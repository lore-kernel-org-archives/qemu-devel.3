Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656DAD31A0D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsnV-0003tC-7n; Tue, 13 Jan 2026 23:47:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsnH-0003jx-2R
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:47:43 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsnD-0003jt-6U
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:47:41 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a0833b5aeeso82031385ad.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768366057; x=1768970857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Vzqjvo/w0Zs6QRyX8FdhDtC3HQSwAJYyNP7h20vpM8=;
 b=QiOIL8IUmhu757dA+uS+aSEKq5w4QpIk9KIwR5D19xMHx4/HQjNGS8KuyzZHpJDUKB
 zOh96t8qAI8A9K2Ao2JuotDmX3nU+5viqWxTozWJhjhvoWQIHAgXHWPZdHG0QbpNwQYM
 5NYjV/H7/3sgQcZClH+nak6JMPu8QjzX1DOQpYW9QtMgYy+xVG3U2EjzVlacEa9BB57X
 zwddhrpDLqhcbZXiwp3Cr8JwZBjKSvZAcrioetWeBw/5w1sNVhgjxzJ3U2WiIcRW0EaT
 KB3aj5bcQa7I/CVVsB92Q7iRoQvQmW2xenJifxzhiIqPOWVWVa2rA8GOaHjNRS8lvbPC
 OONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366057; x=1768970857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Vzqjvo/w0Zs6QRyX8FdhDtC3HQSwAJYyNP7h20vpM8=;
 b=oJZpbz/GM+xO605JpGGNTf5Sxj6NBoxt0cXluUBWzjO3jS9Rpr1sG43hPmg0TtHI7B
 cwxYqk5+n6yUcsOTJrpLLMbVT9qzPRC3pzx42kjto/qww7rrAm/5nfsjZP5zLR8Kr5oq
 8BM34bf29NJthlh9AWYHK25QQPArL0kwm9QIifOCnPTMq9tbEjttYSHB6VA983aU0YtH
 jHo8xdYMevM4wPVe2HarUiyvKpnQMqYu3rXnaE1BG8WXwB/p22H7rDhOjDg7rE5Zqnji
 xMvrWUwJlWlG305UGADqNmePkYevA0GP6WFAgHcvqVrFH6HquElqmuLvcle4yB0IT1md
 YbNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpEuME11gmWO8J2E6KBJcgxZh0ZbpptBZnx2zmQDYH+93SEmzQZuiQvVV9V1FhAN/p0I/pySS1pes5@nongnu.org
X-Gm-Message-State: AOJu0YxHc74nZwdmHgrl7c4a3rXFP21XGmeqY4u5TglCcxA08AwSIXat
 Cq73TOnxLIOmitm4GgN4UMGkN8Os0Er1I6r6GIYcA7SduCfE1z2kxEUf
X-Gm-Gg: AY/fxX7jVsEDFPhwchrRHGQIbusu4chUgROF1EtNqa5uEdssO88+FjMmQFtpO02XOQ5
 r8/B9IWJk9Es0+Gbs0jVqMIku3zxRM9el84/VMUmy8t8xM99HOen4unYQSfGhnJpUogNmGPj+F3
 YvkK4QeLAZdcO37G/f8MQh99URAzMhw+A8DIjn3wEr2WfoBNG/jpi2eBsahw+KLZbKiDUCZkPc1
 wod37UqTnKkZnl1nRrYzPyqFjuZxaB2SvPtKX6RAnzGTG5M8s8ERcKOUTaR/34+lHRdO5iSbw/k
 n8S2S1BD2PFXrwNzUaup9MyBx2KVUh4TGbuZFOBWgRKsnOcGETjZ5pWztMkJcw/3fGlSiuvQYLP
 Q1etCbc9WPNcbV6bbsCy2XE8BHXS6fowQyOTQvJi80JaNQZ6xEp1R/l61o7//TwwO1GK9fRc+la
 XxaUQJTeaTuI4jdn7splBExrkPoZ1XOxJLT9QqX+spl95EC6Db+sVvr14JLxH3EKLGFlzqfw==
X-Received: by 2002:a17:903:2f8a:b0:26c:2e56:ec27 with SMTP id
 d9443c01a7336-2a599daabf5mr15329815ad.19.1768366057258; 
 Tue, 13 Jan 2026 20:47:37 -0800 (PST)
Received: from lima-default (123.253.188.110.qld.leaptel.network.
 [123.253.188.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49037sm216111905ad.36.2026.01.13.20.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:47:36 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
Subject: [RFC PATCH 03/25] target/riscv/debug: Implement permissive type
 unavailable trigger
Date: Wed, 14 Jan 2026 14:46:36 +1000
Message-ID: <20260114044701.1173347-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When a trigger type is "disabled", tdata2 and tdata3 must accept values
that are valid for some supported trigger type. Additionally, writing 0
to tdata1 must result in the type becoming "disabled". This is important
for the prescribed sequences for updating triggers.

Implement write tdata=0 -> disabled behaviour and permissive accepting
of tdata2/3 values in disabled state. This implementation could be
improved by checking tdata2/3 values against supported trigger types,
but it is good enough to be usable by software.

From the RISC-V Debug Specification for tdata1:

  Writing 0 to this register must result in a trigger that is disabled.
  If this trigger supports multiple types, then the hardware should
  disable it by changing type to 15.

and, when type=15:

  This trigger is disabled. In this state, tdata2 and tdata3 can be
  written with any value that is supported for any of the types this
  trigger implements.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/debug.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 2190c25f23..c92bd9860e 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -827,6 +827,28 @@ static void itrigger_reg_write(CPURISCVState *env, target_ulong index,
     }
 }
 
+static void anytype_reg_write(CPURISCVState *env, target_ulong index,
+                              int tdata_index, target_ulong val)
+{
+    /*
+     * This should check the value is valid for at least one of the supported
+     * trigger types.
+     */
+    switch (tdata_index) {
+    case TDATA1:
+        env->tdata1[env->trigger_cur] = val;
+        break;
+    case TDATA2:
+        env->tdata2[env->trigger_cur] = val;
+        break;
+    case TDATA3:
+        env->tdata3[env->trigger_cur] = val;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static int itrigger_get_adjust_count(CPURISCVState *env)
 {
     int count = itrigger_get_count(env, env->trigger_cur), executed;
@@ -883,6 +905,10 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
     }
 
     if (tdata_index == TDATA1) {
+        if (val == 0) {
+            /* special case, writing 0 results in disabled trigger */
+            val = build_tdata1(env, TRIGGER_TYPE_UNAVAIL, 0, 0);
+        }
         trigger_type = extract_trigger_type(env, val);
     }
 
@@ -897,6 +923,9 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
         itrigger_reg_write(env, env->trigger_cur, tdata_index, val);
         check_itrigger = true;
         break;
+    case TRIGGER_TYPE_UNAVAIL:
+        anytype_reg_write(env, env->trigger_cur, tdata_index, val);
+        break;
     case TRIGGER_TYPE_INT:
     case TRIGGER_TYPE_EXCP:
     case TRIGGER_TYPE_EXT_SRC:
@@ -904,7 +933,6 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
                       trigger_type);
         break;
     case TRIGGER_TYPE_NO_EXIST:
-    case TRIGGER_TYPE_UNAVAIL:
         qemu_log_mask(LOG_GUEST_ERROR, "trigger type: %d does not exit\n",
                       trigger_type);
         break;
-- 
2.51.0


