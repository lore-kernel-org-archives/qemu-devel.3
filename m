Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DD4C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 07:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZn1k-0002JS-Lr; Tue, 13 Feb 2024 02:16:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZn1i-0002IM-Rv
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 02:16:22 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZn1e-0007tj-8T
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 02:16:20 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33b2960ff60so2839640f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 23:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707808576; x=1708413376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Cj9qCj9mT2tt5rgoG2stTmiFvC9CmzQUn4FtQx8Dgyg=;
 b=Nyugot3aKozmEN3Od4aVM4pM7pkounGGNXLkw0W5IVimYeo7vi9p45XlNjOPKcyLb0
 ucwVi14PwNoqAH587zDLvN/o5As9DxqXHBts89vViw0MNsrA7uEPWssDKS8TjjL+EWvW
 L2XGrstl/QWtDKZpRqYbpowyGfwJMJpP1XPz+lgx4vGkWs+R7TlMO6OdnOBYo2Nn9qxu
 T+PvwZrcgmXPQH17j6cwgtfzYzv2IlmxmSXT+m+VxgDAt9zXvlaIQ/z8wyxnCkPUTBeI
 N06qJQ6lMMbeVcp05CjT1Lb9P0+eNdJ5qoXcKy7w9a/vHY+vGfMV8DoZudZLOL5KCSUq
 aNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707808576; x=1708413376;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cj9qCj9mT2tt5rgoG2stTmiFvC9CmzQUn4FtQx8Dgyg=;
 b=CdaLWfkuxQBsspLKp2niqZICOZhG5ECMvpn3D77hXCAMtrf9I4yirRCzBCXgBIfSuD
 F2uV6wb5B0R+w+d7smVBDxkgwLNylH+UWQdqIQdo/HiH+4S+XJOLSWiNWDwqdGScdXNC
 yaOM0gE2o9JWXz0tsq+0OWynXzTjzVBz1jpRWtXv+vB28pDK2ItTZqX6n/nTDKtftxpT
 GlubQC84+cerAJD2hnSxitdnjjpabVtlibPkNJPJYIQTEnDr1NWaDQ6V6NOTmrFj0Sk/
 PKAZFAyjxxHEUYQf5iGlgQpoEQnS9o8cOWg2qG1NmIB60eVWIWRZwUc4kqSB3NHYvH1V
 449A==
X-Gm-Message-State: AOJu0YybK9yd3Lrq/47RhdjM8RcdyPyIbw/MKtf6xyWcDjHyJQ4OlnLZ
 7dhrAIXAj48qieB596/1i7r3cp45wPH5ZQbeh5hHj15CawKg8TADRB4N1qtXpnfGC+ZAL6CDClW
 w
X-Google-Smtp-Source: AGHT+IHrTLLFI1tqRrznVpJefkYRpov81hxKrswb+qr8oG1krRE3F60MHN+PzxhK8sZc6q4GGy5DPA==
X-Received: by 2002:a5d:680a:0:b0:33b:58c7:8281 with SMTP id
 w10-20020a5d680a000000b0033b58c78281mr1332042wru.10.1707808576417; 
 Mon, 12 Feb 2024 23:16:16 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWXMyN4Ms6ScJQQh7dqSy6GHbE06UMgK9JZeeYZ9dG7RPFxdwmu0sY+47koNoHh+ljrad1MOEabRm2rvp9PCAl+NJ8Nd7UUfsfFBbWB4V2mbZNhg2jCeHDCnJqMdbFPnKjt8CD/WqqGG7w9iyiK/JUF2m3CtU2AamnOdVAvdLlrXPBpDdlpYbblD6okSn/zo+kuRXcrite5nUivZiblO/1spB3ldJUanQTHWmwBfAOQWhXGyV1vlGieRg==
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 dv5-20020a0560000d8500b0033b483d1abcsm8709565wrb.53.2024.02.12.23.16.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Feb 2024 23:16:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/i386/sgx: Use QDev API
Date: Tue, 13 Feb 2024 08:16:13 +0100
Message-ID: <20240213071613.72566-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/sgx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index 70305547d4..9176040f8f 100644
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
+        qdev_realize_and_unref(dev, &error_fatal);
     }
 
     if ((sgx_epc->base + sgx_epc->size) < sgx_epc->base) {
-- 
2.41.0


