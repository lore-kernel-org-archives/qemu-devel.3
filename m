Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0756ACD4F3C
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa2U-00038b-Td; Thu, 14 May 2026 13:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa12-0000rm-8m
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:33 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0x-0003tk-KR
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:30 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7dca5f64e86so6516604a34.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780282; x=1779385082; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7mCE7v1CMCCdQhzPLrKhoNSMg70i/ioZcq2tZRejjeA=;
 b=GCm8cFK7e3RiBxwRHfRCo7xqsIZUUqKUZvKt+s/jj26mhYvq2HphKsJu6nqMa34s2V
 kNnldHuk12PRZfeSV2z1TBaKkmjggU15fBrmb8qe3ZeFpnJ6nUkJrDH+4kbjXXlgmzMF
 CnARNtPATlQHFkUik/vRlZWZozLRyfsvm8Whtcy6dnIayOBlGJeBrpCRkE7R3JH/7qdZ
 ggBPIo/VFqrvVOnCdA8KVEAq7PBrN8RFB+unT6EdkaoCdbeIU5Fe1D277jk0s10aD70M
 q5vW6cMZavQmAnnlxudtSgyFqhajOELCMyoSlalcGIl8RU6iC/l7uMkUyXQjCUIZZMqT
 WB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780282; x=1779385082;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7mCE7v1CMCCdQhzPLrKhoNSMg70i/ioZcq2tZRejjeA=;
 b=Qoz8g47CvlOB1SQcMEDdnGhKuXU8lh6Yvu382VjcPZDpfVgbDjgkAc0Mh+CskjTZyn
 KhX7ZPTO5ZgzxwWKIGmAEU7MUym7GXKfzenqpW+ItOgE1RE23otLL6UL3U0Mbvt+POhF
 BxQE6tGmZs7RWyoVyTr2XfXfZSe2mm7dOKoc8MIvsLpmEMTkDjrgmxsM9wicoK6cRTob
 TlsNqcnRpvTvszAVy/1AsIax8MdKcEGIo/MM5jQttSMqezk7/ayW4kys5BC6ovssa09/
 +h9U/04E6LAI727ogrZ+ph/6VvEyn7aAmLOvU6o1LD5UE1k8xR6eqB6clXToZRnnQJZ1
 ghZw==
X-Gm-Message-State: AOJu0Yy6UyWU7D6/tpNmsThkm+ZtuzfNcjwE6WPZFjLFJKqSnDRhiEWY
 km7ECVlf0qBQ04P/n2b+LNtEXHs8ZPxOfHYWiQZRSsqFXuOLhjKMdPY0
X-Gm-Gg: Acq92OGf3CYd/j59wsnDPDi0TU4DvlnIQp0Hz3aw7A/aV6N2aD6WyxUr+T1radBGMA6
 zev/myQLrJjF+drOQQ9vH/lQXa05P2np4lYqn5JWJdFqoKL6UwiW6Fjzf8miRYfhtlhqjIva1S7
 WaLLazKnL/3/H05cH0rWSfQTCTuXwVWvRYa4ezpvHPOYIN0WC+qQ93bRzczzYol8ujW7S2XhCzl
 TlpVfDb7rBPKbidxr5XqCfXRKzmXhhnPjAj/FLA5HaEOv8c3YeR+K+BXREUxbD8Ri99aCrbAUaP
 WTGN5e1kT3pvi2IKkC52QQV/NPpXnyWamH0hqHHuaBDZXwpT7gcWtUQM8D6d7PrhhK11SvmEL//
 5sYKvZKAETba1fsVqQ6LYns3+gMaaGAnoZWBH67eCDeVbnnStS+/Ju4tMl0jH9uEHR0kGBiiH5e
 UUIYZ4l2uQSKjFFMgzpIe8n0Z/u/eR+KZUxB+pERh8zUvVmnHIgq2ImtrbujVMO6isLJV/FF/Yp
 7ybn5JO7t/7fJ7zWQfzvxIB3A0RZSqu9KjCumUmVPxj3JDs+0cmDIHKiBpCt1ff6CT2
X-Received: by 2002:a05:6820:1516:b0:69b:91dd:ca4f with SMTP id
 006d021491bc7-69c9bfd6668mr229236eaf.55.1778780281864; 
 Thu, 14 May 2026 10:38:01 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:38:01 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:36:58 -0600
Subject: [PATCH v7 09/35] target/mips: add Octeon LWUX instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-9-226686be4ce1@gmail.com>
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x330.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

LWUX performs an indexed unsigned word load from base + index and
zero-extends the result into rd.

Add the decode entry and route it through the common indexed-load
translator with MO_UL.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split LWUX out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 8a755075e8..db7d5f55f0 100644
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
index f897b42807..401c4bd14b 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -166,4 +166,5 @@ TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
 TRANS(LHUX, trans_lx, MO_UW);
 TRANS(LWX,  trans_lx, MO_SL);
+TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);

-- 
2.54.0


