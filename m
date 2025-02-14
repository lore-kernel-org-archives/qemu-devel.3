Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF80BC021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 10:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1titNG-0003FP-0B; Fri, 14 Feb 2025 05:56:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1titNE-0003Et-FI
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 05:56:44 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1titNC-00069d-Kd
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 05:56:44 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-220ec47991aso9439135ad.1
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 02:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1739530601; x=1740135401;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZVFXlsrJ6uqFDQzwPn+Dorbteo5aZgEE94Bb7QudTvo=;
 b=dgZo/Nt5YdrkQTHGKxUbgFjuw0RG0glfXLoT/qzrABKh/ANW8Uyh6Sr/hE6AVlSuQz
 lSOWqcZ3/byYHX9UInIOSGebyjHUiWvCRAaNNc+mHYbTdsFaPbqxW9kFVb2ZwDMCQzeU
 s0zkoxuO7BUZhLMfTstfJVBYkpIXBpLWBO3vNrQQT91k56FX/JgCe7t+D7YFebM7ZDv4
 eyPMXBUq1k1F0SrnLQabGwmZItSYOjzqO0kHlF8wYD7EbaSWCRcy2Hj4fUNPv4qB9yNp
 FcL/TFGk6Y+W4BYnmhSHA2ACxVJvUnPNF2d2vggkacu94+q+Vbyww6b78hkgjS+e1lAc
 42FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739530601; x=1740135401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZVFXlsrJ6uqFDQzwPn+Dorbteo5aZgEE94Bb7QudTvo=;
 b=nJfGJu/bjYERoVDr0A8uV8ASKxWpvTGGnfhx69L6LVE84ziS8a2boVkEDy2zmKgCgg
 u8KXkNLXK12abQKGDAxF+I/eJvqxeWhTv52Cny7sG4Jyr3O13WqWDW02zmbaZpOAKxI7
 SOTGHO23wlPBu382AJDIBd+pQx9aVfYROsutmtuqZj7XOCpy3fgeBDoEQRfUPJCCdcSd
 c2BpTZrMrOoroGmh4r4XwqkWm8KqZEM4vxpTGTf4EQum61mFFNhYWrflWY9mgTbgNr+9
 VPzjvNZAKsArqLViTkYDIxewdU+9a5aCf8wbUmGhaxhouUjDKpYRdOhWjrGx+9IbAEAF
 bPWg==
X-Gm-Message-State: AOJu0Yya0k029fmTU1k1ejlzcHQidIC6M0ms9uIa+ABddG5q4aNWvWx2
 6D5fPL3bCtfRPhUAF34QYRqh1iD4rj3w4GWkemdc9QE8bwSAyrpr/0Y5Ra5dP7iH4SfFEhDoWih
 vFtv3PA==
X-Gm-Gg: ASbGncuVpBHe/SW0NHp0UyMHHDLfyHkZqPQ4jYRfvN//Gzoe1C0CxFrq9ke8ayXX0JP
 uTnFq08mm7FUDRgeTmH1adiAmLwRqF710Vh6v9kidP4uiHg4WtGbFJCQKLl9lfQOLPJl45dLElo
 it22WA69lpVQFTMgNcO2mX2rJJGl71LsSYY2tupJxtlrWvQdGMrl0v6v45YKcwuaSBLt5AdABZL
 kiv9ILlJaaBz745300jmwO9N/TLYrFr0tSHdaRCVEkyRzH0MYM/Y5B5v4HuswIp0MU8cxa6mEoE
 K6ySZcHa0B4gigJOAly20oUij50+3ZoiN7+sKAjZ
X-Google-Smtp-Source: AGHT+IG7qDL6HFucRj/cfgbNRg6VneqkP4zmomZUyyp/wyuyUvPtqsICTm2cDY9Wg8rZ/Rs2HH4bNw==
X-Received: by 2002:a05:6a21:32a4:b0:1ee:7c01:d20 with SMTP id
 adf61e73a8af0-1ee7c01118emr7104340637.31.1739530601003; 
 Fri, 14 Feb 2025 02:56:41 -0800 (PST)
Received: from Hyman-Dev-Euler.zelin.local ([154.64.226.178])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-add0987b223sm535013a12.17.2025.02.14.02.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 02:56:40 -0800 (PST)
From: yong.huang@smartx.com
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH v4 RESEND 4/4] guestperf: Add test result data into report
Date: Fri, 14 Feb 2025 18:55:26 +0800
Message-Id: <6303400c2983ffe5647f07caa6406f00ceae4581.1739530098.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1739530098.git.yong.huang@smartx.com>
References: <cover.1739530098.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x633.google.com
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

The migration result data is not included in the guestperf
report information; include the result as a report entry
so the developer can check whether the migration was successful
after running guestperf.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 tests/migration-stress/guestperf/engine.py | 10 ++++++++--
 tests/migration-stress/guestperf/report.py | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/tests/migration-stress/guestperf/engine.py b/tests/migration-stress/guestperf/engine.py
index e11f6a8496..d8462db765 100644
--- a/tests/migration-stress/guestperf/engine.py
+++ b/tests/migration-stress/guestperf/engine.py
@@ -24,7 +24,7 @@
 import time
 
 from guestperf.progress import Progress, ProgressStats
-from guestperf.report import Report
+from guestperf.report import Report, ReportResult
 from guestperf.timings import TimingRecord, Timings
 
 sys.path.append(os.path.join(os.path.dirname(__file__),
@@ -276,7 +276,11 @@ def _migrate(self, hardware, scenario, src,
                         src_vcpu_time.extend(self._vcpu_timing(src_pid, src_threads))
                         sleep_secs -= 1
 
-                return [progress_history, src_qemu_time, src_vcpu_time]
+                result = ReportResult()
+                if progress._status == "completed" and not paused:
+                    result = ReportResult(True)
+
+                return [progress_history, src_qemu_time, src_vcpu_time, result]
 
             if self._verbose and (loop % 20) == 0:
                 print("Iter %d: remain %5dMB of %5dMB (total %5dMB @ %5dMb/sec)" % (
@@ -490,6 +494,7 @@ def run(self, hardware, scenario, result_dir=os.getcwd()):
             progress_history = ret[0]
             qemu_timings = ret[1]
             vcpu_timings = ret[2]
+            result = ret[3]
             if uri[0:5] == "unix:" and os.path.exists(uri[5:]):
                 os.remove(uri[5:])
 
@@ -509,6 +514,7 @@ def run(self, hardware, scenario, result_dir=os.getcwd()):
                           Timings(self._get_timings(src) + self._get_timings(dst)),
                           Timings(qemu_timings),
                           Timings(vcpu_timings),
+                          result,
                           self._binary, self._dst_host, self._kernel,
                           self._initrd, self._transport, self._sleep)
         except Exception as e:
diff --git a/tests/migration-stress/guestperf/report.py b/tests/migration-stress/guestperf/report.py
index 1efd40c868..e135e01be6 100644
--- a/tests/migration-stress/guestperf/report.py
+++ b/tests/migration-stress/guestperf/report.py
@@ -24,6 +24,22 @@
 from guestperf.progress import Progress
 from guestperf.timings import Timings
 
+class ReportResult(object):
+
+    def __init__(self, success=False):
+        self._success = success
+
+    def serialize(self):
+        return {
+            "success": self._success,
+        }
+
+    @classmethod
+    def deserialize(cls, data):
+        return cls(
+            data["success"])
+
+
 class Report(object):
 
     def __init__(self,
@@ -33,6 +49,7 @@ def __init__(self,
                  guest_timings,
                  qemu_timings,
                  vcpu_timings,
+                 result,
                  binary,
                  dst_host,
                  kernel,
@@ -46,6 +63,7 @@ def __init__(self,
         self._guest_timings = guest_timings
         self._qemu_timings = qemu_timings
         self._vcpu_timings = vcpu_timings
+        self._result = result
         self._binary = binary
         self._dst_host = dst_host
         self._kernel = kernel
@@ -61,6 +79,7 @@ def serialize(self):
             "guest_timings": self._guest_timings.serialize(),
             "qemu_timings": self._qemu_timings.serialize(),
             "vcpu_timings": self._vcpu_timings.serialize(),
+            "result": self._result.serialize(),
             "binary": self._binary,
             "dst_host": self._dst_host,
             "kernel": self._kernel,
@@ -78,6 +97,7 @@ def deserialize(cls, data):
             Timings.deserialize(data["guest_timings"]),
             Timings.deserialize(data["qemu_timings"]),
             Timings.deserialize(data["vcpu_timings"]),
+            ReportResult.deserialize(data["result"]),
             data["binary"],
             data["dst_host"],
             data["kernel"],
-- 
2.27.0


