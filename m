Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A766BC79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MLQ-0005Qy-OL; Fri, 04 Sep 2026 01:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLP-0005QM-Qg
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:07 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLO-0001En-Ad
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:07 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c9e7391839cso753060a12.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499205; x=1789104005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zqeUT8ZFAO/v+rzJxnSQMo5G2XZRH8NwN23fo7D3gmQ=;
 b=TiK0VFWM7he+oV+3d9A8pPrO+XlqwyyyjKwhuT4kzjgPTl3kE03O/LxE7TLrvwtqaV
 Z2rc+4SnIFnDJxffPdYoPuE2G9OAUcPooDKhhbmz0Irk+V00okw/pfcVOwI2kNUlw+3C
 FE6UlcadZeY1EX0UReKtq4imK6u3nN8uLlllECnfnBsrIs8VGGChl0AtciIQIJDYLuvi
 mjUMgOBkiDBuZX5W3hzk8+ECF+TguB52oqGuUrujEEe37xAydSOzDZzp+qAswP5HcKZo
 +GQAxteO1UtSNilHcwt3KFQtIevPSh0bPYnyaAjOjXHITVCoqV9ICDBmk1EI2dJkUAeu
 99+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499205; x=1789104005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zqeUT8ZFAO/v+rzJxnSQMo5G2XZRH8NwN23fo7D3gmQ=;
 b=ZwRN1coNHD3cMUmp4dSg6jL23PbjqJxR65dXuFcnJUb1g6aHZsFxQGvqBVi+MkPJGQ
 ys7fJ/0Eh1MTr7MyMu4uePKdhBkB3U8CRPqTbrHKClJ+2Jqk3X42juee6rupE6JqAbVu
 2+TsVCBV8Cmryfq76ubGW7/Mp/j7f/hEgU6uZs1TsyPla1qXxQUJX365H3iq/euO6BoI
 KgU/jvVjIdgmOVIoKfRcZDpGs0Wuj3hDsRE7hMMbPXqWdW+5lfVO3v2BF/RsgeQ1hn5N
 OroZis08HBOVJ+/Fg7a1G8+cMN8XKErhHHA2IWGDXU0L3F5RETdnvHX+BtpmNpy4fjiQ
 9vVQ==
X-Gm-Message-State: AFuF++nI37Z4p4G87kcFve5Mp+/lK6zF/uGrxaS8Vrf9U+a5coz8h1o/
 sU6GIrKqhvnYb8FrJ9upyhyVhp5vHR0VeNRCCHs3zVWBkrLJpHF5krBHTW3ClA==
X-Gm-Gg: AYBFou3QWURTmFBHThOQMyhF3+EmnjG1tRaWBdL9we1W87y4346iKzDKj0H56rKazq5
 npMW7Zvr4TeICv+ug7muJaDVc2dZST8PTfuF6hc+Ll29q8BQcWP2k3eU8/LUEXhrYizkCa5lKhM
 KjMquGzHh5mzk7ysFrCLynMjI2Bx+FuvyzU6DJE03TmiGe31imOHqzFVQ3opZX5FqDUkgVamQfN
 PSiMtnYaPp5MzkYZL6YUFMKdszq0CcOL38NIuK8o9Rl3qQO4D1fAYfpiEGIPu41prCva8xXWsWC
 iuL0nQqGC1gewjdmlBa52cu5LaaZX4xWOnbZ2e2e4CA8gasaYC8HGZc3A04uwJSwamByNrh25a2
 0vlUkubys4Ug0iykA2KALgXHmaugKIteUBJY3yb/B9z0+6PY4eGmEEmtcFvpJhO7KhlzIA66eLi
 yXQIpO9OOnlbbCOoPJ+D2vQ7ldgIR/R9HzJsk9ZWfifPJN6b/twXbNWBTgbHN5NX80zBEEe0ie5
 gLafQ==
X-Received: by 2002:a05:6a20:430f:b0:3d1:9166:5c68 with SMTP id
 adf61e73a8af0-3da39ee15fdmr4419118637.8.1788499204824; 
 Thu, 03 Sep 2026 22:20:04 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:20:04 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/47] target/riscv/tcg/debug: set tinfo version if sdtrig
 enabled
Date: Fri,  4 Sep 2026 15:19:00 +1000
Message-ID: <20260904051943.799041-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x530.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Set 'version' to 1 if we're running Debug 1.0.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260805182506.2943757-5-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/debug.h |  3 +++
 target/riscv/tcg/debug.c | 11 ++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/target/riscv/tcg/debug.h b/target/riscv/tcg/debug.h
index eb635bc277..fcd92b768c 100644
--- a/target/riscv/tcg/debug.h
+++ b/target/riscv/tcg/debug.h
@@ -45,6 +45,9 @@ typedef enum {
     TRIGGER_TYPE_NUM
 } trigger_type_t;
 
+#define TINFO_VERSION_OFFSET 24
+#define TINFO_VERSION_LEN     8
+
 /* actions */
 typedef enum {
     DBG_ACTION_NONE = -1,           /* sentinel value */
diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 9b2e5b19d8..148201f3cb 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -957,9 +957,14 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
 
 target_ulong tinfo_csr_read(CPURISCVState *env)
 {
-    /* assume all triggers support the same types of triggers */
-    return BIT(TRIGGER_TYPE_AD_MATCH) |
-           BIT(TRIGGER_TYPE_AD_MATCH6);
+    target_ulong val = BIT(TRIGGER_TYPE_AD_MATCH) |
+                       BIT(TRIGGER_TYPE_AD_MATCH6);
+
+    if (debug_trigger_version_1_0(env)) {
+        val = deposit64(val, TINFO_VERSION_OFFSET, TINFO_VERSION_LEN, 1);
+    }
+
+    return val;
 }
 
 void riscv_cpu_debug_excp_handler(CPUState *cs)
-- 
2.55.0


