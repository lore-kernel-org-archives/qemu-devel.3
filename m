Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBAFC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riY9M-0006Yf-HT; Fri, 08 Mar 2024 06:12:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9I-0006XX-Aj
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:25 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9G-0001QC-Fm
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:24 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dc09556599so17186295ad.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896340; x=1710501140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=etHwFI7I+Yz5FbHjdcCLaiP9JL9CHdZOSFk9wh7o+cc=;
 b=ihhKKFda9ryDYtrqzuy7ylNDl6gb2jRyWfKTDMyYbVpH3Ym/t7mPE2KkLKpV8ERbat
 1p9IRRiA4HuPZWBgqxNqHHuLFA922BbmAGlY7bbsq7A/YGyGzWVAg4LVXeToY88ebX6Q
 f4oqy+wRm6l+mBOSiycshBcbV99WuusW/iO5IgXf81w+0NXtgODkaOsqt42H4YGREQ/Y
 TL20tMLCBUKyjM31tA7PuvTd+FsgnwXGTuThkyHybs091ogLb6dOdn70V4y2xVrlTAmJ
 SpBIZfhTowNQnFKF7cwAuOSUOFZExlhIlU/txsuUStk1Jr0ji/zC5FiSU/iLAKNnG8kt
 cVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896340; x=1710501140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=etHwFI7I+Yz5FbHjdcCLaiP9JL9CHdZOSFk9wh7o+cc=;
 b=ZYnY9UGnPExI/kOv4waPMAfmiwQjr+7i/yPnYY4eyIXrG7r0AS0DzbKALlSe5kPube
 vwFB/k9/VzZyXsnXOraQfZdCXflLcgx5EAfTDn4v42GoEStldm01zAt7CVxOI+fkrm1k
 GZXirT7QdEzVeMYPIdNoSEroHXPb8/MJgmzKYYzLCmaTLYqzKyPEG2bIB6TxLU+edzo+
 gnHCv7mgq2uGJfJHUCHGgfKM03EIIVapPBixM+zBhCulfc1XeS4Wol13mmGWxnaU51a9
 KSlbdy50LYdLAQWN91+AbVBnvKHe+nD3bg4PaUM4s+LzX5o9Mm6bdy5VOZIK+WGtllsH
 GA2Q==
X-Gm-Message-State: AOJu0YzJYSmKs1CcL93uVES2HE5aJnJp8L6esKdDD6viShiJT/qVFqmL
 oWu9t94cACFiiCQSqAAmlxiFGr/wmS6GeKgcPN2Z8bEr05JWC4m/6F9qjTSNcG2gUg==
X-Google-Smtp-Source: AGHT+IEybRiSKxrZvdHY9CqoReedF+dlp5GNPRXhczsVBDyQ2ZfkiY85CvvtH6Xr49SPPbWXBEhPOw==
X-Received: by 2002:a17:902:c942:b0:1d4:cd4d:923b with SMTP id
 i2-20020a170902c94200b001d4cd4d923bmr13157507pla.54.1709896340025; 
 Fri, 08 Mar 2024 03:12:20 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:12:19 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/34] linux-user/riscv: Add Zicboz extensions to hwprobe
Date: Fri,  8 Mar 2024 21:11:23 +1000
Message-ID: <20240308111152.2856137-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Christoph Müllner <christoph.muellner@vrull.eu>

Upstream Linux recently added RISC-V Zicboz support to the hwprobe API.
This patch introduces this for QEMU's user space emulator.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240207115926.887816-2-christoph.muellner@vrull.eu>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-user/syscall.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7f30defcb1..81801f3dff 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8815,6 +8815,7 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
 #define     RISCV_HWPROBE_EXT_ZBA      (1 << 3)
 #define     RISCV_HWPROBE_EXT_ZBB      (1 << 4)
 #define     RISCV_HWPROBE_EXT_ZBS      (1 << 5)
+#define     RISCV_HWPROBE_EXT_ZICBOZ   (1 << 6)
 
 #define RISCV_HWPROBE_KEY_CPUPERF_0     5
 #define     RISCV_HWPROBE_MISALIGNED_UNKNOWN     (0 << 0)
@@ -8873,6 +8874,8 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *env,
                      RISCV_HWPROBE_EXT_ZBB : 0;
             value |= cfg->ext_zbs ?
                      RISCV_HWPROBE_EXT_ZBS : 0;
+            value |= cfg->ext_zicboz ?
+                     RISCV_HWPROBE_EXT_ZICBOZ : 0;
             __put_user(value, &pair->value);
             break;
         case RISCV_HWPROBE_KEY_CPUPERF_0:
-- 
2.44.0


