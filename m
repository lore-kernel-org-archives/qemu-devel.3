Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B420CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMtb-0002ps-77; Fri, 08 May 2026 11:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMt7-0002en-Ko
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:14 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMt5-0001gv-NO
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:13 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-479aa2dbea2so903201b6e.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253190; x=1778857990; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HOILVDpaMznFWxynFwOxhUhVu0sGJ0ISaYpQernUqr8=;
 b=TkmMDqJYW9PBO5igHSJ5KMicY314QvgItCuE9Qw8c+QdgeFhFpSNPvRTaMQLcCrKDV
 K0ujn93ZX7TIZMheG22lJUJqQUNfXGCiyL9c9hYuTOuZ19veT23jPqMxmH3ZHZ5rUVsm
 zLKY7xiNrWQRN7ANZpivHemomuKsCD4ALN8GV/ioUvQp+PILlkPsNPSTcl8d4eQGtRZY
 u9qCygWzcypwGF0j3bk8PQw01vFiSzMNDFBBNCUYYs/rgYuMKDtN/0fBmwt7NbjRNvBi
 BuGjaR7yAtEQC2q/hc+nmy2xiQ/KsoWz45y9ShARiGVBFDej0Ufhn/mWYJSHtn/NrH+5
 pheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253190; x=1778857990;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HOILVDpaMznFWxynFwOxhUhVu0sGJ0ISaYpQernUqr8=;
 b=oVeAKXqL6JNBQ1hqfOqu7Fog/ipzaX1Aq32AaRvSOjbapJSVLyHQxD/0xz1E3iZn6v
 e+jbCNdP68HE/Ke1u1vke/VIXU6Am/B7nHtP+H/lKZGTtmCxYRa2phOmYaEvZ6Ae98G2
 rBbs2pitvlszEDnsRa6UjtHr4+BlhZXlcKhOdMJdGDJmOAI05CAUGQ5ZyxroAg/P3Q64
 rnjcmwr5fug3LLbooED0q5sQp4J9YpslwSxIrU20pyC+5fUKMxapQ6gBJDDYIRBO4NbG
 929yd3vtH6jhskfmhDpBWacjHgi9emVHu7SwsCmP4QxPssLpMJMbx/XgbiLcamDGXt1E
 VzGQ==
X-Gm-Message-State: AOJu0YySo6h6VACmR3x0TeLCRd79jDAkiwH0i272M4AT5SoNKXa5bay8
 KXLA/FUrbwOaUhKrixBLiN5kA5sAriqjqQeusYw+gzQVrruAt0P7ONWgc5zANg==
X-Gm-Gg: AeBDieueruD4p8gBFzmQOo2YZCx14ouVHN6gnP2cziC+3/jHwX1+SAoiTt8lssOHtWS
 Ts+WJjUnn8XZbQToHFqo97z01A6I35acGqxgPtx0Hw6nuCnuWNBQQ+GsiRboxg6vEt9aunSc/B/
 CaCSdGizz9W7pvyHCOiuhMG3+mesGha0jFJ5jBOXYIWND8mvZ26jfuXpGzzDmJ+/JsjmDrkS6PM
 M8F0uvQXFYngh5vRKeGyZKC9tN6kasyyPkaOlUIKTjNwRAngBwukF+OCE+RdSr1l7cNy5XjZaDK
 79Bhirnkt0FnzjGk8ylIVV6YeyWT2Vb/jV7RCncYxyC2qMhEhALwp9Mjf1CvdUdfgzf5kGI/6yD
 7/jZH+HVW3cafJBKMbDKkSYLbaCO1ihnRIZJ/tzDe7j93+RH2/JtW30ceHb3FR/5HhJjcIYIss6
 kocJPQ/gWuMVSKDSC9SrdCl5VPUyKndWXXw+3ARQmbGY/ufUFi7UF/LPDmTvc7a6nCJZLs46nH8
 SZljpB8TfmJjfh429IekLKyGUancxfHFQ9q0VGb/7kdopn6ywUxV/fb2ba/lEB34MsanUlZporT
 bwZtUSqHkpsojzGyLOOz2lozneDYgyKnb1/05L8co30IX4s5O21fCAKLCw0uhXno2haMqxu8DAx
 31YjTNw==
X-Received: by 2002:a05:6820:f026:b0:694:a285:1273 with SMTP id
 006d021491bc7-69998cc6306mr7159586eaf.19.1778253190021; 
 Fri, 08 May 2026 08:13:10 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:13:09 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:12 -0600
Subject: [PATCH v3 12/32] target/mips: add Octeon SAAD instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-12-bcbec96357d9@gmail.com>
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x236.google.com
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

SAAD is the doubleword form of SAA: it atomically adds rt to the
naturally aligned 64-bit doubleword at base and discards the old memory
value.

Implement it with TCG atomic_fetch_add_i64 and the same aligned
transaction semantics as SAA.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split SAAD out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d6b241de42..d77717cd50 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -47,6 +47,7 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
 SAA          011100 ..... ..... 00000 00000 011000 @saa
+SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 19535768d2..104822a64a 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -188,6 +188,7 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
 }
 
 TRANS(SAA,  trans_saa, MO_UL);
+TRANS(SAAD, trans_saa, MO_UQ);
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);

-- 
2.54.0


