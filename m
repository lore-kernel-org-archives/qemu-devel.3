Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76240C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 07:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scKKE-00034I-E5; Fri, 09 Aug 2024 03:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1scKKC-0002x4-LM
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 03:46:12 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1scKKB-0002wM-1T
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 03:46:12 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7105043330aso1698169b3a.0
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 00:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1723189449; x=1723794249;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gO+KhUBLk4wxXd1Tah7t9BkUwm0u320fvMR+lJzhsXQ=;
 b=A+yrxqrxkhyoKZqGSLq+tUOg1MEuALIpORUgRXjoFc5nYXsScrzM+d3JdlMk/ViTuv
 zOz6WJ5fo6uo1UHmWtgnWdkfRzBbzsT1l7nfRZH2VAx4Oi9RVobVDg9p84DAlTXblS1p
 wO+R+P2zPrS8cq0LcQd0WELMeageomX1bf9hv+l32LeoErDRIhOvcQORPLO3VXdkjjaU
 7JEHNImlFh2V8A8LAKrHZPSMSwfMHzXHz6JEoPW4TZ6LVSz8aaIK12I1rGe14b6y+GuK
 48FCxWVJ+oWCX0djD93/Vbvr5paXHfclbL9Xq2H5ggz75pVrrbSX+ycPCxz8FZg2W/Vb
 HiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723189449; x=1723794249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gO+KhUBLk4wxXd1Tah7t9BkUwm0u320fvMR+lJzhsXQ=;
 b=uzXwlQbibqDnBs1EVLvG5tWRkg/Qateqn72jIjn9bzP31cB3fo7t0dZNQNj55SpvXN
 D9UWruwcuM0Ae9XjyF2+7dBpwY+Gp/TF8NIUj+u/QSX1TCLrL0+2PtOp5ZbPJ+xblUIV
 uAFYNToffCRKYC29Rx2Xv6kMKWsSrVBxgQZqiLKNcgWydg5AuFYbE9PxzFqyO8DLqvKg
 eWJxVNXgFx7Hz3IImFVRKxQKS8Y9vUH51plEOh4Ngc7up2KEeYrYEsl5c7iVGDr7eRg9
 qTII16qUS3ZUs3/qsVqP/puZdsLsbJXXKQQwRWCdhy6T+sGXLxUxtnP0wdHgUrmPdjYb
 gMEg==
X-Gm-Message-State: AOJu0YzZFXUst3HxoPT/iaCC0fm7UymgTcdR7HtBATi9k8UKRjfag+2x
 pIb7BugrinrvssMTiC4wo0I4Mq53INnFr2q1UYC9lhOhYDd7eVMIqNtgGlugu9i2F+Td64KadAO
 IY74+vg==
X-Google-Smtp-Source: AGHT+IE/fKsn1nD93Liffef6KqbCCq5WRgvGrJ3sDVey11mYINioOPA5OLCdQBoCfTMDCk32xH29yw==
X-Received: by 2002:a05:6a21:4610:b0:1c3:ff33:24b9 with SMTP id
 adf61e73a8af0-1c89fe6ab90mr1067098637.3.1723189448593; 
 Fri, 09 Aug 2024 00:44:08 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710cb22a455sm2123212b3a.71.2024.08.09.00.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 00:44:08 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v1 3/5] guestperf: Support deferred migration for multifd
Date: Fri,  9 Aug 2024 15:43:34 +0800
Message-Id: <5de50254b726a51c456f9a3a1f1947f28f28646c.1723189080.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1723189080.git.yong.huang@smartx.com>
References: <cover.1723189080.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x432.google.com
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

The way to enable multifd migration has been changed by commit,
82137e6c8c (migration: enforce multifd and postcopy preempt to
be set before incoming), and guestperf has not made the
necessary changes. If multifd migration had been enabled in the
previous manner, the following error would have occurred:
Multifd must be set before incoming starts

Supporting deferred migration will fix it.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 scripts/migration/guestperf/engine.py | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/scripts/migration/guestperf/engine.py b/scripts/migration/guestperf/engine.py
index 608d7270f6..4cddd05a9d 100644
--- a/scripts/migration/guestperf/engine.py
+++ b/scripts/migration/guestperf/engine.py
@@ -106,7 +106,8 @@ def _migrate_progress(self, vm):
             info.get("dirty-limit-ring-full-time", 0),
         )
 
-    def _migrate(self, hardware, scenario, src, dst, connect_uri):
+    def _migrate(self, hardware, scenario, src,
+                 dst, connect_uri, defer_migrate):
         src_qemu_time = []
         src_vcpu_time = []
         src_pid = src.get_pid()
@@ -220,6 +221,8 @@ def _migrate(self, hardware, scenario, src, dst, connect_uri):
             resp = src.cmd("migrate-set-parameters",
                            vcpu_dirty_limit=scenario._vcpu_dirty_limit)
 
+        if defer_migrate:
+            resp = dst.cmd("migrate-incoming", uri=connect_uri)
         resp = src.cmd("migrate", uri=connect_uri)
 
         post_copy = False
@@ -373,11 +376,14 @@ def _get_common_args(self, hardware, tunnelled=False):
     def _get_src_args(self, hardware):
         return self._get_common_args(hardware)
 
-    def _get_dst_args(self, hardware, uri):
+    def _get_dst_args(self, hardware, uri, defer_migrate):
         tunnelled = False
         if self._dst_host != "localhost":
             tunnelled = True
         argv = self._get_common_args(hardware, tunnelled)
+
+        if defer_migrate:
+            return argv + ["-incoming", "defer"]
         return argv + ["-incoming", uri]
 
     @staticmethod
@@ -439,6 +445,9 @@ def run(self, hardware, scenario, result_dir=os.getcwd()):
             except:
                 pass
 
+        if scenario._multifd:
+            defer_migrate = True
+
         if self._dst_host != "localhost":
             dstmonaddr = ("localhost", 9001)
         else:
@@ -452,7 +461,7 @@ def run(self, hardware, scenario, result_dir=os.getcwd()):
                           monitor_address=srcmonaddr)
 
         dst = QEMUMachine(self._binary,
-                          args=self._get_dst_args(hardware, uri),
+                          args=self._get_dst_args(hardware, uri, defer_migrate),
                           wrapper=self._get_dst_wrapper(hardware),
                           name="qemu-dst-%d" % os.getpid(),
                           monitor_address=dstmonaddr)
@@ -461,7 +470,8 @@ def run(self, hardware, scenario, result_dir=os.getcwd()):
             src.launch()
             dst.launch()
 
-            ret = self._migrate(hardware, scenario, src, dst, uri)
+            ret = self._migrate(hardware, scenario, src,
+                                dst, uri, defer_migrate)
             progress_history = ret[0]
             qemu_timings = ret[1]
             vcpu_timings = ret[2]
-- 
2.11.0


