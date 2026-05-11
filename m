Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C598CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVI7-0005O7-Dw; Mon, 11 May 2026 14:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHc-0004lK-Uq
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:14 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHb-0002tQ-F7
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:12 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dca00c1591so1572353a34.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523790; x=1779128590; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ulZT3AyR9KxLxXeHp9mtF2udKofNN1JfLOpr3f1NM0c=;
 b=Jc9td46aeoYk0Qckgb9BNYCcj4x14tEkL8Sa0aAaYSp8je4HCOMPssoSgJMzzQIJPP
 +xPvxQfqDspP2E2HBhMHpk2IdFPvFsR/45xAAeuYqsvBMTm4zWJlaVhQYSZgqEDjATZ4
 r7mQT8jivwh9JMxpP/7pKNg9C9BilJaLwTN3GC09p6jDpBq/Ip/VQU2ykrNRgcjCTDec
 89ebM7TIQxY2ZsqITKEABVFCOtDH5hI54B4dfnh66FQclSPd9sLiBHGMVXAm0PwwCf/7
 8h3vnwMjZUa+BWJUEdeeKlBL+vB+aAfQyvSG0VVzXwz5jw5nFYkmEJdlnp/USapHHbLn
 u9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523790; x=1779128590;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ulZT3AyR9KxLxXeHp9mtF2udKofNN1JfLOpr3f1NM0c=;
 b=Bd8SNdoVEefB0Tow8Nqj6EAvoBDpjJmlrhszcIm3sDCUStsejG+ZHceEmHNUpFbySH
 sKbpShm44FC9wjLC/ztaQaWJJaIEM5ZHaMV/iSEhb01C1SNcWt8ounyu01v45gMdjRX/
 htePaLlOOsHLVcxD011Sv/jbb8ulSelrih1/+mGIuflsRrD0R1l7VzTnf1+dEw5wynou
 HlSOmFHYZ8rxm7lxayDHGMe2ci3i9TnFwcHqg7Py+JJza8CyDvyRRg7d774w0MPFjACV
 Fk5u5nHxa3x/35Nqmt8gBapfQxNAATsr6Y6EzXYsTuXaMgWiWIOKLzg5y0tcQVZFgmQ2
 emLQ==
X-Gm-Message-State: AOJu0YyKMZoCsUOWGyiDWiaD+6xLFjqCt6OsSFAxgrMEg65JXuC5yFPV
 gT++P74L2yevUQasB8drl/lodNpLmhiWIXaQRcwbkYuARuZTXTrES5Ez
X-Gm-Gg: Acq92OHSR4WlBckWRbbyrVEqF7091UEec6CKEM59C3Aqruc80SckGvlfbG5jhbkDp59
 +jbYhGimckqynz09aXdvwvVSDYkt0cc1/Uvabful2AJerSRz5/6v+13YfS3VzJ+OhJ9t/XveSvS
 YiQ8322hi2wpolvWV17AWFQ97on80dowzfvYwCbZ0+0o7oFrYHEr+9IJE0MPl5t3d0E39ZA+kUM
 RdvShlaDyl/DnPGw/ak0mFRQcs456XGm7Ik3pFOVEjyP+AoWLe/nq76pLzJGDAw5h8eFKdecXrz
 6ejxGWICa263sRmy2CpXqEidzDoFywj42x7uhfeqKywRYEnBQDeuFAHEbZ/3DoaaOshLLqOA1Mk
 QqBuc57htA8IfWH8D7hHSuG2nwtPyRcPTp65muq6WIJFdOXycXQ5+Yk+eb4PcMxmEQMNUI/sN1+
 ylBWAzvCJR48JbvtehXe+w9MJvfL0rKJ46pIDfToZVuYwxx7r69pPxlbOqvJvJxwWQ+srQuChOz
 /QRZW0ENrjzs5oAa2E9TvP24PAH0WDSMQw30yKaUCRyL1KZPgkuTbNxLuatPwIH1uX3
X-Received: by 2002:a05:6830:82cf:b0:7dc:e6e8:62b with SMTP id
 46e09a7af769-7e1defeb3b2mr16842077a34.13.1778523790155; 
 Mon, 11 May 2026 11:23:10 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:23:09 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:22:51 -0600
Subject: [PATCH v6 20/35] target/mips: add Octeon MTM2 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-20-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x331.google.com
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

MTM2 loads the high Octeon3 multiplier operand pair from rs/rt into
MPL[2] and MPL[5].

This supplies the final operand pair consumed by the V3MULU multiplier
helper.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MTM2 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Describe the Octeon3 rs/rt MPL[2]/MPL[5] pair handled by the shared
    MTM translator.
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index c85199ae32..682473b011 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -49,6 +49,7 @@ MTP0         011100 rs:5 rt:5 00000 00000 001001 &r2
 MTP1         011100 rs:5 rt:5 00000 00000 001010 &r2
 MTP2         011100 rs:5 rt:5 00000 00000 001011 &r2
 MTM1         011100 rs:5 rt:5 00000 00000 001100 &r2
+MTM2         011100 rs:5 rt:5 00000 00000 001101 &r2
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index c9ea72d832..86b384d312 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -292,6 +292,7 @@ TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
 TRANS(MTM0, trans_mtm, 0);
 TRANS(MTM1, trans_mtm, 1);
+TRANS(MTM2, trans_mtm, 2);
 TRANS(MTP0, trans_mtp, 0);
 TRANS(MTP1, trans_mtp, 1);
 TRANS(MTP2, trans_mtp, 2);

-- 
2.54.0


