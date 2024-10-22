Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3390AD17159
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 02:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t34Q4-0005w6-77; Mon, 21 Oct 2024 22:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t34Q1-0005vB-RM
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:14:45 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t34Pz-0001Wi-Ku
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:14:45 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2e31af47681so4056138a91.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 19:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729563282; x=1730168082;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sVA3h8dGHcJJcPtq0zM3qZ8s881zYIxPG4Jh2pmOWt8=;
 b=S+xCVywvJ3/w4fMH57VS0yRNSYKV4Dhg5giX53yMYjDEwYpc7iu30PqhRJ9x7szjH+
 ikO6q31g8obaCHRJlJZLbfD/nJsNO+izCOdLfIoug6leEmBDGmi05Qw7iy4YcbsgKUmr
 3cOtwRv6oke6TCvslVSdxArXLDwTfi95/XA2iOZ1cSWTfjWtwH3qEoBA6GcCreUIphMv
 4OTDemme8FVJIyRRhnrPdq4NH2AUSoKpNnsxxylW8XmREZQPuJOjuUD2z5AsuAZb7xhJ
 dp28K0j0UmPls5zfW7OXDsTx5R7XulT0OtmpbkYbTxJFCVLcJlx6y//zPyX9ugLHeYlu
 w01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729563282; x=1730168082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sVA3h8dGHcJJcPtq0zM3qZ8s881zYIxPG4Jh2pmOWt8=;
 b=dZRLgMgNotpYdQkA2qn0sYEuwUmnQYT4kQ4RNe2ymYE8PKvAnUciRM5oqTzS2bHili
 TsuTZowt+sQ9+EQaUpD0t2wdiQ3a5tsouINf+lwANrh+2G6PwYsRp+An10yTlB9MvtQ1
 h3qeIdyPBuwUknN9aLrOJEDehYUXI9BsGpWqgDHJW7YOD114kSOFusbtsr6dOEsKCGDn
 28Kp0VM+XPhAvYSNi9Ys26O/D53pSC6pMHzPORrgd3MqqW4V5Yc0ruUVrWm5zCp2ZB6Z
 kE8hLoS84lcheC6e8Cx7KLB9GCfADFUpEAb9w7/6tHjDqMH+Qc93aT+BtpkOWE6+AcU3
 liiA==
X-Gm-Message-State: AOJu0YyTcft2NDB27MUybFn3uSG5ZT16f87wLLArT1l5XQ989h/C/rU7
 lXR302JuZziwREGhu49ueb14WAG5ouWLlK4CuLTpuwyh81PVgW+62BeAzwcnHvb15dHRX/Kdgks
 D3JS0Gw==
X-Google-Smtp-Source: AGHT+IEFp6ES0EJ9Ic3b/aaPxATEdFUK8XSINx3nS9axZTxRJCfOoTsA06Hu0NzXL6l7o8Xq4M86LQ==
X-Received: by 2002:a17:90a:4e0b:b0:2e5:e33c:99c5 with SMTP id
 98e67ed59e1d1-2e5e33c9a62mr276073a91.37.1729563281072; 
 Mon, 21 Oct 2024 19:14:41 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([103.172.41.198])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0bd63fsm32726545ad.173.2024.10.21.19.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 19:14:40 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v3 1/5] tests/migration: Move the guestperf tool to scripts
 directory
Date: Tue, 22 Oct 2024 10:14:22 +0800
Message-Id: <fe995bdedf850f4618721911fb4122621f4768c9.1729562974.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1729562974.git.yong.huang@smartx.com>
References: <cover.1729562974.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Hyman Huang <yong.huang@smartx.com>

Guestperf was designed to test the performance of migration,
with a loose connection to the fundamental test cases of QEMU.

To improve the repository's structure, move it to the scripts
directory.

Add myself as a maintainer for the guestperf so that I can
help to fix bugs.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 MAINTAINERS                                          | 5 +++++
 {tests => scripts}/migration/guestperf-batch.py      | 0
 {tests => scripts}/migration/guestperf-plot.py       | 0
 {tests => scripts}/migration/guestperf.py            | 0
 {tests => scripts}/migration/guestperf/__init__.py   | 0
 {tests => scripts}/migration/guestperf/comparison.py | 0
 {tests => scripts}/migration/guestperf/engine.py     | 0
 {tests => scripts}/migration/guestperf/hardware.py   | 0
 {tests => scripts}/migration/guestperf/plot.py       | 0
 {tests => scripts}/migration/guestperf/progress.py   | 0
 {tests => scripts}/migration/guestperf/report.py     | 0
 {tests => scripts}/migration/guestperf/scenario.py   | 0
 {tests => scripts}/migration/guestperf/shell.py      | 0
 {tests => scripts}/migration/guestperf/timings.py    | 0
 14 files changed, 5 insertions(+)
 rename {tests => scripts}/migration/guestperf-batch.py (100%)
 rename {tests => scripts}/migration/guestperf-plot.py (100%)
 rename {tests => scripts}/migration/guestperf.py (100%)
 rename {tests => scripts}/migration/guestperf/__init__.py (100%)
 rename {tests => scripts}/migration/guestperf/comparison.py (100%)
 rename {tests => scripts}/migration/guestperf/engine.py (100%)
 rename {tests => scripts}/migration/guestperf/hardware.py (100%)
 rename {tests => scripts}/migration/guestperf/plot.py (100%)
 rename {tests => scripts}/migration/guestperf/progress.py (100%)
 rename {tests => scripts}/migration/guestperf/report.py (100%)
 rename {tests => scripts}/migration/guestperf/scenario.py (100%)
 rename {tests => scripts}/migration/guestperf/shell.py (100%)
 rename {tests => scripts}/migration/guestperf/timings.py (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index c21d6a2f9e..c7938c397c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3403,6 +3403,11 @@ F: migration/dirtyrate.h
 F: include/sysemu/dirtyrate.h
 F: docs/devel/migration/dirty-limit.rst
 
+Migration performance test tool
+M: Hyman Huang <yong.huang@smartx.com>
+S: Maintained
+F: scripts/migration/guestperf*
+
 Detached LUKS header
 M: Hyman Huang <yong.huang@smartx.com>
 S: Maintained
diff --git a/tests/migration/guestperf-batch.py b/scripts/migration/guestperf-batch.py
similarity index 100%
rename from tests/migration/guestperf-batch.py
rename to scripts/migration/guestperf-batch.py
diff --git a/tests/migration/guestperf-plot.py b/scripts/migration/guestperf-plot.py
similarity index 100%
rename from tests/migration/guestperf-plot.py
rename to scripts/migration/guestperf-plot.py
diff --git a/tests/migration/guestperf.py b/scripts/migration/guestperf.py
similarity index 100%
rename from tests/migration/guestperf.py
rename to scripts/migration/guestperf.py
diff --git a/tests/migration/guestperf/__init__.py b/scripts/migration/guestperf/__init__.py
similarity index 100%
rename from tests/migration/guestperf/__init__.py
rename to scripts/migration/guestperf/__init__.py
diff --git a/tests/migration/guestperf/comparison.py b/scripts/migration/guestperf/comparison.py
similarity index 100%
rename from tests/migration/guestperf/comparison.py
rename to scripts/migration/guestperf/comparison.py
diff --git a/tests/migration/guestperf/engine.py b/scripts/migration/guestperf/engine.py
similarity index 100%
rename from tests/migration/guestperf/engine.py
rename to scripts/migration/guestperf/engine.py
diff --git a/tests/migration/guestperf/hardware.py b/scripts/migration/guestperf/hardware.py
similarity index 100%
rename from tests/migration/guestperf/hardware.py
rename to scripts/migration/guestperf/hardware.py
diff --git a/tests/migration/guestperf/plot.py b/scripts/migration/guestperf/plot.py
similarity index 100%
rename from tests/migration/guestperf/plot.py
rename to scripts/migration/guestperf/plot.py
diff --git a/tests/migration/guestperf/progress.py b/scripts/migration/guestperf/progress.py
similarity index 100%
rename from tests/migration/guestperf/progress.py
rename to scripts/migration/guestperf/progress.py
diff --git a/tests/migration/guestperf/report.py b/scripts/migration/guestperf/report.py
similarity index 100%
rename from tests/migration/guestperf/report.py
rename to scripts/migration/guestperf/report.py
diff --git a/tests/migration/guestperf/scenario.py b/scripts/migration/guestperf/scenario.py
similarity index 100%
rename from tests/migration/guestperf/scenario.py
rename to scripts/migration/guestperf/scenario.py
diff --git a/tests/migration/guestperf/shell.py b/scripts/migration/guestperf/shell.py
similarity index 100%
rename from tests/migration/guestperf/shell.py
rename to scripts/migration/guestperf/shell.py
diff --git a/tests/migration/guestperf/timings.py b/scripts/migration/guestperf/timings.py
similarity index 100%
rename from tests/migration/guestperf/timings.py
rename to scripts/migration/guestperf/timings.py
-- 
2.27.0


