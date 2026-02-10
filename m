Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A3AEA811E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpoAM-0002F3-BD; Tue, 10 Feb 2026 08:52:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoAK-0002Db-1i
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:32 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoAI-0006Nn-Gc
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:31 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so31615255e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770731549; x=1771336349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pdpSaZtGa5N0YXyoXR6kPL2wef5TSrP+IEpCI4EPzj4=;
 b=OTiRqXSopAa2tOY8vqzoP/YPDuPUnU1xUd8ggK6a1Gqh3gOxCmMuPclH35DK3Mg2IA
 I1xAbe+o3IKE7NUtAXh5IyIX6z85qWLMKiTNmdG43YIxy2Z9VRrB4GsSKphTYqY+h6Pz
 l1b1tRSu0hiEwTfFEyoxyV3b5J8p8IhZLlzkxQXuzeQjwd+Tj7Iusmf4gnyFHftJAQs0
 EL6KpbPmQD9cx2znLNtrTIxRiAHojx8XomQkpGs2bnmD1n1Br5qAHifhO88F+m8Q6s5/
 V+uf0sVCQT/1ZCD767pdONVtV49iRestWadI3P1y1iDap46AnqhhWxr+WXPvpfYzGWvx
 REwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770731549; x=1771336349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pdpSaZtGa5N0YXyoXR6kPL2wef5TSrP+IEpCI4EPzj4=;
 b=mnBCCLUQ7JYPaM0lmhqIgN8BBJLyUQWyUOrD2J5kdUL2MXiOuDMGzZb0rsNu344N2g
 ff6ruTjm90jNnsJRdhe8iLgmRwhGPc0Ux3e18EDmkbokSP8Kik5yh7UKruyXFWdbMXLd
 ZbMs4wk3dxIMnVXYRBM/J6+bCzIGWpCeAX6lkIvmy2PDULRDDBRdy1ASYSXpllbLCvT8
 sqqc9DJuv3ei+I4edO65GluaK5sW6EG9u12M7Hu9Ar8YITB2llsn0ABISNXMp88HmuDf
 DLPE1E/EcWi+4/9M6VFI3JLKrg/7WzQ29vSBOvHvlwqS6k5dupcVd9jVB/Fm6zyytgkQ
 Yt3w==
X-Gm-Message-State: AOJu0YxDvkColJITeuQUeNVW+y89VGcdcEv91GHPMjXctsvUNtfNhMzy
 7HROfycbph8ijCBf3W8BeLu16stSm0+gsc5jexnr5bxza7SszaahwjdbTXoMkO1PJDopwSScX31
 mpS2Q
X-Gm-Gg: AZuq6aJmoJwY8n1smjbemxrEOnMNRv8LXrFtH57YZVkPsZhDVPBkeLPJ6rdmtw8/UG+
 pgyeWFAXT7+xZRfGlngm2yiNDtGYRjfIo6kOv/D7vfv47ixWWFtv7OfpcVyvCkZp/oD9KQ/CSAw
 eeOqUTGu+Eais2bsTEiiLFB8bms6djvNSon5MVx5ou7+Gmu8FaymYNrwhF3cLRGwL72cJ+scOKm
 V+VqHX/9d/ZOapdrM/JIkYfRNDbdIhxJLG9n+GQrrmBa3oppwz2TayCJujK1ugMwpaQkNA5pQGQ
 uoQz8YCFqmI5lUGO27AcnbII3L++7k4c4IVhmFWzB/ZC7AkHBHayOr2LOQKC2vINQSqu/7IqUQN
 neYGqC+ldzWDlQu6NMJSUZ83UMFMoGevPtYmti6JuQ0zB2RUShtiL4XUeuzORspz63o+JCqOO+u
 L+DOMb7Rtom0yxqHsVxRGhtiuZ2d5wjm7VIR64BtAzUw6DUtC2KNxE/AsHUKpBYOS/AFK6vZ/CG
 jzM6crU72UeSWnFLDARyFgMFiwZu8A=
X-Received: by 2002:a05:600c:628d:b0:480:1c85:88bf with SMTP id
 5b1f17b1804b1-4832021ca66mr227640225e9.27.1770731548717; 
 Tue, 10 Feb 2026 05:52:28 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77f9sm64344875e9.3.2026.02.10.05.52.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 05:52:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/26] hw/arm/virt: Rename arm_virt_compat into
 arm_virt_compat_defaults
Date: Tue, 10 Feb 2026 13:52:03 +0000
Message-ID: <20260210135206.229528-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135206.229528-1-peter.maydell@linaro.org>
References: <20260210135206.229528-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Eric Auger <eric.auger@redhat.com>

Renaming arm_virt_compat into arm_virt_compat_defaults
makes more obvious that those compats apply to all machine
types by default, if not overriden for specific ones. This also
matches the terminology used for pc-q35.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 5c31695d37..02db6d8579 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -96,20 +96,21 @@
 #include "hw/cxl/cxl_host.h"
 #include "qemu/guest-random.h"
 
-static GlobalProperty arm_virt_compat[] = {
+static GlobalProperty arm_virt_compat_defaults[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
 };
-static const size_t arm_virt_compat_len = G_N_ELEMENTS(arm_virt_compat);
+static const size_t arm_virt_compat_defaults_len =
+    G_N_ELEMENTS(arm_virt_compat_defaults);
 
 /*
  * This cannot be called from the virt_machine_class_init() because
  * TYPE_VIRT_MACHINE is abstract and mc->compat_props g_ptr_array_new()
  * only is called on virt non abstract class init.
  */
-static void arm_virt_compat_set(MachineClass *mc)
+static void arm_virt_compat_default_set(MachineClass *mc)
 {
-    compat_props_add(mc->compat_props, arm_virt_compat,
-                     arm_virt_compat_len);
+    compat_props_add(mc->compat_props, arm_virt_compat_defaults,
+                     arm_virt_compat_defaults_len);
 }
 
 #define DEFINE_VIRT_MACHINE_IMPL(latest, ...) \
@@ -118,7 +119,7 @@ static void arm_virt_compat_set(MachineClass *mc)
         const void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
-        arm_virt_compat_set(mc); \
+        arm_virt_compat_default_set(mc); \
         MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
         mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " ARM Virtual Machine"; \
         MACHINE_VER_DEPRECATION(__VA_ARGS__); \
-- 
2.43.0


