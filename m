Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B32CC9830E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9My7-0002Pd-6f; Wed, 23 Sep 2026 09:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Muw-000315-MH
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:21:52 -0400
Received: from mail-dl2-x10.google.com ([2607:f8b0:4864:38::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mus-0007av-Bb
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:21:45 -0400
Received: by mail-dl2-x10.google.com with SMTP id
 a92af1059eb24-142dd04edb5so1438860c88.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790169701; x=1790774501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BQcT2TCunpJ4XJOGDsLRORw+wafc2yMdlkK9/vuTXoQ=;
 b=OdDA58sqjAYv0kiOVtJ9vfzQQws+8/0BbFX/eNIxkhMNnhjkjA77LFqLFMDYzNzb3/
 dsJ2DtR+kRz8ynfItiX7J30zL9JHVOa0u0Uhsy6vVrg77Vfk4H/YK/EVYBjLn84Ki/8R
 e2AEiEyyVUHSdrv4qR8IO/fpYIoPavOmne104tmzsNSYMk34LJy04WbTWelXdznNWNiA
 CscdzKH/ok9DEYDyQCSMeuS5uMFeyiZzxsnlV1pK7SJbaxz8b2HeLtaTfTCv22QfU/5N
 vm7Av3CV2uz9XWVeiRRxg2RmzYjhRo8lED5vJo962dzQVTS2B/IcywiqjpBNiY+HP+b7
 oW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169701; x=1790774501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BQcT2TCunpJ4XJOGDsLRORw+wafc2yMdlkK9/vuTXoQ=;
 b=uoFmu11PE7o3hDyKSc2dEid6fZZ0WzxA7FajR5dUlzCvOH+l6WRrCI20MwHzTfWfuM
 JHhlarniYGfsA3LngSIV+0EZpBCrxwj+Jvbbh783kjjx11xECrfRZhET0xezHthDDBHr
 IQehdfbOAUjtMqmHb22u6TGxLBX8ul/ElipbuILXb5fAX+DzwCk+nK6jFCLMCmzdpWZQ
 M3Q/8WQ5oD/GHZSpqklLkqMTyWP6yethbapk2NehyfGuD19N+Ein8DqdwMITKOiPln6c
 QIf0sOZvD+S0vHTy2vDefaZd1ne+mVvkaqjFNnCGDEDbXcQv38+v4Q0Q5kV5HPMWc9nU
 nLkw==
X-Gm-Message-State: AFuF++n+lSFd7NCrXiUZ5jINSM1VwD1Jtq3sPaCD0UzRT2C8dzFhd+FX
 cPWyw6a381KCeO/UWOfijM5sHOi8zqKzTAReIRPHJw/q804bMZBLxl72Pv8MzP7O1T4=
X-Gm-Gg: AYBFou0fU2vfVeUiVfoV0iJ8ED0oWeFL+ChaK/V2aWKols7IlVx9qeiUPKomKvU2AR0
 7VBHrIm6f6UFxA+kXBnR9XrDFNCJXCwu2GsEDA2rnPXyZFxEySh/3GbgTsX+U+jZQ6Kn6zteS5B
 /G8joo2jmDe13qN+RVqIcD9sMbcLFYzAQBoX3f1hmrrBiH8sL9N5JzVNSG5kYn/5Q6Jst6gfSqV
 beiZeh8GlmQ74cMn//wDJEYYjlNulqoB08h+J/FDQm5F4eAQFc5bp/+8j0ZvUDCLTUoO6VsnHjZ
 jNUtkyIRvX6sIBa+9WfXfvGLWwwoy4SSX5W9sc8hWaFwIUWYuCURZyvcuRWV2Z0GpuWUGp5kEuI
 EHi7am2A2VELidsRJ8fw5pHm0G+LfDd+VLSdThmu53oUaftpVn2X7wUxDXndQ0g4HmkLZydtDNF
 iu93AWgh1toSSlBAVOYdFVfQT0qVxarCj+hwhbSahI2reP7sEI49EvAYDblsIYwpDUWUu0N6slV
 ZjBN5sNaHyPCIIfwksOcyg5pNA8aGLhv1flqVVTsVA=
X-Received: by 2002:a05:701b:4551:10b0:144:fd7c:84f4 with SMTP id
 a92af1059eb24-144fd7c8641mr1564469c88.5.1790169700288; 
 Wed, 23 Sep 2026 06:21:40 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:21:39 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, xen-devel@lists.xenproject.org,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Fabiano Rosas <farosas@suse.de>, Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Song Gao <17746591750@163.com>, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 028/114] hw/intc: use kvm_enabled() in APLIC AIA helpers
Date: Wed, 23 Sep 2026 21:15:02 +0800
Message-ID: <20260923131635.1894-29-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x10.google.com
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

- Replace CONFIG_KVM ifdefs in riscv_use_emulated_aplic and
  riscv_aplic_set_kvm_msicfgaddr with kvm_enabled().
---
 hw/intc/riscv_aplic.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index d8e25bfda14..03a0852b8b8 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -167,7 +167,10 @@ bool riscv_is_kvm_aia_aplic_imsic(bool msimode)
 
 bool riscv_use_emulated_aplic(bool msimode)
 {
-#ifdef CONFIG_KVM
+    if (!kvm_enabled()) {
+        return true;
+    }
+
     if (tcg_enabled()) {
         return true;
     }
@@ -177,21 +180,20 @@ bool riscv_use_emulated_aplic(bool msimode)
     }
 
     return kvm_kernel_irqchip_split();
-#else
-    return true;
-#endif
 }
 
 void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr)
 {
-#ifdef CONFIG_KVM
+    if (!kvm_enabled()) {
+        return;
+    }
+
     if (riscv_use_emulated_aplic(aplic->msimode)) {
         addr >>= APLIC_xMSICFGADDR_PPN_SHIFT;
         aplic->kvm_msicfgaddr = extract64(addr, 0, 32);
         aplic->kvm_msicfgaddrH = extract64(addr, 32, 32) &
                                  APLIC_MMSICFGADDRH_VALID_MASK;
     }
-#endif
 }
 
 /*
-- 
2.52.0.windows.1


