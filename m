Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20645E83837
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 21:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs6NZ-0002Iy-7j; Mon, 16 Feb 2026 16:43:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs6NY-0002HU-2z
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:43:40 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs6NV-0008BK-MQ
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:43:39 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4377174e1ebso2690468f8f.3
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 13:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771278214; x=1771883014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OTDC+IzXTddfFCPQNzAsj0ZHhDkOeqcFAGhe17LmNSQ=;
 b=AB3cIwo1JRH7sc0i5m33ixyMm0R1fK2hNTmC4H6Xk35C2x3OzfmvssqYw3fN3hEpQs
 gmlRk9FV+dMnAlShquBE6OoHxmA4tqmw2veazFLnm7noSu65h+F62vyDvbIPip5/34a4
 dK1IeEv+r8rBoDgOYsx/AkwnPd2mj3lnUWhvzezoRgsxwF36K8xE2G0elTUpPN4YagdZ
 uWm9bNIHE9TYc6IwcJUEerZrQdlC/tfqr8+uiYnggDhk2cu/3Wzwc/b9eq5TBoYYubwG
 3XddFoIUF6QMt64qrogXZtowSn4XfXBNt6qDpXKf4mOZOyeK0KiR9mirhoNFS9ZGlkDk
 HKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771278214; x=1771883014;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OTDC+IzXTddfFCPQNzAsj0ZHhDkOeqcFAGhe17LmNSQ=;
 b=Rz+g5kOPLs91SHptPLlvcGoPkiL/EGWFc6fGtk4ZyWkQFBm9aiDp7EBChHsj3hUcmq
 gNiQ2mKsSIOCRjetbkjlJUjluQWdGDm3SStzVoot0WWvrtWjwOW3ZLSz2bUZ9XFQp9zF
 y0jRwuUPJWNar0ilbQGoZVfdlaH4Y9s63lkWKiJJ2xlIbx6d7ER5XmK+PBHC1kLWgFRY
 xEkFzYJ0Xl625VC8P5bLuiQHn1eDher9wniXYvKn13ETkwHcyz6JHpw7cZQtPymcxIbw
 I2/dKkUiCqQzriNr4snh/hoZdWdJZi1kViSifXOQa/Ske4j+kVb9VVm59Mk8ta2dvF8k
 iBaw==
X-Gm-Message-State: AOJu0Yzuy/C5PAJiC9sS1/M/J7xvmB4xDVTUcw2091CthPV2GFjafmmQ
 1dioJ6QgkprwC1HYaQAsnI6U0iNbHYblJiynyo8n31HGv/NnUpSXZcoGPPweIWpuLIQIevOJIGZ
 Dvaj9qHU=
X-Gm-Gg: AZuq6aLPPb3i2/nmhxb6AUs1pD/9NSlKjFITpOapboBTXOeESlWcTStseFZX3c7BjYI
 HIpgSSK22RpwbK1PsH9+wf1MUY9GIiGxEldpASi+p0p2xEhrvDc6a0bP2eEW8MELexKRSeH6yT9
 D08Cq84loimFLCxCd+Snk8HAs0AY/kbPMStMLRX6Nj0ijx3HZhTCSwXdjFOCCW5ww0W+I4t8h/Q
 aEuGVWBT5KmE2aruG4WdQWGIMGoaStpmcodVzMn5YAi+KWePkmH1P+3AH4mQteyeUxuRmNqUD7Y
 5ykGNCdaOHOQs8f4D1zu6hSQfUSizfPLkW6ldLKlcwquGOiNtX2FYhoqplj4JTw89rb8+doLmhl
 cHFE/ROyhK2fBADv4PJD1jxDnQkGI/HTeYmb0hTimSwI/WbNmks+5JU3R6trN7T66joa9MWzey+
 Pxj2XAdf/0NHh7wftC2tDqr3878umC9z5DSanj5pKhB9HSTQiPNrNvtK5MRF0wpHfYZm6R+vJU
X-Received: by 2002:a5d:5f54:0:b0:437:70d3:44e7 with SMTP id
 ffacd0b85a97d-4379790e686mr19766136f8f.30.1771278214178; 
 Mon, 16 Feb 2026 13:43:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac7d91sm30112811f8f.26.2026.02.16.13.43.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Feb 2026 13:43:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 John Snow <jsnow@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] gdbstub: Make generated compound literal array size explicit
Date: Mon, 16 Feb 2026 22:43:32 +0100
Message-ID: <20260216214332.47639-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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


