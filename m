Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B050C021A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 21:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKMQ-00034j-Qy; Wed, 12 Feb 2025 16:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKMQ-00034b-5A
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:33:34 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKMO-0000WZ-I7
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:33:33 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43948021a45so1923865e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 13:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739396011; x=1740000811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AFP0q4a5BbpXO9N+k9FpLHSVcTPUWaHfXxJUQBy2kxE=;
 b=xCdlVAZw8bWD5paEKEuKOWCZl7+w3JEyjILngVA2m0qI120a7/ACqaU2cZxHeO+mRw
 BxnXFfWdSoE3QXVvZjLjMO1dUIB7+8L4X7E6zXKPjK93hxG5vpPWZT3QMVsxypHIBysQ
 i2wBED4+QZ+ERrjlcyN0zDWsTUQ7PN4UhjGmCqOYZSRBK4LAro2nEwDCUd/cnviZYa2h
 5Ri+q/emstyh2tLDVIyQ6o/LgQb1NULp/+2UkKGvILK/BaIamB2UiPbtYWqLeCl6529g
 hPlbnJkViLEl1VDvMwoHPaBsRaPosLAfxcFojVMa7vbLKYm/1mA+aPESuJqYWbhznDn1
 B99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739396011; x=1740000811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AFP0q4a5BbpXO9N+k9FpLHSVcTPUWaHfXxJUQBy2kxE=;
 b=J3jDYqG3u0hNYq73TbOVxRHwLo41LV+fw1M7i1vf70eW2COGFGeTWzMULs1vC6zqYv
 eJQ4t4P3veVV8eVCUiGp36ed6TlmJJmUjjZbaovALdAMVcVpDeGQ5x2X0EO9OwmAdkYJ
 zbJxDqMg/4piz0Jvo5G8yjnbVwhu/OVX3oJDtGB4+rldUDY4ujAO+sYwklwJ5RyeKlmd
 CuPV+Kvvp/OZnrdpVVFOzYX9Y9yi9TCB34iMlPyWfEpFgCnl+0Ae9SXXkccZkACLJ8X3
 vew8U/q5m0cjxZ+b9O+JpMUQhdiJFUqrk2py6owEfqjxaxER+qlVIE9Kj1wrGb3JJLTN
 CDrQ==
X-Gm-Message-State: AOJu0YxiTfJNQVUmSaA8v27Z0wwdmweAz5rTJ2dH8IUp9+VXqo2Tbk4E
 a88dnDFS9HVUozVfb5GmqzwDQwFUqGrrrlazODob0UQvBPuzNOVq6wPZkTPRJiRTibGFVIAb4AR
 B84c=
X-Gm-Gg: ASbGncufwD6qntexQhIerX4UjvSbnS9egCbQQUDJLkDyiJJwAkIhoHGgQjEC6AfG6tU
 aPUoUSaf6AQwLZzLo9dSMqdMEvad0I1zHQ1fXQUgyEV822ZTau1HKQRcmNYOtzVx8yFSTsU+Oq3
 ONIL7gMr7d24M+xuOjY3SKClMxHFXInYeuoUs4YwdoLH7x/rODhZyQRnpPZ19/K/dYJjBDyK2/1
 GPP6hDpAUTaKnf2ax99GXmRHdObBrVgbyD+6uemAafzID8B1ujTKMVGwDDzU/0e/llYb+63kNQ8
 m0SmB7l+6i9c8D5tnNOO8Hqfz4QyeoVDIoZlNezq76MTJy+rWSzxygn2EQpid610MA==
X-Google-Smtp-Source: AGHT+IFF2N3A/XD7OM1l05/vSyz0Y0A/WB6aHsP3qelGoXl8VR1GpUMZC9F6AMx8/VzG+KUv8RHTSg==
X-Received: by 2002:a05:600c:3b82:b0:439:31e0:d9ab with SMTP id
 5b1f17b1804b1-439580d3a55mr54219565e9.0.1739396010884; 
 Wed, 12 Feb 2025 13:33:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f7987sm21121f8f.87.2025.02.12.13.33.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 13:33:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 08/19] qom: Have class_base_init() take a const data
 argument
Date: Wed, 12 Feb 2025 22:32:38 +0100
Message-ID: <20250212213249.45574-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212213249.45574-1-philmd@linaro.org>
References: <20250212213249.45574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qom/object.h     | 2 +-
 hw/core/machine.c        | 2 +-
 hw/core/qdev.c           | 2 +-
 hw/pci/pci.c             | 2 +-
 qom/object.c             | 2 +-
 rust/qemu-api/src/qom.rs | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 9192265db76..7bb14ca7067 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -487,7 +487,7 @@ struct TypeInfo
     size_t class_size;
 
     void (*class_init)(ObjectClass *klass, void *data);
-    void (*class_base_init)(ObjectClass *klass, void *data);
+    void (*class_base_init)(ObjectClass *klass, const void *data);
     void *class_data;
 
     InterfaceInfo *interfaces;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 254cc20c4cb..7bdde9286c2 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1236,7 +1236,7 @@ static void machine_class_init(ObjectClass *oc, void *data)
         "Memory size configuration");
 }
 
-static void machine_class_base_init(ObjectClass *oc, void *data)
+static void machine_class_base_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     mc->max_cpus = mc->max_cpus ?: 1;
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 2745b5e0929..1e0f47cc848 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -693,7 +693,7 @@ static void device_finalize(Object *obj)
     g_free(dev->id);
 }
 
-static void device_class_base_init(ObjectClass *class, void *data)
+static void device_class_base_init(ObjectClass *class, const void *data)
 {
     DeviceClass *klass = DEVICE_CLASS(class);
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2afa423925c..00f50e6f2cc 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2712,7 +2712,7 @@ static void pci_device_class_init(ObjectClass *klass, void *data)
         "access to indirect DMA memory");
 }
 
-static void pci_device_class_base_init(ObjectClass *klass, void *data)
+static void pci_device_class_base_init(ObjectClass *klass, const void *data)
 {
     if (!object_class_is_abstract(klass)) {
         ObjectClass *conventional =
diff --git a/qom/object.c b/qom/object.c
index 01618d06bd8..dfd59502d11 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -55,7 +55,7 @@ struct TypeImpl
     size_t instance_align;
 
     void (*class_init)(ObjectClass *klass, void *data);
-    void (*class_base_init)(ObjectClass *klass, void *data);
+    void (*class_base_init)(ObjectClass *klass, const void *data);
 
     void *class_data;
 
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index f50ee371aac..f3d43e066ef 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -475,7 +475,7 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
     /// the effects of copying the contents of the parent's class struct
     /// to the descendants.
     const CLASS_BASE_INIT: Option<
-        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void),
+        unsafe extern "C" fn(klass: *mut ObjectClass, data: *const c_void),
     > = None;
 
     const TYPE_INFO: TypeInfo = TypeInfo {
-- 
2.47.1


