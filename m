Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4517EC28B2E
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr3Jc-0006lz-6d; Sat, 08 Mar 2025 18:10:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3JY-0006Vs-5b
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:10:40 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3JW-0001Us-Iy
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:10:39 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso16913765e9.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 15:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741475437; x=1742080237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PCiNgLEiS6OiisxvVuwTtdLprKkJGMzsN7gdfZerLX8=;
 b=ZQJ2a2YryAeB8LeI9Nvd0XvB/s7tCSDx4DGC8oSsYBRPmruil6YxUpDztApeZ2MTon
 rJ+oPR+HWkC+nsGqTsU6A63TFZRG7xFfFbz5tIXzPk8Y6ITmda58dsmWcBcENM2lfMJH
 F8f7ygm6TDMOwUsBeuALIf7VtZwM1AWk/ql3CfMEGQjb9rVXkuBXc4RSyZwq3HxUiytP
 agHVd2ZUB2S+Xm/5uLYOSNHalxH8wK6Y+noocq5ZndIGL36+WlTSvm4v5zH8ILuZx1he
 2u+79zjFFXCieYlTPko19oj5JRTSAnqVdu+Jx9pZTlwbSqAwXzpN/3O5gjX3YX+1qb9X
 DyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741475437; x=1742080237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PCiNgLEiS6OiisxvVuwTtdLprKkJGMzsN7gdfZerLX8=;
 b=VCHUH6mpgQ6dfbkBaHlcxXfQVWLwHnjDzIIuo2wygmbuZChxKrTD98/sVeAOtFGIET
 aqWalb03BiqGRcJ+1CkppHl17r/tILXPPC400b2VJ9GjhTjEoy6ckEW4+mdVtoFIwStS
 5/X7iyQoqVxJkDpiP9fLEk7uKkNQj2XbyB7vY2+AKmEc4IZP5dvbw+ukq3XIYM6ATlH7
 qSdSSTkzJY4l2pZcHGRPVkrgs0yX5v6hJJmNfoXiXvXmMUzCVXMriGlcFJVY4iBh2Bu+
 2FS/Hk9fpQ2VocGzvTE42DSOdWFv3ogP6PvakkcE2MD55Ukf7OQ2Dt73dFq6hXH5bamJ
 KfAA==
X-Gm-Message-State: AOJu0YxJrmHaY/HOAnf6V0mPrwKJQpel6Vgb5FanJsvplj2F/N+mzcrl
 cCmW7c6nZNcHnB0OgL6mMzLzNdcNqGFWZZ5bG9Kd9l7vCitVgF3XM8dZ/hRJzAQTM73L/92LY8C
 n44I=
X-Gm-Gg: ASbGncucAIetS3Y+a2/y9x34w7ibbtrTSx/j/cvIPEdF5RAa8KLLEKMMo8rqobWdS1w
 mYHTUOcDu4TEFyb37Nk3ySUXHT5tzyNb06ae+M9I8rXG20DrQ4FXziFO/66to7JSJ83IgbC+I6r
 1EJfvT44v3V+qjrH9lm3PK9g6b3M2c1Gc51M25TwuQSfWuGHUUE5/e5Ez34K+D4efi2d3j1aVYu
 SP3pz361kFl9Jg9HBu0LeQuztKTHD9vtzq0ZARV+PxKVg5IgW3J26YgYhR+AlGhM0mRHdd2WMKi
 VVQJEYITVXrYBV8e0EJr/cVj1h+JmsypA8Mi9c7Al/tuA5tGoTjW5Zl62+nb6/px0gx2872o81y
 gnNbWNhTEActfti/oVP4=
X-Google-Smtp-Source: AGHT+IENrA47OVsXzaZX4a1bGAgrCx0XL0i2aOlzI6Mq7cL2vI+8HE9sGHrEgItEH0nHk0n3/e8OGA==
X-Received: by 2002:a05:600c:470c:b0:43c:f050:fed3 with SMTP id
 5b1f17b1804b1-43cf051022dmr4854905e9.11.1741475436763; 
 Sat, 08 Mar 2025 15:10:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42c6203sm126860865e9.24.2025.03.08.15.10.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 15:10:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 13/21] hw/vfio/igd: Compile once
Date: Sun,  9 Mar 2025 00:09:09 +0100
Message-ID: <20250308230917.18907-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308230917.18907-1-philmd@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The file doesn't use any target-specific knowledge anymore,
move it to system_ss[] to build it once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/meson.build | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 6ab711d0539..21c9cd6d2eb 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -11,13 +11,14 @@ vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
 vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PLATFORM', if_true: files('platform.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
-vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
 
 specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
 
 system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
 system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
-system_ss.add(when: 'CONFIG_VFIO_IGD', if_false: files(
+system_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files(
+  'igd.c',
+), if_false: files(
   'igd-stubs.c',
 ))
 system_ss.add(when: 'CONFIG_VFIO', if_true: files(
-- 
2.47.1


