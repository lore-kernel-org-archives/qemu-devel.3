Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EC2C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 12:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZrVM-00061G-Cr; Tue, 13 Feb 2024 07:03:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZrUW-0005Rj-7h
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:02:37 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZrUN-00017F-RQ
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:02:19 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33ce2d1882fso31452f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 04:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707825728; x=1708430528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=am9vw1W4ncVE3TCNY/MXT9+eSWY4vJNOkE0J8mT4o5M=;
 b=OLUDVSX1xMUpbWZ9zk/vqfufb+lWJP/Qbox8o1W43BhI2Hplbk3N8wSFAkV2Grf6jY
 ahP4Ebx9x59w9VE0mSou2Pudlf/ec72/xcPDF95ftx0LflH9foKfdTJfaPoRbHawFMvf
 gK7vG7Ks3xUx9QnFg7j1/RxfGdljMhjcugKLpr6qbMjVm7CDTrf+QQjhSoZL8ZgClv0J
 X4bMb4jNA+bJZOCOXPh6YpyKSrsTqM254D/fbvGs1CQVA8E81ASCwvgZe7C38dbAQwEN
 /GfUJSKzlJWiESvheO1AbFaeFDd2YCZnrDNqYNIJgs3cEfg2sNSFBa+BoV8IEqL/kXKf
 zVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707825728; x=1708430528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=am9vw1W4ncVE3TCNY/MXT9+eSWY4vJNOkE0J8mT4o5M=;
 b=wsu7QVO/2GMUCXrpKFKX2RdvVOGky2erCso7cW9Tr0hzdC6dlhrih6EkrxDL5GxMWX
 arzPgBCkBjh9DOmpR6Q50oREVO581RpLxJvp0QwcPhX+V+OTABeGMa/6IZdTJjbE5XQl
 +Cdk0P6VHOitwxADGvIsXr6uAaT19sU619GolkmtbwdQaCnOCHI5GQiJS+vgAvmETBDQ
 LanGXDmHsoCeijW0iO8KXWE5EBG8iZ1oZgD8VNeIwW5GdHu4VLwzstCkc+EuoA33AkTk
 kEVbtpHvE7coh9U646Ym84VdOob2LUK42rdy+HeFPaMOsj6Y75dOzduE/GAqngYi2Kyd
 5OyQ==
X-Gm-Message-State: AOJu0Ywzf5qm8l3FrL3j8RwV1up8/k19UYeFiHS+YSsL/R6I8rgqqk+Y
 CkTnBe0U0H47+LejILf9ekN0OCnvcjH0LuupIncf7dTX7a5194Wt1EPiS+/zD8m38rMJHYKDS+x
 5
X-Google-Smtp-Source: AGHT+IHy2g/+Ro2LlkPhrmSYGUif5Fn4NIDKPzAknpGOZKfeoAp9Wz7cGPMGGQKGotR5XSIlZPH1jw==
X-Received: by 2002:a5d:4f10:0:b0:33c:e2b1:b1e2 with SMTP id
 c16-20020a5d4f10000000b0033ce2b1b1e2mr194860wru.67.1707825727975; 
 Tue, 13 Feb 2024 04:02:07 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXHK1yxT4AmZoO1EUrqSSo5e3+Uf+kNrxSXpZbAlqrQDcxJ24bWuYggHvaf8WxCKUGzLMGRyEAJ6TiKiNZI8OF5TB/dg9xvb/EeN8SIKy5CTAowIIkqGqqMK/EkHJ0tcJv/r1fk8IU1+uf3BDY7roMNFrhcLFPGbj+mK58znVtgg3x7xbAKsJgllYr/TWSsqEQsFLQBK79Ry8vq0uwILwo7YIz9hwFQHYi/h/4yaq2TjZvWp51hpswfp8MsfbU+aIJd8YpRY3mH6vcrPm9qA/CKtUuooM4fYZxcJnqPs2H6iM8HlzWTk88PNumBSctavd0weP/Om0c=
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 r3-20020adfca83000000b0033cdbe335bcsm1266650wrh.71.2024.02.13.04.02.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 04:02:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/7] hw/timer: Move HPET_INTCAP definition to "hpet.h"
Date: Tue, 13 Feb 2024 13:01:47 +0100
Message-ID: <20240213120153.90930-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213120153.90930-1-philmd@linaro.org>
References: <20240213120153.90930-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

HPET_INTCAP is specific to TYPE_HPET, so define it there.
hpet.c doesn't need to include "hw/i386/pc.h" anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h    | 2 --
 include/hw/timer/hpet.h | 2 ++
 hw/timer/hpet.c         | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ec0e5efcb2..f9fc42c2be 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -15,8 +15,6 @@
 #include "hw/firmware/smbios.h"
 #include "hw/cxl/cxl.h"
 
-#define HPET_INTCAP "hpet-intcap"
-
 /**
  * PCMachineState:
  * @acpi_dev: link to ACPI PM device that performs ACPI hotplug handling
diff --git a/include/hw/timer/hpet.h b/include/hw/timer/hpet.h
index f04c4d3238..d17a8d4319 100644
--- a/include/hw/timer/hpet.h
+++ b/include/hw/timer/hpet.h
@@ -78,6 +78,8 @@ extern struct hpet_fw_config hpet_cfg;
 
 #define TYPE_HPET "hpet"
 
+#define HPET_INTCAP "hpet-intcap"
+
 static inline bool hpet_find(void)
 {
     return object_resolve_path_type("", TYPE_HPET, NULL);
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 1672faa4f2..01efe4885d 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -25,7 +25,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/i386/pc.h"
 #include "hw/irq.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-- 
2.41.0


