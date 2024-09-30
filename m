Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FA7CF649D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 09:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svCRA-0007m0-I0; Mon, 30 Sep 2024 05:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svCR8-0007ep-Gp
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:11:22 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svCR6-0004UL-Ty
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:11:22 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37ce8458ae3so785137f8f.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 02:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727687479; x=1728292279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gTfK1Y7AoteS474Co0RWkp3B9nFmF0nIHDb3RW7qOck=;
 b=H4BRA/NGY8u5uyAmg0L+UL0hiDkf3e75Lu6iPFJ0oYGSXV3j1cN9fLUbork1xJZTeo
 HY1mO5z24Q08Di1/Gd6+guYis1rrQpqpjj5xFWzmSrO/x2iKQ7D9fOH01Tk8JZrRIS8t
 /q6uB3SafbOjebHuhF0Ly5MLsiQQXlHKIVN6nA3QHbwkid57VvP6L8ztTovcq8yYBwTK
 91BLFvsURauN02zSE8vdVu/Opy/hANoinvVzKSgd2IkpUkUa9fyfIUhdbWNWAOPR0zNB
 /Ub/uWvzb47NS+aFPitKOCm1MCUwVdBGpF6QKtBYJOgbdvnYnR1LOrV19y0FJuNashkc
 CFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727687479; x=1728292279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gTfK1Y7AoteS474Co0RWkp3B9nFmF0nIHDb3RW7qOck=;
 b=HPIH/RmpIBokBWXrjutVLNeT/R/mBr/M9/tcOgMhm8O+TfaLVDMrufrdoEh/ETmCli
 A8p5sYOYgfhS2ZpdVVg1NyPEVw72WpFVY3h3lC9QjvrDIMhgBDUpIid4DvafeNePMj3X
 vP/ucZ3eP23QgDL5aN8aRQh7TQ8Sid/QVzohrn67RymtHCjTFfSZPw6pDH0Y1hnPk44O
 WIWdPeJ533mxfzRQ59ep2Urh4HKNfbUUseTT9ExLnevqtHZppRwQPkL5tu5sL6RPF/1R
 /AM8BrvGoM60mcWdXUcf6WnYoDYM4e8XLQJT+k5yLfFGAZnnWdHeRFKGTY3mW8MvB/MS
 JKCA==
X-Gm-Message-State: AOJu0Yx9HerL4EWtXnm4HsGpFZEIJnqRMqqq24cmU4e7wa9CDyu/SQ8Q
 vPBJsoxh81o0XHu0HNiRVz4oB0mOGNxGVG0TUv5F5a6NwlwSeF95PZhl6qBwrC5VjhRTUOsbcxq
 7
X-Google-Smtp-Source: AGHT+IHLyDLMvH7R5jMc9L6T+pPt/e4XTSIzrVwfL5PG/fZEBYYRyWYqTKGotxGPWdA1evhWYP0TuA==
X-Received: by 2002:a5d:4b8e:0:b0:37c:d123:f3bf with SMTP id
 ffacd0b85a97d-37cd5a69735mr11617422f8f.3.1727687478879; 
 Mon, 30 Sep 2024 02:11:18 -0700 (PDT)
Received: from localhost.localdomain (183.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.183]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd57429e5sm8486235f8f.98.2024.09.30.02.11.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 02:11:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 02/12] target/mips: Introduce mo_endian_env() helper
Date: Mon, 30 Sep 2024 11:10:51 +0200
Message-ID: <20240930091101.40591-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930091101.40591-1-philmd@linaro.org>
References: <20240930091101.40591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Introduce mo_endian_env() which returns the endian
MemOp corresponding to the vCPU env.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/internal.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index 1ce2bbf62d..5fe1af22ff 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -293,6 +293,11 @@ static inline bool cpu_is_bigendian_env(CPUMIPSState *env)
     return extract32(env->CP0_Config0, CP0C0_BE, 1);
 }
 
+static inline MemOp mo_endian_env(CPUMIPSState *env)
+{
+    return cpu_is_bigendian_env(env) ? MO_BE : MO_LE;
+}
+
 static inline void compute_hflags(CPUMIPSState *env)
 {
     env->hflags &= ~(MIPS_HFLAG_COP1X | MIPS_HFLAG_64 | MIPS_HFLAG_CP0 |
-- 
2.45.2


