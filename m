Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6701DC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 10:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1titND-0003Ed-O6; Fri, 14 Feb 2025 05:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1titNB-0003EU-Q7
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 05:56:41 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1titNA-00069M-24
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 05:56:41 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso44373565ad.0
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 02:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1739530598; x=1740135398;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vjFJmABBgiPrIkJaTy2ViAXPV7FmihtNfTlnacdhu6U=;
 b=jlk7r2bPyjec5AOI7fPNuCO3TacszgcaJO6TRWh13W6DDW78oe9U5SQFWloCJO/4Qq
 u52z1DsMJSM3BDObBXECUMQlvga0wKFsxzJZwWGiw3IjLBQei7GVXXiJVW7/7Md5upmK
 UhVKT5VnrAzhOKUIc8egOPIT4T8KPh7KLfglxstDoViV2QoguRMmSDxraNeW0/OwOUiG
 FAWWxFAjl81U4PDTnDl/aDewTbOL40rI16o3+1F/Rr6odaGyE1S+i+VkVIkZ7rQeL1Wo
 LaIqKm9TigVgLyti53FDgo67++SQL9U0W8+bb2UXaFtasSKzZFKDx80Up++aYN3ucWg5
 1iyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739530598; x=1740135398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vjFJmABBgiPrIkJaTy2ViAXPV7FmihtNfTlnacdhu6U=;
 b=RWEn5o0QDVoYo8J4LXxSc4zGKhx6YsErsA6hcbw8y77LCQNGfhNlK0eBSF4dSr0qbN
 0cHrPS85ePEzKREFF7sgImXqrmgjIBaVDIYwIMvlAp0PxbYlpL6MOOJwAxuW5ZxOIVOD
 lVc3q7QzmhrcRajWlEeyphNLY4DEmkeIudmwhRYUCqSUvd/K1Y73NLFEaSRBdiKGey+o
 oxKZYm2gtc12VtSrlIxq+19P2RgxmvDWJV5LKvH9F+Uv+pmFkqzFA7z6QO1T9LWfbd5H
 /Gm5PjN+ya1V6+Qpraldc4wt9osnyIuR4erIkfXpH9R+C7W6qCB+Wsves+ORas7ORL1u
 /nHQ==
X-Gm-Message-State: AOJu0Yz2mUh9HYboiRg5KrNsBb1o6A24BMeYjA3JcwxqUIU12/Tb2jEd
 tLiaRlPvGDYn0hlxqNejDtWm3Hp0PbIW+/44oeCIk/MFE/V1k4RBhBLqAdiDXxEpEc95Oop4bNV
 4cXKE9Q==
X-Gm-Gg: ASbGncvVxqpX6t0VzI6P+Xxu4rNlQ7KkTlK5AF3wf3aA4FIE9Pb+hWciYl//FDAreFL
 xz+96pei7CNuqt/B97v2+H3gxdTSkank1ITV8z7CfXuWQ6os6eecbDloqBLL4Vb2AHjUx4BImka
 7Whhirzpdm9njBFBXQPTORjAuGHUkhilCa7OhroytrP8QgUmaOOcoG543ohxB6Rpho9Xx3OOF3U
 WJV9I0F5myIM0JwM374uKA2vDwJzt2Q7wxEFZ7dKCdsHIhAHyPw+RTTXnMqDdnJ+eFPtDNKiOB3
 vwrXNnTWEXnT9AqYX0RJzdgFcF7ZFKpimsbuTQqX
X-Google-Smtp-Source: AGHT+IG6jNR0H6w6GosfWcxY0VwoBz2CaMesZp6jDcxNqw5iBi6cOd//L6JE8++6h/+pQAUCzXvPmw==
X-Received: by 2002:a05:6a21:3a93:b0:1ea:db1d:99b with SMTP id
 adf61e73a8af0-1ee6b30cf39mr13911908637.3.1739530598324; 
 Fri, 14 Feb 2025 02:56:38 -0800 (PST)
Received: from Hyman-Dev-Euler.zelin.local ([154.64.226.178])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-add0987b223sm535013a12.17.2025.02.14.02.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 02:56:38 -0800 (PST)
From: yong.huang@smartx.com
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH v4 RESEND 3/4] guestperf: Introduce multifd compression option
Date: Fri, 14 Feb 2025 18:55:25 +0800
Message-Id: <c0e3313d81e8130f8119ef4f242e4625886278cf.1739530098.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1739530098.git.yong.huang@smartx.com>
References: <cover.1739530098.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x629.google.com
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
$ ./tests/migration-stress/guestperf.py \
    --multifd --multifd-channels 4 --multifd-compression zlib \
    --output output.json

To run the entire standardized set of multifd compression
comparisons, with unix migration:
$ ./tests/migration-stress/guestperf-batch.py \
    --dst-host localhost --transport unix \
    --filter compr-multifd-compression* --output outputdir

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/migration-stress/guestperf/comparison.py | 13 +++++++++++++
 tests/migration-stress/guestperf/engine.py     | 14 ++++++++++++++
 tests/migration-stress/guestperf/scenario.py   |  7 +++++--
 tests/migration-stress/guestperf/shell.py      |  3 +++
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/tests/migration-stress/guestperf/comparison.py b/tests/migration-stress/guestperf/comparison.py
index 40e9d2eb1d..dee3ac25e4 100644
--- a/tests/migration-stress/guestperf/comparison.py
+++ b/tests/migration-stress/guestperf/comparison.py
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
diff --git a/tests/migration-stress/guestperf/engine.py b/tests/migration-stress/guestperf/engine.py
index 4b15322e8d..e11f6a8496 100644
--- a/tests/migration-stress/guestperf/engine.py
+++ b/tests/migration-stress/guestperf/engine.py
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
diff --git a/tests/migration-stress/guestperf/scenario.py b/tests/migration-stress/guestperf/scenario.py
index 154c4f5d5f..4be7fafebf 100644
--- a/tests/migration-stress/guestperf/scenario.py
+++ b/tests/migration-stress/guestperf/scenario.py
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
diff --git a/tests/migration-stress/guestperf/shell.py b/tests/migration-stress/guestperf/shell.py
index 046afeb84e..63bbe3226c 100644
--- a/tests/migration-stress/guestperf/shell.py
+++ b/tests/migration-stress/guestperf/shell.py
@@ -131,6 +131,8 @@ def __init__(self):
                             action="store_true")
         parser.add_argument("--multifd-channels", dest="multifd_channels",
                             default=2, type=int)
+        parser.add_argument("--multifd-compression", dest="multifd_compression",
+                            default="")
 
         parser.add_argument("--dirty-limit", dest="dirty_limit", default=False,
                             action="store_true")
@@ -167,6 +169,7 @@ def get_scenario(self, args):
 
                         multifd=args.multifd,
                         multifd_channels=args.multifd_channels,
+                        multifd_compression=args.multifd_compression,
 
                         dirty_limit=args.dirty_limit,
                         x_vcpu_dirty_limit_period=\
-- 
2.27.0


