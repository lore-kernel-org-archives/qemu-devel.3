Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3A3FCB602
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytYu-0005CP-HV; Sat, 07 Mar 2026 10:27:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytYo-0005B1-Uc
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:27:27 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytYn-00086s-BT
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:27:22 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4852a8482fcso10547495e9.3
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772897239; x=1773502039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UqlV0omFkY4cd8RSAFIjKr/FAFV4g/FRjEhKaLfJK7Q=;
 b=vlaGQwkU2xoWIlilPU4C+lFyPHFm3dzZqtN9LVK7xzRkhyg8ORmQF9+AC12h9R7T3/
 FX/8RcGS1hN73BUeJbYOuLRFI1bMNvV9uYrOjea2/mYbsXHQYOwECSwI0f36Ohu5+/NL
 +L/prG32wyM6y8ALxzB2wbYl9VLEGh/dFhzWIQrDK7f9xmNnEkH0jeVbIrUJygSCr+8e
 4ASZfXTem71Wa1ZdYzmjV1UXFLZuSjG0s5FQsh5BdeJvxRTyfVPX5JjMVuyYdVFXeeSB
 vP4s7vCjcDo0bgeC0tLrgR4FwBe01LwjLdtOPg3fV1vGtDlzQk+hcoNbPSfFvsdJAGIR
 HYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772897239; x=1773502039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UqlV0omFkY4cd8RSAFIjKr/FAFV4g/FRjEhKaLfJK7Q=;
 b=l6I00ZvIuv+yZEOl3pJQO5lsNRAShqJmhBb4SPsP2OkLeYzkTSkQPBLel4FNPneEZ/
 kSmf2TDzcD7LXuXt9IS+ltSn+nx3LHhp5FRMta1dxxx9TsvvlgD6XlitOZAzA1oVscPv
 EEvaxsevjBo3EEoYjasnIQjmJ5K4Bf77pLUE6GB87lx25dT2te2seKWAyuUnG6F7Q+h2
 AdXG3+JFcIqz+MABJnCu/352R6De7yaVb2vgUdIuAT9lFfq7cHd8Pts5KRp3Fu4VE1zi
 rE+hbjVUkMmwlNWgl/I1FjeD98/jfG5j5fp4cOQ1wa/6Fubbes5R/VI0yoqWmZ5q4vXY
 CcMg==
X-Gm-Message-State: AOJu0YxFiRDR20isspqxwgV75dlP/lYoRzV56QHSv/lLbbvWwiUkZl5i
 Y2czdUtk0YaDzyXKzfpOaoMmOQgGCKvrPO/1I0TQ7kCsgZDBaket+ewY0MvvqzzL2z6rv4bk24o
 M8Uuo8PE=
X-Gm-Gg: ATEYQzwEudxhfFPtVGhRygDPhPEMbLreu+cRMq8iprg6lnMD/w/lSXMbArKRgJh269q
 J12auVu9lnL2KT60XaGQ5E/Y8A+YMvb9Iaxb1e4KVdGWg6OAzpDsnlW1B9DCosoy0RBKHd/LDtr
 Ud+lEE/4Rz4XIlEvBbaybdqho9b2IpLtrglVjo2s50MqXeEBa02hf400hQmF9xGLKYz4VD6/H1G
 DA++8xbbh3mgqcTQWrI5VCQ5+4z6ACtrYaSzh/7iBX3K0und7YoQsUt0qaIuaINWOp1EZFrb3lP
 PvBASo2lQuwQJ1sI31WonN0tUNuZBkl6M/I97poiVV/skNtFQCslabLlqnDrHmbv9wnrp1kWwEh
 Lp68WkiQiqMkD6sNXw3+0eCN/1l3IrneoiL50ygcMym4eNNttmPdpkA7EwOT4WtE7Pkxc6j4ykm
 PQfrJG3/z8Miijsk/mEJ4yB+7WayGO0kACeVCVjAnvZD8gcO/Ex+tcvzFIME6cIIh9eZ6YXaMA
X-Received: by 2002:a05:600c:46c3:b0:480:6bef:63a0 with SMTP id
 5b1f17b1804b1-48526959433mr99455745e9.21.1772897239540; 
 Sat, 07 Mar 2026 07:27:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fae0202sm275919625e9.6.2026.03.07.07.27.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Mar 2026 07:27:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 06/10] hw/i386/iommu: Remove IntelIOMMUState::dma_drain field
Date: Sat,  7 Mar 2026 16:26:30 +0100
Message-ID: <20260307152635.83893-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260307152635.83893-1-philmd@linaro.org>
References: <20260307152635.83893-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

The IntelIOMMUState::dma_drain boolean was only set in
the pc_compat_3_1[] array, via the 'dma-drain=off' property.
We removed all machines using that array, lets remove that
property and all the code around it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/intel_iommu.h |  1 -
 hw/i386/intel_iommu.c         | 11 +----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 54c2b6b77a0..e44ce318417 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -314,7 +314,6 @@ struct IntelIOMMUState {
     bool intr_eime;                 /* Extended interrupt mode enabled */
     OnOffAuto intr_eim;             /* Toggle for EIM cabability */
     uint8_t aw_bits;                /* Host/IOVA address width (in bits) */
-    bool dma_drain;                 /* Whether DMA r/w draining enabled */
     bool pasid;                     /* Whether to support PASID */
     bool fs1gp;                     /* First Stage 1-GByte Page Support */
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d24ba989bfc..f395fa248c0 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4205,7 +4205,6 @@ static const Property vtd_properties[] = {
     DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
     DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
     DEFINE_PROP_BOOL("svm", IntelIOMMUState, svm, false),
-    DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
     DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, stale_tm, false),
     DEFINE_PROP_BOOL("fs1gp", IntelIOMMUState, fs1gp, true),
 };
@@ -5000,11 +4999,8 @@ static void vtd_cap_init(IntelIOMMUState *s)
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
     s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND | VTD_ECAP_PT |
-             VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SSLPS |
+             VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SSLPS | VTD_CAP_DRAIN |
              VTD_CAP_ESRTPS | VTD_CAP_MGAW(s->aw_bits);
-    if (s->dma_drain) {
-        s->cap |= VTD_CAP_DRAIN;
-    }
     if (x86_iommu->dma_translation) {
             if (s->aw_bits >= VTD_HOST_AW_39BIT) {
                     s->cap |= VTD_CAP_SAGAW_39bit;
@@ -5582,11 +5578,6 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         return false;
     }
 
-    if (s->scalable_mode && !s->dma_drain) {
-        error_setg(errp, "Need to set dma_drain for scalable mode");
-        return false;
-    }
-
     if (s->pasid && !s->scalable_mode) {
         error_setg(errp, "Need to set scalable mode for PASID");
         return false;
-- 
2.52.0


