Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79CDC0219D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 12:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thp3y-0006YF-Il; Tue, 11 Feb 2025 07:08:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1thp3u-0006Xk-Sl
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 07:08:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1thp3q-0007T7-8L
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 07:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739275695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lJeiS94LhsXhwqemS2Hc86Gdy72isKD/jYKc6luEDEI=;
 b=NeFFJui1Nv/c8ErHpdHZWmlNnaOiwDkTZ/9UJqtw5XCi7cWtCjcVlraCjZpcBLyLt/UAVL
 k8tk8SV2PKH1bquRCGfr5KIL/ZUdiwhMJaWYb5xsWxtuRODW6FzaHJhb0k1KA0AmjpBiRM
 BVRz5Q0ivbraEWDIfOnXtd+MOa0qB1g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-NxOy1M1JMaeYNTMlQLvMXw-1; Tue,
 11 Feb 2025 07:08:13 -0500
X-MC-Unique: NxOy1M1JMaeYNTMlQLvMXw-1
X-Mimecast-MFC-AGG-ID: NxOy1M1JMaeYNTMlQLvMXw_1739275692
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7328B19560AA
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 12:08:12 +0000 (UTC)
Received: from localhost (unknown [10.44.32.243])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CF5031956094; Tue, 11 Feb 2025 12:08:11 +0000 (UTC)
Date: Tue, 11 Feb 2025 13:08:10 +0100
From: Victor Toso <victortoso@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>, Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v3 0/8] qapi-go: add generator for Golang interfaces
Message-ID: <6u57us5czzafm7tkmtr2ow3i7gnwmeibgbuooomhyznkt5u25z@l6hlz43hzgoi>
References: <20250110104946.74960-1-victortoso@redhat.com>
 <Z4mBWMqktTPWKaGR@redhat.com>
 <4gwkmv7h3hlkrgayhyrid7xgrk3gxylthrhvea7crfzqojbcgg@5mbpyvqv5zro>
 <Z6swLZ3csrf-3JH2@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mj2u2vwrerw2gaqp"
Content-Disposition: inline
In-Reply-To: <Z6swLZ3csrf-3JH2@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


--mj2u2vwrerw2gaqp
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/8] qapi-go: add generator for Golang interfaces
MIME-Version: 1.0

Hi,

On Tue, Feb 11, 2025 at 11:10:37AM +0000, Daniel P. Berrang=E9 wrote:
> On Tue, Feb 11, 2025 at 11:25:05AM +0100, Victor Toso wrote:
> > Hi,
> >=20
> > On Thu, Jan 16, 2025 at 09:59:52PM +0000, Daniel P. Berrang=E9 wrote:
> > >     <<<< Pause here if you've read enough for now. >>>>
> > >=20
> > >=20
> > >=20
> > > As a way to validate these thoughts, I spent a day to mock up a demo
> > > of a QAPI client and server implementation.
> > >=20
> > > First I created some manually written structs for the core QMP types
> > >=20
> > >   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/proto=
col.go
> > >=20
> > > Then I've got (what would be) generated code creating types for the
> > > specific QAPI schema. I've just illustrated this with query-machines
> > > and qmp_capabilities commands, and STOP, CONT, BALLOON_CHANGE events:
> > >=20
> > >   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/gen_t=
ypes.go
> > >=20
> > > Essentially this is all the types you generated, but without any of
> > > the (un)marshalling method impls which IMHO are all redundant. I put
> > > everything in one file just for convenience, your per-file split makes
> > > more sense in a real impl.
> > >=20
> > >=20
> > > IMHO that's all that's needed to cover the scope of what is done in
> > > this series, but to illustrate a real world usage model, I've then
> > > gone on to implement both clients and servers.
> > >=20
> > > At the very lowest level, both clients & servers need a way to send
> > > and recv "Message" instances, so I created a "Channel" object with
> > > SendMessage/RecvMessage methods:
> > >=20
> > >   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/chann=
el.go
> > >=20
> > > This is the most basic low level client one could have for QMP
> > >=20
> > >=20
> > >=20
> > > From that we can derive a object for QMP Clients, giving slightly hig=
her
> > > level APIs to send commands, receive replies & events, avoiding the n=
eed
> > > to touch the "Message" object directly:
> > >=20
> > >   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/clien=
t.go
> > >=20
> > > And derive a similar object for QMP severs, giving APIs to dispatch c=
ommands,
> > > and send replies, events & errors:
> > >=20
> > >   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/serve=
r.go
> > >=20
> > > So far this is all static written code common to any QAPI schema impl.
> > > The APIs can be used with any schema specific structs, however, the
> > > latter might be defined.
> > >=20
> > >=20
> > > Being low level, none of these APIs are strongly typed, which is not =
nice
> > > as an application API in Go, so need a way to introduce better type s=
afety.
> > >=20
> > >=20
> > > In a real application I don't think developers should really be touch=
ing
> > > the structs directly for commands/responses/events. Instead I believe
> > > they need to be given formal APIs:
> > >=20
> > > Thus I have (what would be) auto-generated interfaces for covering all
> > > the commands and events:
> > >=20
> > >   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/gen_c=
ommands.go
> > >   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/gen_e=
vents.go
> >=20
> > One thing that bothers me a little is using event's fields
> > directly instead of event type in the interface itself:
> >=20
> >     type Events interface {
> >         StopEvent(time.Time) error
> >         ContEvent(time.Time) error
> >         BalloonChangeEvent(int64, time.Time) error
> >     }
> >=20
> > In the gen_server_events.go:
> >=20
> >     func (cmds *serverEvents) BalloonChangeEvent(actual int64, when tim=
e.Time) error {
> >         ev :=3D &BalloonChangeEvent{
> >             Actual: actual,
> >         }
> >         return cmds.QMP.SendEvent("BALLOON_CHANGE", ev, when)
> >     }
> >=20
> > I'm actually in favor of moving the Type itself to the method:
> >=20
> >     type Events interface {
> >         StopEvent(time.Time) error
> >         ContEvent(time.Time) error
> >         BalloonChangeEvent(BalloonChangeEvent, time.Time) error
> >     }
> >=20
> >     func (cmds *serverEvents) BalloonChangeEvent(ev BalloonChangeEvent,=
 when time.Time) error {
> >         return cmds.QMP.SendEvent("BALLOON_CHANGE", &ev, when)
> >     }
>=20
> I choose to expand all the types inline in events & commands
> because I felt like this gives a more convenient API design
> for applications, without the extra indirectino of packing
> and unpacking parameters

Sure, just a choice to be made.

> > For the caller it might be an extra step but I see a few
> > benefits:
> >=20
> >     1. Documentation: I'm generating the QAPI documentation of
> >        the events in its types. IDE's can jump-to-definition and
> >        see the documentation there. Obviously we could move the
> >        documentation here or duplicate it but the doc in the Type
> >        looks the right place imho.
>=20
> Yep, it would complicate docs to have to unpack it against the
> method. I was coming at this from the POV of an application
> developer though, intentionally ignoring what is the most
> convenient for the code generator. The latter is fixed cost
> while writing the generator, while the API design is an ongoing
> cost time, so makes more sense to optimize for the latter.

Right. I don't mind doing the work to inline it, but I'm not sure
it is best. Inline commands/events that don't have fields are
straight forward and look nice but what when they have several
fields instead?

Wrt to mandatory and optional fields, I think it is
straightforward when looking at the struct definition that might
be confusing to the methods args.

As example, block-stream command has 12 fields, only 1 mandatory.

    // .. qmp-example::    -> { "execute": "block-stream",
    // "arguments": { "device": "virtio0",             "base":
    // "/tmp/master.qcow2" } }   <- { "return": {} }
    type BlockStreamCommand struct {
        // identifier for the newly-created block job. If omitted, the
        // device name will be used. (Since 2.7)
        JobId *string `json:"job-id,omitempty"`
        // the device or node name of the top image
        Device string `json:"device"`
        // the common backing file name. It cannot be set if @base-node or
        // @bottom is also set.
        Base *string `json:"base,omitempty"`
        // the node name of the backing file. It cannot be set if @base or
        // @bottom is also set. (Since 2.8)
        BaseNode *string `json:"base-node,omitempty"`
        // The backing file string to write into the top image. This
        // filename is not validated. If a pathname string is such that it
        // cannot be resolved by QEMU, that means that subsequent QMP or
        // HMP commands must use node-names for the image in question, as
        // filename lookup methods will fail. If not specified, QEMU will
        // automatically determine the backing file string to use, or
        // error out if there is no obvious choice. Care should be taken
        // when specifying the string, to specify a valid filename or
        // protocol. (Since 2.1)
        BackingFile *string `json:"backing-file,omitempty"`
        // If true, replace any protocol mentioned in the 'backing file
        // format' with 'raw', rather than storing the protocol name as
        // the backing format. Can be used even when no image header will
        // be updated (default false; since 9.0).
        BackingMaskProtocol *bool `json:"backing-mask-protocol,omitempty"`
        // the last node in the chain that should be streamed into top. It
        // cannot be set if @base or @base-node is also set. It cannot be
        // filter node. (Since 6.0)
        Bottom *string `json:"bottom,omitempty"`
        // the maximum speed, in bytes per second
        Speed *int64 `json:"speed,omitempty"`
        // the action to take on an error (default report). 'stop' and
        // 'enospc' can only be used if the block device supports io-
        // status (see BlockInfo). (Since 1.3)
        OnError *BlockdevOnError `json:"on-error,omitempty"`
        // the node name that should be assigned to the filter driver that
        // the stream job inserts into the graph above @device. If this
        // option is not given, a node name is autogenerated. (Since: 6.0)
        FilterNodeName *string `json:"filter-node-name,omitempty"`
        // When false, this job will wait in a PENDING state after it has
        // finished its work, waiting for @block-job-finalize before
        // making any block graph changes. When true, this job will
        // automatically perform its abort or commit actions. Defaults to
        // true. (Since 3.1)
        AutoFinalize *bool `json:"auto-finalize,omitempty"`
        // When false, this job will wait in a CONCLUDED state after it
        // has completely ceased all work, and awaits @block-job-dismiss.
        // When true, this job will automatically disappear from the query
        // list without user intervention. Defaults to true. (Since 3.1)
        AutoDismiss *bool `json:"auto-dismiss,omitempty"`
    }

Might be easier in that case to

    cmds.BlockStream(BlockStreamCommand{device:"virtio"})

instead of defining all optional args as nil.

=20
> >     2. Changes in the Event fields over time would not impact the
> >        Breaking the Methods API. While some fields my be
> >        added/removed/changed, I think this would help break less
> >        the application when bumping the go module version.
>=20
> Yep, hiding everything behind a struct can reduce breakage.
>=20
> The tricky (impossible) question is how beneficial it is in
> the real world usage ?

To me it was just an extra benefit, not a vital one. We are bound
to break when user bumps it. In the real world, as far as I
recall from discussing this with Markus (feel free to correct me)

    i.  Removing fields is somewhat rare. I remember he put out
        an example but I could not find it.
    ii. Adding fields is not so rare although they are usually
        optional.
=20
With inlining approach we would break application in both cases
100% of the time. It'd be less so by using a type.

> As guidance, taking protobuf as a commonly used package though,
> if I look at Kubevirt's protobuf generated APIs:
>=20
>   https://github.com/kubevirt/kubevirt/blob/main/pkg/handler-launcher-com=
/cmd/v1/cmd.pb.go#L1237
>=20
> I can see they're using structs for parameters and return
> values. So that widely used prior art, suggests we go the
> way you outline and use structs.

Oh, but if I'm not mistaken, if you do change the type you are
required to bump the version meaning that you'll need to
generated a new set of types with the new version. That enforces
client/side to implement the new type if they want to talk over
new version (enforced by capabilites negotiation). Not a great
dev experience but it surely works and performance is good too...
but I digress.
=20
> > I'm not sure about empty types like StopEvent. I'm generating it
> > with its doc but as it goes, it is bound to not be used, being
> > generated just as source of documentation. Still, if it so
> > happens that it does change in the future, we would need to
> > extend the Method with its field or its type.
> >=20
> >     // Emitted when the virtual machine is stopped
> >     //
> >     // Since: 0.12
> >     //
> >     // .. qmp-example::    <- { "event": "STOP",      "timestamp": {
> >     // "seconds": 1267041730, "microseconds": 281295 } }
> >     type StopEvent struct{}
>=20
> Yes, if the goal of using structs is to reduce breakage when
> fields are added/removed, then IMHO the logical conclusion
> is that empty structs must be generated.

imho, just a extra benefit. Breaking is somewhat fine if it
happens only when we bump the version and is not something that
happens so often that it becomes a bother.
=20
> > That also applies for commands..
> >=20
> >     // Resume guest VM execution.
> >     //
> >     // Since: 0.14
> >     //
> >     // .. note:: This command will succeed if the guest is currently
> >     // running. It will also succeed if the guest is in the "inmigrate"
> >     // state; in this case, the effect of the command is to make sure
> >     // the guest starts once migration finishes, removing the effect of
> >     // the "-S" command line option if it was passed.    If the VM was
> >     // previously suspended, and not been reset or woken,   this command
> >     // will transition back to the "suspended" state.   (Since 9.0)  ..
> >     // qmp-example::    -> { "execute": "cont" }   <- { "return": {} }
> >     type ContCommand struct {}
> >=20
> >=20
> > I honestly did the requested changes a little while ago but I was
> > thinking about this and tinkering a little with the demo.
>=20
> With regards,
> Daniel

Thanks for the quick replies,
Victor

--mj2u2vwrerw2gaqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmerPaoACgkQl9kSPeN6
SE8eCg//c6mexHQPrEwJHsJsv916SOHGWToS6o970S2TKhm6GMiwDMqdl0bb3zEj
RvtUgi3ocxT3N/taMNZrRNyRZhKfc00JXxMTmVYqWTqDLnJCZhDBTNRCF1KdCEGJ
uhj1qSn6OXZdxQzJIdXpy+gQDYTHa22Cc344QRvFsypPqzbdVYeOvKk9ON3lzXKF
2veznuYGl6i6qi2Amc52TR3DqPwADv7jaL7cXfe6hQ+Y3TudM9omsriS2UmEmaPi
2VSEJ8bzd+F61X7ogaOJFgKr4JAugaA9nDWbN8ZGi0A8CoH/Qr5RBI9df6INXsKu
BmLTBgv8HSbTQwCTLvMpdQackVpk+EdyH99+DhD91uIE4HrRXR3j31BPFDKJxrDt
T56Lykn0zDH9bLPuMCLHfL2CXTjA6qxB1uxHxbclzlHzY3tDZJd+bagzo92CJSO3
Zp1nbI4TmwBFrMXQlqonT1qo/6UbUetZrv3mSn3O32g9ESEAa2vkWrc8P+VEHcO0
Wd9FnnN/qoEGSS+3Ui/PgRRLBQ9aEm1Uki9H4Wnxs97U4VabKvCxUdEpgUqNqaI3
V1zcIWFYwlFpOTpWHxZ+poPAYTeBbaGFt1BInt0IJaHF51GiCuKtFWRmLUD1Hl+9
HDCByKgnad8A31icrSz1ZvXf1XjZGWBSyjYbHRLP/gJlwQnoL2w=
=9ziM
-----END PGP SIGNATURE-----

--mj2u2vwrerw2gaqp--


