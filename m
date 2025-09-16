Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E65CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya5v-00057z-A2; Tue, 16 Sep 2025 14:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4y-0003Cp-Na
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:07:00 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4s-0001dz-0U
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:07:00 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45f29e5e89bso36185535e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758046007; x=1758650807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QJC90Z9Jna1Frj0HcvsOKEe9UH6moSfHJHHkk9hg+yo=;
 b=TA+ZtSf4tRL9WJ+3+raMkgpvqfV6Bu+UXUU525USzSZjb/xNAF3/wlvk4JPtdpoEqS
 T8VkT6hhHp9aIyc0T17wtNMv8lEvcgFhd2Zn1SRtpUmJKVXtOnv78pTZpMNjxjCYqJKz
 KcN6O95SUyas3b6vrgj/mszZovGljRoPMPEYQJcU4VCMhZjYknnttTyYGfRGAKPmbEwX
 tL4xoYZvypQlVlh2Aw6WKL2nQFRQ0OrXZgddNaQcawtDKaMdlxA60IbIFzsB7vExgKBY
 QwYjzAPz860LvTQF2QlEKpMfGGDxwGV4uUL8xZTMAR+pdPYQgVYgvLWFAsJSH8u7YjIR
 oJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758046007; x=1758650807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QJC90Z9Jna1Frj0HcvsOKEe9UH6moSfHJHHkk9hg+yo=;
 b=osY+1YNj5Z7um7ZTB0Onir4m9A2bZrpKmOyYOOGT4q47XruhHc2boeXW2pqU0zKrp8
 X6dECBzPDekZC1c79McKynoHCIcPtXMx6SnKCqdp9fHCJQTwmqikWjUElGjixhuUMb3h
 3277hu+dr7Pkhoq0iCSB+Je25zLk/w6O6zvTviPDi0qUecsWSkO6tnfOl8YrTO2/GOsE
 Qhpsd+WM2AeJG0gIM/jj7xO1jspbsmp8lIHSJBSopHMttW39+35Lm6bqLackApz9Kxzm
 W72NrX440ooJHbbwFNIPeHgEveMEh1j+SXJ4joju+8RXU+pTiEgC0FcaQ88z89nIOoWu
 AleA==
X-Gm-Message-State: AOJu0Yy8vLb3BPuPxp35QGkYVj+btyagiy1Df791XGIrkB0pCSJK3c+7
 g4s4uSMh7u2vc5KAsznb0MurRjyqTFyjaKtjBwh4LTNPxD1JfM/JO/sYaVuYn1Zu6esOk5+0ifh
 /OEL+
X-Gm-Gg: ASbGncsjIF2S19kxBcwc6ysyllZR8Zq4sUG/9jyljordYdjYoR/wQqM2w8ZOdSSwC3M
 lKJZkDpw7Nf/iq46s3NJE5fudZohyKWvjE2JA3Q/Vk2A6gvahEqGiDZyaebplToDILpUu7Xx2dH
 +c3WAQzjQJ0TIP7eahAKsKWVs3SMlIna89jDx8SGPk/jOj/zW9JDVD1/Pg9+W1+ffCtwr6U9mME
 COg75gZr1cowAKXWOQiR6U/hNSuDYAnclJHoqVRGMZ2CFxPbPI69dIDIr/JcSqLMYI06j38cR/U
 LS/K3pUwwOEHevKe01QyjVbA/bfd062qbJ1xZyeKxJTPJgwXYKN2zY1rUrV7BNPBnpYlopfT5HN
 GW0lrQXQA/83MyKKegEYzAt+su9mO
X-Google-Smtp-Source: AGHT+IE7P2el+6TznladCGhlkoQyGMn+tDwscEdohPVr2RPJdGnqAogxRZGcxelBDTNh3ZuUA0qp8g==
X-Received: by 2002:a05:600c:4685:b0:45c:b607:ea95 with SMTP id
 5b1f17b1804b1-45f211e6054mr184892085e9.18.1758046006924; 
 Tue, 16 Sep 2025 11:06:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/36] hw/arm/virt: Add an SMMU_IO_LEN macro
Date: Tue, 16 Sep 2025 19:06:03 +0100
Message-ID: <20250916180611.1481266-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Nicolin Chen <nicolinc@nvidia.com>

This is useful as the subsequent support for new SMMUv3 dev will also
use the same.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Donald Dutile <ddutile@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nathan Chen <nathanc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Message-id: 20250829082543.7680-6-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index bebe2d8cea9..64b4dcf6071 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -151,6 +151,9 @@ static void arm_virt_compat_set(MachineClass *mc)
 #define LEGACY_RAMLIMIT_GB 255
 #define LEGACY_RAMLIMIT_BYTES (LEGACY_RAMLIMIT_GB * GiB)
 
+/* MMIO region size for SMMUv3 */
+#define SMMU_IO_LEN 0x20000
+
 /* Addresses and sizes of our components.
  * 0..128MB is space for a flash device so we can run bootrom code such as UEFI.
  * 128MB..256MB is used for miscellaneous device I/O.
@@ -182,7 +185,7 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_FW_CFG] =             { 0x09020000, 0x00000018 },
     [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
     [VIRT_UART1] =              { 0x09040000, 0x00001000 },
-    [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
+    [VIRT_SMMU] =               { 0x09050000, SMMU_IO_LEN },
     [VIRT_PCDIMM_ACPI] =        { 0x09070000, MEMORY_HOTPLUG_IO_LEN },
     [VIRT_ACPI_GED] =           { 0x09080000, ACPI_GED_EVT_SEL_LEN },
     [VIRT_NVDIMM_ACPI] =        { 0x09090000, NVDIMM_ACPI_IO_LEN},
-- 
2.43.0


