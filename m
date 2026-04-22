Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5593F9B60A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUey-0007W8-Vm; Wed, 22 Apr 2026 06:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUeM-0006yv-7w
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:17:43 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUeD-0002Ne-LZ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:17:36 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso20264915e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776853051; x=1777457851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gSYzG4w2krdb3nT01JqHA9xtpgh1UWf3StMYQUTc4bg=;
 b=fArmz0PbBkq28AMLdMgSbpAv/cUpBHGo4I/DAj22+KywMjndnEotuLki9TrydBg3wx
 6oQbjZ0Q1bNxDT/Ip8XE0wPNABBNb8cd1mjKOTnq/nAxGI6rI+yOUqU7fpXlEEJfZ5Ll
 kV/iHmo6R22URvemdRe9EJSKI18NdXhj3wpQLmOqnvYNfGKNvqF2hg/59iGnEnOl8kUP
 9oivF8WWIJginRd3SuRU/GkP5dy0RCXWceDhBKB2bXCCoOJ7JBIlW7q0O7ZltCYGMv23
 JSw6fqpUvlgYvXctAALT5pnE4S4EyhA8aFsEgx2TG1qyZQZsR9M1pksaz1rQD7FUTjsq
 BvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776853051; x=1777457851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gSYzG4w2krdb3nT01JqHA9xtpgh1UWf3StMYQUTc4bg=;
 b=qsZDOd1OiJAW4/s6F0H/Oa7dvXFzsLYmw+xGzOiWz4kNIJ+bcb6+f2zpFIjdiLP1ct
 eM5u1bQ6G/ZAwR6+LiFLPFljCT96aOBQMJhYjpmYJVcYG7huzEtQA5laTpfNbB8kwePu
 GawANUlaTee4nCh7NTqdjOR4/IAm4IKos11DmfEZrm0bU81emHe8vGwiTvL/w7t+5J0B
 K4f4RIt6EwTZ9IjwfVntPKYR2z84jLETl9WP+jRBya0FBJt0RwWkLxwYPhgLR2usmGA7
 WmAiW+/8tg7gF6bxxcfhSjgtvztP7Ul4T+xFsVBxfSGqNd3XVIpeD8x0TceDMx4HoMea
 6VkA==
X-Gm-Message-State: AOJu0Ywai4dw4KxvoFbNnMlQqgpfJgY+ykOIexhu1QeuV8ypto4A+LO+
 FEhuNrF3rriz1MITrCmKi9M9Bi+fkggE0eBcGwfYOO8AaFh78XUnuMAv+QcaksonLmw=
X-Gm-Gg: AeBDiesoqjK3YFs2ZyJhuDG7EIBaElJ3GpgR2qG8g9RBUqbGBu1NK8GlMuQ2nX3hFhD
 xEtvhfUniX5T2DFaHh0exB6opiq7A60rbTxDgNAHSdwG/rIm8ZsunY9iIf1yGhiVC7wEBL0v53X
 kfz7QEH9R8knzGwbge8vOhe9q51WWvrre6NIWB8RXfV2Ai9RrS+X9oJ/x2A0zTlxfOSWEWxUnUX
 8Np3gmH7eqq4pPI2Og/ERLOK5rRS6iBvldb342UCMTyhykkP5B7FmmRw0x95F1MI0AMzl4d03zL
 YxmNNbpKqJCu2HonjtpT6BHoidYLwI1R/08osEcN03Nuda8HY4JPyZLJXF6uxd5V3uchtZgSC5Z
 4yu5iFLqcSPbNJuFOGzg/AyPI/SGfW5BhdbjUdnjqf1IwFl/27FS72tZbHV7lM4zCqWW1pJa3XR
 eYSUGurpVLIHV3wte9KkkpxsgLZzSN9JGSjg==
X-Received: by 2002:a05:600c:3e1a:b0:489:1ca2:eafd with SMTP id
 5b1f17b1804b1-4891ca2ee65mr169059005e9.11.1776853050447; 
 Wed, 22 Apr 2026 03:17:30 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d5b1sm48556196f8f.30.2026.04.22.03.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:17:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CF1A4616F5;
 Wed, 22 Apr 2026 11:10:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 29/31] target/arm: implement global monitor events
Date: Wed, 22 Apr 2026 11:10:40 +0100
Message-ID: <20260422101043.1234229-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Moving from Exclusive to Open Access should generate event stream
events. Technically a non-exclusive store to any address range covered
by the global monitor should also trigger such an event but we can
only detect that after the event by seeing if memory doesn't match
cpu_exclusive_val when processing the eventual store exclusive.

The CLREX instruction has the same effect as do other operations
clearing the exclusive state (such as eret).

We special case STLR/STL (Store Release) instructions to generate
events because their use is a suggested pattern for clearing locks
that might be sleeping. We only trigger the event if we detect an
exclusive instruction is running.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - add gen_global_event_reg() and use that
  - add handling for STL/STLR
---
 target/arm/internals.h         |  1 +
 target/arm/tcg/translate.h     | 14 ++++++++++++++
 target/arm/tcg/translate-a64.c | 23 +++++++++++++++++++++++
 target/arm/tcg/translate.c     | 20 ++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 089f679ac0a..7045b4a56bd 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -709,6 +709,7 @@ static inline void arm_broadcast_event(void)
 static inline void arm_clear_exclusive(CPUARMState *env)
 {
     env->exclusive_addr = -1;
+    arm_broadcast_event();
 }
 
 /**
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 9bf2701a56b..01053060af4 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -882,6 +882,20 @@ static inline void gen_event_reg(void)
 #endif
 }
 
+/*
+ * Some events affect all PEs in the same shareability domain. In
+ * practice as we currently model SMP systems as single SoC devices so
+ * we signal them all.
+ */
+static inline void gen_global_event_reg(void)
+{
+#ifndef CONFIG_USER_ONLY
+    /* re-use the SEV helper */
+    gen_helper_sev(tcg_env);
+#endif
+}
+
+
 /*
  * Helpers for implementing sets of trans_* functions.
  * Defer the implementation of NAME to FUNC, with optional extra arguments.
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f30df5dbfed..a1b0cc9508e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2253,6 +2253,7 @@ static bool trans_CHKFEAT(DisasContext *s, arg_CHKFEAT *a)
 static bool trans_CLREX(DisasContext *s, arg_CLREX *a)
 {
     tcg_gen_movi_i64(cpu_exclusive_addr, -1);
+    gen_global_event_reg();
     return true;
 }
 
@@ -3407,6 +3408,14 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
         tcg_gen_setcond_i64(TCG_COND_NE, tmp, tmp, cpu_exclusive_val);
     }
     tcg_gen_mov_i64(cpu_reg(s, rd), tmp);
+
+    /*
+     * On a successful StoreExcl the global monitor transitions from
+     * Exclusive to Open Access and at that point generate an Event
+     * for PEs in the same memory sharing domain.
+     */
+    gen_global_event_reg();
+
     tcg_gen_br(done_label);
 
     gen_set_label(fail_label);
@@ -3544,6 +3553,7 @@ static bool trans_STLR(DisasContext *s, arg_stlr *a)
     TCGv_i64 clean_addr;
     MemOp memop;
     bool iss_sf = ldst_iss_sf(a->sz, false, false);
+    TCGLabel *skip_monitor_event = gen_new_label();
 
     /*
      * StoreLORelease is the same as Store-Release for QEMU, but
@@ -3562,6 +3572,19 @@ static bool trans_STLR(DisasContext *s, arg_stlr *a)
                                 true, a->rn != 31, memop);
     do_gpr_st(s, cpu_reg(s, a->rt), clean_addr, memop, true, a->rt,
               iss_sf, a->lasr);
+
+    /*
+     * We don't fully model the global monitor as it would be very
+     * expensive for every memory access. However in the Arm ARM "Use
+     * of Wait for Event (WFE) and Send Event (SEV) with lock" it does
+     * give the example of using STLR to clear a lock. So if a lock is
+     * active trigger the global event register so we don't deadlock
+     * while sleeping.
+     */
+    tcg_gen_brcondi_i64(TCG_COND_EQ, cpu_exclusive_addr, -1, skip_monitor_event);
+    gen_global_event_reg();
+    gen_set_label(skip_monitor_event);
+
     return true;
 }
 
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 59925151fc3..18d64620e40 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -2116,6 +2116,12 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
         tcg_gen_setcond_i32(TCG_COND_NE, t0, t0, t2);
     }
     tcg_gen_mov_i32(cpu_R[rd], t0);
+    /*
+     * On a successful StoreExcl the global monitor transitions from
+     * Exclusive to Open Access and at that point generate an Event
+     * for PEs in the same memory sharing domain.
+     */
+    gen_global_event_reg();
     tcg_gen_br(done_label);
 
     gen_set_label(fail_label);
@@ -4218,6 +4224,7 @@ static bool trans_STLEXH(DisasContext *s, arg_STREX *a)
 static bool op_stl(DisasContext *s, arg_STL *a, MemOp mop)
 {
     TCGv_i32 addr, tmp;
+    TCGLabel *skip_monitor_event;
 
     if (!ENABLE_ARCH_8) {
         return false;
@@ -4230,10 +4237,23 @@ static bool op_stl(DisasContext *s, arg_STL *a, MemOp mop)
 
     addr = load_reg(s, a->rn);
     tmp = load_reg(s, a->rt);
+    skip_monitor_event = gen_new_label();
     tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
     gen_aa32_st_i32(s, tmp, addr, get_mem_index(s), mop | MO_ALIGN);
     disas_set_da_iss(s, mop, a->rt | ISSIsAcqRel | ISSIsWrite);
 
+    /*
+     * We don't fully model the global monitor as it would be very
+     * expensive for every memory access. However in the Arm ARM "Use
+     * of Wait for Event (WFE) and Send Event (SEV) with lock" it does
+     * give the example of using STL to clear a lock. So if a lock is
+     * active trigger the global event register so we don't deadlock
+     * while sleeping.
+     */
+    tcg_gen_brcondi_i64(TCG_COND_EQ, cpu_exclusive_addr, -1, skip_monitor_event);
+    gen_global_event_reg();
+    gen_set_label(skip_monitor_event);
+
     return true;
 }
 
-- 
2.47.3


