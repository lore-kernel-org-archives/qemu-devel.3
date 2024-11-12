Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B9BD41D71
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 09:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAmwm-0007dI-QW; Tue, 12 Nov 2024 04:12:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tAmwX-0007XU-TJ
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 04:12:17 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tAmwV-0007ki-TI
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 04:12:13 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2e9b55b83d2so3075839a91.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 01:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1731402730; x=1732007530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ta9zlJxceH6xvI0lTGE/GAG3tOR+/5oYHysvex7gkPA=;
 b=MNxk4F2sYqAUGV/7tdIYEfAl8Mm3QZMJEIjVSWg3UB2pDJyVwyqrMXJudc4CytwyHd
 EQD1NnK9L/WT+o0VPOtBLjXzI6ifLb0XTIe1RoQSczaB75At+GKZLIuZUXfnJ6WVkb6K
 ZTNat1b20M8QM9xd4RWviWNu2kQe2AUzM3I9QkAqHqqa7CaCYWsw7xSugINJ5ImVkOAz
 Logveqlak7nle9B28C0Z4dWoBnG8dee6HjTmvf0Jpu62Svhz4FJTA9OW3DHl4MwfLsme
 M0/ZAWgzjDnlNDNQSnSFaVd0aiqnUbgZ3WUo9LYf2RafopAdcx4NFoJHSdmRl0+B4XJ5
 kVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731402730; x=1732007530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ta9zlJxceH6xvI0lTGE/GAG3tOR+/5oYHysvex7gkPA=;
 b=ZUEcpwGQbjRnnVy9STr8qlDoYOmgbt8ZtKZ2nJHVKIGYSqEHysop6AUVyrHViu+HIS
 UDW4VBVedRykNS03/9vXN7yd5GnK1Bdh52Gr3Yea6PczunuoEwuR5ZU7JhnuwX8+eUJG
 B6yfSfN/xHdb2s9iqIdMikqQo8u1MNHkCVYCBoLapXrzgECEHqyrGJ3oyodPuk4ZRaUA
 IqiP3uNn6GptnAEOAB7D1yA5v4FznV+xIHvBXPRFPEWP8nejfgHf4CO0oNvsutc+dbt6
 15MxvUqOFTnhYdRVSHztszclU2gWCFkcnYXmIYoIApis02FxifrEytNjyw7wQroLzYUQ
 NVSg==
X-Gm-Message-State: AOJu0Yy6/LYTiPuFuz6kFVnP1+wC+EPWUNT72JTOBYL42jVIdqIF6U5R
 dRg9kpEXaG8F44vLbkQ++8B9TaG9TYBpvvNhxP44vjUCY8hd+k5YL4P8rNn345NqkhVts6nE+QN
 IhGa8IEAaRkpjWPwdQhi1Nwzdnp28B6Wy/Ehl0z5qlc/vU0UjdVR4xc2UeJNDHRk6wMnYIZWX5X
 wqX8v87Pr5+igmSAXalUALm0hnHRcmF/M99Rk=
X-Google-Smtp-Source: AGHT+IGG6YUoo8cyGL2W+pkYbQX+8vHpSZ5U0MkHdyeX1Fb1XCMofv8St8FOawzptzLBPVC6scLKPw==
X-Received: by 2002:a17:90b:3d09:b0:2da:8e9b:f37b with SMTP id
 98e67ed59e1d1-2e9b172af1fmr19875487a91.24.1731402729920; 
 Tue, 12 Nov 2024 01:12:09 -0800 (PST)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a4f6c96sm13495347a91.2.2024.11.12.01.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 01:12:09 -0800 (PST)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v3 3/5] target/riscv: Support hstatus[HUKTE] bit when svukte
 extension is enabled
Date: Tue, 12 Nov 2024 17:14:21 +0800
Message-Id: <20241112091423.2529583-4-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112091423.2529583-1-fea.wang@sifive.com>
References: <20241112091423.2529583-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=fea.wang@sifive.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Svukte extension add HUKTE bit, bit[24] in hstatus CSR. The written
value will be masked when the svukte extension is not enabled.

When hstatus[HUKTE] bit is set, HLV/HLVX/HSV work in the U-mode should
do svukte check.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu_bits.h | 1 +
 target/riscv/csr.c      | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 4b9f899217..fe4e34c64a 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -604,6 +604,7 @@ typedef enum {
 #define HSTATUS_VTVM         0x00100000
 #define HSTATUS_VTW          0x00200000
 #define HSTATUS_VTSR         0x00400000
+#define HSTATUS_HUKTE        0x01000000
 #define HSTATUS_VSXL         0x300000000
 
 #define HSTATUS32_WPRI       0xFF8FF87E
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 1936a6f32a..b6fa8ae53f 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3540,6 +3540,9 @@ static RISCVException read_hstatus(CPURISCVState *env, int csrno,
 static RISCVException write_hstatus(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
+    if (!env_archcpu(env)->cfg.ext_svukte) {
+        val = val & (~HSTATUS_HUKTE);
+    }
     env->hstatus = val;
     if (riscv_cpu_mxl(env) != MXL_RV32 && get_field(val, HSTATUS_VSXL) != 2) {
         qemu_log_mask(LOG_UNIMP,
-- 
2.34.1


