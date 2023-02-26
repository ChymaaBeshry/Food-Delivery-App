abstract class TicketsStates{}

class InitialTicketState extends TicketsStates{}

class GetLoadingTicketState extends TicketsStates{}
class GetSuccessTicketState extends TicketsStates{}
class GetErrorTicketState extends TicketsStates{}

class AddLoadingTicketState extends TicketsStates{}
class AddSuccessTicketState extends TicketsStates{}
class AddErrorTicketState extends TicketsStates{}

class DeleteLoadingTicketState extends TicketsStates{}
class DeleteSuccessTicketState extends TicketsStates{}
class DeleteErrorTicketState extends TicketsStates{}