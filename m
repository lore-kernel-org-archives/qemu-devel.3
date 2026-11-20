Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD4F606A6E7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yqlh4h3/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUtH-0002SE-Rb; Fri, 20 Nov 2026 15:07:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrN-00018t-UA
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:27 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrJ-0001tC-U2
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:25 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4a5024b3c28so1583713f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 12:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795205120; x=1795809920; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hUFQQ8sj0j4/Hz8OMPzhHPjybXNI5XiY3VTlYBCz9kU=;
 b=yqlh4h3/81UaQ1KXfHHsG22JZWxIlq5CLU765967P849B8LEVa8Ti9yFzAvhgAJ9fs
 ipBFPCZbaZ06fY+oU3PZQILm/S6TidPGAjyKAM0FUpkw4gHEHmXlUCRT8Qo3Wzwqyb37
 4GUxR+3J7QM2jfYADpHHAVy07UePgHCO8oRerXOKPSt9llqZZFrKC7YY5Ejh9vzW/Kwj
 kZzbAsi/meKhY+ZUMzvN+Uo4AMUzJF6Pq6KX8BAaWzX5nSk/O2VJcLAPzCEucNlEXdl1
 znJU+fujTzlTbT5Bo7ER4hK8ojWIhg230rD8M1YTIirYP9/HUB/2dcW7/wOAbWGxlDK+
 aDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205120; x=1795809920;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hUFQQ8sj0j4/Hz8OMPzhHPjybXNI5XiY3VTlYBCz9kU=;
 b=jvgTqIAwjtao1NEtZJZRD6zVewdzJIK8kR7nQfp3J7841yrVO6MeH0fgbI3OWqNTas
 u4lGPCLRtf/HUSw+5h3rJuAUOYrkMA63Ys/PWd0yNe0Th7uAjDW2G6BL97NoXNhoivMV
 K2Z2uM67uiHeiQhuF/tw1ti/4Q2aLBIHjFmCsW6HHf1dLJpnKah7ygAjOxnjDoil7vWc
 ycQfbsCe7cfg4qPrGXrdx/3n/vCrnVegWaNNQ3RiMaIJdqkPt1nUfzHUJgCrZYuZwfDh
 tHy1OBv9ozhbdLeBbvsG/zKPlgcuSyWBd73jmMkEieay7ng90GVOXQ/pmFfrSNJBa44r
 TNRg==
X-Gm-Message-State: APuU4Z9f9MghIV0k2exCawQkCdsLFSBPDqYVvwDVysNwTtAnOEOozEEa
 j+TfskAC4MQLHoEHEPO6+0TB5Db5a0WAMjxm73DGHuSCvGKF/rik0Moz/deTE6ZP2g0=
X-Gm-Gg: AYBFou3nKkiYclT+TEIdDWJDacgJ50/RFtFFqtQU5LZhqWvT5uNk0dnRBlrtpN40YSk
 ppg0n8lxeVN1g31D+QV9SU5Xg8MxVc6TBGaPnXYua6efXYdFwUGOf17HRPDY7SgtEmkp0EkdnN0
 b6PvqYpRNvYDddtkiloK08pwuPZC30x/wmKH1fBYERjNZmBw8qyPZxd2CorgiVVGbD83iWEBkI0
 jDJ8n+KwD+e5GEYaiPsOzu6yTxTuyqOAW8l2Ig2TVUkpAjcsOsqUL1BTSoTLBXv7e1tOFpArN19
 bGihHFeCi/7SWPfVfx1LbjAuuoXJ7dfaNHG7hLk2nbpJmNpHmTHD6kyyPPSegyQuQNvYJCUmotP
 sBdUuUzD/ZFEPa2QS0WjGWrgeG9ZwztrnlJdtnlC2Fl6l489qz2ADWpZ0kyLeBzAK8TvhHhjbi1
 7A+ns1iGRjBFL/25R2cX0+Kg7yRxdkyIKbyiEJFwfFaN+Tqop8tgGlQVXnX/vNEzJHOm/QrU8T3
 7JaK9vMUad6bp2bvCkNM/OIZJZdafWcVgCYMiDJW2F1+wJTioNZeWULCmVw6dDN92QnJzkrLXyN
 /tMfPAN/aFdVagYySN3lBLLHZ/dJ
X-Received: by 2002:a05:600c:4585:b0:4a1:c6f5:2450 with SMTP id
 5b1f17b1804b1-4bb8881b8e4mr95685595e9.17.1795205120467; 
 Fri, 20 Nov 2026 12:05:20 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8960068fsm35067515e9.4.2026.11.20.12.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:05:17 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6D9F25FB12;
 Fri, 20 Nov 2026 20:05:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 10/22] scripts/get_maintainer.py: optimise glob matching with
 Paths
Date: Fri, 20 Nov 2026 20:04:58 +0000
Message-ID: <20261120200511.822573-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120200511.822573-1-alex.bennee@linaro.org>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Using the built-in Path.match() method essentially ends up
re-compiling the glob pattern every time we compare a path to a
maintainer line. This really slows things down so skip that and
pre-compile the glob pattern ourselves.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/get_maintainer.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
index fc155028cf4..63983064013 100755
--- a/scripts/get_maintainer.py
+++ b/scripts/get_maintainer.py
@@ -16,6 +16,7 @@
 from os import path
 from pathlib import Path
 from enum import StrEnum, auto
+from fnmatch import translate as fn_translate
 from re import compile as re_compile
 from re import sub as re_sub
 from re import IGNORECASE
@@ -98,8 +99,8 @@ class MaintainerSection:
 
     def _expand(self, pattern):
         if pattern.endswith("/"):
-            return f"{pattern}*"
-        return pattern
+            pattern = f"{pattern}*"
+        return re_compile(fn_translate(pattern))
 
     def __init__(self, section, entries):
         self.section = section
@@ -159,12 +160,14 @@ def __str__(self) -> str:
     def is_file_covered(self, filename):
         "Is filename covered by this maintainer section"
 
+        fn = str(filename)
+
         for fx in self.files_exclude:
-            if filename.match(fx):
+            if fx.match(fn):
                 return False
 
         for f in self.files:
-            if filename.match(f):
+            if f.match(fn):
                 return True
 
         return False
-- 
2.47.3


