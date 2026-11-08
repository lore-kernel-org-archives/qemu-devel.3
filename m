Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050C0606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g7GvRNwq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPyg3-0003FM-4M; Sun, 08 Nov 2026 03:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfh-000391-0a
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 03:54:41 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfe-0000wB-Ms
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 03:54:40 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3E061448AF;
 Sun,  8 Nov 2026 08:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2056B1F00903;
 Sun,  8 Nov 2026 08:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794128075;
 bh=PlLqV3gCN3xTZr0TCDyKWGjS9L6Nz1CukhnmHEYIOHM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=g7GvRNwqda8GD5J3z9SQIzThBJtI4oyETNAjYGHusJWDi6r3zBtZca0koExvYBv0Z
 tq9QWnZl0pzYgkxtZmgcDrpmJCiS4oYhFkBt8MsiUNECsFNCY9QE3cTDCFMLS8fluw
 oSaKJ3b0IkLD/WtNPanz1gbEZhrX/tp5rMJqyXRFcqsMaLUu4YOm/dE/ztua3QUu/O
 pqC67/jcxuKmUWCN/VYzZw6N9xa7A7A/ZVUU/ugo/Imn0KIKxXuiEIPboTKTsWRWjG
 lFAraeSIi09URPN6bwhgO/e8UF/KsMyb9q//UXg5mqFj8by7V4vapOsPgx0yiThgO+
 34m0tLns4UgOQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.100.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfZ-00000005Uji-20ce; Sun, 08 Nov 2026 09:54:33 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH 12/13] scripts/ghes_inject: improve help message
Date: Sun,  8 Nov 2026 09:54:25 +0100
Message-ID: <a65281722a5587257fdbe35b1d6634c2f6703ebb.1794127710.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794127710.git.mchehab+huawei@kernel.org>
References: <cover.1794127710.git.mchehab+huawei@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
    {arm,pci-bus,fuzzy-test,fuzzy,raw-error,raw}
      arm                 Inject an ARM processor error CPER, compatible with
                          UEFI 2.9A Errata.
      pci-bus             Inject a PCI/PCI-X bus error CPER
      fuzzy-test (fuzzy)  Inject fuzzy test CPER packets
      raw-error (raw)     Inject CPER records from previously recorded ones.

  options:
    -h, --help            show this help message and exit

  QEMU QMP socket options:
    -H, --host HOST       host name (default: localhost)
    -P, --port PORT       TCP port number (default: 4445)
    -d, --debug           enable debug output (default: False)

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 scripts/arm_processor_error.py |  6 ++++--
 scripts/fuzzy_error.py         |  4 +++-
 scripts/ghes_inject.py         | 18 +++++++++---------
 scripts/pci_bus_error.py       |  4 +++-
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
index dd2b34a64f15..21cdea774f17 100755
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
 
diff --git a/scripts/pci_bus_error.py b/scripts/pci_bus_error.py
index 1d974c54685c..c4a2cb02bbe6 100644
--- a/scripts/pci_bus_error.py
+++ b/scripts/pci_bus_error.py
@@ -35,8 +35,10 @@ def __init__(self, subparsers):
 
         self.data = bytearray()
 
+        DESC = "Inject a PCI/PCI-X bus error CPER"
+
         parser = subparsers.add_parser("pci-bus",
-                                       description="Generate PCI/PCI-X bus error CPER")
+                                       help=DESC, description=DESC)
         g_pci = parser.add_argument_group("PCI/PCI-X bus error")
 
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
2.56.0


