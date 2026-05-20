Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78FDCD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPf6u-0003XQ-BE; Wed, 20 May 2026 07:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf6I-00039H-P6
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:28:36 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf6G-0004Vc-NM
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:28:34 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bd373f83042so980657566b.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276511; x=1779881311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xj4LscJe5qbbyCvumcZkKMp4Wyep599tHoKrYhpUv9c=;
 b=LVNWN2g+dMPd2jrVaNqZc00XV/9gMQQjORJwfF50BK8LPiSdFIPnjVuk5FwObO/ISa
 SKs/FMM3W3kfYWPMJzWMRjVYp6xX/dUS525xaQqR0rrWeBb6PMVBnlLyhcgIIlSNM319
 +2lfKJGAZaXoKBW4zJanagxspzwL30UbxgXib11Xvpe6YO1AiNxcQ5OGFMmoJWyIeOWE
 +OzSqzIte5Hzl1teg9rNX61D6JNcCL3y7DZKgDaWPAlSeewl6oMonFeIsGLCTwEX7sNw
 Th9VkvdJ2UrmU5vhpCIhZMNjZmUgGAVUz0CEFZXm2rPHD2SCs5yhMv1l8dFIlHXEVQwQ
 BsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276511; x=1779881311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xj4LscJe5qbbyCvumcZkKMp4Wyep599tHoKrYhpUv9c=;
 b=QA12Dcj4URmYS/IjMlMcBMxn5zXQ/ikc9AyJhD3L49PEHCWsDz17Ni15dhyez+JTh2
 ilRsd1LH3bHVYgcj6Bo1nYnx1Mh4y39zBSARkyAo7SyPgn05nct2VP1p8185BJjO2rOP
 nS4CMkJCDDo75Vc3PWJmv/18Z7FjqAFcnpYfjx7UJHbGxiD2esgMk4PMTBPHT4n/Jb4x
 Nh6IROxBRgfRZ9yG3rhur/AvDegFE6q+LA8rhRa89LdCmt+7rIWrtBaj3j/eeAqtNzZh
 niR9Pwm0aaVGeI+NqYYDtt0s0rftaYhLeUd8e6kYuxya9hw8Ueb8heJEhs2SLdudaVgv
 /pRA==
X-Gm-Message-State: AOJu0YyndTCywhEgrvPWQXYba4F23QvTpE4eh93hHclMYkV6nKNuLZZG
 HhnfVxiXclF6WC1Pl5uULrAR4Bd5dH+6RcIL2G8xR83JDM59K8YbpdHkdavyNqEDXETPptUPb+b
 0RgX9wAE=
X-Gm-Gg: Acq92OE+L2Oljsx8ruL/pucHDKVW+25MjQrnd1cx+3CPyRt1fFKJ7gMCrMI0BDIOVMx
 WSL3Y3aM1XtBGE0UGq7bod23o/CYiAqfQtQSFaLm/kWf0xPYf0SIHj5No76b1JWvt37vg0eMWcq
 pMy6t33T+KufwCEDd0QUnNwl6S//6Hsrb8d3UrS2nhvRqoJZ5LVHq5+cSq7MOnvAqFLYAQ/9mlX
 qhfCPpbODZpDNOz30ZnQr8Y+GhPAEQCqQk9qGBtR9SavzeZeDj9vv+2HS90Sid3crXeoqmiW7Cf
 MSw4amQL3SEf8ulsKX51RKy+wdvX6aqo+lDnOP1oysJGSwY2Yl/MTEpMSqSHqz+/pmrCheICXX2
 ZgD02U846tqc/CwH7h52yZsgF2gBe5J5dPABhdf/YBIWgxpI1Bg41jC6ZE2S0ZFnZK5MB0IFGXW
 uo6etUwBU9wnq8J3aiPUKVsahPAf/mrXjVJejzWepWO20P2C0Kqn94wQ/Ux2iiwXsq4bKM+yQrp
 hhfEQ==
X-Received: by 2002:a05:600c:c10b:b0:48f:d1b8:9aa4 with SMTP id
 5b1f17b1804b1-48fe5fcdef4mr275122225e9.7.1779272379308; 
 Wed, 20 May 2026 03:19:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5cab818sm403812035e9.14.2026.05.20.03.19.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 03:19:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v11 12/24] target/mips: add Octeon LWUX instruction
Date: Wed, 20 May 2026 12:17:53 +0200
Message-ID: <20260520101807.9971-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520101807.9971-1-philmd@linaro.org>
References: <20260520101807.9971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

From: James Hilliard <james.hilliard1@gmail.com>

LWUX performs an indexed unsigned word load from base + index and
zero-extends the result into rd.

Add the decode entry and route it through the common indexed-load
translator with MO_UL.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 8a755075e8e..db7d5f55f0a 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -50,5 +50,6 @@ LWX          011111 ..... ..... ..... 00000 001010 @lx
 LHX          011111 ..... ..... ..... 00100 001010 @lx
 LHUX         011111 ..... ..... ..... 10100 001010 @lx
 LBUX         011111 ..... ..... ..... 00110 001010 @lx
+LWUX         011111 ..... ..... ..... 10000 001010 @lx
 LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index f897b42807b..401c4bd14bb 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -166,4 +166,5 @@ TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
 TRANS(LHUX, trans_lx, MO_UW);
 TRANS(LWX,  trans_lx, MO_SL);
+TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
-- 
2.53.0


