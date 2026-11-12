Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924E7606A330
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XwuXaf10
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRRGI-0007hE-7M; Thu, 12 Nov 2026 04:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRRGH-0007gy-AP
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 04:38:29 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRRGF-0003Mq-QB
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 04:38:29 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-490a0e72588so2226827f8f.3
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 01:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794476306; x=1795081106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bEMscnaGn9bAFFmYUy0wam7T3sR3vv8Hkj+qUG7MmWc=;
 b=XwuXaf10PHOW4KxgZUnj8b2+jf0hdFcMnEb4X2/WWun9L9JU/wvrKB2y4Ch+l6xR/c
 MPtsLzXYH2enpFV03q3kFpJMtIXT7ueSstaV+6kqpEYC8PwOgFuRu+hc7JioDl2+GvzB
 Jm/iZ968BuA81l+BgzEED/fKE/U65uksPDquPAdkmL8+GRnVJKB2aPaI8vWquQc0k8LT
 JT4pi4+p41Zq5eyicFMFYQc95SgiOhK01SG0YMq5H/nUerp708F6CEolyEoHwg8BOw55
 DsjNwhDZ7KZfsnobTgGoe1Ziib6HfBjBwop+buQQ8JL63OztfChe95dLmTAhHjk/Qe44
 HTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794476306; x=1795081106;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bEMscnaGn9bAFFmYUy0wam7T3sR3vv8Hkj+qUG7MmWc=;
 b=Hf/BRcLhc+YnFkSBxObst4sVLnvHTvUYXVzUtgAVCIyS/17A7GR9A34v++LS0bgEK0
 5/HG1/MlyAaKZbkuwVWiWWcbAIV7qI5kPegNV1O+lIksnxruX/Ij6u6FWZ8sF0M13O36
 ca/cAPPrIXk07g2kzfz/c/aM/uGFa9QU1lS7APjA0Z8xexIRqDKSDqGxacVq2/6LMKM0
 EQGzW75qRkaJ+I3IcdejolySySynBMNmRpHkC7KEPgcmgikhSS+PxZL8tMTxvJ0oR1iB
 +h1BM90jjeKJpCyMcUhD7J3tDpHfp0JQD5y0af97FqyPvf3lRZHVkepPowDqaKdTcjYK
 xWRg==
X-Gm-Message-State: APuU4Z8D0995/R1cIbklJmixs+LlljgGPGLu/D7IGWLc3lFaD6LlCtJa
 pHpePDkkyxTOu55rJHnY07URKVeCNmNVQn3jBOy9L+wjFaE3Iv4eygRVW28fYZW+TH7ufmif8yj
 8emyLTN4=
X-Gm-Gg: AYBFou1VwPOmmGy67/KpeezP05Un9KF38RfiCOz90+mVSPVmn/2T2pDrL82Bcs0f3OW
 2LSc2qEdNZhjrFW+kPWhSIqHUZYZlAJ7xgn68ZeL22COh7AlC+eLTZOYtuhTUwuGwszoSBzOpY5
 70RPAuXuQiRO6r5ZRdRqebat8MNQImDNH4V4jYVvORglPfH+6m5Wu6thTD7nZjprxpXOUIl+gua
 ng1H2jNCJENvnJ4XYQ5FYVLqCfZ9v37z1OaiCDoCHfEZzMvJJO+DWCnbVdNg6w7BZyYetowBpAd
 p2AYbyXxZp8JbCeExL8S/ZocadVMb5atdDVmXlDDszPUYgT2G8Asa0Zccwmm25CE3yJPxotkkiO
 BC8PR/SgjNVPvFiMEFMx9y/9UGJAgr32g6en5COhLmz/UJSOwp/VCVGWN/FVlETYdyU+kfnHVj4
 lWHaxIKBJeFlpQYLp75Nksi+xsm7WVO5QOtsDHVP0teG5wh8oKRtRgmkJWF5Dw9H4yCjJj+SRh+
 4p9GspRYu5uExscakUnkOGrn1NVSVGa9tLEIivOAdQJvRQ1FjTg8TBCxHsCU4s6w0I9eayouhda
 ImYGt8vRMCphm2QnxpuGaAYQ/89+ckvLEjrxSy2yA2iBpnHJaso9/8B64ljCdnt6ANAMzYoDSaI
 RjG7j/4zk5ET/Ihy1+cKN7OLYFztHNnOWkL8=
X-Received: by 2002:a05:6000:4816:b0:490:2033:1477 with SMTP id
 ffacd0b85a97d-499c9134147mr7435927f8f.56.1794476306050; 
 Thu, 12 Nov 2026 01:38:26 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983585923bsm16189279f8f.11.2026.11.12.01.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 01:38:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH for-11.2 0/2] docs/about/deprecated: minor fixes
Date: Thu, 12 Nov 2026 09:38:22 +0000
Message-ID: <20261112093824.2281467-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We (I :-)) forgot to put in the "since 11.0" tag when deprecating
linux-user arm OABI/NWFPE; patch 1 adds that. Patch 2 fixes a
"wrong kind of underline" formatting mistake I noticed while
fixing that.

thanks
-- PMM

Peter Maydell (2):
  docs/about/deprecated: Add missing "since" marker for OABI/NWFPE
  docs/about/deprecated: Fix heading level for AF_ALG heading

 docs/about/deprecated.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.43.0


