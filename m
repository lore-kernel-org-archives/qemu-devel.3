Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76F6D3DEA4
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 18:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1rfD-0005Q3-Kw; Fri, 18 Oct 2024 14:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1rf7-0005PH-UX
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 14:25:23 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1rf4-0001zA-1I
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 14:25:20 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20c9978a221so29198735ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 11:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729275916; x=1729880716;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZpMHIY0r4zxTQh2swSvg+GZsV7fq2GTEZc/p/hvrbE4=;
 b=SBXUet/pqrJXcvps6zicLTVALIoT9M6Aj1rT0lSk3HXFufKbTf2igVgv6Ce0x7og70
 hJ8rdKnq26kuGkwUFsAEltTD4hxKPud+f4psk9mcZU5H6uWvfE4lLSzqpyV8Y2lBZU2X
 Jh2uqiPKBYCzFTeNwnUk9zn7Pt1ORI3NeWVzAfrReW/pmIBtxMZHEQlOEYpUOjkQVsvc
 AJQ1Vnlt8jYo11tPhPgqk56dB5oHSQcPovG2EjHx1e2pD86GiRGwrKQKoBQd9P3DrOtj
 NW4DyGWjeOTJSpUuH0eup7BM/ObC99mGCpaJOff4ukouOi4uE8lX4kEbX4mMdnBUQVQI
 TiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729275916; x=1729880716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZpMHIY0r4zxTQh2swSvg+GZsV7fq2GTEZc/p/hvrbE4=;
 b=Whon2Aix6L+BwnRZ8CjIhS+okHk5gQnlLQ4bVbr6MqAIqWsl3b+mXok+pUP6TKfoxJ
 6+YbZMBG9yUD0kXVKlJLO0JHw1u7l2N0TcsQZE+MiRmLecDXKGvGCe/OEvKpgMNRb9H7
 10IuA1DmNI0VzL5PxkoCiin497XxFc4geUs26/qwRweJhM1Y0u53HPDVLF6MycMWJzbl
 ycWcrbvP3HcKedNGUFDKliWa8+liei7pBJ3IDoQi0EUT2D3u+tGVwrACpy1Z9v8WTfXv
 zj+EBkGk6F8Z5CweXcalJTchnZLxpUrGhHHMvoGBOzPlEaY6rOPeWOrha9AhWCW+ZRDY
 APGQ==
X-Gm-Message-State: AOJu0YxI4qt8m2bcXFEv+eI9Oo/WGq7l4lYfN0WYmIhVhZR4uuHhm3Lz
 gOfKsFiwrV4xOucIdon3nIAVnJNJwmA9K3MtgW/YtrKT5lpZkRtoG30O+SzLfrXcS7fEhY4FvZh
 3EvfuJQ==
X-Google-Smtp-Source: AGHT+IEtz96fYPzf4dHP4pscg+MEy3hQE84ygZJv276gzdCQN1gO7XZivLnVUty0o416TTwahEQgIQ==
X-Received: by 2002:a17:902:ea02:b0:20c:9821:699d with SMTP id
 d9443c01a7336-20e5a915380mr40552935ad.51.1729275914998; 
 Fri, 18 Oct 2024 11:25:14 -0700 (PDT)
Received: from localhost.localdomain ([118.114.60.204])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e5a8f2034sm15668475ad.193.2024.10.18.11.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 11:25:14 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v2 1/5] tests/migration: Move the guestperf tool to scripts
 directory
Date: Sat, 19 Oct 2024 02:25:03 +0800
Message-Id: <52c9b1f94ef5a9451e462a27ca8386190317e22b.1729275266.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1729275266.git.yong.huang@smartx.com>
References: <cover.1729275266.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x635.google.com
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

Guestperf was designed to test the performance of migration,
with a loose connection to the fundamental test cases of QEMU.

To improve the repository's structure, move it to the scripts
directory.

Add myself as a maintainer for the guestperf so that I can
help to fix bugs.

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
2.39.1


