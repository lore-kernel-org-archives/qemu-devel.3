Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919B7C61CE7
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 23:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOP7x-0005ve-O5; Sun, 08 Jun 2025 19:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOP7u-0005tY-9O
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 19:08:30 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOP7s-0004cb-Nt
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 19:08:30 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-234b9dfb842so32754995ad.1
 for <qemu-devel@nongnu.org>; Sun, 08 Jun 2025 16:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749424107; x=1750028907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wVjrW993BqqXU9EpDADVH1dB+hpwPyajnX8KVD/tm+w=;
 b=cXPsQnuikzBeKv7tm84EknZNb6ikvwjwMS3dd9AjvKSksNolz3/OD8pqG0JSsSvseQ
 qTO7IFOy8eR11bpMNrnmiq/fZUlfYPRg0/FqTcq8ursbAw5oxRMqF2WyRyKd15j8lwH3
 Eam6YMGxL4pX+rgS9snk04jpGF4mHh85bzgBaYCRajz6sRaQvuuNbQ5bh3rcELnNPSq4
 aASyrozFjI6c9DQORaUQ/rrM/sbD8MpjtpwvPpzgW04sOUWXGgmEPCB/gPNAIyB/R9tg
 NYzjUK80ptRmuQiqHjI3m95DZoA9fhmpFZLxCuDB61t6FcUeIhZioVfhZw8W0nO2pdCG
 yt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749424107; x=1750028907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wVjrW993BqqXU9EpDADVH1dB+hpwPyajnX8KVD/tm+w=;
 b=FFfP8JfSOdgKtSDTjBjzgOne2Lmsbip/YVfkWsp4e6U9Pt0QPwLO6ayCS0wMUcyyFb
 b8rXMXEpXTp/G1A/v/80RL1a+Sn9qx+cHg7+wgeMsSKBJ0eLj+to6BZb4HBLB/oeGXsP
 g/LKK0dmjEkmc09L4sNciqzgdIe2R0V2FVBT9Ok9fcjTXAeMFjGfzjNBf3fhoGCbX/9Z
 /SncGW5IUPZZkM7QZ+dlKV0vaQfvqPNb1ND9kXfa0t72E5se94YFqI0HpnvY5zq2aJ28
 uC6zzlqa6drZBZYCbiq/yfQ1G92Kkj5hmz6bgDnO1bodcqfGDXb/441BYwOkDMneINJ0
 dRMA==
X-Gm-Message-State: AOJu0Yzm8K20Z5QURzas+PSQOarO8exe1zBXnPbrd5i36TTq/IHRUwws
 skFJswbIBJNbbnHOn0bz5QSVQ4J+LQLpdV1W2oiXfjQUee92boYLORVCEPACzMXSQaQ=
X-Gm-Gg: ASbGncukW7GSFaR73JxUsBShMlEV6aOrI65mQfEpYhGYS9DoB1/brkGRgwp4tr9whcQ
 +vrm3YhdUQzjhHj46nRI4gx8YK0fsqHQH3y3iIWrRFbTwMX4+7LFCtPWCqq0QVQX2j+/E+4pieb
 tx04H+c2LrdaTB6Qu1Pu+FbftPl52H7FHlfTA3O+EYiGjaStLp/A4T8ePgbeiGRXwRKSWxvCtZ1
 if/sRjMpoVCjepOA28yg2hAtttls56ddhw8HImxzLX7EhYkHh17/Jrl0g77wnlhwSEVYGCBoAv5
 kzrT+HqsUJhBFrZXStMFmKqc5Lrnj6r12Xir3RYkf26qcjDAK1s=
X-Google-Smtp-Source: AGHT+IGebaTfb1WoGeAaYjsLagsI8MCz2O/rML5iqD+1MggiVIVHkkDN+xaIeZtMl01QFQs1YPhHfA==
X-Received: by 2002:a17:902:dacb:b0:235:1ff0:369f with SMTP id
 d9443c01a7336-23601cf11e1mr157802175ad.5.1749424107055; 
 Sun, 08 Jun 2025 16:08:27 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603504f09sm43421325ad.223.2025.06.08.16.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 16:08:26 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v9 8/9] plugins: Remove use of qemu_plugin_read_register where
 it is not permitted
Date: Sun,  8 Jun 2025 16:08:18 -0700
Message-ID: <20250608230819.3382527-9-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608230819.3382527-1-rowanbhart@gmail.com>
References: <20250608230819.3382527-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x633.google.com
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


