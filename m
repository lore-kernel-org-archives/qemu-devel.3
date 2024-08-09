Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4113C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 07:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scKK9-0002jI-8A; Fri, 09 Aug 2024 03:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1scKK7-0002hj-Tp
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 03:46:07 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1scKK6-0002w6-7l
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 03:46:07 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70eae5896bcso1629879b3a.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 00:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1723189445; x=1723794245;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SlUMRFbIZO8Gfc3E5mF3qJaWebgi/RdemF9uE7TuxV0=;
 b=WZXxWtAzeqpisRfuQoHV4hwv5GIsUPQlCdExMGJY5TvOZKXyjJpER0Q+/cHIkOJSh0
 kjXQUI9vUUW4NbAREoV4M8rOvZedCkqbd5jyAfKfxN6rTR+puDJmRumbp3LKYdsi5GAF
 7k+dN5+9nD0dW/juWknKXjw/XjMoo8J+2c7R+aiB3pkQSmOwuTsNTpmLcty+SmN0cmHV
 vSu+GYZB2Ny/mCZXtkZ+CFpC1hdeNKkPFrtZExwkQg2YH++bpsbOZuGMoqJxjlY0Ui9w
 E+3noZGXqOQcfaUHgprT3plf46x0HkIWUrgc6dzlDaKaHLafXYdgwJWMm7aibFSiOA0L
 2psg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723189445; x=1723794245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SlUMRFbIZO8Gfc3E5mF3qJaWebgi/RdemF9uE7TuxV0=;
 b=D0i6Juzoq0FlTsq3cZ9e0X8sCRFLBpsUOk5yjEl/reTH9e69KXyb9oLKw1LZTsyHgb
 mETYHWf6MF9Sc21snwOMIOJ5YjKbY9SLbP7j+VvfswkG1ByMv6d1bnTZ7BcaZtOqCbJk
 rgUu+jtSa9XEjZTAdFUZfr20dfYl+WXSbFyMMia8o1U6xxQVzKIcQgDV5DrCw7EKqqwY
 qZqfx2xGuZPYlNhgyo711ovExOOaPUmfH6Mg0qOPNSwHrXNdiJNv2et+SF/rY91qGOQO
 tDZY77zSpv7dKx7ltbN08igYliqpl1FcAuK5XYadN/W6L5PhF+IVrAouU3qH1HZufOGJ
 9rdA==
X-Gm-Message-State: AOJu0Yxy6DmOGfh4fVzy5X/Ucmf552di677aaRr7uVfUi5uvio/hak+3
 6giRru+ZNOrRsPg5zZYubOXdXuFfhipUwTKRtMNphXHT9JF23LZWwPJ7nP0cXMksumOvqqRxpMC
 vvMFOJQ==
X-Google-Smtp-Source: AGHT+IF5iobtFcYdnhTu/Lt/GRAoBZbjdDXVsWBKry9PHxVGt1lgaqOC0ClvdyxysJSXpUjnQbvqkQ==
X-Received: by 2002:a05:6a00:1482:b0:70b:152:331 with SMTP id
 d2e1a72fcca58-710dc79c6e5mr700352b3a.21.1723189444297; 
 Fri, 09 Aug 2024 00:44:04 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710cb22a455sm2123212b3a.71.2024.08.09.00.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 00:44:04 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v1 1/5] tests/migration: Move the guestperf tool to scripts
 directory
Date: Fri,  9 Aug 2024 15:43:32 +0800
Message-Id: <38f6c0a2385f75f437d2b8b7b5fa82adacc2879c.1723189080.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1723189080.git.yong.huang@smartx.com>
References: <cover.1723189080.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
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
index 10af212632..dae1535dae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3449,6 +3449,11 @@ F: migration/dirtyrate.h
 F: include/sysemu/dirtyrate.h
 F: docs/devel/migration/dirty-limit.rst
 
+Migration performance test tool
+M: Hyman Huang <yong.huang@smartx.com>
+S: Maintained
+F: scripts/migration/
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
2.11.0


