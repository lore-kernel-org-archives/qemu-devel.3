Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2B4CCA471
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 11:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3YzJ-0000Vl-6r; Tue, 30 Sep 2025 07:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1v3Yz8-0000UE-G9
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 07:57:34 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1v3Yz1-0001bR-6i
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 07:57:33 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ee15505cdeso4566492f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 04:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1759233441; x=1759838241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YxDOVkEyGo0OGUeuSAKTdiFhdGIyySSchCgCk2JXJ04=;
 b=ZA5KAAR0zl8REjurIcM6Lil/CyVsyxmM13MalOyqZBh1Mjz5aKArOrAiOnDVCQovIK
 pfrOGhs33p3ZLXG0xHx1k2JM0pB6h+wjrxJnHMj+I7EFvRUUQDdNPNQn6UgKUHd6YNzW
 2m4ztZyQ7LsG8odLG++pnClJ/xNySCAV49wj9if4PCAWZ34KN7Q907tOyQ7oYrBFA45l
 THNatwQ9+utQ+tfSFf+bWvVQGH7T6Tn56kFhwudd7bzm9L4oKATnFiwHCD5WhsG3sTAG
 dZqmXgf+QspVxbCk1kduRXxL8yXnjjbRhWUu5/0FMPxCyDwA35Q4OBB3MfhgLgTx2bkM
 +RaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759233441; x=1759838241;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YxDOVkEyGo0OGUeuSAKTdiFhdGIyySSchCgCk2JXJ04=;
 b=f1aXEdOks6BfRRVC6/OW5jK+rNJRWCDdM6+wXgLCXCFT8J2SgMQwlj/kwBUWH2hgy8
 r19WTg9LBNCbNuq3r9D/v9ug3/5A/doZf50oty36quWyzOV9SQCN1HnDdrajV7xBjPCH
 u7AuXajU6OuFKpmMqFeVrV/M6lUh2o3OXR7qJtoLLyV1neJVbdmzg7A+EsA7rBty5cif
 kMZIJc/BACGdNngo0xZbd+O89X68MiDTLY3sedcRes6HgRdB7UFTnFU1ZkXHuMFDAWOM
 SEGVt/nyTYWb6VG7iWSSiH09QKu1o7j44py4n4++/8g5xPEEHEtY1u/j2QYRH6ZHixTd
 lGqg==
X-Gm-Message-State: AOJu0Yy7oBbYJvcENWjb0GTkU5xmPIIh8ATnHiwdY2hDxiG7MFpetdbL
 cmU7qjMUCsyE9/0v9THc3dk8t4rEbohEvt6ET3ToykDwlS39H2iH/y54xe2d8RbHpyyAa8OflGc
 DNQg=
X-Gm-Gg: ASbGncv0WfMt4t7BEGw4ZaZM00drP4gPvRNW7hfbglGiWP3h+EO1QTa7XI4JkZU7KDg
 4IH+PpCsKCiYGDe+7+JkdqMK9hFeK3AEna//DVPa+6T1C/JNEOD1yPXAACwf1mPwqF0Q6RdxNxY
 4oMzjoENro4G51sQL9ySkLGqnRz5OFJq/IYNh2pjNnW63ncqLtvLqJ1avX8klPx40ZzulMe4VmV
 q3+i4tn6m7Are8xfPA6MlCHTz6zlNcsRyZABw3wF8PAcS+Mbsux+X/ATyg1qBy3eOSAKIxYV0zn
 UNxE7IpEWfo2zcYvcHImWQZrdLrwCY9mAnRSb+xWJKSV0TIuBK4VcS8YOEZQjSkgoTQG3dnAmJg
 ccU/UCaL9RZDeM14LrYnF5e1L5sEVMbZJBlvPhXZgKq6KUbyzVvuo54+46bQjBvkEb884P/nqkm
 pur5P+dSlO6JHimvujdc5ctpKeHyLX4lKchLyd5TptTKE=
X-Google-Smtp-Source: AGHT+IFzVKD6sllrtozuOkWovR1MMDak3c2rNrQE5T0s3QvYyvOnxNh0Z+/47T8pWqDfo59Bmshg8Q==
X-Received: by 2002:a05:6000:2903:b0:3ee:1368:a921 with SMTP id
 ffacd0b85a97d-42411e9ddadmr4394583f8f.28.1759233440813; 
 Tue, 30 Sep 2025 04:57:20 -0700 (PDT)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc7d3780asm22448289f8f.52.2025.09.30.04.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 04:57:20 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, edgar.iglesias@gmail.com,
 alistair@alistair23.me,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH 0/3] hw/arm/xlnx-zynqmp: wire a second GIC for the Cortex-R5
Date: Tue, 30 Sep 2025 13:57:15 +0200
Message-Id: <20250930115718.437100-1-chigot@adacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=chigot@adacore.com; helo=mail-wr1-x431.google.com
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

The first two patches are minor improvements before the core third
patch.

This was initially a single patch split as per review comments (see [1])

[1] https://lists.gnu.org/archive/html/qemu-devel/2025-09/msg05899.html

Clément Chigot (2):
  hw/arm/xlnx-zynqmp: move GIC_NUM_SPI_INTR define in header
  hw/arm/xlnx-zynqmp: introduce helper to compute RPU number

Frederic Konrad (1):
  hw/arm/xlnx-zynqmp: wire a second GIC for the Cortex-R5

 hw/arm/xlnx-zynqmp.c         | 103 +++++++++++++++++++++++++++++++----
 include/hw/arm/xlnx-zynqmp.h |   5 ++
 2 files changed, 98 insertions(+), 10 deletions(-)

-- 
2.34.1


