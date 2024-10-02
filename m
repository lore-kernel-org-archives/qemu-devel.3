Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF770CF3196
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsHD-0006Cg-I0; Wed, 02 Oct 2024 01:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsH5-0005i8-4f
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:47 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsH2-0004t9-Rj
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:46 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20bb92346caso3599675ad.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848302; x=1728453102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Arvu3B3JNoSbLUaOVbJ7yzOlHS2uM7cxNmHtDLRkOT8=;
 b=DnpVwO4CW8uzZNr4CK6l3bz7hE8KhNsk9tfHzQjUf0A/0AtLMqygaNUuhmFQ3rSPi1
 H3Zzjelgg1v7oQj1u7tVC2UHRfCigW1GDNs1dC6M7hU3EdN0iOm+VLIz5iVZfWVivsa2
 fjnE3S4/h6n0BQvpTmaYPJv9btrgeJiJ4AK80xPDZNtN3W/q9n5E9yWGTujVL3Wry2Dy
 HdqwdtkXHdS/7dCBlGu9jx6/Xeu/skMmrxZQ1ZdVwqDh+FB6pthSKCeTSFIDY3BbB2f5
 3t5GEOeCOvip0ZJ7WUZ8o4I2zRzCFU62LaNLgelcGxgWYyuRM4VYAQKo+zK7fotBRGyY
 9AYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848302; x=1728453102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Arvu3B3JNoSbLUaOVbJ7yzOlHS2uM7cxNmHtDLRkOT8=;
 b=h3kFRnuw1oeSZeODkNRArxZcLkyTvhi99DcwOKKbmpPg1VUzFm87XYfoxBwoKtIszu
 Q3hit6fbtqRit1Xi+z2Wzs/NwoCob1Topr0ct0P0ZM6HIdOxX8DWjwPkm2zWshrixrgX
 dRAaPOhUF9/hxY25TEU7tQSZ/oZ1LrG3HqHTyawFLsCDH6YnXQUhSF2wq598Xx33v/7p
 IedjeXwn7eGv6injUdwHeXeTEwhHhEwegqBJR9sU0GPPCmRBsYSJGRrgTkBo8JQYAuVy
 14trTiYxyj65xlLfEicEDx7BnYRIdCojLXU6xNH7JRff6xg3p+cUHQzYNN6ebd2CRvbE
 BvkA==
X-Gm-Message-State: AOJu0Yw3rbdJ9D2SaLPj+d26qB+kRtw0YIYI3dv/RTWot58XHmGnLLiZ
 QqiKMa6lMOcft/np/QPhCXETdUrz25D/IU71gE7u7UvjJwM9M+jUYb8PZUzL
X-Google-Smtp-Source: AGHT+IFiUKmZholgoOk1k2VjEzKfT/HBQbc8ZnFdcB209ygp5xtuqshdflcLtknGv2NzRQfu9ZVyvA==
X-Received: by 2002:a17:902:ce12:b0:20b:a73b:3f5 with SMTP id
 d9443c01a7336-20bc5b8b899mr27529285ad.14.1727848302537; 
 Tue, 01 Oct 2024 22:51:42 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:51:42 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 15/35] target: riscv: Add Svvptc extension support
Date: Wed,  2 Oct 2024 15:50:28 +1000
Message-ID: <20241002055048.556083-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

From: Alexandre Ghiti <alexghiti@rivosinc.com>

The Svvptc extension describes a uarch that does not cache invalid TLB
entries: that's the case for qemu so there is nothing particular to
implement other than the introduction of this extension.

Since qemu already exposes Svvptc behaviour, let's enable it by default
since it allows to drastically reduce the number of sfence.vma emitted
by S-mode.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240828083651.203861-1-alexghiti@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h | 1 +
 target/riscv/cpu.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 96fe26d4ea..355afedfd3 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -81,6 +81,7 @@ struct RISCVCPUConfig {
     bool ext_svinval;
     bool ext_svnapot;
     bool ext_svpbmt;
+    bool ext_svvptc;
     bool ext_zdinx;
     bool ext_zaamo;
     bool ext_zacas;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 89bc3955ee..658bdb4ae1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -197,6 +197,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
+    ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1494,6 +1495,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
     MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
     MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
+    MULTI_EXT_CFG_BOOL("svvptc", ext_svvptc, true),
 
     MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
     MULTI_EXT_CFG_BOOL("zihpm", ext_zihpm, true),
-- 
2.46.2


