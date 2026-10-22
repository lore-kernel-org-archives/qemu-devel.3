Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AEB606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJpVV-0001XF-Pb; Thu, 22 Oct 2026 05:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ewanhai-oc@zhaoxin.com>)
 id 1xJpVT-0001We-Ew
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 05:54:43 -0400
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ewanhai-oc@zhaoxin.com>) id 1xJpVQ-0003Bv-IM
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 05:54:43 -0400
Received: from zhaoxin.com (unknown [127.0.0.1])
 by mx1.zhaoxin.com (MTA) with ESMTP id 4j9M1s3mHqzb0pbL;
 Thu, 22 Oct 2026 17:54:25 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.140.201])
 by mx1.zhaoxin.com (MTA) with ESMTP id 4j9M1r3Klxzb0pbL;
 Thu, 22 Oct 2026 17:54:24 +0800 (CST)
Received: from ewan-server (ewan-server [10.28.24.7])
 by zhaoxin.com (8.30) with ESMTP49ec586927af1748ac6263a515f0510c
 Thu, 22 Oct 2026 17:54:24 +0800
X-Eyou-Smtpauth: ewanhai-oc@zhaoxin.com
X-Eyou-EnvelopeSender: ewanhai-oc@zhaoxin.com
X-Eyou-From: Ewan Hai <ewanhai-oc@zhaoxin.com>
From: "=?UTF-8?B?RXdhbiBIYWktb2M=?=" <ewanhai-oc@zhaoxin.com>
Date: Thu, 22 Oct 2026 17:54:46 +0800
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, ewanhai@zhaoxin.com, 
 cobechen@zhaoxin.com
Subject: Re: [PATCH v4 0/4] target/i386: Add Zhaoxin Shijidadao CPU model
Message-ID: <atncw8u-1ERPEcgw@ewan-server>
References: <20260826084838.2107629-1-ewanhai-oc@zhaoxin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826084838.2107629-1-ewanhai-oc@zhaoxin.com>
X-Eyou-Sender: <ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=210.0.225.12; envelope-from=ewanhai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FROM_EXCESS_BASE64=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Aug 26, 2026 at 04:48:34PM +0800, Ewan Hai-oc wrote:
> Add CPU models for the Zhaoxin Shijidadao server (v1) and client (v2),
> including their cache topology.  The matching KVM support for SM2, CCS,
> RNG2, PHE2 and RSA is queued in the KVM next branch.
> 
> The series also adds YongFeng-v4 with the same five feature pairs.
> 
> TCG does not currently implement these instructions.  TCG_EXT4_FEATURES
> remains zero, so QEMU filters the new bits from realized TCG CPUs.
> 
> The Shijidadao models expose CPUID leaf 0x1f.  A related fix for invalid
> subleaf handling under TCG is available here:
> https://lore.kernel.org/qemu-devel/20260609090046.2376016-1-ewanhai-oc@zhaoxin.com/
> 
> Changes since v3:
> - Rebased to the 11.2 development tree.
> - Added QEMU definitions for the five feature pairs now available
>   through KVM.
> - Enabled the new CPUID 0xC0000001 EDX feature pairs in the Shijidadao
>   models and adjusted the server and client feature sets to match their
>   respective silicon.
> - Added YongFeng-v4 with the same feature set.
> 
> v3:
> https://lore.kernel.org/all/20260109021028.83985-1-ewanhai-oc@zhaoxin.com/
> 
> KVM feature series:
> https://lore.kernel.org/all/20260610023512.3690734-1-ewanhai-oc@zhaoxin.com/
> 
> Ewan Hai (4):
>   target/i386: Add cache model for Zhaoxin Shijidadao vCPUs
>   target/i386: Add Zhaoxin cryptographic CPUID features
>   target/i386: Introduce Zhaoxin Shijidadao CPU model
>   target/i386: Enable new cryptographic features in YongFeng-v4
> 
>  target/i386/cpu.c | 284 ++++++++++++++++++++++++++++++++++++++++++++--
>  target/i386/cpu.h |  20 ++++
>  2 files changed, 295 insertions(+), 9 deletions(-)
> 
> -- 
> 2.34.1

Hi Paolo,

Ping on this series. All four patches have Zhao's Reviewed-by, and
I've checked that the series still applies cleanly to current master.

Could you please pick this up, or let me know if anything else is needed?

https://lore.kernel.org/all/20260826084838.2107629-1-ewanhai-oc@zhaoxin.com/

Thanks,
Ewan


