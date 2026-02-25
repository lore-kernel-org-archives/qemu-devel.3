Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C89DFCEE81
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 11:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvClO-0007xE-Tr; Wed, 25 Feb 2026 06:09:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vvClN-0007wW-Bn
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:09:05 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vvClL-0003gz-U8
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:09:05 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2ad9f2ee29aso12480425ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 03:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772017742; x=1772622542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zGwKFeH5vaILGERB4AfQ4Ozm11H1PzIMpFkkBkAn/V0=;
 b=W2JIcvpHHDlH+1/1/zWp7+YafJNfDmC4eV4zZpVdRgVtCRCIT5aaSHFqUMwjYCXdVb
 RQyHvNPSXlu5o/qcEzNvediCVrNJGgI+QtDHgs1SI6PiPwJhMwjwq+Z99feldQ5o0rUp
 u5DgDD3b/K8nwBPN9Kmaq2v0GJxdpnxMuNsi/oHJt8U5z/fY5mlCWankPizdkBudOFM6
 QN+DCACBDIyLyvvWGm2+0NEYv8tzHb+3SfCgWgnjENQm8Zq9WTVX5FkvcGGmvotiBIx7
 3LLllKCkN43wphW3EvFfM6Rkxlb3AaAsPeLJhZGQwLa6ldinmjIQJ8JLZ+n+ZmS8JRH1
 VRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772017742; x=1772622542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zGwKFeH5vaILGERB4AfQ4Ozm11H1PzIMpFkkBkAn/V0=;
 b=BBLZteb84Nx7rIeG3t+xDX7ZUX8efVnWOxiT6t3Cz6ogLr0emVb8NdX7FwOfDZCQM7
 bacwtljZL+ai++g3kVGIQ1Ax3ZONYF03aNrAW1V+VPG/aoImaoHPTDeJwh/kkh3/yLRr
 pmOTkkoo/8AFI0H6iiWKKpnvtjOcno50uZxf/6w7UDTw9C6cN0jcoBYabVfEvzV8lJVf
 mBs8uCnTW9FyhMGyQK8Gq99N9gauQQKq2H31wJUjl2sC0/2QwPd1ZzyOtjDFVNbqqnFf
 Sl1MHJsTyDF+Z6QNGR4mxaih/2u72yZwJJDgqVG3Mz/8WlLzR/6Tl+uWaNhdUouj5LvC
 6a1A==
X-Gm-Message-State: AOJu0YwjTSMgPBPOsJ4NIQ7pwU6aUQMoFOJq5T+2qwjwP/VuPWB60lJI
 rMYViKfvctrGcsxlR81/JOKRVybLA/rX+feZ5cRX3VFhmIRq2atzDSeylfD82zqZu9O0HRPC9MR
 flML57cuqmZaZK/Yn9wcL7y5zkTa/sYeSSm2Agt/8JOAii+bmZCcNRISyO4IUR4xa1Rn7itPXiv
 VhT//ArblEYy9MDCKploa8MVIQDsB4DWtIPHzdag+tEZhp0vk=
X-Gm-Gg: ATEYQzxBXY7fTEHKcV1eNZ7mMtY1Kv2L2V/CGCgfZiIEEtAJgUjyxi8nPNaFz5FoOCm
 RXWzP4WgIS7srvAs6GEjd5QUl12VLjQYxM7NxKbCpZY9wJcNDQG+d7AUbubudYAsLJGavRL4878
 5yDVDz8mPZza/ojMdnKJvroy2F3lPkMHCDzY5bRG6JKknj/RB1JhjPBZhQZyJ6BCzpUTDN5dvM+
 h8EhYRPvc3061XtcpZgPODuMKsojibUfNGhx1alO4Gwsb3y2s0aELQ1+KUS9neYjrWZsroTzD6m
 3/2CYvDrlMIxAY27eYbpsdyw6W0RAO5tgSc8fxGDoU7uomeu5+udT0ryD0awvj78PDD0oKV54eC
 xDsGXbbqe0B4Cm6/8jI8hT92GXa8+CMx3Nd7r9Ipahfs8Xx0N9X7STlN0y4crR4rOZ/APZ900HS
 F2F/rWgGq9xAr5akpZVZIA1vxoNl4ESuho8kyBvDtgeOikJevWX7WRMm5ue1+i++JFGwXypO3wC
 jDABG5AHiVukfmDorjCrZRPjPQ=
X-Received: by 2002:a17:903:2ece:b0:2a7:63dd:349b with SMTP id
 d9443c01a7336-2ad7441b1c7mr152066225ad.10.1772017742085; 
 Wed, 25 Feb 2026 03:09:02 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad74e35133sm140452665ad.9.2026.02.25.03.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 03:09:01 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, Max Chou <max.chou@sifive.com>
Subject: [PATCH 3/3] fpu: Simplify OCP FP8 E4M3 NaN classification in
 parts_canonicalize
Date: Wed, 25 Feb 2026 19:08:02 +0800
Message-ID: <20260225110802.1217946-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225110802.1217946-1-max.chou@sifive.com>
References: <20260225110802.1217946-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x644.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The OCP FP8 E4M3 format has only a single NaN encoding (0x7F/0xFF),
Replace the indirect check via parts_is_snan_frac with a direct
check of no_signaling_nans to make the intent clearer.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 fpu/softfloat-parts.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 3c323c0cec..5ef7e2d921 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -245,8 +245,8 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
         case float_expmax_e4m3:
             if (p->frac_hi == 0b111) {
                 frac_shl(p, fmt->frac_shift);
-                p->cls = (parts_is_snan_frac(p->frac_hi, status)
-                          ? float_class_snan : float_class_qnan);
+                p->cls = no_signaling_nans(status) ? float_class_qnan :
+                                                     float_class_snan;
                 return;
             }
             /* otherwise normal */
-- 
2.52.0


