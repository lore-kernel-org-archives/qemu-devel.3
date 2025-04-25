Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937D4C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Kzs-0000Mf-AL; Fri, 25 Apr 2025 11:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Kzq-0000M6-Qr
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:29:46 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Kzp-0003a3-05
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:29:46 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso1446223f8f.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745594982; x=1746199782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m/bacTSDHKX+X3/6lsFjSc+oRDkdg9IgOgsBvbEcNjc=;
 b=HiUQjbJORD1Npmtt982HzqwLvcNYl8rrZoRxKyI4eTcyYuD/5oeiYJx3MVrN/yzbOm
 0KesvkM5fB9iJxX7L33oiSFAaxOMIGkv2S4iVeKp65dEMT/ljThgHtusWxaBg/3aVdcd
 40LwxHJxG1ndH5Fz2tD5vO4E0AORNxC0Tdpv1jWCgaEnbXh6iVviM2DnG84c97mIglKy
 Lj1eZxAo1kWl2pLykxCtc2oozNeY1hL9OnpeCYxwKdOYEt6Y953qDpyiusjHLZLnHdZl
 iKVXs5ncAhpnlD+nkyYR8CWE+sRkwy5lWLcjZYAOAYiHJuBEAb+7o+hfsNQM5YpGkr5s
 G54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745594982; x=1746199782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m/bacTSDHKX+X3/6lsFjSc+oRDkdg9IgOgsBvbEcNjc=;
 b=ZDMk9OpmCL1ZLfonhDRzQp9GoWTSNYL5aihd+e6wnLQhDCGM80kagtN8evJy7xtwWM
 PB8YYAZFSZWshIz4fdQwvIGfbZ8AQGMhuzXRfz3E6swJD27jT2pDTO/Nq11fyHQLQVUF
 0a5fIUXw0mzrLHQb4cFg0SEDY+yks3rEZ/t0v6pVA+BvPO2xzb2wuFdhEl8mf+7O+df4
 K4PTkCrCiZG+Wp3uDHk0vZpwhCZHZQ1eoJUYAVf5QF9eXMsHmFCdfaPcGchf2fG6ZUuP
 azdhjlq+uM4XZy0iquc8A9PvRhMDDQvHy1YZgu8Mfn8t+lM0dqGn/L6OH7tqVHj72s5d
 qaWA==
X-Gm-Message-State: AOJu0YyddWt48gLOQYh1b8x0L+BveGcVs3osg6N3vo3duONcb5jNjqZP
 IGOD5bmUGNweyGuyZRhhNvpNRH593wYDUaS9kaUtckHpN5MV4ohWM0/ZT5l8H1v6+7t/Hy1vky+
 1
X-Gm-Gg: ASbGncu5MIoKzHmMaMPpNUtfPsgyncYOeoBi9w850u5FdJ+Do+EOOmab9NCt7R12W1I
 Ds9VEpEJ8Tl49wOqxZoFkvbp8vasxcs7PO4jyhJqgirJT2E9oEXNNE0rJQij7YZ7C33nyrNH6ky
 eLCxEWFl4Q1xrQEFwWY++XX4CkNrj3IHLVQb7V+2QLNp3G19DlzS85Iw2+3KfYu7f1EipDCsO08
 GTyzxNFD9TcupGkfB3rc+hdxOrQ2uBtwyJL68iVn/v55lB6IBBzduIgDMJk42gbCLFIIFEOzR+9
 B0dMXYXp86nZ+jaBl5S9b7Y0IxQO/VlXokZT2/Jk3X2rNKp2DUPbEpCFeX752dq+Jtl7Ul1kPss
 u2HePPho9BTRa4xbKx2A9WUu7eA==
X-Google-Smtp-Source: AGHT+IFPPCyM4Xvkj1c4lVahb9oZvr7puytyk/ulPAAfq82dLcPCoHjUbP8QxaYnWHfwm7iuotWHkw==
X-Received: by 2002:a05:6000:4387:b0:39c:266c:136d with SMTP id
 ffacd0b85a97d-3a074e0fb1dmr2249984f8f.12.1745594982637; 
 Fri, 25 Apr 2025 08:29:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e46517sm2636007f8f.71.2025.04.25.08.29.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:29:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/58] qom: Have class_base_init() take a const data argument
Date: Fri, 25 Apr 2025 17:27:56 +0200
Message-ID: <20250425152843.69638-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
Message-Id: <20250424194905.82506-3-philmd@linaro.org>
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
index abfcedd4a5f..bbff84855ae 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1243,7 +1243,7 @@ static void machine_class_init(ObjectClass *oc, void *data)
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
index 2844ec55560..475b97c649e 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2809,7 +2809,7 @@ static void pci_device_class_init(ObjectClass *klass, void *data)
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
index 34d7bc0ef96..03fe6247ff6 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -492,7 +492,7 @@ pub trait ObjectImpl: ObjectType + IsA<Object> {
     /// the effects of copying the contents of the parent's class struct
     /// to the descendants.
     const CLASS_BASE_INIT: Option<
-        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void),
+        unsafe extern "C" fn(klass: *mut ObjectClass, data: *const c_void),
     > = None;
 
     const TYPE_INFO: TypeInfo = TypeInfo {
-- 
2.47.1


