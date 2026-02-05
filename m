Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B359ECD9A6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 21:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo6sm-0003f8-V2; Thu, 05 Feb 2026 16:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo6sj-0003eZ-DE
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 16:27:21 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo6sh-00028a-5O
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 16:27:20 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42fbbc3df8fso1126479f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 13:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770326837; x=1770931637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XxNnZTCKp5g2WkUf5d7qDwOIEz00PYgDoHsNEpolEt0=;
 b=ZqjPCV+s6CVu7O4gf0f+kp1OARE6jT2rSfCGgd/d0kmApedspD2yJysbiUFAVcOeoF
 BCN7WIbFOwc2kHdsHspavZax9pit9fyEE6XRks1w69MQZ4Sy5EVi6hBcLSUEDIsufuzG
 c5aPP3bPLyUXUlEI1vXxzAlMCxz5xQUJtp2+MOGNzrJVNfyD3uQ5AS8QQY9Kjs2g9cUf
 V7DH/mvK8qO9TaMDaXxe7dXLuWf5o2qtzAxakuQQKaLpEgBzsaQ4DG/oAQubCQOWm1w2
 WewjvjKT5JPdZVjdES9+UIIIfVG1EqjM9BkYQKk7BbLO3/AiPr1FQkqnJEvQmoZG3RBS
 fZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770326837; x=1770931637;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XxNnZTCKp5g2WkUf5d7qDwOIEz00PYgDoHsNEpolEt0=;
 b=Su3l0tQzoea/uHcfwvnfNecIIjdcK7bTa/qrhh1QNMVTCrPqeZSVfEDB2GwA66sk9U
 pmVPx5XxWiYdM74BZfFfY84TXPaQZz/LNDhl4+iVedIp0vRsvmlzElfOlCs42gQK9rad
 wCRs+u2+WfZDeIvlgQTVelSUmVVZkXi97tjoGQqRXYP6Kr5DWf9Xg8FsOqGxXAnujBr4
 SLBw0f7LKTjFu57PeyW1NplKhRfHF+/GOGZgthJBPCeK5fvehXeTnhooX3zK/2Cd6S6r
 3UGBP2a174XrbJBZHpIyRFs18R1tElQHpxCSM11vUIe6DZQAwjQtpNumwfEFFLfVoMYh
 pJUA==
X-Gm-Message-State: AOJu0YzmnRcK2vQexcNRX6TsoNbSzwqqRF5hUabbFRbLLe2hlnXw/x4l
 oLPy+AQWbUuHOukVgcC9RR642AzfvA8tXHpvk17ODJWAtmgXCUZ0W3qWmtOCCubQi3lEoqJgfQa
 4w/aYMbE=
X-Gm-Gg: AZuq6aJ6MF7ByCE5k1QCIHPGHQ+z6kqgeMjOWtzWvZ1H+73LnSQstUvjT1opfanDSo7
 9W/ZtyV65T9v6C8a8f9PJS/ApGg8J8NxF9rHFThOCDoBj1xTDLBA/xNiLmgKkcGXHH8d0G91D3t
 ucMdXq14BJqN0VEwCWX5j+8YsKclYR6raHSlT+KSWLofEnQ6eIss96D4tL33ebY7wKgrATYVp/5
 jvEt7G51fkK1xXdd0jndbkdwQu04860sfOJYl8V6rNqMW5Fe61PafWagT3pPzdh3c7VX9AeAmMX
 WcCTc8LeF1BFj4HcQXamR0xPOwEMsm7+JsEqtcZkxzqELGlITtz+3tIF+YzFtW9/W6vrPzFZhHO
 bDcKip5IqAWpGVAr3/sD3h4kwrNXnoWB40wnB3Bl+emtYfw7slZnzyR38rrX37uDsV7gic3PloQ
 7TXHmkD/sL1SfnU5kam5r24eYKoVazchwLAQhXhFd5Xc97f8N5cO9OiIWAASvG
X-Received: by 2002:a5d:5f82:0:b0:435:94dc:8c78 with SMTP id
 ffacd0b85a97d-43629378331mr992196f8f.40.1770326836684; 
 Thu, 05 Feb 2026 13:27:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362972fa41sm913092f8f.23.2026.02.05.13.27.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Feb 2026 13:27:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/tcg: Expand tcg_global_mem_new() ->
 tcg_global_mem_new_i64()
Date: Thu,  5 Feb 2026 22:27:14 +0100
Message-ID: <20260205212714.10035-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

The s390x target is a 64-bit one, so tcg_global_mem_new()
expands to tcg_global_mem_new_i64(). Use the latter which
is more explicit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 4dabd49840f..203afe265bc 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -217,9 +217,9 @@ void s390x_translate_init(void)
 
     for (i = 0; i < 16; i++) {
         snprintf(cpu_reg_names[i], sizeof(cpu_reg_names[0]), "r%d", i);
-        regs[i] = tcg_global_mem_new(tcg_env,
-                                     offsetof(CPUS390XState, regs[i]),
-                                     cpu_reg_names[i]);
+        regs[i] = tcg_global_mem_new_i64(tcg_env,
+                                         offsetof(CPUS390XState, regs[i]),
+                                         cpu_reg_names[i]);
     }
 }
 
-- 
2.52.0


