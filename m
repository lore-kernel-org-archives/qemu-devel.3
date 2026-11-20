Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4FB606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xULzr-0002yD-Bz; Fri, 20 Nov 2026 05:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xULzo-0002xt-Ko
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:37:32 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xULzm-0002w9-Iw
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:37:32 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D375560E017;
 Fri, 20 Nov 2026 11:37:28 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 183mlASYF5Ni; Fri, 20 Nov 2026 11:37:26 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AD54E60CCE7; Fri, 20 Nov 2026 11:37:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AB79313C28F;
 Fri, 20 Nov 2026 11:37:26 +0100 (CET)
Date: Fri, 20 Nov 2026 11:37:26 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Helge Deller <deller@gmx.de>
cc: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Keith Monahan <keith@techtravels.org>
Subject: Re: [PATCH v3 2/6] hw/scsi: share NCR/LSI definitions in
 lsi_scsi.h
In-Reply-To: <76ff52a0-6cc6-45b9-b7e3-f9532c26cf57@gmx.de>
Message-ID: <08479444-9893-a0c2-f772-5ce8f2fde202@eik.bme.hu>
References: <20261119233235.32808-1-deller@kernel.org>
 <20261119233235.32808-3-deller@kernel.org>
 <faf7c973-3c97-9899-7a46-3a518634603e@eik.bme.hu>
 <76ff52a0-6cc6-45b9-b7e3-f9532c26cf57@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026, Helge Deller wrote:
> On 11/20/26 01:58, BALATON Zoltan wrote:
>> On Fri, 20 Nov 2026, Helge Deller wrote:
>>> From: Keith Monahan <keith@techtravels.org>
>>> 
>>> Move common defines and structures of the 53c710 and the lsi53c895a
>>> drivers to lsi_scsi.h, as suggested by BALATON Zoltan.
>
>> We have Suggested-by tag for that instead of putting it in comment
>> message. 
>
> Sure, will fix that.
>
>> This patch should come before the previous so it avoids the churn of
>> renaming what patch 1 added and add that already using these defines
>> and names after this patch.
> Independend of in which order patches should come, please take a closer
> look at patch #2.

Maybe it wasn't clear so just in case, first patch should split out shared 
parts into a header from the 895 model leaving the old 710 model to be 
replaced untouched. Then should come the patch replacing 710 with a 
rewrite using the header and having the rename changes to make it more 
easily comparable to the 895 model. That should avoid churn in this 
version.

> Your suggestion was to "share common defines and functions" in a common
> header file, with the intention that both drivers share functionality/code.
>
> This is what this patch currently does, e.g this part:
>
> -#define LSI_ISTAT0_DIP    0x01
> -#define LSI_ISTAT0_SIP    0x02
> #define LSI_ISTAT0_INTF   0x04
> -#define LSI_ISTAT0_CON    0x08
> #define LSI_ISTAT0_SEM    0x10
> -#define LSI_ISTAT0_SIGP   0x20
> -#define LSI_ISTAT0_SRST   0x40
> -#define LSI_ISTAT0_ABRT   0x80
>
> Now, looking at the result, I'm not sure this is what we really want.
> We rip out single bitmasks out of context and put it in in various
> header files. I think this is generating more confusion that having
> the defines per chip/driver as it was before.
>
> I suggest to keep those defines per-driver as they are, but instead
> share the lsi_request struct, LSI_* enums, PHASE* enums, and
> lsi_* functions only.
>
> Thoughts?

I think there are more defines that have the same values just different 
names so there might be more to share but you can leave that to a separate 
patch after the two models are easier to compare to see the simlilarities 
and differences better.

Regards,
BALATON Zoltan

