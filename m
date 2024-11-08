Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCE7D5E145
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 08:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9KhK-0004iq-V8; Fri, 08 Nov 2024 03:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1t9KhI-0004i9-02
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 03:50:28 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1t9KhF-0000z4-2E
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 03:50:26 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-72041ff06a0so1529917b3a.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 00:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1731055822; x=1731660622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6BhvEdDTwvnKFeE7c/8v+kTR6bLRWZP+JTJ2ME/VWsA=;
 b=TOZn+LxP7PSdK+S0dIF9GDKnCR+6u/DfcDkN4dTeygxIYrfcgF9M2j5/bL1fAZSPKd
 Lh5cKbtldTmbFk4gMlgqD7Fqu3TstQpKwK3Z1JHft1PJyEwwRFUdT70f98ksTtJP9qa8
 bcXqZH2bOY7KB4jsvYxpag5Z1katoxUHyI166HmkuoFEEqPq9xLjn/eto0morel5mMj6
 i7u38pkDchVM6IpJ4lDmskbB/xL7sOwOzBP+rWwjxe28PoDXuDZOkTPYjeFsfVJQMnE3
 DRQWWJ88yeV09DT9LIqYcjX1vnV6nFQpeVDTC927RGRLuK1X60Ha+Q0YOtdn9v/Hw/0Z
 F9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731055822; x=1731660622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6BhvEdDTwvnKFeE7c/8v+kTR6bLRWZP+JTJ2ME/VWsA=;
 b=Ienzf+tLiXyzGy5ynspF1IfAc5hEeqHfU68M5CiN+2Xwb3oAaByhzGrdDj4dteZlcY
 Ke1mGXWlBJrj9kanDoa37Nxupa10GjzyuKkRFXBN/hyiScBEsGVXAhq761vJSiIdEXRB
 4C5OLfA0f88nouAwhlde0zwXp9ByjBnQUIy59emy298hmcmW85U+u7FEQaWfkOqYUI8y
 QO40hywr39dGTyBd5X/p7WAu4rMSqlFEHiOn+zHRbTvVY84Tsf/xIDgAnk3j31OktIje
 9g+i5Ufxra6UlJxlsXV9Gi76QBCj+8GJwSMOQfC8sMZOvWlAQmu81EeHEl912NQRayhw
 YSEA==
X-Gm-Message-State: AOJu0YybOCSw3pg04QwJay9TGqoD53hIdHmEHL+esqE4w13SPVgrh8Bl
 ddbsU7RvvOXGwEuvuPAP36/I8QptAstHKYSzzuOY7ZcQwLXY7umUFUgtU6zE0tzfDPSQIm+lcPf
 NeWJ3M/bmeBCIXLtWpkb1b9eE6J7AgU1KDFHlZKDAf4BGiGx6+gUWvrO6Rnc8oM8ZKzYK6mNURI
 ilEcrMRXNtNcayNvH60a8RS9vbboitJNpGPyg=
X-Google-Smtp-Source: AGHT+IEDO1YVmMVcIw/xJFY7ieep7e2a6NYamnsqd9G9rvcMmGAX537BxkYiQqPGGfhgY+17smNWWQ==
X-Received: by 2002:a05:6a20:7291:b0:1db:eb91:56d6 with SMTP id
 adf61e73a8af0-1dc22b57e64mr2679242637.40.1731055821871; 
 Fri, 08 Nov 2024 00:50:21 -0800 (PST)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a541da0sm5540135a91.13.2024.11.08.00.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 00:50:21 -0800 (PST)
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
Subject: [PATCH v2 3/5] target/riscv: Support hstatus[HUKTE] bit when svukte
 extension is enabled
Date: Fri,  8 Nov 2024 16:52:37 +0800
Message-Id: <20241108085239.2927152-4-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108085239.2927152-1-fea.wang@sifive.com>
References: <20241108085239.2927152-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=fea.wang@sifive.com; helo=mail-pf1-x434.google.com
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


