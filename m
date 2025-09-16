Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E526DCAC5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya4V-00034x-Pj; Tue, 16 Sep 2025 14:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4S-000330-JD
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:28 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4Q-0001aH-G4
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:28 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3dae49b117bso4502257f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758045985; x=1758650785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1afiKA5WXH75zos913UixLbC9rUVw+fEq1nhaCLbfzY=;
 b=ElvpNaZKw4zElsHb85YYe2n7mw6AcCUqYRko2AGezp61RZFG5M/4zxr68qC/LQBfyp
 DI7DHJbO/Uzml9DL/Hfxu9ORYv93akeOCiUl6y+M1n/PfTRqDjWw1X/Rc22Tgd+yNmxG
 +Sl2iFijpSgAWI0Nx8Uur2AAyX8g2TwA7ek6bhAyvVCu0qGGBSFI97qlKQc8SIEt1/RE
 m0UXKotoxP4kOlg2jlG6h7MVH2QKorHoGl1YXcp+ROiZMzwWHTTQBgcwC7Lt9W5RFcC1
 nFp2ppl/GVEOkFv8VJaxOOMZlMN0y+jJBkccq0a721ogyqJE2e4ki83T6EC9/1UAbjZX
 0Vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758045985; x=1758650785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1afiKA5WXH75zos913UixLbC9rUVw+fEq1nhaCLbfzY=;
 b=SecBJZzfN0fURXs9wtALru8GhLqTc9nnEADb9xQx+huYyTca2YLDn4PnXbTnPzcOGI
 /8K01mAdJAlu+Nt6YKbuciHCk4XImOB9JmHpdbTQQ2pr4FvPOeMdEX6aYff47CzCH2rI
 bT6hJ35iJWE9IpiEA3td4XB9pmF/WQ2pjWx9hxaM1QoPqOCZRwDuUCpSNWOwPOacPKfm
 6puYqaacTx0aHgTIMWTkVOa5Yr4oelHXaCd0OkCH9vqa8RfoOMFcIhofbinBs6g//LJm
 inntwRjNhb2YGW7+IUYNlEnRJTrUiGY23bukFdfQ95v74mSGFp1C3cHGhdkjKULmgQJo
 s/zQ==
X-Gm-Message-State: AOJu0YweuVDGdLk+Xk2B3EmsqmH4zLZ1cNGTQQUwi6SfJ+FeW0g/qZeO
 Lah8P3fKglAhCUZVJnzk8Os0e0Tn4dAG7aWqfQ/HrKjmWxT/y70k29AFxmMQDS2ySfGCzr5zI86
 shEn4
X-Gm-Gg: ASbGncvMVviWj0Kq1cxUccObkcWMweka1qve+qg2DutsHdDb/KOZR++cejfv058yRTm
 0hBo6tfnQEcEQdr8RgCT8LwQCRqmcroA+F7egxK/ou4IWGBXNQ1Ze94FZ7ONna9TaUuOpzfWjOL
 NfEy4ceE4C+wmqoKCKPb7N8a5i+/kRDfhKOvTuV/rdV0Q7SGZC2rx36tJUR+BjTkEHn1ddv1Pkx
 UXYmVxYA3nOongPv710rSSIBnX705W98ryfvU+4FP8xVNbRU12o8KuLKJUFLYfdUGSV0L2UBU/+
 7lGCfv9LUvCvYnRs4cdhCOL62nqrtXGkth3ntmu5oonxBRo6e1Qat8GsNv7VJEw+EJupHemUcU2
 u7cHUuu3Ma4+OgObvo+JA3L1JF4lv
X-Google-Smtp-Source: AGHT+IGxYUxvZ84igQRtdwiXQhuIxv3UDI8Yvm1UmB8TF8eIDCM1lTI75aPLaMHJr7AUj2u7XuXKXg==
X-Received: by 2002:a05:6000:26cc:b0:3e7:4265:66de with SMTP id
 ffacd0b85a97d-3e7657907camr11483390f8f.8.1758045984859; 
 Tue, 16 Sep 2025 11:06:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/36] target/arm: Fill in HFG[RWI]TR_EL2 bits for Arm v9.5
Date: Tue, 16 Sep 2025 19:05:45 +0100
Message-ID: <20250916180611.1481266-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250830054128.448363-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index c9506aa6d57..1d103b577f7 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -408,10 +408,19 @@ FIELD(HFGRTR_EL2, ERXPFGCTL_EL1, 47, 1)
 FIELD(HFGRTR_EL2, ERXPFGCDN_EL1, 48, 1)
 FIELD(HFGRTR_EL2, ERXADDR_EL1, 49, 1)
 FIELD(HFGRTR_EL2, NACCDATA_EL1, 50, 1)
-/* 51-53: RES0 */
+/* 51: RES0 */
+FIELD(HFGRTR_EL2, NGCS_EL0, 52, 1)
+FIELD(HFGRTR_EL2, NGCS_EL1, 53, 1)
 FIELD(HFGRTR_EL2, NSMPRI_EL1, 54, 1)
 FIELD(HFGRTR_EL2, NTPIDR2_EL0, 55, 1)
-/* 56-63: RES0 */
+FIELD(HFGRTR_EL2, NRCWMASK_EL1, 56, 1)
+FIELD(HFGRTR_EL2, NPIRE0_EL1, 57, 1)
+FIELD(HFGRTR_EL2, NPIR_EL1, 58, 1)
+FIELD(HFGRTR_EL2, NPOR_EL0, 59, 1)
+FIELD(HFGRTR_EL2, NPOR_EL1, 60, 1)
+FIELD(HFGRTR_EL2, NS2POR_EL1, 61, 1)
+FIELD(HFGRTR_EL2, NMAIR2_EL1, 62, 1)
+FIELD(HFGRTR_EL2, NAMAIR2_EL1, 63, 1)
 
 /* These match HFGRTR but bits for RO registers are RES0 */
 FIELD(HFGWTR_EL2, AFSR0_EL1, 0, 1)
@@ -452,8 +461,18 @@ FIELD(HFGWTR_EL2, ERXPFGCTL_EL1, 47, 1)
 FIELD(HFGWTR_EL2, ERXPFGCDN_EL1, 48, 1)
 FIELD(HFGWTR_EL2, ERXADDR_EL1, 49, 1)
 FIELD(HFGWTR_EL2, NACCDATA_EL1, 50, 1)
+FIELD(HFGWTR_EL2, NGCS_EL0, 52, 1)
+FIELD(HFGWTR_EL2, NGCS_EL1, 53, 1)
 FIELD(HFGWTR_EL2, NSMPRI_EL1, 54, 1)
 FIELD(HFGWTR_EL2, NTPIDR2_EL0, 55, 1)
+FIELD(HFGWTR_EL2, NRCWMASK_EL1, 56, 1)
+FIELD(HFGWTR_EL2, NPIRE0_EL1, 57, 1)
+FIELD(HFGWTR_EL2, NPIR_EL1, 58, 1)
+FIELD(HFGWTR_EL2, NPOR_EL0, 59, 1)
+FIELD(HFGWTR_EL2, NPOR_EL1, 60, 1)
+FIELD(HFGWTR_EL2, NS2POR_EL1, 61, 1)
+FIELD(HFGWTR_EL2, NMAIR2_EL1, 62, 1)
+FIELD(HFGWTR_EL2, NAMAIR2_EL1, 63, 1)
 
 FIELD(HFGITR_EL2, ICIALLUIS, 0, 1)
 FIELD(HFGITR_EL2, ICIALLU, 1, 1)
@@ -512,6 +531,11 @@ FIELD(HFGITR_EL2, SVC_EL1, 53, 1)
 FIELD(HFGITR_EL2, DCCVAC, 54, 1)
 FIELD(HFGITR_EL2, NBRBINJ, 55, 1)
 FIELD(HFGITR_EL2, NBRBIALL, 56, 1)
+FIELD(HFGITR_EL2, NGCSPUSHM_EL1, 57, 1)
+FIELD(HFGITR_EL2, NGCSSTR_EL1, 58, 1)
+FIELD(HFGITR_EL2, NGCSEPP, 59, 1)
+FIELD(HFGITR_EL2, COSPRCTX, 60, 1)
+FIELD(HFGITR_EL2, ATS1E1A, 62, 1)
 
 FIELD(HDFGRTR_EL2, DBGBCRN_EL1, 0, 1)
 FIELD(HDFGRTR_EL2, DBGBVRN_EL1, 1, 1)
-- 
2.43.0


