Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DE7EFCD71
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 10:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzXPL-0007vG-AI; Mon, 09 Mar 2026 06:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vzXPH-0007rk-S2
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 06:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vzXPE-0001Vy-4v
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 06:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773050406;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SVaAl0hg8Crb51WUycUQ/vXcVqo6x2fhIJxEqlBI3SM=;
 b=RVkRi1HLkmK7oMl0Qb49J6d7+4t74ZrF+k+3XEwZ8oTc80+SH2Hko/MW4ZRX90HX9BKDMo
 uyMMRrZ41xrtSZKOuc1GO9Lvq3S9/PKThu3ZuZCTKqkhRchhg1OwWy4PkZJr9CvnfBoCZJ
 ZqTAx+K6/neByp443nAyjyScCO3mv4o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-ZfEbZdYqPj6nbfVcNQfDwQ-1; Mon,
 09 Mar 2026 06:00:02 -0400
X-MC-Unique: ZfEbZdYqPj6nbfVcNQfDwQ-1
X-Mimecast-MFC-AGG-ID: ZfEbZdYqPj6nbfVcNQfDwQ_1773050400
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A7301956059; Mon,  9 Mar 2026 09:59:59 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.95])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58FDE19560A6; Mon,  9 Mar 2026 09:59:55 +0000 (UTC)
Date: Mon, 9 Mar 2026 09:59:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@freebsd.org>, Sean Bruno <sbruno@freebsd.org>,
 =?utf-8?Q?Mika=C3=ABl?= Urankar <mikael.urankar@gmail.com>,
 Guy Yur <guyyur@gmail.com>, Alexander Kabaev <kan@freebsd.org>,
 Michal Meloun <mmel@freebsd.org>, Ed Schouten <ed@nuxi.nl>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: Re: [PATCH v3] bsd-user: Switch to SPDX-License-Expression
Message-ID: <aa6aF2HKJ-54fs8h@redhat.com>
References: <20260307-bsd-user-copyright-v3-1-666ac0b819f1@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260307-bsd-user-copyright-v3-1-666ac0b819f1@bsdimp.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Sat, Mar 07, 2026 at 09:49:41AM -0700, Warner Losh wrote:
> Two minor changes to the copyright and license marking for these files:
> (1) Stacey D Son is used instead of variations of his name.
> (2) The GPL boilerplate is replaced by SPDX markings. No change to the
> terms of the license are intended, and this matches current QEMU practice.
> 
> There's no changes to the license or additional claims to any IP that
> others may hold in these files. All the S-o-bs in this commit have given
> me permission to do this to the extent they may hold rights. git blame
> over multiple repos and branches suggests that only minimal other
> material is present (much of it likely not subject to copyright
> protection). The project's long and complex history as well as tooling
> limitations make it hard to be 100% sure. Any omissions are
> unintentional and I will correct them as they come to light.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
> Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Guy Yur <guyyur@gmail.com>
> Signed-off-by: Alexander Kabaev <kan@FreeBSD.org>
> Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
> Signed-off-by: Ed Schouten <ed@nuxi.nl>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
> Adjust the copyright markings for the bsd-user project to the extent
> that's easy and prudent. This removes the gpl boilerplate and replaces
> it with a SPDX line, per QEMU standard proactice. It uses Stacey D Son
> everytwhere rather than variations on that name. It uses full date
> ranges as appropriate.
> 
> All that's changing is the markings. I have Stacey's explicit permission
> to do this, as well as people cc'd. The history of bsd-user, first
> copied from linux-user and then passing through several branches in
> several repos as maintainers shifted make it hard to get a complete list
> of authors. But to the best of my ability to determine, this list
> represents the overwhelming majority of people who may have a copyright
> interest in the files not documented with a Copyright line.
> 
> This does not chanage any intellectual property rights people hold in
> these files. Nor does it change the licensing of these files in any
> way. It's easy to revert relevant parts should an unknown-to-me author
> appear and desire it. I believe it's legally defensible and would not
> affect future legal matters, especailly given this explicit statement of
> intent.
> 
> I'm doing this proactively so that all the files, with only few
> exceptions, can be marked in a similar manner in bsd-user's blitz repo.
> This will help in upstreaming as it completely takes the issue off the
> table, likely saving me hours of future work in reply to why something
> is marked the old way or realizing in the upstreaming process I have to
> make the change in bsd-user's blitz branch first (or worse, during the
> review process). Each individual change might not be a big deal, but the
> cumulative effect can grow large.
> ---
> Changes in v3:
> - Drop a few more files
> - Add Karim Taha, who has given me permission
> - Link to v2: https://lore.kernel.org/qemu-devel/20260304-bsd-user-copyright-v2-1-173525ffa614@bsdimp.com
> 
> Changes in v2:
> - document permissions better
> - drop a couple files that had others claiming copyright.
> - Link to v1: https://lore.kernel.org/qemu-devel/20260302-bsd-user-copyright-v1-1-f05587d18d4e@bsdimp.com
> ---
>  bsd-user/aarch64/signal.c               | 15 ++-------------
>  bsd-user/aarch64/target_arch.h          | 16 ++--------------
>  bsd-user/aarch64/target_arch_cpu.c      | 15 ++-------------
>  bsd-user/aarch64/target_arch_cpu.h      | 18 +++---------------
>  bsd-user/aarch64/target_arch_elf.h      | 14 +-------------
>  bsd-user/aarch64/target_arch_reg.h      | 19 +++----------------
>  bsd-user/aarch64/target_arch_signal.h   | 16 ++--------------
>  bsd-user/aarch64/target_arch_sigtramp.h | 16 ++--------------
>  bsd-user/aarch64/target_arch_sysarch.h  | 16 ++--------------
>  bsd-user/aarch64/target_arch_thread.h   | 16 ++--------------
>  bsd-user/aarch64/target_arch_vmparam.h  | 16 ++--------------
>  bsd-user/aarch64/target_syscall.h       | 16 ++--------------
>  bsd-user/arm/signal.c                   | 18 +++---------------
>  bsd-user/arm/target_arch.h              | 16 ++--------------
>  bsd-user/arm/target_arch_cpu.c          | 18 +++---------------
>  bsd-user/arm/target_arch_cpu.h          | 18 +++---------------
>  bsd-user/arm/target_arch_elf.h          | 18 +++---------------
>  bsd-user/arm/target_arch_reg.h          | 18 +++---------------
>  bsd-user/arm/target_arch_signal.h       | 18 +++---------------
>  bsd-user/arm/target_arch_sigtramp.h     | 18 +++---------------
>  bsd-user/arm/target_arch_sysarch.h      | 18 +++---------------
>  bsd-user/arm/target_arch_thread.h       | 18 +++---------------
>  bsd-user/arm/target_arch_vmparam.h      | 18 +++---------------
>  bsd-user/arm/target_syscall.h           | 18 +++---------------
>  bsd-user/bsd-file.h                     | 18 +++---------------
>  bsd-user/bsd-mem.c                      | 17 +++--------------
>  bsd-user/bsd-mem.h                      | 17 +++--------------
>  bsd-user/bsd-proc.c                     | 17 +++--------------
>  bsd-user/bsd-proc.h                     | 17 +++--------------
>  bsd-user/freebsd/os-misc.h              | 18 +++---------------
>  bsd-user/freebsd/os-proc.c              | 17 +++--------------
>  bsd-user/freebsd/os-proc.h              | 18 +++---------------
>  bsd-user/freebsd/os-stat.c              | 17 +++--------------
>  bsd-user/freebsd/os-stat.h              | 18 +++---------------
>  bsd-user/freebsd/os-strace.h            | 19 +++----------------
>  bsd-user/freebsd/target_os_elf.h        | 18 +++---------------
>  bsd-user/freebsd/target_os_siginfo.h    | 18 +++---------------
>  bsd-user/freebsd/target_os_stack.h      | 18 +++---------------
>  bsd-user/freebsd/target_os_thread.h     | 18 +++---------------
>  bsd-user/freebsd/target_os_user.h       | 18 +++---------------
>  bsd-user/freebsd/target_os_vmparam.h    | 18 +++---------------
>  bsd-user/i386/signal.c                  | 17 +++--------------
>  bsd-user/i386/target_arch.h             | 16 ++--------------
>  bsd-user/i386/target_arch_cpu.c         | 17 +++--------------
>  bsd-user/i386/target_arch_cpu.h         | 17 +++--------------
>  bsd-user/i386/target_arch_elf.h         | 18 +++---------------
>  bsd-user/i386/target_arch_reg.h         | 19 +++----------------
>  bsd-user/i386/target_arch_signal.h      | 16 +++-------------
>  bsd-user/i386/target_arch_sigtramp.h    | 16 ++--------------
>  bsd-user/i386/target_arch_sysarch.h     | 18 +++---------------
>  bsd-user/i386/target_arch_thread.h      | 18 +++---------------
>  bsd-user/i386/target_arch_vmparam.h     | 18 +++---------------
>  bsd-user/i386/target_syscall.h          | 16 +++-------------
>  bsd-user/qemu-bsd.h                     | 18 +++---------------
>  bsd-user/syscall_defs.h                 | 18 +++---------------
>  bsd-user/x86_64/signal.c                | 16 +++-------------
>  bsd-user/x86_64/target_arch.h           | 16 ++--------------
>  bsd-user/x86_64/target_arch_cpu.c       | 17 +++--------------
>  bsd-user/x86_64/target_arch_cpu.h       | 17 +++--------------
>  bsd-user/x86_64/target_arch_elf.h       | 18 +++---------------
>  bsd-user/x86_64/target_arch_reg.h       | 19 +++----------------
>  bsd-user/x86_64/target_arch_signal.h    | 17 +++--------------
>  bsd-user/x86_64/target_arch_sigtramp.h  | 17 ++---------------
>  bsd-user/x86_64/target_arch_sysarch.h   | 17 +++--------------
>  bsd-user/x86_64/target_arch_thread.h    | 18 +++---------------
>  bsd-user/x86_64/target_arch_vmparam.h   | 18 +++---------------
>  bsd-user/x86_64/target_syscall.h        | 16 +++-------------
>  67 files changed, 185 insertions(+), 971 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


