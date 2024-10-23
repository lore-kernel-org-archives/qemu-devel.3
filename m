Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA70D2E00A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 03:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3S9S-0007Om-Bf; Tue, 22 Oct 2024 23:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S98-00070i-Bp
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:56 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S92-0008MU-Sc
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:54 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71eb1d0e3c2so2914628b3a.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729654486; x=1730259286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wgfe8eEx0DyNMgpV+RxevSprfVFpnEpDRbWriLdWhhM=;
 b=zVk9yVz4v6sPUgy8iI5zYfP5fBmYo8DBG/vwo1xLEclmPocPLSpy4QLxUOiR1qcqzM
 bEyd85Ujc+YuQe8fqyhHhdiwBNxL1HRNMBCURUXWe7uHpULEXp/pgJWJJHTDlxMczNg1
 9yk/1bpfqOnHQ+i9/pxPxS5lWyL3dRaTNO3LQ6AdjM2jSngAyC0DvPrszHLxTmYq1eqr
 d9tYfItZVtdXZCIHPb1q8DjTV7yzlcSRix9lcBZ0bFPSpAf4Pbo7LuRD7Ozih2gDDRrI
 pKhT5U2//d9JsfHPxsy7lrotsYArEVFC8SR5qRsNltplblzsbnp0yPYEnegOBG1gwUIR
 /AQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729654486; x=1730259286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wgfe8eEx0DyNMgpV+RxevSprfVFpnEpDRbWriLdWhhM=;
 b=jsLfgO27RXF8HsEFZdpqBqyeVx6inbNJyp4jYrvP3xXvSafYHP2I8qhxfDZGiRmxi/
 Kj21OLKRJyMjM0/1oAnLnllF75vSb7RbSNaFSaM4w6c+vX2FDJ3D+L0dJYF8dexeYLBi
 Kmf6lBLnRjmmg+7eVGbJ85JzT7iEOipERWsM+3SVN/uVnlh+QeibEI3VQDx+leOVAcur
 OYkQVSNw1fCvAsXj/YkFatuXyhlDjeP02NFWemb6Cj0uBIScJdqFP3HZIBtxRwsv5vIt
 pq1qVh56ok5ipphJKWeUJVwNa6IOJr9yzu/TXfFTMib2YWVg8H/XQ/otdAzEk0B71AOQ
 LCmw==
X-Gm-Message-State: AOJu0Yw3JBhWVr8Gp4hIspfQ1GF3RN/uYbGFqlr5hQKrGAZd2os8RltP
 +TJXYlaE+FoXbyZ7WLf6vBG9msKNZ2IOrmYRu9VOJ9sqwQGQTZ3izHfm1Q/E0uQuO+Qffj6Y3q7
 N
X-Google-Smtp-Source: AGHT+IG/lmlLGaI+y5DPzANv/9T2nVNOSsuWnTGuVilfd06AtVYZcfKuBc9tOW/rQYd5iecRLhT8EQ==
X-Received: by 2002:a05:6a00:4fd3:b0:71e:3b51:e856 with SMTP id
 d2e1a72fcca58-72030b715d2mr2036263b3a.1.1729654485614; 
 Tue, 22 Oct 2024 20:34:45 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d73b1sm5438338b3a.105.2024.10.22.20.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 20:34:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Dani Szebenyi <szedani@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 15/24] tcg/ppc: Fix tcg_out_rlw_rc
Date: Tue, 22 Oct 2024 20:34:23 -0700
Message-ID: <20241023033432.1353830-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023033432.1353830-1-richard.henderson@linaro.org>
References: <20241023033432.1353830-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

From: Dani Szebenyi <szedani@linux.ibm.com>

The TCG IR sequence:

  mov_i32 tmp97,$0xc4240000             dead: 1  pref=0xffffffff
  mov_i32 tmp98,$0x0                    pref=0xffffffff
  rotr_i32 tmp97,tmp97,tmp98            dead: 1 2  pref=0xffffffff

was translated to `slwi r15, r14, 0` instead of `slwi r14, r14, 0`
due to SH field overflow.  SH field is 5 bits, and tcg_out_rlw is called
in some situations with `32-n`, when `n` is 0 it results in an overflow
to RA field.

This commit prevents overflow of that field and adds debug assertions
for the other fields

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Dani Szebenyi <szedani@linux.ibm.com>
Message-ID: <20241022133535.69351-2-szedani@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 223f079524..9a11c26fd3 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -911,7 +911,9 @@ static void tcg_out_rld(TCGContext *s, int op, TCGReg ra, TCGReg rs,
 static void tcg_out_rlw_rc(TCGContext *s, int op, TCGReg ra, TCGReg rs,
                            int sh, int mb, int me, bool rc)
 {
-    tcg_out32(s, op | RA(ra) | RS(rs) | SH(sh) | MB(mb) | ME(me) | rc);
+    tcg_debug_assert((mb & 0x1f) == mb);
+    tcg_debug_assert((me & 0x1f) == me);
+    tcg_out32(s, op | RA(ra) | RS(rs) | SH(sh & 0x1f) | MB(mb) | ME(me) | rc);
 }
 
 static void tcg_out_rlw(TCGContext *s, int op, TCGReg ra, TCGReg rs,
-- 
2.43.0


