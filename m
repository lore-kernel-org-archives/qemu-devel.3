Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CFDCF3196
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsH6-0005iw-Va; Wed, 02 Oct 2024 01:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsH0-0005ek-Vw
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:44 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsGx-0004sP-Ln
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:42 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20b7259be6fso35679825ad.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848297; x=1728453097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WIhN1lfGZc49P84+ZrkBofiKW5kd04uaLJ+TIZC5yR0=;
 b=aQBRWST1b61WoNMPJAt+9oL6bY13487KEyrINAhMAZid5GFZmQteyxWbmcZ269Rtr9
 YllOMXTDohj3SjZRP0R3bo7m3M1JO4UXT2dMA3ubTg2EU3oljt7Vn2nvS221e9vSuDcb
 O2fKos8MPjjX0zn9K0i1XbCAZxFw7aJMiiE2mJNxZeE//quqYVVwm6jGPP4qXcfwMC+g
 CSJKVmNOaiUTIwo8M7FCh2twggroSThMYEicIzflb/nJJ1lgcdYpF7wH+O0iaDZHPAMq
 CP1WPVF9Jh4voODn2iAq58a6Yv2j3z6I2LUT0GXwSHw13nusbZ9+CYXo+eVqjRu4erfY
 WBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848297; x=1728453097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WIhN1lfGZc49P84+ZrkBofiKW5kd04uaLJ+TIZC5yR0=;
 b=jKqH5y6bvtK0Smk8WDvna0kQ/M17T4aLP0zZlS1YEPr6jkF9pfMvhcQxkwqEWdAw+f
 vVoijaMzq1tprHlUzMT0L1vRDLRI94A6MXsx2pPX49wIGSKr+zpaJtCh7GXJE0tjnukM
 PQJ7FzS4e78m9pHJuKsFzYPp23rSU5qUtU9jesg5PM0h7CgujbiWPe8aKFKxedH+WekW
 +rhYbCWp230qJgIxMa/3h9shEAK5xjLZNpYE901Lw7Op9opRZoivtcVYGQtpNxmWH9FB
 01PIvsi/jUqP02gYQVQ6v+Sv5jRUwgvMgO2pj+DvQSjRoMh0YkEdm43ZJNDK5ioHZRej
 9NsA==
X-Gm-Message-State: AOJu0Ywo+zu0FqiXXG4xsHm+zb3o0VhkTGcvcgYcOysaRfo2n7rClWOD
 bmnLGTLwRk4RrdxGsbeagcZuHVBS/7ygaFJxJcRw1u9zRqwuzUBhDFtBmIrp
X-Google-Smtp-Source: AGHT+IEpPxPbewHE/ibRZQgaJ6QYxmhRr3MP1GUDLDzEAp5fBygNdnlk5+lX7QDvR9Dip/J2EqeRcg==
X-Received: by 2002:a17:902:e550:b0:20b:720d:734 with SMTP id
 d9443c01a7336-20bc5a5cd06mr32410085ad.41.1727848297067; 
 Tue, 01 Oct 2024 22:51:37 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:51:36 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 13/35] target/riscv: Add textra matching condition for the
 triggers
Date: Wed,  2 Oct 2024 15:50:26 +1000
Message-ID: <20241002055048.556083-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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
2.46.2


