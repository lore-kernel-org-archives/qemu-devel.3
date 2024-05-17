Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84387C25B79
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 15:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7z6q-00051a-9F; Fri, 17 May 2024 11:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7z6o-0004zq-RV
 for qemu-devel@nongnu.org; Fri, 17 May 2024 11:02:58 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7z6n-0005QV-8n
 for qemu-devel@nongnu.org; Fri, 17 May 2024 11:02:58 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a59e4136010so514879566b.3
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 08:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715958175; x=1716562975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZ4R0GpwuiTGFZYxz5B+fpMVNyC6MJRh/IKnd5gDIFo=;
 b=fEqAGDOJK1oItUQ4vhKuDvBvDFXISaGMwkUtHoUqXBih+NB0f56QPJqjcJbnXfXqf8
 iENDaUdQX5HmbT0dJVc+tDvELlCWyQWfdl6YM/TlC6Vcuf8FmrnhPR6sfaZNl7tuQMWR
 PZnu6jDnnWnd34Qzdt0Efrljz3eqCqNmCXqLKBxJsAtJoN53+GSx4FMAiXryxYtQEOEl
 ZymReNmfbuKfpQQuFWeL2d00zm9lCaJ6qOph0AkbRyojd3x+wKAaoxsV/ljFU09HSp8v
 xlkeVP/FrqXVO3mgQcelste2cYC2q4+/PjvfQznHOUoUz8+Bvt4GhYawXQ+BBBSGMFGR
 F+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715958175; x=1716562975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CZ4R0GpwuiTGFZYxz5B+fpMVNyC6MJRh/IKnd5gDIFo=;
 b=vNcIFvSlwneF2mU9YBwRhdRmaipNivuPL2W9o6vyqqw+TwOvvsrh8/t7aUnAky2Kxw
 wOU6AxNcbLShQgoqDL8zJRbCDVgvWewL6tEq049C8NX9u7XR7NkbJQ2KKJpuftGk9L3o
 QB2afaGmQfB9MBGw7g5nUsrKboJP1VNB0M7mek7wtIASGuzWNbwxM6DDIUVyCymh04jh
 ABz03fUp+pJQjN9k066jNZ81jEYaTWF/9tFZhbdPzUy2AhFu+Risp8A8iWoV2cygmi6K
 VOonY9IyRDVe+lxMzaGsqyNdcx9xKpob84msSYPOI85Vf65vvHTxZNva+DJcNoxb2Vj6
 1JsA==
X-Gm-Message-State: AOJu0YzED+PuuuscOy3UAGUEP2B3GSmez5cMLzbuHxRZXuJqEDPXcDwt
 fZYS9DTc0eEtZvx3TkJuwJbx8Sm7INv2IK4H4KsAub/MKjMZbIpv5u6kZ3GhkJAzOLEvNrxKnyf
 z
X-Google-Smtp-Source: AGHT+IEz6WJMxkjCXNa6qWDT45T1aglS3vG7MFpY3J0WFh4yiwBDHHaNg0UcXhG14MRFBX4EASYSGQ==
X-Received: by 2002:a17:906:15cd:b0:a59:c9ce:3386 with SMTP id
 a640c23a62f3a-a5a2d5cb0c1mr1344291466b.33.1715958175249; 
 Fri, 17 May 2024 08:02:55 -0700 (PDT)
Received: from localhost.localdomain ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b17555sm1120578666b.189.2024.05.17.08.02.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 May 2024 08:02:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/5] tests: Gently exit from GDB when tests complete
Date: Fri, 17 May 2024 17:02:27 +0200
Message-ID: <20240517150227.32205-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240517150227.32205-1-philmd@linaro.org>
References: <20240517150227.32205-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

GDB commit a207f6b3a38 ('Rewrite "python" command exception handling')
changed how exit() called from Python scripts loaded by GDB behave,
turning it into an exception instead of a generic error code that is
returned. This change caused several QEMU tests to crash with the
following exception:

Python Exception <class 'SystemExit'>: 0
Error occurred in Python: 0

This happens because in tests/guest-debug/test_gdbstub.py exit is
called after the tests have completed.

This commit fixes it by politely asking GDB to exit via gdb.execute,
passing the proper fail_count to be reported to 'make', instead of
abruptly calling exit() from the Python script.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240515173132.2462201-4-gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/guest-debug/test_gdbstub.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/guest-debug/test_gdbstub.py b/tests/guest-debug/test_gdbstub.py
index 7f71d34da1..46fbf98f0c 100644
--- a/tests/guest-debug/test_gdbstub.py
+++ b/tests/guest-debug/test_gdbstub.py
@@ -57,4 +57,4 @@ def main(test, expected_arch=None):
         pass
 
     print("All tests complete: {} failures".format(fail_count))
-    exit(fail_count)
+    gdb.execute(f"exit {fail_count}")
-- 
2.41.0


