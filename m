Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18781C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7M8E-0006fD-4D; Thu, 17 Sep 2026 20:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7M8C-0006er-1b
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:07:08 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7M8A-0004sp-Fa
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:07:07 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-85469d20963so122756b3a.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789690025; x=1790294825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZEMtFIfZNRZAXvmyI7lep73l5ReH37r60zcF9WOmkRg=;
 b=Q/ix6PlHD7B/0BlftcWMKCVPhBn1Sy3bJB+y695mDs30mjltmJIdkaWLwDFFKntufd
 hMSAuQu87OODzPUjH5b+BtpwSZZsPFqG78uF7VDub6gUqTvaSBLpWUJaNKarIiOKL63g
 GgqsgAvZYEY3irLFrNvtEVYfbc104IYqCFGAd6eV0dmg8L03vdIG8PfegnRdptE2Msyo
 zS6XfRSWG35N+6rsowJuPgVoKKEWtkMUcGWXmBG/oig9iv03MlMOm1VgJ+1f6fEo3cIf
 dwlZ95h1qOD9iKQcH+Q01Wo/3JCSZTEzscMltIQXHQ6si4nF6/k5majOJSXGmWMQsmzX
 QPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789690025; x=1790294825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZEMtFIfZNRZAXvmyI7lep73l5ReH37r60zcF9WOmkRg=;
 b=QlCVqEn4IUj63XxmYOX9XSfwnk4viRK1qLzNMwfgpWcI+kBkvhSapLx5RTTBXATz4h
 IM7YLgEmHQ2emb5aks06Rq22jIhaDhLVT3UWL2rUG54ZchLnDTQt95r7mjg4sCbbGRyk
 PocWljyLmP1zUi/HAA/tN7TGzkcwLMsIoin21X/7U5+5R9T4/Iu5HAT+ePhOyjTqmyaK
 pn1yZINJid7bwgU0yOBcN5NmtVCM7qt4DHuCanr2wp/wTFaTrulb0fqVDvfzDg2nVB5e
 zmig4PuVUl1Afr8Aep7WhTPw8YJtuQAfET0CMd0YrS360KMq1RM75McRy46Ual3utnEn
 fv0Q==
X-Gm-Message-State: AFuF++ll47B/PQ9Trhn65hbcWyB0gW6iaKleZA+7BGw8wt48raU2QQW9
 POTFofU60Bh9NuAT6KiRPYX8oY8qT8nDNo75ilMD7zCq+4K39oxKEgVqh1t27nYUmdA=
X-Gm-Gg: AYBFou0G8e8TgF0B6CFJRObYGz+1NDCPi1aO/mESWij8oEjTR6vJ3J1RCGZxUUb0XwN
 9z7+/whRsBcQwQQFOxjOuOfW4htImC5R+hKuREhfY6sqU0MdAYGSFkW5RD2O3VZIBpE1KrvekJ4
 cwuHcb3tjvGDoahlx/0Fngqnm9GFeCcy1kXOUqsxP3UDa9k4wvdJKNv4CgX95iuHQa5r+B8t07c
 sc0fnMSExxpkk2U8y4JARWG70LS/vnUzBA6oeHaNcqcHUv8JM1kFxaI30fZHYKJ3PH3BAQ20ZhN
 qR7YJLCJ4SlqyPhtcOY1Yb6glX9lok9yb9yWUUr/6dIResbQ0R/wRKTX8ydw0i/nVTxZ+Z51kJU
 warQSZoQnuMcT+sV+cjF2xeeXLL4bdoLiAdCwazyT/pwQbqBPYd5hPWOjoExiSCistOeQEbvGOL
 uj2qycNrQvAB6SB8xIwhnvbbKIcU6dXweBT/bQqfNnqVmHZZ/FqoF/PZPou70D4W06x73h8XMOy
 cid4jvosfwoin+facmha7mV44U3Ublv1umDvm5Aq5M=
X-Received: by 2002:a05:6a20:2d06:b0:3dd:85aa:4524 with SMTP id
 adf61e73a8af0-3dd8c4f0987mr1362147637.31.1789690025022; 
 Thu, 17 Sep 2026 17:07:05 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33bf5b1d335sm20328212eec.28.2026.09.17.17.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 17:07:04 -0700 (PDT)
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
Subject: [PATCH 3/8] hw/arm/virt: use unique QOM name
Date: Fri, 18 Sep 2026 08:06:34 +0800
Message-ID: <20260918000640.1001-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260918000640.1001-1-luoyonggang@gmail.com>
References: <20260918000640.1001-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-pz2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Set TYPE_VIRT_MACHINE to MACHINE_TYPE_NAME("arm-virt") so ARM virt
no longer collides with other virt-machine types in one process.
Keep the -M / help / migration name as virt-* via
machine_class_set_name().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/arm/virt.c         | 3 ++-
 include/hw/arm/virt.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3eecf094bcc..c8ffa1ceaf4 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -123,13 +123,14 @@ static void arm_virt_compat_default_set(MachineClass *mc)
         MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
         mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " ARM Virtual Machine"; \
         MACHINE_VER_DEPRECATION(__VA_ARGS__); \
+        machine_class_set_name(mc, "virt-" MACHINE_VER_STR(__VA_ARGS__)); \
         if (latest) { \
             mc->alias = "virt"; \
         } \
     } \
     static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
     { \
-        .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
+        .name = MACHINE_VER_TYPE_NAME("arm-virt", __VA_ARGS__), \
         .parent = TYPE_VIRT_MACHINE, \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
     }; \
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 22e66d1a113..383ee320948 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -215,7 +215,7 @@ struct VirtMachineState {
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
 
-#define TYPE_VIRT_MACHINE   MACHINE_TYPE_NAME("virt")
+#define TYPE_VIRT_MACHINE   MACHINE_TYPE_NAME("arm-virt")
 OBJECT_DECLARE_TYPE(VirtMachineState, VirtMachineClass, VIRT_MACHINE)
 
 void virt_acpi_setup(VirtMachineState *vms);
-- 
2.52.0.windows.1


