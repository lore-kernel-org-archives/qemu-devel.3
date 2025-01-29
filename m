Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65956C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 19:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdE7l-00076n-8N; Wed, 29 Jan 2025 14:53:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tdE7g-00076V-0H
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 14:53:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tdE7c-0005YB-3B
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 14:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738180386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R3sQ9oAvy7SKq5tBgXCii/Z5fT/mnJucxUIKmyzAdUc=;
 b=Qm+81bM47unvPjWffPcuIhEJhOICGAn5eoAqbeQoxrahCOscY6MqnLYBqzLWged1Z76nJK
 N3knugi+t5LwDp6G+HdFffklZ86CiF6E/8EZCMHSOPzKHBttOASsPJ9A+i0/06E0iBSar0
 uwIXHWnN+b5PIzuUIkPO1ERATFTxSns=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-nEfGqcjOOlu9KQznHUOmGw-1; Wed,
 29 Jan 2025 14:53:04 -0500
X-MC-Unique: nEfGqcjOOlu9KQznHUOmGw-1
X-Mimecast-MFC-AGG-ID: nEfGqcjOOlu9KQznHUOmGw
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2250519560AB
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 19:53:04 +0000 (UTC)
Received: from localhost (unknown [10.45.224.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 02C181800268; Wed, 29 Jan 2025 19:53:02 +0000 (UTC)
Date: Wed, 29 Jan 2025 20:53:01 +0100
From: Victor Toso <victortoso@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>, Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v3 0/8] qapi-go: add generator for Golang interfaces
Message-ID: <qksovrxuaf76op4fdadn6xbd32njcndgj2vfp73mpn5efi327b@jf5ot3jznmui>
References: <20250110104946.74960-1-victortoso@redhat.com>
 <Z4mBWMqktTPWKaGR@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="x62rdbw76owc2zm4"
Content-Disposition: inline
In-Reply-To: <Z4mBWMqktTPWKaGR@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--x62rdbw76owc2zm4
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/8] qapi-go: add generator for Golang interfaces
MIME-Version: 1.0

Hi,

On Thu, Jan 16, 2025 at 09:59:52PM +0000, Daniel P. Berrang=E9 wrote:
> On Fri, Jan 10, 2025 at 11:49:38AM +0100, Victor Toso wrote:
> > I've pushed this series in my gitlab fork:
> > https://gitlab.com/victortoso/qapi-go/
> >=20
> > The fork contains some tests, including tests that were generated from
> > QAPI's own examples from another generator created for testing, if you
> > are interested in it:
> > https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg04946.html
> >=20
> > I've generated the qapi-go module over each commit of this series, see:
> > https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v3-by-patch
> >=20
> > I've also generated the qapi-go module over QEMU tags: v9.1.0, v9.2.0:
> > https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v3-by-tags
>=20
> Apologies in advance for what will be a long mail.....
>=20
> I can't recall all the discussions we had on previous versions now, but
> I've been having a look at the generated code again, and have thoughts
> around the design of the Event / Command types.
>=20
>=20
> I've been wondering how to actually use the generated code to implement
> a client and a server API. We previously said such APIs are out of scope
> for this series, but at the same time I think they are pretty important
> to consider as a way to evaluate the design approach.
>=20
> Sending messages is easy as you always know what you're sending. The
> big design issue is around receiving data off the wire, and the
> associated unmarshalling. QMP has several different message types
> (command, return, event, error, QMP greeting). When we've read a JSON
> JSON doc off the wire, we (usually) have no idea what message type we
> are going to unmarshal. Even if we know the message type, we then
> might not know the sub-type.
>=20
> IOW we have a major chicken & egg problem with unmarshalling.
>=20
> Taking BalloonChangeEvent:
>=20
>   type BalloonChangeEvent struct {
>         MessageTimestamp Timestamp `json:"-"`
>         // the logical size of the VM in bytes Formula used:
>         // logical_vm_size =3D vm_ram_size - balloon_size
>         Actual int64 `json:"actual"`
>   }
>=20
> which has an UnmarshallJSON method that consumes this whole doc:
>=20
>     { "event": "BALLOON_CHANGE",
>       "data": { "actual": 944766976 },
>       "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
>=20
> Before we can instantiate a BalloonChangeEvent struct and call its
> UnmarshallJSON method, we have to already know we've received an
> event and also know the event type is for BalloonChangeEvent.
> This means we must have already partially unmarshalled it before
> we can unmarshall into BalloonChangeEvent.
>=20
> IMHO the idea of having UnmarshallJSON methods on the "Event" interface
> (and "Command" interface) that consumes a complete message is thus
> flawed.
>=20
>=20
> Instead, I believe we need to have a two phase approach to unmarshalling.
>=20
> For the 1st phase  we need a struct which can unmarshall *any* type of
> QMP message, but only 1 level deep. Essentially something like this:
>=20
>   type Message struct {
> 	QMP       *json.RawMessage `json:"QMP,omitempty"`
> 	Execute   string           `json:"execute,omitempty"`
> 	ExecOOB   string           `json:"exec-oob,omitempty"`
> 	Event     string           `json:"event,omitempty"`
> 	Error     *json.RawMessage `json:"error,omitempty"`
> 	Return    *json.RawMessage `json:"return,omitempty"`
> 	ID        string           `json:"id,omitempty"`
> 	Timestamp *Timestamp       `json:"timestamp,omitempty"`
> 	Data      *json.RawMessage `json:"data,omitempty"`
> 	Arguments *json.RawMessage `json:"arguments,omitempty"`
>   }

/* Note to self, should have probably tested 'exec-oob' */
=20
> Once that Message is unmarshalled, we can examine the 'QMP', 'Execute'
> 'ExecOOB', 'Event', 'Error' and 'Return' fields, to understand what type
> of message we've received.
>=20
> Then it is possible to identify the right Event or Command or Return
> class to use to perform the second level of unmarshalling using the
> json.RawMessage data the 1st level of unmarshalling captured.
>=20
>=20
> IOW, if 'Event' is 'BALLOON_CHANGE_EVENT', we know we can use a
> BalloonChangeEvent struct to Unmarshall. This struct, however, would
> look different to what you've proposed, it would only need to contain
> the 'data' fields for the event
>=20
>     type BalloonChangeEvent struct {
>         // the logical size of the VM in bytes Formula used:
>         // logical_vm_size =3D vm_ram_size - balloon_size
>         Actual int64 `json:"actual"`
>     }
>=20
> This would also mean there is no need to provide any UnmarshallJSON
> or MarshallJSON methods at all on the BalloonChangeEvent, as the json
> marshall code can work exclusively from the field annotations.
>=20
> The same thoughts above apply to the command / return structs. I don't
> think any of them need to have UnmarshallJSON/MarshallJSON methods.
>=20
>=20
>=20
>     <<<< Pause here if you've read enough for now. >>>>
>=20
>=20
>=20
> As a way to validate these thoughts, I spent a day to mock up a demo
> of a QAPI client and server implementation.
>=20
> First I created some manually written structs for the core QMP types
>=20
>   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/protocol.=
go
>=20
> Then I've got (what would be) generated code creating types for the
> specific QAPI schema. I've just illustrated this with query-machines
> and qmp_capabilities commands, and STOP, CONT, BALLOON_CHANGE events:
>=20
>   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/gen_types=
=2Ego
>=20
> Essentially this is all the types you generated, but without any of
> the (un)marshalling method impls which IMHO are all redundant. I put
> everything in one file just for convenience, your per-file split makes
> more sense in a real impl.
>=20
>=20
> IMHO that's all that's needed to cover the scope of what is done in
> this series, but to illustrate a real world usage model, I've then
> gone on to implement both clients and servers.
>=20
> At the very lowest level, both clients & servers need a way to send
> and recv "Message" instances, so I created a "Channel" object with
> SendMessage/RecvMessage methods:
>=20
>   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/channel.go
>=20
> This is the most basic low level client one could have for QMP
>=20
>=20
>=20
> From that we can derive a object for QMP Clients, giving slightly higher
> level APIs to send commands, receive replies & events, avoiding the need
> to touch the "Message" object directly:
>=20
>   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/client.go
>=20
> And derive a similar object for QMP severs, giving APIs to dispatch comma=
nds,
> and send replies, events & errors:
>=20
>   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/server.go
>=20
> So far this is all static written code common to any QAPI schema impl.
> The APIs can be used with any schema specific structs, however, the
> latter might be defined.
>=20
>=20
> Being low level, none of these APIs are strongly typed, which is not nice
> as an application API in Go, so need a way to introduce better type safet=
y.
>=20
>=20
> In a real application I don't think developers should really be touching
> the structs directly for commands/responses/events. Instead I believe
> they need to be given formal APIs:
>=20
> Thus I have (what would be) auto-generated interfaces for covering all
> the commands and events:
>=20
>   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/gen_comma=
nds.go
>   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/gen_event=
s.go
>=20
> these interfaces are applicable to both clients and servers, just needing
> different private implementations.
>=20
> On the client side the implementations of these interfaces:
>=20
>   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/gen_clien=
t_sync.go
>   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/gen_clien=
t_async.go
>   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/gen_clien=
t_events.go
>=20
> And on the server side the implementations of these interfaces
>=20
>   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/gen_serve=
r.go
>   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/gen_serve=
r_events.go
>=20
>=20
> Finally we can consider what an implementation of a client looks like
>=20
>   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/cmd/sync-client/ma=
in.go
>   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/cmd/async-client/m=
ain.go
>=20
> And what an implementation of a server looks like
>=20
>   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/cmd/server/main.go
>=20
> The key observation at the end is that the client/server impls are all
> using strongly typed APIs and don't have to concern themselves with JSON
> at all.
>=20
> The two demo clients should work with an real QEMU or the demo server.
> The demo server won't work with qmp-shell, because I blindly assumed
> each JSON message had a terminating newlinue for ease of impl and this
> isn't compatible with qmp-shell. Solvable but I couldn't be bothered
> for this demoware.
>=20
>=20
> So what does this all mean wrt your series ? Not that much, probably
> just a little code deletion and some small tweaks.
>=20
>=20
> First, it illustrates that the approach taken for the Command / Event
> interfaces & the corresponding UnmarshallJSON/MarshallJSON methods is
> redundant code. Aside from that, I think everything else in your series
> around generating the basic types is essentially good.

Alright. The addition of Marshallers was done in the last
interaction. Before, I had the following for command and similar
to event:

    func MarshalCommand(c Command) ([]byte, error)=20
    func UnmarshalCommand(data []byte) (Command, error)

Each of this series iterations had a more or less a different
idea of how the consumer of this generated code would use it, but
without a proper PoC on top, like you've done here and thanks for
that.

I'm happy with the suggestions and I'll incorporate them.
=20
> Second, it shows a way to build on top of your series, to define a higher
> level API to make interacting with QMP much easier for app developers,
> eliminating all exposure of JSON & marshalling, in favour of formal APIs.
> This doesn't have to be done now, it can be a phase two, as long as we
> have an approximate idea of what the phase two API will look like, so
> we can validate the phase one design against these future plans.

Just want to put emphasis that the module that we will maintain
would still be considered alpha/unstable until we get the library
in a state we agree is good.

> NB What I've not especially considered in any of this is the impact of
> differing QEMU versions & their schema changes. The easy way out is to
> just re-run the generator for each version, putting them in a separate
> Go package. So you can do 'import' of "qapi/qemu/abi920" for 9.2.0
> schema APIs, or "qapi/qemu/910" for 9.1.0 schema APIs.

Yeah, plus what Markus said. Choosing qapi/qemu/900 should stay
working as long as QMP would guarantee (end of grace period of a
breaking change).

I'd consider sane Applications to bump the go module when they
bump the minimum required QEMU version for their supported use
case, to be able to handle new events and changes.

> The app dev would have to choose which version (or versions)
> they consume & implement against. Splitting versions across the
> whole package, avoids having to consider versioning within
> parameters of a single command/event.

Thanks again,
Victor

--x62rdbw76owc2zm4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmeahxwACgkQl9kSPeN6
SE+qXw//Rp5zU/+fV6x8QN8CjOWVvJH572HiDNu1mGBaXq8TyWAIsqW/+FzUQzA8
5Hj/OZ1p4q5qx/vJzwBZjnZRK1gjSx9kvpoKvzzMXlBFnlzdJgIEPM98xDV+x5Rp
6Xicj+0hfQi6iSQj3By1/B3JwlBb+OmcNedchigSRqw8Z8xxGDmtyahZpwwWClij
Bjo+64x2tgZM+xlDm5wUteB0uvJWQEPxsICcPb380AR+dHEsTgtfBE/610q6zuTg
bJy8yt2eqKKcXz58aRCX/svUDCbBKJ5NJSWU2H5pJgUP+BUUSyMYzGSzT5fEagAS
/oTIwMGtFALKJcNU/l7REvjCpA1N/s2R13A125XCwCjs+L7VrQvSwzX1Szi27eQI
WCH///6CFz2yiDgADuE4omnXmk59nTc1UtmmFa6l0V/2pwm3P+/BgVC2UiQ71lj6
9t+ak20rXx/g4zvvuYyM7FKB6c54bfDiwxdw9MNRcC9ifgVd/n4gox9PqP3ocKKL
b1oqB1/knmSwz4vfSmZCHJUkmSddcyUglLWSlnCgUw9hPYu4AOToU8ccIKUnVy1l
BzeONAeiDZMJEkr8DwLxaNd/Uu2Wr7HYZrLKJn/a22KaVGh4d6c0ulO4R/e1HOqv
T8q+NhG25Y9QqcRdb/2N9fqUAE5QG01nOiPTTfsRx3dlcI3w7i0=
=uPR1
-----END PGP SIGNATURE-----

--x62rdbw76owc2zm4--


