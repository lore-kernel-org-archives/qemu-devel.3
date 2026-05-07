Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463C8CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1J7-00022Q-DH; Thu, 07 May 2026 12:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1Ic-0001eD-0E
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:10:10 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1IZ-0007tl-6F
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:10:04 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d55b97f358so735404a34.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778170201; x=1778775001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=HYWTup8K7yd2OeztZooscUxiu885dsTg8BE4ElD1Uzo=;
 b=ksIqNTDku7SCJM5eiGeSF/1rfRLSNHYAzygpEyvnEVNpyG5sGhAj70waqVZGZcbiYO
 gT/ZaDGyQUnGCvG+8DQkTPjMs6NsP/pX509VF15aH6r4asjWr7uBVommG/41BIAM5NQI
 gQ+ZbjWVdfmvcY2bO0lOSFyVi8D4vziAesDrk6IVvRuOk6V06iaZbeCAGHjqAknK77Rr
 Qhe1MOmB2wg5RHHIAIaH3SADDehWCqQ6e/AJ0zothASgQm7IG8P3uYMCjsEpO1LHX+P0
 2KZ666JjdQVYNnkc2lBl6TEYd+9PWvuw8qwYUt1kyH9dGkklTa+qrzD0zzZo+Ws4fw7H
 z21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778170201; x=1778775001;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HYWTup8K7yd2OeztZooscUxiu885dsTg8BE4ElD1Uzo=;
 b=av3aPJSvswzidFG/rTLNTy/obxpGAww9A9aMB5VeHaoDUPOR/BMe0m/qu+D031ITd3
 DutVB/YPtoAf0a0lfsUcivoMhCKFlWDgVy2BfmVqPqpFY98E7P5kQRx/UaUdunCmDmos
 dOKfnKmPRCjrbm5cvtrvhQSRGTd4udDhm38mOKdbG65Ah5zs/GBaoyA9ty4wfp/Zydi6
 AoW2y6oOfJcnnCsa4u8JjIRCXArGNxWcTxw3XjGGN0itIA0WYO/TYxhiUPfhDRTCb/sk
 gSaaq3wRc2C/Je4Gk880aREvOXPomIEuYam3oDaC9ARRJ+kir1Bo/AtVSbauPH8Hocto
 9NMQ==
X-Gm-Message-State: AOJu0Yz7Tg8tlA1Syz+XfB4L7s6IjghIm81FEjmgnSmfddPMETqF5Vwp
 uoglaFtuk7GIICQYYR8FlxSJwQwc19nKVZ97PYzS9zO/5EYR07BiG6y/5b1JzGLKit0O+EXwDXA
 IQxLu
X-Gm-Gg: AeBDietg2cnU1Ma9mKxdxfO4W0t/ZW7cPKYfLUtlSNQ2CaBPTyEanelGImRsNmDrrSg
 rYNzHneaxmYhF3BJuA/xiAbh6Bi5QVmbSHNatZ5Odg2ZFWggIDZXgp9qx2y/+xn4l/BMYUUGLRj
 ceUPTCpL4abVB+V6dlgfU3Vv2nL6BA5t6lMwi7IW4jDobQGVgfoHg5eFPilXHjrKCWS2pSv3Y49
 Rfbs40YraEj3YTjM9omH5SpFBfwNB+GnEEi213TAGrDsvYYq9/TQRq0CigA5LdYxZ949T0SBdwN
 5Y4JtO3OliP3rOnx/kYsCldRZFbAa5ewyj8+fsiLxlAHx3PULcRzYvSNyM/9zIRC+ASV8RqQvDO
 qk4++zOM1Fnm86gme5h6iDK87mhBH9B7RnmscT8mFx0OHyZNDA5aWsRU7EUjrm25GWs7jGL015Q
 M382D2V597KzJkDW0J2JYPOJmqyIcNX1k=
X-Received: by 2002:a05:6830:71a4:b0:7d8:7d95:fa59 with SMTP id
 46e09a7af769-7e1dea10bfamr5067026a34.0.1778170201156; 
 Thu, 07 May 2026 09:10:01 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e302462fb1sm16415a34.11.2026.05.07.09.10.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:10:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/11] fpu: Export some internals for targets
Date: Thu,  7 May 2026 11:09:48 -0500
Message-ID: <20260507160959.449170-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

Based-on: 20260507160518.444797-1-richard.henderson@linaro.org
("[PULL 00/29] fpu patch queue")

No changes for v3 other than merging 29 patches.


r~


Richard Henderson (11):
  fpu: Reorganize partsN(muladd)
  fpu: Return struct from parts{64,128}_muladd
  fpu: Hoist nan check in partsN_addsub
  fpu: Simplify 0 +/- N case in parts_addsub
  fpu: Use parts64_round_to_int in parts_s390_divide_to_integer
  target/s390x: Move float{32,64}_s390_divide_to_integer
  target/arm: Use FloatParts64 in bfdotadd_ebf
  target/arm: Drop oddstatus from is_ebf and bfdotadd_ebf
  target/arm: Use FloatParts64 in f16_dotadd
  fpu: Saturate the exponent in uncanon_normal
  fpu: Introduce exp_scalbn

 include/fpu/softfloat-parts.h |   9 ++
 include/fpu/softfloat.h       |  11 --
 target/arm/tcg/vec_internal.h |  12 +-
 fpu/softfloat.c               | 224 ++++++++--------------------------
 target/arm/tcg/sme_helper.c   | 102 +++++++---------
 target/arm/tcg/vec_helper.c   | 127 ++++++++++---------
 target/s390x/tcg/fpu_helper.c | 135 ++++++++++++++++++++
 fpu/softfloat-parts.c.inc     | 223 ++++++++++++++++-----------------
 8 files changed, 407 insertions(+), 436 deletions(-)

-- 
2.43.0


