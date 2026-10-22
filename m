Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02871606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VR3eRCix
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJz8J-0002zi-2Y; Thu, 22 Oct 2026 16:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJz7g-0002xU-0G
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:10:53 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJz7Z-0005rs-Ck
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:10:47 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a1e477fe16so1564505e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 13:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792699839; x=1793304639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iumkKdxbXinQWarJtWow+eRgQvhUYCIsnjsB/thj/6Q=;
 b=VR3eRCixaDGyYz1i1Txmq7pbEa0/RHKUP4ejhj07HKunwQCpmSY2nXnFF7oRkVWCkp
 0AOOur7bAD/J9iQOuVA0fRpv/HbwSV4dhG1dvCsEIDnw+fwI+duPMU/LtfpEy582Pi0Q
 gUlObXpypfjNSutesyodlrlckv2WeuXSRjQyLY0Ae7lFlL8swvaqhGKcys5D9c73cgSZ
 e8uMLyAqMAb1gRu3LUyZOPziRMaOdSHXRJvfdWfrDub+4C572JP+n8fs37noTO/gkgtd
 ToEC3lG0MDHdP16OV1bj4nGgRzsgDMyWEiruHrE703gFfKf5MfRLVjHNmj+8tO2T173f
 6sOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792699839; x=1793304639;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iumkKdxbXinQWarJtWow+eRgQvhUYCIsnjsB/thj/6Q=;
 b=oX2CyQeNI8E+ubO4+Cyr0y0dT0QzO7ItgHaDIRseL3l+UCFmKFaBnesX0xu0kT74+U
 mDchsTqCNRcsbILGse/crJZT50x7ppB9uwqfjpzsiTjiBwIpxuSzIGvUFnkSjdpx2Pwj
 w172QQ0Cdi6Hd+d1+4ZQCgbrY3v+H9re4DNXxnw+cLs9d8KO72bjxLI5e3gFSalMUc3R
 rGE+T/pmAszRAVIvZAHhprmeDyrJkLC5NqawT1vO0RRqP5Scf4fq3mDWKGQaIk8uTzaV
 k0f65sCC9TJtDx0iLBnj5gObJxT5tjQehkMi4yv/b2Wldi9b85kukILcEjgwCecHtuAE
 58MA==
X-Gm-Message-State: AFq9FYJQCVUZGZ5Wxv6M2Xo52i9Z4TbqlsWYp3rrzqMAY+pEHPlCEWOH
 isb/BHQVbRvrjZ8AS5vmSNb2oDIpOG9q0E39tESI/GQgdD73UgKwztx8+1aJcpa1BD9N6YtwmQR
 hYj0qDm4=
X-Gm-Gg: AYBFou2k3K6VGIBhJDLAGUhKifWteTLPUDcX2Yg9VfC5NHlpR5LnvWHr5R8QUmB68eE
 jyUpiDfIOGdwCUkL8n0iaCeL6GCx0+s68uCgHCNH/WeeNTLgf6Xidukry2v+NghQGGY1VWR/Xc1
 KhIBgRTaI4v2W/dDa9ouhqu9w4CHVs//Ttb+2jkuaXMCH2yyccDzpI8WYeTU188LiJrlUSm/lRo
 hPGf7NveBgOzSE1olE0NZiXPWbejPI7bRs9oKTFFUPuNOlMWZdr9xF7SSeGSqmlRqheksSYJy9C
 380GPCx5LxItGd7s4F3nlzGFR9wgalmihgFb8d1cRSYXKvuuAfpjzuTKceoT3BCsV0RPop1Rk9x
 NGtbLZfM62puKBl5NH9kNMkiLw4qWaFbiUpYjiYYjGSbYHDpKeiRG853EyLr6dF8YvA6ef1P+6p
 cvmqSFyUc9buwaUu9qV1nM570Cs7Y6DHRGaUGpPh9ISdz7ViK1PN2/9ccPxzcISrvsdmpbSsYSE
 27ILNaOZKlw2szf+Bt4oZ96G+G4BmO800eSJT6qT/GFBrqO6saJWCb4sf91+H8Idpo4lPmmqZuw
 8e+3ai4P3pOtzqcstJpoFA+kM2RDfqTNinqrCQEiIM/scEisBFvsTWwRvwFi
X-Received: by 2002:a05:600c:1910:b0:4a1:fc66:b62b with SMTP id
 5b1f17b1804b1-4a211ede211mr2573495e9.35.1792699839433; 
 Thu, 22 Oct 2026 13:10:39 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a21226047fsm603875e9.4.2026.10.22.13.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 13:10:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH] target/riscv: Use 1ULL for a value we're going to shift by 63
Date: Thu, 22 Oct 2026 21:10:37 +0100
Message-ID: <20261022201037.764619-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In prop_marchid_set() we set mxlen to either 32 or 64, and then
calculate
 invalid_val = 1LL << (mxlen - 1);

which shifts the signed value 1LL up into its sign bit when mxlen is
64, which Coverity complains about.

This is not UB for QEMU because we use -fwrapv, but it makes more
sense to use an explicitly unsigned 1ULL here when we clearly want to
be treating it as an unsigned value and the 'invalid_val' variable is
of type uint64_t.

Resolves: Coverity CID 1547552
Fixes: d6a427e2c0b24 ("target/riscv/cpu.c: restrict 'marchid' value")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 08a4d14ea1f..d47a69bea7d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2298,7 +2298,7 @@ static void prop_marchid_set(Object *obj, Visitor *v, const char *name,
         g_assert_not_reached();
     }
 
-    invalid_val = 1LL << (mxlen - 1);
+    invalid_val = 1ULL << (mxlen - 1);
 
     if (value == invalid_val) {
         error_setg(errp, "Unable to set marchid with MSB (%u) bit set "
-- 
2.43.0


