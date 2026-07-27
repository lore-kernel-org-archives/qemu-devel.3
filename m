Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCA2C531FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woFga-0008UJ-N8; Mon, 27 Jul 2026 03:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flavien.solt97@gmail.com>)
 id 1woFgM-0008Qo-ML
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:23:27 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flavien.solt97@gmail.com>)
 id 1woFgK-0005qQ-N7
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:23:26 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cbb8b54fcf8so2314421a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 00:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785137003; x=1785741803; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hQnhrc+B4ntfIfS7WFVE7RCkWpO+btWxjP4Q3NLZqQQ=;
 b=I1YWIazvTFm9YnK2TelNjxlduBK6viqnJr8dIprBoqfXe6Y0ZVfy7zy/UNmyrfRCU0
 1Q9whjWUI7c/71uHQ9I2SJ9cuNPnGlooGs6dIGaFM5Gd3Y6HfCRjvd5cFHVjQhV14J3y
 KUoBGk1NmV0JX7dVS9qJO2RvOXM7e3QkngvQxd59l7yZ0CWGZxf1jFl1a/OydYIlwTbV
 EC5ZZxz8y27XOn3M7XchvoMoN2MP521crAfImEfQVVkyQ6jWvE80gyrFiFryMj5/sAEy
 qiYkg1ImkWE7A4VGqkeiD+YViCjsvdHT8He+AQoJOXA1DZwYodu4BqjI5e+mzr9rgCwS
 RTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785137003; x=1785741803;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hQnhrc+B4ntfIfS7WFVE7RCkWpO+btWxjP4Q3NLZqQQ=;
 b=MUpuSNJDXH/rexIq8blrESCkISm+3ADPfZRwt0JXBPTLrpW5YEgTjO5XpdlUVmCcBP
 +MGBUf2NkuRO5GUr/dV+KxuBMktaoIDBI5jKXNWuFZAXmvydSy0B1Os03myfbSFZzYek
 R/xDq5awOci3UhKdU8Z1CNdxswTCVZeeAJrUTXzPhnKjoEJ65WuIJKwF1Nd6aoFCnmkp
 Tgw4inLcNxvqEmGA7wrfzFoaHLYJdL8gIYM3+cU8K7DDj6v3mkZMC3UY0RGbk7JzPKxc
 2iq1sTO8b3dEqS9U3aWoQH56AnZxUJzhG5Ki71kuR/dxyA5kFH5+uCnd7xRoI3Sf80Pg
 Li7g==
X-Gm-Message-State: AOJu0YztHNjt+bORtf6crJTCNMzUAa5AMgvCMZNCq52pxgFBy8qU8Mfm
 U5kWvBs1pgOu3u2F37qTZVFHs6Ceg8w6GNGa+VfpYfe+PgFRKJ1ccuuo
X-Gm-Gg: AR+sD10lWex0Zs4xCnuA0DxPNp2Xm8C66ecG+CgX21F/b7JzrA/JiGHQlC4dk75NuFI
 Yney2D40w62eQ6Dx+jeI3XWNroY+MxbXsC3/x5nU8NeiIfDkXc3In+KQyVJW0BH82qbh1x8A1GU
 ziTBYEwUkREqN0YcVqsJd1/WSyD+2fP9eMjy1A3wmVmXK5ozWICZGmQuyvtNHzWTi4IWCQhZUMO
 m8SH/dkLUN96/A9UPvzR5VBZ4teYfc5gy84PiLUCQS8T9kkLCK8+YxhForsnpd1xrBY+fj9Wwyh
 wEU5vR7e1oZVVHNJYPT6vKDdjHJ3xWHePGp4vx3iZaf4w3ASTdNebbkJilCdOTSr+FHWqnk956n
 tapqGonlv+VAHaJEWndASHUkWofYniU9OsSGUTWSB/uC8dVzkWyB74yshBejNtaWKqec9eqJwrQ
 HqP//schVJp5FqhqIJ+o0j40lriaBK4+OOL1oHYKZQcx27BxPqfe/7OI1V0rzTuhnWRs7EkQZGQ
 8ISssgznpfO2wA=
X-Received: by 2002:a05:6a21:6005:b0:3c0:9c1a:8939 with SMTP id
 adf61e73a8af0-3c67e1422bbmr6777579637.65.1785137003349; 
 Mon, 27 Jul 2026 00:23:23 -0700 (PDT)
Received: from flavien-macm3.ddns.comp.nus.edu.sg ([137.132.220.135])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc419c52sm28481032eec.10.2026.07.27.00.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 00:23:22 -0700 (PDT)
From: Flavien Solt <flavien.solt97@gmail.com>
Date: Mon, 27 Jul 2026 15:22:58 +0800
Subject: [PATCH v4 2/3] hw/riscv/riscv-iommu.c: always send MRIF notice MSI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-qemu-mrif-v4-v4-2-73e0890ad395@gmail.com>
References: <20260727-qemu-mrif-v4-v4-0-73e0890ad395@gmail.com>
In-Reply-To: <20260727-qemu-mrif-v4-v4-0-73e0890ad395@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Tao Tang <tangtao1634@phytium.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Nutty Liu <nutty.liu@hotmail.com>, Flavien Solt <flavien.solt97@gmail.com>, 
 qemu-stable@nongnu.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785136991; l=1860;
 i=flavien.solt97@gmail.com; s=qemu-mrif-v4-gmail; h=from:subject:message-id;
 bh=AyhDitwqEMTLhlxlyQPXe6ylATgJ9+x3GdqYluglOUU=;
 b=4Ok61yc4C5AdfW6amsyCzxZweTU7B+B3UNZTbZYBxs2/L/yAQ8ctCgjRRgrQu6KHSvo8SN9bo
 EuVmKzjdZRTC30+dLE8x6Vkxp+dEYaiv1EcKIFw2uRX34SvvC5LxZOv
X-Developer-Key: i=flavien.solt97@gmail.com; a=ed25519;
 pk=wEVvqF5SMWVnTyKNb8WAo78S30Q6giJmU/VisghJRtI=
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=flavien.solt97@gmail.com; helo=mail-pg1-x52e.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The AIA specification requires an IOMMU to send the configured notice
MSI after storing an MSI to an MRIF, even when the corresponding
interrupt-enable bit is clear.

riscv_iommu_msi_write() currently reads the MRIF interrupt-enable
doubleword and suppresses the notice MSI when the matching bit is zero.
This makes notice delivery depend on a bit that AIA requires the IOMMU
to ignore.

Remove the enable-word read and send the notice MSI unconditionally
after updating the MRIF pending bit.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Cc: qemu-stable@nongnu.org
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Signed-off-by: Flavien Solt <flavien.solt97@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Tested-by: Chao Liu <chao.liu@processmission.com>
---
 hw/riscv/riscv-iommu.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index f6865d1..2bbac30 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -788,19 +788,6 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
         goto err;
     }
 
-    /* Get MRIF enable bits */
-    addr = addr + sizeof(intn);
-    res = dma_memory_read(s->target_as, addr, &intn, sizeof(intn), attrs);
-    if (res != MEMTX_OK) {
-        cause = RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
-        goto err;
-    }
-
-    if (!(intn & data)) {
-        /* notification disabled, MRIF update completed. */
-        return MEMTX_OK;
-    }
-
     /* Send notification message */
     addr = PPN_PHYS(get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NPPN));
     n190 = get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NID) |

-- 
2.54.0


