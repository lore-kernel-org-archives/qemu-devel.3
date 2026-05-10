Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371CBCD37AF
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 02:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLtgC-00068c-NS; Sat, 09 May 2026 22:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgA-00067v-GT
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:02 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtg9-0002xz-0p
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:02 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-42c08cbae4cso2560798fac.2
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 19:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778379239; x=1778984039; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Kt/X9h3ebfY2yAsj4mYC6DTi18sxMdPXWVIaTnR56mU=;
 b=LRmtqElQYGpXHcNJRnZZ8zI29oXIrKWb+MYvXJm6jFLXtKC1BzgGLHp+Quyltiph3B
 m+z5ii5oVFngwuR11KEUFkZx5SlcbFQFHOMcWH2k/o2ehjErrkk4aAStBfh7RPqSxhec
 OP8vGq20+f4YUaFWpor7nG0J0cTF0FRpjRnzQWggnFJju3Xy4Z2EfA3u4BHO/YM7WmaQ
 x9bfId1D00mCepp9z2LK5A3dOJ4oOftPM1JVNA2rWZZBcOAI936pGp2pLJjOPQhT63Ii
 cLaMuakgMX03MM8xxoTd7m5jawO+/3ZDOH92x2rYrboyDvkoSQx0AfT2Mp1tZRViUJOD
 F4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778379239; x=1778984039;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Kt/X9h3ebfY2yAsj4mYC6DTi18sxMdPXWVIaTnR56mU=;
 b=Mgc/PGBfpYqSfuLtsxEeI8tTkyKp/WzIl881nZlWC4cW9VnRXiesSYOY8vgJRLDN25
 0j4ZpiJ+O3IhKgxZ6B4dMcks7Ipqq0tdM60xqJ4m8JLyrsnpHUcJutke9mUjm3gNedWL
 LMC8J2bqCuivUzrB/LAfrPYHBY4T4WMdDnlMqTmLj8MHNIf7tC6wmvD9QXEfr2/iaacL
 OkFkYZ+dgN+CLKCxyo5qgVEUiIFXwLdupBLinB1vF59le7iRrH+J5p01lxCMlmtFMkYU
 3KeP+b0ZbbpZOlmd0b117z0wzfKVBv4J9QxPfMGv06oxoedTJHiYSd6q831aIi/pXcPt
 a12Q==
X-Gm-Message-State: AOJu0YxNHDKup23XwzXlojwg4+AAAjf5JQ/QlP6X1dfNlig+CRIyFsTz
 ATjTb2cZifj4Q6arFKN0+yQhSeylFhqhmqniGcklt2RcivW39WOHbMOAgVDL+yTr
X-Gm-Gg: Acq92OHx4YwtgHj7eBlcU2A6WdTQJh9Qs73Qjpd6VkKTcPsPFqj1SZA7ZwYtJa/KUy1
 gy9+6EnN8mo4704uwJma3eMwWKei3j4au2pcZmHFrE6LtzpaB1fpppE1cnLyKkgiqO2RCSe5Y5n
 t6H2SBCNJcHYu8sHWwFMhm55Cky32VDLrW6z5ibdHa5mMbrUFHKoW90tH6CELSqJ4PgD8ag8+Pf
 RiV8x5VqiP0D/R+TequdL6TnxdvXJLYpZDUbn6vgAP+vgcgoRRawPw+zKadOq3ia5No+55GdpzI
 kaYbkgta19crNyulge5QexfdR5E2FYmCXqfFq0dm7NO8DwCb3uQho48TBDahV8kQ6L3rnoVVrJd
 UYBkClvpD9jR3O+Cq4nNspXKrdTxKc+ZckGAwJJYwLdWBfKGzzlByYS7YcatqeS3IvnEeoWAIn/
 aT/sQ7MDBa5AK/RwQh33cBqsKK/TIdo6qMosc6j/z1V5xnrKXswPrUs5T477Kk5Y9IF5bYPW8MR
 tcUMvftsLgdw03pYcCuaaNVahGPuo51Z7zhAJ+ARmITw2cRCmaEFeuyL5g+L4rG/o0N9TXAOpcC
 wCEiWPhaUZdBNA==
X-Received: by 2002:a05:6820:169f:b0:694:9f32:11 with SMTP id
 006d021491bc7-69998c8feb9mr10592690eaf.5.1778379239540; 
 Sat, 09 May 2026 19:13:59 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dbffdbsm3645643eaf.9.2026.05.09.19.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 19:13:59 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 09 May 2026 20:13:31 -0600
Subject: [PATCH v4 08/32] target/mips: add Octeon LBX instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-mips-octeon-missing-insns-v2-v4-8-d669dcd05c2f@gmail.com>
References: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
In-Reply-To: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x30.google.com
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

LBX performs an indexed signed byte load from base + index and writes the
sign-extended result to rd.

Wire the existing indexed-load helper to MO_SB so Octeon user-mode
binaries can use the signed byte variant alongside the existing LBUX
path.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split LBX out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index a2bfd0751d..efb1a48b38 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -49,4 +49,5 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 LWX          011111 ..... ..... ..... 00000 001010 @lx
 LHX          011111 ..... ..... ..... 00100 001010 @lx
 LBUX         011111 ..... ..... ..... 00110 001010 @lx
+LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 1893bf359f..ecdce6ab9b 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -161,6 +161,7 @@ static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
     return true;
 }
 
+TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
 TRANS(LWX,  trans_lx, MO_SL);

-- 
2.54.0


