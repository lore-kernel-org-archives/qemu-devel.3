Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC0F606A322
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LIVR+fF9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLagD-0001v1-Eg; Tue, 27 Oct 2026 02:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLag2-0001sP-E2
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:28:54 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLag0-0008AI-Tj
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:28:54 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3acd21ba21aso2942850a91.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082531; x=1793687331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RNDD+ScD3AdYVl6IHt/6cgD0pnuLGi/tjfqp4L4WKTU=;
 b=LIVR+fF9pw9Fh5Bvwm1rUwxms1F2+/kyBgk+SDEfDNxn5UXbzJQ+h1/eNm9OckHCHK
 K+F9D/j5BP7yNuekGAyf+DjaFhEOVZMTJ5POu7Mi+dtj7KRc5tqK3EQ2nDIOxjebcBC6
 NgFV/HwCLznxzhSoD20D3S3vlTV4i1kY17N3BwAl1sq6ml7DNk1n+drkSNxKUr6xTyl3
 PQV66fuF1LbM3nAT7VvBX974yMof9yHVCFiMp2u6yyIbj9Sft7qz9LKeiiwapKj1q+Qs
 hjg+JXWfi1Mcny+sWoI49q4GbNRgufUjDP7+WDhtw6RbJpCH514NS1qgfRJLX9vW2FrH
 aKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082531; x=1793687331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RNDD+ScD3AdYVl6IHt/6cgD0pnuLGi/tjfqp4L4WKTU=;
 b=OQlF/KIY+iDPObrT7J2d3faeqB9XebbTrQQxdXs+59g7PniyZubIN10z5LzsPzv7Wu
 /EoihnxvUXA+b6mBbLncD0RhPmbOkNyRS0FYTc2Qbe/RrXaS+wd0hE6bEENKmvKCJwj+
 FcDhElhr2SMAoCc0E7+dY910TDAbEO0HzgW+7iBkBYW4Ix14UVofuqeyU3Q6b4O75A/y
 8R3ZHq7hrD/CewwCg0L5k3n5A/RT3EJJ038OL444W0ZJxbywcqIOU7bXRf1wWPk5lG1h
 bxh39q4i6TCl5DpBk4BJfSajmXEyWcI26OpAemKJeKP9Nv2zLEuaxsy+J00lxlkETJJ0
 NDNw==
X-Gm-Message-State: AFq9FYKqv8Se9kO91828YvZmesZwui5P/3LXCFAfFs6fUYUGeBZFmyy3
 5SUcHLvt9YVZwxqa/W/Tw/0oU6/hN3zjVRWdaoSkkU0rtcUOlojRt9F7S4p7Wg==
X-Gm-Gg: AYBFou3o38F+M+hn9RFZXcHmML4lhpn0C8ZrelTpnwJ9z9tiZ/vLiBnx1UdizpM7BXt
 MtBNPrW7ow9ROV5Otuy1dt0iXcNP5+l7RQRmbMdv0/k00nLNFl163xtl/YHX6IW2L825xSUBkl+
 KNXoh6VM71jj/MUqeLYScSEfL6yd/ZJYA5ZOnyUsYBHExvUUenBI2jZa+Sb6J221LJF2OvNeOCW
 oSiF8mC8G5t/ApaX8wTwOu1KOO2PUMoH8FR5WZeHJRZflBnYj3XMD1uHmh79Ba18j/i0Oyc7uo+
 kNafoNNdgA2gHvESEb4EDLFUkPIBBCbqw4xUUMZbqWTWr5bbxDFki9rJ6nJeIV4Ebflkz99Q8Nn
 r1PUH2+PQtuCwCXmxZZK3v7SgcDw7qnvBulsXaPSuH1UF6pJi0bmBPxOvdymOC5AXJxAc6KTP/h
 +VUjhbK/iBFz8e5LafJ87OJ53tIe3o6V9WuH4h7cnSmzU9CyJqefnFz6UDHPOlvhTl875vq2Gec
 ueEr1aMlKxd9EUGQmwLQ3I8U0srm4o5iDsEVPjRbgeME4SpYa916z5tFtl+RieZt3Ci+z7feA==
X-Received: by 2002:a17:90b:4e8c:b0:39d:84af:a0b3 with SMTP id
 98e67ed59e1d1-3adeac07c4fmr7558585a91.18.1793082531451; 
 Mon, 26 Oct 2026 23:28:51 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:28:50 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Portia Stephens <portias@oss.tenstorrent.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/29] docs/atlantis: Update Atlantis UART documentation
Date: Tue, 27 Oct 2026 16:27:47 +1000
Message-ID: <20261027062808.1995205-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
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

From: Portia Stephens <portias@oss.tenstorrent.com>

Update Atlantis documentation to describe the DesignWare UART used.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20261015002849.1640109-4-portias@oss.tenstorrent.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/system/riscv/tt_atlantis.rst | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/docs/system/riscv/tt_atlantis.rst b/docs/system/riscv/tt_atlantis.rst
index 539c22354f47..d94d064f4f62 100644
--- a/docs/system/riscv/tt_atlantis.rst
+++ b/docs/system/riscv/tt_atlantis.rst
@@ -13,7 +13,7 @@ tt-atlantis QEMU model features
 
 * 8-core Ascalon-X CPU Cluster
 * RISC-V compliant Advanced Interrupt Architecture
-* 16550A compatible UART
+* DW8250 compatible UART x5
 * 4 PRCMs (Clock and Reset Controllers)
 
 Known limitations
@@ -25,9 +25,8 @@ real platform. Notably:
 * There is no PCI host bridge, so virtio-pci devices cannot be
   attached. Boots that need block storage must use ``-initrd`` with
   an initramfs.
-* The DesignWare UART is modelled with QEMU's ns16550-compatible
-  ``serial_mm`` device; DesignWare-specific registers beyond that
-  set return 0.
+* The Atlantis platform has 5 UARTs but only ``UART1`` is currently exposed
+  on the command line serial interface. ``UART1`` is the Ascalon console.
 
 Supported software
 ------------------
-- 
2.55.0


