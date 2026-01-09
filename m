Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548F2D232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6Qu-0005SV-OM; Fri, 09 Jan 2026 01:57:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Py-0004Ha-D9
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:19 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Pw-0002sy-Tv
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:18 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c47ee987401so1202066a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941774; x=1768546574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fsAe4IlyePu7Wh/22qQPwxy3w2E4OsZSEQYaosoGNL0=;
 b=U/NcmQW+Dyo3kTPXqcFgvI+q4topLnKP6JXrofo9WnRlM6L1Shb2mcIK01gqf4GQ2A
 asHB0JJTzcJFcYJxkJRKU8JWD/yY8CoacyMGEon5vbIgRPr6kJiZeJHLeLU1mwOpliow
 aco+EE2jCtXzwQyenONVrM9dAQEG0sqQztAplcd6+avdAoy0/BWkZgt/IBB+LFLJvoJ1
 gkNtmv2ia0SOOWl+aDeyHkfTTS1Pt/osAnG/Wee5dHlfOcv1ZJb1L5auSxyG9NWdpWeJ
 os/0MPpDSOjbYYofgWo9sV98r2wd+tRKTUEbubfD3ENrGyclFGPG3b/N89cGKPMJAMmd
 6TPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941774; x=1768546574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fsAe4IlyePu7Wh/22qQPwxy3w2E4OsZSEQYaosoGNL0=;
 b=bEBa+IT0UBe5O43iSJNJ/+jvWrEVANI70zr9RQsCiElCXDrr2bzzT1VxuhKd5j3u3w
 8sUDiUwxq8F5nY9BpaJMYHEryI6j2hoLg8vzu4ABI0oGeZLULgEIwH79I4Aof8v7vo2J
 gP8yycgVlghfxC6Jw15rjPDcSXMi7UWXwCmUDGiMBwG29XTtgThSNoxPN8vl/cdMUwDF
 mGhN8o7tUUR85JK/vy02ApUtdONmkaPyLIDWl7c6Cm2R8K+IK8e2ZkC/jT7ZcbDMIc6D
 UV5UTGpfLYd7QqEZGLouCiFfppApiSZyYZneATjApUlOFleeO8fWfQUyxHQ9QhILRL3X
 p3fw==
X-Gm-Message-State: AOJu0YwO7jF/Ssl0EIRLM9T1eKLoOOLfL8+r41MhkSDPmshhFh5G7pZC
 Rf5FKVx+Djq6NsZoF+MR3bPfZ/PshsRPa+gEjslae0fWZUPetlImLf7hWZKxFw==
X-Gm-Gg: AY/fxX7XrPtuHfAkqQsLXRJPuk9/8nbdQtVsBpmEsF8DgXcKdlyYR4AtvHgPWNMAwoY
 jG8j12IJnrMm5SGbEj5PMMo69DFJRxqkX9gUSg0dCY9mS7WmSd+jfyRjQ0fhGpfscAiGwo1td3Y
 l7cUUy2jCI+opgnnpCxZG67In6nj3eCU6g/OX9VEjkIIhD0frPoVtkOfcH2w+0/p9agCKUeUkip
 J/2/KLp5o/mAh3wwBz6Xnlrox5Hh4HQXuhZf0pD4Rx7FgSfMJvIHRMqA95jR7QPkiofCaOXYhXE
 9nTsU6E3Yii8c3C5Tg0S7ZGAsn8q+00ubMDoSQeJ/Q4tKGuMhEpXtgFVwdiAJ2lrXqKSvW/8pjL
 TzG+bg8dLFJL+4+IZtPNXyYtoggsdKpuMKXm4s0olZapkOPMHVfrrHTu0jRrFzktnszge6JNUud
 8w9PJkueSz61znbLq4J8QYfHQt9w0Byo/ZeSnyhWEc+XhQKzElSFXvnVI0fiuPqCT2sVStXil+U
 thGywTS2pfml2cDCu0=
X-Google-Smtp-Source: AGHT+IHxcBB0/dJSPa8fGxOIAWv5iOuWAttEquhsLcfaKwSW8/l5U+0BoQG8LxtdoyBWPBoHbQsbyw==
X-Received: by 2002:a05:6a20:1591:b0:368:9449:8364 with SMTP id
 adf61e73a8af0-3898e9e72a5mr9238466637.9.1767941774122; 
 Thu, 08 Jan 2026 22:56:14 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:56:13 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PULL 20/34] hw/riscv: riscv-iommu: Don't look up DDT cache in Off
 and Bare modes
Date: Fri,  9 Jan 2026 16:54:45 +1000
Message-ID: <20260109065459.19987-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
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

From: Frank Chang <frank.chang@sifive.com>

According to the RISC-V IOMMU specification:

* When ddtp.iommu_mode is set to Off, there is no DDT look-up, and an "All
  inbound transactions disallowed" fault (cause = 256) is reported for any
  inbound transaction.

* When ddtp.iommu_mode is set to Bare, there is no DDT look-up, and the
  translated address is the same as the IOVA, unless the transaction type
  is disallowed (cause = 260).

In the current implementation, the DDT cache is incorrectly looked up
even when ddtp.iommu_mode is set to Off or Bare. This may result in
unintended cache hits.

Therefore, the DDT cache must not be looked up when ddtp.iommu_mode is
set to Off or Bare. For other modes, software is required to issue cache
invalidation commands before any inbound transactions.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Message-ID: <20251028085032.2053569-1-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 01730109c7..b46b337375 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1292,13 +1292,18 @@ static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
         .devid = devid,
         .process_id = process_id,
     };
+    unsigned mode = get_field(s->ddtp, RISCV_IOMMU_DDTP_MODE);
 
     ctx_cache = g_hash_table_ref(s->ctx_cache);
-    ctx = g_hash_table_lookup(ctx_cache, &key);
 
-    if (ctx && (ctx->tc & RISCV_IOMMU_DC_TC_V)) {
-        *ref = ctx_cache;
-        return ctx;
+    if (mode != RISCV_IOMMU_DDTP_MODE_OFF &&
+        mode != RISCV_IOMMU_DDTP_MODE_BARE) {
+        ctx = g_hash_table_lookup(ctx_cache, &key);
+
+        if (ctx && (ctx->tc & RISCV_IOMMU_DC_TC_V)) {
+            *ref = ctx_cache;
+            return ctx;
+        }
     }
 
     ctx = g_new0(RISCVIOMMUContext, 1);
-- 
2.52.0


