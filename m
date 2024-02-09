Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12917C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 09:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYMpG-00054f-To; Fri, 09 Feb 2024 04:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMpF-00052o-Cj
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:05:37 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMpC-0000ep-Qp
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:05:36 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-511616b73ddso1149950e87.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 01:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707469533; x=1708074333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HTBcOkyf9XYobNj1mcoJBJIN9decb6okix3YTMtoBGI=;
 b=hFScsn7BKCffMbY4fe4+BlY7huNuaJEfOFCSCLtm7IDS2sGyotDH30Olx6VzfJLKZr
 6wWMlklVxntGZYKWzzr78fqZ8bHu+/yrTDsYImw4YiQacLBiuiywdcquzZNgk3crgeHZ
 Ou9dAvPDM6+mT9n+eKFCbKA2WrZ7CG9dmhg5vWsy7ctSetwCihrM1eQUqR7Gec//5FcD
 UF+BVnwpTvzUz8+ICW0jjLLYQUaSpx+lZAR+y6xtInsqyhnAJjHWIOJXvZ5y4udV4HHI
 3dw6lyFl6HapmUJCrNdUEhkiOmEPhHhuCqolETxZ8si91Mjg3U8pCNSIzfoeHPGc5Cql
 u2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707469533; x=1708074333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HTBcOkyf9XYobNj1mcoJBJIN9decb6okix3YTMtoBGI=;
 b=I6DN/EehkZ7FPpyAirpVPlYhYOHrG9NonQYdz7iJtxabFqgvhLBJVOzQT3lCZ8HOZ9
 kZRbRw71sOwqjinxYEYEJMUw2cDyZx7O7kDOOyTbbMjKmGuZyiWdEkE7XpftfPgP0cjj
 KLn1hLSy/agbr9y1oqurOGR4RPZ3z8rkClrSS/RyJ7ibaZ11DKykyCJaS0/c9KL0qGN6
 5pTPedb1BOdYdHX1/hhbFFHpd6vsYPnZaHsuozhDUD2VRzjgc9DCZnFSvIL0DWE/EFKV
 T08J7CFw9JXnZ43K1gTZemJNT5DFj08/qZyE3V6kE6Fe9a19ZTN0wQWkAmt1Toy/Beo4
 c8IA==
X-Gm-Message-State: AOJu0Yy4f6DomKXPN6sWS9E+Ahv2EwUBxyEFMIw1AnrJTx++XI4m0i01
 VhgaYXb7f7dZMdqNqCCdAUHpcgzkMxLLqx7REpjBaQ/X6xNPiX2NDe6twf7FXZ0h+GvagDfTu54
 dDfw=
X-Google-Smtp-Source: AGHT+IE2w49RE3RjIXIud/gu2iNy5ktRU9VNMb89m1pINMbUsqLyNTfyfeRJ48lXrK8XhWPeVxic9w==
X-Received: by 2002:a19:ad47:0:b0:511:3e58:3cff with SMTP id
 s7-20020a19ad47000000b005113e583cffmr596037lfd.16.1707469532935; 
 Fri, 09 Feb 2024 01:05:32 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVLnWIvOyj6bf54wnuS6AO+W9AjF369INnTU2Pq7K7+AnU9+eAoSzZxyh4CQZLnomQVYSECONH0ML914Kpx1r7Ivf3kAQerpZjc+S18TnPlv3SPlcZZayPOSgEf0kwNTNdNoBI4XXKEYjYV9jvnwomMk4LWHvsXyqaJRtS0PlEQbvCyuXenb/i5tuO9kI8vfx3dPvzsaX7NVkmlaA9Fg49oUbFZUzT5ulshVFkAPsJduVSQmGI6/zPcil5BzOyAycsLgWNLSthXIaWyebhOPszK4UwiKFkYPTMATVrAAZ2pzGy6JkDKotzelNHnk2GhkVuDjera9RdspSHnv76Izy52vR/FQu4=
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 be7-20020a05600c1e8700b0040ffc10f7cbsm1943521wmb.42.2024.02.09.01.05.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 01:05:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [RFC PATCH 03/11] target/mips: Remove MIPSITUState::itu field
Date: Fri,  9 Feb 2024 10:05:04 +0100
Message-ID: <20240209090513.9401-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240209090513.9401-1-philmd@linaro.org>
References: <20240209090513.9401-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

Previous commits removed the MT*C0(SAAR) helpers which
were using CPUMIPSState::itu, we can now remove it too.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.h | 1 -
 hw/mips/cps.c     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index ef26fe03c7..6ec2ff4b97 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1184,7 +1184,6 @@ typedef struct CPUArchState {
 #if !defined(CONFIG_USER_ONLY)
     CPUMIPSTLBContext *tlb;
     void *irq[8];
-    struct MIPSITUState *itu;
     MemoryRegion *itc_tag; /* ITC Configuration Tags */
 
     /* Loongson IOCSR memory */
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 4f12e23ab5..988ceaa0b9 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -96,7 +96,6 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
             itu_present = true;
             /* Attach ITC Tag to the VP */
             env->itc_tag = mips_itu_get_tag_region(&s->itu);
-            env->itu = &s->itu;
         }
         qemu_register_reset(main_cpu_reset, cpu);
     }
-- 
2.41.0


