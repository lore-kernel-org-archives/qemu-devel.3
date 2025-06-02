Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDCFC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 06:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLyVB-0004Ce-Ns; Mon, 02 Jun 2025 02:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLy3F-0001em-AQ
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 01:49:41 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLy3D-0007KF-0p
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 01:49:36 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2352e3db62cso22328135ad.2
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 22:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748843362; x=1749448162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TL3Io6uv1wYqEJLOSkdLO7yEUmLjlnt6GTg1df0N+1g=;
 b=apNc4a8DkGjQ26APfGT2JYeerNU2DrtPcdRATV8+YQDC40RhfUy75rLwkjhhr34ENo
 GwFDX8vaRihfVwr4xfmZnXaW2gvyv8qx0JrhZJ5l6fAwwaPXwjls0hQsuvP2j1n2C1dU
 x+ob0NZUFLLRLRYSPLP7ahEv0q1Hto+CVZ7EcOpoYGVNwZdbdtgf3kkMOXeN69bRGe/S
 tPhMM3tK8eqMaVqDoNSPrXflI4rdj9gNQdC8GsZqibthj5veStbH9QIpS1eNToTrauXy
 UDBrMIwv+yq+i/pLKP6LuYCaJ6b1lUsEbgZDGTt+jTo7+qAVJK+TDWklFQeXs2Ij0llf
 jFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748843362; x=1749448162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TL3Io6uv1wYqEJLOSkdLO7yEUmLjlnt6GTg1df0N+1g=;
 b=xAv0WXzp73JlkR3w0vRveQvVZbQc1Aim9pT3060XIuUYLurT+SYSFge8UsanjyGtSn
 eN3igavudHjpJR3rOOEN/dGTfDtzOvJHqoK3B4KOXk34PVCIciSl5i1oHXeEr8ED3ZfH
 tpXCXLe3qqyS5bnjO6uUKXkD4QFNl8KTW0yUridsDIXJqciK+ho5zv6UCDwVBNZl8HTc
 XvAK4a1pV2a/s5eWfmOiWWJUROQTvrnwB+m+NC1T7P89/otzjoC2ZVCXnsdnGCy+43f8
 MOD6lurHGUQTvHQ2YXfoQRRZUYVji2IfHx+sVoGuUaMJN9lV/96prQZEIXZdTTp9UUeW
 Skgg==
X-Gm-Message-State: AOJu0YzLYlQMovk7mQVkuu2LOYi8zSR7AoPnTJwxSAbuFPjJ+aHaxC8z
 BifEvVFw3IAo4Jlz3OGV3/6aJBvPwAgpt+ntEQXH3J4zghTGgs1/0LEfvZaTLSXgYP0=
X-Gm-Gg: ASbGncvBRfHwEdxqI29lbLKTxQFUaYlL3SJAqYEY1EF2cn0CUOLBxguK2JTTEC6FKF3
 RT3t5BfycIRcmKjVzVmAOjyDW0P0rY7aDZRhzaI1SD7JU4YWp4c5OI9sGjTU7mWQmzXFQdGcAoF
 4YRG8wQQXpyp+IXEISHS9MOLFt1ivERvy5IYymCoCulK+yE+zxI+G+WVWMFx1V1qZ5635nOs1bd
 HGLKFRMTwkc/fRh2f4vE6SKyTA5fN+9ZUbAUIDZhBhusmXlmKZ9SKY85phzHRcMO+HrUUynQ5Ln
 xVqyVYdD+CQ60iIi9faHSGcd66dyIRNATCeZ+TukGFzh4Y/dhckDuifLBXs3wg==
X-Google-Smtp-Source: AGHT+IFP0ZhXETNnnpbS+zf5/ZOE2i2lSbTQJukB8++gNLXsPsdO/pJcbcA9YuVLW5BujVk71T1OPg==
X-Received: by 2002:a17:902:ce83:b0:234:a139:11fb with SMTP id
 d9443c01a7336-235291ee18dmr150079435ad.27.1748843361684; 
 Sun, 01 Jun 2025 22:49:21 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506bdce12sm63464085ad.99.2025.06.01.22.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 22:49:21 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 novafacing <rowanbhart@gmail.com>
Subject: [PATCH v5 4/9] plugins: Add memory virtual address write API
Date: Sun,  1 Jun 2025 22:49:11 -0700
Message-ID: <20250602054917.302638-5-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602054917.302638-1-rowanbhart@gmail.com>
References: <20250602054917.302638-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x635.google.com
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


