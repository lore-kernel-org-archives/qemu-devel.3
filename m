Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4717C54E49
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret2Z-00038v-0H; Tue, 27 Feb 2024 03:42:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret2V-0002aM-2r
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:42:15 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret2R-0008KK-SX
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:42:14 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-564fc495d83so4580865a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023330; x=1709628130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9zD/OKW2eI569vD83pviooB+9Gzp5s2IN5noJR3qtG4=;
 b=AgV0M77zCe75IXST6dLnYlJLJt8+WKT8/UA4JivMuWP0NFz1T+j1Bh27hWmLHZx5M0
 6ohlK84p7VLz8hLg7DlUCuRGbn8mysBOIM4tPIabeu2Syml1aIcUyKvenQZCtiHt8cOM
 Nt8mDefoQI6tGA5lPGlKReiiJWz3WBKuTyjioySLUu6cF1PWUcIeOp1eFtzpocGyvPkD
 IRWrMXvh5thl3dqAyO/rF3T/a9bP0ZhOvUUQ24pTTpDJm66qDLGiMtf/xmvqbBoh3inJ
 h0WU/ikGpiymU7ELoF+plxIE2WFNq3ZeFRfak9qyl0rUt+pr1yQcn4R24ewA69xU3C8m
 Rtrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023330; x=1709628130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9zD/OKW2eI569vD83pviooB+9Gzp5s2IN5noJR3qtG4=;
 b=PdKPjK7478eFD8qU5cpUCnWYgeKE8njTBVMyTis+e1dHHqaoMMg1XTsfXxQHcWtlHt
 xlZsWY1FA7+FmUjjhsUy31hgDu8fRNdeYA58CAVOcPy/k4LDv2//+P+937OV/viZMWcH
 ud1MpuepP3Ylg+wxkMffQ/M8WSIQe3oFonl3l2WHK3P8Q2x5F6wG/XbngPGTIBGtDLYJ
 M8uF5cP9B33Z9SmrphfCgvBZvwnBqmfDWVTlwVodFpEegpnVcgG2kW9OBZNlU61IFB1a
 czgOWDvOhtOGucZ95WtRTQUEkeMeOhGs6NipSbcqC2xn/AAdX/ja7hAe5e2SM5jqll2Y
 +iIg==
X-Gm-Message-State: AOJu0Yz9afXVYaSK5p4mtNJEdAx0lJ+zu4EkLMmYqT08Y19ltqhAnhd8
 6tUgto+OC7cEjY0S2fdncvNg4KUr64HzQoidpF2PtZI3CiVQF8QW0GVJjFf3UL2athNl/O24yNF
 I
X-Google-Smtp-Source: AGHT+IE02bMtvZpWaB9ce3nfzypPQuqHvxqyi/6ii5I60rSE3K89IJ/uqNDmgkBPVMwaHCPTB+Lgjg==
X-Received: by 2002:a05:6402:6da:b0:566:aa2:8433 with SMTP id
 n26-20020a05640206da00b005660aa28433mr2734239edy.36.1709023329828; 
 Tue, 27 Feb 2024 00:42:09 -0800 (PST)
Received: from m1x-phil.lan (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 q7-20020a056402040700b00566220e204csm543399edv.15.2024.02.27.00.42.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 00:42:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 22/30] hw/i386/sgx: Use QDev API
Date: Tue, 27 Feb 2024 09:39:38 +0100
Message-ID: <20240227083948.5427-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
References: <20240227083948.5427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Prefer the QDev API over the low level QOM one.
No logical change intended.

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240215142035.73331-4-philmd@linaro.org>
---
 hw/i386/sgx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index 70305547d4..de76397bcf 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -286,7 +286,6 @@ void pc_machine_init_sgx_epc(PCMachineState *pcms)
     SGXEPCState *sgx_epc = &pcms->sgx_epc;
     X86MachineState *x86ms = X86_MACHINE(pcms);
     SgxEPCList *list = NULL;
-    Object *obj;
 
     memset(sgx_epc, 0, sizeof(SGXEPCState));
     if (!x86ms->sgx_epc_list) {
@@ -300,16 +299,15 @@ void pc_machine_init_sgx_epc(PCMachineState *pcms)
                                 &sgx_epc->mr);
 
     for (list = x86ms->sgx_epc_list; list; list = list->next) {
-        obj = object_new("sgx-epc");
+        DeviceState *dev = qdev_new(TYPE_SGX_EPC);
 
         /* set the memdev link with memory backend */
-        object_property_parse(obj, SGX_EPC_MEMDEV_PROP, list->value->memdev,
-                              &error_fatal);
+        object_property_parse(OBJECT(dev), SGX_EPC_MEMDEV_PROP,
+                              list->value->memdev, &error_fatal);
         /* set the numa node property for sgx epc object */
-        object_property_set_uint(obj, SGX_EPC_NUMA_NODE_PROP, list->value->node,
-                             &error_fatal);
-        object_property_set_bool(obj, "realized", true, &error_fatal);
-        object_unref(obj);
+        object_property_set_uint(OBJECT(dev), SGX_EPC_NUMA_NODE_PROP,
+                                 list->value->node, &error_fatal);
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
     }
 
     if ((sgx_epc->base + sgx_epc->size) < sgx_epc->base) {
-- 
2.41.0


