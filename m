Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A08AD1CDB8
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 08:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Aeb-00060l-KE; Tue, 22 Oct 2024 04:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3AeX-000608-Gl
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3AeV-0003VN-Op
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729587245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=m9jaaMZV2jCLMhr7hyIfgarHDbfhaJSn2IeUobUjr+4=;
 b=Kq2plsXO9t93AV+lCr35sh6chQNhDL7hWvdtWho60asUnaGQCufDHGoedFxzYUxot5NmDn
 P3jvVE4dbWPNa8yVwyeGTfBTBOQ9ZpLXTuZC2JptJgiRz/nyh4oIybHz85yKIoD1HuzA3Y
 wmMySInHkVGiLJrHDVTtmEoaOzARhcU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-777whuuTPI2EyBZMMQ6kqw-1; Tue, 22 Oct 2024 04:54:03 -0400
X-MC-Unique: 777whuuTPI2EyBZMMQ6kqw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d52ca258eso2642304f8f.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 01:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729587242; x=1730192042;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m9jaaMZV2jCLMhr7hyIfgarHDbfhaJSn2IeUobUjr+4=;
 b=Xy6NsT1wtgiik0kGEk49sv/PPR2YzJ1uF1wm8/t5F3SmlRTrJOx2aPibBcQS1MiBMq
 lQNzKLOo+qlVv8UZyxx4POuNMgtdAOdOn4qmfYKRFMssQqsBfcn5tUG8sOvYdN8L0YMh
 gvJT2FopTQgdGSX1uPzrrv7KQ91zK/LFys4bRHI3LKV25S5o6ueel8fXDMec1cKbZaY0
 sn7rTv8PuzMHIiyOisJ97wBJpbGGB1lN9Mm1WMm7PdpR/kYtAKxfHs0y7DFZMo0x0iX8
 BWSZ9bmmr4WolUgiN+jtnpjcCg+NchqAs0JETBlHQ7LmgMNFsiK6Pb3PDY8h8URC9VKh
 v/tg==
X-Gm-Message-State: AOJu0Yx6jCRJ1DnXdNxuaRyUwrwxQ4wlgduoGNqKs3ZL6Z3HcMljHgLA
 EClbCtsdvwFwWB5ZKUbqhzTon6oQ6vaBzGSPxW8D6n49LzIoiGO/kfyHmoc0ooRWEb1qwQkkVbe
 /RfoQBg8x+LrtxV88O9ryzaKpCC3TMtHd5HTkR/sONjslyJ7YFXkLyPa9viiG53/cF1DC7LNHLo
 U8E2NZ2YYWrRo+yD7jmTqgRDNN/trBHLII76PfnNY=
X-Received: by 2002:a05:6000:a:b0:37e:d965:4e04 with SMTP id
 ffacd0b85a97d-37ef0bf7463mr1728191f8f.36.1729587241938; 
 Tue, 22 Oct 2024 01:54:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSBbDCV0IPiJQL1Cpw6RsXYbLQytjfAu7mViVjvSS71jVeAY55pJG6hvJuh/tf9ls79XsBLQ==
X-Received: by 2002:a05:6000:a:b0:37e:d965:4e04 with SMTP id
 ffacd0b85a97d-37ef0bf7463mr1728170f8f.36.1729587241534; 
 Tue, 22 Oct 2024 01:54:01 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a5b630sm6142829f8f.60.2024.10.22.01.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 01:54:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, peter.maydell@linaro.org,
 berrange@redhat.com
Subject: [PATCH] arm: Kconfig: disable stellaris if Rust is enabled
Date: Tue, 22 Oct 2024 10:53:59 +0200
Message-ID: <20241022085359.186470-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The stellaris board requires the pl011-luminary variant of pl011,
which is not supported by the Rust implementation.

There are at least three possibilities: 1) implement the subclass
(a bit harder in Rust since the language does not have subclasses)
2) change the ID to a property 3) split pl011-luminary to a separate
Kconfig symbol and leave the subclass as C code.

Just for the sake of starting the discussion, this RFC patch uses
the big axe and disables stellaris.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/arm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index e7fd9338d11..d5ade150d23 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -219,12 +219,12 @@ config STELLARIS
     bool
     default y
     depends on TCG && ARM
+    depends on !HAVE_RUST # Rust does not implement pl011-luminary
     imply I2C_DEVICES
     select ARM_V7M
     select CMSDK_APB_WATCHDOG
     select I2C
-    select PL011 if !HAVE_RUST # UART
-    select X_PL011_RUST if HAVE_RUST # UART
+    select PL011 # UART
     select PL022 # SPI
     select PL061 # GPIO
     select SSD0303 # OLED display
-- 
2.46.2


