Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4BEC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlxD-00064W-DW; Thu, 27 Jun 2024 06:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlxB-0005pb-47
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:09 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlx9-0001iE-C4
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:08 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-706a1711ee5so1722496b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482526; x=1720087326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+2ZtPlx1gfPCtUTgrKOFONw9SOdI5ccx3X/2YcbrFmM=;
 b=PxIX0gePqbQzku9ZTvlyXJNfiIawfRbpmdybJmzvGgGupKSfsMj4mcUIdbECmgk0fm
 Y1fbn8Dy5GiwDItTy2eET7f/d80+FwwcQCASpePXDN97Jkj7eXG9kdOGzYZ3N1km3JE0
 QRQGJaIa4q7FcAzElHhrhSs6NsLLypUrRXCL3LjOiy8Rrj1vVwIpBEbobFvSEZWRqHTy
 tSc1DmGX8KsOQMCpkdcLZmOuWG8NyBCspexrIBxyEBSaWAZ3tIHehN1n5lGD8V1ySDSx
 MmcWPTeGlJUazq/G4K/UHnYtWKf5zjI+Bph0PvwrfCt5gUfhgFIbZvblmuzWx0BVpoN7
 pyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482526; x=1720087326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+2ZtPlx1gfPCtUTgrKOFONw9SOdI5ccx3X/2YcbrFmM=;
 b=iUWHq7Mia6hp2o8l8NNNt88W9yoPFfFbczrUpy7RfEeixTic4eHoPMt4yzXfhf8Tkn
 kcLqgZubTBO+nwLoypAzcDKoYjprfyFzjj+k2ZKSMwxEDksUxhCtlbgFF7DNyOYo4Pge
 y9bdTjoojid6aTeXSnaqht+GOifEcCWPvOayptaaFXKNIdIcds0vzl4DGuj1UFH9qC5M
 QHhXKcpglIadkLcKTud+j6Z3ToJdBLiUdjJeZFnO53aH11IGCdc0XkKTdkDAZQHFhzcj
 w3kH5bKwL5/nhBFNfU+YtXnKYvh0zyR+B9UDk75HkludQx85FSFa+1HkXyhthVsHImSS
 MYxw==
X-Gm-Message-State: AOJu0YwsxJgbezF06MYVId0Gqd8FAF5fjSOKpVeAeEM2KeewwNrNv6ay
 Nlf6ZQzkeOLCSW4fXB+rVmJoVnvM0KHEW+KXfBY4r0hlbHMnWoilJaWZACGy
X-Google-Smtp-Source: AGHT+IFxkBI4qboUzeCkA6q0oEkqA+onz8dJdSXqVVgMOfzOGt2lZhT62kN0qO0pBVgTb+j9kRvwrA==
X-Received: by 2002:a05:6a00:c8e:b0:704:2811:62 with SMTP id
 d2e1a72fcca58-706745be4c5mr15284762b3a.13.1719482525517; 
 Thu, 27 Jun 2024 03:02:05 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:02:05 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "Fea.Wang" <fea.wang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 19/32] target/riscv: Reserve exception codes for sw-check and
 hw-err
Date: Thu, 27 Jun 2024 20:00:40 +1000
Message-ID: <20240627100053.150937-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
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

From: "Fea.Wang" <fea.wang@sifive.com>

Based on the priv-1.13.0, add the exception codes for Software-check and
Hardware-error.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240606135454.119186-6-fea.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 096a51b331..c257c5ed7d 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -673,6 +673,8 @@ typedef enum RISCVException {
     RISCV_EXCP_INST_PAGE_FAULT = 0xc, /* since: priv-1.10.0 */
     RISCV_EXCP_LOAD_PAGE_FAULT = 0xd, /* since: priv-1.10.0 */
     RISCV_EXCP_STORE_PAGE_FAULT = 0xf, /* since: priv-1.10.0 */
+    RISCV_EXCP_SW_CHECK = 0x12, /* since: priv-1.13.0 */
+    RISCV_EXCP_HW_ERR = 0x13, /* since: priv-1.13.0 */
     RISCV_EXCP_INST_GUEST_PAGE_FAULT = 0x14,
     RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT = 0x15,
     RISCV_EXCP_VIRT_INSTRUCTION_FAULT = 0x16,
-- 
2.45.2


