Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325ACCD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgX-000160-RQ; Wed, 20 May 2026 00:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgV-00014X-Iz
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:31 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgS-0003ms-VA
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:31 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7df05fc49e5so4626486a34.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251846; x=1779856646; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V+Z5Xa+4C9Lk0TNV9LgOzbpa9crqmSVwKd0svd97e8w=;
 b=JrQVfw9HDf0VchnU6MOipQNHJpkvqZQDsGE9jpirga4tnDnvwYV9inq97aDAwGeEGb
 JUhc8OwBBMAkGyX8/jeMoToOaG6s75zj6mc8f4JOOMTkfJTNsH9F2isVnCxXICSN2ErV
 zy7Doi1PlQ5vx09VSlU7N/b3gLJiLYZIAaecaj0NznFbKfo1LUfNrHKRc/3zkJDgiilx
 wXNm7E+DzQcIB/73FamTxebg0xDHxEjd5ZLX8EwFHbd3UDdusfNpGMHgIh9INC8i4F3x
 0EBGL/1l1wxp4PJg/BQeG6nEdsOv2XPff4LQn2tFKvN9ad0pl68m46uh6NKVG1d6Zb+X
 ttqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251846; x=1779856646;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=V+Z5Xa+4C9Lk0TNV9LgOzbpa9crqmSVwKd0svd97e8w=;
 b=mmKpTuNj4K+mrTNzBu180GyC01Mx1G2FoAdHzhLLZvKOIFsa8hQ1e3G4Kt8i7dm7XL
 cdQrFaZN/P0YLo/H9xTAGXnKNM5HlBGyxpvu8z3r3z3nXOsNtIA54d5LfnuVUJ5LpO4j
 J8AkC8A4y7MO9yVD49Bjl7LqssGZVVNscrjTtzDkoseXsgf6wIK4FTVBg4n3Y6N6h85l
 sZZrUwY21jEldCu0SDmdrEAv+KUTTEycbhNZkIJ5Ld+GWpCCj0byadJAw9bQLWAdCfPp
 JHXHsQHDGlAqPht3NoFTIeHLZs4ikrrGGEYZPkSIwzi9xtilaQdnWdclF0d2VQqfmH3z
 PJ6A==
X-Gm-Message-State: AOJu0Yzdnq1OYetdxRscC+S8x3TVUxm5oqpqnyve66+m/XviT3IkBDJw
 TLHQvM+6cFgwo9bSwME5lQtsntNlE47ZVJpLnfJb1Jt/sPrM4nfQ1rAc
X-Gm-Gg: Acq92OFYl20NAiXlpE0k7WoqmQLSKu+mrqrOFG37EMHDCYuy3HttH0eo8/n1YXfaxRG
 +86rgRexfjaOtljUWfP35WCvHuObVVTHRpfFWr78mKT4OXZnJ2rcQ7Wsl4XRB3V2nD412ckiyV4
 Ga4lDdS3gJrRiOfhopY6ARcBfOeigCsdqgZ5quf8xIWMMkXPcKYbt54fFBadarr2tE+wjXgb5Q2
 WGPJ0HErKTu78Q3kJCRQkQhBsobL3qe4Fn9ug4MK/4Sd5wOuYbqznILfKSNNJu4W/ibd+yMt5Zp
 Ft6Ti8L3yFginkt+YBGlBu3mnVp5T94DF2r7Wm5fcyQ4+OTVgwG07k6wksPzfScyOSvXgTZMrhJ
 zooHcgpeuvZvjhCZmZYrP0o4RSmihHp5WPnmdF86oaOp/3Kd/Hu5hIQFdsTdeXzQ8RfovW8pVqy
 pwYPh5d8a/GEhZ+2ezKYuL4FVK1c4nKa7SiemKx/N/pX98iAoPygj5IZASwuvJLdDRLn3W35fYc
 2LS/6rogSOosg+pG7JySjOtP3tcQSSddnq4MkBzI/fDfBbaDKQnkXKATrXsmYTXdfXI
X-Received: by 2002:a05:6830:6205:b0:7e1:f7e9:327e with SMTP id
 46e09a7af769-7e4fa05ec7bmr16481899a34.22.1779251846518; 
 Tue, 19 May 2026 21:37:26 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:25 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:04 -0600
Subject: [PATCH v10 10/45] target/mips: add Octeon SAA instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-10-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32d.google.com
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

SAA atomically adds rt to the naturally aligned 32-bit word at base and
discards the old memory value.

Implement the common SAA/SAAD translator with TCG atomic_fetch_add_i64.
The MemOp selects the word or doubleword transaction size.  QEMU only has
one Octeon CPU model today, so keep SAA/SAAD under the existing Octeon
instruction feature bucket instead of adding a finer-grained Octeon+
feature bit.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v6 -> v7:
  - Use MO_32 for the word-size atomic transaction; the signedness bits are
    irrelevant for a discarded fetch-add result.  (suggested by Philippe
    Mathieu-Daudé)

Changes v2 -> v3:
  - Split SAA out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Gate SAA/SAAD behind an Octeon+ feature bit.  (reported by Richard
    Henderson)
  - Use the i64 TCG atomic add path for both word and doubleword sizes.
    (suggested by Richard Henderson)

Changes v4 -> v5:
  - Drop the separate Octeon+ feature bit; QEMU only has one Octeon CPU
    model today.  (comment by Richard Henderson)
---
 target/mips/tcg/octeon.decode      |  4 ++++
 target/mips/tcg/octeon_translate.c | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index db7d5f55f0..d6b241de42 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -44,6 +44,10 @@ SNE          011100 ..... ..... ..... 00000 101011 @r3
 SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
 SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 
+&saa         base rt
+@saa         ...... base:5 rt:5 ................ &saa
+SAA          011100 ..... ..... 00000 00000 011000 @saa
+
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
 LWX          011111 ..... ..... ..... 00000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 401c4bd14b..f00692830a 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -161,6 +161,20 @@ static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
     return true;
 }
 
+static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 value = tcg_temp_new_i64();
+    TCGv_i64 old = tcg_temp_new_i64();
+    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
+
+    gen_base_offset_addr(ctx, addr, a->base, 0);
+    gen_load_gpr(value, a->rt);
+    tcg_gen_atomic_fetch_add_i64(old, addr, value, ctx->mem_idx, amo);
+    return true;
+}
+
+TRANS(SAA,  trans_saa, MO_32);
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);

-- 
2.54.0


