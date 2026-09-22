Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B92C98304
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x98TI-0003M0-O1; Tue, 22 Sep 2026 17:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x98T8-0003FJ-6y
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:56:12 -0400
Received: from mail-dl2-x0e.google.com ([2607:f8b0:4864:38::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x98T6-0000wB-Dy
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:56:05 -0400
Received: by mail-dl2-x0e.google.com with SMTP id
 a92af1059eb24-1437b77c274so166901c88.3
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 14:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790114163; x=1790718963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZEMtFIfZNRZAXvmyI7lep73l5ReH37r60zcF9WOmkRg=;
 b=lVh6/5Q/QYPabqCECPPsC6Zmifhk65d1JPZXdfTTy/RAr7BlmXDRV0SE9wtFTvXXVS
 fz8GnPo6/C+94vdc3iqYZmQXPu8u1hkaJ9LlpR6bPgD9xupV7lePQE5sdHVTc0hCsVjc
 cbMC6MbOcPXXmyahn+GGNu8PBI0XpnDBlpVprjYNjuFwJSuvszffShfLCxveMfW9IVrl
 d+o4jPEMf3efS6pSsKviPWQL9Xw54jPYBHlw/H5gto62ors55u+T0zNVae5zzmcwngeO
 uHPhgSGs6yjWdn6XFUiH6lFE5bTn9/7pGkOOqjjuQFMDxBBOhCD8MJtowiN5RhjPXto7
 EnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790114163; x=1790718963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZEMtFIfZNRZAXvmyI7lep73l5ReH37r60zcF9WOmkRg=;
 b=s13ZO20rbjF5XYelkRKiZGw8Iu4RnnsLqem2R97l/yUQFjiB0pS1TNzFaX36FEAV/y
 hG5FkqaGMoHKsrowUONA5ixIehEdl6bjyYZT39bS9HQpsSWqSAKs1VpTQWuL1XjcA6Au
 dF7YJbC/50QiiSLQegHgYT9F2EaYZjN54rYIsGW78NXagN5hFwL+Be7+eA214yjD1ScK
 OIR4lruZfAO5wHjPCxhdsVIG7ZmjwlYPIJtrsl8tnYYdIjLjvygKz03fOdLi5qq4je9U
 8BULN3RCl/SWvL2FFR5xeYL6TuffDu2vEkO+Jw6wCdExWfWdwZYSD9FFT5ZSMUGe3d3i
 nmfQ==
X-Gm-Message-State: AFuF++mGmuYwfELzhMSO3cPnCnGLAVeunnqAy9e2/D9UKWmgYj8DkbkE
 EOgP/icy3nSlNz8c7pkqZwrXAZ8GO4xGUg9B1wRWcGkwCX90xdbz6/prkm6tLXhxYEE=
X-Gm-Gg: AYBFou284Wi1nBaG/qOKetpst9MTiMvn2ul9owF2cI7rpQSaCR3DNRg8kOzWN2Hqzqr
 4Et3JaVp/dgft0WyASi7+z7P7wpuPjYb+3OvBR8uuHxGTxntG72oatL2ceXHaYlUs4IBzm6lWeq
 x9ShI5fcsQyt23qw+BPvCJWASNKuL/rm518thlCABrWrb5eQIvTQ/QuHNRz2nUZKc6b3yAdpKxh
 EUNCoC/fTy0KRPM52a0EHCK5hZA3To01x2PngVy3h2jVk7BxIm6VG8QHF7Ebh5mDGsAP3Hnptl9
 K1TYWMQfDYstamWReD3218VM0ZGK6c7cpdelrECpfuvyQSpWnoXjI11YQYFgPfRUeFkcyi78Baw
 8mQzeKygcs6ciSLQOqsZMAsjAuUmTk72WEYhvOHnx/Zvn5gGDj6/dzT7UonFYkLbGGsATgkIhpy
 MQM3GECdhZioxRwRWvLhNuBvZ1dcRxay6VsuLrVvg8FZTYWjJmdqocyINJUeb6t7NvI5MEu41T/
 u712GDrtWYL3uTW1NvkM1YSi9rAiFAd
X-Received: by 2002:a05:7022:28e:10b0:143:2967:c0b1 with SMTP id
 a92af1059eb24-144f9c47315mr621949c88.25.1790114162558; 
 Tue, 22 Sep 2026 14:56:02 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-144f949e60dsm1001153c88.2.2026.09.22.14.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 14:56:01 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Song Gao <17746591750@163.com>,
 Markus Armbruster <armbru@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Stafford Horne <shorne@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 3/9] hw/arm/virt: use unique QOM name
Date: Wed, 23 Sep 2026 05:55:26 +0800
Message-ID: <20260922215533.641-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260922215533.641-1-luoyonggang@gmail.com>
References: <20260922215533.641-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x0e.google.com
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


