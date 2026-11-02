Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22FF606A327
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ldeH1o2R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsDK-0003Zz-Oh; Mon, 02 Nov 2026 08:36:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsD0-0003DD-Q9
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:24 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCy-0002IE-OE
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:22 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a2084d62cdso26742405e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626579; x=1794231379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8AjgkbFsVI/r17ygHTxocPjLF130NnWkN4UcAhp4aFo=;
 b=ldeH1o2R5ns2ej6q0VRq+GR6N0/KtvJUtFvxFiAfSRSyCh4lVQXZ2SsP18ao8EVY3W
 50tnCNRv1OG5kHWGgoqZj5vcQUmhg/+0Bl3dNf6ySNImdXiK8VaTe/EnRT32HEi1mIeF
 rF8ze+fEOtW5JM+65bKSip22tNNtS9WGhfx9KKrHtkkXwx+mKzvlvTrDLdBwigHA/V1x
 66G5jmCN+CcyR6TSigYg0DXrg0kMlSoFL1Rjra2rV115/e5k/21pKaEZBockFRM7BIzm
 +DavxfNnNLWa+tMzcvhv+/tu3EO1GSw1s5eOVr+Q4E/Q840XuJ3kJ84yWq7nHgj9Zpxm
 ilbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626579; x=1794231379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8AjgkbFsVI/r17ygHTxocPjLF130NnWkN4UcAhp4aFo=;
 b=UcxmLNEL55rs9YqLumC5aKEu1XzlCF9zgi2r1nfgOHM+tb9pt8/vd6vszsDOmtf9Y3
 /v+xgUpxJH62S85al33/tEFjSa6SJMQqMBTRUqAl8KD3Bzk1sPzk6Yx/V88Q8Y3DuNL/
 Pui9ZvWLNinRf97Od5KP0TT4OkmFUVnjHK5I50pVC2BfmzACTSoELPFqNjx3osEZdqnf
 iofA6JHzr1xIPAdVMu9dVlnTjw2xA180PU2z/yUqfeTUZ/4waV9fuOwSynn73HWq3rTL
 T5xwyhAWWtsAE8yCG9SiacTE+iUxCU7rUhN6YnK2p5P8WDSRFCcqvikk2N9qyJtlmM76
 byKA==
X-Gm-Message-State: AFq9FYJ6VAfKN09LFwyFdypZnhHMwMLE6JUKOoT+i0vy6w8IS7MxF/GN
 pG4DLmvakiGm6139Igf4HUFzq7CG0jPaQ7TVYQ7quoXOQHyVPgOlN+0cdkrNMIB1YNDC2S4Wf1q
 fpKYgSZc=
X-Gm-Gg: AYBFou0Le2BA0z5bOZNFcRL+CwAJU8lVPWxWh/s7DDJRl4BzcAX1x9vrWHC/KA2Shen
 YwEAI6sub7EqRRv2LcbsbybleYhnnqv5pr9ZyXKsLvheUDT6BqhcsMqseu5+veq+SQXheTALQKy
 q/hpn0EOQJdx6U8sekZ1xJcqIViaa//EKmgL/qesdr98WxXYC5SZDGk7MxT1ECpaUKQVS2DVF2k
 +6UECqgnoJbTwUs+HTfkJUqCBUkJwDr7GhvJbHPrXZdTR0BJreSTO46rXWgy9P3wxl7R/6xFfzN
 VgiLNQm5xNQmWVDfd4uZ4bGdyH2+V6dEXnkV7KmEPoBesnrfSBo/1HWsIIMk/c9D6jaXWf9nc1g
 EFYYU4pqyrzxYoeZLI50E8qWTcKjWR+H9rEnWo6Z4d6j0T1LZObldS2K2FEUWW1fA6EsYLLmlFJ
 gKJtcjdJxyMMims2VTdhX15YOIeeapkGLoJb9njRlPGBNdKPLx0Y8lPhAoHyNF3oGflnDvtZAD/
 zFJyG60D29Bi/8KDh8hS9Q66keXhlnCTN/s4q28UAq/D71IahxXya3YMXAERaNSQjMI9hEdSTdT
 eHPnhGau07M1dED6r/WfAplmdH7/MH/+aefw8OuKfvVaFMS577l25S3+sAJ7qg2PmjYQioO2Nob
 K+WcneL8jiVrw9COp7/p5ZhTq39KJtH8Ptg==
X-Received: by 2002:a05:600c:1f87:b0:4a1:f68a:9736 with SMTP id
 5b1f17b1804b1-4ac17b2be08mr232409685e9.26.1793626579246; 
 Mon, 02 Nov 2026 05:36:19 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/47] target/arm/cpu-sysregs.h.inc: Sort by name alphabetical
 order
Date: Mon,  2 Nov 2026 13:35:26 +0000
Message-ID: <20261102133547.1375701-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Eric Auger <eric.auger@redhat.com>

Sort by register name alphabetical order. This will allow to
easily diff with the future content, automatically generated.

No functional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Khushit Shah <khushit.shah@nutanix.com>
Message-id: 20261030131406.461599-2-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-sysregs.h.inc | 46 ++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index d9e058a57e5..b5c79709719 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -1,13 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-DEF(ID_AA64PFR0_EL1, 3, 0, 0, 4, 0)
-DEF(ID_AA64PFR1_EL1, 3, 0, 0, 4, 1)
-DEF(ID_AA64PFR2_EL1, 3, 0, 0, 4, 2)
-DEF(ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
-DEF(ID_AA64FPFR0_EL1, 3, 0, 0, 4, 7)
-DEF(ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
-DEF(ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
+DEF_MUX(CCSIDR_EL1, 3, 1, 0, 0, 0, 16)
+DEF(CLIDR_EL1, 3, 1, 0, 0, 1)
+DEF(CTR_EL0, 3, 3, 0, 0, 1)
+DEF(DCZID_EL0, 3, 3, 0, 0, 7)
 DEF(ID_AA64AFR0_EL1, 3, 0, 0, 5, 4)
 DEF(ID_AA64AFR1_EL1, 3, 0, 0, 5, 5)
+DEF(ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
+DEF(ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
+DEF(ID_AA64FPFR0_EL1, 3, 0, 0, 4, 7)
 DEF(ID_AA64ISAR0_EL1, 3, 0, 0, 6, 0)
 DEF(ID_AA64ISAR1_EL1, 3, 0, 0, 6, 1)
 DEF(ID_AA64ISAR2_EL1, 3, 0, 0, 6, 2)
@@ -17,30 +17,30 @@ DEF(ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
 DEF(ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)
 DEF(ID_AA64MMFR3_EL1, 3, 0, 0, 7, 3)
 DEF(ID_AA64MMFR4_EL1, 3, 0, 0, 7, 4)
-DEF(ID_PFR0_EL1, 3, 0, 0, 1, 0)
-DEF(ID_PFR1_EL1, 3, 0, 0, 1, 1)
-DEF(ID_DFR0_EL1, 3, 0, 0, 1, 2)
+DEF(ID_AA64PFR0_EL1, 3, 0, 0, 4, 0)
+DEF(ID_AA64PFR1_EL1, 3, 0, 0, 4, 1)
+DEF(ID_AA64PFR2_EL1, 3, 0, 0, 4, 2)
+DEF(ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
+DEF(ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
 DEF(ID_AFR0_EL1, 3, 0, 0, 1, 3)
-DEF(ID_MMFR0_EL1, 3, 0, 0, 1, 4)
-DEF(ID_MMFR1_EL1, 3, 0, 0, 1, 5)
-DEF(ID_MMFR2_EL1, 3, 0, 0, 1, 6)
-DEF(ID_MMFR3_EL1, 3, 0, 0, 1, 7)
+DEF(ID_DFR0_EL1, 3, 0, 0, 1, 2)
+DEF(ID_DFR1_EL1, 3, 0, 0, 3, 5)
 DEF(ID_ISAR0_EL1, 3, 0, 0, 2, 0)
 DEF(ID_ISAR1_EL1, 3, 0, 0, 2, 1)
 DEF(ID_ISAR2_EL1, 3, 0, 0, 2, 2)
 DEF(ID_ISAR3_EL1, 3, 0, 0, 2, 3)
 DEF(ID_ISAR4_EL1, 3, 0, 0, 2, 4)
 DEF(ID_ISAR5_EL1, 3, 0, 0, 2, 5)
-DEF(ID_MMFR4_EL1, 3, 0, 0, 2, 6)
 DEF(ID_ISAR6_EL1, 3, 0, 0, 2, 7)
+DEF(ID_MMFR0_EL1, 3, 0, 0, 1, 4)
+DEF(ID_MMFR1_EL1, 3, 0, 0, 1, 5)
+DEF(ID_MMFR2_EL1, 3, 0, 0, 1, 6)
+DEF(ID_MMFR3_EL1, 3, 0, 0, 1, 7)
+DEF(ID_MMFR4_EL1, 3, 0, 0, 2, 6)
+DEF(ID_MMFR5_EL1, 3, 0, 0, 3, 6)
+DEF(ID_PFR0_EL1, 3, 0, 0, 1, 0)
+DEF(ID_PFR1_EL1, 3, 0, 0, 1, 1)
+DEF(ID_PFR2_EL1, 3, 0, 0, 3, 4)
 DEF(MVFR0_EL1, 3, 0, 0, 3, 0)
 DEF(MVFR1_EL1, 3, 0, 0, 3, 1)
 DEF(MVFR2_EL1, 3, 0, 0, 3, 2)
-DEF(ID_PFR2_EL1, 3, 0, 0, 3, 4)
-DEF(ID_DFR1_EL1, 3, 0, 0, 3, 5)
-DEF(ID_MMFR5_EL1, 3, 0, 0, 3, 6)
-DEF_MUX(CCSIDR_EL1, 3, 1, 0, 0, 0, 16)
-DEF(CLIDR_EL1, 3, 1, 0, 0, 1)
-DEF(ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
-DEF(CTR_EL0, 3, 3, 0, 0, 1)
-DEF(DCZID_EL0, 3, 3, 0, 0, 7)
-- 
2.43.0


