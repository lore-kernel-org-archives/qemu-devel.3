Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DADCD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 09:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNIS-0002G9-Ot; Mon, 11 May 2026 05:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMNHK-0000AI-GA
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMNHG-0004Bz-CK
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778493015;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0aHAKfCeO6o7TFvCjCAZjHfFJRuYylMqFjy9QKrdb4w=;
 b=AW7o/kM2hUJO2V4B/SWvqjUBQz3SiU3eKF69rNVQbe1ZeHELMj1HJAVfgQZj+GW/pjks3Z
 1cPWA34dg02hgPJEaAABe/lZgsSKANSEbLBI08rh/3RHv6qs37QcBz9RBIHyRHBOfVPiJG
 zDJ9XAhGsEDzGHpmAkYYU27SgqnKtkA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-lwUyOwGkM2eKg-K6Jm7iig-1; Mon,
 11 May 2026 04:37:36 -0400
X-MC-Unique: lwUyOwGkM2eKg-K6Jm7iig-1
X-Mimecast-MFC-AGG-ID: lwUyOwGkM2eKg-K6Jm7iig_1778488655
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2172018005B3; Mon, 11 May 2026 08:37:34 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.30])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60801180034E; Mon, 11 May 2026 08:37:28 +0000 (UTC)
Date: Mon, 11 May 2026 09:37:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/9] tools: Move more tools sources into tools/
Message-ID: <agGVRFsSh1mbKc4U@redhat.com>
References: <20260508152428.2648560-1-peter.maydell@linaro.org>
 <735327c6-f23f-42cf-9b8e-a651d8ee7770@oss.qualcomm.com>
 <CAFEAcA8eKM_DNK4kWX0DNudMiq__uZ-MQM0L-2CfWL39CgCyJw@mail.gmail.com>
 <CAJ+F1C+XzzsGRwLjUCYiDaS9OGXMq5oc3QM5pm4obZAgLP7Z1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1C+XzzsGRwLjUCYiDaS9OGXMq5oc3QM5pm4obZAgLP7Z1w@mail.gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Mon, May 11, 2026 at 12:23:32AM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Fri, May 8, 2026 at 8:23 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Fri, 8 May 2026 at 17:00, Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> > >
> > > On 5/8/2026 8:24 AM, Peter Maydell wrote:
> > > > We have a set of binaries that we call "tools": they're built based on
> > > > the --enable-tools/--disable-tools configure setting, they're
> > > > documented in docs/tools, and they're standalone executables of one
> > > > form or another.
> > > >
> > > > Currently the sources for these are a bit scattered: many still in the
> > > > top level source directory, some in contrib, one or two actually in
> > > > the tools directory.
> > > >
> > > > As an initial attempt at cleanup, this patchset moves the sources for
> > > > qemu-bridge-helper, qemu-edid, qemu-img, qemu-io, qemu-nbd,
> > > > qemu-keymap, qemu-vmsr-helper and elf2dmp into the tools/ directory.
> > > >
> > > > The patchseries also moves the ebfp skeleton sources from tools/ebpf/
> > > > to ebpf/bpf-src/, because this isn't a tool by the above definition.
> > > >
> > > > As per my thread from a while back, I would ultimately like us to
> > > > clean up contrib/:
> > > > https://lore.kernel.org/qemu-devel/CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com/
> > > > But parts of that clearly need more discussion. So this is just doing
> > > > some parts that I hope are not controversial.
> > > >
> > > > Annoyingly, meson doesn't seem to provide any way for a subdirectory
> > > > meson.build to say "the foo.c in this subdir builds into a foo
> > > > executable that lives at the top level of the builddir". And we have a
> > > > lot of test harness stuff plus user muscle memory that assumes that
> > > > qemu-img and qemu-io live there. So the build runes for these tools
> > > > have to stay in the top level meson.build (and tools/meson.build
> > > > remains an empty file). The exception is that contrib/elf2dmp/elf2dmp
> > > > is now tools/elf2dmp/elf2dmp, but I think the set of people who were
> > > > running that from the build directory will be small.
> > > >
> > >
> > > It's a deliberate design more than an annoyance. It pushes users to make
> > > things explicit at top level, which is good to understand what is built
> > > and how, and hide details in subdirs in variables. QEMU's top level
> > > meson.build is over complex, so it may appear more as a burden than a
> > > benefit though.
> >
> > Personally I think if the build system doesn't let you do a
> > pretty normal and reasonable thing that's annoying. Meson
> > annoys me because it has a tendency to be over-opinionated.

Being opinionated is a double edge sword. A big part of the mess you
get with traditional build tools is that they are not opinionated so
every project ends up doing something slightly different and thus it
is harder to understand each project.  Being opinionated is what keeps
meson simpler to understand and learn, at the cost of loss of flexiblity.

Meson may not have the balance entirely right, but overall I think it
has been beneficial to be very opinionated, even if that means some
places needs to be relaxed over time.


> I have to agree that meson is sometimes lacking. In this case, it
> would be convenient to have a link created at build time. But you have
> to resort to fairly annoying custom_target python code today. In the
> meantime, there is also fs.copyfile() that could work (although it's
> also somewhat limited or buggy). For later, we could try adding
> fs.symlink() perhaps. Paolo might have better chances than me getting
> it accepted ;)

IIUC, the main reason to want binaries in a specific location is
so that tests find them in that location.  That is a valid historical
approach, but meson offer an alternative approach that could be used
instead.

We can set the test environment so that meson modifies $PATH such that
all the built binaries appear at head of $PATH. Tests then don't need
to assume a location for them in the build directory, just let execvp
search $PATH as normal.  For execution outside of 'meson test', we have
"meson devenv" which sets up a local interactive shell environment, or
we can launch the test via the "run" script which wraps "meson devenv"
for a single command.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


