Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADF0C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riY9r-0006gU-Ds; Fri, 08 Mar 2024 06:12:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9k-0006fQ-Eq
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:53 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9f-0001ae-Mi
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:52 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dc0e5b223eso4934755ad.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896366; x=1710501166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8hMOgfT97lEwas5azcGeM/dlMzYi43I5zjS/KCNScj8=;
 b=IVvl6B62cFn2Uk34gDQjwCS67iZWQGhYtDDQla5Xmz7NTJEnv6Uf1NEOs5fZ79MioO
 MMVyst8oR6zzquWjoijcsuqkUDpU0VYhCgt5AGsSpK5dRa8VhVgEJIB2bhO7gs/bhit4
 NcvMu63WlN6CKz1AQjvu0en86n6T6yUf874j1UV2czVfMYmgT5B3gOkNACxIfVVstHkq
 nUDeqjVMnwsoqXl3Uy3WXVpVVWLIaSBB2WGldJ0RIcvyMP4aWjCdIIJiLK1y+V6ESMVD
 mFxrSDvYeUvL+OxRcy2BOZ5EMhMf5AImN4VJiEs/nGGxr8hjmxojfOl1Ib9Hzp3/C4YA
 ck4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896366; x=1710501166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8hMOgfT97lEwas5azcGeM/dlMzYi43I5zjS/KCNScj8=;
 b=HRqXyBBQickWgBGjOepru0LPEmrw+lQyZs8UaHmszmPpX7b6Rzd3Ue+fMPG9OOVAXd
 3F4ego7m/Z6unNzHERX3irn1Uy01Cj0LKFQr5LDVl/nIzjQOmVM3ZAga1yLfudYEFq97
 ayt3aRVSs6l3vkmd6SfsFSKp38JL0a7GfvKJTzEz0d4TYyJPtvkD9Wm5v3saPoTBRauc
 O5DrVJdRE3YToDFDSLGEevppBxcKnoFuWBave8hqi+Ozgq/lTVmp+gtFsP3+CFTg3XzX
 bZfzdM6ERm5U/aj/b/qdoD1Zj1HfCGlJEAB2Wvp/DVMKGlrQLgh4hbCV08Re3p32DYRi
 jx1Q==
X-Gm-Message-State: AOJu0Yzh+FzVJJgrSP3RMhEoHzhgDrmAtCAjGgHSNvuT3Q9T0qeLTIhR
 3vIFEBV9UKs8SylyctXid9ZCXU406X4vEEoZpCTSLV20zIXH/Xbh4bkG+FsjJLESgA==
X-Google-Smtp-Source: AGHT+IHawxxd2iRlTC6cc7IKdgjV7B5AEYhq4gQRUX4MtVJVhwXoSMpvfmzRUSsGW8r0NU+b6SXOUA==
X-Received: by 2002:a17:903:22cf:b0:1dd:2b9b:8898 with SMTP id
 y15-20020a17090322cf00b001dd2b9b8898mr13594691plg.14.1709896365989; 
 Fri, 08 Mar 2024 03:12:45 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:12:45 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Irina Ryapolova <irina.ryapolova@syntacore.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/34] target/riscv: FIX xATP_MODE validation
Date: Fri,  8 Mar 2024 21:11:31 +1000
Message-ID: <20240308111152.2856137-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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

From: Irina Ryapolova <irina.ryapolova@syntacore.com>

The SATP register is an SXLEN-bit read/write WARL register. It means that CSR fields are only defined
for a subset of bit encodings, but allow any value to be written while guaranteeing to return a legal
value whenever read (See riscv-privileged-20211203, SATP CSR).

For example on rv64 we are trying to write to SATP CSR val = 0x1000000000000000 (SATP_MODE = 1 - Reserved for standard use)
and after that we are trying to read SATP_CSR. We read from the SATP CSR value = 0x1000000000000000, which is not a correct
operation (return illegal value).

Signed-off-by: Irina Ryapolova <irina.ryapolova@syntacore.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240109145923.37893-1-irina.ryapolova@syntacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index cc9cef3d85..805b972f6d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1295,8 +1295,8 @@ static RISCVException read_mstatus(CPURISCVState *env, int csrno,
 
 static bool validate_vm(CPURISCVState *env, target_ulong vm)
 {
-    return (vm & 0xf) <=
-           satp_mode_max_from_map(riscv_cpu_cfg(env)->satp_mode.map);
+    uint64_t mode_supported = riscv_cpu_cfg(env)->satp_mode.map;
+    return get_field(mode_supported, (1 << vm));
 }
 
 static target_ulong legalize_mpp(CPURISCVState *env, target_ulong old_mpp,
-- 
2.44.0


