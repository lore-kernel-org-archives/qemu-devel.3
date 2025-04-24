Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15783C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 19:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u82Zm-0003JZ-Ju; Thu, 24 Apr 2025 15:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u82Zk-0003Iw-Ac
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 15:49:36 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u82Zi-0001QX-Dm
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 15:49:35 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39ee682e0ddso981396f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 12:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745524172; x=1746128972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11yASgslBTEDeAvinIeNK9fxBiH+5qVPG7ODqw+CXyg=;
 b=TkaSBkjV17oqskRyoimUBhOlP2qQOvyEEHhOVt62ODB49l6rDNmMCcXmiG7qklCL6K
 AjAuNnXRgoC7wwdh8ZOKbjxUwdDDgSuIORyu4YTMl8wODXR2jiuPFu2y/aiLFakH53T4
 3Xr3nlNjYHDzEjPuYI+BThdcKQjKjNvxSD91radGJ0WgURx5NIumeyWcDf1EweNJYCF3
 WKXxJIup8rHExOGgCzaXWqZOWSmr8zHaV7/0oksR3VbCJlapu3MlNocucpvaOIUXH/p4
 XeOBFPpfy2AYYKe1uRdFHNjO7cN1vn/+LyHuDzPOF1XbtG57IM20d8DGc22Z+yA15J3w
 JUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745524172; x=1746128972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=11yASgslBTEDeAvinIeNK9fxBiH+5qVPG7ODqw+CXyg=;
 b=THBFVM72KbjYJINDcYK3xJJ55x4rwRtqWoC/OMqKQUeRuo/J0gUrFVFaRmsXgCcOCY
 vm+7u07j2o3Pz8F6hpsgOhMJ9gYhtuCZfPDM4yolQyiiiP7B57d+Kf8LXUQq31275EdF
 O41dOfEZkbYEGqh3qLP4ZfqNoM5lsQ3um5RTqb8hcubOvH7x27zQVmKluSg2rAcdmwub
 S+WqXtu1W2Q9uZnMhUnwaYdc5ifvRQNb57FFpbD1CMxCxV6qvPYoWE+75Q4mPJo8S3Qy
 VKEbhCghfElxbazSetOz5Mu8MNX5UPTTPGdTD4eSecQktM+KlNahxWqYSR0cdlA1/pz/
 23Fw==
X-Gm-Message-State: AOJu0YyuvcIyjYu1wpqQrv+/WLTe/eqmeYBmpJjbDOLlaxLwOk9v1pBf
 7k/1No+djqFbg/AVsgYEGJFkeBk/wy6H3pMbFEIAewT4nXXjaLMphj8ssDs6T9KBzmHkqyr6t7D
 Q
X-Gm-Gg: ASbGnctaUxTi898mmmWyk5O8B2xgB7Mqod1aC/nNMdt8awG43sWrvYwrw4iHMgkYq1r
 lAjUP1/H6YnGItQ+qcl/wySTw3G+4xp2dsvBl2K2zIRuyZsU2bpnf8M+TRVnjA8RsHhr4dCJ5Ca
 fVBGVPVmz6uU77LDIxP+opI/6Vch53ms9D+ShFsauLky00GXFh8pT2Pmgqkt9rad6YGEuYD13wm
 WaIbDhYW9CLFk7O9Y3bG3wbzsA3lOxuXxV41ku/4Pzmyy6Y86iWqPoJq0nEvRUf0vtNTlONGcfX
 mMqqzoCeG+VpEWZCdmRxJEehfACEnTqf07Y8Ng1G5w1cgZKihGeiHU4XAjNCJs7TLx+IpKZaJ76
 0Zp/BNVBPu/b8G9GYcIovDswFwQ==
X-Google-Smtp-Source: AGHT+IHb9nqCvTwuazqYlf7FG6lR7yHv+f7TYjWYC9IxZvd3B260qtAJlT+oJ/K05VvLt4rA09BFFw==
X-Received: by 2002:a05:6000:4023:b0:391:253b:4046 with SMTP id
 ffacd0b85a97d-3a072a7d18cmr549762f8f.16.1745524172443; 
 Thu, 24 Apr 2025 12:49:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5cb16sm166565f8f.84.2025.04.24.12.49.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 12:49:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 5/6] qom: Constify TypeInfo::interfaces
Date: Thu, 24 Apr 2025 21:49:04 +0200
Message-ID: <20250424194905.82506-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424194905.82506-1-philmd@linaro.org>
References: <20250424194905.82506-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-pci.h | 2 +-
 include/qom/object.h           | 2 +-
 hw/scsi/megasas.c              | 2 +-
 rust/qemu-api/src/qom.rs       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 567a9b0a9da..31ec144509f 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -256,7 +256,7 @@ typedef struct VirtioPCIDeviceTypeInfo {
     void (*instance_init)(Object *obj);
     void (*instance_finalize)(Object *obj);
     void (*class_init)(ObjectClass *klass, const void *data);
-    InterfaceInfo *interfaces;
+    const InterfaceInfo *interfaces;
 } VirtioPCIDeviceTypeInfo;
 
 /* Register virtio-pci type(s).  @t must be static. */
diff --git a/include/qom/object.h b/include/qom/object.h
index 42b75d10a43..26a45f638cd 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -490,7 +490,7 @@ struct TypeInfo
     void (*class_base_init)(ObjectClass *klass, const void *data);
     const void *class_data;
 
-    InterfaceInfo *interfaces;
+    const InterfaceInfo *interfaces;
 };
 
 /**
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 6104d4202aa..ad258c1014a 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2487,7 +2487,7 @@ typedef struct MegasasInfo {
     const VMStateDescription *vmsd;
     const Property *props;
     size_t props_count;
-    InterfaceInfo *interfaces;
+    const InterfaceInfo *interfaces;
 } MegasasInfo;
 
 static struct MegasasInfo megasas_devices[] = {
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index f0a79f96d5e..f1b4022157b 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -514,7 +514,7 @@ pub trait ObjectImpl: ObjectType + IsA<Object> {
         class_init: Some(rust_class_init::<Self>),
         class_base_init: Self::CLASS_BASE_INIT,
         class_data: core::ptr::null(),
-        interfaces: core::ptr::null_mut(),
+        interfaces: core::ptr::null(),
     };
 
     // methods on ObjectClass
-- 
2.47.1


