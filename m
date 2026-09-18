Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF38C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7M8c-0006rJ-Dr; Thu, 17 Sep 2026 20:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7M8T-0006lm-6b
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:07:26 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7M8Q-0004w0-AW
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:07:24 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 d9443c01a7336-2d9004a1ac0so956285ad.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789690041; x=1790294841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YOVPYqT9U27F/5THFDcioiKO/qOfS51eimtoaATVi/U=;
 b=FwQnsATnffoylCAb3Nq1868H+d8NzUrO7Y4/wB3FA2VP4+HHXYflwAh6dyKP57Pmpq
 sxwyfBcK8E8xi4jfNQbwBtiWsY4xUwS/Hn2YXuzEAjv8iJmmIe0Hi1hEt3EjBMMrJsPh
 KzDAERNA0uy+IWrgWsp7LCKxGDc4htend3ksftICMftz2/3XOGeYF4sZIGXTZhWsysJC
 jyxQzWYtzcQpeqBG4F6unTMvEvb014dzaLCP1DGeg/DXZs892X6kr8Akt17wGsXeiXtd
 bGw8FK4ZMfQ+hj3zPq3hv51pxVJHc0LravdnfLMcoQsqjcGSia4B5byqxt+VuqPvhPft
 jYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789690041; x=1790294841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YOVPYqT9U27F/5THFDcioiKO/qOfS51eimtoaATVi/U=;
 b=2RVRdQ+mjMqSjb4wQRt/aGMptdNsgm5+PPr8I/wZPpAkiQq2Rw678Nj1vGkQ6k0DRP
 2VgbkKs128I9K8J6gI3oGEBqoJR6+oqlKYfakbVmU+ap70GmW5H8jvRNzkrxbmHwHcUL
 Jcz+muxsWwXD943tqAjKfwpKU7IVC6L/VbpdhlsBE1zsK5xujp0KCqiGc/5Fr4EDFHCj
 Hxi0Y1C33lqJYuSC+Jd3Z6xXjoCwYtZA+FUpDOAbpO1v6OiCJda63UFEqBe9KLRAMwV0
 aAbG/j8uYTN0KFWbo7XEORZeh/ToXUw2co/ZV2ZOZxOYxcG/vJGVDdyjkvi+5ZhlP5Ff
 CU5Q==
X-Gm-Message-State: AFuF++nCJvoXGObhL8YZMdZFlF/wtlBMrtXmoGy8MWInWa5lohLuMG2U
 jFizz5zonIQBcGXxNlbKSfglu958DHjXCjohzDxujKQ0iXlsaP5zWCP5G5VHSCNFJLE=
X-Gm-Gg: AYBFou10JjGMENtut6W7oeuzJY1bvA0FJKj8dVjI3W0jS2LMfMR9e5NDUHBz8Y/8MT2
 yPywAbYMmB1HudMiDruYG/n+FQ1dk3OdQo8l+075uv5Zua6PvcBHDT8up3BJoM6VctGxHmLc9HX
 wicQu8Uah8KbOzdMYapJFURAK2/VgBX2RwwRgq99nNdiC9E5MTFm8BbNmsdD6hm8ILCsIK0rdb+
 yVxESU+CLARKcMReWadpzVRAsTrhxyFOJwfYFwAAMWdj/kx6WjMB6itSmw1mlxHjNIBJi9z8f9G
 snpn3batrIVNxiqkeC8WzEXKnAOGWFjD7wZGlDGweMZra/znCZSXgd84PwfPMRxpXID+bUr2uSt
 +sl84JnT+e5bhgqgQH5YuXkwv9EbyE635QmKj3J6TR9viSwAeD9Jga16Y1bhbyvnuRYl0gA574H
 bigZI0N9YpSTFmConwZKv223A4JFwgZmpkG6P8NYxT+CuG70L9r66tS2oWoLqL+z5SA1nlCT4qu
 BtXd1f89laqxs2LAsfHdMh1Fz90CNov
X-Received: by 2002:a17:903:2f0f:b0:2db:31d5:1448 with SMTP id
 d9443c01a7336-2ddb1b993d7mr14893815ad.22.1789690040584; 
 Thu, 17 Sep 2026 17:07:20 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33bf5b1d335sm20328212eec.28.2026.09.17.17.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 17:07:19 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Stafford Horne <shorne@gmail.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <17746591750@163.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Chao Liu <chao.liu@processmission.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 6/8] hw/loongarch/virt: use unique QOM name
Date: Fri, 18 Sep 2026 08:06:37 +0800
Message-ID: <20260918000640.1001-7-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260918000640.1001-1-luoyonggang@gmail.com>
References: <20260918000640.1001-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Set TYPE_LOONGARCH_VIRT_MACHINE to MACHINE_TYPE_NAME("loongarch-virt")
so LoongArch virt no longer collides with other virt-machine types in
one process. Keep the -M / help / migration name as virt-* via
machine_class_set_name().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/loongarch/virt.c         | 3 ++-
 include/hw/loongarch/virt.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 9c5371af9de..2b003443eb0 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1543,6 +1543,7 @@ static void virt_class_init(ObjectClass *oc, const void *data)
         MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
         mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " LoongArch Virtual Machine"; \
         MACHINE_VER_DEPRECATION(__VA_ARGS__); \
+        machine_class_set_name(mc, "virt-" MACHINE_VER_STR(__VA_ARGS__)); \
         if (latest) { \
             mc->alias = "virt"; \
             mc->is_default = true; \
@@ -1550,7 +1551,7 @@ static void virt_class_init(ObjectClass *oc, const void *data)
     } \
     static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
     { \
-        .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
+        .name = MACHINE_VER_TYPE_NAME("loongarch-virt", __VA_ARGS__), \
         .parent = TYPE_LOONGARCH_VIRT_MACHINE, \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
     }; \
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index d39a9bbf5dd..09529de48bd 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -130,7 +130,7 @@ struct LoongArchVirtMachineState {
     bool highmem_mmio;
 };
 
-#define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
+#define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("loongarch-virt")
 OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, LOONGARCH_VIRT_MACHINE)
 void virt_acpi_setup(LoongArchVirtMachineState *lvms);
 void virt_fdt_setup(LoongArchVirtMachineState *lvms);
-- 
2.52.0.windows.1


