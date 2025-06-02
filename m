Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC6BC5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 06:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLyZl-000713-4P; Mon, 02 Jun 2025 02:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLyLP-0006dC-Th
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 02:08:41 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLyLN-00026L-MP
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 02:08:23 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-73972a54919so3348759b3a.3
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 23:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748844500; x=1749449300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TL3Io6uv1wYqEJLOSkdLO7yEUmLjlnt6GTg1df0N+1g=;
 b=W7IVue+nkS4m2CTbfOnInLZnZIu4lOaMkz6y66TaRUuyxNMTjV2lOU6yB7pN9bx8+7
 JT3Ftga3qvMaOE/LfvXxYEfGR5xjBz6Zlh2LwIH4No0+hdX/pet2qkB2/lZmZrd0akbz
 1c4VCZstghzB/dI9+Bjhd3S4E2Xma3YWnG6CtJQS77NWgH+PIuutSAVNLQBZ7Vr/lbMw
 Qp+HwTzBSMyuc5CVg9EITLU9AhEfGD6hpuFOGB86eSF/8ZzrQDIE1PAJNKC0xIrbGfgi
 Xcn5X1Iu2JclJG4/LZaiMueiVcIWLpEGH18BAbzR2VU9oyh0jyEu7WVwM2xbx+XInRQA
 +bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748844500; x=1749449300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TL3Io6uv1wYqEJLOSkdLO7yEUmLjlnt6GTg1df0N+1g=;
 b=J3qga7upS1aofsw+RaYBN7ofqm2CEhNMenUX+6MQcw1FODz3sKR4nVdtAINQkYYoqg
 qRnh+edRhLhRcA2a1/+wWD7TyscbxyAwYTp/aS8BxiY9zIR0OprbfP4c9DqE2iaxcre7
 bufsEImAMAq5XVOk/3jIF0wqAOfYW+sy4P7inO/NNBT5Gi9Qsk9qTHDL7Yw+LF+6weMJ
 OHB1LU7LTyIaYu/G4j3Kw1p0oIzKIJepbnSL5NqpIj6uXK7vlKFPYSRt8uv9JgxYzjwx
 5WVpIKai0bGcdXc4W2z7BeopznCGxwFPGH3uoXtaGHHPjNqAtn5KQ0cG5+6s52mAdoav
 8ZPg==
X-Gm-Message-State: AOJu0YxIpqrbkG3Y9Nmj6qNyiRJY97/sT/kNJqJTcKCvmXwsznHpK1Gi
 mUwLLa0uzXhfS+D5NAlmf8sUwyQwMImw7PKSVvSAaNKSl1xQ1J7MJ8cppTyb7K4Xa8E=
X-Gm-Gg: ASbGncuqQjwrWdtUE6dF+5+9co1Va24JZZE/JXhCa9JMSipabs7qj0fjwuf84uzFXl4
 +Gxl7VUE9JYEoJZ1HjBV3LINxjZ0sow6AF6yN7sRVa/5bdAekuS8QbRHN8bnrKKfaIu0W2//AtM
 r+h6gFoq7pJTWEZF4P4QBx5HIpx1BcljWEat+W6kOGfkCO9vOosjZXgbtMASWmD65NHU/DGdUDB
 9hGAP7jc9OYgWexrNg5DsPqObwQvEPRbguv9iG8OhKRLu29zha4yyx+AhK1ukQVxpYenYkQ3FiC
 F42JMiXOB2jFTpWKJvYUi1oMcnsAPYsfw2cm0XioJWAxRz9tuFY=
X-Google-Smtp-Source: AGHT+IFE5UK4DUDTTTNkkAtttysd+3ZvdSYQ3kG5wBDX85/dpOnqOcALcKGFOwRbmDnpdSfzbPnHFQ==
X-Received: by 2002:a05:6a20:9186:b0:215:eafc:abd9 with SMTP id
 adf61e73a8af0-21ba1165cfbmr11260756637.14.1748844500080; 
 Sun, 01 Jun 2025 23:08:20 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afff7388sm7036966b3a.171.2025.06.01.23.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 23:08:19 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 novafacing <rowanbhart@gmail.com>
Subject: [PATCH v6 4/9] plugins: Add memory virtual address write API
Date: Sun,  1 Jun 2025 23:08:10 -0700
Message-ID: <20250602060815.328261-5-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602060815.328261-1-rowanbhart@gmail.com>
References: <20250602060815.328261-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: novafacing <rowanbhart@gmail.com>

This patch adds functions to the plugins API to allow reading and
writing memory via virtual addresses. These functions only permit doing
so on the current CPU, because there is no way to ensure consistency if
plugins are allowed to read or write to other CPUs that aren't currently
in the context of the plugin.

Signed-off-by: novafacing <rowanbhart@gmail.com>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 include/qemu/qemu-plugin.h | 21 +++++++++++++++++++++
 plugins/api.c              | 18 ++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 120fb626a6..8ae7758b95 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -948,6 +948,27 @@ QEMU_PLUGIN_API
 bool qemu_plugin_read_memory_vaddr(uint64_t addr,
                                    GByteArray *data, size_t len);
 
+/**
+ * qemu_plugin_write_memory_vaddr() - write to memory using a virtual address
+ *
+ * @addr: A virtual address to write to
+ * @data: A byte array containing the data to write
+ *
+ * The contents of @data will be written to memory starting at the virtual
+ * address @addr.
+ *
+ * This function does not guarantee consistency of writes, nor does it ensure
+ * that pending writes are flushed either before or after the write takes place,
+ * so callers should take care to only call this function in vCPU context (i.e.
+ * in callbacks) and avoid depending on the existence of data written using this
+ * function which may be overwritten afterward.
+ *
+ * Returns true on success and false on failure.
+ */
+QEMU_PLUGIN_API
+bool qemu_plugin_write_memory_vaddr(uint64_t addr,
+                                   GByteArray *data);
+
 /**
  * qemu_plugin_scoreboard_new() - alloc a new scoreboard
  *
diff --git a/plugins/api.c b/plugins/api.c
index 16141f5c25..7258b6590b 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -476,6 +476,24 @@ bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
     return true;
 }
 
+bool qemu_plugin_write_memory_vaddr(uint64_t addr, GByteArray *data)
+{
+    g_assert(current_cpu);
+
+    if (data->len == 0) {
+        return false;
+    }
+
+    int result = cpu_memory_rw_debug(current_cpu, addr, data->data,
+                                     data->len, true);
+
+    if (result < 0) {
+        return false;
+    }
+
+    return true;
+}
+
 struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element_size)
 {
     return plugin_scoreboard_new(element_size);
-- 
2.49.0


