Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748E3CD3447
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 02:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLtgF-00069U-ND; Sat, 09 May 2026 22:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgB-00068I-Im
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:03 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgA-0002y9-1p
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:03 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-66f747175d8so1902578eaf.0
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 19:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778379241; x=1778984041; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vKRIKunBp1BcQ/wvFKLfVR8rprQQ5oAvC03+LhObVds=;
 b=lfI0dOjiIi/9HgwZaVksyeubWgpNP4e0r3u0BOi+nGPKVhuNL+8yi/SSCVo0mjPW8U
 bYXpKZW18qnFSxbxFRY32r45T5wbr5vYhyZyvDoRbMwZWjbKfj6AOVQDlTVLqLlBoeOo
 PSoMDeIDcocOSFzoDZ5lm3mfi3uss+yqwQhy9Wq2CKlocbkTan60CVOD/VtFRSU0QnVy
 1ppPnbQTRnMul6ljJIygRd8stVA+w3//JWiylDYJRZ4EMQ72v0Ij+HqFAWagLhYZVEjw
 ow8hNDAR6EyFhvjtZkTgcJPIxHk9pprXBZDQP+Ydbq3Ah4XMYzi/g2nb0zxrkdp4wigp
 OIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778379241; x=1778984041;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vKRIKunBp1BcQ/wvFKLfVR8rprQQ5oAvC03+LhObVds=;
 b=qPanMbisnGlSW8fkxnJsx7bpfyIdFuF20+xZkAXd6iWvGEoPb9OmiVIScejSlKU0LP
 aYyzfN3V16C///vvFN4mLNKSBMki4LDay8rCAYVppEw+PF6ApwsAmdtZaLGOjRx8FjMW
 M7rD7duo3qHo/fDnMuqFPmVj256DIcHCND3amFqpwVcbUuZlvFaWeSal7yH0GEH5IRsm
 LiV1dG/Hnbg2BcT4qtBvGPK74RU7gBTPbxqCbz4IyzlVCdBsqmbl9rQEyHwHZ0WJ+MCX
 0Ko8DMkiR49YnGhigg1PeCenUPVqgq90Tx7TZ8/Jab++0Xb0g2eRCLzmWOmGltCiVOvY
 Y04Q==
X-Gm-Message-State: AOJu0Yx84ZTHGjSXkV9R9VJ0tRLU65XtAs6bcwDoi4yxLcsJTJnwAsYr
 BauI1cTpREGHBYalyD6wISqwFxEQyq4r9UXlLMeBYyzA7mMIkuIBUl63jUl+2Z7B
X-Gm-Gg: Acq92OGvYEwObBn98NKE9/bvXmA/0Q7q/OnLboiAUR21NDZPH8YFONWr/qqR/5QsZ8/
 9rfc81ylyuSEaOKZyclhqO95fQ0+ZWrQQE5T3B2j3T+VJfFkF/Lliiql+L7QZHDPQNm6JBgD9C1
 HK6i6o2xuUslUpL8M33ZM9JEpqzfvkO3Kj/bTT49HU6nwLiGcsD5MP8JSIVnoRNnH0HWOvpMzdD
 nRhjrDQGuiiqYBNz4/qNba6+7aUZOTZdCaJWwtEt6PKtEhr/A4YlqyFQ1JocioWNrxWCIJ7h51y
 4lv8vGM7tBMVGkFB5pjLdVKaiJ1ad8igpW2Dmfg133FARCAyQ5R2dbXM45IHiyDUIQIdXIAvEPK
 Up57/MKZVlnxKaya4SwSJIne2GzZRIeAABPL1if2HUCn7K6VUgWdYFJ+QAh5lIOwToaMo1qN2G+
 lVFb3zx4uiQ3jxK0pMPA2pifCvPTHRwRsOuevZ99OeOTI/90FUthU6rUCxP4f2cR9pV5L94rB/0
 tkKg5SWf196deKMKyfKbHX+tJtisUgFetozW8B6cP4SVuZkgNeFPVYVKhvg4ODXXdch1bTxSTJE
 czI=
X-Received: by 2002:a05:6820:80cb:b0:696:6c93:e82c with SMTP id
 006d021491bc7-69998d34577mr10199972eaf.49.1778379240782; 
 Sat, 09 May 2026 19:14:00 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dbffdbsm3645643eaf.9.2026.05.09.19.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 19:14:00 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 09 May 2026 20:13:32 -0600
Subject: [PATCH v4 09/32] target/mips: add Octeon LHUX instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-mips-octeon-missing-insns-v2-v4-9-d669dcd05c2f@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc2d.google.com
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

LHUX performs an indexed unsigned halfword load from base + index and
zero-extends the result into rd.

Add the decode entry and reuse the common indexed-load translator with
MO_UW.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split LHUX out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index efb1a48b38..8a755075e8 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -48,6 +48,7 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
 LWX          011111 ..... ..... ..... 00000 001010 @lx
 LHX          011111 ..... ..... ..... 00100 001010 @lx
+LHUX         011111 ..... ..... ..... 10100 001010 @lx
 LBUX         011111 ..... ..... ..... 00110 001010 @lx
 LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index ecdce6ab9b..5a189c6484 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -164,5 +164,6 @@ static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
+TRANS(LHUX, trans_lx, MO_UW);
 TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LDX,  trans_lx, MO_UQ);

-- 
2.54.0


