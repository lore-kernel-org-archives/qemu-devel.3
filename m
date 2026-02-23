Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B36EEC1112
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKj-0002SE-9J; Mon, 23 Feb 2026 12:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKh-0002QS-Rq
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:55 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKg-0000HK-9Z
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:55 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48371119eacso52939055e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866173; x=1772470973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2coO5QjLP0oc9KsM/+Txuq5tlHPzzz+22aLdjZKCFt4=;
 b=QwW8NC2Q5ypGAhzcYos7AtqSq7YNYH17WPTX5XN1lECE+Ft9sX2D2W902hOwGWrGHm
 v8FDek4Nile60ixjoyPOEF/x8osVcUBkWyR17pq/6c2jrUovA+iOMjLRn4HTeewhyr1D
 O/1YHuoTnTQhoZAHbFqy9KVQDCmafApqFHSX0aTM2c7FPUPKYsT9FUoDfzvvrOT1gBQu
 ehUA3UXXrMBBo2wRjwolfZj4+gqK2hzIaIIMVPlogiXr5z+VNHJHsokiIOsvQIFh4fFx
 pVXJFxFguU+0Qt4/ehe9x5jIeXAdRdYNc3qfxWh3uW4vYI/EcrA7ndxzKh08x0khJS9P
 qpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866173; x=1772470973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2coO5QjLP0oc9KsM/+Txuq5tlHPzzz+22aLdjZKCFt4=;
 b=ILMHsK/LrsS44AcxX507yUWqrf9MEbikw3/93zyl4kfnfvi1ZgALF8iDNTGJKmPkEG
 Y0+1ywOG5EGM4sojispZyaU9jfXiC4IUF4ElgQTqBAcgMe/V2Rt22u6afjV+79pkAxd5
 iCAJfRlGNY8UpIjNlTERXMKKYmwOggoKrdG+EdgWHUQ/qZwGmlYVUxcvXXa4DY2fGvqF
 SyhGW3HwMz26Q1c063gjDRgujDpnIcjs8SE95ocMgXKycHgfzBrZdaeo7OAb1WY14amt
 Zc8B5ucjbGTmWxsD11odqO6yFlv9oAtJJ1odwiSJnx/0GlFPwEoMdnBYrHRSi5RAIhlN
 eVRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCSPIPSgCyFXri9SNuCBVxiZU8AndjNSxfy2/04pWLh/QPERzESu6me61zc4V/YcGx3LP25Ky9VADJ@nongnu.org
X-Gm-Message-State: AOJu0YzttRExnbu3vojiyF3GM4uU1h5v5ia6aPoweoDVjMEdk+vA8V9m
 frY2Lrn2sHjLhXSxbzS1HzRJeEMf7f2jjk4b6H9FBAF+NuE9AzHTfngfd7ePucMOPXrr+grMkEZ
 l4X7s
X-Gm-Gg: AZuq6aKNb4MJ1QVGFHUXDnObZNbvugsVHEV/cGKzMmlnU54n1MwXH4ianqVSplT8gtP
 YeYOjXtxoK9X1/F+J6k89nFv82/WwNdTlR5IL6hN9+eTam0h9WooWSdV9IcprcdjmqH2utNQcL3
 oVZsk204KoCbyf2KBcb+i80pCC1kWY08jyW2nexTvW62bRD0dBvXrRfCXL3yH1bi+31SPwgiGAj
 5ZDtwAXF/maFFt+7Tyeo/mkfjaoYlnFTiWJ5cRnDZRsxXF5EmU12lOzAYp/IG4+eVMMwnpsxYjh
 yf9LvPBOmkTIqyDCjecMNSl+khAi9BxubxxVOjhc4+FGXHqUkGoj5N8dOA40+KDQTFqWemDUl7h
 wD9mKHtgHauv9V7Ar657uAPVazudwqRcVjQQkm5ZmNB+S+2FnzCAj//4prFsNhdtR3xcZ/wAiSo
 cx7Pqu4bWhwDBSNPzJ9nu87VFIvyuy/9YEthw9cpQX8yIfU9kj61M2mbwyTLd2Y0Qw+CmqX8WYh
 Au9AgA007jllXH1pti/vhobAt/s4KIAnc7irVoFNw==
X-Received: by 2002:a05:600c:c166:b0:483:8e67:e696 with SMTP id
 5b1f17b1804b1-483a96088eamr162999475e9.15.1771866172677; 
 Mon, 23 Feb 2026 09:02:52 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 34/65] target/arm: GICv5 cpuif: Implement ICC_IDR0_EL1
Date: Mon, 23 Feb 2026 17:01:41 +0000
Message-ID: <20260223170212.441276-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

ICC_IDR0_EL1 is an identification register; we can implement this as
a simple constant value.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gicv5-cpuif.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index c591e249b1..36d1c196a8 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -38,6 +38,18 @@ FIELD(GIC_CDHM, HM, 32, 1)
 FIELD(GIC_CDRCFG, ID, 0, 24)
 FIELD(GIC_CDRCFG, TYPE, 29, 3)
 
+FIELD(ICC_IDR0_EL1, ID_BITS, 0, 4)
+FIELD(ICC_IDR0_EL1, PRI_BITS, 4, 4)
+FIELD(ICC_IDR0_EL1, GCIE_LEGACY, 8, 4)
+
+/*
+ * We implement 24 bits of interrupt ID, the mandated 5 bits of priority,
+ * and no legacy GICv3.3 vcpu interface (yet)
+ */
+#define QEMU_ICC_IDR0 \
+    ((4 << R_ICC_IDR0_EL1_PRI_BITS_SHIFT) |     \
+     (1 << R_ICC_IDR0_EL1_ID_BITS_SHIFT))
+
 static GICv5Common *gicv5_get_gic(CPUARMState *env)
 {
     return env->gicv5state;
@@ -220,6 +232,11 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
         .writefn = gic_cdhm_write,
     },
+    {   .name = "ICC_IDR0_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 2,
+        .access = PL1_R, .type = ARM_CP_CONST | ARM_CP_NO_RAW,
+        .resetvalue = QEMU_ICC_IDR0,
+    },
     {   .name = "ICC_ICSR_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 4,
         .access = PL1_RW, .type = ARM_CP_NO_RAW,
-- 
2.43.0


