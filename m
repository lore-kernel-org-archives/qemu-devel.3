Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BCFF5141C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytnb-000308-Iq; Sat, 07 Mar 2026 10:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytnY-0002t3-2U
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:42:36 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytnW-0002bk-F2
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:42:35 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4836e3288cdso69635755e9.0
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772898152; x=1773502952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=19Jh4cxb/4s8fkFA1FRyjet0D0g0yjU6dnxuKdjK/IA=;
 b=PwXYWHQgG3qRv5eJ2/LM9NEz5QKBg8QSl7QLqKa1ex3ZnqTeywJqKpW9eUAT9QMU4P
 bO8H0euACid2sb5OWqfUV8M2Uu9MnXf4yag/jjfOgvie9HNZmgoqDqJR4gOFPAXtxwyW
 DRQOVyX2/Y5ZCGabqVmbhw5gtrPaob/xGRuUM70V3IccY8EbfAe3FqyhbwWonpGH1erE
 iwhPYCt/5KqA5BCfngG6pikwElx5oRmDqhr+WlW8DehnR3wN2hVEDMVORjD5nmzipz29
 4qlhEBa2StwlrsVdZhPdlNdhVxGkffWO3MBJH0+JcCHrT4TBskDQpMquUq1LGaDIbK2z
 ghTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772898152; x=1773502952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=19Jh4cxb/4s8fkFA1FRyjet0D0g0yjU6dnxuKdjK/IA=;
 b=J4m36aM2v0wWDvUYw4fLqcarEOt/RgYA8FIf7ofXXFLmwqYrX53xCeuTAVROrnGL7T
 hHtqfSSqdyR9U76eKEbpebbY+q0ndjr8bGz6k4C0zt4H/bhS/LQpagZ0z+s5hYf7v8pM
 tw2bhrgjOBwF+KmBuGgYk2isaSuA/8oczChmk5s086Dch+/I1bkTKhRLjDQ54G9GVTY4
 ayKi9iCTyKizfyAuT4UFMCkIjSpOe1qKdbdDdjvmceNe5tEDpokxQrOzlM/+qJS/JXyy
 eI6/SnPyuCe28jE694K9nDKXE1Nq9sLHP5HvS1fjiLS+9lhbt3xpv65Qk1P18nEBJjpR
 aMhw==
X-Gm-Message-State: AOJu0YzT4dH//D+UB8IcMTKBHvz6brBbirBcEFrriHXSphBvgJ19TT/x
 b04XTg2TojqU67nkp2g6ViyV1FUSuAb+b761lYcfSks/53Qs4/e0QrPL549RBzEaUpViY3qgJAi
 RIxlxJY4=
X-Gm-Gg: ATEYQzx3X/lVNaCmpBh53dQZ5fxTIgwSxjciG1cjgLK9XO6B75o0C4i4OQ+VNxM4gOP
 IRqt0pX5FP2567Tz9DysNyT3icAnuJMaq6PJFp8SVg7SixGdi/+Dl/fVtU2Nlr2cI/B0tLH1sPM
 qRoz/lLVhvmPZtj3hvC9o6Z5mf9B7xKDCVovKoIZvBLeJTC9a9gwmN6+VChsljyYLDzX75F96zN
 zEtHO+uMo550mriKWOskn1Zxpg9Owy91n4ehqecckWWld9HNPrJv+mdB4nEp4O8WvcGai7hZ7ZL
 5jS9i5ilwj62/kACpvlh0Xf5Am0S4131SoV0egbATbRbWHqyFcXHTTZuHiklqCIuwRsL4HwPsQG
 GqD4VDgOvgN9p1+ouEj9FyrnGyJwmIoEalGbXLI4OQ2elgZnIFVFXK2Zn3ilQLlx85BnKDUyCpv
 b2vcodOj99pR2OiA54IqjnvQEGLEaiH01iZ/NjbkdvMYvVROvO5O9Qm2rsKPoSwFWvkfh6bLP6
X-Received: by 2002:a05:600c:45d1:b0:483:7b99:131d with SMTP id
 5b1f17b1804b1-4852675e55cmr97394835e9.16.1772898152441; 
 Sat, 07 Mar 2026 07:42:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852767d8e4sm110786735e9.2.2026.03.07.07.42.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Mar 2026 07:42:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 4/6] hw/core/machine: Remove the hw_compat_4_0[] array
Date: Sat,  7 Mar 2026 16:42:00 +0100
Message-ID: <20260307154202.86309-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260307154202.86309-1-philmd@linaro.org>
References: <20260307154202.86309-1-philmd@linaro.org>
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

The hw_compat_4_0[] array was only used by the pc-q35-4.0
and pc-i440fx-4.0 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/boards.h |  3 ---
 hw/core/machine.c        | 12 ------------
 2 files changed, 15 deletions(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index 9155e0cc9ed..f85f31bd90d 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -864,7 +864,4 @@ extern const size_t hw_compat_4_2_len;
 extern GlobalProperty hw_compat_4_1[];
 extern const size_t hw_compat_4_1_len;
 
-extern GlobalProperty hw_compat_4_0[];
-extern const size_t hw_compat_4_0_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 9a3d826c3cb..a14ad05b9a6 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -209,18 +209,6 @@ GlobalProperty hw_compat_4_1[] = {
 };
 const size_t hw_compat_4_1_len = G_N_ELEMENTS(hw_compat_4_1);
 
-GlobalProperty hw_compat_4_0[] = {
-    { "VGA",            "edid", "false" },
-    { "secondary-vga",  "edid", "false" },
-    { "bochs-display",  "edid", "false" },
-    { "virtio-vga",     "edid", "false" },
-    { "virtio-gpu-device", "edid", "false" },
-    { "virtio-device", "use-started", "false" },
-    { "virtio-balloon-device", "qemu-4-0-config-size", "true" },
-    { "pl031", "migrate-tick-offset", "false" },
-};
-const size_t hw_compat_4_0_len = G_N_ELEMENTS(hw_compat_4_0);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.52.0


