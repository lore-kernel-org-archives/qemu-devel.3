Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322ACC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 22:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYXuL-0001Rr-RZ; Thu, 16 Jan 2025 17:00:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYXuI-0001PV-6Z
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 17:00:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYXuF-00029F-J6
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 17:00:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737064802;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=IHOgEB9XYB/eL3ut46BTFI7SvJ+5EaiGZPXZfC2Ber4=;
 b=A7rz3irPelbZzrjrhp9+zXwhkdGknsRL6X4gXXOHbgmqPK1F4OgCP+ypefZtkIj3RdLvW3
 e5w+EqDm4xTshGLGjK48/ABB3s1J+SnMXivd4Ifz0jdX7bQyPanRL2PzmlGV0pRyn0X7NR
 1zCdNVYM9MFOebahabzDHNUBK0UooEo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-M6OXHybCPW-tO_IT6pNRwQ-1; Thu,
 16 Jan 2025 16:59:59 -0500
X-MC-Unique: M6OXHybCPW-tO_IT6pNRwQ-1
X-Mimecast-MFC-AGG-ID: M6OXHybCPW-tO_IT6pNRwQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53A681954196
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:59:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.111])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7CE030001BE; Thu, 16 Jan 2025 21:59:55 +0000 (UTC)
Date: Thu, 16 Jan 2025 21:59:52 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v3 0/8] qapi-go: add generator for Golang interfaces
Message-ID: <Z4mBWMqktTPWKaGR@redhat.com>
References: <20250110104946.74960-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250110104946.74960-1-victortoso@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jan 10, 2025 at 11:49:38AM +0100, Victor Toso wrote:
> I've pushed this series in my gitlab fork:
> https://gitlab.com/victortoso/qapi-go/
> 
> The fork contains some tests, including tests that were generated from
> QAPI's own examples from another generator created for testing, if you
> are interested in it:
> https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg04946.html
> 
> I've generated the qapi-go module over each commit of this series, see:
> https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v3-by-patch
> 
> I've also generated the qapi-go module over QEMU tags: v9.1.0, v9.2.0:
> https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v3-by-tags

Apologies in advance for what will be a long mail.....

I can't recall all the discussions we had on previous versions now, but
I've been having a look at the generated code again, and have thoughts
around the design of the Event / Command types.


I've been wondering how to actually use the generated code to implement
a client and a server API. We previously said such APIs are out of scope
for this series, but at the same time I think they are pretty important
to consider as a way to evaluate the design approach.

Sending messages is easy as you always know what you're sending. The
big design issue is around receiving data off the wire, and the
associated unmarshalling. QMP has several different message types
(command, return, event, error, QMP greeting). When we've read a JSON
JSON doc off the wire, we (usually) have no idea what message type we
are going to unmarshal. Even if we know the message type, we then
might not know the sub-type.

IOW we have a major chicken & egg problem with unmarshalling.

Taking BalloonChangeEvent:

  type BalloonChangeEvent struct {
        MessageTimestamp Timestamp `json:"-"`
        // the logical size of the VM in bytes Formula used:
        // logical_vm_size = vm_ram_size - balloon_size
        Actual int64 `json:"actual"`
  }

which has an UnmarshallJSON method that consumes this whole doc:

    { "event": "BALLOON_CHANGE",
      "data": { "actual": 944766976 },
      "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }

Before we can instantiate a BalloonChangeEvent struct and call its
UnmarshallJSON method, we have to already know we've received an
event and also know the event type is for BalloonChangeEvent.
This means we must have already partially unmarshalled it before
we can unmarshall into BalloonChangeEvent.

IMHO the idea of having UnmarshallJSON methods on the "Event" interface
(and "Command" interface) that consumes a complete message is thus
flawed.


Instead, I believe we need to have a two phase approach to unmarshalling.

For the 1st phase  we need a struct which can unmarshall *any* type of
QMP message, but only 1 level deep. Essentially something like this:

  type Message struct {
	QMP       *json.RawMessage `json:"QMP,omitempty"`
	Execute   string           `json:"execute,omitempty"`
	ExecOOB   string           `json:"exec-oob,omitempty"`
	Event     string           `json:"event,omitempty"`
	Error     *json.RawMessage `json:"error,omitempty"`
	Return    *json.RawMessage `json:"return,omitempty"`
	ID        string           `json:"id,omitempty"`
	Timestamp *Timestamp       `json:"timestamp,omitempty"`
	Data      *json.RawMessage `json:"data,omitempty"`
	Arguments *json.RawMessage `json:"arguments,omitempty"`
  }

Once that Message is unmarshalled, we can examine the 'QMP', 'Execute'
'ExecOOB', 'Event', 'Error' and 'Return' fields, to understand what type
of message we've received.

Then it is possible to identify the right Event or Command or Return
class to use to perform the second level of unmarshalling using the
json.RawMessage data the 1st level of unmarshalling captured.


IOW, if 'Event' is 'BALLOON_CHANGE_EVENT', we know we can use a
BalloonChangeEvent struct to Unmarshall. This struct, however, would
look different to what you've proposed, it would only need to contain
the 'data' fields for the event

    type BalloonChangeEvent struct {
        // the logical size of the VM in bytes Formula used:
        // logical_vm_size = vm_ram_size - balloon_size
        Actual int64 `json:"actual"`
    }

This would also mean there is no need to provide any UnmarshallJSON
or MarshallJSON methods at all on the BalloonChangeEvent, as the json
marshall code can work exclusively from the field annotations.

The same thoughts above apply to the command / return structs. I don't
think any of them need to have UnmarshallJSON/MarshallJSON methods.



    <<<< Pause here if you've read enough for now. >>>>



As a way to validate these thoughts, I spent a day to mock up a demo
of a QAPI client and server implementation.

First I created some manually written structs for the core QMP types

  https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/protocol.go

Then I've got (what would be) generated code creating types for the
specific QAPI schema. I've just illustrated this with query-machines
and qmp_capabilities commands, and STOP, CONT, BALLOON_CHANGE events:

  https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/gen_types.go

Essentially this is all the types you generated, but without any of
the (un)marshalling method impls which IMHO are all redundant. I put
everything in one file just for convenience, your per-file split makes
more sense in a real impl.


IMHO that's all that's needed to cover the scope of what is done in
this series, but to illustrate a real world usage model, I've then
gone on to implement both clients and servers.

At the very lowest level, both clients & servers need a way to send
and recv "Message" instances, so I created a "Channel" object with
SendMessage/RecvMessage methods:

  https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/channel.go

This is the most basic low level client one could have for QMP



From that we can derive a object for QMP Clients, giving slightly higher
level APIs to send commands, receive replies & events, avoiding the need
to touch the "Message" object directly:

  https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/client.go

And derive a similar object for QMP severs, giving APIs to dispatch commands,
and send replies, events & errors:

  https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/server.go

So far this is all static written code common to any QAPI schema impl.
The APIs can be used with any schema specific structs, however, the
latter might be defined.


Being low level, none of these APIs are strongly typed, which is not nice
as an application API in Go, so need a way to introduce better type safety.


In a real application I don't think developers should really be touching
the structs directly for commands/responses/events. Instead I believe
they need to be given formal APIs:

Thus I have (what would be) auto-generated interfaces for covering all
the commands and events:

  https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/gen_commands.go
  https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/gen_events.go

these interfaces are applicable to both clients and servers, just needing
different private implementations.

On the client side the implementations of these interfaces:

  https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/gen_client_sync.go
  https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/gen_client_async.go
  https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/gen_client_events.go

And on the server side the implementations of these interfaces

  https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/gen_server.go
  https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/gen_server_events.go


Finally we can consider what an implementation of a client looks like

  https://gitlab.com/berrange/qapi-go-demo/-/blob/main/cmd/sync-client/main.go
  https://gitlab.com/berrange/qapi-go-demo/-/blob/main/cmd/async-client/main.go

And what an implementation of a server looks like

  https://gitlab.com/berrange/qapi-go-demo/-/blob/main/cmd/server/main.go

The key observation at the end is that the client/server impls are all
using strongly typed APIs and don't have to concern themselves with JSON
at all.

The two demo clients should work with an real QEMU or the demo server.
The demo server won't work with qmp-shell, because I blindly assumed
each JSON message had a terminating newlinue for ease of impl and this
isn't compatible with qmp-shell. Solvable but I couldn't be bothered
for this demoware.


So what does this all mean wrt your series ? Not that much, probably
just a little code deletion and some small tweaks.


First, it illustrates that the approach taken for the Command / Event
interfaces & the corresponding UnmarshallJSON/MarshallJSON methods is
redundant code. Aside from that, I think everything else in your series
around generating the basic types is essentially good.

Second, it shows a way to build on top of your series, to define a higher
level API to make interacting with QMP much easier for app developers,
eliminating all exposure of JSON & marshalling, in favour of formal APIs.
This doesn't have to be done now, it can be a phase two, as long as we
have an approximate idea of what the phase two API will look like, so
we can validate the phase one design against these future plans.


NB What I've not especially considered in any of this is the impact of
differing QEMU versions & their schema changes. The easy way out is to
just re-run the generator for each version, putting them in a separate
Go package. So you can do 'import' of "qapi/qemu/abi920" for 9.2.0
schema APIs, or "qapi/qemu/910" for 9.1.0 schema APIs. The app dev would
have to choose which version (or versions) they consume & implement
against. Splitting versions across the whole package, avoids having to
consider versioning within parameters of a single command/event.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


