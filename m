Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C1FCCF9E9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 08:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stjPx-00074U-QX; Thu, 26 Sep 2024 04:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1stjPv-0006vK-IG
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 04:00:03 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1stjPt-0007nn-K7
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 04:00:03 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42e5e1e6d37so5985735e9.3
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 01:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727337599; x=1727942399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xh7WBfH5gcvBmbNvFUOwXZgfNe+K+ES49djgjpPwT8I=;
 b=HMRUBtT/PD+om96i97cfuSFLnVrbVYMmBnduamRsGKuQ7QGONVB93wIvg0kPENpz9s
 O7cURO2zm27v0ZxL577rbOq/J11lH+WII9tFsx6p5EqqTEnm2B9i7XBkGjvlrDRs3AyD
 t76M2JrRBa60DU8dtnIK088k0EX1R+Iu6HvmCBgq0VXzlJdflHXa4R4lSUpYRGybsf98
 m2cP70rm0YKcmGigY3jyQcX1UuwJM+CK8nEVRCgHHDxKhY1rtQzZisRPqXaOTLahizYJ
 /d0znvX/xBo9myzm9JXZL2rQGgdFiZKeyMkcFGInOmMQTPriFYDmRfo6PWjXvxgp4vdu
 cQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727337599; x=1727942399;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xh7WBfH5gcvBmbNvFUOwXZgfNe+K+ES49djgjpPwT8I=;
 b=lyw0iFQmN7XozXC4juipYbweGFKuDOMPwGkckT1WHRKfoySXS74RtvV7VsbBCBqIsU
 w9uiEfAeYKGNVXaFCoTcEhVIJ9Ta+kuUs1m03pxcBuVx6vTGotRAxIAP6JeurgpcM7XD
 8+G6zeejlwZbwo6r2hKeD/Sfk2togeOmMlkDXAjyyFD+gE9korZz6AIcT8rKsrnQvJaz
 um144n+rs7jX7gK2Orflid5xl9UwXcBbrkCxDt6BE1U0jpb7q7U679+Yq5pmfntYRe0r
 3rWmYW85sFZgGXsMhl+3f1BJDgfRvMtGdWOMZpFY45++6ao0KRAe8tqWFOYQmMgTfBrw
 YaNg==
X-Gm-Message-State: AOJu0Yz0GrJWqXisvjv9C9Rpy+GaPHYr8NYMr4xtuvaouk87dwJZoMVz
 3KMXwP6GBk3WBQnK21DYOv8yvu/rSREQ8Thi1y/iuuu00XWAoOv0TfWGig==
X-Google-Smtp-Source: AGHT+IEJaYS5unIe9L+EM1qJcytOeHUd7pdoISgs/B/qLy/fVql5zqZpOxTmzJfrLapDq22F+JFQqw==
X-Received: by 2002:a05:600c:1d10:b0:42c:b1ee:4b04 with SMTP id
 5b1f17b1804b1-42f55db3699mr4578365e9.28.1727337598995; 
 Thu, 26 Sep 2024 00:59:58 -0700 (PDT)
Received: from archlinux.. (dynamic-078-054-081-221.78.54.pool.telefonica.de.
 [78.54.81.221]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e969ddcc4sm39401805e9.10.2024.09.26.00.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 00:59:58 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH] MAINTAINERS: Add myself as maintainer of e500 machines
Date: Thu, 26 Sep 2024 09:59:48 +0200
Message-ID: <20240926075948.2343-1-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ffacd60f40..0a191a03db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1430,8 +1430,9 @@ F: hw/pci-host/ppc4xx_pci.c
 F: tests/functional/test_ppc_bamboo.py
 
 e500
+M: Bernhard Beschow <shentey@gmail.com>
 L: qemu-ppc@nongnu.org
-S: Orphan
+S: Odd Fixes
 F: hw/ppc/e500*
 F: hw/ppc/ppce500_spin.c
 F: hw/gpio/mpc8xxx.c
@@ -1446,8 +1447,9 @@ F: include/hw/ppc/openpic_kvm.h
 F: docs/system/ppc/ppce500.rst
 
 mpc8544ds
+M: Bernhard Beschow <shentey@gmail.com>
 L: qemu-ppc@nongnu.org
-S: Orphan
+S: Odd Fixes
 F: hw/ppc/mpc8544ds.c
 F: hw/ppc/mpc8544_guts.c
 F: tests/functional/test_ppc_mpc8544ds.py
-- 
2.46.2


