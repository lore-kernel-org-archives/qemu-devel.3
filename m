Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CB6CF34D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 23:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swVT7-0007R6-5C; Thu, 03 Oct 2024 19:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swVT3-0007PV-EK
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:42:45 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swVT1-0003Xc-VK
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:42:45 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cbc22e1c4so12169225e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 16:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727998962; x=1728603762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A2b2LwHBDDNlQ4lpraog9QbauHHDsoDaj9FTLQzChw4=;
 b=Dv6K9vlHkdK0ZrufRyplTCH1bPArT/8GdAbHw5Xr7QwQqTAzTF7ObyfqtnbQF5FS8W
 dk1NlJouizbAl/AuU1TTSjYZJu/3cHCxReWxyGspBlR6p8YwmJhzD3U8sZSSalT0WJXK
 xphsrmmdY5Fdj1V1mMpR/4xZVZTBb06hFrEYwzF+HNzceqM4FJacKToZ3PytVr4WtY3c
 F0UKU/KhrkmSgo+T2xPBWQl7G4IZF7D185mV8dp8Z+WWG68WzHCgvG58SXSRfTvibawk
 BmDxTYKEkO8S1yWkb0JY4I6bzJ7RuhvGuF6/nRFrRTL19DnT2r6irP/jWJLnZfai/+v2
 Myig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727998962; x=1728603762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A2b2LwHBDDNlQ4lpraog9QbauHHDsoDaj9FTLQzChw4=;
 b=rK7BCS64L9tG+1xGMq72N0KSPzUvdksbKwqlMhzQED6Tj2JePdpZUUyKl5UNzlDF/1
 5gpHOfqMuTinSkoQQAS+8O+wphVD7PQLRb3Z6BnDoqs1iRiQlKyhToArpVmOxNMI5M9t
 1163O0UgqcfGbbXvopoidstk7GN53r1lmg9Y4pTlOLKzNb3JnjpApAZy3torCacwjTbD
 UxURDWPH4EaKB1VYTfB4zM7JQUyJDbfdLIKZduPX59IsC1w/p+Ra3QwpMXMK8fRap+mD
 htaQrD6gIuXODB+H2BMAASyi2WBrroAalC0Q7PQdRf8uR6VqPrbrnkIqb1iiNOniI5il
 Y+BQ==
X-Gm-Message-State: AOJu0YxZpz80fkPrW0OkwhQfAKqxtVpWwm2mFADRFS3bAJqvg0MPlJm2
 6K7pvAbf4HGXiMaixdHpPRKWNdRsTbD4klDX4kFTe3euZiNltF1M7JvlLV47gn3/xeufwKk+J3p
 oIPM=
X-Google-Smtp-Source: AGHT+IFUhQSBkMnwy2l0lFzF+iJGccfusHlORuoJfYCEHpm//0iz8GifaG1pW6FqC7DwbSM5AG2H1w==
X-Received: by 2002:adf:fe8a:0:b0:37c:ccfc:92c0 with SMTP id
 ffacd0b85a97d-37d0eb1b83emr472244f8f.57.1727998962052; 
 Thu, 03 Oct 2024 16:42:42 -0700 (PDT)
Received: from localhost.localdomain (45.red-88-29-191.dynamicip.rima-tde.net.
 [88.29.191.45]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d07fde1fesm2201806f8f.0.2024.10.03.16.42.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Oct 2024 16:42:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Song Gao <gaosong@loongson.cn>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 03/16] linux-user/i386: Use explicit little-endian LD/ST API
Date: Fri,  4 Oct 2024 01:41:58 +0200
Message-ID: <20241003234211.53644-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003234211.53644-1-philmd@linaro.org>
References: <20241003234211.53644-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

The x86 architecture uses little endianness. Directly use
the little-endian LD/ST API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/i386/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index cb90711834f..0f11dba831f 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -754,8 +754,8 @@ static bool restore_sigcontext(CPUX86State *env, struct target_sigcontext *sc)
     env->eip = tswapl(sc->rip);
 #endif
 
-    cpu_x86_load_seg(env, R_CS, lduw_p(&sc->cs) | 3);
-    cpu_x86_load_seg(env, R_SS, lduw_p(&sc->ss) | 3);
+    cpu_x86_load_seg(env, R_CS, lduw_le_p(&sc->cs) | 3);
+    cpu_x86_load_seg(env, R_SS, lduw_le_p(&sc->ss) | 3);
 
     tmpflags = tswapl(sc->eflags);
     env->eflags = (env->eflags & ~0x40DD5) | (tmpflags & 0x40DD5);
-- 
2.45.2


