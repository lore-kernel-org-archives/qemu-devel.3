Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA08C61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 04:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzRXE-00076L-QH; Thu, 27 Aug 2026 00:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzRXC-00075M-La
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:16:14 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzRXA-0006RJ-8U
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:16:13 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38fdeaed181so495231a91.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787804170; x=1788408970; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oiEJurby+Qpd4ILfISgzYyvA6Za7whUIgu/6pGXW1uo=;
 b=N7c9AYgcNUsEBU0UYp9jeknJ7Qm+zpZRHchy543wVQDJPOsRThfxKPVimITGe47qxM
 dK3GGSfhIVMp+BCN9lEePhetvSRxLzZ0yDxOQE5YYwuovkFStGara4SrsucZXS/ZoXu2
 Q05jMABkj3Q76wY13xOdQwjLRLqE01e/jmVYGDVA/+tDx+NFg6nlMDz2+yZVmKlGq0C3
 1y4p7qVHUjKUlJvPMfV1EHvhWSiotUGHn6O8Am6py3Da2aH4/HgXgMgRAwpGVsztiW5w
 Z++vxvF7HU8U+9wRfGqMAeTVq2pJo4DAtsrJCkOoBkt4jgyBIfVVm9z8v+G8wj9YlRb7
 I6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787804170; x=1788408970;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oiEJurby+Qpd4ILfISgzYyvA6Za7whUIgu/6pGXW1uo=;
 b=DSwmd82Xb778mnNzAFnAIRH9dUpQCj/HE1BU8K2k90wYvezgb/v2OAqdpLt2sio12Y
 Wj7bGdV2+uFFipBrw9t9xoF3DDwBM7MdnipAcMaFjf/FNsD6JkZkh+nTzF6YSp0hzrF3
 7tjFKLeQsLNNP1Yx2uCZy71NnELLv4HogRRQ+lvOUu1cvEjdZwoQ+nCoBQj+w2uTAqxc
 gfoUS8drgEDlPP2nfm6jRllNbPec5la2ExogAueeghxoXSZYcgpWs/g6S09KWyt6DlGs
 8B77XIwa1wiyhvAYLeWodxnM902Wiu1uHrtPNFek1y6/kb1ByL1jBNu4MfJcjr1jWiX1
 Dvog==
X-Gm-Message-State: AFuF++l1v0V6FBkfKLQ+HMRZFRWIZXKsnBZWas7Tyose5Cp+/3l6ingN
 dCBOTXkBa7eBcnvdF5OfARc9yhPcNBGY6K7JA8133usWghFaLQEE0QGmJQ90SrIsBX/A1EOxe0i
 apTmy
X-Gm-Gg: AR+sD11EHuhbCkwbute3i47i4d/mvQOxNcJ59lIq2ytTNrZ2d6Hb4QQDM+yEmCBKvgW
 wl4n7dCuKBoUSHB5tgotnBzD0Mt+cPellOIAzXMDM0vuOadugvjctNPkq9++CSP9tRdlHP+wcqO
 fKfbxg9lmMtaQ+4bm44BtxV/OxaiugFcczgQ2NZZEXH+eZIeMhYD/XdJ/lhkerf4xXwpN9jEUJl
 vKSiltRADEzRs5erz1tWDNd5keSHK0xrTsLDfwrh40PqmCAQUMa2QFcVXjf55nUOQhxB0BGRUoc
 tqggDVB8PyixYU4l6xhCPZVzec1im7+CcEn1IvOE4B6UU7hXrC6WUcgZC+bbXaazDvUjCiBLDzn
 2noFWYz1G7ctv+Oj+H5aMnr08FCJkKw0tpESAkk8cvQtJyV8hrJ5wgxxpLlJokoDLiTBODU4ofg
 EHj3b+/qzm/mTvb2VEqF0E79bz5rioPYENv2J6QN0hOX8PbL2VYLRDkspZoDJqeHdXCtiePbJYC
 QhMfWe+c5Uk123Lew==
X-Received: by 2002:a17:90b:384e:b0:38e:57a3:f218 with SMTP id
 98e67ed59e1d1-3966d4232fcmr22899216a91.13.1787804170408; 
 Wed, 26 Aug 2026 21:16:10 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0d81682sm969597a91.7.2026.08.26.21.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 21:16:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com
Subject: [PATCH v4 0/6] target/arm: Introduce cpu types max-v8 and max-v9
Date: Wed, 26 Aug 2026 21:15:51 -0700
Message-ID: <20260827041557.775080-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

This is something that we've talked about for quite some time,
having separate "max" cpu types for Armv{8,9}, because Armv9
prohibits some deprecated Armv8 features.  Retaining all features
simultaneously has the potential to cause confusion.

Pierrick, patch 2 replaces the one you posted using ifdefs.

Changes for v4:
  - Adjust for single-binary.

Changes for v3:
  - Several patches merged.
  - max-v8 is also present for qemu-{system-}arm.

r~

Richard Henderson (6):
  target/arm: Move -cpu max stuff out of cpu32.c
  target/arm: Build cpu32.c once in system mode
  target/arm: Rename and adjust aarch32_max_v8_tcg_initfn
  target/arm: Introduce cpu types max-v8 and max-v9
  target/arm: Use -cpu max-v8 with aarch64=off
  target/arm: Separate cpu types max-v8 and max-v9

 target/arm/internals.h                        |   5 +-
 hw/arm/sbsa-ref.c                             |   2 +
 hw/arm/virt.c                                 |   2 +
 target/arm/cpu-max.c                          |   4 +-
 target/arm/tcg/cpu-max-v8.c                   | 130 ++++++++++++++
 target/arm/tcg/cpu32.c                        | 116 -------------
 target/arm/tcg/cpu64.c                        | 159 ++++++++++++------
 target/arm/tcg/stubs32.c                      |   7 +-
 tests/qtest/arm-cpu-features.c                |   4 +-
 docs/system/arm/emulation.rst                 |  13 +-
 target/arm/tcg/meson.build                    |  11 +-
 .../aarch64/test_virt_aarch64_off.py          |   4 +-
 12 files changed, 273 insertions(+), 184 deletions(-)
 create mode 100644 target/arm/tcg/cpu-max-v8.c

-- 
2.53.0


