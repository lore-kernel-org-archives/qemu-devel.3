Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BA5EA4FB2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 11:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuUSc-0004SS-MO; Mon, 23 Feb 2026 06:50:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUSb-0004RK-2v
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:50:45 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUSV-0004ri-Vj
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:50:42 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EE6EF4434C;
 Mon, 23 Feb 2026 11:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AF5C2BCAF;
 Mon, 23 Feb 2026 11:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771847433;
 bh=INiyl0aRSuBnQVQ202CeCvEnWeCH+QmITdcQn0SHaNI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rRjjaF5iqvrBfEXMP11OUq6Ev1XoWbLBjEs7vBiTXn5ZUNodWkTl4V88HfpgjTCER
 Q7gOiHm1q5wcKiTUufcFgpFLw9DIIsG24yYJg/ThIYlXUNq68GW6IoTqe66VtDvi6F
 5mJzX6dHpnFqpUbHO90KBi0hWG1JI5jJoZRYH43YbBpqg1A4DNqvvylQug8n6g95yu
 pEqg1bqru7yEeG2fsqbFJZ/u6Uzs5EHbRX5YPrkqKYbhLcu0GbfZOdW0cH0Ik/O4Le
 +8LpetTFViD7QVYxf2CQ6jXVAL6uC6ln9KynB44Biqy+9AIDtfdJ2JbVTci4GFwdvw
 yS/tZhLf3dsZA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUSO-00000007JoJ-09WF; Mon, 23 Feb 2026 12:50:32 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v3 07/14] scripts/qmp_helper: avoid long lines when possible
Date: Mon, 23 Feb 2026 12:50:23 +0100
Message-ID: <aa2bc28a159fe21bddfff1c21af4ee6383547d7e.1771847176.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771847176.git.mchehab+huawei@kernel.org>
References: <cover.1771847176.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

checkpatch.pl reports some long lines. Most of them are due to
strings that need to be long, or due to python's way to indent
files and very long names on some class methods.

Yet, some of them are due to pylint instructions that can also
be placed just before the line, or are too indented. Solve
such cases.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/qmp_helper.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
index 63f3df2d75c3..80fdaef60214 100755
--- a/scripts/qmp_helper.py
+++ b/scripts/qmp_helper.py
@@ -199,7 +199,8 @@ def bit(b):
     def data_add(data, value, num_bytes):
         """Adds bytes from value inside a bitarray"""
 
-        data.extend(value.to_bytes(num_bytes, byteorder="little"))  # pylint: disable=E1101
+        # pylint: disable=E1101
+        data.extend(value.to_bytes(num_bytes, byteorder="little"))
 
     def dump_bytearray(name, data):
         """Does an hexdump of a byte array, grouping in bytes"""
@@ -351,7 +352,7 @@ def send_cmd(self, command, args=None, may_open=False, return_error=True,
                 if obj and "return" in obj and not obj["return"]:
                     break
 
-            except Exception as e:                     # pylint: disable=W0718
+            except Exception as e:            # pylint: disable=W0718
                 print(f"Command: {command}")
                 print(f"Failed to inject error: {e}.")
                 obj = None
@@ -443,7 +444,9 @@ def argparse(parser):
         validation_bits = ",".join(qmp.VALIDATION_BITS.keys())
         gedb_flags_bits = ",".join(qmp.GEDB_FLAGS_BITS.keys())
 
-        g_gen = parser.add_argument_group("Generic Error Data")  # pylint: disable=E1101
+        # pylint: disable=E1101
+        g_gen = parser.add_argument_group("Generic Error Data")
+
         g_gen.add_argument("--block-status",
                            help=f"block status bits: {block_status_bits}")
         g_gen.add_argument("--raw-data", nargs="+",
-- 
2.53.0


