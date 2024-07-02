Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2153FC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 18:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOiV8-0005NR-Pn; Tue, 02 Jul 2024 14:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOiV6-0005MR-5M
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:45:12 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOiV4-0008Ib-28
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:45:11 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-754d2b05db5so554138a12.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719945907; x=1720550707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oyBXc49dKIhi+M2/Wd3aKEZ1Qn/WS2CXcYu906JKbew=;
 b=kPRQDfIJTWyuivv323yihCtXF/LAyRk6D0wltAIaMNRNXIZ9GLKuplD3VvseSMkkr5
 hM9Sd+YDPS+i++EBzQIWXlSvO1Sfn/m1g72NW+HucRX3fEXs9xsEmZEPrbz2njHtK7Jb
 72W88SqimaZkDMejqMG0qlZLmRDswhz/Rh1fuUCi7DnRUxuT2JYeO/is/q4tdRvrp1eJ
 wk5a9qB1jPzq7u69JheOOK4PlELJnEoaw100CrpCUwtX56RkXdKa1L+0KmARWPG4r5jv
 rXUZbD7ZfKhdm3lB+I6wkf0YQitBs/V6TEQlV0OiLhdMq9ZdBs+pejpIGwt+iFwBe9Qg
 jG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719945907; x=1720550707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oyBXc49dKIhi+M2/Wd3aKEZ1Qn/WS2CXcYu906JKbew=;
 b=JXUVtVMBNH5cq+OEjrhsjAM2W+mWJRdmiCVwpocvlEdwdGw3OuG2uEQhgfHocbOwEy
 g7AnKM2Rwoww/2mNnPzhyfikJN4BJM236+BdkyDjWuhjhmgWLhf5jI/QsRf+sYTA/Hp2
 /cZzfX/X0eunJFV34SpqpNkr8Oko/jo/nTFPZDpuEhR0ESMWT7V+XrEQqkG/5RCsumTI
 jtFCiXsYFBalWGM/mEa8cllprXMNwY0+c7VnqCUb3hvqgWLc9w311ENOCYPr++RFx6/z
 +X8+44xyCJKMstAXsWtteit+x8rqkDZo878NFe/TERQTslY3SDiHODahdnaIYNx/RYrL
 72Hw==
X-Gm-Message-State: AOJu0YyJ6OASdEUxj4P+xXuJsBShXnfbGUqxCsOyUj+YIgbhrYSdjfuB
 VmdI3OoBtTzPRJdbyYAWEBHB24A0VxfvqgWY+1R6ME4pd+oBpff4Jnr3c/KcdEu6Btl0PDhLNwa
 D
X-Google-Smtp-Source: AGHT+IHrGsy78fuVLOJuk9MZOlOXfnbeRKuXMmgBbHZ6YxzKeg+cjGkIFm3nW8yeCznH7BW76ZMFYw==
X-Received: by 2002:a05:6a20:b2a3:b0:1be:c33b:11da with SMTP id
 adf61e73a8af0-1bef6246216mr6812640637.38.1719945906994; 
 Tue, 02 Jul 2024 11:45:06 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e8196sm9257394a91.49.2024.07.02.11.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:45:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v4 3/7] plugins: extend API to get latest memory value accessed
Date: Tue,  2 Jul 2024 11:44:44 -0700
Message-Id: <20240702184448.551705-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
References: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52a.google.com
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

This value can be accessed only during a memory callback, using
new qemu_plugin_mem_get_value function.

Returned value can be extended when QEMU will support accesses wider
than 128 bits.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1719
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2152
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h   | 32 ++++++++++++++++++++++++++++++++
 plugins/api.c                | 34 ++++++++++++++++++++++++++++++++++
 plugins/qemu-plugins.symbols |  1 +
 3 files changed, 67 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index c71c705b699..649ce89815f 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -262,6 +262,29 @@ enum qemu_plugin_mem_rw {
     QEMU_PLUGIN_MEM_RW,
 };
 
+enum qemu_plugin_mem_value_type {
+    QEMU_PLUGIN_MEM_VALUE_U8,
+    QEMU_PLUGIN_MEM_VALUE_U16,
+    QEMU_PLUGIN_MEM_VALUE_U32,
+    QEMU_PLUGIN_MEM_VALUE_U64,
+    QEMU_PLUGIN_MEM_VALUE_U128,
+};
+
+/* typedef qemu_plugin_mem_value - value accessed during a load/store */
+typedef struct {
+    enum qemu_plugin_mem_value_type type;
+    union {
+        uint8_t u8;
+        uint16_t u16;
+        uint32_t u32;
+        uint64_t u64;
+        struct {
+            uint64_t low;
+            uint64_t high;
+        } u128;
+    } data;
+} qemu_plugin_mem_value;
+
 /**
  * enum qemu_plugin_cond - condition to enable callback
  *
@@ -551,6 +574,15 @@ bool qemu_plugin_mem_is_big_endian(qemu_plugin_meminfo_t info);
 QEMU_PLUGIN_API
 bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info);
 
+/**
+ * qemu_plugin_mem_get_mem_value() - return last value loaded/stored
+ * @info: opaque memory transaction handle
+ *
+ * Returns: memory value
+ */
+QEMU_PLUGIN_API
+qemu_plugin_mem_value qemu_plugin_mem_get_value(qemu_plugin_meminfo_t info);
+
 /**
  * qemu_plugin_get_hwaddr() - return handle for memory operation
  * @info: opaque memory info structure
diff --git a/plugins/api.c b/plugins/api.c
index 2ff13d09de6..e9c07610052 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -351,6 +351,40 @@ bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info)
     return get_plugin_meminfo_rw(info) & QEMU_PLUGIN_MEM_W;
 }
 
+qemu_plugin_mem_value qemu_plugin_mem_get_value(qemu_plugin_meminfo_t info)
+{
+    uint64_t low = current_cpu->plugin_state->mem_value_low;
+    uint64_t high = current_cpu->plugin_state->mem_value_high;
+    qemu_plugin_mem_value value;
+
+    switch (qemu_plugin_mem_size_shift(info)) {
+    case 0:
+        value.type = QEMU_PLUGIN_MEM_VALUE_U8;
+        value.data.u8 = (uint8_t)low;
+        break;
+    case 1:
+        value.type = QEMU_PLUGIN_MEM_VALUE_U16;
+        value.data.u16 = (uint16_t)low;
+        break;
+    case 2:
+        value.type = QEMU_PLUGIN_MEM_VALUE_U32;
+        value.data.u32 = (uint32_t)low;
+        break;
+    case 3:
+        value.type = QEMU_PLUGIN_MEM_VALUE_U64;
+        value.data.u64 = low;
+        break;
+    case 4:
+        value.type = QEMU_PLUGIN_MEM_VALUE_U128;
+        value.data.u128.low = low;
+        value.data.u128.high = high;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return value;
+}
+
 /*
  * Virtual Memory queries
  */
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index ca773d8d9fe..eed9d8abd90 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -13,6 +13,7 @@
   qemu_plugin_insn_size;
   qemu_plugin_insn_symbol;
   qemu_plugin_insn_vaddr;
+  qemu_plugin_mem_get_value;
   qemu_plugin_mem_is_big_endian;
   qemu_plugin_mem_is_sign_extended;
   qemu_plugin_mem_is_store;
-- 
2.39.2


