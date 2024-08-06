Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2739C52D73
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 15:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbM5U-0006gh-3l; Tue, 06 Aug 2024 11:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sbM4m-0006Bk-Bd
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 11:26:16 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sbM4h-0005QW-Bq
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 11:26:14 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7b8b1743a01so291547a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 08:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1722957850; x=1723562650;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dGXPceVfjGUXduFfW7fbunNiffjwGB6schfMiKemxFk=;
 b=Mn9VCpGvkQwVnWFYiUhFFQbsS/Lb7PGwzfU/cmvpCc6oflN0TUuzPEJ6BunPDyYFqn
 EHlcf1dlIBBtcDl8HJVrPIGr8K38nml0UpFfROz5Ldseec6n6Fvv4eu9Z74qpPAdki6k
 68Qa7Zv7DLntq5QCZKvuioPP6EK+n7kquJR+lj2ORLM7VR0GtGp8BnyBZGnmDSKi/zOv
 L/RFd40TV6ybeNSkYW5wXtGiJfNf6TuyMT3M+v/t9cLgU4Kv9fvq5TCLNtSopsTAC8JP
 G/C/2eHgsJkP67vb3TiynXWPlhogY1s/l/Nhplr3112Qq83/fy/eST/B7f1YfYAvzjoi
 K3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722957850; x=1723562650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dGXPceVfjGUXduFfW7fbunNiffjwGB6schfMiKemxFk=;
 b=J5BAAkc89WW6bsNQ0PiNhhssKiWklwFH5S77mzr6eg0Mf/S92s5H6BtQzwRa2TZCJi
 2okovfDGVFDpr+Hh/0X4avw8pXeNzmKQgsDR/vDpweUcpYD8tqkmKIqa8inSjRAXwblC
 fM/8X818gykObi7TPw7BYnt5/44H3HzieklSPSIo3Oz+J1+lr10/dsbFy2jAImgx4B5w
 jNqnTnjoAjSa0mge3AmU9RLFxjh7JwzS4Q6QrR2G3pq+3jkePT+ggdQA/6DdaiYtNYTL
 6x9xGncOJ4xvt1ZXpDrtntTtNoyonnJ7l5hN9yWedx/T0p9BTY6IVX5aoJc4pLLHSZIa
 UPKg==
X-Gm-Message-State: AOJu0YzpjDL8NLeTu3wza7cl7iOFVmUqQJ98eCac1CNsssIEJhbiE+Ns
 bLJh4xkLAdE8YgTN8oArJMHspP+dsGwUryOtl1nLa9kEwA8gFGPc3CGCT2DHgI7Nhhh/S5PoAnY
 0NuGmiy5X
X-Google-Smtp-Source: AGHT+IFkbqxr+m4IfWGV+88BRe/k/Y+53IWbeFs7y0ikGays+3ieQ+F0zsE2Sc4tiPND93Za0+ibJw==
X-Received: by 2002:a05:6a21:6b0a:b0:1c2:94ad:1c67 with SMTP id
 adf61e73a8af0-1c699563513mr15395351637.30.1722957849285; 
 Tue, 06 Aug 2024 08:24:09 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ed2d04bsm7059727b3a.201.2024.08.06.08.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 08:24:09 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 yong.huang@smartx.com
Subject: [PATCH 2/2] tests/migration: Introduce multifd compression into
 guestperf
Date: Tue,  6 Aug 2024 23:23:42 +0800
Message-Id: <8af3ae48cd4c3116b9f0f478bd5cf6df64198d66.1722957352.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1722957352.git.yong.huang@smartx.com>
References: <cover.1722957352.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x532.google.com
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

Guestperf tool does not cover the multifd compression option
currently, it is worth supporting so that developers can
analysis the migration performance with different
compression algorithms.

Multifd support 4 compression algorithms currently:
zlib, zstd, qpl, uadk

To request that multifd with the specified compression
algorithm such as zlib:
$ ./tests/migration/guestperf.py \
    --multifd --multifd-channels 4 --multifd-compression zlib \
    --output output.json

To run the entire standardized set of multifd compression
comparisons, with unix migration:
$ ./tests/migration/guestperf-batch.py \
    --dst-host localhost --transport unix \
    --filter compr-multifd-compression* --output outputdir

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 tests/migration/guestperf/comparison.py | 13 +++++++++++++
 tests/migration/guestperf/engine.py     | 12 ++++++++++++
 tests/migration/guestperf/scenario.py   |  7 +++++--
 tests/migration/guestperf/shell.py      |  3 +++
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/tests/migration/guestperf/comparison.py b/tests/migration/guestperf/comparison.py
index 40e9d2eb1d..71208e8540 100644
--- a/tests/migration/guestperf/comparison.py
+++ b/tests/migration/guestperf/comparison.py
@@ -158,4 +158,17 @@ def __init__(self, name, scenarios):
         Scenario("compr-dirty-limit-50MB",
                  dirty_limit=True, vcpu_dirty_limit=50),
     ]),
+
+    # Looking at effect of multifd with
+    # different compression algorithm
+    Comparison("compr-multifd-compression", scenarios = [
+        Scenario("compr-multifd-compression-zlib",
+                 multifd=True, multifd_channels=4, multifd_compression="zlib"),
+        Scenario("compr-multifd-compression-zstd",
+                 multifd=True, multifd_channels=4, multifd_compression="zstd"),
+        Scenario("compr-multifd-compression-qpl",
+                 multifd=True, multifd_channels=4, multifd_compression="qpl"),
+        Scenario("compr-multifd-compression-uadk",
+                 multifd=True, multifd_channels=4, multifd_compression="uadk"),
+    ]),
 ]
diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestperf/engine.py
index 608d7270f6..883a7b8ab6 100644
--- a/tests/migration/guestperf/engine.py
+++ b/tests/migration/guestperf/engine.py
@@ -31,6 +31,8 @@
                              '..', '..', '..', 'python'))
 from qemu.machine import QEMUMachine
 
+# multifd supported compressoin algorithms
+MULTIFD_CMP_ALGS = ("zlib", "zstd", "qpl", "uadk")
 
 class Engine(object):
 
@@ -205,6 +207,16 @@ def _migrate(self, hardware, scenario, src, dst, connect_uri):
             resp = dst.cmd("migrate-set-parameters",
                            multifd_channels=scenario._multifd_channels)
 
+            if scenario._multifd_compression:
+                if scenario._multifd_compression not in MULTIFD_CMP_ALGS:
+                    raise Exception("unsupported multifd compression "
+                                    "algorithm: %s" %
+                                    scenario._multifd_compression)
+                resp = src.command("migrate-set-parameters",
+                    multifd_compression=scenario._multifd_compression)
+                resp = dst.command("migrate-set-parameters",
+                    multifd_compression=scenario._multifd_compression)
+
         if scenario._dirty_limit:
             if not hardware._dirty_ring_size:
                 raise Exception("dirty ring size must be configured when "
diff --git a/tests/migration/guestperf/scenario.py b/tests/migration/guestperf/scenario.py
index 154c4f5d5f..4be7fafebf 100644
--- a/tests/migration/guestperf/scenario.py
+++ b/tests/migration/guestperf/scenario.py
@@ -30,7 +30,7 @@ def __init__(self, name,
                  auto_converge=False, auto_converge_step=10,
                  compression_mt=False, compression_mt_threads=1,
                  compression_xbzrle=False, compression_xbzrle_cache=10,
-                 multifd=False, multifd_channels=2,
+                 multifd=False, multifd_channels=2, multifd_compression="",
                  dirty_limit=False, x_vcpu_dirty_limit_period=500,
                  vcpu_dirty_limit=1):
 
@@ -61,6 +61,7 @@ def __init__(self, name,
 
         self._multifd = multifd
         self._multifd_channels = multifd_channels
+        self._multifd_compression = multifd_compression
 
         self._dirty_limit = dirty_limit
         self._x_vcpu_dirty_limit_period = x_vcpu_dirty_limit_period
@@ -85,6 +86,7 @@ def serialize(self):
             "compression_xbzrle_cache": self._compression_xbzrle_cache,
             "multifd": self._multifd,
             "multifd_channels": self._multifd_channels,
+            "multifd_compression": self._multifd_compression,
             "dirty_limit": self._dirty_limit,
             "x_vcpu_dirty_limit_period": self._x_vcpu_dirty_limit_period,
             "vcpu_dirty_limit": self._vcpu_dirty_limit,
@@ -109,4 +111,5 @@ def deserialize(cls, data):
             data["compression_xbzrle"],
             data["compression_xbzrle_cache"],
             data["multifd"],
-            data["multifd_channels"])
+            data["multifd_channels"],
+            data["multifd_compression"])
diff --git a/tests/migration/guestperf/shell.py b/tests/migration/guestperf/shell.py
index c85d89efec..1452eb8a33 100644
--- a/tests/migration/guestperf/shell.py
+++ b/tests/migration/guestperf/shell.py
@@ -130,6 +130,8 @@ def __init__(self):
                             action="store_true")
         parser.add_argument("--multifd-channels", dest="multifd_channels",
                             default=2, type=int)
+        parser.add_argument("--multifd-compression", dest="multifd_compression",
+                            default="")
 
         parser.add_argument("--dirty-limit", dest="dirty_limit", default=False,
                             action="store_true")
@@ -166,6 +168,7 @@ def get_scenario(self, args):
 
                         multifd=args.multifd,
                         multifd_channels=args.multifd_channels,
+                        multifd_compression=args.multifd_compression,
 
                         dirty_limit=args.dirty_limit,
                         x_vcpu_dirty_limit_period=\
-- 
2.27.0


