Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47784D3DEA4
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 18:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1rfG-0005RB-Ce; Fri, 18 Oct 2024 14:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1rfA-0005PX-Oz
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 14:25:25 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1rf8-0001zY-Kb
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 14:25:24 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20cb7139d9dso22957785ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 11:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729275920; x=1729880720;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f4rXhcsu75RQ6qJ8BqPK5pJGFSBb9OK02xFD1ELB+RE=;
 b=cHgUb1eLYJMUSx2Kd7C4fdQjqAVDVrwsJ97CQKYMSSUqntm8enpzYJH1KawXiBFSmy
 IJzxyvGqxQ452RnON5kRTzshxgXQmRBHfKmnM4m8Fq4lpxRV8KlppfOoxqSvT4DJuru3
 IMrp7a8YN1EQGY32kQlAWBLhMmFzDwGNJfG7qXnQOwjGujk00DZ30sKCrfK+YYg+xd25
 g3kCMnYiBLOZBHJSbheOG5y9tCEbB9RDG+MH50NV1AyWzCj7R5xL4ZHtlDrmZ5aEIFkr
 IIX3yEpdFsqFhYj0qJI/GThjPyXoX/jt+gPGZnzDf4pXClzr7TX7EmcZsiqipYG4mEnX
 ebiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729275920; x=1729880720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f4rXhcsu75RQ6qJ8BqPK5pJGFSBb9OK02xFD1ELB+RE=;
 b=Cupr1rIy+Fkaa8p2BNHd3NC6vlfJn/xvx94Ptt08WY1V0Sw3muJVt7xlQ4mNnVFOUs
 Qh/uRG2lb1Z1jpDGiABRuH79Ex+Ic0KyBUXnAsf1zGfA+mYEsO75sHDcezWYPYaCaMFW
 b4pOtkGuyG/9Vr60n79lADWFF5D0ONySr6yWNGwUP2cl5SfxhVIgSkoHY8hvSrKjaXK/
 wYXGr1AVM7JtO+pqAnPXaAZW5kBlFKP/64l7Pyf9ekudQMH2T6Z9807X4AAS+JmDlMiZ
 8nQs3SmnQlM5f/qleDZ5PqlxnugsvKE7UhW1Pz+l0iH1DZaJVpgoi2Yh4LRKJMcigQgv
 gvwA==
X-Gm-Message-State: AOJu0Yzieru8mFxkhcHSUQrlE8/rqAo5u5csUNL4KR8EyG7XRIyXXX9v
 Ehnda9w34QZBnWCRh+PcgX/3ObOAiLJIGQqoUD0RhLkecHlZMOuCBBtDgCmoTtKm8hsIA7bdLUP
 f5OP9sg==
X-Google-Smtp-Source: AGHT+IHNTFlA64Z7438lRC4Dm5QySlOViy66H5y9G5fD6p1xhtovSIoPEcjgIUAUeUvLJ1AcJXa4EQ==
X-Received: by 2002:a17:902:db04:b0:20e:5997:c107 with SMTP id
 d9443c01a7336-20e5a8fb320mr45380465ad.39.1729275919607; 
 Fri, 18 Oct 2024 11:25:19 -0700 (PDT)
Received: from localhost.localdomain ([118.114.60.204])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e5a8f2034sm15668475ad.193.2024.10.18.11.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 11:25:19 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v2 3/5] guestperf: Support deferred migration for multifd
Date: Sat, 19 Oct 2024 02:25:05 +0800
Message-Id: <b8dfc975dcb9f48faf5cef154aaafd248179f664.1729275266.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1729275266.git.yong.huang@smartx.com>
References: <cover.1729275266.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x632.google.com
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

The way to enable multifd migration has been changed by commit,
82137e6c8c (migration: enforce multifd and postcopy preempt to
be set before incoming), and guestperf has not made the
necessary changes. If multifd migration had been enabled in the
previous manner, the following error would have occurred:
Multifd must be set before incoming starts

Supporting deferred migration will fix it.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
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
2.39.1


