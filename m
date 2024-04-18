Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B907C0650F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 15:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxTYj-0003Ff-QP; Thu, 18 Apr 2024 11:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxTYg-0003Dm-KE
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:20:18 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxTYV-0004Th-L0
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:20:13 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-418bbc690e1so8579335e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 08:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713453606; x=1714058406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=gPIaBM3QM8McnGpdq3qblSpqrPodIkBgwRVjsR+0/1E=;
 b=YTxnwxx78og9nHusPZmZEh7dW8Ttskztk/VdBSKYAHovY4eJxA3KdNu/0yaWFbWgcF
 sc27sfyxdVPJ1R1rbCBgAj8QOIcJjLpp3YRc0HZMSTypFIrueXSxQ3y5NA0ZTZRt2nBE
 h6GZVUA0fsUeDtHPQbSJfBoPJXW5D/gv+p/jen/zl3ZubapspVd+DjPIq98h0SlSKk3b
 0+IWEi/mcKxYmDCWixZVyrDPSe+UsPE0769wtdnwMoY7QrweYuDjTVOwJTZI+fugSJE1
 mDO8PeDGKDjGYCsS53f9VO9FqaAP3nJnGzxFrhneV4AGQHWJQ1M7zzLQsqsERGbb8+nY
 3zsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713453606; x=1714058406;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gPIaBM3QM8McnGpdq3qblSpqrPodIkBgwRVjsR+0/1E=;
 b=cY7fnB0Htie2qTKAYd2/DOryzhUSM4iPGWQf4m21b7r2k5qrTgXOyiCVkchgVP/mrU
 SdfEXcB5zpWziF2C9lrXzFxv+HoZZXliSuxk18+RfIxUonvoVfYVKX1WbViC1RwLE3Sc
 /SZTupWGGn+PCHayBxm8To/fLQPB9hQLDu5iRmbE+9lR59zBV7P04YjnvK0f61X4c4+c
 7ZkBiw8x9KyUG+Ny4WlHzk71q5sdnKkpaOSe6bQd7nuxDO5I6ysjSkn37puYfkA15n6B
 yzeWDBaot8y3FJacQGODpBOLN6y79e6KHbWRIs6rlpfvIZl+7mlvzmArxRIkeDKiKhjg
 ejKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDenCkTRh9Y3JqLgSbTkfQupeRgWdQMrFGZebGnAUfn5+cMV3KKxTbuPH/LOpKfo3JeygK9bXcHA5pOxmNh8epeSHhtlI=
X-Gm-Message-State: AOJu0Yys1yZ4YMcrJVwouTpyvblea+BZ1jL4R5yEV5ujwrfZExEJEe3h
 B5UI+v7ee4/zQvHZCU4yRZY6WmGcXa8jFf16UKiMraQKNcmY6svuRbCmY6sDxRovXov7avCkQbD
 p
X-Google-Smtp-Source: AGHT+IF2BTrCux/T7XkAuk9s47p9uuQfYZsNjI3l+JwII0hmM8OWowVXrUs2aG4D83coYKJHC4uewA==
X-Received: by 2002:a05:600c:a004:b0:416:bc18:2a00 with SMTP id
 jg4-20020a05600ca00400b00416bc182a00mr2310119wmb.38.1713453605638; 
 Thu, 18 Apr 2024 08:20:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a05600c475100b004162d06768bsm6886839wmo.21.2024.04.18.08.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 08:20:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/5] target/arm: Update emulation.rst, add some easy features
Date: Thu, 18 Apr 2024 16:19:59 +0100
Message-Id: <20240418152004.2106516-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

As of version DDI0487K.a of the Arm ARM, some architectural features
which previously didn't have official names have been named.
Mostly these are features which we thought of as part of baseline 8.0
support.  For SVE and SVE2, the names have been brought into line
with the FEAT_* naming convention of other extensions, and some
sub-components split into separate FEAT_ items. This patchset updates
our list of supported features in emulation.rst to add these.
The audit also caught a few cases (eg FEAT_CCIDX, FEAT_DPB2) where
the omission from our list was just an oversight.
                                
I've also included a few patches enabling "basically no-op for us"
features: FEAT_CSV2_3, FEAT_ETS2, and FEAT_Spec_FPACC. (The latter
does require us to put in the handling for ID_AA64MMFR3_EL1 as
a real ID register rather than an always-zero reserved sysreg.)

thanks
-- PMM

Peter Maydell (5):
  docs/system/arm/emulation.rst: Add missing implemented features
  target/arm: Enable FEAT_CSV2_3 for -cpu max
  target/arm: Enable FEAT_ETS2 for -cpu max
  target/arm: Implement ID_AA64MMFR3_EL1
  target/arm: Enable FEAT_Spec_FPACC for -cpu max

 docs/system/arm/emulation.rst | 41 ++++++++++++++++++++++++++++++++---
 target/arm/cpu.h              | 17 +++++++++++++++
 target/arm/helper.c           |  6 +++--
 target/arm/hvf/hvf.c          |  2 ++
 target/arm/kvm.c              |  2 ++
 target/arm/tcg/cpu32.c        |  2 +-
 target/arm/tcg/cpu64.c        | 10 ++++++---
 7 files changed, 71 insertions(+), 9 deletions(-)

-- 
2.34.1


