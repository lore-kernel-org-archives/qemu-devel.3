Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2051C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPxX-0004Xf-FP; Wed, 27 Mar 2024 05:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPxV-0004Jd-P4
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:52:37 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPxU-0006oe-77
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:52:37 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-515a86daf09so4808043e87.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711533154; x=1712137954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OsIizV2m9/3hMtPiDzFMJ5egzT3hkg2W7UMGOxAPpCY=;
 b=a0+aSuiqnIhw/kQIpKKPglJ8y4hl6qpncGmMSU7PUni5TdKVb/FZCaNX0aBpOQyJ14
 L89ZEwNV9BztbR9AkUBtOz3WKy5nmX1pHLps+nNSttdxV/aqDIu8LO0GGyNOn5JlZpL6
 Hax5QgZDpbp+7gHtu3eA3QX0AePwi1HvRFHoT/IS/F82AMzJCIaoJEXXq9tCKqgiwWhU
 BvdLNYXdTLiOVh97cIT6rHUM/vZV0dYrAF4rGE2sBuiCltfcqtONGypCxuW8JKCEkxKe
 Ky+RdzsHAzRvk6WuhsBohv+E15ggrSyNHg0u0LDlDved+7kAAOkLfapc+sC+RD8ZO0q7
 CDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711533154; x=1712137954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OsIizV2m9/3hMtPiDzFMJ5egzT3hkg2W7UMGOxAPpCY=;
 b=w2G2ea1SJwNdBbcVJY0UlRlBgDV1ypS5k5kti2JMLAbCrkRaE0vS9V/mrsz3l+v5oE
 ilK7GaFq6OLINW1ESpCd6ILdpphc5ytj0dssmUHn3CJJKQDi+p9EWgpW24zl+f8LIOER
 ppuggMp22HbcbSLGyDRpSAdK1oWAZWduyIiSHEwkBdsJX3Y+o+GyjINaKzw/3pTVINsY
 3ZYLHEt1pxcKttBdBOsKjNIW1IYlSELKU9K2gov9DMwO+4ZtqoNlS1KU7kmfpd2V4V/h
 6hoaU8txontAtBbG5Fd3ssUb8AQyqNoaxQBqPKquzpu8o5CnE1s6PjvOqY/lXK04TsBu
 VLtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWeMzEB+44ubqcF7993KAcofH7RzB9bCst0vwcUZpO9Wf7t/6f1DGMUF+CdGIkuB2i9iDufnuk2mIFECC7ldiRaehaiMQ=
X-Gm-Message-State: AOJu0YxF+eGdyfUpUoeXyUXUEm8VO+GjK9EIbztR9q55PdhstOfBxXh4
 bkJrJUyx1J7BrkOpYB/A+/JUZMFYw64/dRVGwI0ZoVdFs8PeLRWC49n8Kn7EsxM=
X-Google-Smtp-Source: AGHT+IHr7bRIQSdgpFFvVGHqYS3EOet/KzGvqm3v+2kKbJ0qO5H24xWfEb30AurSX34WqIQMnpeQtA==
X-Received: by 2002:ac2:5a5d:0:b0:515:8c3e:566b with SMTP id
 r29-20020ac25a5d000000b005158c3e566bmr582754lfn.31.1711533154397; 
 Wed, 27 Mar 2024 02:52:34 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 i18-20020a170906265200b00a4df5e48d11sm1558656ejc.72.2024.03.27.02.52.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Mar 2024 02:52:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Zhao Liu <zhao1.liu@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 v2 11/21] hw/smbios: Remove 'smbios_uuid_encoded',
 simplify smbios_encode_uuid()
Date: Wed, 27 Mar 2024 10:51:13 +0100
Message-ID: <20240327095124.73639-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240327095124.73639-1-philmd@linaro.org>
References: <20240327095124.73639-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

'smbios_encode_uuid' is always true, remove it,
simplifying smbios_encode_uuid().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


