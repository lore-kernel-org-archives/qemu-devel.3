Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4734DC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 04:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9dDH-0005VQ-Hu; Wed, 22 May 2024 00:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9dDE-0005V0-3l; Wed, 22 May 2024 00:04:24 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9dDC-0007xN-AB; Wed, 22 May 2024 00:04:23 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3c99e6b8b1fso3073284b6e.1; 
 Tue, 21 May 2024 21:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716350660; x=1716955460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pv888GdiOxDIgPgjwwn7UnK1ZS3sV6PekCysk+JGFYk=;
 b=Ss52oKuYzPy6MZ+FeGM+kDiIQ9oadK2oQGcRFDAkYjbbn/x1TgWbhTDkX4lF8Ij0r5
 DX6IfWdqx6fnMAO35S7ClXezBNJuGCh6EZ21vOBacmrYrKjFpS4vcvJm5vta5Od+8eDA
 ENMRQO8AG+7dRYhfHp6AMRiBO5jKqOIG4VUvmK/6oviNWtp04POhkYa9VGOSCTKQLyNL
 xQqqsIcYnfOD07Cxe7kvxbvi8POHG+PramjLJJFQ+fSqWb4IF/cQNbLINRMVmTwQB/Ad
 yoVBCQ6PhsDc7MNCZVMPECCsIW0bS1oxnqPLhoSahY1r4O9wsx9yWM9plleNetUOaiRy
 8lYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716350660; x=1716955460;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pv888GdiOxDIgPgjwwn7UnK1ZS3sV6PekCysk+JGFYk=;
 b=SaXjZnSH6gySs4kp4U5YBpeGqriMzwTWR37vUippGvmOQit9zWf9ebPUVeNfu5DEom
 SD/XgkSFy5tAJpbXY+ZOQ1WgR+R9LiUig0+BUXnLzaCNzrzVwHspsSN1JRdQRYsPFAFG
 PcBHKXiAr0p2fhN7GgqEyUqmqh1GNhZlam0DUo2pVTEC8EoIjrF+PGEy0KJK3nUwh3xl
 31zDI14MAuXOdvxq7vimpFX+IsOZrtlHH0OkHswINbWx3AFEAY3wY7sDaa0vwxIpUHtC
 AV17dZT5VMCUjVFep+MzAr+dBaEzTvUqhK+IWHhgpgGawEwdsFdMtNN1pCViI6k/lcZ5
 8aIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+OLNnJcRz+x4BEA1VSfKnHyvKoMM4PD3tXTUKq3ShVX+3Z/IQOE7ArEe/ykc4wnilC1h9ltT2oIAG8BT4HRBemNdNcZk=
X-Gm-Message-State: AOJu0Yw7cfM90pa2lj81lsf09VK5oaFNWeKZQ3MpnD7f3VcjrFC2EUXw
 rzBKmZ4WqhaQet15TjnHDySjaDc7q5ceBToJpYqAGNVo8W0SFrOLh1akbg==
X-Google-Smtp-Source: AGHT+IE8xUVD3x5xaxEXdEybAKP/dBjdUg/WKNoDPNJoihvhBMUIV/sEJpVIPjmbJTReb1zWZNXekg==
X-Received: by 2002:a05:6358:6f0d:b0:183:fb12:39f6 with SMTP id
 e5c5f4694b2df-19791e1d8b4mr119356655d.14.1716350659984; 
 Tue, 21 May 2024 21:04:19 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6589645bbefsm10197158a12.55.2024.05.21.21.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 21:04:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/2] target/ppc: Fix PMU instruction counting
Date: Wed, 22 May 2024 14:04:09 +1000
Message-ID: <20240522040411.90655-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The crux of the problem being that dynamic exits from a TB would
not count instructions previously executed in the TB. I don't
know how important it is for PMU to count instructions exactly,
however for instruction replay this can lead to different counts
for the same execution (e.g., because TBs can be different sized)
and that blows up reverse debugging.

I posted something on this out before, but missed a few things
(most notably faulting memory access). And found that forcing 1
insn per TB seems to be the only feasible way to do this.

Sorry to ping you on this again Richard, it's not urgent but
you're the guru with this stuff and I'm hesitant to change it
without a better opinion ... Simple band aid for the meanwhile
could be leave it as is but just disable counting if
record/replay is in use.

Thanks,
Nick

Nicholas Piggin (2):
  target/ppc: Fix PMC5 instruction counting
  target/ppc: Tidy pmu_count_insns implementation

 target/ppc/translate.c | 163 +++++++++++++++++++++--------------------
 1 file changed, 83 insertions(+), 80 deletions(-)

-- 
2.43.0


