Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0F0C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 11:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thoAP-0002mh-MM; Tue, 11 Feb 2025 06:11:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1thoAK-0002mH-AS
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 06:10:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1thoAH-00086e-QJ
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 06:10:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739272249;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aHMr+S/qEyJxIoQ3GZWM/ZtsNaf2tLt/uoktCMQgchk=;
 b=JlDpc2L2XYfh1DVSHwFDQCczCRowQEvhxtZ6rI29BjBGNiQJy23C+XTUM/ez8FtSUM0eu4
 UCU22PExXGXOvu4hppdYUxnby7RGJtr1amImOhyykyBChtGu8NUZ0Oz+Dz3AxKHnzEaURU
 sikhuYohaNbUVfj4YmWrhErUUUqk7NA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-ijbelHaOPWuywII7Zskb0Q-1; Tue,
 11 Feb 2025 06:10:43 -0500
X-MC-Unique: ijbelHaOPWuywII7Zskb0Q-1
X-Mimecast-MFC-AGG-ID: ijbelHaOPWuywII7Zskb0Q
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 061AC1800875
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 11:10:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.132])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70B861800358; Tue, 11 Feb 2025 11:10:40 +0000 (UTC)
Date: Tue, 11 Feb 2025 11:10:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v3 0/8] qapi-go: add generator for Golang interfaces
Message-ID: <Z6swLZ3csrf-3JH2@redhat.com>
References: <20250110104946.74960-1-victortoso@redhat.com>
 <Z4mBWMqktTPWKaGR@redhat.com>
 <4gwkmv7h3hlkrgayhyrid7xgrk3gxylthrhvea7crfzqojbcgg@5mbpyvqv5zro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4gwkmv7h3hlkrgayhyrid7xgrk3gxylthrhvea7crfzqojbcgg@5mbpyvqv5zro>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 11, 2025 at 11:25:05AM +0100, Victor Toso wrote:
> Hi,
> 
> On Thu, Jan 16, 2025 at 09:59:52PM +0000, Daniel P. Berrangé wrote:
> >     <<<< Pause here if you've read enough for now. >>>>
> > 
> > 
> > 
> > As a way to validate these thoughts, I spent a day to mock up a demo
> > of a QAPI client and server implementation.
> > 
> > First I created some manually written structs for the core QMP types
> > 
> >   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/protocol.go
> > 
> > Then I've got (what would be) generated code creating types for the
> > specific QAPI schema. I've just illustrated this with query-machines
> > and qmp_capabilities commands, and STOP, CONT, BALLOON_CHANGE events:
> > 
> >   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/gen_types.go
> > 
> > Essentially this is all the types you generated, but without any of
> > the (un)marshalling method impls which IMHO are all redundant. I put
> > everything in one file just for convenience, your per-file split makes
> > more sense in a real impl.
> > 
> > 
> > IMHO that's all that's needed to cover the scope of what is done in
> > this series, but to illustrate a real world usage model, I've then
> > gone on to implement both clients and servers.
> > 
> > At the very lowest level, both clients & servers need a way to send
> > and recv "Message" instances, so I created a "Channel" object with
> > SendMessage/RecvMessage methods:
> > 
> >   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/channel.go
> > 
> > This is the most basic low level client one could have for QMP
> > 
> > 
> > 
> > From that we can derive a object for QMP Clients, giving slightly higher
> > level APIs to send commands, receive replies & events, avoiding the need
> > to touch the "Message" object directly:
> > 
> >   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/client.go
> > 
> > And derive a similar object for QMP severs, giving APIs to dispatch commands,
> > and send replies, events & errors:
> > 
> >   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/server.go
> > 
> > So far this is all static written code common to any QAPI schema impl.
> > The APIs can be used with any schema specific structs, however, the
> > latter might be defined.
> > 
> > 
> > Being low level, none of these APIs are strongly typed, which is not nice
> > as an application API in Go, so need a way to introduce better type safety.
> > 
> > 
> > In a real application I don't think developers should really be touching
> > the structs directly for commands/responses/events. Instead I believe
> > they need to be given formal APIs:
> > 
> > Thus I have (what would be) auto-generated interfaces for covering all
> > the commands and events:
> > 
> >   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/gen_commands.go
> >   https://gitlab.com/berrange/qapi-go-demo/-/blob/main/pkg/qapi/gen_events.go
> 
> One thing that bothers me a little is using event's fields
> directly instead of event type in the interface itself:
> 
>     type Events interface {
>         StopEvent(time.Time) error
>         ContEvent(time.Time) error
>         BalloonChangeEvent(int64, time.Time) error
>     }
> 
> In the gen_server_events.go:
> 
>     func (cmds *serverEvents) BalloonChangeEvent(actual int64, when time.Time) error {
>         ev := &BalloonChangeEvent{
>             Actual: actual,
>         }
>         return cmds.QMP.SendEvent("BALLOON_CHANGE", ev, when)
>     }
> 
> I'm actually in favor of moving the Type itself to the method:
> 
>     type Events interface {
>         StopEvent(time.Time) error
>         ContEvent(time.Time) error
>         BalloonChangeEvent(BalloonChangeEvent, time.Time) error
>     }
> 
>     func (cmds *serverEvents) BalloonChangeEvent(ev BalloonChangeEvent, when time.Time) error {
>         return cmds.QMP.SendEvent("BALLOON_CHANGE", &ev, when)
>     }

I choose to expand all the types inline in events & commands
because I felt like this gives a more convenient API design
for applications, without the extra indirectino of packing
and unpacking parameters
.
> For the caller it might be an extra step but I see a few
> benefits:
> 
>     1. Documentation: I'm generating the QAPI documentation of
>        the events in its types. IDE's can jump-to-definition and
>        see the documentation there. Obviously we could move the
>        documentation here or duplicate it but the doc in the Type
>        looks the right place imho.

Yep, it would complicate docs to have to unpack it against the
method. I was coming at this from the POV of an application
developer though, intentionally ignoring what is the most
convenient for the code generator. The latter is fixed cost
while writing the generator, while the API design is an ongoing
cost time, so makes more sense to optimize for the latter.

>     2. Changes in the Event fields over time would not impact the
>        Breaking the Methods API. While some fields my be
>        added/removed/changed, I think this would help break less
>        the application when bumping the go module version.

Yep, hiding everything behind a struct can reduce breakage.

The tricky (impossible) question is how beneficial it is in
the real world usage ?

As guidance, taking protobuf as a commonly used package though,
if I look at Kubevirt's protobuf generated APIs:

  https://github.com/kubevirt/kubevirt/blob/main/pkg/handler-launcher-com/cmd/v1/cmd.pb.go#L1237

I can see they're using structs for parameters and return
values. So that widely used prior art, suggests we go the
way you outline and use structs.


> I'm not sure about empty types like StopEvent. I'm generating it
> with its doc but as it goes, it is bound to not be used, being
> generated just as source of documentation. Still, if it so
> happens that it does change in the future, we would need to
> extend the Method with its field or its type.
> 
>     // Emitted when the virtual machine is stopped
>     //
>     // Since: 0.12
>     //
>     // .. qmp-example::    <- { "event": "STOP",      "timestamp": {
>     // "seconds": 1267041730, "microseconds": 281295 } }
>     type StopEvent struct{}

Yes, if the goal of using structs is to reduce breakage when
fields are added/removed, then IMHO the logical conclusion
is that empty structs must be generated.

> That also applies for commands..
> 
>     // Resume guest VM execution.
>     //
>     // Since: 0.14
>     //
>     // .. note:: This command will succeed if the guest is currently
>     // running. It will also succeed if the guest is in the "inmigrate"
>     // state; in this case, the effect of the command is to make sure
>     // the guest starts once migration finishes, removing the effect of
>     // the "-S" command line option if it was passed.    If the VM was
>     // previously suspended, and not been reset or woken,   this command
>     // will transition back to the "suspended" state.   (Since 9.0)  ..
>     // qmp-example::    -> { "execute": "cont" }   <- { "return": {} }
>     type ContCommand struct {}
> 
> 
> I honestly did the requested changes a little while ago but I was
> thinking about this and tinkering a little with the demo.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


