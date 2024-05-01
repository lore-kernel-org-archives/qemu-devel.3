Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59545C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 14:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2B6D-0002ku-93; Wed, 01 May 2024 10:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5q-0002hL-If
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:58 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5o-0002AV-Dc
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:58 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1ec69e3dbe5so12751645ad.0
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 07:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714574275; x=1715179075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kmUmHZTNzNBMvvIGWmKaQ5oKXKcaA0ppcXgwQeTRE2E=;
 b=IP7uYznmdhLf/uUTUbA+D7r3jkMCKsUwfvjSW55jlB/c/3yjTgntNXHww0170KQZrn
 gAJr6v0AESLtORYf+/reFDiqWFCwFityfosJhSS1qomvAycGLzudZ7C1bV8wgHAHN2o8
 TtQeSvtEDaW5RkNeJZ45RcM9ujwkPmoP3tmajzL7COnuWZybUk6CyNGvkMCJCiiDLxpz
 DoXa2aGZFelFFLspCWAq/0SSVaXE40e5Asy5+s1miCJwZ+SmmeWuTOYwLrdn8y3q+8+K
 K5uZ1A92fBhoWiK9CL/Wxb0Ukl92E2rCOpPxlKCHVDH3v4jakMMAAC/Nn/sw9uqaIkS5
 IZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714574275; x=1715179075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kmUmHZTNzNBMvvIGWmKaQ5oKXKcaA0ppcXgwQeTRE2E=;
 b=ht3/IFW/4238z7DXDIf5YOVEPTTzFlDIUBUNBx+jN48vv6CGdE2lRkv3wpl9CqxMe6
 8OyjzBRccxbf8XcxG3mQMXq0b8QqckWIiCj5nqZwKd5hogi2KHlcdyPcr32hM6YXrU0C
 PH5moBmOgrfzyNxQTmB+IB7hAdQEvaF3NrBE6vSBfdMa+kghoVHLXMyuMZ6APUWc4UCJ
 ukr0a0b67eLLfSPpueTVZMNZEhN28bglv8hQXSn6mo3Q9vpWETnV3wlRvgkUoXzT9XZa
 V565LESWvfn1aoIcUrmBcrC86eVZLyUUlEaamOIf+wUeQ7nPKYq1nvv5HQVW8qYZUPHv
 LQog==
X-Gm-Message-State: AOJu0Yw7uffGRFqraSCcffZeo1YuU0dJWzRyMGDOX8M/tZFEsFjCO9hb
 7sp91zeWfmXHFvxFvDvVvRuvGPWK6UP0KI46Qfa0l0ZUvMxGmeDBX6Lc9wsGwKkKZ90URgpaAms
 O
X-Google-Smtp-Source: AGHT+IFUcCNbcEWdI2sF0OwbCkZMfkwuprth1MJHIM1jpfD+xVeTXW3EHuDDTehuuCFgduyK8oDmOw==
X-Received: by 2002:a17:903:2c9:b0:1ec:a6e4:dc9c with SMTP id
 s9-20020a17090302c900b001eca6e4dc9cmr1648750plk.50.1714574275156; 
 Wed, 01 May 2024 07:37:55 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a170902f54c00b001ebd73f61fcsm5751573plf.121.2024.05.01.07.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 07:37:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 15/20] plugins: Introduce PLUGIN_CB_MEM_REGULAR
Date: Wed,  1 May 2024 07:37:34 -0700
Message-Id: <20240501143739.10541-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501143739.10541-1-richard.henderson@linaro.org>
References: <20240501143739.10541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Use different enumerators for vcpu_udata and vcpu_mem callbacks.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/plugin.h  | 1 +
 accel/tcg/plugin-gen.c | 2 +-
 plugins/core.c         | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index b679a22bae..f5a08b1220 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -68,6 +68,7 @@ union qemu_plugin_cb_sig {
 
 enum plugin_dyn_cb_type {
     PLUGIN_CB_REGULAR,
+    PLUGIN_CB_MEM_REGULAR,
     PLUGIN_CB_INLINE,
 };
 
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index e77ff2a565..c545303956 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -361,7 +361,7 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
 
                 if (cb->rw & rw) {
                     switch (cb->type) {
-                    case PLUGIN_CB_REGULAR:
+                    case PLUGIN_CB_MEM_REGULAR:
                         gen_mem_cb(cb, meminfo, addr);
                         break;
                     case PLUGIN_CB_INLINE:
diff --git a/plugins/core.c b/plugins/core.c
index b0615f1e7f..0213513ec6 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -391,7 +391,7 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
 
     struct qemu_plugin_dyn_cb *dyn_cb = plugin_get_dyn_cb(arr);
     dyn_cb->userp = udata;
-    dyn_cb->type = PLUGIN_CB_REGULAR;
+    dyn_cb->type = PLUGIN_CB_MEM_REGULAR;
     dyn_cb->rw = rw;
     dyn_cb->regular.f.vcpu_mem = cb;
 
@@ -547,7 +547,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                 break;
         }
         switch (cb->type) {
-        case PLUGIN_CB_REGULAR:
+        case PLUGIN_CB_MEM_REGULAR:
             cb->regular.f.vcpu_mem(cpu->cpu_index, make_plugin_meminfo(oi, rw),
                                    vaddr, cb->userp);
             break;
-- 
2.34.1


