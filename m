Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935CACD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 09:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKv5v-0005gy-DT; Thu, 07 May 2026 05:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wKv5t-0005eC-9J
 for qemu-devel@nongnu.org; Thu, 07 May 2026 05:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wKv5r-0001jV-Dj
 for qemu-devel@nongnu.org; Thu, 07 May 2026 05:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778146350;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MIplG652C+44eNB8SHxgDXOIgZNYyLfTOoS35oSYyU0=;
 b=Cj7gqHVlC3U1CT4JTmpLDYSUPFfX2/e7vscNbpvG3/YpfwLF9vAinWFC9CCOr9Mui0Wb4Z
 k52EB2Rfz6Ll2h21WCayWMn98/pridV/DpvCXq1j64aW9e3eBsxuweYDoZ1Q2RekXzNIyS
 VPolXhP1314pUxfNd9e22k5sO66WFi8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-dVnQxGtIOH-Rp6y9xrPJmQ-1; Thu,
 07 May 2026 05:32:25 -0400
X-MC-Unique: dVnQxGtIOH-Rp6y9xrPJmQ-1
X-Mimecast-MFC-AGG-ID: dVnQxGtIOH-Rp6y9xrPJmQ_1778146344
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43EA418005B5; Thu,  7 May 2026 09:32:24 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.217])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E25D61953947; Thu,  7 May 2026 09:32:22 +0000 (UTC)
Date: Thu, 7 May 2026 10:32:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 08/10] .agents/skills: add qemu-issue-triage agent
 skill
Message-ID: <afxcI3-84QA5GKph@redhat.com>
References: <20260505170105.228162-1-alex.bennee@linaro.org>
 <20260505170105.228162-9-alex.bennee@linaro.org>
 <afxMiS7Y5RIXPLUz@redhat.com>
 <b4c22e08-eb21-486d-a9d8-5ef84f28b0e9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4c22e08-eb21-486d-a9d8-5ef84f28b0e9@linaro.org>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

On Thu, May 07, 2026 at 11:20:57AM +0200, Philippe Mathieu-Daudé wrote:
> On 7/5/26 10:25, Daniel P. Berrangé wrote:
> > On Tue, May 05, 2026 at 06:01:03PM +0100, Alex Bennée wrote:
> > > While triaging the issue tracker I wondered if this would be a
> > > suitable job for an AI agent. Unfortunately the OSS program doesn't
> > > give any credits to run agents in gitlab. However I do have access to
> > > models from my editor and ECA so I built one and tested it on a few
> > > issues.
> > > 
> > > Obviously this can't apply as is because it probably encodes too much
> > > of my local setup (using pass for API keys) and uses the ECA as my
> > > preferred coding agent. I assume at some point there will be agreement
> > > between all the agents where skill live.
> > > 
> > > Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> > 
> > ..snip..
> > 
> > > diff --git a/.agents/skills/qemu-issue-triage/assets/labels.txt b/.agents/skills/qemu-issue-triage/assets/labels.txt
> > > new file mode 100644
> > > index 00000000000..d329f34183d
> > > --- /dev/null
> > > +++ b/.agents/skills/qemu-issue-triage/assets/labels.txt
> > 
> > Seeing our labels listed like this triggers my urge to "tidy" :-)
> 
> Should we improve MAINTAINERS and store these tags there, then
> generate labels.txt?

Tricky question. IMHO the MAINTAINERS file is not neccessarily
the right granularity for issue labels. 


> > > +Storage                    Block subsystem, Storage devices, etc.
> 
> We should really expand this one.

This has always confused me when we have many "block:" labels too.

Mixing backends and frontends is also an anti-pattern for label
tagging.

I'd think 'block:' for all backend stuff, and  'device:storage'
for all frontend stuff


> > > +block:9p                   The 9p network file system
> > > +block:NVMe
> > 
> > These two are not like the others under 'block:'. 'NVMe' is frontend device,
> > and 9p is a filesystem. I'd assume 'block:' applies to block/*.c
> > 
> > > +block:curl
> > > +block:nbd
> > > +block:nfs                  Issues related to the NFS backend
> > > +block:qcow2
> > > +block:ssh
> > > +block:vmdk
> > 
> > Probably want a "block:core" for stuff not specific to one of the listed
> > backends.

> > > +efi                        EFI firmware related issues
> 
> firmware:efi, ...

Yes, we have many more firmwares in git


> > > +guest: AIX
> > > +guest: BSD                 Guest OS is BSD (NetBSD/FreeBSD/OpenBSD/etc)
> > > +guest: Linux               Guest OS is Linux/Linux-based
> > > +guest: Windows             Microsoft Windows guest
> > > +guest: macOS               Apple macOS / Darwin as  guest OS
> > > +guest: os2
> 
> s/guest/guestos/? (vs hostos)

Yes,

> 
> > > +host: aarch64              Bugs reproducible on AArch64 hosts
> > > +host: arm                  Bugs reproducible on ARM hosts
> > > +host: loongarch64          Bugs reproducible on LoongArch64 hosts.
> > > +host: mips                 Bugs reproducible on MIPS hosts
> > > +host: ppc                  Bugs reproducible on Power hosts
> > > +host: riscv                Bugs reproducible on RISC-V hosts
> > > +host: s390                 Bugs reproducible on s390 hosts
> > > +host: sparc64              Bugs specific to Sparc64 hosts
> > > +host: x86                  Bugs reproducible on x86 hosts

And 'hostarch' for these perhaps


> > > +host:32bit                 These are mostly TCG related bugs where we sometimes struggle with emulating larger guests, especially atomic and address space issues.


> > 
> > More space inconsistency
> > 
> > > +hostos: BSD                FreeBSD, OpenBSD, NetBSD, and derivatives as host OSes
> > > +hostos: Linux              Linux-based host operating systems (Fedora, RHEL/CentOS, Debian, Ubuntu, openSuSE et al)
> > > +hostos: Windows            Microsoft Windows host OS
> > > +hostos: macOS              Apple macOS / Darwin as a host OS
> > > +icount                     issues relating to icount, deterministic execution and record/replay functionality

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


