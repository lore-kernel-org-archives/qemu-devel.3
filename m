Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE43CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVHa-0004kS-Oo; Mon, 11 May 2026 14:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHT-0004iR-FX
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:03 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHS-0002h3-0d
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:03 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d55b97f358so3291376a34.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523781; x=1779128581; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=epwzgyqWUwHcHcXE43xJX3o43C9OR5h/s86x93rUm6w=;
 b=SX7DP1RmvUQaRBhuwt/dr7oAN9rk5Kpt6SKNYjVT0Y4n7Fwy931Kv+ulpnACwTq9pw
 Qcckq+SmAyqCOw8/dXaJoIw5616LrQwP3ROQ7K5GF/Jca6FLNxidyLTOmUf62y+GK1VC
 KtdfVW5Ybi0LALbeJZsGqpEoccFgYg2ULOGpVn72cSCF4WfJ/LkoWGecA7V4LUxG4oOC
 ezYNLfrxCVCqv4SgK85TXNm+62ESg197Np3VAjbvR+iXrR1ccG9zZuB/BIgerndhWPGx
 2t+UG8Xp19ys2K00tWUN6Xz9gK1YQuGozaWvHjZ2rF26WXaphPAvftFJrJpjX3swe2J3
 3d3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523781; x=1779128581;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=epwzgyqWUwHcHcXE43xJX3o43C9OR5h/s86x93rUm6w=;
 b=eR2QHjkMEUVxXRviQNZHEujHm1UnHrXnybo8dgKhraD9eDvtvsEWV5clsst8SqyR3B
 AXB1bbwUxwlHRSpLxZ+cNyenYoYE2V/FISab79fxwwFJ4S5wY+hw2DVFU/VpLTuxtMv6
 oocWrtNwppBLpKPNjEVBafoYINiii2lH7aUxDhpdCFHX2BEMpO3Xz0gQl+Kbrab/Qdfa
 gVbeQA73y8BhidASdNjCzjno5UzF+ENfTlwtUcbqsEYbgGtmZ6MrKYJL8FerQapEqTHc
 sL8NyV13G+Nnp7Z3+oFVKodaCF/UJzYt9XvHmh91ndVHwpzZVboSgp6IXxp8ZytXZTkY
 UlMg==
X-Gm-Message-State: AOJu0Yzo7DoLQcqR0wBeUToc8lzpVJTB58I01vsBuTgx4br7FM0O3wZV
 j7zrOOOuvIxLYI5Zs0xdEZrvQxXkdMkpnoa4YMA0ukqucCxqHCEUzi6S
X-Gm-Gg: Acq92OE7bZ7nMbO6GQMzGr6SJGRnU9of78lmL9BZfOzp5goB1TSi4tW9f4MTcFMV7MX
 pJJPVWCevGa+O9DCabNpbWxlchVi/Irycgbl7QQcgkd81w42sahXdDzfKZ2S1JwMNYDxAsW2tXG
 zyu1gPfdL691o/wyccSVKbNDlbmsycNzgE/d/PfL2FbyH3POOXdRJbxgfBQzp3wpUMNnQdFs6YZ
 mIqgi+YMjTDwIiHCDqQBYVdlZ1FeDch/+A6RqBmx1jFvWS6JCWN2pnQBLSJhHh/FGetQq64yh9G
 3MLHPjcSmp10/ld7msybsGKUrwmd+26LgxDcPCkNXqJ/NIqArNGf2i3yFqUHGhI/uTr8lGKMIZ8
 VnHS+v17wii+QqU9dm5RdyGOQz7VaUwJj/6+Z+ZwWQpCVBs4E8psP9bttdJ7F0rfP8h8XjQFvOz
 fR/PMJ+Jy1LqaKjzhB/EW+AQ+L3nKo803CRE5s3FCGwfekrbHnSBMk12+SC/l0k2wUe1kECw1H9
 DTwf/+6vI6FZSOR38xPCj6ULbKkG0GonF+V3srEnx5HF3/tPW6t3r0mBbSqRMDhybdg
X-Received: by 2002:a05:6830:6110:b0:7d7:e59c:80e6 with SMTP id
 46e09a7af769-7e1def44dbbmr16041397a34.12.1778523780694; 
 Mon, 11 May 2026 11:23:00 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:23:00 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:22:41 -0600
Subject: [PATCH v6 10/35] target/mips: add Octeon LWUX instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-10-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32a.google.com
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


