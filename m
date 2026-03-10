Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34729EB1076
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzPn-0003gn-TT; Tue, 10 Mar 2026 11:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzzPO-0002x1-MY
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:54:15 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzzPM-0006ZV-Vm
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:54:10 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4853c3c2fe7so14686605e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 08:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773158046; x=1773762846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=US85J4JR3GJNPZ3oJTe2cSnkCs6VXwsD3WsU8xuipE8=;
 b=isy1/iGWDgf7M8V2EptuTpmQxarP6aar9n4rGGtZ0toaS2zScyT15YqXyG8cqPr4PM
 vpnbdcn/pmuBO8GMHANeZGNXHuT7G90fCnjAwWNI6C5Ip3dPc31dw+jRwxKj7aD+u6kb
 LcGlZVuficGendAG5c5tP3OY1LX4HpnJacd4hBejjUswJFdN1ecZ7/NnjWGHHg/vOCOW
 AvcZHm4SknK3s2HvxlgRFQzHmBD0b/mXwe79diQVRvZa9pFDqyskobhwl+g6MFSECNOh
 auM/owM+w4rFQQK57BG96Cw8qWygXXhVx+piAhwMr/YYiDXagbMwWDuEVTczwZbXjkRu
 wRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773158046; x=1773762846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=US85J4JR3GJNPZ3oJTe2cSnkCs6VXwsD3WsU8xuipE8=;
 b=IFppoL2Kc+h1PPsAEecrmk8YyES+Nikt1hs0JasLKB6YtsPngs7j+qYFonm83LUBaG
 SdTUsWjJl3u+WBIb/qG5W5GMqT6GddQagNyIQtRCoGeRsinwQI9WqkermMCs6f4cRxjY
 KlgQ2+jj/AJh5s86DTKbHMJV3Qk97aw25+mTx2cGLb/lUVamkOH3oFaRKNyRzTSI7YJE
 52hQdBZ0F2H6QisXHrWKNS/ioCIklpaatWnJf8z/PkyLEZ8ZeMfAk1BQF9yN6ktwE1tc
 k/4SIul5wbqn9H/njcc1jE5iHXVH/sYJxuEcHc0EfqfzfFSa1/AjmKQtTjzAkEomky9R
 HkFQ==
X-Gm-Message-State: AOJu0YxKFx/hibjpVfMOoVlAD0alFV7FS2okceI+Llk9/23abwFlvJ77
 VFsDZy0Nj7ifSxHg4CR5+ujIn2VQrrS63H/jJ5VXen84CSFz5yNTkG2Zrtr6wcp96XwgPPEmdmA
 t3tzHhkI=
X-Gm-Gg: ATEYQzwm62rRUcHdG8LNQVYBedkJMfTjKZAuKBosYdeY4OC5LZWpzk4sKwQD4v/WS+q
 shtDo6rzoR5mpUaUKZhv/nF15DVoKz1Lc8TKgrcKukcEGWkc68ntNBYi7N2jrsfrEJnbBbOhC37
 zCbzbkpQm3CHqShBKz9VfhTeuJj9tGxFAJzfzOlYWLf5GfM+cjxvpCqpa3OVBucglVaAcS+0ntA
 ieOAwVHQxWAJ060etMHl1PAPcFLtr3F42zZ5+oQ3ocXhgxY4DjMSJo0IQgeoRqIZWJQrdkFotp2
 Waf/ggdGuXDsj+bmSdDXNyetQ+AMY5ZNRTpoZhGorJlwSK3vfZnTV9cw/8SJrChXSGgYFMGfV/t
 lpmghJ8vAKkCIQnppbuCfF+XaslsiPby3FUWbWX4pLjoVkq0c6UTCWVdjYzB6TJlmqTA33y95l8
 XKHUT8fMQSl2rZPtox9aUh8IgPLTRSMNxHK3+8CtJMU10fnrP9XKAJD0yX039V739JN25NF75T
X-Received: by 2002:a05:600c:6387:b0:485:3983:aba8 with SMTP id
 5b1f17b1804b1-4853983ad1amr133011035e9.27.1773158046474; 
 Tue, 10 Mar 2026 08:54:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad97abasm33905707f8f.10.2026.03.10.08.54.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 08:54:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-ppc@nongnu.org
Subject: [PATCH v2 05/13] gdbstub: Have scripts/feature_to_c.py generate more
 verbose output
Date: Tue, 10 Mar 2026 16:53:21 +0100
Message-ID: <20260310155329.48772-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310155329.48772-1-philmd@linaro.org>
References: <20260310155329.48772-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


