Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D96C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x98TS-0003rP-Jo; Tue, 22 Sep 2026 17:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x98TR-0003l7-8n
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:56:25 -0400
Received: from mail-dl2-x0e.google.com ([2607:f8b0:4864:38::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x98TP-0000yq-PR
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:56:25 -0400
Received: by mail-dl2-x0e.google.com with SMTP id
 a92af1059eb24-142dce6e237so218689c88.3
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 14:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790114181; x=1790718981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YOVPYqT9U27F/5THFDcioiKO/qOfS51eimtoaATVi/U=;
 b=B7SEo/ofovaiBKFaH2N8MMSmVVAwM1QIfJPQ0QOPoKQUQkA+a2dccHv8uC8jA+CCb5
 o+ADEE9dyF3msdWf48XRlIXb0AvNrXRbFOUnIH1ciZo3GMQr9zDehqBlcbUeO2jaJ3ZA
 VISveU7JoRtOlLEUuSC6Y3VdIBC5hdW1E8VIrRY3Y1MSsvukffwc8Tbumjy/T+0DM5YK
 kFUddTwYAW2/us3h/w+/CIkMrDPAFs3ZqlrtfBLd7S2Hi7LdOaYDV5UzPlGOJexRchwF
 +S8YKcyqEsvgOIjaX4uEIy93bpknsE8Mrc28gm+P3nCxLnthLSOssGxss9HgppWnWotv
 lAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790114181; x=1790718981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YOVPYqT9U27F/5THFDcioiKO/qOfS51eimtoaATVi/U=;
 b=ubTTuwP5hJay8uPrzei92Sh+qVvNz4FcebQk58mnLw94EtJTAxHAlaUfNfnjwZZYPB
 1k/PjEebSEGMAyAnubiDDLjbKQjzPDjtZJ5TvUxr+eK43ICwmPr+YnFP4YH22G+lMkwU
 GOf0iwOINZsH/muzfzBtRQu2KJAvsV1J84StQPd1BoR+lh4XbDCw4HTs2Uu2iKaqUBG4
 0iSAcAA+OoeiMZqAoAkCst+ky22a48VX/doqkDymUp6eKFL+BM4fvd2XeFbYy32qPOA7
 v5GYwFoKqKmSgDhqanzVEluNQH902QwHAkgrPqbLQIhm7nijNZGxuzcaAwOCUDIwko6U
 g+/w==
X-Gm-Message-State: AFuF++nKaTWzyVc4JXGdg4BNKlH2lwIE8GH9sr28AcOjN3NUJQazE5RC
 WhxpLf4/gSIAGEAewnf5WCghV+V8zlZLaEHgAKAdIHk7Cg+HuRhNcYcFpYtEpEe7R1I=
X-Gm-Gg: AYBFou1OilOzJOyvwXT1cFawS8lTbPfaa8fak7zDDvYCwLwOz+y65K3h5m05Y1Wged+
 SmE8D4fpagYUhXUCLJeglBqHA5eM2sQDq6JhYARQukQogDr6D9YejJjX1NIHmYiJFBXvO6BakFM
 8ADrxiipCFLHqi5rFiMc5s22Wm8Tnr2aVqU7/Kl/s+2/0DGPcKpaPbH+yE+1nf68y84vLFoI7U1
 +5Y713+Dvqnp0qXqNdzeCoeiRsZXbnWGwzV9r5p85sqoN1DhBFVzrrm468Ttzmf4RWULStfzRlQ
 5MabrNvciuxFCzGK0aezRJlknrm158c5a/weLvqfstdS7WNsn3dGYtityCKqXMVM6N/GWZmBv9g
 PktDHzrcywpWl8RdhViPP8hecKSjq0nreYULNQqkMv7wSrbmDL5gouxwcCosNJVHUnLBI81EsZp
 RAvovz3yLf2NHOZN0umQwIAKlGJcfPWmglKqQjXNnkETd1fJtvXR6Z1eEYgFV+pfEf8ZAWabBgw
 DDqa/W4xcaQS12+fCpmU/2QmwwB83Y=
X-Received: by 2002:a05:7022:68b:b0:143:271a:309 with SMTP id
 a92af1059eb24-144f91bcb4amr1272460c88.47.1790114181227; 
 Tue, 22 Sep 2026 14:56:21 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-144f949e60dsm1001153c88.2.2026.09.22.14.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 14:56:20 -0700 (PDT)
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
Subject: [PATCH v2 6/9] hw/loongarch/virt: use unique QOM name
Date: Wed, 23 Sep 2026 05:55:29 +0800
Message-ID: <20260922215533.641-7-luoyonggang@gmail.com>
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


