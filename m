Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A75CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXXV-0001PT-E3; Thu, 14 Aug 2025 08:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXXT-0001OQ-Ss
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:58:39 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXXQ-0004EB-Nr
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:58:39 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-32326e67c95so1319538a91.3
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 05:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176313; x=1755781113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kEj8duxAu1Pam82WhtcHKlYlFMg89KDGm3ClOoILo48=;
 b=hMscfo7bcA81xcf0jJ3cJ8fo5Bu/x0+wH6rmYzZ5mkr2vJGmwTJI7f5TgLXGtRIcEI
 idBji1EgF/KxKp4M6Tjej9FbcF3iwGNMRzZaUX3SbXgEwZ1idRqysdkaxeM/42EV5rgR
 rtl2nS4+Rk2SwbLQC+jR79VoqjcnnitkTJyiPY3hhxh+XBGhupkUWH9gzr0PwzXKLDsw
 D51n1ydtH6gRdghedUxvhMSNOGhwQubzbIKoO+a6Gs34J1mbIUPbC9SpnOLFpkod5z4C
 L1HB/60hLhDSL5lrqgnIIEqtQwNJNKj/5pVABacTzXADO5JWxXLf5qFSlgOH9DnISptR
 ibgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176313; x=1755781113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kEj8duxAu1Pam82WhtcHKlYlFMg89KDGm3ClOoILo48=;
 b=QF+GyB5RTwxpKunKpGiBusOkyQQTdfGwHyeM/x+pKJIsaRZZIjMOYw6Xn4DsVvxNVm
 ETVipYo59zaEKl6mbF7XjXpXCUzug0iQydZrO7nb+j5NBhX5wrmEltcZTc0wDn5yrfFS
 hyNVDus0UrGnyz8ArfCIKlAfjHOOKkINHDSZy7oZHtOlUmOSAyBmUyrSgY3M8LX5ZIwn
 FuFAKcuEgM1pXsulWrbKLA1yf4nuaXrGbIKZ1WWJ19U8O5qDvLemEAC/n5atFDX6hIu3
 iI/BhJimQCh9y7CWie6gtJ3JeKVZRCVRiKW8cwJP789u73VFHmhc8RQN923mCuM9xMSq
 7Yfg==
X-Gm-Message-State: AOJu0YzgsW2uHlBE3y4vaKZT4BOtePVfVHI/jPEgMFKu8Ck1ewAY0HZ0
 ENPM6tSBQKKbBCWMOmrX4bkeC1/8np6CAmvgF1HFX9r7Bm6LJs7oR8/BFO34iWhZ5k5OAdD8zA2
 XwFbtSJw=
X-Gm-Gg: ASbGncurzZtpc/hcjYovBnL2hGN+fTobE4ucbhKmC74iyQp6lbH0hEumC5/YFVZcpNT
 zlxrlcyErtnEg1ja26LFhwL0a+sHqyTqTTGVNPLItTSmg1P0dWE3j8KFaqKiKe9sIeVguwaULRL
 C+nkHX99S+NLrUjPduIDPKhMnXwdF6ZZBj9XIekOMSjpcBssGl9H9zjm2dq6BrxzK8u1BkdYHbr
 2PLGN0QZZO6avv5/Zh1h8FtJe3+0tWE4RhYDLNFI+88IGZcrfNWTKXmNNEF33Rd1GheeoJFewIJ
 MW7rIcjsIvFyNs8PchAxQ4QeNC8NUViN21xSSPDQYBsOKv44GCE/CxsQ29YqvYgAlhDCzHYRTxL
 0m353lzwF5UBjeCIpa4zLst92SOWMpaSAiCbSn5sPI3X9ab/n6Bjw9QkdLw==
X-Google-Smtp-Source: AGHT+IFRJUfoCzm3PtL2k4jQEUZ3CSNgU83jsQX7Qd3e1UnzTBACi0q7w71dAOK4Cl6HgJ1ThTAR1A==
X-Received: by 2002:a17:90a:d00c:b0:31e:ec02:229b with SMTP id
 98e67ed59e1d1-32327a4e21cmr5178322a91.20.1755176313324; 
 Thu, 14 Aug 2025 05:58:33 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.05.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 05:58:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 10/85] target/arm: Fill in HFG[RWI]TR_EL2 bits for Arm v9.5
Date: Thu, 14 Aug 2025 22:56:37 +1000
Message-ID: <20250814125752.164107-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index c9506aa6d5..1d103b577f 100644
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


