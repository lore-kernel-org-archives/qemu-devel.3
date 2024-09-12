Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB814EE644C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socPn-0001Xy-3t; Thu, 12 Sep 2024 01:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPk-0001Sl-GP
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:44 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPh-000318-Lx
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:43 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7191f58054aso453216b3a.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119039; x=1726723839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zHM5wBkancr1aI05BSHOUm9WH4dpuz+OJwBW2j963mI=;
 b=bGmJaXm9nWhEicHHHxj0y9ijo4YN30xFWsqcSZqwmSRnOZR9PMPwHwlbNEYtBQtxqL
 nYqdeduSViJAAU44g7ri4sZPal2BKMc0zCC2BpHPTQ/1UFg3PYmMynyB9lAkeQgouSuE
 B/eonpTaL8ufsFQaSHUtDgIGif1Z2RrM6nTGYaKAKtIayiUFXOhdat276RIADhlqQjfU
 qAq6D6wY3MDNhUThcT5OONMqRkF1114U4WSZKxarjVaX0Ro3rmdVYTvJHGX4TWhIXRNY
 on0H4nqLeqSBo2ukWDMOxjM6eyhubCD9ZTfWbaTdxQJb75ExCs6lWq8qUB6pvEdVrKFh
 eNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119039; x=1726723839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zHM5wBkancr1aI05BSHOUm9WH4dpuz+OJwBW2j963mI=;
 b=IjOk3aKARmS/WztK3DXzS/cttgdQ8YaJWR9ULKFE+a47lOi6UEr8gDpmkme4lgfKfX
 6D7ftYWKd9S66Cz+HIz44WRPCUX9vsyg3mB8TKiXW40wUg/xi7gBzsmwMyG3SwoND0vB
 C1sKu6TL8G+VirdOgEzJ/eEaoOHIFJQLuNoa8yGdOuQeTYpdJn6tdNrHTw32zofcLOmh
 E2VKC91sXptTCO9IX/FlThZdI1qstmrvkOHTk/9hmNsOwnvGr1Mr2Ni1zYIWBI5W5SDo
 HRtNRAzwXdtTXP8j6YanVcdXiB9yPtgneE2zNyar4Mo0k/6CtdxLbN9mWer1o12pb8FK
 K27Q==
X-Gm-Message-State: AOJu0YyH5S1vI/DbxgVP2g4aZDOFdPzowbVgMvvOR0YlPQTCSiYROURg
 14z0NTZ6OLSeJLT9TGJGJ1W/YhBAY9IO5XRY3fH3tWQJ15sSODJM4PO91g==
X-Google-Smtp-Source: AGHT+IGkLYVT8qJLWOIwC1qSAqKHGHKgG4ANp0Nc+IwPKd+3UE7xq8yP9juXsYkUJkTqPZQXLIicEg==
X-Received: by 2002:a05:6a21:6e41:b0:1c3:fc87:374e with SMTP id
 adf61e73a8af0-1cf764c255bmr2035722637.41.1726119038645; 
 Wed, 11 Sep 2024 22:30:38 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:30:38 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/47] target/riscv: Add textra matching condition for the
 triggers
Date: Thu, 12 Sep 2024 15:29:18 +1000
Message-ID: <20240912052953.2552501-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42f.google.com
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

From: Alvin Chang <alvinga@andestech.com>

According to RISC-V Debug specification, the optional textra32 and
textra64 trigger CSRs can be used to configure additional matching
conditions for the triggers. For example, if the textra.MHSELECT field
is set to 4 (mcontext), this trigger will only match or fire if the low
bits of mcontext/hcontext equal textra.MHVALUE field.

This commit adds the aforementioned matching condition as common trigger
matching conditions. Currently, the only legal values of textra.MHSELECT
are 0 (ignore) and 4 (mcontext). When textra.MHSELECT is 0, we pass the
checking. When textra.MHSELECT is 4, we compare textra.MHVALUE with
mcontext CSR. The remaining fields, such as textra.SBYTEMASK,
textra.SVALUE, and textra.SSELECT, are hardwired to zero for now. Thus,
we skip checking them here.

Signed-off-by: Alvin Chang <alvinga@andestech.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240826024657.262553-3-alvinga@andestech.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/debug.h |  3 +++
 target/riscv/debug.c | 45 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index c347863578..f76b8f944a 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -131,6 +131,9 @@ enum {
 #define ITRIGGER_VU           BIT(25)
 #define ITRIGGER_VS           BIT(26)
 
+#define MHSELECT_IGNORE       0
+#define MHSELECT_MCONTEXT     4
+
 bool tdata_available(CPURISCVState *env, int tdata_index);
 
 target_ulong tselect_csr_read(CPURISCVState *env);
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index d6b4a06144..c79b51af30 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -364,11 +364,54 @@ static bool trigger_priv_match(CPURISCVState *env, trigger_type_t type,
     return false;
 }
 
+static bool trigger_textra_match(CPURISCVState *env, trigger_type_t type,
+                                 int trigger_index)
+{
+    target_ulong textra = env->tdata3[trigger_index];
+    target_ulong mhvalue, mhselect;
+
+    if (type < TRIGGER_TYPE_AD_MATCH || type > TRIGGER_TYPE_AD_MATCH6) {
+        /* textra checking is only applicable when type is 2, 3, 4, 5, or 6 */
+        return true;
+    }
+
+    switch (riscv_cpu_mxl(env)) {
+    case MXL_RV32:
+        mhvalue  = get_field(textra, TEXTRA32_MHVALUE);
+        mhselect = get_field(textra, TEXTRA32_MHSELECT);
+        break;
+    case MXL_RV64:
+    case MXL_RV128:
+        mhvalue  = get_field(textra, TEXTRA64_MHVALUE);
+        mhselect = get_field(textra, TEXTRA64_MHSELECT);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /* Check mhvalue and mhselect. */
+    switch (mhselect) {
+    case MHSELECT_IGNORE:
+        break;
+    case MHSELECT_MCONTEXT:
+        /* Match if the low bits of mcontext/hcontext equal mhvalue. */
+        if (mhvalue != env->mcontext) {
+            return false;
+        }
+        break;
+    default:
+        break;
+    }
+
+    return true;
+}
+
 /* Common matching conditions for all types of the triggers. */
 static bool trigger_common_match(CPURISCVState *env, trigger_type_t type,
                                  int trigger_index)
 {
-    return trigger_priv_match(env, type, trigger_index);
+    return trigger_priv_match(env, type, trigger_index) &&
+           trigger_textra_match(env, type, trigger_index);
 }
 
 /* type 2 trigger */
-- 
2.46.0


