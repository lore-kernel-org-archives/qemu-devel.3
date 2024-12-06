Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457EEE7717B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 16:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJan7-0007hu-Qa; Fri, 06 Dec 2024 11:02:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tJan1-0007fq-RB
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:02:48 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tJamy-0006Ut-6t
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:02:47 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-385d7f19f20so1060393f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 08:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733500962; x=1734105762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lR3sL4vQ9I6CvOc01/h1HSKTuaHzREP3JJkYjTbyomY=;
 b=h2FuZMtSZq2sdnjZHDUH3QCqJaKNvs/zaUtip65ryDxUeKgtkuXk5J+OFq6dxW7OCf
 7tHv+bOwl0Hoyvb64g01BldrHKNstybJ4xzG3iecvvUV46rGehQOudenhGuhhBAu3Pyx
 0IV9xS5yiNKxRhIBv9IrVkMbrpEADFS4Z26Ng4WmkGbqChpX2nW57EULdxtF1PgkwKPi
 JDVNDGbppIQMm980jvjLXY5QWUqV16yU6pHRBZdjV60ZraJq8aSOw8M9UxxJPj/0Q3Ez
 eXvPrhYHYYCZ0/JmHDGRV+B5wImjkhVe61tyCB16gmzJzcRpuRA0Z57f853rMgvWGj4v
 +CBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733500962; x=1734105762;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lR3sL4vQ9I6CvOc01/h1HSKTuaHzREP3JJkYjTbyomY=;
 b=TjWVpU+4/DYN77mpc/U1Huh5DtCUXRGg/v09NvFgAy66vuhfmwSMMGHOYZ4bXSpqdV
 GBH6zDszOsRF+7onVtaajUraahFFjHWzF9JDCsC+yOoVpMJs9HcWrE+HvcFqtrjZGsP8
 Az3GO+A5VoEQSc91LV0hYb/PLw846QafFja0N7p/rvtvfHc2uINvYp29if+dYJDpy+gt
 aUNcDBIEAswgaOZbNg4mRFnuamQtHZ861TSRk6oiCEdmgzNWRY2uwfpCwLVMmZVKIwVE
 +K25HIYrLkTTGBIa2+wVdgNFK1U6V60EGlUNnNt3qxySODZRKSitVed0/japTs4sw72l
 P3Ww==
X-Gm-Message-State: AOJu0YwvefDtN1HZk1oXwwC7laszaB+OkdUwAR54F3xbdDahRz4LjiQ6
 jK/YMfi3MFrILuNxIwvwt6mmqZvQWZdwtaYO2wPt1uuk7aUbmpZmlVUrsdOeum8=
X-Gm-Gg: ASbGnctx7IEtM/EJu6FkUwRPsFHP3y2kOzrqxs7PbHXTP0jKQdbZ/2QOYQd4PzSBzXA
 iJYpyAT6YAK4EQXOPjC741K6U9Xvmj+2yBeEX/pXe4FzWjt7H9DX797T+SSbgAjKi5+JbQ6Y74L
 difd6Tb7jTinuicsDweG2rwzzQ9UbLn6gdpAVUTzhEC2l3+ka/ZNM12iDbHTqvraPJfX+I69Ttz
 Vv5w+uhILd/ObMSSHJtkOnXVnXA1vCfCPChImQ1fC5Puze8
X-Google-Smtp-Source: AGHT+IHjNyo4Zn3uxKcNbbT7zvtvVZdctd9lg8KomvDhsV7UrpTJJc8fIkyJlZZl0ASsvLSR8rAZ+g==
X-Received: by 2002:a05:6000:2c6:b0:386:3262:cd7d with SMTP id
 ffacd0b85a97d-3863262d11dmr516585f8f.45.1733500962134; 
 Fri, 06 Dec 2024 08:02:42 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d04da5e0sm86137845e9.0.2024.12.06.08.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 08:02:41 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 607185F8C4;
 Fri,  6 Dec 2024 16:02:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/3] target/arm: implement SEL2 physical and virtual timers
Date: Fri,  6 Dec 2024 16:02:36 +0000
Message-Id: <20241206160239.3229094-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Follow Peter's review I've split this into a several patches as there
are some other fixes that should be made to other EL2 times that
shouldn't be rolled together.

v1
  - improve GTIMER docs
  - fix gt_recalc bug
  - address review comments for the main patch
  - cc qemu-stable (no rush for 9.2.0)

Please review.

Alex.

Alex Bennée (3):
  target/arm: document the architectural names of our GTIMERs
  target/arm: ensure cntvoff_el2 also used for EL2 virt timer
  target/arm: implement SEL2 physical and virtual timers

 include/hw/arm/bsa.h |   2 +
 target/arm/cpu.h     |   2 +
 target/arm/gtimer.h  |  14 ++--
 hw/arm/sbsa-ref.c    |   2 +
 hw/arm/virt.c        |   2 +
 target/arm/cpu.c     |   4 +
 target/arm/helper.c  | 179 +++++++++++++++++++++++++++++++++++++++++--
 7 files changed, 194 insertions(+), 11 deletions(-)

-- 
2.39.5


