Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73295C00A94
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 18:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvM2o-0006BE-RW; Fri, 12 Apr 2024 14:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvM2n-0006Av-4S
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 14:54:37 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvM2l-0002CA-7P
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 14:54:36 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e2232e30f4so11276695ad.2
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 11:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712948072; x=1713552872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=3cvOKCh4zBNMcv5As3so3YaqyK5t9O43WU8XMxT44OU=;
 b=MpgdlA7n21Lniirt5KJaiThNCQlOd9b+i8NwD/Z2XOH/5REoaJD6PA/n0ksItW2HJ2
 qg6GGf1Gvk1gGNSwjxmU7EunER9Xznn0vaOy3PiLiCQ5TdXa0E6FtXGrVfgiKKJeLYrJ
 AbEieahEbOX50GhHfrLA6zidioZMthA4zi0RxRn8ojeSzlyRmDjyGZ5ImVOXpsMZDifr
 ul+Z5+Lj6vQHPYCdH/bH9xWXNKLYgY1RxuapFnyudYBgQ/KDuMI2CN4lDc7zaqFOg0DI
 omtT6Obrj4VBJoJxaB0SZIj15Lfk+SjJt25TTKyx+tEtDI9poBJYnd3T2+k1mvAfadYz
 HhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712948072; x=1713552872;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3cvOKCh4zBNMcv5As3so3YaqyK5t9O43WU8XMxT44OU=;
 b=bV8QASlGKqDIzstGsOYZowjG8ObRIREX8fPfkHO/IeUF5A8IcvoUpGCRn2kvgckK8M
 EYjULGiylFj0qTYklZKo/+6T4ukgpMNLcubAlYnNTDHCvyZBI0zUje26J8nEI5lFtxcR
 mNv3yhOgAQRyhz5HwXnQ9i1PXwDSwv0dKdlp11bIlBfPSNPa9lQ4nyD1TRn6anZrOpbv
 EmcHJZKg33A9QUpZ+9sqgxVlO5SsZ+zMt2d/FSKOTPBMZrXrUI09FvApcdg1K8QntJku
 kHIJ1RTKXvv9zFHbgvdrwty/R50O1m8Jw0+fFmvq+iQufxJcEFYOUhF/XorN9HYjvui1
 hmcw==
X-Gm-Message-State: AOJu0YxbgR7ZxPLXyuUQ0AmiUzuuAAlPGcJbPGoNWW1bs0NZcUIDsJMd
 /HoZD44tCs+2P5q3GH4lLwubyp8Jw6FeoDbZX1v8gykhx4R+3z0krTRemRSgL+3u8W60UX1sukD
 s
X-Google-Smtp-Source: AGHT+IEq/afFailGRAiOLjXc3Ix3YO/u1K2pcl/z53tabpINh6myqc+u+va6p/2h5wY8v78VoiP42A==
X-Received: by 2002:a17:903:22c4:b0:1e0:b9d0:f6b with SMTP id
 y4-20020a17090322c400b001e0b9d00f6bmr3365120plg.68.1712948072598; 
 Fri, 12 Apr 2024 11:54:32 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 f18-20020a170902ce9200b001e511acfd0esm3319070plg.140.2024.04.12.11.54.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 11:54:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] target/sparc late fix
Date: Fri, 12 Apr 2024 11:54:30 -0700
Message-Id: <20240412185431.465942-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Since this problem has 4 issues open, let's get it for 9.0.


r~


The following changes since commit be72d6ab361a26878752467a17289066dfd5bc28:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-04-12 16:01:04 +0100)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-sp-20240412

for you to fetch changes up to c84f5198b0b676ad67962b5250af1b0d0842e319:

  target/sparc: Use GET_ASI_CODE for ASI_KERNELTXT and ASI_USERTXT (2024-04-12 11:48:26 -0700)

----------------------------------------------------------------
target/sparc: Fix ASI_USERTXT for Solaris gdb crashes

----------------------------------------------------------------
Richard Henderson (1):
      target/sparc: Use GET_ASI_CODE for ASI_KERNELTXT and ASI_USERTXT

 target/sparc/helper.h      |  3 +++
 target/sparc/ldst_helper.c | 65 ++++++++++++++++++++++++++++++++--------------
 target/sparc/translate.c   | 48 ++++++++++++++++++++++++++++++++--
 3 files changed, 94 insertions(+), 22 deletions(-)

