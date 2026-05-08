Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24640CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMuF-0004SM-A0; Fri, 08 May 2026 11:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMtE-0002gb-RB
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:22 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMtC-0001jB-N8
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:20 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-42fe552aedeso765197fac.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253196; x=1778857996; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WZDIIV4iuVXaGnQ53Uie7KdsIthTfGrlVQtg2iJp9oQ=;
 b=oe6Uha9AgxiP58Vmb28w2AT0ZW9djKsCIV6YcckNw89jSDQPx9dIzktp2ikqVGhDgm
 UosS3kUK67MtVdiC9H/hAKhoM2pyS5EaccvZmknCrtCY+Fy+QB/Rm4BOEFJ7lvNIQXyQ
 N4qv9Rftgjb954Uci0NrU7dxafwXUACxWO/JPIe7C5f1erAxPqpBX3MLj8NWdMmVc2KT
 lz+xtD4rjNcSod/x2Zv7xKQibN4xtloDy4TODEPOQ1y35OlVKPuZTSkLTFGY0gITY6wJ
 wkdCD0jEnfxOoizn4ylaw1dYuRVU92hs5xLOn15hWX8gbebRXx8C47tPZSZWieiUUbtB
 dLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253196; x=1778857996;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WZDIIV4iuVXaGnQ53Uie7KdsIthTfGrlVQtg2iJp9oQ=;
 b=oN9OzWoHc0y/w4Jd2u433gJboBEKgNmNwLAVe3OW8DCtMoCHE2CMW8auyPIMk7J38Z
 9MVctXZF934D0KAiqfldEq3I8trk7KPWn3ATYF866WpZ0EbZTVTMYhhRRTAta1HasiZS
 jowtyLEakmc9+evBPCPFKWH0CUnqFPlFPbwa9MzU6Ruj7NdWysuoWD9GnOpmZjRNpTDq
 UkpUI/dC9Rzt4JdiP56lpJHXzwYeU68MlWIhcno4oMgsOBpyCrSXDaubmkh0aLOKpvSD
 xAti0bw3azzSZspLr4xUS7IHUxdFwVE9qIXj8M/ZvRqKrdsji1YoMS1oRcjmycHkS5xd
 JCmQ==
X-Gm-Message-State: AOJu0YwZkdtN4wtwhqwZagpp072Me336TI31s2rWXDurYp7u7+rtDs8r
 xN1Af635oSzQ/bv1/4BHxmCM9SqkcRACTnAMvjarP6IRWIFeLqH9e4awdUkeOA==
X-Gm-Gg: AeBDiesC7ocTy2ROMCLcKPITwIJ2Wp3sh+UNz8ev6im4/6qw2dfSPNWwRgv3q2qbL45
 GsbCCmlBzjCeRX6b9UNjHvLV9Xh0y7NnXpZ574T51I5jANUxmbCYJEUrzI3Xyg/TqUiVyhDV8Oc
 04/S3e3skCCPGTH4X9O3+Gc2f7INq41PPzUSjIf6Ip6W7BMO0gQxtszxXTEtHDSzef7s9u3TgBx
 SJAIe8UJe5MDsJutDlmB+Qu0aP53IluE1sYp8FwsEtznt76zc2P8BSCh5p82pG/7dkofLJdvmIo
 HuPb3oFqhgu9s138H1w1tHIS9c03WKnS0aCjas57aPx+/TNiK19crPoH4GmIfG77RQb3cWugxRL
 SyaHvCgS3EN1pW91WVyqmGg8ae4fuAPi9Y/7xnPJis23AuWuUnWIZJHC7iFhXgAZtgI7QdhrIZQ
 hrFymfAlQCT4L8Eba7SrxLQyEuEA1F4pk4gWLxV0VVUV9/ZY2iVWrKcOvyftuKT5F4eFH+DmJi1
 VFxg/yLstTCphkJVAvKmBDmfmZqd6ewGdDKNeZovWuiEkDCAaRoO00/1heRmPIPKeyMyN2lkahj
 DATRzKdBZIiqkBMGxfP3QtfLD638syZCNwsHzDeSEqZrxWu+tyZVZF9lHHf57lKBakjfn8I=
X-Received: by 2002:a05:6871:6aa:b0:430:12f7:71cd with SMTP id
 586e51a60fabf-434f65ab1e4mr8740323fac.23.1778253196090; 
 Fri, 08 May 2026 08:13:16 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:13:15 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:18 -0600
Subject: [PATCH v3 18/32] target/mips: add Octeon MTP2 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-18-bcbec96357d9@gmail.com>
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
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x32.google.com
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

MTP2 loads the high partial-product pair from rs/rt into P[2] and P[5].

This exposes the final guest-managed partial-product slot for the
three-limb Octeon multiplier operations.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MTP2 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d339e6d1b8..165cd5088f 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -47,6 +47,7 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 MTM0         011100 rs:5 rt:5 00000 00000 001000 &r2
 MTP0         011100 rs:5 rt:5 00000 00000 001001 &r2
 MTP1         011100 rs:5 rt:5 00000 00000 001010 &r2
+MTP2         011100 rs:5 rt:5 00000 00000 001011 &r2
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index ff02978898..809a4ae70c 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -293,3 +293,4 @@ TRANS(LDX,  trans_lx, MO_UQ);
 TRANS(MTM0, trans_mtm, 0);
 TRANS(MTP0, trans_mtp, 0);
 TRANS(MTP1, trans_mtp, 1);
+TRANS(MTP2, trans_mtp, 2);

-- 
2.54.0


