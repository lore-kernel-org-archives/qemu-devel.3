Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAE9F99C86
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 06:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEhqu-0000JV-QD; Mon, 20 Apr 2026 02:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1wEhqj-0000IZ-23; Mon, 20 Apr 2026 02:11:14 -0400
Received: from mail.avm.de ([212.42.244.120])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1wEhqe-00013O-Ve; Mon, 20 Apr 2026 02:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1776665461; bh=4Fal2xIRmMlpUVYVNP3GCV943FUFHigfFD9v3c84+go=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JQB7NKQYuKWS5DTmV1SQhXBTzF4dg30KDxZXGqoxqiOVnQDbUCT3/KKdK1U1ZdFQJ
 F1zu/CVCJo1I5SnzG9zhFwDuRiBS6hYkJTXdBcNh1QOLF0smIHaX2OCvO9nqje9X+1
 CpmjPxeMA5y1OTedzGUq7evzbIYsD+i7Y5kPkuGE=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <c.speich@avm.de>)
 id 69e5c375-04a0-7f0000032729-7f000001c46c-1
 for <multiple-recipients>; Mon, 20 Apr 2026 08:11:01 +0200
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Mon, 20 Apr 2026 08:11:01 +0200 (CEST)
Received: from l-cspeich ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2026042008110178-397 ; Mon, 20 Apr 2026 08:11:01 +0200 
Date: Mon, 20 Apr 2026 08:11:00 +0200
From: Christian Speich <c.speich@avm.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v4 5/7] hw/sd/sdcard: Add erase-blocks-as-zero option.
Message-ID: <lzsepp6tyxsfivi5zjqk4m3m2otbqwhyqfpkk6b26u4ecm7ab6@x2enoxyynbq6>
References: <20260417-sdcard-performance-b4-v4-0-119e66be10c2@avm.de>
 <20260417-sdcard-performance-b4-v4-5-119e66be10c2@avm.de>
 <2bdfa874-468b-4f59-b0c8-a7f51fc9d5d9@linaro.org>
MIME-Version: 1.0
In-Reply-To: <2bdfa874-468b-4f59-b0c8-a7f51fc9d5d9@linaro.org>
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 20.04.2026 08:11:01,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 20.04.2026 08:11:01, Serialize complete at 20.04.2026 08:11:01
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-purgate-ID: 149429::1776665461-2CFDF98C-25D65AE6/0/0
X-purgate-type: clean
X-purgate-size: 2658
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=212.42.244.120; envelope-from=c.speich@avm.de;
 helo=mail.avm.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 17, 2026 at 02:06:50PM +0200, Philippe Mathieu-Daudé wrote:
> On 17/4/26 11:51, Christian Speich wrote:
> > Currently, erased blocks are filled with 0xFF. However SCR Bit 55
> > (DATA_STAT_AFTER_ERASE) indicates that an erase produces zeros. One of
> > them is wrong.
> > 
> > This patch does two things.
> > 
> > First it fixes the reporting of DATA_STAT_AFTER_ERASE in SCR to
> > correctly reflect the content of erased blocks. We also increase the
> > Product Revision (REV in CID) to indicate to the guest that
> > DATA_STAT_AFTER_ERASE is now reliable.
> > 
> > Secondly, we introduce a erase-blocks-as-zero option, which allows the
> > user to choose if erased blocks should contain 0xFF or 0x00. The default
> > is still 0xFF to remain compatible with current users.
> 
> I'll update as:
> 
>   Secondly, we introduce a erase-blocks-as-zero option, which allows the
>   user to choose if erased blocks should contain 0xFF or 0x00. While
>   previous QEMU versions keep using the 'erase as 0xFF' pattern, the new
>   default becomes the more efficient 'erase as 0x00'.
> 
> Does it look OK to you?

Yes, looks good, thanks.

Kind Regards,
Christian

> 
> > Signed-off-by: Christian Speich <c.speich@avm.de>
> > ---
> >   hw/core/machine.c |  5 +++++
> >   hw/sd/sd.c        | 15 +++++++++++++--
> >   2 files changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 0aa77a57e956693208d77fea6af5853ed4904234..54e4c05c96e3cf35ab2e702ee81fba36457cadd7 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -38,6 +38,11 @@
> >   #include "hw/acpi/generic_event_device.h"
> >   #include "qemu/audio.h"
> > +GlobalProperty hw_compat_11_0[] = {
> > +    { "sdmmc-common", "erase-blocks-as-zero", "false" },
> > +};
> > +const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
> > +
> >   GlobalProperty hw_compat_10_2[] = {
> >       { "scsi-block", "migrate-pr", "off" },
> >       { "isa-cirrus-vga", "global-vmstate", "true" },
> > diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> > index b27fed2e563e5971dd32787498eb8abed9ffe9be..0f997ed8cc80e38645101cb8f47c86f1c30d5a25 100644
> > --- a/hw/sd/sd.c
> > +++ b/hw/sd/sd.c
> 
> > @@ -3287,6 +3296,8 @@ static void emmc_realize(DeviceState *dev, Error **errp)
> >   static const Property sdmmc_common_properties[] = {
> >       DEFINE_PROP_DRIVE("drive", SDState, blk),
> > +    DEFINE_PROP_BOOL("erase-blocks-as-zero", SDState, erase_blocks_as_zero,
> > +                     true),
> >   };
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> 

