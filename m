Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F61FD374D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 12:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvE2h-0003GV-MX; Wed, 25 Feb 2026 07:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvE2g-0003FS-02
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 07:31:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvE2e-0007f8-8e
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 07:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772022659;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=XrbX0U2jpo32se6YUhVajxEtco/lmky6rIes5a6oi9w=;
 b=dGjB5mJtYYniiIllwnMkCzu4wix/5qOeH9CbBk9Fnv9CIYtlLTrpy0V+pWqtEr+SA+lPiZ
 A3YqLPF02mCZiINbfkF7FevEbTILA+Bc7pamTgmPUswIV78/oTrXG8EoSmKOXPIXx4WWZ0
 HIu+3EPROEOUyLtq6Z58WWX703VlR2Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-T7LH5ddLOZ-1_Xs_APb9dQ-1; Wed,
 25 Feb 2026 07:30:50 -0500
X-MC-Unique: T7LH5ddLOZ-1_Xs_APb9dQ-1
X-Mimecast-MFC-AGG-ID: T7LH5ddLOZ-1_Xs_APb9dQ_1772022649
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C52C6195606B; Wed, 25 Feb 2026 12:30:48 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.165])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2CE83003D8B; Wed, 25 Feb 2026 12:30:45 +0000 (UTC)
Date: Wed, 25 Feb 2026 12:30:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>
Subject: Re: [PATCH v2 01/16] meson: Add BE RISCV targets
Message-ID: <aZ7rchFnUwL9XGBL@redhat.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
 <20260225102016.200654-2-djordje.todorovic@htecgroup.com>
 <d03c5416-14a2-425f-a96c-ba340cf79617@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d03c5416-14a2-425f-a96c-ba340cf79617@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Feb 25, 2026 at 11:39:50AM +0100, Thomas Huth wrote:
> On 25/02/2026 11.20, Djordje Todorovic wrote:
> > Add options to compile riscv64be-softmmu and riscv32be-softmmu
> > ---
> >   meson.build | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/meson.build b/meson.build
> > index 8c6c0a9a32..41ad38d184 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -55,6 +55,11 @@ supported_cpus = ['ppc64', 's390x', 'riscv64', 'x86_64',
> >   cpu = host_machine.cpu_family()
> > +# Unify riscv64be to riscv64.
> > +if cpu == 'riscv64be'
> > +  cpu = 'riscv64'
> > +endif
> > +
> >   target_dirs = config_host['TARGET_DIRS'].split()
> >   # type of binaries to build
> > @@ -281,7 +286,7 @@ elif cpu == 'ppc64'
> >   elif cpu == 'mips64'
> >     kvm_targets = ['mips-softmmu', 'mipsel-softmmu', 'mips64-softmmu', 'mips64el-softmmu']
> >   elif cpu == 'riscv64'
> > -  kvm_targets = ['riscv64-softmmu']
> > +  kvm_targets = ['riscv32-softmmu', 'riscv64-softmmu', 'riscv32be-softmmu', 'riscv64be-softmmu']
> 
> I really dislike the idea of having yet another target like mips where we
> have 4 different flavours (32/64 bits x big/little endian). That increases
> the compile- and testing time a lot. Couldn't you do it the ppc64 way? The
> ppc64-softmmu target can handle both, big and little endian, no need for a
> separate binary here. And we are going the same way with microblaze now -
> the microblaze target recently got support for little endian, so we can
> finally get rid of the microblazeel target now.

Also with the ongoing work to make a single QEMU binary that can
support any target, it feels like any problems with handling big
and little endian in a single binary will need to be solved
regardless, so if practical we should align with that direction
from the start.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


