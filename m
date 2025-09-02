Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5B9CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 16:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utUDf-0008Ey-Mz; Tue, 02 Sep 2025 12:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1utUDe-0008E7-5I
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 12:50:54 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1utUDc-0004PO-DG
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 12:50:53 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b0449b1b56eso201125166b.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756831850; x=1757436650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BrVjWsHcZyingugi7ctu2XV6MLij18kQAJ1wqTXEpSY=;
 b=Q3xuiQKLQzcPuXotfKoE3v3OJZkcAZiVvcHsK8amhD3uUAL5Mrsb2nLK1vNlxkL5ZI
 KgFTirI5DINOXc7RHJOLygXLarEBfNLll7L2EadzgyaPgUvAY1alVzHYrgDBeI/dXI20
 sircMSYpEAeZN7t30DuqMNplc78O1+HDUr36DQEjJRFzfZtXqU/7maULGt6GwBSoZFKK
 iWNaZbS1zzqTjyK5mPIR/quoDGBU2qvXnR5rzHgTBPU/KuAf6JFOjwTvLlF3DIDJQBLh
 NEZFqzIq1ow+zG5IV2atT+aaQVV+K8p4P4l/9SDAZTnjg3PPu7LeonrDqOXaetkCwScG
 Na5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756831850; x=1757436650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BrVjWsHcZyingugi7ctu2XV6MLij18kQAJ1wqTXEpSY=;
 b=DPt4YiYU8nBQyG0+HQkfSXPV42QsiFt09vIQ0v4VDbvra1QytxaUH+xKFiexIQIG2e
 HrYiuO8eX9tq1NWL+OtzD9dvVxH1LBTly5SwRiI0jDTWbYMlH9cWX6Cu1Lrjs1iN5IfD
 m9GGShIjDtUfdaIrSkhDdTkEESak4EBMXzggi4QviUZjusapdjiPv6iLrXravskZ8QjI
 5pS/6r42GsFQbxLvxgdP0nlP4L0MhC9HLmCyyaRZOB22rW2LkTMRMNfz87roLDIYHOUB
 4LrQhTmIRKyqmDYXoLK3UaqMFVGusL1qlNjS1O7e+ODbavvwrdUirZvq6ts5GU4QyuCX
 rjWQ==
X-Gm-Message-State: AOJu0Ywz5EX3xUhFYgnDJAF3jm4bZWfFSPhplPap3BD6gXxlHMUNr6bD
 SRlLTovbx2UL1azqbTSIrQOLJ4vTZ0W01RBXtgJqosUb6p12iFamBo2GbzqV12aHxO8=
X-Gm-Gg: ASbGncvkHw8gcgFOraqtDDnAek+Sf4G/M/lv3sFEMjzwksnzvnzlwlWz10sYfEevQzB
 N9O1yy/OxuIS+PooPuRZvOkw2aHQUkTVkoFPoPMD0XhmSKt0mPlzDlWkFSAxjTVmP70Q7Z/p7WM
 Temz40UYAgGUjIRb7is6CSdF5J/PuoxpG8ErPTshP4u28w9K1yXNTPvAlwkc183Imn0Q1Wn0FL8
 WLIM7QBvIo/eZch/IF4M/mQvKQ+KTZjbhEvLuaPkD3E+0vZ7UZzIluGX4+smyZFv/J3FSCDmHzy
 IcSaEyCJJ6qts2tPFCDgJSyONQmMOATjKA2pkIvGp7r4HD+Q9mYFonMzH7ZHTGko3nBGtDfQ3/o
 WsBgMjWUBTVTXKHEu6eATKpjwqEUpE6EuFw==
X-Google-Smtp-Source: AGHT+IEeJxb8P67X8byzzu7f7TFVuVXRh5jN2TohRy1M0QtxrvsUlbJ3XKN1eTbeHz06pKr96Exj7Q==
X-Received: by 2002:a17:906:9f90:b0:afe:d1cb:6327 with SMTP id
 a640c23a62f3a-b01d976c577mr1262831866b.48.1756831850326; 
 Tue, 02 Sep 2025 09:50:50 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0420a16c32sm624240866b.94.2025.09.02.09.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 09:50:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D0C1B5F8D8;
 Tue, 02 Sep 2025 17:50:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/4] docs/system: unify the naming style for VirtIO devices
Date: Tue,  2 Sep 2025 17:50:46 +0100
Message-ID: <20250902165048.1653323-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250902165048.1653323-1-alex.bennee@linaro.org>
References: <20250902165048.1653323-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

This makes the index look a little neater.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/devices/virtio/virtio-gpu.rst  | 2 +-
 docs/system/devices/virtio/virtio-pmem.rst | 6 ++----
 docs/system/devices/virtio/virtio-snd.rst  | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/devices/virtio/virtio-gpu.rst
index b7eb0fc0e72..39d2fd2d21c 100644
--- a/docs/system/devices/virtio/virtio-gpu.rst
+++ b/docs/system/devices/virtio/virtio-gpu.rst
@@ -1,7 +1,7 @@
 ..
    SPDX-License-Identifier: GPL-2.0-or-later
 
-virtio-gpu
+VirtIO GPU
 ==========
 
 This document explains the setup and usage of the virtio-gpu device.
diff --git a/docs/system/devices/virtio/virtio-pmem.rst b/docs/system/devices/virtio/virtio-pmem.rst
index c82ac067315..0c24de83ec7 100644
--- a/docs/system/devices/virtio/virtio-pmem.rst
+++ b/docs/system/devices/virtio/virtio-pmem.rst
@@ -1,7 +1,5 @@
-
-===========
-virtio pmem
-===========
+VirtIO Persistent Memory
+========================
 
 This document explains the setup and usage of the virtio pmem device.
 The virtio pmem device is a paravirtualized persistent memory device
diff --git a/docs/system/devices/virtio/virtio-snd.rst b/docs/system/devices/virtio/virtio-snd.rst
index 2a9187fd701..3c797f66e03 100644
--- a/docs/system/devices/virtio/virtio-snd.rst
+++ b/docs/system/devices/virtio/virtio-snd.rst
@@ -1,4 +1,4 @@
-virtio sound
+VirtIO Sound
 ============
 
 This document explains the setup and usage of the Virtio sound device.
-- 
2.47.2


