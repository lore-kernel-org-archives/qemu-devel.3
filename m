Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46144C02196
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 17:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdvGg-0000NK-B5; Fri, 31 Jan 2025 12:57:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lacraig3@gmail.com>)
 id 1tdvGe-0000Mc-I0
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 12:57:24 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lacraig3@gmail.com>)
 id 1tdvGd-0004T8-1S
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 12:57:24 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5d982de9547so4280324a12.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 09:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738346241; x=1738951041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e6uGwaniCL5bYZNfnfF6MzaJzg1nlQBZKTNndfBAHl8=;
 b=AjXqOtUoEUwOa2qUYa4uNs5kkoKbvXbdTLasQkvZMQYsyzYxG0pXvLKvDYC8bVznVn
 2JoQ+ppDG0vfyWIt4U975+hs9NDEzJ9UlP6m9dURXHt8TDy+y1okiBlrp3XHhVSy+GKr
 //MKaGhraHFJU0pQEt4YXDwWZE8pgQcb3+32oZcNg0FxUnX5yBevX53Q+qVpaKjvHIGc
 01KkGDs7yJclI41GupKGz8Y0+nNx03JOMEmE7c+bs7wCZGX+vJB1bm5RgUUTvN7zMaxV
 xDmIIS1iUIvTtl7Dsjp92R3Cnjo+ITVBAulDUrZSc4quKofzqrINCbeth6VG/iV8xlVd
 0MZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738346241; x=1738951041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e6uGwaniCL5bYZNfnfF6MzaJzg1nlQBZKTNndfBAHl8=;
 b=X9unB6jo1VE+OA8pqtNIIZpa0WF+Kj8VyO1vWpPnNQsgOSoJ/YgMKHtd0uFkOtPoQm
 g49+MFdJxbGtOCfp75kJFfc8vT5gN6Jt4+iLWykDcYOZ2wMVmEc0GTtuwOxLneYz7lUp
 VsGFu/DCL0ojpvVMTu2N8lPGX8qRze+3peLRyWX2o0HB2ejojvL4bGMHC+CeSDugOlt3
 gJOnlAfK5ms/Iy6Hw28SklC0zbYWBE0SdyyjC9RYZMuY5NGHrOum9hVO7yRNSEFLan5x
 hrdOWgaT+4aSKyr8azM/Q00r+gSfsQFu0LiarvzmlSUrq4b+j4IaWS9hF4GuAICE1na0
 JxiA==
X-Gm-Message-State: AOJu0YwneN6EqJnkijsdjJJYCRAU2ELNk+OJ6e6iO5PVn1df7mqwL+TV
 52mMMqGGH/hEausd2JpPsQ5sHNevT74+CPlgqAHvSloQOFcIixBnz5bRoA==
X-Gm-Gg: ASbGncuTt2vNqgkJI3deX2RJmSvd3B1iSzk+5DBi3Jg3QUq1/jXtQ//NQdK0InFzj9q
 qNEX0oP0eB68p7BaOWi6T4epfFO8a3vDlkhh5Vik36I25Y2BDGE3AmMrp2Q7OVKWjVfc2KGQ+zx
 3zEzMFIWpNEtpjQidzw4G0QTqa+8xT8+Fu5s6UyVxIs6H4PfYOSO6SSuVP51xwNz/WXe19opZAp
 Mi3mvRFLdLm81g3cgGfPBPniaS+eq3pdbNhbPpU9AXQYTB2u93TWMDeSz4HHlo1ZJeE34tmsj1a
 ba0tRONjWU0=
X-Google-Smtp-Source: AGHT+IHO/8dm5p3YxVE448p2NyRGp5QWIyuIEy4/zVsFXahTfu/cQnwxiwMd8Gl4oJwd6JC71aumww==
X-Received: by 2002:a05:6402:518f:b0:5dc:32eb:f289 with SMTP id
 4fb4d7f45d1cf-5dc5f01e810mr11304728a12.22.1738346240858; 
 Fri, 31 Jan 2025 09:57:20 -0800 (PST)
Received: from luke-igloo.. ([18.4.85.124]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc723efc45sm3110074a12.32.2025.01.31.09.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 09:57:20 -0800 (PST)
From: Luke Craig <lacraig3@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Luke Craig <lacraig3@gmail.com>
Subject: [PATCH v2 1/3] plugin: extend API with
 qemu_plugin_tb_get_insn_by_vaddr
Date: Fri, 31 Jan 2025 12:57:14 -0500
Message-Id: <20250131175716.3218600-2-lacraig3@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250131175716.3218600-1-lacraig3@gmail.com>
References: <20250131175716.3218600-1-lacraig3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=lacraig3@gmail.com; helo=mail-ed1-x52b.google.com
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

---
 include/qemu/qemu-plugin.h | 11 +++++++++++
 plugins/api.c              | 13 +++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 3a850aa216..a1c478c54f 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -500,6 +500,17 @@ QEMU_PLUGIN_API
 struct qemu_plugin_insn *
 qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx);
 
+/**
+ * qemu_plugin_tb_get_insn_by_vaddr() - lookup handle for instruction by vaddr
+ * @tb: opaque handle to TB passed to callback
+ * @vaddr: virtual address of instruction
+ *
+ * Returns: opaque handle to instruction
+ */
+QEMU_PLUGIN_API
+struct qemu_plugin_insn *
+qemu_plugin_tb_get_insn_by_vaddr(const struct qemu_plugin_tb *tb, uint64_t vaddr);
+
 /**
  * qemu_plugin_insn_data() - copy instruction data
  * @insn: opaque instruction handle from qemu_plugin_tb_get_insn()
diff --git a/plugins/api.c b/plugins/api.c
index 4110cfaa23..a6bd912c56 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -258,6 +258,19 @@ qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx)
     return insn;
 }
 
+struct qemu_plugin_insn *
+qemu_plugin_tb_get_insn_by_vaddr(const struct qemu_plugin_tb *tb, uint64_t vaddr)
+{
+    struct qemu_plugin_insn *insn;
+    for (size_t i = 0; i < tb->n; i++){
+        insn = g_ptr_array_index(tb->insns, i);
+        if (insn != NULL && insn->vaddr == vaddr){
+            return insn;
+        }
+    }
+    return NULL;
+}
+
 /*
  * Instruction information
  *
-- 
2.34.1


