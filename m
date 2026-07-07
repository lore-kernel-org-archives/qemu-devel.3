Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054EDC43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5eL-0003fL-Az; Tue, 07 Jul 2026 09:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5dt-0003Dt-FR
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:15:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5dr-0000eU-SK
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:15:17 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8i8m3742128
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:15:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2+z8poJM9049xhIW9DHOkqApxurQIMrtrakZfDdgwws=; b=I3UDbAQkWhNhxQTX
 12NCoDWuS020DUFs0BkCyQJYLsRZqTPRrvehkuc4mKriMxsf0WBaSUjhqomNSbbB
 uJjZgjRHjleIy8dyjL3kw5JqmUEMXZ9x2S/A+Umv3B5YvoMiHltTdfFHmKDPZgdC
 D6lZWCfE1LTckebubnHMmakToZNJTd5qr8qCL/Ih+TlXBZy06HnlGxx2kbBbcWoW
 1eyeJxJjujZ4iABWlxxwgPF4SaAUvM5lD92jultaOcOpoND3YJ3GGox8cMzZXL+2
 iGuIMm5HnNMl1wmArIMdE94rWG/sm+jnjqEFygvuxLyRNlYjHSmube2utKriZdU1
 MP2gaw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8ye0gpw8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:15:14 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so54953091cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430113; x=1784034913; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2+z8poJM9049xhIW9DHOkqApxurQIMrtrakZfDdgwws=;
 b=h0an7EWXrN+t4C+LuHxqlm0ShD3DnwG3hZJKVtC+AnJSXAJiAEXK9nwKRU/QwykqNL
 j4fG5b3oOCy46a1CfjzCteOReWU09X8vJ1JEpOdR8r4kpKJyQxLHNog9ggMJwH+IGVtr
 zOwlIManfN3kOJXrjueTxHuVUutsS/cfPJFXJSXimqDhtyygWLeQNfGttsbCOoG+efYV
 TCsKcHEjrZSjivUp5rEwfY+bc2tjRqo5FUnhb3BLxPPPZI//ATZW4stgxwCZ8WKfnl4o
 jY6GQHbfMO9PoCEajhqvD3UxVxvS5xVBEpSvTAjEY8EZ4jSHQLoR2BKAvS1HME/NJ8ur
 55Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430113; x=1784034913;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2+z8poJM9049xhIW9DHOkqApxurQIMrtrakZfDdgwws=;
 b=RX3xHb02fSeI+ChXIyaFIrIZBPYMsaUoRWt+DgyE/6U8sztNFANqbVUUAjxhMuNJcI
 g7eCfYR7ThfGeyiie9r2IjIwKwAceDOYyOxMvKF8M6WMYWqrhdB5VWEoQquuhLnSL+gT
 t3sOzguSNrT1HIC55Bb6PxXw6ZhIPDYZA6cgCaaQdZ59AWEFL23bvmiTe0u8GTs/WVkf
 tUs81k+FjK4JXlc/3GgqOjcQ+i3WPuoDfsnGg0pewGr1KBFadqkjYmlbzFwgt950L+A+
 LMRAr0H/5b7MUPO7RhdP98Zeu1ra/LvrUOmEqI2+1ZxsllaCyjG3cUyTf8dIWpT6GOq1
 wCfQ==
X-Gm-Message-State: AOJu0Yxn8Rws3FragojjKfPxl7DCC7G6zVNIYA+RUdpEhnerQeHEuAMw
 FcfZHB9hRnTqroD6gAK4mtcwD1+5hx1ZdfoDWHjyfQViOYNHnmBVLa5jJy4BAcg8tqRHemFSwxi
 Ks0LfmmQC8F3ofPs1YNoO6vuqcxP7ArDd9W35uFJE2dZUYIlPBG77HGry1TQmFcqA+g==
X-Gm-Gg: AfdE7cnlfodHiK0C1y6YriGVi7gdTKlKbMpKS5acIwBFick+KRMMDj/PO1uJBEjIaFB
 rf3UHUosrXsOwsP1jrBpVCxSoaYcqQ/k9EvrRqLyise3dXJmsvjVv8k7JpTpVMnaTEs231L3UUQ
 WIdjZygVT69XdfenxMScHPWqGcDgC7rGg9P0wgUjlBPl9heyKFh3fs+uam8/lR8rAsEl8N4zsqv
 lmRWZU5Yk3s+f5IT4L0Hb4XNApTuTFrBF1pqdtAfLlclLvl/c6UKCGtwdH2te3MwEjZ1KA8upMw
 OVuTCv/HbSETYtsL4GxDUcWX9g4Lt9DbYtw5SRQuBIjJM1Ch4MtVQO6XRhvI187irDwm0Mf4b3U
 12E1GfCSYtOV4dLKhL6J+1P2gzMyE8liCU3w5Qgusrljpr38fcBQ4WgHnde9MqzOpBf9J
X-Received: by 2002:a05:622a:1b10:b0:51c:7b12:5ff4 with SMTP id
 d75a77b69052e-51c7b126584mr22651091cf.80.1783430113268; 
 Tue, 07 Jul 2026 06:15:13 -0700 (PDT)
X-Received: by 2002:a05:622a:1b10:b0:51c:7b12:5ff4 with SMTP id
 d75a77b69052e-51c7b126584mr22647391cf.80.1783430110182; 
 Tue, 07 Jul 2026 06:15:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19dbee72sm5922391a12.30.2026.07.07.06.15.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:15:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/32] hw/acpi/ich9: move initial property values into
 ich9_reset_properties()
Date: Tue,  7 Jul 2026 15:12:13 +0200
Message-ID: <20260707131223.51505-24-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GUrl6KsPucToGdt9SXnbJNFZJIokOrSB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX9/ToXgBLuDQI
 Mrg1fXWyweFZRzqv8/kLpVmFqJTQqvOiXEUJWFAvLNIYGvOTcx5bLNyCtM8Z21PL6ZOTd6Fd7dE
 4C1KobOkxNmR5RDFw5bh5mi2JXqhmcQ=
X-Authority-Analysis: v=2.4 cv=SZfHsPRu c=1 sm=1 tr=0 ts=6a4cfbe2 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=IgTeGzRZ1uGHlxDtOR0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: GUrl6KsPucToGdt9SXnbJNFZJIokOrSB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX6Z0eTGJDjcjK
 ahokbFak83NZoYvqXt+J2vOYRqh5IvYeGYvHEGdziEfGZtJYszFAnpfBWbucGum1cI8Aeg8ESka
 Us6NoyQNMKGjagWoMaHHXTudDt+ACEtTIqh8vb6+HdcsNgi5uwx7pHPW+oKCWdDlmC5su8zbgH9
 q0tediHCC56L26qU1A9jjOqEMmID2RL/reUzUfVlHUz6RDq64XZRbf+qIh6IQoJi2SDfLMPKP+Q
 l7HwqVWQ9a9dNoDO1cmPZqZ7w4saeq4i9geRSeYkj4YmsBBVmprX7MYrlJORiRjX3Zo5AoWVtpj
 5+KCA7UjKZj5HC9lYOvaI6OqhXgv7aOGlHvqNZVmylUHQjYHebaDhucrLiIRWesYFHvhEOdorxK
 9+SVZy4hfWsfFElipy9hnk8jONhLIuPxtdW1hCOw/KC89F6XaXtznpglhewE9pehWBWW1BCFws+
 sPHvyDH17V6MSFm86Wg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070129
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260703135512.3213964-7-mark.caveayland@nutanix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/acpi/ich9.h | 2 ++
 hw/acpi/ich9.c         | 8 ++++++--
 hw/isa/lpc_ich9.c      | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 019f0915c11..30990fcef53 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -81,6 +81,8 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq);
 void ich9_pm_iospace_update(ICH9LPCPMRegs *pm, uint32_t pm_io_base);
 extern const VMStateDescription vmstate_ich9_pm;
 
+void ich9_pm_reset_properties(ICH9LPCPMRegs *pm);
+
 void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm);
 
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 5c7dfb2c69d..5e8f8a7eafa 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -388,9 +388,8 @@ static void ich9_pm_set_keep_pci_slot_hpc(Object *obj, bool value, Error **errp)
     s->pm.keep_pci_slot_hpc = value;
 }
 
-void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
+void ich9_pm_reset_properties(ICH9LPCPMRegs *pm)
 {
-    static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
     pm->acpi_memory_hotplug.is_enabled = true;
     pm->disable_s3 = 0;
     pm->disable_s4 = 0;
@@ -398,6 +397,11 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
     pm->acpi_pci_hotplug.use_acpi_hotplug_bridge = true;
     pm->keep_pci_slot_hpc = true;
     pm->enable_tco = true;
+}
+
+void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
+{
+    static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
 
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
                                    &pm->pm_io_base, OBJ_PROP_FLAG_READ);
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 9cec18a378c..edf9783ec8d 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -701,6 +701,7 @@ static void ich9_lpc_initfn(Object *obj)
                                    &lpc->smi_negotiated_features,
                                    OBJ_PROP_FLAG_READ);
 
+    ich9_pm_reset_properties(&lpc->pm);
     ich9_pm_add_properties(obj, &lpc->pm);
 }
 
-- 
2.53.0


