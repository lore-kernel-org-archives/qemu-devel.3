Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F293DC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 03:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXBmO-0006qd-4T; Mon, 05 Feb 2024 22:05:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXBmC-0006p9-R1
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:05:36 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXBmB-0003CB-D6
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:05:36 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e04ea51984so656060b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 19:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707188733; x=1707793533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OrOSiOgFqO4ZuxdnM1JjpVN0rJqPqJZg3/Y91qAkhPI=;
 b=r6GZI5DeQKOWk+6fxcakXZu1yL0RzyDd5RohH5prw131kZTrXydKsjIvkKlrBB1AYB
 jBLytOE44+m5bzNiDhlC89AT3c/zO213OgxXg7BpHs9/0b62O+mTAkjYotyM8EgJQtXF
 6zyMY0gQqGSkql6kTytr0KhZwAZbTzgDuqz7DfoKoX7wzxrkbk+HH5/5qtSgyqXeWJg+
 RWEZ1o3FZReSkwQxFtQxyBg1SuyQfb0RQZbJZxAQq70qDcKDUptKR59KL9dkhwlE4seb
 s3coweg4OT6ghhG2GnCVPPU5LLdU9vTWwcpw9xANStW8EvofWGcAaZRxJNc6Ac0Dsv69
 ljYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707188733; x=1707793533;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OrOSiOgFqO4ZuxdnM1JjpVN0rJqPqJZg3/Y91qAkhPI=;
 b=neXCNykt5p/k/qHp8DlJSIyIUDYOG8KpgLJUYHECy7Dz3cM/97BF2wRVRV3pv6bzpG
 xs1yAba1/h68AhYSU7LD1kpsIX8yAwdiX831qAcmKqe41KZufd8Tr1fWLR8EK+mCiszg
 9xkSQ3RpHmzuQNX5iMzsF7C64KqvZa6FLFfAs9CIYps+fY76W+QEPCisLLFUvkO1RAMI
 +HG71KVbG44NKCFxikkOcnxhHrYzFnCH2dgnIpLNlPZQvUrj7HjzN+V00SUHLJAJkmaJ
 qP/jYhrJbK/zyAB6wfqvpi5TA88XD6Q8P7IVRtYFr4o9S4Irulgm0B05kmHD/FnchneB
 ID1g==
X-Gm-Message-State: AOJu0YwJyV+OkDAfjJ9aA1MT4uv9r08OcGA3hCpehrLALP6uqMHe6O2V
 ctP0whnq5OnQr/3DWjR8z+Kar7VIqHnQhkBDS5XvyJwn47GxfBjh7qTWBcfdRobYpqgzwiudF+U
 avZM=
X-Google-Smtp-Source: AGHT+IHN8h0sOcNlDdYBLPOUYuTPCnzdpMgsHwqhGNKSwiJTrK/AtU6lWPt17Dy6M1pnE+VuRIs10w==
X-Received: by 2002:a05:6a00:26d5:b0:6dd:dbb2:8ee9 with SMTP id
 p21-20020a056a0026d500b006dddbb28ee9mr1045932pfw.6.1707188732908; 
 Mon, 05 Feb 2024 19:05:32 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXxclPMm73wKJoKvqFoj9p7c6743PW066mGFwMrWRnMhKblJN8xNxwRaguVodvnXIUTNxNeg3SeuDf1dMPCgEet5EHm/u4YPlst
Received: from stoup.. ([43.252.112.200]) by smtp.gmail.com with ESMTPSA id
 r14-20020a62e40e000000b006e025030700sm627478pfh.190.2024.02.05.19.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 19:05:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v2 0/6] target/arm: assorted mte fixes
Date: Tue,  6 Feb 2024 13:05:21 +1000
Message-Id: <20240206030527.169147-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The first patch is unchanged from

Supercedes: <20240131003557.176486-1-richard.henderson@linaro.org>

while the remaining patches replace

Supercedes: <20240205023948.25476-1-richard.henderson@linaro.org>

While digging through Gustavo's test case, wondering why it
should be failing at all, I finally noticed that we weren't
overflowing MTEDESC.SIZEM1, but underflowing (-1).  Oops.

But I did find a few other points by inspection where we
weren't properly handling or supplying MTEDESC.


r~


Richard Henderson (6):
  linux-user/aarch64: Extend PR_SET_TAGGED_ADDR_CTRL for FEAT_MTE3
  target/arm: Fix nregs computation in do_ld_zpa
  target/arm: Adjust and validate mtedesc sizem1
  target/arm: Split out make_svemte_desc
  target/arm: Handle mte in do_ldrq, do_ldro
  target/arm: Fix SVE/SME gross MTE suppression checks

 linux-user/aarch64/target_prctl.h | 25 +++++-----
 target/arm/internals.h            |  2 +-
 target/arm/tcg/translate-a64.h    |  2 +
 target/arm/tcg/sme_helper.c       |  8 ++--
 target/arm/tcg/sve_helper.c       | 12 ++---
 target/arm/tcg/translate-sme.c    | 15 ++----
 target/arm/tcg/translate-sve.c    | 80 ++++++++++++++++++-------------
 7 files changed, 78 insertions(+), 66 deletions(-)

-- 
2.34.1


