Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E6FC41513
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbHT-0004N5-SC; Tue, 18 Jun 2024 12:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbHR-0004Gz-7I
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:01:57 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbHO-0006um-O7
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:01:56 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57a44c2ce80so6726733a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726512; x=1719331312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8FeF7HG1jBJoN+fgafsrLpLmoyytTa1LuFpsp6SO8ew=;
 b=K5aw73PqCE3xWf9JyOfJRdV0uLMfNpEpYjvOLTuenXN7HD5LqCqOPRzk84MZx4ot8d
 MaoAjeGnhpg0o2cvNLgEvy4qle5GXcALR/xbUdoRq9PnAEKMMhONZFpOq1Em23077jeZ
 CG0dBYXQHRJIlY7Sg5NMyQo+rrC1p7NW+4CG6NngjeIVtPMOf8QQY6iCudciq3VLx6wS
 +D00sha03xEljK4l+dOwjDahv9uJ2DiyclhzASac3WBvp0rbSOmeqP8HUCnp6I0sV7Do
 0LSN7khRQ/cDl0VRGsRE/OWQUmcjr0sC6c0yj45nSZ0IduTXJvdUFAK9c2uSsWvj3294
 jKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726512; x=1719331312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8FeF7HG1jBJoN+fgafsrLpLmoyytTa1LuFpsp6SO8ew=;
 b=i0S+685bo0qcvLngY101aAySC1e1l/hgmXrFcbAiirkhMwawKOU3dUaa8E0for5EYk
 H1IEL0C/HsMfYT7xcQN2YZlUNSL5sKCzmyNIAmVllnaTugZJ/w9HDcmQ+N5d0zq0XIqH
 m54K5KuBGOXg7lckbVIkemMTFI5ED6GqeyFabe21HL4iWA8SI1ApEsuPKJOGvmhcW/UF
 8OXpRJdXPAh06ktTDb+GOsLk72nuxDb4yU2a9Xl/Q/HcGTemOCgRYUAZ3o1aFVwFUrFc
 3bBLx271jpGaoykV+ENzrSyX/CI2oOllir+UrVS5yt2faUO4Zt1hYvxneE6afX3xi8Zw
 Digg==
X-Gm-Message-State: AOJu0YwOIuHzoY65lhl0uzTT4KiXgLS27h5QVGb9tfG5dUwR2Wyct/Zj
 IhJcmj01nhKDTYmWY61JBzQpu2FLs5Ankfn0TR1oNDeWRMksUgtw97007DlM3XSJ4VlKOUPmm09
 A
X-Google-Smtp-Source: AGHT+IFm2Hk0qyf4cDdlcXryswae7t+8wBtK0Hzqu0SjxkzbP927WTJgZUnmlXLKWHJfPzuV0S4HUA==
X-Received: by 2002:a50:d75a:0:b0:57c:6f1d:1926 with SMTP id
 4fb4d7f45d1cf-57cbd68f814mr8980753a12.22.1718726512425; 
 Tue, 18 Jun 2024 09:01:52 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72cdfd0sm7894027a12.5.2024.06.18.09.01.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:01:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 12/76] hw/smbios: Remove 'smbios_uuid_encoded',
 simplify smbios_encode_uuid()
Date: Tue, 18 Jun 2024 17:59:34 +0200
Message-ID: <20240618160039.36108-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

'smbios_encode_uuid' is always true, remove it,
simplifying smbios_encode_uuid().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240617071118.60464-13-philmd@linaro.org>
---
 hw/smbios/smbios.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 8261eb716f..3b7703489d 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -30,7 +30,6 @@
 #include "hw/pci/pci_device.h"
 #include "smbios_build.h"
 
-static const bool smbios_uuid_encoded = true;
 /*
  * SMBIOS tables provided by user with '-smbios file=<foo>' option
  */
@@ -600,11 +599,9 @@ static void smbios_build_type_0_table(void)
 static void smbios_encode_uuid(struct smbios_uuid *uuid, QemuUUID *in)
 {
     memcpy(uuid, in, 16);
-    if (smbios_uuid_encoded) {
-        uuid->time_low = bswap32(uuid->time_low);
-        uuid->time_mid = bswap16(uuid->time_mid);
-        uuid->time_hi_and_version = bswap16(uuid->time_hi_and_version);
-    }
+    uuid->time_low = bswap32(uuid->time_low);
+    uuid->time_mid = bswap16(uuid->time_mid);
+    uuid->time_hi_and_version = bswap16(uuid->time_hi_and_version);
 }
 
 static void smbios_build_type_1_table(void)
-- 
2.41.0


