Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE066D61015
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 13:50:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlSP8-0007Gy-Sn; Thu, 29 Jan 2026 08:49:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlSOF-0006bp-Gn
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:48:57 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlSOD-0008Ui-Si
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:48:55 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4806e0f6b69so7415935e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 05:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769694531; x=1770299331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i39vnueW0R6mJX0qhth54AsfO2wnFdadpiJr87YviR4=;
 b=tnHVOhfwYTDELr8xtXM/tF077RZmD7GOTkgCHz2VdQ4j+8/LlTvEx9FTR7xDbYYKiB
 j7rpzmL0WZOunE4p4bPGRQ0jBQ0OTUSipI9S4ORd2WaLeQf8CvfKtRCIVwNK0YoA6jLj
 slKeelhlYZfrSeJTEOaPsZcI6Ssa2qvvR6N47brqzYChZ0bIaynKjxHk2VX2oDbRAXms
 326eDlSJ1fnq8UL6W3uKRt6CRazrCcL6phoK07W0/afczn7ZKgHL53q2g+9z6pkuG7oV
 GCPHbpLufeiP8OkH2+/cUDAgo2yirB02QdFdUOB8j9bzTUDytcflKc4vczq3yP/rPft4
 busA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769694531; x=1770299331;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i39vnueW0R6mJX0qhth54AsfO2wnFdadpiJr87YviR4=;
 b=i5MNTgQgE7WFu3xkgV3epYeiVeQRC4NWTAzELER3yLjEQ2y3tV5y6qwYmjh+OUbSuy
 zg0QfgDpZbXcDgdEdt8dkWazk0zchEUpWiG+PdZ5PrNHqXCRngper1ptYgLMMeHr/Wkd
 vE7wVxOyzVU7N6Ceh/agoPyH3ZxAohkGIUO1ZBsWYBAbnZoMu+t/VOXhwRqfni1AuTIu
 dFVvpOBN3shQXsZLOvqdcvCZWv88G6dGRDkwwdYVp0RwDXhGT//rvN9MZpqR1QZDO/FQ
 QiAcYO1xKMggKWut93TsyuGzdWl+i1z0O9mTpDXkh9igmhMEFBVOA9TN0yCI+H7mLpAd
 0cqw==
X-Gm-Message-State: AOJu0YzLf7nPnetzkzWc310X57eJ4eNDA0roqybt8O+5j1r1tQ7kpuBs
 nHhRyg7xXXCqjlYA45JJVN21brzbfA6d+6apxTmeGzftFRgpVb2YDdt3sM/nyg9+p1i9CeDcL7x
 gK1k3qdk=
X-Gm-Gg: AZuq6aJcVCJvUOgkwYLSm35omUX4kl+vTL+cphtvZPygtr/WekfZ5ELsdl5p+ieb27u
 UxiliwHtEeLKei/vxiu7z9fRgsvgETNyxQ0qsAOpfsJt1m2eB8ihieNhUFRwjcteA/oFdNoxEwR
 ULPhgEdxPK0PLnbQAxuZ7Hj2ffCP8znltcJrb0GUfv5O1VBXcWmxVqNMkVzpLZqW9C5XOgx32pK
 587hCMPlaEW9QbmCgMi2hj5LNL0d84L+39euuRv/bjB6tm5iBUkWfDwn/mijLPwqaz6+Sy8BwNZ
 KXPhwxNrBgdpImrK0yC1Jc8Dz1WBoaAagN4kTt9E2/syF/vohrQod7GujO2ER7Xn76NbtingRTJ
 MAqrRJ2rrUM6tVfuObtbVhdpxT41J7gsJEm/oNdwgcU1lj64uopF7j0xswD8VfbJFkFf4nevtsE
 VC6UG5CiiuXFCAb4tMkVFRlJHigBtV5ws1Y7iACXKaMCwekz/dCQCe0Sch9rnm
X-Received: by 2002:a05:600c:1994:b0:47e:e2b0:15b8 with SMTP id
 5b1f17b1804b1-48069bfa73bmr114142145e9.4.1769694531006; 
 Thu, 29 Jan 2026 05:48:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e1b21fsm4400745e9.17.2026.01.29.05.48.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Jan 2026 05:48:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, devel@lists.libvirt.org,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] target/arm: Deprecate '-cpu any'
Date: Thu, 29 Jan 2026 14:48:47 +0100
Message-ID: <20260129134849.36557-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Arm '-cpu any' is aliased to '-cpu max' since more than
5 years. Deprecate the former in preparation of removal.

Philippe Mathieu-Daudé (2):
  target/arm: Remove dead code
  target/arm: Deprecate '-cpu any' (remplaced by '-cpu max')

 docs/about/deprecated.rst | 8 ++++++++
 target/arm/cpu.c          | 1 +
 target/arm/tcg/cpu32.c    | 3 ---
 3 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.52.0


