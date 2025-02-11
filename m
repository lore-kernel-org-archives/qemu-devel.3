Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01290C0219D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 10:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thnSD-0003kP-UE; Tue, 11 Feb 2025 05:25:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1thnS9-0003hj-Px
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 05:25:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1thnS5-0008Vz-U4
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 05:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739269510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qyefJm0TVUsJ99TDsIqjq7G4P2y31cU0cdeZ6MW4l+4=;
 b=g5YpcP3t/keDFKjI/NS/UCDHD8yLfkXA23xhIpNwQqwKBzL2Pwu2aShQvRfeKIUWUO55Ok
 V+D2zZEz2ERWmql2PICeJEepCAQgsGCly4zaVHdBm7NN/m1qrSJrXw4Cho7FRa8DnvNu7i
 pa5K8M6sQXwWD2GAG26MziNSkCbZpKY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-DwWDA9huN26JJStr0otKlg-1; Tue,
 11 Feb 2025 05:25:09 -0500
X-MC-Unique: DwWDA9huN26JJStr0otKlg-1
X-Mimecast-MFC-AGG-ID: DwWDA9huN26JJStr0otKlg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C50A18004A7
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 10:25:07 +0000 (UTC)
Received: from localhost (unknown [10.44.32.243])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 98FE4195608D; Tue, 11 Feb 2025 10:25:06 +0000 (UTC)
Date: Tue, 11 Feb 2025 11:25:05 +0100
From: Victor Toso <victortoso@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>, Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v3 0/8] qapi-go: add generator for Golang interfaces
Message-ID: <4gwkmv7h3hlkrgayhyrid7xgrk3gxylthrhvea7crfzqojbcgg@5mbpyvqv5zro>
References: <20250110104946.74960-1-victortoso@redhat.com>
 <Z4mBWMqktTPWKaGR@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kbwbkppxmutk3z7a"
Content-Disposition: inline
In-Reply-To: <Z4mBWMqktTPWKaGR@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--kbwbkppxmutk3z7a
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/8] qapi-go: add generator for Golang interfaces
MIME-Version: 1.0

Hi,

On Thu, Jan 16, 2025 at 09:59:52PM +0000, Daniel P. Berrang=E9 wrote:
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

One thing that bothers me a little is using event's fields
directly instead of event type in the interface itself:

    type Events interface {
        StopEvent(time.Time) error
        ContEvent(time.Time) error
        BalloonChangeEvent(int64, time.Time) error
    }

In the gen_server_events.go:

    func (cmds *serverEvents) BalloonChangeEvent(actual int64, when time.Ti=
me) error {
        ev :=3D &BalloonChangeEvent{
            Actual: actual,
        }
        return cmds.QMP.SendEvent("BALLOON_CHANGE", ev, when)
    }

I'm actually in favor of moving the Type itself to the method:

    type Events interface {
        StopEvent(time.Time) error
        ContEvent(time.Time) error
        BalloonChangeEvent(BalloonChangeEvent, time.Time) error
    }

    func (cmds *serverEvents) BalloonChangeEvent(ev BalloonChangeEvent, whe=
n time.Time) error {
        return cmds.QMP.SendEvent("BALLOON_CHANGE", &ev, when)
    }


For the caller it might be an extra step but I see a few
benefits:

    1. Documentation: I'm generating the QAPI documentation of
       the events in its types. IDE's can jump-to-definition and
       see the documentation there. Obviously we could move the
       documentation here or duplicate it but the doc in the Type
       looks the right place imho.
   =20
    2. Changes in the Event fields over time would not impact the
       Breaking the Methods API. While some fields my be
       added/removed/changed, I think this would help break less
       the application when bumping the go module version.


I'm not sure about empty types like StopEvent. I'm generating it
with its doc but as it goes, it is bound to not be used, being
generated just as source of documentation. Still, if it so
happens that it does change in the future, we would need to
extend the Method with its field or its type.

    // Emitted when the virtual machine is stopped
    //
    // Since: 0.12
    //
    // .. qmp-example::    <- { "event": "STOP",      "timestamp": {
    // "seconds": 1267041730, "microseconds": 281295 } }
    type StopEvent struct{}


That also applies for commands..

    // Resume guest VM execution.
    //
    // Since: 0.14
    //
    // .. note:: This command will succeed if the guest is currently
    // running. It will also succeed if the guest is in the "inmigrate"
    // state; in this case, the effect of the command is to make sure
    // the guest starts once migration finishes, removing the effect of
    // the "-S" command line option if it was passed.    If the VM was
    // previously suspended, and not been reset or woken,   this command
    // will transition back to the "suspended" state.   (Since 9.0)  ..
    // qmp-example::    -> { "execute": "cont" }   <- { "return": {} }
    type ContCommand struct {}


I honestly did the requested changes a little while ago but I was
thinking about this and tinkering a little with the demo.

Cheers,
Victor

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
>=20
> Second, it shows a way to build on top of your series, to define a higher
> level API to make interacting with QMP much easier for app developers,
> eliminating all exposure of JSON & marshalling, in favour of formal APIs.
> This doesn't have to be done now, it can be a phase two, as long as we
> have an approximate idea of what the phase two API will look like, so
> we can validate the phase one design against these future plans.
>=20
>=20
> NB What I've not especially considered in any of this is the impact of
> differing QEMU versions & their schema changes. The easy way out is to
> just re-run the generator for each version, putting them in a separate
> Go package. So you can do 'import' of "qapi/qemu/abi920" for 9.2.0
> schema APIs, or "qapi/qemu/910" for 9.1.0 schema APIs. The app dev would
> have to choose which version (or versions) they consume & implement
> against. Splitting versions across the whole package, avoids having to
> consider versioning within parameters of a single command/event.
>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>=20

--kbwbkppxmutk3z7a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmerJYEACgkQl9kSPeN6
SE+QDhAAre3QdYwYUXLFNH6wiLshxhIcddySoKD7nMN+sm1nxaEZ7sbOZnNDRD4u
OkvYUTJIOjbfmuA6earDqm5+tfQMyi+IHdhkkaMmFEtwV4ec9ePh9sd6c01h3838
E853LEEIk103skTvSlm96Ajr5eB4Y8fbNwECx75MBeWhvvNXbQ88XgKPbSHpU/89
Ojih+9U7DE3COVIPCgs+OjgdzZdEnEsOthIaqYnRGPaHKdlNrrZS3YTmmSWc5QpL
v/n+z4MPpCc9vyT6q/s6QBFCJ9OWIhrW5Opa8W4K8QZlg5iwqJSxYAOUdWkQjN9A
AwhvDjoht8kUXqlnfACxOrs5ctg0TPSvPzvPPsaavxmOuMRd8MvN5HTvlLeSu1+V
DW7gL2rO9Z/D8Q1w1D+6VPcozUz7uPTV6yWKfrw9p4eh1tW8Y0CnH9H2FT2KGKxM
lqIBhwoqz3lOs7i8jJuvskUSfSvnL1slcHzREymd3Q/Ol+/69CWFKw/jo++l3wxg
rVadbasfyJjHNcB9e6RkaC/M5ldkS6J4eb36vTqeBIh55sBSs5KAKuHtzkYrVdcA
aELEAk3KVCTuT8OInssYigttxrAIvASJT939iy3E169d5GG6oMbE3J4Axo5+g5Ii
syDKdR9pxJQffjZgjh5SVq4p3gfWEzZDKg9r/iiRdKvIB/LN0fM=
=eeVT
-----END PGP SIGNATURE-----

--kbwbkppxmutk3z7a--


