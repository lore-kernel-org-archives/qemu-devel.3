Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0691DE7FDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 23:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn3cu-0005d8-9i; Mon, 02 Feb 2026 18:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn3ck-0005cd-Cb
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 18:46:31 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn3ci-0004zb-Rs
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 18:46:30 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48068127f00so42798355e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 15:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770075987; x=1770680787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EkaMhVjkThnUV33nCiP7UTlNSfm4cnSYMI9T3hosd9A=;
 b=Zmr3zVeubMf7zMKVyDdT71IuQvuymKiOrBc7qLevDD5yN1/dmhMdhdfkvJQslb+xoP
 YEEn87JgXReiHzfXHkBUYR1JWtSzc4kp1NZ1evVfHIgd9Q61waMX1BI5Sr6hn1eNS0Wl
 SeT2+zcZ8vd/N3jgWyREK4EdaMKXXC1i/vq4jk14ff4X1UkjN6P0z6TLeWktpJpflzhG
 8lX8B80iexR8905Y1ECzLg4ryWhS4HCNM+YiywSbNrLWHPXK821t44OQOQ9DbAXGdYWK
 Ro5kOH6xGfo8IXArMN28j7gOhf/pQMPWqyLhOE2Eyr4CSVv5hjnjVIe7TY11Y1VyebPn
 8cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770075987; x=1770680787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EkaMhVjkThnUV33nCiP7UTlNSfm4cnSYMI9T3hosd9A=;
 b=V/aWM0dZKZwMFgkjWHVGzGR+y5oSlc1e0tsnduLgfiByGgeMgoW766jAh9VYel3IQ7
 eZLuZ+GWQFFuV+gWLPQGiFZoptImCKUd36QYuo2NkKi3HmtU7KYHRYWDRjZNTv6QigNL
 /oS8UOxoG8++xOklm7hCUZfm3LoJDXiFuNMRqgjoybq0gijKze7l84bd8I+0ogT4U+r1
 WG2BJmbKA1xr60n0IcYSW7EBPhbCxUa9Li1Q5TJGTXuvah/ax7IsS28MHmIo6SOsNBco
 GSwdcqEGFvlHL//3vNtEPHxYFSknDPKO5EU/pTxSAkJDAPq1zjTvrR+IdPSlWsifKgqt
 IqCQ==
X-Gm-Message-State: AOJu0Yz0xjt6EK7jQAbXQgIUjLvsYb80yTHeL4NDW/n0Wzj9+nD/x2y4
 RVeLGbuPtvdnOVePTVCCKyYWFNmukG/CzNyitZdiI0fNeP9M1g4OvMPQIkVmMhLhqi199cCdFpQ
 /HLX9MlE=
X-Gm-Gg: AZuq6aKufnHnSR3oB3YoJb/N77in6OsHujfEBvzN9N37OO+PBbi1YN0HNZ7O3pAFtNz
 YF+rDby53DopVoexColaDCbQ3W5ZrkgGoG3ZRbS1NcfZ1Oypk2Lt+JCRHXsdx1Ka735Mq8J+tVy
 g2iQeE0LGfJ0xIifFEublIRNotAwt5UQH97SBhaVqc+E2G8yH8o8CrBMCxa3EIaOPDqDUtixsMP
 2vHJEH9ISkHvyImHUjbW737StutYoIQcKSAHfU7IJBJbPoavnRt11igABUqh8xo+5LJxOL5/GjW
 nYXHuvmqjNeqEg86tyDxo5Cr1DeXsMxJWSp4fQu5QU5N3cD/273Ed9FHHg/O7+G0NGWOJkNosFo
 d0nURHgj79ogM3VYgE8Fs682Zigk8GlFmwGLkxU2sw+xwJ/Q6UWzIEvacLpzbTYFXpok4ZCejec
 G6NgXLhTQyDaSZQRj3pIJj1MLojt9KCjce/3o6YP3WcaQWsLVXexmLVMxst7AH
X-Received: by 2002:a05:600c:6814:b0:480:699c:abe9 with SMTP id
 5b1f17b1804b1-482db4b21c6mr146819395e9.37.1770075987163; 
 Mon, 02 Feb 2026 15:46:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483002955dbsm25456085e9.5.2026.02.02.15.46.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 15:46:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/7] target/alpha: Do not use target_ulong for page table
 entries / indexes
Date: Tue,  3 Feb 2026 00:45:47 +0100
Message-ID: <20260202234550.34156-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202234550.34156-1-philmd@linaro.org>
References: <20260202234550.34156-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

%L[123]pte are loaded calling ldq_le_phys() which returns
a uint64_t. %pt is loaded with @ptbr, declared as uint64_t
in target/alpha/cpu.h:

  236    uint64_t ptbr;

%index is at most 1024 so can fit in uint16_t.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 2dc52cc4465..d6200d101cc 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -173,8 +173,9 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
     CPUState *cs = env_cpu(env);
     target_long saddr = addr;
     target_ulong phys = 0;
-    target_ulong L1pte, L2pte, L3pte;
-    target_ulong pt, index;
+    uint64_t L1pte, L2pte, L3pte;
+    uint64_t pt;
+    uint16_t index;
     int prot = 0;
     int ret = MM_K_ACV;
     MemTxResult txres;
-- 
2.52.0


