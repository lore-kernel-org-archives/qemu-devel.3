Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D06D10366
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 21:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO0tj-0001WU-4D; Tue, 25 Nov 2025 16:48:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0tV-0001QK-My
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:48:23 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0tU-0005CS-4E
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:48:17 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-429c48e05aeso128610f8f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 13:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764107294; x=1764712094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0m+k2UyUztzmcb8I6pH4YXiVmZQfT+gR4LS5nZYwQho=;
 b=vyR3oRPE0W4AE8SfMECR3A4Qx2pB+beXuJa2eW0idKPVkLt7FIvBwNki1K53cv3nCR
 90OE8nTn5E+cIhHgXE2di7NJlUVo1hNRC/yVonSMkNBfh2TRwiQv4tMqtjzsXMwIqMbd
 7eoxq+jG1YZcLqUZsZgzlFhKbf4OJ8dxae+EtXZw0Jt+fgF56+yzNjLsrRp1PBvzix+p
 3qSy6KgK0TdQvAztgSwBe5w7VWFdnh0JkhrRs+DbE0PGP513RVusWuucheeVBHZ1XDZo
 N5Z0lfd1zVtEY5kovcDoGwMoEobe4kSNVN/k1qbap5DVe0rl8Dc2cli61sMn3J5dTBrc
 7D1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764107294; x=1764712094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0m+k2UyUztzmcb8I6pH4YXiVmZQfT+gR4LS5nZYwQho=;
 b=DBRZj2aba7v2BeTVWirV5+SgV0A3dnnyArhcn999s1lK+AURaaYH9nfakINRmc2cvT
 4RkT9O5SBdLL8PWunWizgvXrAo5N7+riSPmY74zVGX/e5uvyh5vfLDpNyHsaDqWCfkTt
 pZeb8ul/jo4r2lgnxcKJ4c9VAStzZNX1Kaana9wy92FnhZhH3noNnYYAZZb3Snhdh5Yu
 a8qxOCDgNxjtRVdQjCEfm7PDs5R5AO2pO/iAUO3NrLtqcPTX3rJ/xjLLOzoT+UF1QEjm
 vf6OLXNSPl1vmx6zMnL3qb2ZQsUm9U9dguMSY0Bu4oiMRK1MyZ6Gr4azfPkve8ICSyXx
 lRag==
X-Gm-Message-State: AOJu0YzGUXC7siVI2kYE81inE3a/04WMnEzNq06y+ScO+3JPNpDkCTe1
 Rn6iMaHoamaVznNuD0qJiJRaJe8LvlP48/0zoAgApHJUPo9I3nwft92VJE3yWXB7Jcqt7jeznM7
 7+OEvtAwIkQ==
X-Gm-Gg: ASbGncu+98LvzcGJbQy/83HnfN6E2Lw9Rv9MG0qxiR5P3lVfRUFI+bkDN5qikF/pECi
 n4KaG5abxvckrb1DkWYlVaWwk4XyCfmxoJqEqjuUbXJNIq2W9sWT1RzbcSvFNQ36irPdLX46xro
 pOCMyWzKnoD2L/arcYiwDrnoi7oID7xPLl3kPjQ97JC/fiMsax1+L5+zJMF4ZktfCdLyzNoKOos
 0eEZI+FdfUwr12Nm+bu8zH+F0vI2lKyUgo0BE/oVkFPIQdDAnS8CReiHLCtvNuoFIKuo0p6TpmE
 cmUE2ArrfOjr2RFTBj81PuDVXAW/gE82/CxOOSl3bXp3a1rvCwden+xEuxGkfZI7Xarv9k/vGEK
 UQWw/7UvS57St7YCpA7AWkBeCjacsxsndjYXnld9BWEoX3Z2uLkQ6OAM7tWbPFD146v3t4l3ma0
 lffpPyTmoSr/fg1GE8e8Wy/F5tPdcG1Mzi0GV+Rdm2I33PqFdVlcb5ExRBRdpg
X-Google-Smtp-Source: AGHT+IEG7a34iYTcnYTKnB2EeWKdfViP10xcsFGjFIFNuYI9ddq01JQajN40YNIBZkoT7wCcjihTjQ==
X-Received: by 2002:a05:6000:1a8a:b0:42b:47ef:1d59 with SMTP id
 ffacd0b85a97d-42cba63b5b2mr24795015f8f.4.1764107293971; 
 Tue, 25 Nov 2025 13:48:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa3a76sm36678238f8f.24.2025.11.25.13.48.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Nov 2025 13:48:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/9] qtest: Allow and ignore blank lines in input
Date: Tue, 25 Nov 2025 22:47:53 +0100
Message-ID: <20251125214802.1929-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125214802.1929-1-philmd@linaro.org>
References: <20251125214802.1929-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Currently the code that reads the qtest protocol commands insists
that every input line has a command.  If it receives a line with
nothing but whitespace it will trip an assertion in
qtest_process_command().

This is a little awkward for the case where we are feeding qtest a
set of bug-reproduction commands via standard input or a file,
because it means you need to be careful not to leave a blank line at
the start or the end when cutting and pasting the command sequence
from a bug report.

Change the code to allow and ignore blank lines in the input.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20251106151959.1088095-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/qtest.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/system/qtest.c b/system/qtest.c
index cbeb7f37728..67e2385f4b0 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -69,6 +69,9 @@ static void *qtest_server_send_opaque;
  * so clients should always handle many async messages before the response
  * comes in.
  *
+ * Extra ASCII space characters in command inputs are permitted and ignored.
+ * Lines containing only spaces are permitted and ignored.
+ *
  * Valid requests
  * ^^^^^^^^^^^^^^
  *
@@ -367,7 +370,11 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
         fprintf(qtest_log_fp, "\n");
     }
 
-    g_assert(command);
+    if (!command) {
+        /* Input line was blank: ignore it */
+        return;
+    }
+
     if (strcmp(words[0], "irq_intercept_out") == 0
         || strcmp(words[0], "irq_intercept_in") == 0) {
         DeviceState *dev;
-- 
2.51.0


