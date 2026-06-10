Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F410CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 08:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXERR-0004D4-2U; Wed, 10 Jun 2026 04:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXERK-0004C0-1I
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:37:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXERH-0005Se-Ob
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781080648;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=peR6Oo5JrzBDE84WfI7i2EVS8E933Ek9VIiFwibsv4E=;
 b=PaEiKnS/rgD4hhRQPkPTs7AfmXER9+r5iv9cTJ/E/VLMhCWTcKEdxyel4yF35+iHem5gsf
 c5zEeb9/W1/bwJU/kramAznWDZSH9UoAV61NyXDjhmzC+7AkHgbXJ75vr9b0imQpgYNNUS
 KlNgNKz2QK4Q6oMGKjp9H+Onp+7sPVY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-U-o080ZXPmiy7RrRHxcRdQ-1; Wed,
 10 Jun 2026 04:37:25 -0400
X-MC-Unique: U-o080ZXPmiy7RrRHxcRdQ-1
X-Mimecast-MFC-AGG-ID: U-o080ZXPmiy7RrRHxcRdQ_1781080643
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DC7418003FC; Wed, 10 Jun 2026 08:37:22 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.112])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C823E1800598; Wed, 10 Jun 2026 08:37:13 +0000 (UTC)
Date: Wed, 10 Jun 2026 09:37:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Dorinda Bassey <dbassey@redhat.com>,
 Albert Esteve <aesteve@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev,
 dev@lists.cloudhypervisor.org, rust-vmm@lists.opendev.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Demi Marie Obenour <demi@invisiblethingslab.com>,
 Alyssa Ross <hi@alyssa.is>, Mark Burton <MBURTON@qti.qualcomm.com>,
 Matti Moell <matti@qti.qualcomm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Sergio Lopez <slp@redhat.com>,
 Vishwanath Seshagiri <vishs@meta.com>, Rob Bradford <rbradford@meta.com>,
 Zhengyu Zhao <zhaozhengyu@bytedance.com>,
 "Jorge E. Moreira" <jemoreira@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Where should the vhost-user specification live?
Message-ID: <aikiB90tij642pEZ@redhat.com>
References: <CAJSP0QV4W=5MJsSGggACv-tqxDtiieKc0YzEn8t-R=RD94KJaQ@mail.gmail.com>
 <CADSE00+ziHc8W2FqNT-aJU0Lt4sZ=NfQLc65m16vpT++pZM+xQ@mail.gmail.com>
 <20260601151815.GC411459@fedora>
 <20260601160352-mutt-send-email-mst@kernel.org>
 <CACzuRyxedVMHNGkRf7AVyPWUTMgBMa6_DBnSHn+V6H7wN7XzWw@mail.gmail.com>
 <20260604162853.GC115597@fedora>
 <CAJSP0QXR6MyqoE1Uh-X7DzsOabbbN69TUyxf8r6ghUDCQnrP=w@mail.gmail.com>
 <CAFEAcA_Kd5_k+XyagUbB2+YVEMB0Sb0AB=oUZu6bGDot9TaFrQ@mail.gmail.com>
 <CAJSP0QVuSvVwa1szAy_3WVtWOjGK=oYAXjqAzbg5YoEvgybRjA@mail.gmail.com>
 <CAFEAcA9ZkbNK5kRL5+OiqgN2hk3JAmFN8Qd3cytqyTEm9hBkvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9ZkbNK5kRL5+OiqgN2hk3JAmFN8Qd3cytqyTEm9hBkvg@mail.gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

On Tue, Jun 09, 2026 at 08:51:15PM +0100, Peter Maydell wrote:
> On Tue, 9 Jun 2026 at 20:45, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >
> > On Tue, Jun 9, 2026 at 2:51 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > On Tue, 9 Jun 2026 at 19:00, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > > > I'm not sure if anyone brought up this topic on qemu-devel and with
> > > > Michael before. As I mentioned in my reply, there are ways to avoid
> > > > blocking vhost-user spec changes when qemu.git is frozen:
> > > >
> > > > The simplest approach is to keep merging vhost-user.rst changes during
> > > > freeze since it does not jeopardize the release or introduce
> > > > instability.

snip

> I tend to view the specs subsection of the docs as being
> for things where either QEMU really is the authoritative
> source (eg fw_cfg), or where the spec is for something that's
> basically moribund and has no better home. If vhost-user is
> a cross-project specification that it so active that it
> cannot live within QEMU's release process, then I think
> it deserves to have its own independent home.

Yes, the main impression I get having read through this whole thread
is that vhost-user spec should have its own home outside QEMU.

We can come up with all sorts of rationalizations for how to make
things work in the context of QEMU, but they all just come across
as excuses to avoid changing the fairly arbitrary historical use
of qemu.git. Even if as QEMU maintainers we consider that we're a
"neutral" home, I can understand why it might not be perceived that
way from the outside.

If people want agility such that we need to make exceptions for
our rules during freeze that is one flag that it doesn't belong
with the main qemu.git, but there are broader points that are
pushing my view in that direction too.


Not mentioned is that engaging with the QEMU mailing list as a
non-regular QEMU contributor is not a very attractive task.
While QEMU may be satisfied with email, QEMU are in a tiny
minority these days. The rest of the OSS community has
decided that git forges are the better way to collaborate.

Our dev list is very high volume, with changes very easily (and
often) lost in the noise, even from regular contributors, such
that we have to teach people to (repeatedly) "ping" to attract
attention.


If we want agility though, IMHO it is best to stay away from the
bureucracy of the OASIS virtio spec / committee, which is a big
turn off IME.


If we're considering a move of the spec, we should probably consider
the best home for some of the related code parts too:

  subprojects/libvhost-user/
  contrib/vhost-user-blk/
  contrib/vhost-user-bridge/
  contrib/vhost-user-gpu/
  contrib/vhost-user-input/
  contrib/vhost-user-scsi/

IIUC, the subprojects is fully standalone code with no dependency
on QEMU. It remained within QEMU for "convenience" allowing us to
consume them from the impls under contrib/. While the contrib code
has some depedencies on QEMU, overall they appear pretty light and
so likely easily detached

  $ git grep '#include "' vhost-user-* | awk '{print $2}' | sort | uniq
  "hw/virtio/virtio-gpu-bswap.h"
  "hw/virtio/virtio-gpu-pixman.h"
  "libvhost-user-glib.h"
  "libvhost-user.h"
  "qapi/error.h"
  "qemu/atomic.h"
  "qemu/bswap.h"
  "qemu/ctype.h"
  "qemu/drm.h"
  "qemu/iov.h"
  "qemu/osdep.h"
  "qemu/queue.h"
  "qemu/sockets.h"
  "standard-headers/linux/input.h"
  "standard-headers/linux/virtio_blk.h"
  "standard-headers/linux/virtio_gpu.h"
  "standard-headers/linux/virtio_input.h"
  "standard-headers/linux/virtio_net.h"
  "standard-headers/linux/virtio_scsi.h"
  "virgl.h"
  "vugbm.h"
  "vugpu.h"


We have a often repeated desire to eliminate the "contrib" tree
as a concept, since it is currently effectively a "dumping ground"
for things which are either unmaintained or didn't have a better
home yet. This might be a chance to provide a better home for a
big part of it.

IMHO this suggests it is worth creating a new top level gitlab project
for it all to live in and form a dedicated team around it, rather than
trying to pick any existing location.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


