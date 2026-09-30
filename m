Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E821CCA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBov8-0001Cg-F1; Wed, 30 Sep 2026 03:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBov7-0001C5-Bs
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:40:05 -0400
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBov4-0003sA-Dx
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:40:05 -0400
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-343479e6005so1103786eec.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 00:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790754001; x=1791358801; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=36QMi8FkTHqsIRvQCfr3lK3cpL1UxEN1MbLX8HWDnMA=;
 b=jAoBV9hp/ny2v1ne+Z6FkCsUip89WFCEWxdC0rzPZ+MxqTW+rUkFhAIRwGfw8faLjp
 C5sHnyQO5X+wwCZnF+ZeoJe1isucHbdgNcInzLXvu1njpBAaZ0mdBhIFW/0HQ/cp8M6p
 BQja61fg8ppq/3OQ2N8eKULA6AFes7dZUijzpv41Ym3oVbu1OwdCGna0ilxTCAdVO+m0
 fTlVMSzQ1KYoME4CTbdpxu0w6gua6X9pONuanGu/f1Rdbgw97Xe8HI08etUkheKQDsUy
 Qm7cG6Q+Rxc6WTWWZibKBTW/ikz+azdRSb+Qyphtn7dVN2Xe5f1PjXBA/oZOjlKgIiAt
 e6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790754001; x=1791358801;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=36QMi8FkTHqsIRvQCfr3lK3cpL1UxEN1MbLX8HWDnMA=;
 b=u3Jx0c+zGb3mCllR40GxZGKVcQ00yVd4gddtRWrIx19qeNSHc4BuqGp4u/wZBt2uQ3
 5d3k9u0tfiqaO7pp4rUwqUgpGIbjgC0uve/hnKbP4e2V1aZ2i/+233yw2Na8LUPPgTo5
 W8Tl3lhjTwD7x0MKq1iUEuOwk6hPzTNgiAV4ECxLpyiK5j81xo3Dm2ggggqrpm+Z4ero
 5UQp2s1mCH5Q/u7TE2nsXYjX9GgOJc02Cx4RX3drDYaGPgc0jh9iu8LFC5OEojgjaidg
 uPsYDuOXmT5S0NndXp/6Ls4CUwaA8I9i47fK+Yryy1FItS2t4B1raxRL0fPKvRtqcG5t
 cU8g==
X-Gm-Message-State: AFuF++nXuFb7gzfl8zz5ITjljcjYQNDMDvqJ5JTjXIhTNDCZ4Sl7jZ4I
 SqfZJGemYqbsN1ru7DGR1bEK6sqvTwGlgLdIOGAwFCBU5O++Admg6uF4aZCrZCGO
X-Gm-Gg: AYBFou3Ln5mbf95IwSCz/+R5rAckC4dyn2ozyo9L2qASVwN4IFVL6biSgl9kj5I4o74
 +RSPT8a9TRAmFbu5MqmAOpMAR9U6vC/VZ54nA+OqXJdaEfiri24GyUdrfyj1cirSbYFgZg0CwoP
 h+chHqFkvb8IyyszfDUlCjZ1TgE/AAOppZ6OKBkFhAFTicdbmfHZsrUlxg7rIXVEF+XayYGFW+s
 QzUNiYaVO103OL4B7Jp09cSmOp291yYN6v+UtrYraoXve7uluusJiU4zkvKKE2N+ssem/07xHIR
 o2PBCjI+Bo0Kl4VJPVd5rIE9c/rBMKDgQxiwi+8Mv97scIwAUgyHg/9OfNWS/ySasZ1p85kDrou
 KZ0KDdTPNRNgBpmirDuqO7Am1J9uRmSBnPfUc2Wg2/3EIQuFZD2rXQXG7aL9pBi7OJRXc0K3EhP
 VePyiJWJO9Anz2BlNwYFNcNsLwDzffAEOnOG5s3ByiVwxeuP2igH/tet2H3hSR1ZLyVnjFi1Zi+
 ikopOmUyn5dMCwE8g==
X-Received: by 2002:a05:7300:ce8c:b0:341:c383:9afb with SMTP id
 5a478bee46e88-34cde86989amr881911eec.20.1790754000611; 
 Wed, 30 Sep 2026 00:40:00 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34cf5b4349bsm1825773eec.25.2026.09.30.00.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 00:39:59 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <17746591750@163.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 3/6] hw/loongarch/virt: prefix ACPI helper with
 loongarch_virt_
Date: Wed, 30 Sep 2026 15:39:30 +0800
Message-ID: <20260930073935.712-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20260930073935.712-1-luoyonggang@gmail.com>
References: <20260930073935.712-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

- virt_acpi_setup is the same C symbol used by ARM and RISC-V virt.
  Rename it now so a later combined binary does not need meson -D
  prefixes for LoongArch.
- Rename the file-local virt_is_acpi_enabled to
  loongarch_virt_is_acpi_enabled to match.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt-acpi-build.c | 6 +++---
 hw/loongarch/virt.c            | 2 +-
 include/hw/loongarch/virt.h    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 600ef60fc5..b9df9b3a12 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -674,7 +674,7 @@ static const VMStateDescription vmstate_acpi_build = {
     },
 };
 
-static bool virt_is_acpi_enabled(LoongArchVirtMachineState *lvms)
+static bool loongarch_virt_is_acpi_enabled(LoongArchVirtMachineState *lvms)
 {
     if (lvms->acpi == ON_OFF_AUTO_OFF) {
         return false;
@@ -682,7 +682,7 @@ static bool virt_is_acpi_enabled(LoongArchVirtMachineState *lvms)
     return true;
 }
 
-void virt_acpi_setup(LoongArchVirtMachineState *lvms)
+void loongarch_virt_acpi_setup(LoongArchVirtMachineState *lvms)
 {
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
@@ -692,7 +692,7 @@ void virt_acpi_setup(LoongArchVirtMachineState *lvms)
         return;
     }
 
-    if (!virt_is_acpi_enabled(lvms)) {
+    if (!loongarch_virt_is_acpi_enabled(lvms)) {
         ACPI_BUILD_DPRINTF("ACPI disabled. Bailing out.\n");
         return;
     }
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 9c5371af9d..19fbf6db0d 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -242,7 +242,7 @@ static void virt_done(Notifier *notifier, void *data)
     LoongArchVirtMachineState *lvms = container_of(notifier,
                                       LoongArchVirtMachineState, machine_done);
     virt_build_smbios(lvms);
-    virt_acpi_setup(lvms);
+    loongarch_virt_acpi_setup(lvms);
     virt_fdt_setup(lvms);
 }
 
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index d39a9bbf5d..72268466de 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -132,7 +132,7 @@ struct LoongArchVirtMachineState {
 
 #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
 OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, LOONGARCH_VIRT_MACHINE)
-void virt_acpi_setup(LoongArchVirtMachineState *lvms);
+void loongarch_virt_acpi_setup(LoongArchVirtMachineState *lvms);
 void virt_fdt_setup(LoongArchVirtMachineState *lvms);
 
 static inline bool virt_has_dmsi(LoongArchVirtMachineState *lvms)
-- 
2.55.0.windows.3


