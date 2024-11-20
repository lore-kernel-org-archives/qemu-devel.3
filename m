Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38705D6E2CD
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 07:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDfQK-0002SH-58; Wed, 20 Nov 2024 02:46:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tDfQI-0002QS-1Q
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:46:50 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tDfQF-0006QO-A5
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:46:49 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-212776d6449so302185ad.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 23:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1732088805; x=1732693605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hvzvoO5brrLYHxKu/Ou4AE457DWwgARUuUV3MJMIxX4=;
 b=CE7XhGPkyPWyxo7xUFeq83w4NzOoXKD/epWoOPEnYxZkUkKIQMmRRqAd1+kF1msq1D
 974jgXPd7QvUKvcOo7idWEpUiOXLIlp72P4n6LaWsUpEtoLoPTO+aEuZLnfRnK3/Yu7A
 4ZwrMUWXeZl9efvU+8dVbADR/enSNPTS+Lxcdii5vKnFMB+ZryfDAIh6iNV3H41woktR
 y5YPsTAEwo+RGGsWKoVfiDBIi9rn2LrgU4OYWUwY9socBDW91FQ1k6O08kzn+bMnel6B
 EAF4pBcicsFgmUYsFcDCASWG/tumt++RCUiu8lm06AeTBdoMp46ONriZKCQ8Bc5UpfGh
 8Mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732088805; x=1732693605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hvzvoO5brrLYHxKu/Ou4AE457DWwgARUuUV3MJMIxX4=;
 b=muffz1D8kt7sEEmxoOq3gKTtEDDPDFpg5LZa8ODg/r1jmqkni4A+xuH+GGx7K1HuzP
 a83nb7rhD9vXEPFdSY0PzVJNIceC5il14jQGUtGdJuD6lKK3qQOY58fkwMqp+yRFScRp
 jMftDWWoJkAKc4txF0pKRKJ0gSQyua/z0wW0v2scOTKOaUE+Ek7cKT7zOphhZiqx0aJZ
 G5SvFivHeaQVISKkvSnkKW07bqNZ4YhZD63V7Qa2K6M2Lkce6kL+LKGo5t7DIkqAjTJQ
 lefccTFNfYbznez/1Or+0ME8DZucuwB9FLwXIpx923NL/NogP4RdX+EAndwP6rjtAMSF
 5zJg==
X-Gm-Message-State: AOJu0Yy5C19QJsQ0juxhE979DswoJvzs9PH94FjD1ENnhdn3BAksIn3y
 kCbSjQ52kBNmgP+Wr2T2XREhkIn6PfVPWDUJYQNKHSKfRgtEtTMCzf7eZrdGfjy4eQruB5UMmPb
 FzgZzYxsuId9pkr8wr4YX1wOP87pI/8zQrQlhGXTkUxoG7JmzmpPKyX2C2CyLGTSk9vC6qUhWHz
 EM6qegirnmdLmgEUKx/tO5hLg9Lr4jXUcKilc=
X-Google-Smtp-Source: AGHT+IF6nRdpWv1AfiP3UFwmy1yuIt1r9YmXhTV7T9KQcGgymz3ZFI4RY5hGtgFwo031oOrdXHOWUA==
X-Received: by 2002:a17:902:f652:b0:212:530:a65d with SMTP id
 d9443c01a7336-2126fd89c9bmr13159015ad.38.1732088804697; 
 Tue, 19 Nov 2024 23:46:44 -0800 (PST)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211d0f51fe0sm86206255ad.233.2024.11.19.23.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 23:46:44 -0800 (PST)
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
Subject: [PATCH v4 3/6] target/riscv: Support hstatus[HUKTE] bit when svukte
 extension is enabled
Date: Wed, 20 Nov 2024 15:48:51 +0800
Message-Id: <20241120074854.1767780-4-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120074854.1767780-1-fea.wang@sifive.com>
References: <20241120074854.1767780-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=fea.wang@sifive.com; helo=mail-pl1-x631.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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


