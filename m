Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4C1CD1280
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp613-0005BP-OC; Tue, 26 Mar 2024 08:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rp612-0005A5-BS
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:34:56 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rp610-0000e1-Bo
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:34:55 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d4a8bddc21so73417131fa.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 05:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711456492; x=1712061292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJYNwNm35V5xzu7ic8glr0yVgOLlUO7V69uiN6b/dLQ=;
 b=ImwtXejocYwY03ztl7PcvG+qWx+9sEyjnBtmkQf8mNh782mcjxhbgXY2ToKGqTqyD9
 cGDO1Rv9/jtZe++yvJpMy3tCF56yc7XNL5UMsSNsIhte2cGk8HgRJiq29hQRLdVwa6xm
 iWbz+0Y96kxDPiuwHBFIHxT8AwE/6nD6rsbjJabU+ucfQhr5C+V5OCz7ImbhzfDv5wW7
 9/9q0OPBvYTgykZESz4Ul/cXNV5b0xqmtpbiePC2zoey2W8Y8fm3w79D2ePhgIHmMeeH
 7BK+x9lagdCHTaYogRt9CcQVuLVN7HGW5H4ZKALi5ml52vIV76t8Wzul+Wzz0HGdZ85s
 QLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711456492; x=1712061292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IJYNwNm35V5xzu7ic8glr0yVgOLlUO7V69uiN6b/dLQ=;
 b=kr2YIqhmGvd/xu35X1ALH6m2LPaWw4TZet55Aw85hPczBR5iOEr5v1XlF45rry/4QJ
 KtyIfczqgc+BLf45FuSwMnFR38U/MOCS/E4PpBE/zuCmz1VgSeRBoHQf9F2OCgjGnyCB
 bbyhv+n4cyKa4dGk/smJ+MJa20L1oSuCNTUn+eb0LFrqIeyo6JT6kEaeldOBbdTqOR4/
 N+Djn74udXwmDmTnfXklAllU8+n1W2asaplx8a6AijX6TjgiINg82b33GWZT3KLR4s1o
 yBz+IzGymkC6rRcoxGPLIiM2DMpIxGo5pgr8PnTy+j5Ys3D6XFt1HAJE+kbUJAvIXWJp
 kGmA==
X-Gm-Message-State: AOJu0Yy/nbiLhxRKyzbncQuFN2q/Ej49WrwWng10ggNSqnr23mSYWEGr
 PMUss9dCvh8zzy9GaUkNTf4daJsQ9JGfddRHXX8PF5YbngfCfoabeKy1UdQl0Eo+G8TcXpOqz12
 XcEc=
X-Google-Smtp-Source: AGHT+IFF+q4pH2dp2GsZ2JARo/2j7Re9ePv1UenxaKmnmjeL/SoIw3pZ+/ICTHBVBikr0xeTX4YDSA==
X-Received: by 2002:a2e:9c95:0:b0:2d2:b506:d2cb with SMTP id
 x21-20020a2e9c95000000b002d2b506d2cbmr7372056lji.9.1711456491775; 
 Tue, 26 Mar 2024 05:34:51 -0700 (PDT)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 y19-20020a1c4b13000000b004148090cf85sm716317wma.0.2024.03.26.05.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 05:34:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 3/9] plugins: add new inline op STORE_U64
Date: Tue, 26 Mar 2024 16:34:20 +0400
Message-Id: <20240326123426.761473-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326123426.761473-1-pierrick.bouvier@linaro.org>
References: <20240326123426.761473-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lj1-x22a.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/plugin.h      |  1 +
 include/qemu/qemu-plugin.h |  4 ++--
 accel/tcg/plugin-gen.c     | 13 +++++++++++++
 plugins/core.c             |  6 ++++++
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 23271fbe36a..d1d9b4490df 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -69,6 +69,7 @@ enum plugin_dyn_cb_type {
     PLUGIN_CB_REGULAR,
     PLUGIN_CB_MEM_REGULAR,
     PLUGIN_CB_INLINE_ADD_U64,
+    PLUGIN_CB_INLINE_STORE_U64,
 };
 
 /*
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 4fc6c3739b2..c5cac897a0b 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -305,12 +305,12 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
  * enum qemu_plugin_op - describes an inline op
  *
  * @QEMU_PLUGIN_INLINE_ADD_U64: add an immediate value uint64_t
- *
- * Note: currently only a single inline op is supported.
+ * @QEMU_PLUGIN_INLINE_STORE_U64: store an immediate value uint64_t
  */
 
 enum qemu_plugin_op {
     QEMU_PLUGIN_INLINE_ADD_U64,
+    QEMU_PLUGIN_INLINE_STORE_U64,
 };
 
 /**
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index d3667203546..1cfd7908df1 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -152,6 +152,16 @@ static void gen_inline_add_u64_cb(struct qemu_plugin_dyn_cb *cb)
     tcg_temp_free_ptr(ptr);
 }
 
+static void gen_inline_store_u64_cb(struct qemu_plugin_dyn_cb *cb)
+{
+    TCGv_ptr ptr = gen_plugin_u64_ptr(cb->inline_insn.entry);
+    TCGv_i64 val = tcg_constant_i64(cb->inline_insn.imm);
+
+    tcg_gen_st_i64(val, ptr, 0);
+
+    tcg_temp_free_ptr(ptr);
+}
+
 static void gen_mem_cb(struct qemu_plugin_dyn_cb *cb,
                        qemu_plugin_meminfo_t meminfo, TCGv_i64 addr)
 {
@@ -177,6 +187,9 @@ static void inject_cb(struct qemu_plugin_dyn_cb *cb)
     case PLUGIN_CB_INLINE_ADD_U64:
         gen_inline_add_u64_cb(cb);
         break;
+    case PLUGIN_CB_INLINE_STORE_U64:
+        gen_inline_store_u64_cb(cb);
+        break;
     default:
         g_assert_not_reached();
     }
diff --git a/plugins/core.c b/plugins/core.c
index a8557b54ff7..e1bf0dc3717 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -321,6 +321,8 @@ static enum plugin_dyn_cb_type op_to_cb_type(enum qemu_plugin_op op)
     switch (op) {
     case QEMU_PLUGIN_INLINE_ADD_U64:
         return PLUGIN_CB_INLINE_ADD_U64;
+    case QEMU_PLUGIN_INLINE_STORE_U64:
+        return PLUGIN_CB_INLINE_STORE_U64;
     default:
         g_assert_not_reached();
     }
@@ -535,6 +537,9 @@ void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index)
     case QEMU_PLUGIN_INLINE_ADD_U64:
         *val += cb->inline_insn.imm;
         break;
+    case QEMU_PLUGIN_INLINE_STORE_U64:
+        *val = cb->inline_insn.imm;
+        break;
     default:
         g_assert_not_reached();
     }
@@ -562,6 +567,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                                    vaddr, cb->userp);
             break;
         case PLUGIN_CB_INLINE_ADD_U64:
+        case PLUGIN_CB_INLINE_STORE_U64:
             exec_inline_op(cb, cpu->cpu_index);
             break;
         default:
-- 
2.39.2


