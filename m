Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE9F606AB3E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=MUWntwdJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgt4-0002ir-9G; Wed, 04 Nov 2026 14:43:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgsY-0002GY-3h
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:42:39 -0500
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgsV-0002Ki-Uo
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:42:37 -0500
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-3514b90bb89so2069079eec.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821353; x=1794426153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r0F7wiKG9LD1+Wdy0dzzhVEva/0PrXC8srYHsHCOBis=;
 b=MUWntwdJLamvdn39MAWe8/fObRs8TuFm7DXiMBKklhGKy/KshBRF85qvnO3vjArKS3
 PtgQyTWGWvDsQ9MX2LEMVByYK0MJOtxowGwlALcHPOz3IIUX4BFpBfz3Zvl9ZOcA9Yxs
 u8qLqwL43pb3PWNUR1sKniwRGpcp5/CXYXNRL+FcJeQLY2RwyVpSMyCn7KnIplrnsuF4
 prmsy1RNVy4xuI75yxzgBeLdYVDhcdvHTNaKL8aTIyhNDk6V7ft58oDYuqGxm/mLzAb9
 wPba0LXZgW4Bu6EjJtLljo5FgwBuXHrHRshKSqv4NGhlC6wH1RRLoLF0HwreF49UeP+l
 P0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821353; x=1794426153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=r0F7wiKG9LD1+Wdy0dzzhVEva/0PrXC8srYHsHCOBis=;
 b=AL5bqI4brNskIq2H0YJpGTS8q6LgygCEa5HN4+XbgkfkP9eGIzLXn2Elqo5oAMC+kh
 ltaUvJn1MrY5WMw78zUbjZUf0DGcJqU/tFtJPkebBEza/QLslIX+SsTaRx0CAs0ElAZ9
 vnFmhiiu+KQDiT0b3SjZSWiuyqCZgLR2QCvTxldRPqWmnrX3tzrDAsx10ZXvo6PGREPZ
 Yh04Cfj5JQ3jHOXUU3prHOgaL+HNkdjtFfnOW5chPrqpkDPUvDpI/0mg1aSemhKtCvVd
 Kwu/Psb1OqZJ4wM6liNPmvkrM0/80bN14Nvx+Z3STTIQ6RMmAaBN6s1Ie9K4f8253Duk
 xcPA==
X-Gm-Message-State: APuU4Z/21bXSX0kV+mXXXC+StemUO/SJ/c7A2I85tpZL1M6YyLSNbYPE
 OlWMwMh8BlHrDk4dck80tLvAjUkAYTiwPiBCpAa8WeoWaIM0kZuMu+34Uwwn9BOdyhVYiJ9lwwu
 D7mjjzPgN2Pgi/ATc4vUDUdt52IQLD3dgEEpGgX1mzYjKX9K9pbOSLaChJHTxdPpnWKwyYrdcgB
 NzUBp+14WSZl/MtdX1yEm9+fZ4goqX7LTBa1EaP7gWfA==
X-Gm-Gg: AYBFou25y8MeVb11mah36wLAFtZ8FFBwLrI5ADHWMVYr68mW24QE7ag3RWRV/CcRm2p
 D0smpUo77kKFhHkSUyKu+rlmaVmvmo6hqsV8ImDBwf8yTzMkFKj9vbfgINgQQvWOVvdjS1cVHzW
 1UVLqb5ElEXyOdnSTaCXBa+o9KjrTqRnkqtmiqXWRPcZjgrGxkw2Ckv2ukvDCTNzIXkMLd6drby
 WTBnnIoH72rm/ji+ZDn64vdFg/H5LIkea8qVZco/kABkTstjGhpEl67keMx+29Cu7CvmpYMoAwA
 9JXMQdRf9cM2NZ5zby0Yq3reG3KN2I/S65vaZzPCC5UMfEA6AZp03ybH8Upe9CshzZqQQ/jMe4M
 dlMdKKWXvMjzAnXoe1vLsFvI5B8lEDNCxvTNA/rnWPWCONFzRiHbDbNWROUuYXeBq1YMMSP7SrG
 Kdu67HOu74zX4dEKNsCQgA1wELRF9UVMaVzZKbRAbwtMHMge33bW1N/4zX+L3BHZDNms0BDoC3W
 FZgEg4/edL/0D3CNaFe0sZffpxiI0m0pTpGfio0MiUXupuFXYtnBfsRxA8RewQMrrUyJvXF+ays
 jU6UWiKgtK+zFp9grwtkJ2Wpejqn+HwOdv5g8Toz9oe8oF6hIahYxdEapm4jQPE6A33cMJ7whHR
 7jRiYZ/W01psyDW6hrqU9xMm4G1dF
X-Received: by 2002:a05:693c:4152:20b0:36a:1807:75a4 with SMTP id
 5a478bee46e88-36a423cacb4mr28913198eec.20.1793821352192; 
 Wed, 04 Nov 2026 11:42:32 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:42:31 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC PATCH 05/38] target/riscv: Add implied rules for Zvqwdota8i
 extension
Date: Thu,  5 Nov 2026 03:41:20 +0800
Message-ID: <20261104194155.679241-6-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=max.chou@sifive.com; helo=mail-dy1-x1330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add implied rules to enable the implied extensions of Zvqwdota8i
extension.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 96a1d76c5a2..08b14782451 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2851,6 +2851,15 @@ static RISCVCPUImpliedExtsRule ZVFHMIN_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule ZVQWDOTA8I_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvqwdota8i),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32x),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule ZVKN_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zvkn),
     .implied_multi_exts = {
@@ -3055,6 +3064,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZVKS_IMPLIED,
     &ZVKSC_IMPLIED,
     &ZVKSG_IMPLIED,
+    &ZVQWDOTA8I_IMPLIED,
     &SHA_IMPLIED,
     &SSCFG_IMPLIED,
     &SUPM_IMPLIED,
-- 
2.56.0


