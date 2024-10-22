Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DB4D17159
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 02:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t34Q9-0005xg-MY; Mon, 21 Oct 2024 22:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t34Q8-0005xY-OQ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:14:52 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t34Q7-0001YG-0E
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:14:52 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20cb47387ceso45381085ad.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 19:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729563289; x=1730168089;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lKvuj5hWnr5GBGkIVkR3iyQz24UtRbahAZ35LrK2uoY=;
 b=APO0QSv1s6ScGy9y9I1+uqLUMP7+UpKl7V/9LYW9LWyRe134XdJy+EHP0GHXhEhS63
 xrnrWKgUwtF61xkfdsYxHllg3VKmzLPLaHZt1L1tp3BEAJY107DdAsgI0e4kn5T57jb6
 V/HPhGFCIaa164TNzf/qp3rZn6w8vRntYFZNpJRkSGs5b1WkM+km11JBdhXw246GaoLe
 PFEaSISHM8rXqgLQErkc48D7S8qUsYWgCZBBYpM0ZGtM/tn8YXkJWjdN2Zs8U7DEobVS
 bEYXpk2uEic8m9ouy3mfM0hp1+93B4xKui1QFeiZI4OF5Hcsdt6kqWphyuXlBrIuUIC/
 yqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729563289; x=1730168089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lKvuj5hWnr5GBGkIVkR3iyQz24UtRbahAZ35LrK2uoY=;
 b=GZRnQXqF7qfeDGLlZ4vyLreLZQt4xnoOxHOwGSbaRztW8I/4+nDXuQqQKVnCuWSUZP
 qBJe6jRAuRFQluEDxyaiTEjyUIWVB3EU14xP7jefBKg/8Y++tlqqsDPcbvVvgQ8F+Y+4
 gYYNXKPlQXNScBT5KMsjyMHjz1w0ql64PspZ8V9oDMwad0eBH7QyQQzGlbXDXAMC2MGH
 IbJtID8L20+HtiSk3GdxCqw2xR9ZBjzJw6cv/IrOV7xhSd2L+tgutVlayfYOPM6DFQU5
 TckkdUJLxS8t0JmCwZn1zMqEcmSkz/iyNBpZpgS40C1o8QuurA93pc2MkM7Zau74rw34
 7FlQ==
X-Gm-Message-State: AOJu0YwadLA5+OTg+ZaMw6SSTBDPZ6Tg6pVn+SrAn/Akuw44rpZkMZ9R
 UWuw3xmN30y5pO4bpzegR5jJOPkw3xcmzyaZCkgFC0YAU5rLPhGQnoERVJcLhdtr74zs03sGEs9
 oMqNmAA==
X-Google-Smtp-Source: AGHT+IEN5aCcckZf6y8wKLRPkS/feHXlDLngYAQsMgVQvxughZJjj80y3tjn7JcPTXz6F2f1GDnePg==
X-Received: by 2002:a17:902:ced2:b0:20c:c694:f6c6 with SMTP id
 d9443c01a7336-20e5a927e6bmr136070235ad.49.1729563288679; 
 Mon, 21 Oct 2024 19:14:48 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([103.172.41.198])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0bd63fsm32726545ad.173.2024.10.21.19.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 19:14:48 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v3 5/5] guestperf: Introduce multifd compression option
Date: Tue, 22 Oct 2024 10:14:26 +0800
Message-Id: <89b191beabd6ce778e5ae4756937f589b5261099.1729562974.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1729562974.git.yong.huang@smartx.com>
References: <cover.1729562974.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62d.google.com
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

Guestperf tool does not cover the multifd compression option
currently, it is worth supporting so that developers can
analysis the migration performance with different
compression algorithms.

Multifd support 4 compression algorithms currently:
zlib, zstd, qpl, uadk

To request that multifd with the specified compression
algorithm such as zlib:
$ ./scripts/migration/guestperf.py \
    --multifd --multifd-channels 4 --multifd-compression zlib \
    --output output.json

To run the entire standardized set of multifd compression
comparisons, with unix migration:
$ ./scripts/migration/guestperf-batch.py \
    --dst-host localhost --transport unix \
    --filter compr-multifd-compression* --output outputdir

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/migration/guestperf/comparison.py | 13 +++++++++++++
 scripts/migration/guestperf/engine.py     | 14 ++++++++++++++
 scripts/migration/guestperf/scenario.py   |  7 +++++--
 scripts/migration/guestperf/shell.py      |  3 +++
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/scripts/migration/guestperf/comparison.py b/scripts/migration/guestperf/comparison.py
index 40e9d2eb1d..dee3ac25e4 100644
--- a/scripts/migration/guestperf/comparison.py
+++ b/scripts/migration/guestperf/comparison.py
@@ -158,4 +158,17 @@ def __init__(self, name, scenarios):
         Scenario("compr-dirty-limit-50MB",
                  dirty_limit=True, vcpu_dirty_limit=50),
     ]),
+
+    # Looking at effect of multifd with
+    # different compression algorithms
+    Comparison("compr-multifd-compression", scenarios = [
+        Scenario("compr-multifd-compression-zlib",
+                 multifd=True, multifd_channels=2, multifd_compression="zlib"),
+        Scenario("compr-multifd-compression-zstd",
+                 multifd=True, multifd_channels=2, multifd_compression="zstd"),
+        Scenario("compr-multifd-compression-qpl",
+                 multifd=True, multifd_channels=2, multifd_compression="qpl"),
+        Scenario("compr-multifd-compression-uadk",
+                 multifd=True, multifd_channels=2, multifd_compression="uadk"),
+    ]),
 ]
diff --git a/scripts/migration/guestperf/engine.py b/scripts/migration/guestperf/engine.py
index 4b15322e8d..e11f6a8496 100644
--- a/scripts/migration/guestperf/engine.py
+++ b/scripts/migration/guestperf/engine.py
@@ -31,6 +31,8 @@
                              '..', '..', '..', 'python'))
 from qemu.machine import QEMUMachine
 
+# multifd supported compression algorithms
+MULTIFD_CMP_ALGS = ("zlib", "zstd", "qpl", "uadk")
 
 class Engine(object):
 
@@ -191,6 +193,12 @@ def _migrate(self, hardware, scenario, src,
                                scenario._compression_xbzrle_cache))
 
         if scenario._multifd:
+            if (scenario._multifd_compression and
+                (scenario._multifd_compression not in MULTIFD_CMP_ALGS)):
+                    raise Exception("unsupported multifd compression "
+                                    "algorithm: %s" %
+                                    scenario._multifd_compression)
+
             resp = src.cmd("migrate-set-capabilities",
                            capabilities = [
                                { "capability": "multifd",
@@ -206,6 +214,12 @@ def _migrate(self, hardware, scenario, src,
             resp = dst.cmd("migrate-set-parameters",
                            multifd_channels=scenario._multifd_channels)
 
+            if scenario._multifd_compression:
+                resp = src.cmd("migrate-set-parameters",
+                    multifd_compression=scenario._multifd_compression)
+                resp = dst.cmd("migrate-set-parameters",
+                    multifd_compression=scenario._multifd_compression)
+
         if scenario._dirty_limit:
             if not hardware._dirty_ring_size:
                 raise Exception("dirty ring size must be configured when "
diff --git a/scripts/migration/guestperf/scenario.py b/scripts/migration/guestperf/scenario.py
index 154c4f5d5f..4be7fafebf 100644
--- a/scripts/migration/guestperf/scenario.py
+++ b/scripts/migration/guestperf/scenario.py
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
diff --git a/scripts/migration/guestperf/shell.py b/scripts/migration/guestperf/shell.py
index c85d89efec..1452eb8a33 100644
--- a/scripts/migration/guestperf/shell.py
+++ b/scripts/migration/guestperf/shell.py
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


