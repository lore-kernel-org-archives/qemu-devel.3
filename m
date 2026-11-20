Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19245606A33E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 01:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUDBB-0005c1-Te; Thu, 19 Nov 2026 20:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xUDAx-0005bW-0g
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 20:12:28 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xUDAv-0007YG-4Q
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 20:12:26 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 40B4860EB20;
 Fri, 20 Nov 2026 02:12:22 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id NSqkxg0irj7b; Fri, 20 Nov 2026 02:12:20 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 334F860EB15; Fri, 20 Nov 2026 02:12:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2F7CE13C290;
 Fri, 20 Nov 2026 02:12:20 +0100 (CET)
Date: Fri, 20 Nov 2026 02:12:20 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Helge Deller <deller@kernel.org>
cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>, 
 Fam Zheng <fam@euphon.net>, Keith Monahan <keith@techtravels.org>
Subject: Re: [PATCH v3 0/6] nc53c710 rewrite
In-Reply-To: <20261119233235.32808-1-deller@kernel.org>
Message-ID: <5211baa3-97ef-03d6-6935-1eedef436769@eik.bme.hu>
References: <20261119233235.32808-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
>
> This is the third attempt to replace the existing 53c710 driver by
> a new driver based on the code of the lsi53c895a.c.
> Patch #1 is not meant to be reviewed, as it basically just replaces
> the existing driver by a new one.
> But patch #2 implements the proposed changes to use a common header
> for both drivers, as suggested by BALATON Zoltan.
>
> Note that the ncr53c710 driver is currently only used by the HPPA 715 machine,
> and this patch should not have any effect on any other platform or machine. On
> the 715, this driver has been sucessfully tested with Linux, HP-UX and NetBSD.
>
> Please review.
> It would be great if this series can be included for qemu v11.2, as the current
> driver does not work stable for any guest OS.

The freeze is strictly for bug fixes but replacing a whole device model 
with a new one is hard to justify as just a bug fix. I had the same before 
that something I wanted to include was ready too late and I had to wait 
until the next release to upstream it. It may be frustrating but please 
accept that this has likely missed the release so you now have more time 
to clean this up. I've never seen execptions made during hard freeze but 
I'm not the maintainer of this area so I'm not the one deciding just 
telling that in my previous experience this happened to me too a few 
times. If you don't want to wait until the next release maybe this could 
be submitted early in the next cycle with backporting to stable as a fix 
then could be available in 11.2.1. This series as it is is not the best 
way to do this and I think your intent was maybe to have one patch at the 
beginning that could be included without the rest but if that won't happen 
anyway you could redo it the right way that was suggested and merge it in 
next devel cycle.

Regards,
BALATON Zoltan

> Keith Monahan (6):
>  hw/scsi/ncr53c710: rewrite the 53C710 SCRIPTS engine
>  hw/scsi: share NCR/LSI definitions in lsi_scsi.h
>  hw/scsi/lasi_ncr710: map the full LASI SCSI module page
>  hw/scsi/ncr53c710: move to COMMAND on CLEAR ACK after MESSAGE REJECT
>  hw/scsi/scsi-disk: add quirk_mode_page_no_flexible_disk, use it on the
>    715
>  hw/scsi/ncr53c710: Comment cleanup, reduce verbosity, repetition
>
> MAINTAINERS            |    1 +
> hw/hppa/machine.c      |   10 +
> hw/scsi/lasi_ncr710.c  |  129 +-
> hw/scsi/lasi_ncr710.h  |   28 +-
> hw/scsi/lsi53c895a.c   |   79 +-
> hw/scsi/lsi_scsi.h     |   98 ++
> hw/scsi/ncr53c710.c    | 2957 +++++++++++++++-------------------------
> hw/scsi/ncr53c710.h    |  282 ++--
> hw/scsi/scsi-disk.c    |   13 +
> hw/scsi/trace-events   |   43 +-
> include/hw/scsi/scsi.h |    1 +
> 11 files changed, 1426 insertions(+), 2215 deletions(-)
> create mode 100644 hw/scsi/lsi_scsi.h
>
>

