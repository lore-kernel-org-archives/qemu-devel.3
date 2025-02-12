Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE3EC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 21:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKNG-00058E-So; Wed, 12 Feb 2025 16:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKND-0004se-Pv
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:34:24 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKNC-0000Zi-9O
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:34:23 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso2195365e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 13:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739396060; x=1740000860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3tahwZukGhQY0cObaTIwWhUmXQqOFwvV4yeEEvNe3Ak=;
 b=YfIj8rwM399z1uK855bV+qJDRi+1SpaVlSr16qLYDrewAdegp0GidellzbfSF6Qa2Z
 Dz7WFTeKYgDMaQQtCr5lJUMrs5JX8gwAy1xh04/uLtDhAIy401UszLjjgQDFiJU+xwdQ
 b7BImy/kqG0+Y6wHq+Yz1JqGAV7VD1cH9MX8pzr+uLySYUcnnZ9xgL1e1YacNj+eryKz
 ikjVoKbVMDNnhauwPj0GiLktdeQDcMl1d4VHzRDroEW76kb2ECtHt0XqVFrWTU/LC6Be
 x23F31qjMfe4+YTFpucA1cvwc7CZuk3BUw63HTn3rMxQZDuz9D3Xo0HR3qQ+uCAGmjya
 MCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739396060; x=1740000860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3tahwZukGhQY0cObaTIwWhUmXQqOFwvV4yeEEvNe3Ak=;
 b=ayb8s8yJHuSZnONb0YMwG2SWoeStsq1RNqBEy2SUn+BypO5usO3g3+e1Oh48o1O4SB
 cKNCQwdN3VX4uOc20JJq/g0EvyeVyyfEFEqyYc27mpLIk5O7w9pZ5TCJ/ttxFLowUU7Q
 rzFFCcttx3tlPdDQT3l3V05znBi6KxlibCF6GwyoXOtu9gb4AxUB3u196mNoHGqlf0/+
 dM2lG21pLCecNrSvyeBfmnWxq6rwvrTUq2TBxa7uMnWyXNWm6RPdiQ9Fe8Pv6OTmCvBf
 GnXvXELakP5XFM0hn5sdAdHZkcRiJ/ZXc5UgVmkfwPgkL5epmLi1V9pYnYXPssC8fov8
 ElGQ==
X-Gm-Message-State: AOJu0YwLrKhzCxWuf40lVfZ8kpuxD4y5kCdXJU9umoXz6YG1X3T2WcA6
 ePAJogTwpDVzulNc9GPbLOCjacg0bzBe2gRI/TPk0rqQDq7w8H4FQCECBAfNNhqNW7LuOtn2a13
 NlMg=
X-Gm-Gg: ASbGncuwKyjo7y5B3iBnIwUSSmXv7W30YaKctUsQBaAsBRKeP3996poUfhFlqIYFb2U
 Sj9bn+h5op9Ot7hHx6goQMIqXIlmHWiK4jBN8CNErPw/Qvt9U7BS90QYhtnvuBllagvKVvaxw3k
 3iHKaL+lTWYinw7o2cQCurVbYvSs+d56aJd55dH4BriHzMVC63WqweFNVa2L3XRE5Q1V44Uq2cl
 l+aARCLmXBbuqhdrrTppWIEKasig92HA2xLGd4yh7txPUX4BPJV1vrq131d24xSZwiZlu628ELd
 JDk/XoJzh7uAZiI6xDswJ1CMv+1+GQVxfJGsr4EibDezZTAFPTbeB/qjhnRh1zem8Q==
X-Google-Smtp-Source: AGHT+IGotS/3O+wmWktJ3ePo6qnkPb9/U65PSkIDob5JtKNMlNKiqGE7pwYsoUqmKRm9Zuyd9Z+05Q==
X-Received: by 2002:a05:600c:1e0f:b0:434:f586:7520 with SMTP id
 5b1f17b1804b1-43960185f0amr11972505e9.6.1739396060389; 
 Wed, 12 Feb 2025 13:34:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d5e9esm20117f8f.61.2025.02.12.13.34.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 13:34:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 17/19] hw/virtio/virtio-pci: Reduce generic_type_info scope
Date: Wed, 12 Feb 2025 22:32:47 +0100
Message-ID: <20250212213249.45574-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212213249.45574-1-philmd@linaro.org>
References: <20250212213249.45574-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio-pci.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 6f0e1772669..99724deb3d9 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2488,18 +2488,6 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
         .abstract      = true,
         .interfaces    = t->interfaces,
     };
-    const TypeInfo generic_type_info = {
-        .name = t->generic_name,
-        .parent = t->base_name ?: base_name,
-        .class_init = t->base_name ? virtio_pci_generic_class_init
-                                   : virtio_pci_base_class_init,
-        .class_data = t->base_name ? NULL : t,
-        .interfaces = (const InterfaceInfo[]) {
-            { INTERFACE_PCIE_DEVICE },
-            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-            { }
-        },
-    };
 
     assert(t->base_name || !t->non_transitional_name);
     assert(t->base_name || !t->transitional_name);
@@ -2507,6 +2495,19 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
     type_register_static(&base_type_info);
 
     if (t->generic_name) {
+        const TypeInfo generic_type_info = {
+            .name = t->generic_name,
+            .parent = t->base_name ?: base_name,
+            .class_init = t->base_name ? virtio_pci_generic_class_init
+                                       : virtio_pci_base_class_init,
+            .class_data = t->base_name ? NULL : t,
+            .interfaces = (const InterfaceInfo[]) {
+                { INTERFACE_PCIE_DEVICE },
+                { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+                { }
+            },
+        };
+
         type_register_static(&generic_type_info);
     }
 
-- 
2.47.1


