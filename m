Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96718606EEA0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=cOuiekl+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgtM-0003Ic-F2; Wed, 04 Nov 2026 14:43:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgtE-0002tY-8s
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:20 -0500
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgtB-0002VZ-Kr
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:20 -0500
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-36cad25b8b0so1632944eec.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821396; x=1794426196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N6SgaFV4LpKPN05QhfqTqgshBHVppExqak4hwdva5dU=;
 b=cOuiekl+rIfr4NvExKXWJ2o+wsMk7CUHc4jOy+zUNh5x0ybtmQc2h4J1s5+/nQTyWr
 wSXjRVUBi4Kglnt0DRr1Rc32XEPE3xtj1o09g/PDd6MEr/dovIlFbq++reiF0IZ6ntPx
 0ylzVRffh4SJgnAAZqK27CxOSML1KB7qj7Ww5ZcfcIG/ieWF9EcSIlbKTwq1o7AoNQ7v
 T+AyP/zcpVV2EZmiasCE7GKsma9oVNfUwMU4DNBxLmVYklADOBd44bEfmkMKrcZhiDjL
 ogNXsxWyb1NNrYUYhk+0GN5ZiAr3q01ekg6UOLxmSUenK10lzcw+Z3Pa5xovHei64/Q7
 SxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821396; x=1794426196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=N6SgaFV4LpKPN05QhfqTqgshBHVppExqak4hwdva5dU=;
 b=SXToooyf9EuoQ78yhQOeaEjUP/ZTam+eUdbjWXD6268xqYR9W3RY2+i9xDMNzjqG2q
 7nFcL9nmp7SiBr2TVwCTl/xRENVMzs35TgBKSgHTXVJjKahE6mSUZ9NccNk3vhgapPNI
 BeEqgrAEMI9+ldRgkw/ntrq0QuwEe510PLeG8GR04QDTqaokN9tXX2OZlD2JoShINPso
 w7E2e2ezHs1oKQZfb+emKiMGRjQIpDT4QFEMMe8cKjRKTydbblzL2mMTcihduGsxz9wk
 hgjJ22BjJZrKmEUeov5WT3hu3bnb9w0COAiG3vf3hxmooowQBJEKGp0yayEl7s+FPvqi
 uPJA==
X-Gm-Message-State: APuU4Z8XmXtLQQJcpRhtJFe9V1tPKUOFYi/G/fC920gI2Vnpx3hfKc3j
 EphobPetIAJ3MSicTi582Epnh+1fH4RNcSOaOH+bsoYz6un7wfEdgxcoK0Sgn6GqIAOM2RpGxQ4
 CgIny2iWGSByCNPDbKs7kFOptXLphC9MGhcg6goPxohZllmuAFggsMYrno72eYWrNUY1Slp4SLv
 ckneZQZl/p8F2Ay6mYdzHyyMEAHwMS3IahdOWQ+9uiFw==
X-Gm-Gg: AYBFou1aEAmnLPIxSD8K9Q3/YTDa72Z1gOnu71nKa7bJ+jty1UwRY0lR+DRjDW5Re8t
 5PEu9RnYsgmh+tkn1Nojj93+pVIWQelJ4PmkASFYFAJ97iHtHCRFz0c5DrfdZXg+de9lkPVbnB5
 hD6x7MtrUPET6f/CXrjSAia9ltWFd+6DckC7h9rFULTMJxXFLMyUUV/SFThgyRoqLwLVz3W1gYy
 oi+uxPdRAUDkJTl8pK0m5rTJqbOnexxklwbuExCFETdnbiATjnqTfxcT8l4Vl0SNZjrL/7Pue16
 bPK+G+oyI3Xsa3KfLUAzAen5az/guh/evs/J5hUf4UaymslWiAnyvdXEjD552SoEMhQShxtvDh+
 Ha0cRGMAuQSuVo0ovBNWWVt5FljBbpet+hm1G718ZGhjjHoPs7Lc8Fd0QuB9xP8SwtAdnPLydYm
 NCzA+olWIGNYxmWz4NjMeXBS6gLnCWdpCfjblCgzs7GHfgefmUjTMlpoIeJDVvi9fRtG2q5xkcM
 7geesWXJI7c1F3BQ2Mh2bg7xFGd/R/Jt0MsLXdpDc6viOL5H8IAbek9bB3c1aMEIgXhHFYZtKoB
 0vYtJKvMboqlFtInEApcdjGjcpp2uLr87qgzcpN1Gi9/tENCj3uc2f7hFGuSHS/B5T0nkEaP4iu
 go/E8KyQMPsy2J/t1/+rjvSmfbpoxsg==
X-Received: by 2002:a05:7301:715:b0:369:f41e:d2dd with SMTP id
 5a478bee46e88-36a4241b18amr24774869eec.31.1793821395942; 
 Wed, 04 Nov 2026 11:43:15 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:43:15 -0800 (PST)
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
Subject: [RFC PATCH 20/38] target/riscv: Add implied rules for Zvqwbdota8i
 extension
Date: Thu,  5 Nov 2026 03:41:35 +0800
Message-ID: <20261104194155.679241-21-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=max.chou@sifive.com; helo=mail-dy1-x1334.google.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add implied rules to enable the implied extensions of Zvqwbdota8i
extension recursively.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9271f79d1b6..26d5ac69c75 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2895,6 +2895,15 @@ static RISCVCPUImpliedExtsRule ZVFWDOTA16BF_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule ZVQWBDOTA8I_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvqwbdota8i),
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
@@ -3101,6 +3110,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZVKS_IMPLIED,
     &ZVKSC_IMPLIED,
     &ZVKSG_IMPLIED,
+    &ZVQWBDOTA8I_IMPLIED,
     &ZVQWDOTA16I_IMPLIED,
     &ZVQWDOTA8I_IMPLIED,
     &SHA_IMPLIED,
-- 
2.56.0


