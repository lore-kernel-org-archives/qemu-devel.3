Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F5FCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgZY-0008Ae-JB; Tue, 12 May 2026 02:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgZT-0007pO-ND
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:26:25 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgZP-0007ec-2B
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:26:22 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-44a74032ff8so3769175f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567175; x=1779171975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YEwsHCgWEkYua89nPUV5fuOYHoZwg1lrZGYXkIuVzmM=;
 b=aJmGM2pqKi1uHjxH9onuHmfYs/0Sc/JTwcWz5SxqTv94RGZhg/bOtoBChAYkYd+p4J
 kuTzMz01gUn/KAePvdxFqzQxwt1kq8VBk9tMdtS3B8CoP4oPge5bAzHmnQyHXLEgAN7r
 E8MHFMB88Lfg06ijFomzvdCsaZckTL18iZS7rWdzMz0S6GQnEM30hEardcaPN4AMad5S
 CcxGXFwBgQ+4ZcFSiIhnvzYrS1pAiGO5tl3VULKA+vPKVxl1OczPw5X2ym85iVLsUSnc
 +NT1hz+EUU1KIb3+4kbT9QV4bkeYi8Bo/ZA/E/IRWcArzh+SETJi+ipwx9+Jnrg2c5HR
 ee8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567175; x=1779171975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YEwsHCgWEkYua89nPUV5fuOYHoZwg1lrZGYXkIuVzmM=;
 b=IEXNiPwxYblkjYszKOv/h/2EKaGh6+ukKJctEunNWJaCL8IAr0tlFV1uVie46Pg/k/
 sPJa104pW/a0OfJDnbRhbpHcU4669QS9ijBmwT/ZNLtQqqDrSv7YatFKnbVzanHgKzbf
 fXsKKXI5VN6axG4iUBngOiW9hifVlPOSzTzd/XU1OS957sgxhO/r5fnNmUP+SKXkm1HK
 4emTBepzcuoJemF+OBclBjVqQ79AwgDiN4gzD92ZnN1B0aNVlb/R1RFCZudpXyJpUKnQ
 YuJZ540ZB35xfb896huPBwBHb11f8Ma2koBSkBwexzX1sRkwA5mUsw/LrKTuiMusKqFn
 9CIg==
X-Gm-Message-State: AOJu0Yw22GYoY31eIKUhQb31OlUo2f4tSjH3GWgjbmJVQyfQcsGvww5R
 OsK5OhXYujcnsY4MgO6jCo4oDtS0LH/x2IjQiU94z+nMlzuvQKtKx1LnYLWepCeaYQNz785KrRf
 Rrx1yjdE=
X-Gm-Gg: Acq92OEsspScNA2V3xu95xUyd9T+wYdFRvOILuhr0WvII/5t1Oxo2z+Esw0ssFr/FIW
 RqJr1SrtysFhnhh064B4OoTG+scAjsFcMUFXX62qkPrY+SvfMl2Ch87g35Rm8tUJJ3t1Q5VXkiJ
 5m5nY5Jk/i5vS9JwLy1BarvRotYLQ88sSi45HlY16ezwuF2yu/7t2/TGq0PcMNfJFWfQCoduEup
 0iQffaORhYOq30OfnY7RFcA+XFSKumlIeMOK28m/MY5PZsmkbj09ZFQsZc3mw1Zd/9lPZZ95Nco
 iiBopHMbKJNeXtDZ55/aJXLAdCOZbf4FLMEwuH/5PjsGMQEaQ/bOdEQKYLKSboZQAuetwEYRcKP
 o28Zj3gaUsmrXjRLiGYt686P3aDY+xoBQRr0K5Ao0w3Jp0URZrvP5jtK2X0XzRmYhEvEmdUm2YE
 qs58+MZ0HR+6f4UCv0qUOlDk9Q8gmozpYhW8ky7ielG4T9aYMLus1hmmvFAHzNzMHZ4mWjZucI
X-Received: by 2002:a05:6000:1a8f:b0:43b:9c73:2933 with SMTP id
 ffacd0b85a97d-4515b525503mr42182901f8f.15.1778567175292; 
 Mon, 11 May 2026 23:26:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e6a6a64sm31706729f8f.6.2026.05.11.23.26.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:26:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/41] =?UTF-8?q?MAINTAINERS:=20Add=20Doru=20Bl=C3=A2nzeanu?=
 =?UTF-8?q?=20as=20MSHV=20reviewer?=
Date: Tue, 12 May 2026 08:21:39 +0200
Message-ID: <20260512062142.67998-39-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Message-ID: <20260506102156.501805-1-magnuskulke@linux.microsoft.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 488d194a41e..e5d58d58646 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -596,6 +596,7 @@ F: docs/system/whpx.rst
 MSHV
 M: Magnus Kulke <magnuskulke@linux.microsoft.com>
 R: Wei Liu <wei.liu@kernel.org>
+R: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
 S: Supported
 F: accel/mshv/
 F: include/system/mshv.h
@@ -611,6 +612,7 @@ F: include/system/nitro-accel.h
 X86 MSHV CPUs
 M: Magnus Kulke <magnuskulke@linux.microsoft.com>
 R: Wei Liu <wei.liu@kernel.org>
+R: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
 S: Supported
 F: target/i386/mshv/
 
-- 
2.53.0


