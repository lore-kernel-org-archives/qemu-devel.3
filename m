Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76194C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 14:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNCW8-0002Tg-CM; Fri, 28 Jun 2024 10:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCW4-0002S9-Id
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:23:56 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCW1-0004PU-6v
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:23:56 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52e743307a2so858406e87.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 07:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719584630; x=1720189430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kFJB9ypZ3yzacaX0zrNCsCIbzybKZZLvBjJsHqEuQeA=;
 b=seab8uxoAsuYUM1cmXzsjJjNsgG3CvHzOAEPWX9tG5MhU7a9R0GTDSdxJF5aI3WIgS
 T94S6kAqO4/iqsLo0SBiVHit20sPl7UIGSpKAwLFRwuh/b2rmsN7u2qI2gZSDwUEitGj
 nLsfWQJZG2Fzb2UpL1WnpCTTZsMlYnMjqjiOb9jG9+wFcaaUZjoyxYOcmnOwPXlYQJ6M
 Wj0eBDw2vYra/FsLwTlrMORPe+slYU9D6II5QmNrBdlxT7n9LSKP1wdKIQyMNXH5YDU0
 uQhwbifRnH83j90W8yGaAKwn+nbB3yukMKTGohhJaxQj8HLlTGI7VqndnyFCYytnDOw8
 UkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719584630; x=1720189430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kFJB9ypZ3yzacaX0zrNCsCIbzybKZZLvBjJsHqEuQeA=;
 b=gBywWfCU7UXoMB2DpuSbvbDjqsG2I7M1tTdki6ruGhjlcuYZ6njyc19COoLhp2cfRc
 VhjKCaboDdCNBlLMUF5Et6r9wlLCjRdmd8O21vTXjdBZoPNC3xV2uoSLRzdhzCM6gkXE
 XEqtLOKj2pwc3rabO6kirOhawQafHHm0Lo0Tr4Ygjr1Loz9WZ0keV4HDA29i6ZtWlQpT
 yG6Pawe3hq20u1ftkhid7s2qBOw6owBE6PIAdgL4Xb8L8FIZh1pneME6PmYUydGx7myi
 eAChTJSy85brxn4B2y4OQVYKYj7AFNjhujRJBERDTCqWVbCQSOGROr6zzP2/J3tKjfSK
 9S+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGDfsbUJtquALpx9tcASKXQJ+JL+sak+bVDWA8kkQPxp/52j92v8gnt2b9zk3y9dWSx2j5nxi8S6d0BdAQsecXWIWrf50=
X-Gm-Message-State: AOJu0Yy+AU1BPg24DfjaQPuABk2JnOqsA4Ei/lmBRS4hrFZu4FFGffc7
 VHhKO5hGKR+oKMkvBqfMZ4I1SOuxWWmBY0D40IR4zbgEM+h2SDARHO5KFZBKm32kqMO8Tv8+UoM
 nZJQ=
X-Google-Smtp-Source: AGHT+IHSzYfZG00ctXTCFyx2goAQG5uUxigIivx4K+tWnvhp+OzbJO504j421lBnfM+f08UM4JsDMg==
X-Received: by 2002:a05:6512:3e0a:b0:52c:e3c7:941e with SMTP id
 2adb3069b0e04-52ce3c799f0mr16122795e87.47.1719584629803; 
 Fri, 28 Jun 2024 07:23:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af55c0asm37180945e9.15.2024.06.28.07.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 07:23:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/9] target/arm: Correct comments about M-profile FPSCR
Date: Fri, 28 Jun 2024 15:23:39 +0100
Message-Id: <20240628142347.1283015-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628142347.1283015-1-peter.maydell@linaro.org>
References: <20240628142347.1283015-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
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

The M-profile FPSCR LTPSIZE is bits [18:16]; this is the same
field as A-profile FPSCR Len, not Stride. Correct the comment
in vfp_get_fpscr().

We also implemented M-profile FPSCR.QC, but forgot to delete
a TODO comment from vfp_set_fpscr(); remove it now.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vfp_helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index ce26b8a71a1..dd67825270b 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -176,8 +176,8 @@ uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
             | (env->vfp.vec_stride << 20);
 
     /*
-     * M-profile LTPSIZE overlaps A-profile Stride; whichever of the
-     * two is not applicable to this CPU will always be zero.
+     * M-profile LTPSIZE is the same bits [18:16] as A-profile Len; whichever
+     * of the two is not applicable to this CPU will always be zero.
      */
     fpscr |= env->v7m.ltpsize << 16;
 
@@ -226,7 +226,6 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
         /*
          * The bit we set within fpscr_q is arbitrary; the register as a
          * whole being zero/non-zero is what counts.
-         * TODO: M-profile MVE also has a QC bit.
          */
         env->vfp.qc[0] = val & FPCR_QC;
         env->vfp.qc[1] = 0;
-- 
2.34.1


