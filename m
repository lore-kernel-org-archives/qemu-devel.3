Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CEAC04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 21:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2dmL-0008MH-KU; Thu, 02 May 2024 17:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2dmJ-0008Kp-63
 for qemu-devel@nongnu.org; Thu, 02 May 2024 17:15:43 -0400
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2dmH-0002oG-I4
 for qemu-devel@nongnu.org; Thu, 02 May 2024 17:15:42 -0400
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-36c6df3d735so7878815ab.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 14:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714684538; x=1715289338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lezV6qv69drq1uwqg+MI9PV30u+2tX2GZliG5Wjhny0=;
 b=ExzrTTe23mhpyP1WugmdV1I09RNPEKuMj4qAk+Gmq2uMr2yEdHqBKjfM6HDYrqAkhC
 se8szTQ7Adn7W1DyjURys6wk8GEieFURg+li8y7JL2PrrmSVmgf4ohGsutP42Iqq2ptJ
 qJjeA+VL8kl+N24XBYy2uI3pcT+wKK1Qz660+axOiwEVdoDUAgoDKAjWuMODWAZ6Xv9C
 TaEmz8WQouAaelQ9zhv3hyip9Ua8cLyJiGsFSHmPl/rlccjPigJr7LoRXFSW1UJ2XQ44
 2e+MAQhz5Q2pUwjnWsh9qT+ouCH0Q6h9vDMl7pBAUbF1Mbt7SJ1dnOr5li0JWmZtgGTE
 U46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714684538; x=1715289338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lezV6qv69drq1uwqg+MI9PV30u+2tX2GZliG5Wjhny0=;
 b=Mlr4DeWCd6LU+kUitxl6tY7mvRykepA891s+9hQU8rjkC2gXitZW7aIR1kcuWT3ZTW
 N6lHBUJuREIyyay+aV5wisbkulmYTVbmV8AweVkASIOYH8blxbil/X0QSgNTTxdmmvgX
 STk4PbQ990e2S22JI1cdQHXmpE7r7BCTso09CXDg8hetWmxIonPj/qmEgsauvzEw69Eg
 3JZbQUUAap9XIp8TCEc2XPGNXIcijMFotA1Kxbyzq+BGw0ii57UYPn962ZzYsxFubrcG
 EUJ/fMpE2jWvRjOB+MdYB3mNmM64BjVvckHBwXzqSafE9F9wOQFIoTqVfTCg7ZDt7LeA
 V4Nw==
X-Gm-Message-State: AOJu0YwQaV5a/NxabXWg8De881XPq8x1rxZD+Ovyk9NY063RitbP7xUM
 NHvBB3w9t26WOWpTgYQ7hcgYhGI6Ve5LKl4bbIWWzP2c4DqvKu0856dKvGKDCDyfW1LfpNONSzD
 2aeM=
X-Google-Smtp-Source: AGHT+IGaEY+LNUDC2ItS5Eri7rVaCq/ldkDxIIuHg39WlMp4KWdNDtPd1H7ChLkm3leNNl1TdWsBvw==
X-Received: by 2002:a05:6e02:1aa2:b0:36c:4f8f:d01e with SMTP id
 l2-20020a056e021aa200b0036c4f8fd01emr1040420ilv.19.1714684538376; 
 Thu, 02 May 2024 14:15:38 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::ecd0])
 by smtp.gmail.com with ESMTPSA id
 d14-20020a63f24e000000b0060063c4be3bsm1700915pgk.14.2024.05.02.14.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 14:15:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v6 2/9] plugins: extract generate ptr for qemu_plugin_u64
Date: Thu,  2 May 2024 14:15:15 -0700
Message-Id: <20240502211522.346467-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240502211522.346467-1-pierrick.bouvier@linaro.org>
References: <20240502211522.346467-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-il1-x134.google.com
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

Plugin operations can access a scoreboard. This function factorizes code
generation for accessing entry associated to a given vcpu.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/plugin-gen.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 8028ae76c3a..8e2c3ef94f6 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -113,24 +113,33 @@ static void gen_udata_cb(struct qemu_plugin_dyn_cb *cb)
     tcg_temp_free_i32(cpu_index);
 }
 
-static void gen_inline_add_u64_cb(struct qemu_plugin_dyn_cb *cb)
+static TCGv_ptr gen_plugin_u64_ptr(qemu_plugin_u64 entry)
 {
-    GArray *arr = cb->inline_insn.entry.score->data;
-    size_t offset = cb->inline_insn.entry.offset;
-    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
-    TCGv_i64 val = tcg_temp_ebb_new_i64();
     TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
 
+    GArray *arr = entry.score->data;
+    char *base_ptr = arr->data + entry.offset;
+    size_t entry_size = g_array_get_element_size(arr);
+
+    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
     tcg_gen_ld_i32(cpu_index, tcg_env,
                    -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
-    tcg_gen_muli_i32(cpu_index, cpu_index, g_array_get_element_size(arr));
+    tcg_gen_muli_i32(cpu_index, cpu_index, entry_size);
     tcg_gen_ext_i32_ptr(ptr, cpu_index);
     tcg_temp_free_i32(cpu_index);
+    tcg_gen_addi_ptr(ptr, ptr, (intptr_t) base_ptr);
 
-    tcg_gen_addi_ptr(ptr, ptr, (intptr_t)arr->data);
-    tcg_gen_ld_i64(val, ptr, offset);
+    return ptr;
+}
+
+static void gen_inline_add_u64_cb(struct qemu_plugin_dyn_cb *cb)
+{
+    TCGv_ptr ptr = gen_plugin_u64_ptr(cb->inline_insn.entry);
+    TCGv_i64 val = tcg_temp_ebb_new_i64();
+
+    tcg_gen_ld_i64(val, ptr, 0);
     tcg_gen_addi_i64(val, val, cb->inline_insn.imm);
-    tcg_gen_st_i64(val, ptr, offset);
+    tcg_gen_st_i64(val, ptr, 0);
 
     tcg_temp_free_i64(val);
     tcg_temp_free_ptr(ptr);
-- 
2.39.2


