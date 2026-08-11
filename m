Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46215C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 19:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtrx2-0002GJ-HJ; Tue, 11 Aug 2026 15:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtrww-0002FD-13
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 15:15:46 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtrwt-00027z-6z
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 15:15:45 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-39266382df6so54665a91.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 12:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786475741; x=1787080541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PSytBMJaQ9G9l9syB4XOENPGWna1JnjRQcf0lvpH1T0=;
 b=RZsOGAopDBwGD+nU3+fYsBxSfRoQ1Zk2wJ6/1H+5Is0ubaIWc+2T/EmjMSJ2rel5mL
 vV7WOjr3ZfNb/1EmVlucVs6rG7O2AgRJ51DTDcgNuphm+4pRzj53fNgcXWXX8jslPcRm
 zi3L8JFpiQpAFRhoJ29RlDdbW6M/iVKrNxmOOt2txk75TPQZbkm1ykJPbpHtb2M3gmb1
 PLhZt6ekxJPaPEzFz7Qy/SMCdSxrRYCJeeumUoXd9++BnqSfu+jyVL7ic7yR1P2C9Rvh
 SMKmi+A3gWq9AfeXiDxCaxjTM32L7A18GAby4dS2f3G6mvdqulKGWMlkVXTzqXOEEFqF
 WXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786475741; x=1787080541;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PSytBMJaQ9G9l9syB4XOENPGWna1JnjRQcf0lvpH1T0=;
 b=cq1vFIwu+WvdpFIc9Q6BMOtb5aPj2Ns81C6n8FQhYAnoFSKk6+on24jrVORSmsaFFr
 zrTQISILFv3N7kh7kNBDDy5hf7ivHribnMiYFSAiXG5Kc3s4DEWnmnkN2AHjmwVOh25n
 99KpUUqme+/DypDtiSs3Dbq11+D9m8K5xio69L5oM9Eiq5K1GE9BFXgg6m/EixiDkDpB
 WYKjJ/sPqpCAmPIXXBlt8TAgKNc/OiSJ5w38nWkXOsfpVxBntiTWTwVILhGUja09dikW
 pHBJyM+ITW/fL61PRmfbSPSlbLy6n9mXqwQJRbjTJXMw6ziH2k8KXPTjRAqH4vwCg0kK
 4GeQ==
X-Gm-Message-State: AOJu0Yw1k28RI96lFyPlRDxf05u/7bibX8hmZsOq2/jDWUNV5dDY1IAF
 O56NbSy6tjzSlU3G4/NYvzUDX1hLnn66ax6VAl+P1GI7CQSC19UcgyzBcXitLqBAtbQI0W+enro
 COhjI
X-Gm-Gg: AR+sD10v8C2Y3QmeRqtJTK1DLPjYQ3mWp3LGP1PVAXhLAOZLmX0MNT22uDmnncHyGjn
 ija8kXDOcs/yTeqnKzGlUVsqoXN1c0sCnMb88VNvlHX/a8n0m3tDmd3QUR6ocYSN04lh6AciUQC
 q8hx1JQ6Npao+T0Ai5RGMyPCrb3IA82B6YB81nKJEE+qmpahsknTguYss1MKx4pFuJm17HPlKti
 btJsJhrSInG2JF1+KhLRdxX9yC8mTtDeGrOZho2J6TbjIDc4v64mdPlPitnEiHKZQQxNewaJRJG
 2eSnurOX2ER0dSttHR4sfBhAJz/6t+ea9tKvsF21Xi5i0XTkCee3FlZTL38/RHr/8pQbA2yIJ+L
 /+5dP1MEn4WoILYchbh3qdKp+DC4/YkzGQzZ+6Ft2xMoQmxja50U+2fwFShoM1Uk2WYn0C1mqPV
 oGUZIE5kWFCHUkgApZ0F54tT79LouLahRNnGLnUKfjs9Ax5STGQgZ47uiC5p3H9gH0Kvg7jvLDV
 2P0dbZtKDEM/fI/nYl8
X-Received: by 2002:a17:90b:530c:b0:38e:e9b:ffa4 with SMTP id
 98e67ed59e1d1-392f4727915mr2357031a91.6.1786475741323; 
 Tue, 11 Aug 2026 12:15:41 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f97fc409sm209668a91.1.2026.08.11.12.15.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 12:15:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: yang.yanjun1@sanechips.com.cn,
	qemu-arm@nongnu.org
Subject: [PATCH v2 0/3] target/arm: Fix SVE2 WHILEWR/WHILERW zero diff
 boundary case
Date: Tue, 11 Aug 2026 12:15:37 -0700
Message-ID: <20260811191540.79882-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use tcg_gen_ussub_i64 for WHILEWR.
Merge diff == 0 test with bounds check.

r~

Richard Henderson (3):
  tcg: Export tcg_gen_ussub_i{32,64,tl}
  target/arm: Fix SVE2 WHILEWR/WHILERW zero diff boundary case
  tests/tcg/aarch64: Add regression test for whilewr/whilerw

 include/tcg/tcg-op-common.h       |  2 ++
 include/tcg/tcg-op.h              |  2 ++
 target/arm/tcg/translate-sve.c    | 38 +++++++++++++++++++------------
 tcg/tcg-op-gvec.c                 | 14 ------------
 tcg/tcg-op.c                      | 20 ++++++++++++++++
 tests/tcg/aarch64/sve-while-ptr.c | 28 +++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  5 ++--
 7 files changed, 79 insertions(+), 30 deletions(-)
 create mode 100644 tests/tcg/aarch64/sve-while-ptr.c

-- 
2.43.0


