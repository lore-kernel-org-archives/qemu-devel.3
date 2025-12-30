Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F7EEE021F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 15:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vabyn-0004D2-5L; Tue, 30 Dec 2025 10:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1vabyl-0004CS-RG
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 10:49:47 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1vabyk-0006j9-C1
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 10:49:47 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-430f5ecaa08so4127215f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 07:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767109783; x=1767714583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7o4WR474es/5e2xL8IEZwboJcaG4RYzal78dgOeo56I=;
 b=bdFe7SLXglrj3ZcakpNjsBKCVcXGHlP7Gcvkdoou0Iv9gQ/jCxJvJ/PXqDcTwK3Wnk
 MWdnfkji/a9gvu+C/vsio3RUPdIWfcDfJovq6c0bcyb6+jey3wDPhGJh8uoepjUjRx64
 mOqltFgkaWvOdXFcMH4RbaG6CotV9XJVoFmLMV1ssJd4hVm80YMS8PeZdreGAcrz/YF8
 ZDxqHr+yDrX6SkyzhPExUOBu1pavxTcORzpCXZb4MsW7qKcx7sDZP0vX1uKRYFrnZCAI
 AGko7SAkMfK5fXgXMFYsAikKcuGkLenhK/g7Ko9t6JBiVOibn6YiSP7FFEsAQA2eNYGE
 wStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767109783; x=1767714583;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7o4WR474es/5e2xL8IEZwboJcaG4RYzal78dgOeo56I=;
 b=iePMwNeoyIrAwEgGpHDvIrXkhSVBeDIWJKcMDKuMc5Juh6TCciBtEAuehmzgoJn6rG
 3gqWcrLDgaIa4R3AM60zJ/X7ryWEPiUZwpQAxWDt8sY+fmYU8zl1bmKZ4Nb++qH+rlZu
 bWObv46yMw1zBgjrrG0rXbyDl3Qe612J1+XkYV7tlFeMnAd5zhOdfYQc5XExRgJ1tQtp
 U3Ru64XYKMH4INL4JmFHgC69oBbXHNURSKfpKvOvgP/UoUqiyxO3cuNUE1b0eP4wb9ds
 97+CTBS8H4WqN7wrzE4PrMTtQ/n25uuRNEHN1PSBsSlG/JJi4wDTwmSjxWmO1RHzF5P1
 Ib9A==
X-Gm-Message-State: AOJu0YyqP3D8V85++S7Wo9PcZadCbrBJmJCaNYfnGg9tl5HvLVqWy7SM
 d1L+hKOgNLYQbz9ip0QCpsPemwcp3kvADfoyHN6h663UjSSs0TTmzWIfP8WXfJg2YYw=
X-Gm-Gg: AY/fxX6T7j8dZ09ebDbn4zO5fwCBX4RLnD8zDmmfEJ+CTnaw1vgg+JufXCI0c94zgCU
 gjicjfFrQvnPwBp1EASZeac8/PWx8uZAPwR7FntUO/KtaWqzIITBuq4Jb01ou0TAuRL7Kunyhpp
 3s0QMr7rj4LqIK2Kq9r8wWkuaehp8vqaUcPzsPv1kD1v/JukBcJIoW3QT+mKfG3VLjMoc1R1/RT
 kuyIOv/wZhSujwg9WZxk/Jnha5XbLDKX4UiT8QYWVE6i2/zRx2ABnUCLzHRNH5cDIcPHdrMj+eg
 Hr68hn8av06G+Jsc/4DS5F/jG25Ybhrq4gG3MmmWc6U8nB5BP2Bbw8W7fU3yay7QGeuIzeH78NQ
 tbY/Yf+AlpNFyvvy/X/MZ514Nc4OH/Nbs6xNt9+UONTSD/aovW5MiRsAeVpL2jS5vMAOPXHMbDV
 BA6BVHbq978mkQ87Zb/zAaaYEfWcUymh/6cBp/gEp7baWttzVvT0g=
X-Google-Smtp-Source: AGHT+IGcnGQwF7BtUFWWzHfH1eLReTptWIEqZ4OfRfZtQXz5imzUdnzwwqgjZoltymIcW6UaERgGrA==
X-Received: by 2002:a5d:5f82:0:b0:432:852d:8f61 with SMTP id
 ffacd0b85a97d-432852d8f98mr16972869f8f.21.1767109783496; 
 Tue, 30 Dec 2025 07:49:43 -0800 (PST)
Received: from myrica.home (233.226.6.51.dyn.plus.net. [51.6.226.233])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1aee5sm70343633f8f.4.2025.12.30.07.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 07:49:43 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: eric.auger@redhat.com
Cc: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, jpb@kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] MAINTAINERS: Update VIOT maintainer
Date: Tue, 30 Dec 2025 15:48:45 +0000
Message-ID: <20251230154844.325364-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x431.google.com
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

Unfortunately I can't contribute to QEMU for the time being, but Eric
has offered to take on maintainership of the ACPI VIOT. Thank you!

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cbae7c26f8..a11338f1b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2174,7 +2174,7 @@ S: Maintained
 F: hw/riscv/virt-acpi-build.c
 
 ACPI/VIOT
-M: Jean-Philippe Brucker <jean-philippe@linaro.org>
+M: Eric Auger <eric.auger@redhat.com>
 S: Supported
 F: hw/acpi/viot.c
 F: hw/acpi/viot.h

base-commit: 942b0d378a1de9649085ad6db5306d5b8cef3591
-- 
2.51.0


