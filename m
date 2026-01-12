Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAA8CF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQlT-0002VS-6d; Mon, 12 Jan 2026 17:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQlG-0002NH-Nc
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:51:47 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQlC-00036M-I4
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:51:45 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso49918905e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258296; x=1768863096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xrLE8QcUI0TfOD8kuprrL3VRGu8CPhar7FsisvjUxR0=;
 b=UidNGTWw+gFh/Vizj4K8Mg/4PODdGu/2OvNMN68nxlcwWArLXl74pQ084/pnbIqMb4
 4+MChpDnFCFx0zoqUFq0vTJxj5qVcGtJn88k3aRxaDPxiRcmKPi175tlUZlUt0oo/D+x
 pOaYnN5pIGTT5XiSZxNFGryL/q8UIWFsFk9dQR2mY3ksT8Okn4PPaq75Ry+ANRfD9P1+
 EWdHsalnNQ9iwNPzUzTQNMrwP9PNUkkSX+l/AxcGu5gnndJETsvbqlThUy9eMWG0DhUr
 V8LSCwizkiY6rRxQrk8KxLYvMPEb/2knFD8VUdCDTJ2mS+tzYdjp+sA5Bz2DMnkfx1U3
 pRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258296; x=1768863096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xrLE8QcUI0TfOD8kuprrL3VRGu8CPhar7FsisvjUxR0=;
 b=k6ys8phkQOcOewRQaYmDQUVPwImZgolMkGIbQX7CVyoa6YmXrKwawLwepFfhnWFcxP
 XtVNqhr1wBpfwUekbhIM7G0RHZBjg7hklAePsC1gwknn7Z1z3qG63pqU7eMfY4KsORfm
 czM0MbUVCI04IWb3KrGF3jxpAggZcSqMwlZ4fazSP2Gj8XSZhXwQK4fm7rBcOMDAufTg
 zDAYsFmTlfb9WP9JaYijhmmI7NasZGpbsXU6i/p35h/td6wEjT5MJPsnN0emR6uaoIAc
 i+5Hod2T03dP31bz0jH/KA+Sb2DTMFE+YEsiE5iBj2FF7UYpWI6LjMkQOCOjWGAw16lJ
 0DTg==
X-Gm-Message-State: AOJu0YzhxEn3LxwdgCIZgBKWR9dwv6XbyU5LI2sduEx/TsW7jfHABjxY
 fnysz2tVVk3LeWE1eArFmeUQWrRACxfLeOiMjkpU7A82xE2cBRoGFmiuTuGYFXUslwEDjr5WXxF
 kQ5aLYGk=
X-Gm-Gg: AY/fxX7Sgeqco879Kuc+/7RrJQJ7qZYCVMpXorJeuASrXCA3qTsLzv3sh/UqZ7wo2Pl
 WIdMXjGuQpAoVhLf9gamrVQgaCPqjM+uqrOLnhUIOnfkH3FkWn8vEWfmD7hEsKOsAq5VevUiFix
 WRM1MJD82TzNHz/CFGyWaEySXseVIM8C2W3kdCPiQB3xwbLHqyPeZqlStcM4YQ++Oa7aLekbESo
 gavP7Y/oxwMkofswDUkkwiihjQpNhl3/kdZrNALO0kCaNQSX84waDnjBT4F2wvLRQUNIdWgJhHW
 F3fTdftelLIGf7ZtXjY8RibEG4n5VWtbt2kY2kkfaEDbZwjVqyQb1VFQzFLU37w/Hdl4hXGk5Ur
 D998RCSKoPb0HyCZdrEdOlEZM2lj4yr+nKccBGpv0lJPZNvuHhJQQjIC9mzupNOioVe5ogzXPST
 UJm8wv3soZ4hhP5Qvtu2UQLj0bcYM0uSBpNA9XigTfrgXVAD3Aaydqr/bCWbfj
X-Google-Smtp-Source: AGHT+IHVIWCYj8UiDmq/ra5GqPCaAXCUd2kM5ztNQOn7AYxQ7hX30sxkYoPHWiACYTWB0qIFsMXGUA==
X-Received: by 2002:a05:600c:1391:b0:477:a219:cdc3 with SMTP id
 5b1f17b1804b1-47ed7cccaa3mr11717055e9.12.1768258296476; 
 Mon, 12 Jan 2026 14:51:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f41f5e0sm367757375e9.8.2026.01.12.14.51.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:51:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/61] target/hppa: Avoid target-specific migration headers in
 machine.c
Date: Mon, 12 Jan 2026 23:48:18 +0100
Message-ID: <20260112224857.42068-24-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
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

machine.c doesn't use any target-specific macro defined by
the "migration/cpu.h" header. Use the minimum header required:
"migration/qemu-file-types.h" and "migration/vmstate.h", which
are not target-specific.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260107200702.54582-8-philmd@linaro.org>
---
 target/hppa/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index 13e555151a6..6a143cf8df2 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -19,7 +19,8 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "migration/cpu.h"
+#include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
 
 
 static int get_psw(QEMUFile *f, void *opaque, size_t size,
-- 
2.52.0


