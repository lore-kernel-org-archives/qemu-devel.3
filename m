Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82EAC531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 21:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn0gf-0000qL-Mq; Thu, 23 Jul 2026 17:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1wn0gP-0000jF-O6; Thu, 23 Jul 2026 17:10:22 -0400
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1wn0gN-0006EF-IA; Thu, 23 Jul 2026 17:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
 From:Reply-To; bh=hR14eAkSsBeI+OJ4kvfhmtmdU+NxBkFwNYh4qGR9Vtc=; b=qsEsDZnwsso
 AYbuQDn/M3v5NxPrjPh2CS00THKXPqJmGpnIxZFYbq/g8cBZfpB9DyFiIiJ+X7ilbqFrhDYPxrz0V
 Be6Te5GN53WvvCtJiLmT8CItm/QLMd951AZARtIV/OLvVUXYM/ifpyFuItYNxm+MvHNi1yLpwLFek
 tS3Ti6x+vYox25kfE9Ya3C0uBboZsFWsUwDaxQ1lgQmly2S47T2NwqhzkKhip1E6etgNGy8X2kxqZ
 ZObaKbPdloSLuxl5CH3AI1K6Jzmqt6a/JfK/RjJt/7qI0ACDIYWbsnJXzLJ4YmCfnexNA9Lf2etOc
 P/jmUgjDZYcB40GH144gaIQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wn0gF-003bjm-67; Thu, 23 Jul 2026 23:10:11 +0200
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1wn0gD-001oFf-5l; Thu, 23 Jul 2026 23:10:11 +0200
Received: from berto by gate.service.igalia.com with local (Exim 4.96)
 (envelope-from <berto@igalia.com>) id 1wn0gD-004gBd-02;
 Thu, 23 Jul 2026 21:10:09 +0000
Date: Thu, 23 Jul 2026 23:10:08 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/sd/sdcard: Register device ops in drives without media
Message-ID: <amKDMCpAbalcsFc9@igalia.com>
References: <20260723205847.137001-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723205847.137001-1-berto@igalia.com>
Received-SPF: pass client-ip=213.97.179.56; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu, Jul 23, 2026 at 10:58:39PM +0200, Alberto Garcia wrote:
> -    if (blk_size >= 0) {
> -        blk_size -= sd->boot_part_size * 2 + sd->rpmb_part_size;
> -        if (blk_size > SDSC_MAX_CAPACITY) {
> -            if (sd_is_emmc(sd) &&
[...]
> +        int64_t blk_size = blk_getlength(sd->blk);
> +        if (blk_size >= 0) {
> +            blk_size -= sd->boot_part_size * 2 + sd->rpmb_part_size;
> +            if (blk_size > SDSC_MAX_CAPACITY) {
> +                if (sd_is_emmc(sd) &&
[...]

There's a bit of churn here because I'm moving a whole block inside
another one, because I think that the resulting code reads better, but
we can of course keep the patch simpler if you prefer:

@@ -3145,7 +3145,9 @@ static void sd_realize(DeviceState *dev, Error **errp)
             error_setg(errp, "eMMC image smaller than boot partitions");
             return;
         }
+    }
 
+    if (sd->blk) {
         ret = blk_set_perm(sd->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
                            BLK_PERM_ALL, errp);
         if (ret < 0) {

Berto

