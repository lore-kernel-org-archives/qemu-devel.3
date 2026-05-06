Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589DFFF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcuk-0000ON-SN; Wed, 06 May 2026 10:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcuK-000861-4w
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:07:24 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcuG-0001u8-KT
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:07:23 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so7247085e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076438; x=1778681238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tzTXng2eGHvdBSlbAlW/K/vbtwAgahERdYZnQaXODMk=;
 b=iQEadZaw8dneZM78KLRoreBhA+dT2SxOzyVMdFM6Ql6va/dKGi/S7WD24SvA3Mjst8
 pxqawy7tZ5/ubvSQ/llfkNKdqxDDiMFC2ayD3MwFmcFaWkhHR029unkAM78Kyp31USZB
 DmF0vdH71FauCcjM7yo7idSJFlbIWyi9e8dT4jDwgn2y1BxLLKR907j7Zp+wtWoHytO7
 AeGxGUvU14xMA7unNMvna+yQvP9qqIPjBCVtsQZl5JjPPFKvXCuUeV+yeaLKZSECKbvY
 lezpRqKmGhe4hVvhLFyfktITMxeVoepjsfiEYr1ER0WV1rw2DkYEEMbHHGqmlLgDcuOD
 ecww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076438; x=1778681238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tzTXng2eGHvdBSlbAlW/K/vbtwAgahERdYZnQaXODMk=;
 b=UHrUqru7jIajSie6b4Vn33UFTzNv03QPIhe0Q16bI0Pv5WqKW3QzsWLwHb/aPg0lFT
 DmekQqYH3OtxO65IbjCxg5OpZxIATiX6UCpNASnSSucgGaUQf/Qb3edJLoZPaDWtotPX
 Qh0Tpi6xalpKhB0gv9+/uvQsQl88z3McJs60zTLu5jGpmmcMNOtLfiTGR9qcCxkTEA+x
 DutpwUsZWACncwS0qL3zyzO8M+l08VdpT5b4H4wVMjXJ3e22/E3QJK/58k818RKpehSZ
 wuV6Rg21nZPBJ3mKV3g1GIAClhgveBhZHhwSpE9+FRzF0u1Awe6y+tc3I2hwxddRSezZ
 8eUg==
X-Gm-Message-State: AOJu0Yx6gaAgUOCZxHSoDl7EJk56lIgyVr6VS8gBhYtLAlt+WygXFNBe
 RAQkOzX1/gCRsD8UZ3K3H9pChOrY0q7xMp6XJ9zcLEsYW2lbOON2gsIPOGww+OzxdqTSzEFslZW
 mV7opPEQ=
X-Gm-Gg: AeBDietrFwXoYq7LjaicZUKhshz4BRAyXOVdI12ScQ9ib23P8YXsPr2WQ10NYu51w+j
 IkJL3Nfg7tKQyuA7vgJNl4D1cewhBQ+BaPHZH7JD7+jDMoNJqngNTlcy+hBfEy/y3I+aKTuWS+n
 y1Lp+ba+KpQ1zOhzf6hDmTC6HWNgB77xECxxfJpP93fqV1/d4sj6yyCfD3Xj4BjqOZ/H6G2efFH
 7855L205CX2e0LX4QZPCVJiX4vIVXwSO9Gm0d68lg2borS3B/5iLKhOi1QQ7nrqZXl262K07gaV
 hu7JusKk7YRITcGbQihb7AiESIkoiqnuZIIBoNc9SehQt3rQOfxNXBkDvzjljGCsq4pYzLPjORE
 EqXCDa9LM4vjgn/y1luICt2vtNzdksiF7Yf0JsLnCy3XStaBW9sN8yAZQxVJkwOXHbFqcEYM/U4
 FD+UvIwHU22uxuY6Jg5gNjdv6SdlcNtcyDS5Zg3jydAWzdyUgiWAlK5WaRHXH4q3eJyvI+ZhVD8
 l3ahVTjs5E=
X-Received: by 2002:a05:600c:c11c:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-48e5226c4f0mr38171165e9.2.1778076437715; 
 Wed, 06 May 2026 07:07:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530a67dcsm27577715e9.2.2026.05.06.07.07.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:07:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 090/110] target/s390x: Compile few files as common unit
Date: Wed,  6 May 2026 15:55:02 +0200
Message-ID: <20260506135524.20617-91-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Nothing in these files prevents it to be built as common unit:

 - cc_helper.c
 - excp_helper.c
 - fpu_helper.c
 - vec_fpu_helper.c
 - vec_int_helper.c
 - vec_string_helper.c

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20260423135035.50126-5-philmd@linaro.org>
---
 target/s390x/tcg/meson.build | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/s390x/tcg/meson.build b/target/s390x/tcg/meson.build
index 17c9374d09e..67f31bfddd4 100644
--- a/target/s390x/tcg/meson.build
+++ b/target/s390x/tcg/meson.build
@@ -1,14 +1,16 @@
 s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
-  'cc_helper.c',
   'crypto_helper.c',
-  'excp_helper.c',
-  'fpu_helper.c',
   'int_helper.c',
   'mem_helper.c',
   'misc_helper.c',
   'translate.c',
-  'vec_fpu_helper.c',
   'vec_helper.c',
+))
+s390x_common_ss.add(when: 'CONFIG_TCG', if_true: files(
+  'cc_helper.c',
+  'excp_helper.c',
+  'fpu_helper.c',
+  'vec_fpu_helper.c',
   'vec_int_helper.c',
   'vec_string_helper.c',
 ))
-- 
2.53.0


