Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F12CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQn1-0000Wm-C6; Tue, 02 Sep 2025 09:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQmy-0000Uw-27
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:08 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQmt-0004SY-RR
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:07 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3d0b6008a8bso2100215f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818660; x=1757423460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7F5eIWtwGjAcSDjJbli/J422DEzt3H2+R5Kkkzggnos=;
 b=UWO72YEwPSF9Aeah8oyng9DeUVrbLxuDYprk6L0kscF5XUsSlit5YXmYyGMEQMQmI4
 GZKBj5+RMwA8JOT/bbJJUvROYucWKaa8kILq7vtsaBflHq1y0slsmegk4QZ2gDsXX+JJ
 6+jRJKv1HMF6E1mIvPCra9j8xkwV6Fw6q6i6rcbSjU8avn7IkUX+JOpv+R2P8Kbk04/3
 bjdV0B7Ca84oxv9rI4r1wjpAgdQVqBue6llcNfADZRKHEX4WseSkwetOA7RSW5mG7Bzw
 HrP2yCEZNu3b7vVh7G5uxMm/XwmK8NbeYe79pIfrfHGI7puevKhi7pYf6pqfO3btH0BE
 7IqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818660; x=1757423460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7F5eIWtwGjAcSDjJbli/J422DEzt3H2+R5Kkkzggnos=;
 b=NqcPTtUWmw1Pxqi0b4O0ZT9LUXK6qXdaGjveYb0PpNrobbdW2BxX/ocoNbQX+nZPNO
 kszE00QJ2vzCuv9RIU2z8fV2h0O9tFSzDmvQ/wi83jeSYrrS+Xc2LSTS00dewn7+7W6E
 qE5f98pmZL7FH3Q1zW8PSQT2JZ2CcPv+kScTtpHuBOoOiXd2JzphPyTe6I8EpGQ/PRGZ
 51sq92YosDgmPMpP8+fngAnPk9W7DAcj+LYFJ6YONkHyqeqZcbar4nygim17BUtuikcp
 xzzC+5aovOizKKO1lSRSLiqeHyxHbKaQ/anWyJflv5c97UXc/8kGI4fl33+sJgwFHLXP
 KPag==
X-Gm-Message-State: AOJu0YxSHZZd++HgFOVCm1aHXpiBzGRECT1c2AaWhxyeRPEfWiH5PC92
 1BVivqnc95DyC5pu4xlEe+c4Wn7ND8dcTtIyPgsZ3FUM1sYv/mW/0g1GwnwTyDIxwAlhRSwg13C
 sHj3h
X-Gm-Gg: ASbGncv4J9NQtBfdeLlpysj5EPQEJYCtpUHmfegv+H7/hxwKluDUPbxiP3/41Zma0dA
 3EurSnpOd8YvOgySPj8Qwm/lfjm+y3KZ+1xcpN7uk3IAYTjp2Iv0wFDI7EXVkY54Zi3jWn4nM6U
 6W8A5e76+5rX5Zz8sKf2rcWlKpL1B5MHIginzAvzTG4wy3odxeMWCYMryNi5pW4pLBi/Q7CC0z6
 u3fXyr+bB3HCB0ar/xkCXDuIilho0ZfxTAT/hg2TCeHvkHlRHMCueiWnSiF0AlipoN0/gToUiux
 wNpm9LIjP5u7VakrZNixjDIyjMT31Fc7ts5Q7FA4aHvtD+ID0XMXYk/GzoGrX6kV8cc9ina6WX5
 882wUJLHlmiRe+0eNzaFWytAu6Pm96NIcqRbSNaZYxIxf0sAQ2l8RAoZyVzOILrxuY7lwDaOnf7
 8xtfDhWKo=
X-Google-Smtp-Source: AGHT+IGRru28GlAmQS2YlNliqsRwTVl7DfXxRd0qyRgM+12gljJrpPCPPZykgf4JxInVdOjtPkHoTg==
X-Received: by 2002:a05:6000:18a2:b0:3c8:d236:26aa with SMTP id
 ffacd0b85a97d-3d1e05b9a97mr9648132f8f.58.1756818659560; 
 Tue, 02 Sep 2025 06:10:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d21a32dbc5sm15924801f8f.11.2025.09.02.06.10.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:10:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/39] hw/meson: enter target hw first
Date: Tue,  2 Sep 2025 15:09:46 +0200
Message-ID: <20250902131016.84968-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We can reuse target source sets for "generic" devices that are related
to a single architecture (like interrupt controllers).

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250801174006.2466508-2-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/meson.build | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/hw/meson.build b/hw/meson.build
index 791ce21ab42..1022bdb8069 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,3 +1,26 @@
+# Enter target code first to reuse variables associated
+subdir('alpha')
+subdir('arm')
+subdir('avr')
+subdir('hppa')
+subdir('xenpv') # i386 uses it
+subdir('i386')
+subdir('loongarch')
+subdir('m68k')
+subdir('microblaze')
+subdir('mips')
+subdir('openrisc')
+subdir('ppc')
+subdir('remote')
+subdir('riscv')
+subdir('rx')
+subdir('s390x')
+subdir('sh4')
+subdir('sparc')
+subdir('sparc64')
+subdir('tricore')
+subdir('xtensa')
+
 subdir('9pfs')
 subdir('acpi')
 subdir('adc')
@@ -44,26 +67,4 @@ subdir('virtio')
 subdir('vmapple')
 subdir('watchdog')
 subdir('xen')
-subdir('xenpv')
 subdir('fsi')
-
-subdir('alpha')
-subdir('arm')
-subdir('avr')
-subdir('hppa')
-subdir('i386')
-subdir('loongarch')
-subdir('m68k')
-subdir('microblaze')
-subdir('mips')
-subdir('openrisc')
-subdir('ppc')
-subdir('remote')
-subdir('riscv')
-subdir('rx')
-subdir('s390x')
-subdir('sh4')
-subdir('sparc')
-subdir('sparc64')
-subdir('tricore')
-subdir('xtensa')
-- 
2.51.0


