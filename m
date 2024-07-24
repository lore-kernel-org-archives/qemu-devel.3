Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA815C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 19:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWhxY-0002Q8-C0; Wed, 24 Jul 2024 15:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sWhxR-0002MR-Nv
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 15:47:30 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sWhxP-0006EC-C0
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 15:47:29 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70d138e06e3so150595b3a.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 12:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721850439; x=1722455239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pjRe9WOOgnZVoD/80IX7JyvW7Ap72zwjrzdwxvANZMw=;
 b=ukeOWWTzcfFJNFLZpydNYX0A92mv9f0pugHQf+NEw8PEXH4OlNtrkvuaEfUyk0Trhe
 u5DFpe86jTkBilpjBWS49WTJxYtOD/bzPUKmcIfeqkfdGu8RxhEIidUvqoiSWctNjwF8
 UlqhzSxKG4nUocT1CqGY2hF5WpwzwNvRXPIFxDFtkqJZBnvzMooTE0iTtjlZiMHMWFm+
 mZ32/ijThYL8DQWBs4TbI/CrW8wrqHpLF93/E+2baD9PulmFQuJ4QVui9XIORNzCaDS1
 ZQOBNWFJVZvm+OeRNmQsBtixJO5UgQ95cDT23lgK5LfvixcJDmbFS3D0GDCplQzVHRy9
 9aoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721850439; x=1722455239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pjRe9WOOgnZVoD/80IX7JyvW7Ap72zwjrzdwxvANZMw=;
 b=T0mQUOvPutUqQZdti4YJHkKaDykaQciGInFFZWdeuZWjRnxSTAoDcoiTBtUyznof2i
 GjrWfjTeh3aJQa6/G5xsj3uCvlA6JcJjh87S2QOiQ39A6LAujunQotOobSAiUqs3joiI
 jY7GOU4CBrSMrUu+j20sEMABUCRyCsYTx1Ecg2piV73JyyKvarInnP7y/uLuMOj4crF+
 9sz9G2BZM6L34hnd95Rrwd31z/kV8x/xE3kPBuAMnmmIsaBK/ODxJb/88xGUwA8VorAl
 bUEknAfq+yOEHo8I7H9Plix6BqaHRu0l+FqR9UPxIA+BiUkOPAqf6EH/HU3bR+HzwjL+
 ypwg==
X-Gm-Message-State: AOJu0Yy18oL0j2Q0ABkWojTpVmm3Q+VORkamzlEAFLOUwJhZK+/thkOu
 HIPXTUHvutmbhlPVsudZhq1AHG+iZV6Ox7FDbylJtA41qJXACRpgeo9+WxW2sBH47dZo3mMi2EA
 CaIg=
X-Google-Smtp-Source: AGHT+IG0fwoSiqGaW9ooLLXBgjANCAI3vidxSwkvBD+PUCbcCnRGfr554280xCxxVR9UH4Q2hA5ghg==
X-Received: by 2002:a05:6a20:12c4:b0:1c3:ea21:dc31 with SMTP id
 adf61e73a8af0-1c4732d0562mr1086504637.42.1721850439626; 
 Wed, 24 Jul 2024 12:47:19 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d19c52a62sm6339116b3a.124.2024.07.24.12.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 12:47:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>, Zhao Liu <zhao1.liu@intel.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v7 2/6] plugins: extend API to get latest memory value accessed
Date: Wed, 24 Jul 2024 12:47:04 -0700
Message-Id: <20240724194708.1843704-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240724194708.1843704-1-pierrick.bouvier@linaro.org>
References: <20240724194708.1843704-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h   | 32 ++++++++++++++++++++++++++++++++
 plugins/api.c                | 33 +++++++++++++++++++++++++++++++++
 plugins/qemu-plugins.symbols |  1 +
 3 files changed, 66 insertions(+)

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
index 2ff13d09de6..3316d4a04d4 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -351,6 +351,39 @@ bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info)
     return get_plugin_meminfo_rw(info) & QEMU_PLUGIN_MEM_W;
 }
 
+qemu_plugin_mem_value qemu_plugin_mem_get_value(qemu_plugin_meminfo_t info)
+{
+    uint64_t low = current_cpu->neg.plugin_mem_value_low;
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
+        value.data.u128.high = current_cpu->neg.plugin_mem_value_high;
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


