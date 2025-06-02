Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F85C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 06:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLySf-0002kL-6l; Mon, 02 Jun 2025 02:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLyLX-0006dv-9O
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 02:08:54 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLyLV-000278-AB
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 02:08:30 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-74264d1832eso4385191b3a.0
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 23:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748844504; x=1749449304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wVjrW993BqqXU9EpDADVH1dB+hpwPyajnX8KVD/tm+w=;
 b=bsc9pbB8wDbU4I95yJDrTXSoBr96hPtVT/9Ml8A7EC+WltzMd4xyzxuBaFs7BXK1xi
 5Hmqxl6SKGZ65p/7RZF81/LVgw/A0ZjMBqgGDHxtDfK6bmZmgbx4upxvSR361nWqz6rP
 4/MfyYzJHDJHQ6TXgcLlPK3DUaekis9JVO7lCCydFqQiivAoSRv6ozSHC+knDNWJiiz9
 NWTzCkvBdfZLU+7/AdP6EINcCyRJbm9MUdGeo2K0aWq0Af9pl4NooRG405Znh9ZzNCH6
 bPkOObMRPfdEeaHXoNIeDpQPKaCw9cfZJqbWEBm8WmpLPsDG49qhvou5CtM09GHBCfC2
 F3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748844504; x=1749449304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wVjrW993BqqXU9EpDADVH1dB+hpwPyajnX8KVD/tm+w=;
 b=hu7uqbsIPkn04RlaCgw5G6/mp19RHr/WfupXN5nftLpb9DWBy2yBRZz3qNR+bAWJ5i
 BZZuaIvk4QG8hSczyBMZXjbGPRguq70QQ7bCqYxva5S8gtaObR96+IlRPuNwoAJFQDt6
 HBik0UMxooIoYNH7VEpKkZh/z6YlP3GuaeSaY+KbZccX0BuEx14zWuFmqAiMYKjKC+G6
 1L3GjEL6AjzxQ/oqGLV3fj9oZTFY5xTBH6XDnR1CgkozuL+Ci1LcGss/lqMUG7d0EhmX
 o6+kt81N6a3KkzyBACp4BHrC2VwDPxOCOBXFkUcAdFmjBG5uaIrPRLNO52l+eTWYgvkn
 0hBw==
X-Gm-Message-State: AOJu0YyAXj1EFhh2qPdouYgOeOkk+ztL936Y7qgZ9opQGE0oZNtnYxug
 k9qDRHvcRVal8NahzWYjQkRAbkWLovFtDt/HtYlDb1EJMVWLAQeGSMRi7U8y2ax9034=
X-Gm-Gg: ASbGncuWDr7JJ2gFbCTamcNUCDKM23hIWGLbVJZGlKNOu73imszsF8662v0tnWJ/1SW
 Nal6973qfOj0NRuMCftl7n1sGxaEuRBlnLyk5EKzmhIwx2NrMIzIQgskUuXqCMQCkSTHHlKdKhZ
 bQAsTpT8s5ZTjZawL4ZNbOwJK0hhOJ4oLp+mn4YEEc9QKwLX8fGW6au5z5TtXXQFwBgFkTL4RJA
 BxA8Iry5qy1zdRdymd8hbpNftcAu6HaG3nzeOzILRQybpON+ODf/49m3RIZ9F4aTA10SYD21ZSa
 NNCNowMFZuE9XDG6LH6drMlHMd2PZgTxQyikWMWVFSzLDYWClXU=
X-Google-Smtp-Source: AGHT+IHFcYndX3onRjw+LXJbmuRxYbCGqR9Qt0/D9y5KCMVDS4lvYiY9kltU7et736zrp+5QfCTp6g==
X-Received: by 2002:a05:6a00:14c2:b0:737:678d:fb66 with SMTP id
 d2e1a72fcca58-747d18210f0mr9355571b3a.5.1748844503688; 
 Sun, 01 Jun 2025 23:08:23 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afff7388sm7036966b3a.171.2025.06.01.23.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 23:08:23 -0700 (PDT)
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
 Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v6 8/9] plugins: Remove use of qemu_plugin_read_register where
 it is not permitted
Date: Sun,  1 Jun 2025 23:08:14 -0700
Message-ID: <20250602060815.328261-9-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602060815.328261-1-rowanbhart@gmail.com>
References: <20250602060815.328261-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x433.google.com
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

This patch is required to make the insn plugin work after adding
enforcement of QEMU_PLUGIN_CB_ flags in calls to read or write
registers. Previously, these flags were not enforced and the API could
be called from anywhere, but this was not intended as described by the
documentation. Now, the flags are enforced and qemu_plugin_read_register
can no longer be called from a vcpu_init callback because it does not
request the QEMU_PLUGIN_CB_ flag (nor does it have a mechanism to do
so).

Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 tests/tcg/plugins/insn.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
index 0c723cb9ed..265d3ebe9e 100644
--- a/tests/tcg/plugins/insn.c
+++ b/tests/tcg/plugins/insn.c
@@ -81,25 +81,6 @@ static Instruction * get_insn_record(const char *disas, uint64_t vaddr, Match *m
     return record;
 }
 
-/*
- * Initialise a new vcpu with reading the register list
- */
-static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
-{
-    g_autoptr(GArray) reg_list = qemu_plugin_get_registers();
-    g_autoptr(GByteArray) reg_value = g_byte_array_new();
-
-    if (reg_list) {
-        for (int i = 0; i < reg_list->len; i++) {
-            qemu_plugin_reg_descriptor *rd = &g_array_index(
-                reg_list, qemu_plugin_reg_descriptor, i);
-            int count = qemu_plugin_read_register(rd->handle, reg_value);
-            g_assert(count > 0);
-        }
-    }
-}
-
-
 static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
 {
     qemu_plugin_u64_add(insn_count, cpu_index, 1);
@@ -295,8 +276,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     insn_count = qemu_plugin_scoreboard_u64(
         qemu_plugin_scoreboard_new(sizeof(uint64_t)));
 
-    /* Register init, translation block and exit callbacks */
-    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
+    /* Register translation block and exit callbacks */
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
-- 
2.49.0


