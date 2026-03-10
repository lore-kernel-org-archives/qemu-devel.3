Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8ABBFD88CD
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 23:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w06Of-0000yQ-MS; Tue, 10 Mar 2026 19:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06Oa-0000y6-1m
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:21:48 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06OW-0008K2-UN
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:21:46 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439c944bb62so4992191f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 16:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773184903; x=1773789703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bj/hjGdaTcwc0CniLQTv7gtXBbi9cqQXsRRG3awcJ4o=;
 b=nC8ue+LS18pqrybSDYT5WrGUvmP9HsrBv4X2F/jCaYVMDmxLHzHC+U6UkcMYit2hcR
 cARLim0LrAhpLmnFBykzWFKNgdO/iQpgvlty2MfwKw4lXwZeT35QQnmjhkl6zVrZaISM
 sPqP2+gX/ADeiuppExaP8UIeeiRQGxEZ+z/rP+ASAolzq6eZgPA5OwmIhf71skag8RHU
 6siW/QtFonh/EXYNm94W2fsIoi3pWRRwc4iEtAsrXVfvfD4JVW59ENTd8Bl4/P4f9BNI
 8EaSX1UN10trJvl5MnBYTFiIIfB9WmV+YiQOaPfDlJzG8vw9JXC5Dc3WTzxhC3yXmDwT
 QdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773184903; x=1773789703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bj/hjGdaTcwc0CniLQTv7gtXBbi9cqQXsRRG3awcJ4o=;
 b=LgTxCMEm2vzxZEHYnk+7U53RzkdimGmcv9QVsryQrhSw7yrrDjgBqCWmDYI2qxs4dS
 E25Jx4LvlfTRy1KupZAn+yFAk+I2gT+8rkpsADzFngdj0ESA6rV6Qnd8uIMp84M+YWmM
 o4HGc2BOdWGn3qn0VK8lrCq0A3gam0LO5q3w2FHBOyth0ZCOqYRLhQ8jEsQIIZipz7SP
 +KoIj2AvsAJ5wOzmguuky2T2khP0iwoilkSMjgaz6lB8BcQs9tMzTrz55vMEmOEIR99n
 iHZhh2sTy6gNz+rVPBqJYFE5sXgZ7iysfanmC/uUNutNgD4Zl7I4GThqoUhOYpRedB8S
 0OQg==
X-Gm-Message-State: AOJu0YwAHw20L4mkJ9RzK51kUXUFzKTpDkrs84R6qtY5BWzobspT9M2b
 wjSLB0QGoGc153FFLu2wNKmRUzBKgztBAfvEObHGLoKcMzX4Wq3d5dMMzrIx+XYBuWf6kKGjRke
 bPDQqCMo=
X-Gm-Gg: ATEYQzwgoq6inW9nFdL1nB2C/2h/PSpWals4mAxlKc68ULYkas3LrDqhvHytQc7LPLN
 /A991YjFaPWPlObkZN9kZMnHDY30u1hjBMR9pZD8agt1XM32VyUemvksDGvxW2QAlK0mQyQWBVh
 I3YvQS8rq05rQIlrY54GIcJ5hfXbv3zH1qk2gvy1dQvKq3leRV05xOuJlw3J6+znCrNFR90/Yti
 4lly84Y1CKBxl9BzSjFphMdtgG1Rf5VVd8gJxATLREsk14+yHOFXoj6/u1dGMHb+fjhBeJA4hYu
 KLRlMUEhJ+yrvpgMPNgfPDAk2ZFH6AXNXR6byFqkmq9sykh6bSmZ3hXpEtBdpW6k9FXMt2YHy+K
 te8eepAe2V0iteKQ6JXBzy8pWBNos5whK5QaBgrpgoaossjQHOzdXSg0VGHxfzu6k57HuXJtHy6
 7VDgwm1bu763bZkYi1qQ/uid2mkAFG4Pfkk/vCMbhz1tZ+bTEdu4sTueNI0Img5YVYBmlvj1rQ
X-Received: by 2002:a05:6000:24c4:b0:439:b3ff:9abb with SMTP id
 ffacd0b85a97d-439f8224fc0mr1135355f8f.57.1773184903093; 
 Tue, 10 Mar 2026 16:21:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f818d4c8sm1941947f8f.7.2026.03.10.16.21.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 16:21:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v4 08/16] gdbstub: Have scripts/feature_to_c.py generate more
 verbose output
Date: Wed, 11 Mar 2026 00:20:36 +0100
Message-ID: <20260310232045.58440-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310232045.58440-1-philmd@linaro.org>
References: <20260310232045.58440-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Make the structure field names explicit, so it is easier
to figure what is what when reviewing multiple entries.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 scripts/feature_to_c.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/scripts/feature_to_c.py b/scripts/feature_to_c.py
index 3aa62fb895f..1329695ad04 100644
--- a/scripts/feature_to_c.py
+++ b/scripts/feature_to_c.py
@@ -85,13 +85,16 @@ def writeliteral(indent, bytes):
     num_regs = max(regnums) - base_reg + 1 if len(regnums) else 0
 
     sys.stdout.write('    {\n')
-    writeliteral(8, bytes(os.path.basename(input), 'utf-8'))
+    sys.stdout.write('        .xmlname = ')
+    writeliteral(0, bytes(os.path.basename(input), 'utf-8'))
     sys.stdout.write(',\n')
-    writeliteral(8, read)
+    sys.stdout.write('        .xml = \n')
+    writeliteral(12, read)
     sys.stdout.write(',\n')
-    writeliteral(8, bytes(feature_name, 'utf-8'))
+    sys.stdout.write('        .name = ')
+    writeliteral(0, bytes(feature_name, 'utf-8'))
     sys.stdout.write(',\n')
-    sys.stdout.write(f'        (const char * const [{num_regs}]) {{\n')
+    sys.stdout.write(f'        .regs = (const char * const [{num_regs}]) {{\n')
 
     for index, regname in enumerate(regnames):
         sys.stdout.write(f'            [{regnums[index] - base_reg}] =\n')
@@ -99,7 +102,7 @@ def writeliteral(indent, bytes):
         sys.stdout.write(',\n')
 
     sys.stdout.write( '        },\n')
-    sys.stdout.write(f'        {num_regs},\n')
+    sys.stdout.write(f'        .num_regs = {num_regs},\n')
     sys.stdout.write( '    },\n')
 
 sys.stdout.write('    { NULL }\n};\n')
-- 
2.53.0


