Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2604AFD45FC
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO7i-0008Fx-Bu; Wed, 25 Feb 2026 18:16:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO6u-0007Fe-T6
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:16:05 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO6t-0002pe-Ex
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:16:04 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso2325285e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061362; x=1772666162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0wTslWdGU4/52F0F1RtcG+lh5cc+cLUvd+EC0K3UAbY=;
 b=ApZAX6dpGTw6Ky2HqkXI6Z46aZKaCBCcA/G7EIIbcPW1yTtZa5W5hq4rlCBTEtx2IK
 ZJ5hEIVurLKoyaE4rgdlO28tpiHBVahYyYS1uS7QM2xpFTuMLjquH1NALHBvxo0XV30j
 rYCLNCUiYL3hrISi/mutslUfo4R6+OszlSB4CkFx98RF68K6lMakr7hw8sARyAt44K1x
 oVosNny+KWFGAmSsPs/N3PO+lFtYh5fE/MQOtEWUHy7K4xW5gwQlaHTqdY1ZhayzFHtV
 6vbdwGvWghiLX34OQB6dUCeVuLobOYxg/5pxP0tnKI8IXMfVPvfZ41j9ZrqiWnEQtKN5
 krOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061362; x=1772666162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0wTslWdGU4/52F0F1RtcG+lh5cc+cLUvd+EC0K3UAbY=;
 b=Q5tRbmTwWYjr+PpWozSmMy4qnNbmpKcCn0oS0oFXo4RW4rXqnCvU8mP3GKKAdLKFP2
 h5DH/K0wY5unvLO0sxg9qtv/gtSEPlnWB5DLpihOJ7ydJB4H8tYMplNuO4+goPoHF78N
 lawS1iP3zcPP0n9Qg9NSGmt3tEcC/0JxbTXF0IBQmtPPFdJ055S57CCpNRSr4FaxSacU
 96tspAsPYRZ4WmrepxA6koiq3uoSFRUD1OaG5jfty/NFbUgdb3s0yS6mHY9cn+B+yv4v
 VivlX3SIHf6hMKcVkkEQZ3VA3y2s+U0X1pDOq+7YgxUqZkOyDRM0Jncsb3otD1Ur6BzH
 9xwQ==
X-Gm-Message-State: AOJu0YzuVZPx1WyHRsGpUj3dtcEdzWqbZO3kkhkFbZX6fqjnG6PakZE7
 pBMfv3fJFKGpW+Pxk1RIwhzj2qeD89NaXj/yIbK2wkgc4wlz90TDJ+HtqZ9PUd37AoAy3SCp4cc
 tg8yOcA0=
X-Gm-Gg: ATEYQzzK5Kyd2jtg7KwmiMx7gt/V+2m6HjJ4XXaZWW8k3BwYQDponLkW+QI41Tn0Kd+
 zTeayZQzi4rsKX5C1UG32zpIwDutxC6uDl8KShGI5nG+Eq2S2XpwyeFvvo6f41jwiRAJscRijPT
 Ws+Nme5tP+cKZG3csJDnI3sW678Um5ra/Mf20w4JrvmKMG6xq/5NSGvaxxcBmbMj3+ZsbINlAdp
 W6Yd7E3hpIXnT8Nn6gqD+ga8qCQpnG8ldf5I7uI8wsIwUNVzolxGLgOkCChLAwwxwKIbF/Tt1BL
 anv14BobuovDkKIwJDfaTRRaQs7qzNH3R0g8ZyBVZM+WLeRwZHcbY6b6Nrzt/NVzekk64hYsJrm
 tuhdcG6WCNs5wo2LiGo29cmnlS+atpQuuD0HBN1/LjmXWzhoWDEvoiJKbNQTpEfHaZYfintSsMD
 woybz43Fm4FHq5t8QYPKdeK5Net0IntL+UunNZRUBNgXwFjPHOJJTuCIZeT87vo88oOHQsnYM5Y
 4536StlD3c=
X-Received: by 2002:a05:600c:6815:b0:483:7783:537b with SMTP id
 5b1f17b1804b1-483c21a54d7mr40631515e9.24.1772061361560; 
 Wed, 25 Feb 2026 15:16:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43992ced321sm4927538f8f.35.2026.02.25.15.16.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:16:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/70] gdbstub: Make generated compound literal array size
 explicit
Date: Thu, 26 Feb 2026 00:13:16 +0100
Message-ID: <20260225231411.96482-17-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

GDBFeature::num_regs holds the number of registers, but when using
the compound literal construction, if the last array entry is not
set, the array will be shorter. Prevent array overrun by making the
array length explicit,

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-Id: <20260216214332.47639-1-philmd@linaro.org>
---
 scripts/feature_to_c.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/feature_to_c.py b/scripts/feature_to_c.py
index 807af0e685c..3aa62fb895f 100644
--- a/scripts/feature_to_c.py
+++ b/scripts/feature_to_c.py
@@ -90,13 +90,16 @@ def writeliteral(indent, bytes):
     writeliteral(8, read)
     sys.stdout.write(',\n')
     writeliteral(8, bytes(feature_name, 'utf-8'))
-    sys.stdout.write(',\n        (const char * const []) {\n')
+    sys.stdout.write(',\n')
+    sys.stdout.write(f'        (const char * const [{num_regs}]) {{\n')
 
     for index, regname in enumerate(regnames):
         sys.stdout.write(f'            [{regnums[index] - base_reg}] =\n')
         writeliteral(16, bytes(regname, 'utf-8'))
         sys.stdout.write(',\n')
 
-    sys.stdout.write(f'        }},\n        {num_regs},\n    }},\n')
+    sys.stdout.write( '        },\n')
+    sys.stdout.write(f'        {num_regs},\n')
+    sys.stdout.write( '    },\n')
 
 sys.stdout.write('    { NULL }\n};\n')
-- 
2.52.0


