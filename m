Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B538C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJlv-0008FQ-63; Sun, 26 May 2024 15:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJls-0008E2-BE
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:08 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlp-0007eO-KT
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:07 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f4a52b94c3so621985ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752583; x=1717357383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gi/s2+2cD+V3SrsXlMXx3XfT3mv0KBqmrRsXrf+YVAk=;
 b=w4qoWTPfrWV3vuA+XhXDxXV8LMlMbfkPUd/lTpEVs5UOBfmPpHYAoSeqnxIm5Yu00j
 JyFzjpfnllauSh+joVth0Gbi0VXp5oQZLhQBezC7Mh1Rd+DDRBEA1DySeC9vQe5Gs+ZG
 QEyJb8rs8C78zHTpxR+wC7IrH8z8aqWDrXLh+xWgB8AxgfmS4iVIhZ6m6kZV6mDc8bTa
 bkEnJVlo98JtmZRXxjLPeEUUsxHEFYR6ppShiNXEKNVeEVTCW5RHDcmpL1ghnPnNqSG5
 8wGfQOCmW9pgbinPf2KGIOjgZpKlPsoSQMh6oPc5RVLv956Wi50LGxrZpPzWgY9MM6d2
 xrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752583; x=1717357383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gi/s2+2cD+V3SrsXlMXx3XfT3mv0KBqmrRsXrf+YVAk=;
 b=HT8ukhCqgxXfXThDswgRlyVDMYJByo9mp0qTHlXqALtt7WMxiMJJ+Oyr5BY415zD42
 dDNqG2VTYQeUdyEpT5s0Gw+s9ZS9vJ6eqojlkgExJCagOyFX8pjlPddnWm9I3BCje5sZ
 3QotPErQNhuLS7PPsRdlSOfns4dryoACRTnpfe0nHprTj5JwwKlvAZhcMi/ZtLvUmmdX
 x9BhzeDZ1yKcvc/RoA6rf2JMu0i2YshiH8XdN6iSFDCYETBsPwD69GKy8NFVAo0Y1VRW
 Fby8Fq3fYpIKTmrqwY12UEVcnpRS1Jb9g3IEK6ZUg+GWZ8r/aUltdV6owP8v6t3LHlK4
 fX4g==
X-Gm-Message-State: AOJu0YxBhcRy3xVn7X9RCBA5Os6t3LOdCSPCKdDbP0lO597Kjd+Uc9Pm
 6kAXdClvL36VBxYh2a9cbUsT32w8QQuyOBRquDKIhl6YKT+/4nOdoFCbH0nKvxEcE4S9vrGlFkx
 k
X-Google-Smtp-Source: AGHT+IE3x9Xvg6nlJO11JIY2GMwB4YXsNx4D5GxtgmoHP8W+u2+RfTVFnCsoVGZO3KdJ/QMbSvW9fg==
X-Received: by 2002:a17:902:c94c:b0:1f4:92bb:6604 with SMTP id
 d9443c01a7336-1f492bb660cmr14211025ad.20.1716752583388; 
 Sun, 26 May 2024 12:43:03 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 10/37] target/sparc: Add feature bits for VIS 3
Date: Sun, 26 May 2024 12:42:27 -0700
Message-Id: <20240526194254.459395-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The manual separates VIS 3 and VIS 3B, even though they are both
present in all extant cpus.  For clarity, let the translator
match the manual but otherwise leave them on the same feature bit.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu-feature.h.inc | 1 +
 target/sparc/translate.c       | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/target/sparc/cpu-feature.h.inc b/target/sparc/cpu-feature.h.inc
index a30b9255b2..3913fb4a54 100644
--- a/target/sparc/cpu-feature.h.inc
+++ b/target/sparc/cpu-feature.h.inc
@@ -13,3 +13,4 @@ FEATURE(CACHE_CTRL)
 FEATURE(POWERDOWN)
 FEATURE(CASA)
 FEATURE(FMAF)
+FEATURE(VIS3)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 378da991eb..9e5fe905ad 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2188,6 +2188,8 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_HYPV(C)    ((C)->def->features & CPU_FEATURE_HYPV)
 # define avail_VIS1(C)    ((C)->def->features & CPU_FEATURE_VIS1)
 # define avail_VIS2(C)    ((C)->def->features & CPU_FEATURE_VIS2)
+# define avail_VIS3(C)    ((C)->def->features & CPU_FEATURE_VIS3)
+# define avail_VIS3B(C)   avail_VIS3(C)
 #else
 # define avail_32(C)      true
 # define avail_ASR17(C)   ((C)->def->features & CPU_FEATURE_ASR17)
@@ -2201,6 +2203,8 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_HYPV(C)    false
 # define avail_VIS1(C)    false
 # define avail_VIS2(C)    false
+# define avail_VIS3(C)    false
+# define avail_VIS3B(C)   false
 #endif
 
 /* Default case for non jump instructions. */
-- 
2.34.1


