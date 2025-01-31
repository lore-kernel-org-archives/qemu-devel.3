Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36555C02192
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyEj-0003PJ-V7; Fri, 31 Jan 2025 16:07:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lacraig3@gmail.com>)
 id 1tdyEe-00039v-UK
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:33 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lacraig3@gmail.com>)
 id 1tdyEd-0007yD-BQ
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:32 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aaeef97ff02so419271366b.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738357649; x=1738962449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXv1FTbPXF7he4SA7QeS7JVItWKx3/NJD/RBYClAVpk=;
 b=kCI2IRzgRlKBy9eXIXn8ewHVN1vz2ALmyc403fNnXlcztS9ExrGt17MazLJz21N7E9
 L3PFkPEOA2Gj0OPwwcSJpI+xuXsrqd2NQ8CFg/wLMKtLMmQOuDRFj13QqM+8FetaJchh
 HGLvUPPVQdJEuQBV4//PAQ+SkNEbeoukvCSe1fW7Ko9/R8zWroIqP+VWJMNHYN+fCv/r
 MqpCzc3mWPwLDX+OUYn/kTw1x3Hx6IT7R6UgSfT3+RskzKtgCr4aN3ji/xbv8o7D04W9
 JBVYFvZppWw8UPDqPW/qaYLFsXy/1TBN3EB1HdJmouA4xmF0CAlp45npIJCBFuxLXXZb
 77qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357649; x=1738962449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wXv1FTbPXF7he4SA7QeS7JVItWKx3/NJD/RBYClAVpk=;
 b=QFFByN6OrI41XUrcoNM+zQHdW51X+BLTJTZIuS2P77P8xD9B3OTDDm9XmVNV2eDjnQ
 f0AV05ZJMpKhbY8hl3F1PBo0Q/AUkDu4aHwUK7e4sycL3axJZ1ct5GIqNbMQJ0XpeaMi
 ZN8ZurBRbVQ0lJOxMMD8UprDaZHv7z1qQCVdJAzErg7Edl0YJWLKuDd1ZGT22y3pN9OL
 jW3Bzt8gR7JiIX919e+MLcJ26OjmUBhq54fHBPlIHGr/Cg2K6LAsRFJB3DuhW+c9Rszh
 3FRZEV4m6WR6UDj+peFj+c7R1tvRrLOirhhlutMp2Za4hDGZzf0AepO1KsPVgDNcw9jM
 16sA==
X-Gm-Message-State: AOJu0YztMuWIcs61HBplUY1c0Hv7VH+KPUDAvVdSlgkQEHSx5bJaGZeH
 lKuq5v/n7mtRhZ3ZXNjc0wFjcLtoXgJWMKvIzyDdPD8M8XdVsCbDI025Vw==
X-Gm-Gg: ASbGncu1otB8OO/6tQLRlejOhK7aGmMAojZ02OpprTVv7v8ydq54ak3KYume9d+dixt
 TxA0Bi+WEd3sZCfE21CP0SPM/qxDMMtX4ZICBy21vT0fENhYFNSWT4sdv8WlwL2OI0tdNCwrD5z
 hOUKa6Wf7sWW5MPKZnLnkxLwEwMV7jhODINb9NYpJeE5gST5bXE34GrC/PJM9fbMZuKRNDYQkuE
 BXCSG9kC76bL64RPTBFncdUgh4DDoOQdMUcWA+krAOZYKBExIvRZF3p59uvbzJZ7xoOBEVpW0KT
 BxWMtoFRszk=
X-Google-Smtp-Source: AGHT+IEnODabV5ZM8Xn5Iutl3U1xke/vJM67YDp4KVYCPx/7m7Tw/zUukSzMN72AshHAwSl/HLA5Qw==
X-Received: by 2002:a17:906:7955:b0:ab3:9923:ef4e with SMTP id
 a640c23a62f3a-ab6cfcdfdb1mr1399199866b.22.1738357649429; 
 Fri, 31 Jan 2025 13:07:29 -0800 (PST)
Received: from luke-igloo.. ([18.4.85.124]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e4a31624sm347719666b.142.2025.01.31.13.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 13:07:29 -0800 (PST)
From: Luke Craig <lacraig3@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Luke Craig <lacraig3@gmail.com>
Subject: [PATCH v3 1/3] plugin: extend API with
 qemu_plugin_tb_get_insn_by_vaddr
Date: Fri, 31 Jan 2025 16:07:22 -0500
Message-Id: <20250131210724.3330110-2-lacraig3@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250131210724.3330110-1-lacraig3@gmail.com>
References: <20250131210724.3330110-1-lacraig3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=lacraig3@gmail.com; helo=mail-ej1-x635.google.com
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

Signed-off-by: Luke Craig <lacraig3@gmail.com>
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


