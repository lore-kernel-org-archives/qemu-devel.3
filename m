Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64FFEDE9AB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4qp-0002bl-FO; Tue, 10 Sep 2024 13:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so4qn-0002NX-A5
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:40:25 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so4ql-0004sK-8d
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:40:24 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7178df70f28so832121b3a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 10:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725990021; x=1726594821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7IuVk+4j8sLSrVGUPeyOAaGe996Ji2rvk6igp9easzQ=;
 b=le+W0nwCevLDcF+sqwkCcXUchGY4Z/SIV3ES+dAmATsGilPFooST1leunQTx6w6a7p
 RkP5qr9NvmUlhIEqchmAq90C+er9qLuEEW80WD4bkm8FHYmlM2C4IAJhtG+mzIFjS/nD
 GwNvxcZdGzSScerAZ1kNcP7iLnQslB+CqW8MMAj7srTl+mT+l3BC2TIa0krT7C0lc7PP
 fghuH8A26vZ+gc3tdnE9xRP//mu1tCxZ3xWWxd4yT+gizMwmJdcY16h/+rck1Bzj+nRx
 Trt/TJKrCBLNx173n37Idc+DxZvHBHBSAKgDAUNqyGNMdjyA6GxEecuW95wb/+Yh9uEk
 +Sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725990021; x=1726594821;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7IuVk+4j8sLSrVGUPeyOAaGe996Ji2rvk6igp9easzQ=;
 b=DYgsGVil5PUHetgZiehYpFobJmNXdq1n9f62gNB+jb2O9dylMlikACEXZ4i4NAtQEo
 pPhAA4umehFCp3BhV5XBkWJwhwM+4rWnFuvY6ujhNR+y4B3dgV/UhqW8qfD1qUnQksqf
 PFqV9bbJBI4Igr5RNwUOVo7lzUVjw8Zj9tNF0Gl2mowMBc4cgymJjR6WveR6d8J3v6jb
 sBRSx8mac1YJ39tKsW3O4UAhySjeUGM11wSHw9YcbTz79p/LJ48DrYwjf93rX9KR30FO
 5HCVmOb9B+uCNZfCOT0NyGxjgljBg7F1Uz/6YXfOABlM/00CWY/pDe7SE4q3pG7LXI4B
 NQfw==
X-Gm-Message-State: AOJu0Yxz+WsOq07BmH8G8iyi4udpzAiJojsw5ZMjj9lQ+bJ2kAC4vAFs
 bEiLAfvRoOz5LPxW4jXjzi0UKKfRQ7vaPM4tS+JCQMu2ljz0fAETPoP1zTCKiiZy1hsp1cjYeOV
 XLPyAcA==
X-Google-Smtp-Source: AGHT+IElvFQY+4wSOF9AHzT+ZFuOHW2i6wZqAogDfq4RXoum4LbG220eqTylWzBSlE9N9DFYJSnNEw==
X-Received: by 2002:a05:6a21:458b:b0:1c8:a5ba:d2ba with SMTP id
 adf61e73a8af0-1cf62cdaf9cmr652112637.22.1725990021601; 
 Tue, 10 Sep 2024 10:40:21 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db04966d3asm6682751a91.38.2024.09.10.10.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:40:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 0/3] build qemu with gcc and tsan
Date: Tue, 10 Sep 2024 10:40:10 -0700
Message-Id: <20240910174013.1433331-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

While working on a concurrency bug, I gave a try to tsan builds for QEMU. I
noticed it didn't build out of the box with recent gcc, so I fixed compilation.
In more, updated documentation to explain how to build a sanitized glib to avoid
false positives related to glib synchronisation primitives.

v3
- rebased on top of master
- previous conversation shifted on why clang does not implement some warnings
- hopefully we can review the content of patches this time

v2
- forgot to signoff commits

Pierrick Bouvier (3):
  meson: hide tsan related warnings
  target/i386: fix build warning (gcc-12 -fsanitize=thread)
  docs/devel: update tsan build documentation

 docs/devel/testing/main.rst | 26 ++++++++++++++++++++++----
 meson.build                 | 10 +++++++++-
 target/i386/kvm/kvm.c       |  4 ++--
 3 files changed, 33 insertions(+), 7 deletions(-)

-- 
2.39.2


