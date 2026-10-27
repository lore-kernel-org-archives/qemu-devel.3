Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAED606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gxx+KebE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLag7-0001tG-V5; Tue, 27 Oct 2026 02:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLag5-0001sz-R3
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:28:57 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLag4-0008Ac-5H
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:28:57 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3ae1b34e0d2so287575a91.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082535; x=1793687335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7/c/3fUv9pdiUGCkXSDH2A1SdTkDX3HRAt/rFtZ4Oq8=;
 b=gxx+KebETwSMAEVC/NR1GW5BHY86Uhbu7iOrosDvSYyVpojDaMHRqc1XDJ2gaPgS9D
 qYaqJNE1krCXlZspdGz/7gwuNeyopMrqzCen9I2aNMkZ2Tf2Pv8acv+BPeGvw7sHhPjL
 tbZbLf0TGJD8kFQXQyOmF2n3sPgEAN+2xGfco5g30pDLjEjpbFVTJNBsf6lwvI9/mNOY
 Hk2rZITSNqxwmxcoRUOr0o3K69bE3LVdBFmTTZ8+zjw56n2Es19pWrwXWqJRU7760o1p
 6FEZ3WXYEKQW34NNEXPKdDtMwwKtF4KBdJeHyOhR89XljVw1A15G0rd7uX0ZfxGD1oJx
 JY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082535; x=1793687335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7/c/3fUv9pdiUGCkXSDH2A1SdTkDX3HRAt/rFtZ4Oq8=;
 b=MrOQRd5GssL0bW2BxmWKB6zgdhz+WZV5Nl4BmsVyOWt7sSAYLF9hcK6Npji2JJd/RN
 E/Llen/C9cUkEiuxoeaETICyV784TKfxpKIpI6mZlRPlSGKA3CUt6YYMSste1EuNfWi2
 331YbBge98CjByKim533y4mSuo+mHpdG7Gr6MIRKJZ7rGgnBnG1qL/+02ax3v4twVNcc
 vkfzCv6brf7vs13AvOMgY6RCQWi4hkNojBvQTSwRSy96d6esa5PEFQPak0Msq9BVudol
 k0SisFnHU3VysHyoTXbzR1UaUpcoouvAVliH+7gPa4LD7lweRUeP8IwETaLGkTYj+WcH
 k3MA==
X-Gm-Message-State: AFq9FYIZbtO0gON4GDyNhqUFxaa2Li/uak/Z9GtgAd1hF1Gx85LGsAs/
 pFkJmi7w+1LaE6kH9se2SMqfiD+G6w5/RWca/EeIDuKJF8PWYabj7hPGy4icvA==
X-Gm-Gg: AYBFou2yT9TYxTIw4yOWVopFBf6s3M15Y59m++zE9Q7XBthYPNzCENI07uB4903XCny
 ZpawHKWWV7PVyqKURhsMxb/mhMlkRVvpHreBlHgkQllkppe31zyXJWpibw9BuWfcWToRzmo9BgZ
 VZoGZSOG05FlSPF+IbVxNey0dqRp3IDnRqJC71c2Ej81ZaUXC4NQuxUa1mjdmwouiZIBJQa+hia
 BKdp+FDjoJLWZrgdthc0zcDAfhmg+CcjYhQxskQf6muzcKGSCnhKwnloOP3sKkh60jWiVwHm53X
 IWfCCrc9rTLVjXDD4VPRHUoNzLygiVhS9ov4u0cavPHhbP7rhk/Vc3qFv9uRsCBcg/KXw8kuZWF
 xmd97iLFDHlnQfS91XR7Qowm4q0QIoVB3XJq57eW33G0h6KxgZzuELnzAcsSC9VeqMhOnj9QVSa
 OvZBARESHVzUWC9EOk+vRI+EbbPvAs6taGdKFAbkR1ikYFBXVMCa4orkt8sW46h00BiZgrX87Mw
 BfozW3OE8XcE4x5JhajwKh6eiubJ0p3uLepO7Gr369tTJ+QOzATwRTNZhXo6TmCO000wvKopw==
X-Received: by 2002:a17:90b:2885:b0:3a4:7195:ecba with SMTP id
 98e67ed59e1d1-3ae4029973fmr761105a91.20.1793082534891; 
 Mon, 26 Oct 2026 23:28:54 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:28:54 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Tan Chi <tanchi25@mails.ucas.ac.cn>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 09/29] hw/riscv/riscv-iommu: fix entry leak with ioatc-limit=0
Date: Tue, 27 Oct 2026 16:27:48 +1000
Message-ID: <20261027062808.1995205-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tan Chi <tanchi25@mails.ucas.ac.cn>

riscv_iommu_translate() allocates an IOATC entry before passing it to
riscv_iommu_iot_update(). The update helper normally transfers ownership
to the hash table.

When ioatc-limit is zero, however, the helper returns without inserting or
freeing the entry. Every cacheable non-identity translation therefore leaks
one RISCVIOMMUEntry.

Avoid this by disabling caching at the caller when ioatc-limit is zero,
so riscv_iommu_translate() does not allocate an IOATC entry in the first
place. This avoids special-casing entry freeing in riscv_iommu_iot_update()
and keeps the ownership semantics simpler.

Suggested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Fixes: 9d085a1c3cb2 ("hw/riscv/riscv-iommu: add Address Translation Cache (IOATC)")
Cc: qemu-stable@nongnu.org
Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20261005111523.277550-1-tanchi25@mails.ucas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 323a041b4a55..866f49cc39aa 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2919,7 +2919,8 @@ static IOMMUTLBEntry riscv_iommu_memory_region_translate(
         /* Translation disabled or invalid. */
         iotlb.addr_mask = 0;
         iotlb.perm = IOMMU_NONE;
-    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb, true)) {
+    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb,
+                                     as->iommu->iot_limit > 0)) {
         /* Translation disabled or fault reported. */
         iotlb.addr_mask = 0;
         iotlb.perm = IOMMU_NONE;
-- 
2.55.0


