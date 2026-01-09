Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E45D1A628
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 13:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veCkl-0008Oo-6V; Fri, 09 Jan 2026 08:42:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1veCkj-0008NF-9v
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 08:42:09 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1veCkh-0004BD-IL
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 08:42:09 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c06cb8004e8so1761309a12.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 05:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767966126; x=1768570926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=affQLNqmyiWgfxRtBOl48kOnpHcewRCNgdrvFEEYG14=;
 b=g3Zu+QpIZJ4YvjfCkI6TpLPbJfoACS0is7hjYxd3iOixGzfGAU/Hc1iIqA4PvupNQk
 eVC+j6YRUuFS3ge1M6+FBpUk13+toORIXg28KqcKLSMPMfiop+p8s20wm09HWzmIR1uq
 fvNP2yIqPnxFDINvQrVWFkrSpxiBWDiNzz9JbryYlUF7EgVfPEPiQaw5SB3+LfSseAVy
 jrtSg7I173DYJLWG2lBA3q2Grx0q/eSKzLq5im5e1wBY6cKR5U+GZG+Eu+xcKY5mJvbT
 /ATJri9hB46LiWzKyazM7TX0+RXpfZoIhL4q4sKiNHMgz14XqOCnZjV15qT7ZoVu0GXC
 kbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767966126; x=1768570926;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=affQLNqmyiWgfxRtBOl48kOnpHcewRCNgdrvFEEYG14=;
 b=sn11Ll6XEzkLhZUr0lMlznA5b2fi0Fao2DvTM7GCBSZaMdFgvRDKtMyArU1aO0jfq8
 WDwsAG/c3O7TcFds5arBRv3U1I3+dYVSg0TXkC1XAeYgzmM2Fnz60GnkFykt3mDhd3eO
 nDWI3py0C+c8unkN7xEnK6uy2T6Z/6G1CUH2/Z3UpkMupLhL0ZqBdDk229vsZtoXuRxv
 M/xDVFtSjIgZE/3BMA5NQ79doi3jnedjQTPrLCKGADZFijjdPjDs1l82a/h6pfbCF+Qx
 xZ7P9w7ioWiYIJ3b+C8DqWHzLiIVcTcY3mHIrwiLyduzu6buRce9JDCvxNVoNDzOFjqi
 aIzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTHxWBEyGNydpQ9UP3ZJFshRjo4Eo91ze8oCyJpfwRAvY1iCSK8lFhaKBfqD8RWFdilyHZCDtuYN95@nongnu.org
X-Gm-Message-State: AOJu0YzqTjVq+QBSbfKygvB3fShJOOWgTSKXeMrMJdVhyOiymJugfyJ4
 SjnfGWycBWBJ2o8XK9qRnDx4nWP/bv22hg47dJgoQ7TeuPe+iPaKU9dL
X-Gm-Gg: AY/fxX4dhuyJNRuqZiWjgcAhsooF/RI/JodGhkoOX62OI16QUx14iiOpM87M2tzLtzg
 WUvrL39ecJKA6413fwKDXaawSrMQ+OVSRt/QC+Q+NBKPNcyE1yoN0d2qfneaTWqTXPqlyY6Y/RH
 TBTLEhlQZNUiv6HFANCz3qAvfu2GtRW+5Y14Sv+WSGdcmUugjoBrEWnNkcguhUZycWOsJhTyNk2
 vnCMU5MPA+6hjfHNf0WRoehDoLYDkuylsI/GTBE1aypLYyakFo0pCmcUV8X4aAefi6ETf4q6CSM
 0+o7xG4Spr3SdAz0BFuN6T5HRO3RlSmqCFzC/YcYMngSMJJt+77Oz1bsnkLM6B4bz1dGKuO2w/q
 1vBLGlHgvtk7+x8C70A8zrXrFcHSlAmVmrogSUgFKe/KRT9hZaB0CSB3sH3pV7Likoe3n8BX5Bi
 4VdxvDPtiK+hpj8ANQjnK9CrJ0bvPBbVM=
X-Google-Smtp-Source: AGHT+IGw9u2IVFav3vYE3Sx4yXPeUWioDJxRwanhFAWEj6CC94URAIXKwZDi4GYpeonIr4mivdbmZw==
X-Received: by 2002:a17:90b:5746:b0:349:8116:a2d8 with SMTP id
 98e67ed59e1d1-34f68c02457mr9944904a91.7.1767966125856; 
 Fri, 09 Jan 2026 05:42:05 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fb7419csm10871316a91.13.2026.01.09.05.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 05:42:05 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH] target/riscv: tt-ascalon: Add Tenstorrent mvendorid
Date: Sat, 10 Jan 2026 00:11:43 +1030
Message-ID: <20260109134145.398565-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

JEP106 has two vendor IDs for Tenstorrent. We will use Bank 16, hex 0xa1:

 ((16 - 1) << 7) | (0xa1 & ~0x80) = 0x7a1

Add it to the Ascalon CPU definition as the mvendorid CSR.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
This stands alone from the atlantis series and can go in asap.

 target/riscv/cpu_vendorid.h | 2 ++
 target/riscv/cpu.c          | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
index f1ffc66542a0..751a13aace47 100644
--- a/target/riscv/cpu_vendorid.h
+++ b/target/riscv/cpu_vendorid.h
@@ -8,4 +8,6 @@
 #define VEYRON_V1_MIMPID        0x111
 #define VEYRON_V1_MVENDORID     0x61f
 
+#define TENSTORRENT_VENDOR_ID   0x7a1
+
 #endif /*  TARGET_RISCV_CPU_VENDORID_H */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index efdec49e49ed..85ce4d83a371 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3190,6 +3190,8 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_svnapot = true,
         .cfg.ext_svpbmt = true,
 
+        .cfg.mvendorid = TENSTORRENT_VENDOR_ID,
+
         .cfg.max_satp_mode = VM_1_10_SV57,
     ),
 
-- 
2.47.3


