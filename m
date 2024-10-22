Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094EBD17159
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 02:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t34Q7-0005xC-5M; Mon, 21 Oct 2024 22:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t34Q4-0005wO-Lg
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:14:48 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t34Q3-0001XX-0Q
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:14:48 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20bb39d97d1so47257575ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 19:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729563285; x=1730168085;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zj16xsP69yRm8kfvS7x0oc4hUe/30vMQW6eBXthukQ8=;
 b=hI8cFTLwjn5w6OPv5tBwgHoQP1makOHAVFMJ9aYQe4kW74jDxZWxuq4DPyncqZnvTa
 KFgGmT/XNKS3juWkfDGgUzbvo7mQT/kfcPuv79YkYjEdm0SLN5srzB87BqBz5r3p6AJ9
 +lF4QDf1LMaQvj98BjM8tg7SK56d9qBu4C95fiy8M0V3xc6VHVC07yusFuXgBbS8gknv
 uWNZAIrEbitlPPotuHRdKnMqI77lrQXce65CFiD8V+QAsiqG+PIOA7YBRVFG2cyyHKfx
 kPQD4/fbJq9F0tSJaaHcF8n2LcQOnDj7PaApnxXXBbqkD5q5itQQBFq0DKshjQgA28lP
 bNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729563285; x=1730168085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zj16xsP69yRm8kfvS7x0oc4hUe/30vMQW6eBXthukQ8=;
 b=LaU1xlBwfLL3zmvBl+5ynprVujfTOIkH54EVaW0FAiG/XR0jy/c2TZ8m9Lzi6Ansx8
 YUmIxmJPPKsYzBKzDUsVTBcgjYXEoS5cdDJPY576bp/7OPQOgbDvbhm3jyPY8Brc38+o
 H3tDM3nmGIdne74d3mTdYvfpMPnikJ0tpRHVhDevB0fcj1MfMJLRdoGjtoNJiA4QplUQ
 9ZgLIyPpvvfEn/Fs1P1WTtd11xKAUOnpd0Gyi6kfU1RlSuJKSo3+thFVm+bTqMUKxM6u
 wFEyHCgy0svVm7tk+rL515gskaPnwnaNYlK1sC3l2A513tgrdWjkdcRad9Q6C+3l9asA
 6JTw==
X-Gm-Message-State: AOJu0YweOjoFYo00snbTtitHFC9bOo+CkAh2iV9mNND4QEwBfLtQGVfz
 MfIrkN2FrNXI5bB0NReS+eAkJ1FCg18r5qTlsZ+QhW5v3Y0YssAEO+VBKOg9vhxa4/dN1FzbtIk
 nuOU+oA==
X-Google-Smtp-Source: AGHT+IE2JzQP3YDsudqrkKBKctPz5ZJzYYsslGXvmJnnuJTqMHDtLOINXJBhEC09M53+vWt3lvOVdA==
X-Received: by 2002:a17:903:2451:b0:20c:5cdd:a91 with SMTP id
 d9443c01a7336-20e9492f9damr24506215ad.41.1729563284775; 
 Mon, 21 Oct 2024 19:14:44 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([103.172.41.198])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0bd63fsm32726545ad.173.2024.10.21.19.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 19:14:44 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v3 3/5] guestperf: Support deferred migration for multifd
Date: Tue, 22 Oct 2024 10:14:24 +0800
Message-Id: <62b27597177e6c756475bcb95a5e1bc35a998cd3.1729562974.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1729562974.git.yong.huang@smartx.com>
References: <cover.1729562974.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62b.google.com
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

The way to enable multifd migration has been changed by commit,
82137e6c8c (migration: enforce multifd and postcopy preempt to
be set before incoming), and guestperf has not made the
necessary changes. If multifd migration had been enabled in the
previous manner, the following error would have occurred:
Multifd must be set before incoming starts

Supporting deferred migration will fix it.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/migration/guestperf/engine.py | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/scripts/migration/guestperf/engine.py b/scripts/migration/guestperf/engine.py
index 608d7270f6..4b15322e8d 100644
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
@@ -424,6 +430,7 @@ def _get_timings(self, vm):
 
     def run(self, hardware, scenario, result_dir=os.getcwd()):
         abs_result_dir = os.path.join(result_dir, scenario._name)
+        defer_migrate = False
 
         if self._transport == "tcp":
             uri = "tcp:%s:9000" % self._dst_host
@@ -439,6 +446,9 @@ def run(self, hardware, scenario, result_dir=os.getcwd()):
             except:
                 pass
 
+        if scenario._multifd:
+            defer_migrate = True
+
         if self._dst_host != "localhost":
             dstmonaddr = ("localhost", 9001)
         else:
@@ -452,7 +462,7 @@ def run(self, hardware, scenario, result_dir=os.getcwd()):
                           monitor_address=srcmonaddr)
 
         dst = QEMUMachine(self._binary,
-                          args=self._get_dst_args(hardware, uri),
+                          args=self._get_dst_args(hardware, uri, defer_migrate),
                           wrapper=self._get_dst_wrapper(hardware),
                           name="qemu-dst-%d" % os.getpid(),
                           monitor_address=dstmonaddr)
@@ -461,7 +471,8 @@ def run(self, hardware, scenario, result_dir=os.getcwd()):
             src.launch()
             dst.launch()
 
-            ret = self._migrate(hardware, scenario, src, dst, uri)
+            ret = self._migrate(hardware, scenario, src,
+                                dst, uri, defer_migrate)
             progress_history = ret[0]
             qemu_timings = ret[1]
             vcpu_timings = ret[2]
-- 
2.27.0


