Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E742D0D171
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 20:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vda7M-0004VV-Pv; Wed, 07 Jan 2026 15:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vda7J-0004Hl-QO
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:26:53 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vda7H-0006Tk-M2
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:26:53 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so26818495e9.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 12:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767817607; x=1768422407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qbEWbfzOEl2vvjRgaEvnNzAE5xfC7sw7G9ADxX19RZ8=;
 b=a4pUNXdrflHBLCT1Gudjv6Bc3lbxLaaw8qVDOmTzg6rd/O+VQ0n8YwvWAoSxgsL1ku
 jJZ1Dkj8CMEHuU+ym/lHeEGFeJRZHJBdRQuqXxlzbt/eGht9BzBmdvyuoxtc1j9SahTR
 Dtk0sNndkZ+WrPi5T8PTg4qeBv8/0b1lUdJEOukSF7RHxfaB9smIanAAsfeSGW9vF/u9
 lD0q/Q9IiMrO7lZ2yOjRmOnDjV/7GzArGDVkLsOYAvLddhMGy3QgeO1cEFm6K8W9E3K0
 /dJ6i3D/eYWX+i2VWEh2NHvzhI9JIv3qocdtLlZ9bilxNGnTMc6ZROwmOJF//Pouvvqs
 dyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767817607; x=1768422407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qbEWbfzOEl2vvjRgaEvnNzAE5xfC7sw7G9ADxX19RZ8=;
 b=Wb/XzoA8BwIkN6ZUkvt0k2HXJRpN7UnP9nzfeggvnfZOupxkEmWrVFXOFm1CncuUzp
 vuXhmJ1bkfRCDJ/3m1rH+qx4JLSKMt706+Qas+YSKd8XE7A6CuZ44aVVqTn551n1y+C0
 sv3ARsa3wEHNVUd70ZmaE0ki4NmSKzR5+YPE2Zpzo2rVuiE4Li0hfeJJ45oKLUcyPytV
 swhTZooP1lMk1Agt7rIYentgnhE/v2td6hPLSCqeGr6WaJ6wlPaQYIK7UOrQVIA8F1QP
 JD7XFuO2V2ePyPq5wGYedjBhaEFm8sCg5xhnkAxdemMCD8u4mb97ZQVp/KS1/QCzdklB
 0cvg==
X-Gm-Message-State: AOJu0YzfF9IX8oxyn+54woaubY5fOjwugAjNvVBZD2kg+NP3SQzZDS+V
 +Fkt6xLVu+WsghnmmsRa7npxR7sIGAA52EtFx95M4gTNnk+aqI3NlZOb14KmAwPAi+14Ywkcib/
 vAGksf6Y=
X-Gm-Gg: AY/fxX659yVWa2ICQjE5FWHxnxrZtYs2YtPVrO/MRV3DMMEO1ck1h8TVeUpWKgXYce8
 BiITxm3nPY4ovacIhGR25dwntdfl6IGgrzxiACj5Bi6aktm5IhX7wZfv1hC5iZ6TyMZb0kEfYmq
 KZK9Fr/g9CxekXq6JqCZW/NlmTBodFUUps4XgB5tFZG5kqTLn1wulf67R+oMcBvGDlFF0ex8qE5
 CnhtQoXC5DyHEt7QS2SdfXBnVG8Aj5gWe7j/1wRr6LSk9V0KbaSsKR2GXcyDnSeK4CnVuikoftD
 Uo50XJh5KxRjlXkP4ppw26RM+iPv3UO1vMqbv4dZ7bkZbx1pDSoNMEYkPU6DfrPXIJrc32fY/W6
 XuHWWPzqdRmRTMm2Jf16EmRJuA9SGD1eLiq8HIHRN4tkcPd3O4J3XW5FlxZsGtdJHh4YQiyqNY5
 EuJU9ERakN6jIGPX+kUbPDppLhFOmILedSo2SZqEU14GpxUKUDpyMowVUxVQWO
X-Google-Smtp-Source: AGHT+IEOEvJboRrOvHkNylrffZSrpcng2dYsG3R0PUUJEY0uhgDXVhnAMc7VwRy3w2xq6I2/xFJPog==
X-Received: by 2002:a05:600c:4fd2:b0:477:58:7cf4 with SMTP id
 5b1f17b1804b1-47d84b09145mr43311735e9.4.1767817607116; 
 Wed, 07 Jan 2026 12:26:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5dfa46sm12177841f8f.27.2026.01.07.12.26.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 12:26:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/7] hw/xtensa: Build hw models in common source set
Date: Wed,  7 Jan 2026 21:25:56 +0100
Message-ID: <20260107202556.55787-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107202556.55787-1-philmd@linaro.org>
References: <20260107202556.55787-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

These files are now free of target-specific symbols,
build them as common files (thus forbidding further
uses of such target-specific symbols).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xtensa/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/xtensa/meson.build b/hw/xtensa/meson.build
index 1d5835df4bf..fec22ef7d2f 100644
--- a/hw/xtensa/meson.build
+++ b/hw/xtensa/meson.build
@@ -8,4 +8,4 @@ xtensa_ss.add(when: 'CONFIG_XTENSA_SIM', if_true: files('sim.c'))
 xtensa_ss.add(when: 'CONFIG_XTENSA_VIRT', if_true: files('virt.c'))
 xtensa_ss.add(when: 'CONFIG_XTENSA_XTFPGA', if_true: files('xtfpga.c'))
 
-hw_arch += {'xtensa': xtensa_ss}
+hw_common_arch += {'xtensa': xtensa_ss}
-- 
2.52.0


