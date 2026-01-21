Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9ACC44501
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 11:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viWLO-00032i-Ud; Wed, 21 Jan 2026 06:25:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1viWLH-0002uW-Hf
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:25:44 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1viWLE-0007q6-Tz
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:25:43 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 657D844288;
 Wed, 21 Jan 2026 11:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC00C2BCB7;
 Wed, 21 Jan 2026 11:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768994725;
 bh=mJkwk0b1J+wBP6yJ8KSn8HC69LO+4cInAVMNTa0sJSQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fdXMd6iuwS9o37AXoWFTiXUjQWSRkwlXAE2HyMskisDVeGtXoNyj/O810l2v76OO6
 h++/G49w5zw43ZazQlqne6p/6aoG0Lf273D9SRsfHDtq0QY+/UmNuM5NAhBLUKbFtC
 Ru03AaEKbDQTNHgbX5MoR7E/64EZyrqdikYm1b8q5Sy8VSOhL7+WLUWbA1N6WUOSkY
 DnbKROB6eyxkHbQgSg7XYP3wq8uJLiuysHyBk4kP7X1EvKTNTeqXUUHtwYW2C6bfMF
 chlF625RRKh+3WrTXdXjRawhRZFLim/69mGPDoC/cFOZDa0ibTQDB8C+cT4lwathgY
 DWtZ5O0tTUWRg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1viWKx-00000003gK6-1MoO; Wed, 21 Jan 2026 12:25:23 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 13/13] scripts/ghes_inject: improve help message
Date: Wed, 21 Jan 2026 12:25:21 +0100
Message-ID: <5b4efacb92c898d5b345e6df1579756a79b586dc.1768993993.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768993993.git.mchehab+huawei@kernel.org>
References: <cover.1768993993.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a one-liner help message for each type of error inject
command, and use raw formatter to keep line breaks.

While here, use a more uniform language.

With that, "ghes_inject -h" will now show:

  usage: ghes_inject.py [options]

  Handles ACPI GHESv2 error injection via the QEMU QMP interface.

  It uses UEFI BIOS APEI features to generate GHES records, which helps to
  test CPER and GHES drivers on the guest OS and see how user‑space
  applications on that guest handle such errors.

  positional arguments:
    {arm,pcie-bus,fuzzy-test,fuzzy,raw-error,raw}
      arm                 Inject an ARM processor error CPER, compatible with
                          UEFI 2.9A Errata.
      pcie-bus            Inject a PCIe bus error CPER
      fuzzy-test (fuzzy)  Inject fuzzy test CPER packets
      raw-error (raw)     Inject CPER records from previously recorded ones.

  options:
    -h, --help            show this help message and exit

  QEMU QMP socket options:
    -H, --host HOST       host name (default: localhost)
    -P, --port PORT       TCP port number (default: 4445)
    -d, --debug           enable debug output (default: False)

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/arm_processor_error.py |  6 ++++--
 scripts/fuzzy_error.py         |  4 +++-
 scripts/ghes_inject.py         | 18 +++++++++---------
 scripts/pcie_bus_error.py      |  4 +++-
 scripts/raw_error.py           |  6 +++---
 5 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/scripts/arm_processor_error.py b/scripts/arm_processor_error.py
index d9845adb0c0a..597382031ab8 100644
--- a/scripts/arm_processor_error.py
+++ b/scripts/arm_processor_error.py
@@ -122,7 +122,7 @@ class ArmProcessorEinj:
     """
 
     DESC = """
-    Generates an ARM processor error CPER, compatible with
+    Inject an ARM processor error CPER, compatible with
     UEFI 2.9A Errata.
     """
 
@@ -169,7 +169,9 @@ def __init__(self, subparsers):
 
         self.data = bytearray()
 
-        parser = subparsers.add_parser("arm", description=self.DESC)
+        parser = subparsers.add_parser("arm",
+                                       help=self.DESC,
+                                       description=self.DESC)
 
         arm_valid_bits = ",".join(self.arm_valid_bits.keys())
         flags = ",".join(self.pei_flags.keys())
diff --git a/scripts/fuzzy_error.py b/scripts/fuzzy_error.py
index 9f80abb72319..3ddb90f743a1 100644
--- a/scripts/fuzzy_error.py
+++ b/scripts/fuzzy_error.py
@@ -121,8 +121,10 @@ def __init__(self, subparsers):
             },
         }
 
+        DESC = "Inject fuzzy test CPER packets"
+
         parser = subparsers.add_parser("fuzzy-test", aliases=['fuzzy'],
-                                       description="Inject a fuzzy test CPER",
+                                       help=DESC, description=DESC,
                                        formatter_class=argparse.RawTextHelpFormatter)
         g_fuzzy = parser.add_argument_group("Fuzz testing error inject")
 
diff --git a/scripts/ghes_inject.py b/scripts/ghes_inject.py
index 4028fdb15582..488d10ffcafd 100755
--- a/scripts/ghes_inject.py
+++ b/scripts/ghes_inject.py
@@ -17,28 +17,28 @@
 from raw_error import RawError
 
 EINJ_DESC = """
-Handle ACPI GHESv2 error injection logic QEMU QMP interface.
+Handles ACPI GHESv2 error injection via the QEMU QMP interface.
 
-It allows using UEFI BIOS EINJ features to generate GHES records.
-
-It helps testing CPER and GHES drivers at the guest OS and how
-userspace applications at the guest handle them.
+It uses UEFI BIOS APEI features to generate GHES records, which helps to
+test CPER and GHES drivers on the guest OS and see how user‑space
+applications on that guest handle such errors.
 """
 
 def main():
     """Main program"""
 
     # Main parser - handle generic args like QEMU QMP TCP socket options
-    parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter,
+    parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter,
                                      usage="%(prog)s [options]",
                                      description=EINJ_DESC)
 
     g_options = parser.add_argument_group("QEMU QMP socket options")
     g_options.add_argument("-H", "--host", default="localhost", type=str,
-                           help="host name")
+                           help="host name (default: %(default)s)")
     g_options.add_argument("-P", "--port", default=4445, type=int,
-                           help="TCP port number")
-    g_options.add_argument('-d', '--debug', action='store_true')
+                           help="TCP port number (default: %(default)s)")
+    g_options.add_argument('-d', '--debug', action='store_true',
+                           help="enable debug output (default: %(default)s)")
 
     subparsers = parser.add_subparsers()
 
diff --git a/scripts/pcie_bus_error.py b/scripts/pcie_bus_error.py
index e8285b5dcc84..843ec09c7572 100644
--- a/scripts/pcie_bus_error.py
+++ b/scripts/pcie_bus_error.py
@@ -35,8 +35,10 @@ def __init__(self, subparsers):
 
         self.data = bytearray()
 
+        DESC = "Inject a PCIe bus error CPER"
+
         parser = subparsers.add_parser("pcie-bus",
-                                       description="Generate PCIe bus error CPER")
+                                       help=DESC, description=DESC)
         g_pcie = parser.add_argument_group("PCIe bus error")
 
         valid_bits = ",".join(self.valid_bits.keys())
diff --git a/scripts/raw_error.py b/scripts/raw_error.py
index f5e77bdfcead..1e9eb1bcf15b 100644
--- a/scripts/raw_error.py
+++ b/scripts/raw_error.py
@@ -21,8 +21,8 @@ class RawError:
 
     SCRIPT_NAME = sys.argv[0]
 
-    HELP=f"""
-    Inject a CPER record from a previously recorded one.
+    HELP="Inject CPER records from previously recorded ones."
+    DESC=HELP + f"""
 
     One or more CPER records can be recorded. The records to be
     injected are read from an specified file or from stdin and should
@@ -58,7 +58,7 @@ def __init__(self, subparsers):
         self.size = 0
 
         parser = subparsers.add_parser("raw-error",  aliases=['raw'],
-                                       description=self.HELP,
+                                       help=self.HELP, description=self.DESC,
                                        formatter_class=argparse.RawTextHelpFormatter)
 
         parser.add_argument("-f", "--file",
-- 
2.52.0


