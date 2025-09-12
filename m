Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31427CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0hu-00018q-KW; Fri, 12 Sep 2025 06:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ux0hc-00012Y-Oz
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 06:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ux0hS-000254-Ts
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 06:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757671692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OGHZs4YsMUnjC2tGsZznEgmUH5FkFrdebelOWfZYWkQ=;
 b=UZvS2dODyTvQprTR3RnNoixo6e04lrHbmkK/FA3lulElNOLgoMZqVNTW4KY5lP4cCTzzEZ
 95lt7TtIzp72Hpl1/eWwP9F9SqY9y07HDgvUcerDAkr4lReL9li03ACUF8ykRbUy2JrZZC
 QQa72K8CjhB+EVB/sKPdQHe88ra32H0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-HNL4TwhKNSSgSupXRJyn5Q-1; Fri,
 12 Sep 2025 06:08:10 -0400
X-MC-Unique: HNL4TwhKNSSgSupXRJyn5Q-1
X-Mimecast-MFC-AGG-ID: HNL4TwhKNSSgSupXRJyn5Q_1757671688
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40AE4180045C; Fri, 12 Sep 2025 10:08:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.15])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DEEE31954126; Fri, 12 Sep 2025 10:08:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 3/4] tests/data/vmstate-static-checker: Add dump files from
 QEMU 7.2.17
Date: Fri, 12 Sep 2025 12:07:54 +0200
Message-ID: <20250912100755.316518-4-thuth@redhat.com>
In-Reply-To: <20250912100755.316518-1-thuth@redhat.com>
References: <20250912100755.316518-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Thomas Huth <thuth@redhat.com>

For automatic tests, we need reference files from older QEMU versions.
QEMU 7.2 is a long term stable release, so it's a good candidate for
checking whether the migration could still work correctly. Let's add the
files from that version that have been taken with the "-dump-vmstate"
parameter of QEMU (compiled with single machines and the configure switch
"--without-default-devices" to keep the json files reasonable small).

Some devices also have been removed manually from the json files, e.g.
the "pci-bridge" (which can be disabled in later QEMU versions via Kconfig),
and some Linux-related devices like "scsi-block" and "scsi-generic" and
KVM-related devices. Without removing them, we might get errors otherwise
if these devices have not been compiled into the destination QEMU build.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .../aarch64/virt-7.2.json                     | 2571 +++++++++++++
 .../vmstate-static-checker/m68k/virt-7.2.json | 2936 +++++++++++++++
 .../ppc64/pseries-7.2.json                    | 1068 ++++++
 .../s390x/s390-ccw-virtio-7.2.json            |  475 +++
 .../x86_64/pc-q35-7.2.json                    | 3297 +++++++++++++++++
 5 files changed, 10347 insertions(+)
 create mode 100644 tests/data/vmstate-static-checker/aarch64/virt-7.2.json
 create mode 100644 tests/data/vmstate-static-checker/m68k/virt-7.2.json
 create mode 100644 tests/data/vmstate-static-checker/ppc64/pseries-7.2.json
 create mode 100644 tests/data/vmstate-static-checker/s390x/s390-ccw-virtio-7.2.json
 create mode 100644 tests/data/vmstate-static-checker/x86_64/pc-q35-7.2.json

diff --git a/tests/data/vmstate-static-checker/aarch64/virt-7.2.json b/tests/data/vmstate-static-checker/aarch64/virt-7.2.json
new file mode 100644
index 00000000000..d7491be99cb
--- /dev/null
+++ b/tests/data/vmstate-static-checker/aarch64/virt-7.2.json
@@ -0,0 +1,2571 @@
+{
+  "vmschkmachine": {
+    "Name": "virt-7.2"
+  },
+  "gpex-pcihost": {
+    "Name": "gpex-pcihost",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "PCIHost",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "config_reg",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ]
+    }
+  },
+  "arm_gic": {
+    "Name": "arm_gic",
+    "version_id": 12,
+    "minimum_version_id": 12,
+    "Description": {
+      "name": "arm_gic",
+      "version_id": 12,
+      "minimum_version_id": 12,
+      "Fields": [
+        {
+          "field": "ctlr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "cpu_ctlr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "irq_state",
+          "version_id": 1,
+          "field_exists": false,
+          "size": 7,
+          "Description": {
+            "name": "arm_gic_irq_state",
+            "version_id": 1,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "enabled",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "pending",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "active",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "level",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "model",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "edge_trigger",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "group",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              }
+            ]
+          }
+        },
+        {
+          "field": "irq_target",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "priority1",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "priority2",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "sgi_pending",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "priority_mask",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2
+        },
+        {
+          "field": "running_priority",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2
+        },
+        {
+          "field": "current_pending",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2
+        },
+        {
+          "field": "bpr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "abpr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "apr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "nsapr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "arm_gic_virt_state",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "h_hcr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "h_misr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "h_lr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "h_apr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "cpu_ctlr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "priority_mask",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 2
+            },
+            {
+              "field": "running_priority",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 2
+            },
+            {
+              "field": "current_pending",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 2
+            },
+            {
+              "field": "bpr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 1
+            },
+            {
+              "field": "abpr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 1
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "arm-gicv3-its-common": {
+    "Name": "arm-gicv3-its-common",
+    "version_id": 0,
+    "minimum_version_id": 0,
+    "Description": {
+      "name": "arm_gicv3_its",
+      "version_id": 0,
+      "minimum_version_id": 0,
+      "Fields": [
+        {
+          "field": "ctlr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "iidr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "cbaser",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        },
+        {
+          "field": "cwriter",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        },
+        {
+          "field": "creadr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        },
+        {
+          "field": "baser",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        }
+      ]
+    }
+  },
+  "arm-gicv3-common": {
+    "Name": "arm-gicv3-common",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "arm_gicv3",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "gicd_ctlr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "gicd_statusr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "group",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "grpmod",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "enabled",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "pending",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "active",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "level",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "edge_trigger",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "gicd_ipriority",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "gicd_irouter",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        },
+        {
+          "field": "gicd_nsacr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "cpu",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 664,
+          "Description": {
+            "name": "arm_gicv3_cpu",
+            "version_id": 1,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "level",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "gicr_ctlr",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "gicr_statusr",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "gicr_waker",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "gicr_propbaser",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              },
+              {
+                "field": "gicr_pendbaser",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              },
+              {
+                "field": "gicr_igroupr0",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "gicr_ienabler0",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "gicr_ipendr0",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "gicr_iactiver0",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "edge_trigger",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "gicr_igrpmodr0",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "gicr_nsacr",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "gicr_ipriorityr",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "icc_ctlr_el1",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              },
+              {
+                "field": "icc_pmr_el1",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              },
+              {
+                "field": "icc_bpr",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              },
+              {
+                "field": "icc_apr",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              },
+              {
+                "field": "icc_igrpen",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              },
+              {
+                "field": "icc_ctlr_el3",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              }
+            ],
+            "Subsections": [
+              {
+                "name": "arm_gicv3_cpu/virt",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "ich_apr",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 8
+                  },
+                  {
+                    "field": "ich_hcr_el2",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 8
+                  },
+                  {
+                    "field": "ich_lr_el2",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 8
+                  },
+                  {
+                    "field": "ich_vmcr_el2",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 8
+                  }
+                ]
+              },
+              {
+                "name": "arm_gicv3_cpu/sre_el1",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "icc_sre_el1",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 8
+                  }
+                ]
+              },
+              {
+                "name": "arm_gicv3_cpu/gicv4",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "gicr_vpropbaser",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 8
+                  },
+                  {
+                    "field": "gicr_vpendbaser",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 8
+                  }
+                ]
+              }
+            ]
+          }
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "arm_gicv3/gicd_no_migration_shift_bug",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "gicd_no_migration_shift_bug",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 1
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "fw_cfg": {
+    "Name": "fw_cfg",
+    "version_id": 2,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "fw_cfg",
+      "version_id": 2,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "cur_entry",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 0,
+          "field_exists": true,
+          "size": 4
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 2,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "fw_cfg/dma",
+          "version_id": 0,
+          "minimum_version_id": 0,
+          "Fields": [
+            {
+              "field": "dma_addr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        },
+        {
+          "name": "fw_cfg/acpi_mr",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "table_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "linker_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "rsdp_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "cfi.pflash01": {
+    "Name": "cfi.pflash01",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "pflash_cfi01",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "wcycle",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "cmd",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "status",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "counter",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "pflash_cfi01_blk_write",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "blk_bytes",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 0
+            },
+            {
+              "field": "blk_offset",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "pl061_luminary": {
+    "Name": "pl061_luminary",
+    "version_id": 4,
+    "minimum_version_id": 4,
+    "Description": {
+      "name": "pl061",
+      "version_id": 4,
+      "minimum_version_id": 4,
+      "Fields": [
+        {
+          "field": "locked",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "data",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "old_out_data",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "old_in_data",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "dir",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "isense",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "ibe",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "iev",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "im",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "istate",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "afsel",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "dr2r",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "dr4r",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "dr8r",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "odr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "pur",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "pdr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "slr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "den",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "cr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "amsel",
+          "version_id": 2,
+          "field_exists": false,
+          "size": 4
+        }
+      ]
+    }
+  },
+  "pl011_luminary": {
+    "Name": "pl011_luminary",
+    "version_id": 2,
+    "minimum_version_id": 2,
+    "Description": {
+      "name": "pl011",
+      "version_id": 2,
+      "minimum_version_id": 2,
+      "Fields": [
+        {
+          "field": "readbuff",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "flags",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "lcr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "rsr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "cr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "dmacr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "int_enabled",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "int_level",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "read_fifo",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "ilpr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "ibrd",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "fbrd",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "ifl",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "read_pos",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "read_count",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "read_trigger",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "pl011/clock",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "clk",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8,
+              "Description": {
+                "name": "clock",
+                "version_id": 0,
+                "minimum_version_id": 0,
+                "Fields": [
+                  {
+                    "field": "period",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 8
+                  }
+                ],
+                "Subsections": [
+                  {
+                    "name": "clock/muldiv",
+                    "version_id": 1,
+                    "minimum_version_id": 1,
+                    "Fields": [
+                      {
+                        "field": "multiplier",
+                        "version_id": 0,
+                        "field_exists": false,
+                        "size": 4
+                      },
+                      {
+                        "field": "divider",
+                        "version_id": 0,
+                        "field_exists": false,
+                        "size": 4
+                      }
+                    ]
+                  }
+                ]
+              }
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "pl061": {
+    "Name": "pl061",
+    "version_id": 4,
+    "minimum_version_id": 4,
+    "Description": {
+      "name": "pl061",
+      "version_id": 4,
+      "minimum_version_id": 4,
+      "Fields": [
+        {
+          "field": "locked",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "data",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "old_out_data",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "old_in_data",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "dir",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "isense",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "ibe",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "iev",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "im",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "istate",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "afsel",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "dr2r",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "dr4r",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "dr8r",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "odr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "pur",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "pdr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "slr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "den",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "cr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "amsel",
+          "version_id": 2,
+          "field_exists": false,
+          "size": 4
+        }
+      ]
+    }
+  },
+  "vmcoreinfo": {
+    "Name": "vmcoreinfo",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "vmcoreinfo",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "has_vmcoreinfo",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "vmcoreinfo.host_format",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2
+        },
+        {
+          "field": "vmcoreinfo.guest_format",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2
+        },
+        {
+          "field": "vmcoreinfo.size",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "vmcoreinfo.paddr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        }
+      ]
+    }
+  },
+  "arm_gic_common": {
+    "Name": "arm_gic_common",
+    "version_id": 12,
+    "minimum_version_id": 12,
+    "Description": {
+      "name": "arm_gic",
+      "version_id": 12,
+      "minimum_version_id": 12,
+      "Fields": [
+        {
+          "field": "ctlr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "cpu_ctlr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "irq_state",
+          "version_id": 1,
+          "field_exists": false,
+          "size": 7,
+          "Description": {
+            "name": "arm_gic_irq_state",
+            "version_id": 1,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "enabled",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "pending",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "active",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "level",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "model",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "edge_trigger",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "group",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              }
+            ]
+          }
+        },
+        {
+          "field": "irq_target",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "priority1",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "priority2",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "sgi_pending",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "priority_mask",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2
+        },
+        {
+          "field": "running_priority",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2
+        },
+        {
+          "field": "current_pending",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2
+        },
+        {
+          "field": "bpr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "abpr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "apr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "nsapr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "arm_gic_virt_state",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "h_hcr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "h_misr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "h_lr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "h_apr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "cpu_ctlr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "priority_mask",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 2
+            },
+            {
+              "field": "running_priority",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 2
+            },
+            {
+              "field": "current_pending",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 2
+            },
+            {
+              "field": "bpr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 1
+            },
+            {
+              "field": "abpr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 1
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "arm-smmuv3": {
+    "Name": "arm-smmuv3",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "smmuv3",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "features",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "sid_size",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "sid_split",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "cr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "cr0ack",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "statusr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "irq_ctrl",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "gerror",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "gerrorn",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "gerror_irq_cfg0",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        },
+        {
+          "field": "gerror_irq_cfg1",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "gerror_irq_cfg2",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "strtab_base",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        },
+        {
+          "field": "strtab_base_cfg",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "eventq_irq_cfg0",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        },
+        {
+          "field": "eventq_irq_cfg1",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "eventq_irq_cfg2",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "cmdq",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 24,
+          "Description": {
+            "name": "smmuv3_queue",
+            "version_id": 1,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "base",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              },
+              {
+                "field": "prod",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "cons",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "log2size",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              }
+            ]
+          }
+        },
+        {
+          "field": "eventq",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 24,
+          "Description": {
+            "name": "smmuv3_queue",
+            "version_id": 1,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "base",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              },
+              {
+                "field": "prod",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "cons",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "log2size",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              }
+            ]
+          }
+        }
+      ]
+    }
+  },
+  "pl011": {
+    "Name": "pl011",
+    "version_id": 2,
+    "minimum_version_id": 2,
+    "Description": {
+      "name": "pl011",
+      "version_id": 2,
+      "minimum_version_id": 2,
+      "Fields": [
+        {
+          "field": "readbuff",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "flags",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "lcr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "rsr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "cr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "dmacr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "int_enabled",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "int_level",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "read_fifo",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "ilpr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "ibrd",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "fbrd",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "ifl",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "read_pos",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "read_count",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "read_trigger",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "pl011/clock",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "clk",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8,
+              "Description": {
+                "name": "clock",
+                "version_id": 0,
+                "minimum_version_id": 0,
+                "Fields": [
+                  {
+                    "field": "period",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 8
+                  }
+                ],
+                "Subsections": [
+                  {
+                    "name": "clock/muldiv",
+                    "version_id": 1,
+                    "minimum_version_id": 1,
+                    "Fields": [
+                      {
+                        "field": "multiplier",
+                        "version_id": 0,
+                        "field_exists": false,
+                        "size": 4
+                      },
+                      {
+                        "field": "divider",
+                        "version_id": 0,
+                        "field_exists": false,
+                        "size": 4
+                      }
+                    ]
+                  }
+                ]
+              }
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "armv7m": {
+    "Name": "armv7m",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "armv7m",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "refclk",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8,
+          "Description": {
+            "name": "clock",
+            "version_id": 0,
+            "minimum_version_id": 0,
+            "Fields": [
+              {
+                "field": "period",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              }
+            ],
+            "Subsections": [
+              {
+                "name": "clock/muldiv",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "multiplier",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 4
+                  },
+                  {
+                    "field": "divider",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 4
+                  }
+                ]
+              }
+            ]
+          }
+        },
+        {
+          "field": "cpuclk",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8,
+          "Description": {
+            "name": "clock",
+            "version_id": 0,
+            "minimum_version_id": 0,
+            "Fields": [
+              {
+                "field": "period",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              }
+            ],
+            "Subsections": [
+              {
+                "name": "clock/muldiv",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "multiplier",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 4
+                  },
+                  {
+                    "field": "divider",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 4
+                  }
+                ]
+              }
+            ]
+          }
+        }
+      ]
+    }
+  },
+  "fw_cfg_mem": {
+    "Name": "fw_cfg_mem",
+    "version_id": 2,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "fw_cfg",
+      "version_id": 2,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "cur_entry",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 0,
+          "field_exists": true,
+          "size": 4
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 2,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "fw_cfg/dma",
+          "version_id": 0,
+          "minimum_version_id": 0,
+          "Fields": [
+            {
+              "field": "dma_addr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        },
+        {
+          "name": "fw_cfg/acpi_mr",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "table_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "linker_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "rsdp_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "pl031": {
+    "Name": "pl031",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "pl031",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "tick_offset_vmstate",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "mr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "lr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "cr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "im",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "is",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "pl031/tick-offset",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "tick_offset",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "fw_cfg_io": {
+    "Name": "fw_cfg_io",
+    "version_id": 2,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "fw_cfg",
+      "version_id": 2,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "cur_entry",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 0,
+          "field_exists": true,
+          "size": 4
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 2,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "fw_cfg/dma",
+          "version_id": 0,
+          "minimum_version_id": 0,
+          "Fields": [
+            {
+              "field": "dma_addr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        },
+        {
+          "name": "fw_cfg/acpi_mr",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "table_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "linker_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "rsdp_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "virtio-serial-device": {
+    "Name": "virtio-serial-device",
+    "version_id": 3,
+    "minimum_version_id": 3,
+    "Description": {
+      "name": "virtio-console",
+      "version_id": 3,
+      "minimum_version_id": 3,
+      "Fields": [
+        {
+          "field": "virtio",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 0
+        }
+      ]
+    }
+  },
+  "acpi-ged": {
+    "Name": "acpi-ged",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "acpi-ged",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "ged_state",
+          "version_id": 1,
+          "field_exists": false,
+          "size": 560,
+          "Description": {
+            "name": "acpi-ged-state",
+            "version_id": 1,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "sel",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              }
+            ]
+          }
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "acpi-ged/memhp",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "memhp_state",
+              "version_id": 1,
+              "field_exists": false,
+              "size": 304,
+              "Description": {
+                "name": "memory hotplug state",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "selector",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 4
+                  },
+                  {
+                    "field": "devs",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 24,
+                    "Description": {
+                      "name": "memory hotplug device state",
+                      "version_id": 1,
+                      "minimum_version_id": 1,
+                      "Fields": [
+                        {
+                          "field": "is_enabled",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 1
+                        },
+                        {
+                          "field": "is_inserting",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 1
+                        },
+                        {
+                          "field": "ost_event",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 4
+                        },
+                        {
+                          "field": "ost_status",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 4
+                        }
+                      ]
+                    }
+                  }
+                ]
+              }
+            }
+          ]
+        },
+        {
+          "name": "acpi-ged/ghes",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "ghes_state",
+              "version_id": 1,
+              "field_exists": false,
+              "size": 16,
+              "Description": {
+                "name": "acpi-ghes",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "ghes_addr_le",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 8
+                  }
+                ]
+              }
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "pcie-host-bridge": {
+    "Name": "pcie-host-bridge",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "PCIHost",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "config_reg",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ]
+    }
+  },
+  "gpio-key": {
+    "Name": "gpio-key",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "gpio-key",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "timer",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        }
+      ]
+    }
+  },
+  "armv7m_nvic": {
+    "Name": "armv7m_nvic",
+    "version_id": 4,
+    "minimum_version_id": 4,
+    "Description": {
+      "name": "armv7m_nvic",
+      "version_id": 4,
+      "minimum_version_id": 4,
+      "Fields": [
+        {
+          "field": "vectors",
+          "version_id": 1,
+          "field_exists": false,
+          "size": 6,
+          "Description": {
+            "name": "armv7m_nvic_info",
+            "version_id": 1,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "prio",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 2
+              },
+              {
+                "field": "enabled",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "pending",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "active",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "level",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              }
+            ]
+          }
+        },
+        {
+          "field": "prigroup[M_REG_NS]",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "armv7m_nvic/m-security",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "sec_vectors",
+              "version_id": 1,
+              "field_exists": false,
+              "size": 6,
+              "Description": {
+                "name": "armv7m_nvic_info",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "prio",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 2
+                  },
+                  {
+                    "field": "enabled",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 1
+                  },
+                  {
+                    "field": "pending",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 1
+                  },
+                  {
+                    "field": "active",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 1
+                  },
+                  {
+                    "field": "level",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 1
+                  }
+                ]
+              }
+            },
+            {
+              "field": "prigroup[M_REG_S]",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "itns",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 1
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "pci-host-bridge": {
+    "Name": "pci-host-bridge",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "PCIHost",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "config_reg",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ]
+    }
+  },
+  "gpex-root": {
+    "Name": "gpex-root",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "gpex_root",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "parent_obj",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2608,
+          "Description": {
+            "name": "PCIDevice",
+            "version_id": 2,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "version_id",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "config",
+                "version_id": 0,
+                "field_exists": true,
+                "size": 256
+              },
+              {
+                "field": "config",
+                "version_id": 0,
+                "field_exists": true,
+                "size": 4096
+              },
+              {
+                "field": "irq_state",
+                "version_id": 2,
+                "field_exists": false,
+                "size": 16
+              }
+            ]
+          }
+        }
+      ]
+    }
+  },
+  "armv7m_systick": {
+    "Name": "armv7m_systick",
+    "version_id": 3,
+    "minimum_version_id": 3,
+    "Description": {
+      "name": "armv7m_systick",
+      "version_id": 3,
+      "minimum_version_id": 3,
+      "Fields": [
+        {
+          "field": "refclk",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8,
+          "Description": {
+            "name": "clock",
+            "version_id": 0,
+            "minimum_version_id": 0,
+            "Fields": [
+              {
+                "field": "period",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              }
+            ],
+            "Subsections": [
+              {
+                "name": "clock/muldiv",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "multiplier",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 4
+                  },
+                  {
+                    "field": "divider",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 4
+                  }
+                ]
+              }
+            ]
+          }
+        },
+        {
+          "field": "cpuclk",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8,
+          "Description": {
+            "name": "clock",
+            "version_id": 0,
+            "minimum_version_id": 0,
+            "Fields": [
+              {
+                "field": "period",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              }
+            ],
+            "Subsections": [
+              {
+                "name": "clock/muldiv",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "multiplier",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 4
+                  },
+                  {
+                    "field": "divider",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 4
+                  }
+                ]
+              }
+            ]
+          }
+        },
+        {
+          "field": "control",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "tick",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        },
+        {
+          "field": "ptimer",
+          "version_id": 1,
+          "field_exists": false,
+          "size": 8,
+          "Description": {
+            "name": "ptimer",
+            "version_id": 1,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "enabled",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "limit",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              },
+              {
+                "field": "delta",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              },
+              {
+                "field": "period_frac",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "period",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              },
+              {
+                "field": "last_event",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              },
+              {
+                "field": "next_event",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              },
+              {
+                "field": "timer",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              }
+            ]
+          }
+        }
+      ]
+    }
+  }
+}
diff --git a/tests/data/vmstate-static-checker/m68k/virt-7.2.json b/tests/data/vmstate-static-checker/m68k/virt-7.2.json
new file mode 100644
index 00000000000..16bee8cdad0
--- /dev/null
+++ b/tests/data/vmstate-static-checker/m68k/virt-7.2.json
@@ -0,0 +1,2936 @@
+{
+  "vmschkmachine": {
+    "Name": "virt-7.2"
+  },
+  "m68020-m68k-cpu": {
+    "Name": "m68020-m68k-cpu",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "cpu",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "env.dregs",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.aregs",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.pc",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.sr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.current_sp",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.sp",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_op",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_x",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_n",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_v",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_c",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_z",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.pending_vector",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.pending_level",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "cpu/fpu",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.fpcr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.fpsr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.fregs",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 16,
+              "Description": {
+                "name": "freg",
+                "version_id": 0,
+                "minimum_version_id": 0,
+                "Fields": [
+                  {
+                    "field": "tmp",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 24,
+                    "Description": {
+                      "name": "freg_tmp",
+                      "version_id": 0,
+                      "minimum_version_id": 0,
+                      "Fields": [
+                        {
+                          "field": "tmp_mant",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 8
+                        },
+                        {
+                          "field": "tmp_exp",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 2
+                        }
+                      ]
+                    }
+                  }
+                ]
+              }
+            },
+            {
+              "field": "env.fp_result",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 16,
+              "Description": {
+                "name": "freg",
+                "version_id": 0,
+                "minimum_version_id": 0,
+                "Fields": [
+                  {
+                    "field": "tmp",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 24,
+                    "Description": {
+                      "name": "freg_tmp",
+                      "version_id": 0,
+                      "minimum_version_id": 0,
+                      "Fields": [
+                        {
+                          "field": "tmp_mant",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 8
+                        },
+                        {
+                          "field": "tmp_exp",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 2
+                        }
+                      ]
+                    }
+                  }
+                ]
+              }
+            }
+          ]
+        },
+        {
+          "name": "cpu/cf_spregs",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.macc",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "env.macsr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mac_mask",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.rambar0",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mbar",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        },
+        {
+          "name": "cpu/68040_mmu",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.mmu.ar",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.ssw",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.tcr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 2
+            },
+            {
+              "field": "env.mmu.urp",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.srp",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.fault",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 1
+            },
+            {
+              "field": "env.mmu.ttr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.mmusr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        },
+        {
+          "name": "cpu/68040_spregs",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.vbr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.cacr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.sfc",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.dfc",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "m68030-m68k-cpu": {
+    "Name": "m68030-m68k-cpu",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "cpu",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "env.dregs",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.aregs",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.pc",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.sr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.current_sp",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.sp",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_op",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_x",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_n",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_v",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_c",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_z",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.pending_vector",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.pending_level",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "cpu/fpu",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.fpcr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.fpsr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.fregs",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 16,
+              "Description": {
+                "name": "freg",
+                "version_id": 0,
+                "minimum_version_id": 0,
+                "Fields": [
+                  {
+                    "field": "tmp",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 24,
+                    "Description": {
+                      "name": "freg_tmp",
+                      "version_id": 0,
+                      "minimum_version_id": 0,
+                      "Fields": [
+                        {
+                          "field": "tmp_mant",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 8
+                        },
+                        {
+                          "field": "tmp_exp",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 2
+                        }
+                      ]
+                    }
+                  }
+                ]
+              }
+            },
+            {
+              "field": "env.fp_result",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 16,
+              "Description": {
+                "name": "freg",
+                "version_id": 0,
+                "minimum_version_id": 0,
+                "Fields": [
+                  {
+                    "field": "tmp",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 24,
+                    "Description": {
+                      "name": "freg_tmp",
+                      "version_id": 0,
+                      "minimum_version_id": 0,
+                      "Fields": [
+                        {
+                          "field": "tmp_mant",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 8
+                        },
+                        {
+                          "field": "tmp_exp",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 2
+                        }
+                      ]
+                    }
+                  }
+                ]
+              }
+            }
+          ]
+        },
+        {
+          "name": "cpu/cf_spregs",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.macc",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "env.macsr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mac_mask",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.rambar0",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mbar",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        },
+        {
+          "name": "cpu/68040_mmu",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.mmu.ar",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.ssw",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.tcr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 2
+            },
+            {
+              "field": "env.mmu.urp",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.srp",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.fault",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 1
+            },
+            {
+              "field": "env.mmu.ttr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.mmusr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        },
+        {
+          "name": "cpu/68040_spregs",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.vbr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.cacr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.sfc",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.dfc",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "fw_cfg": {
+    "Name": "fw_cfg",
+    "version_id": 2,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "fw_cfg",
+      "version_id": 2,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "cur_entry",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 0,
+          "field_exists": true,
+          "size": 4
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 2,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "fw_cfg/dma",
+          "version_id": 0,
+          "minimum_version_id": 0,
+          "Fields": [
+            {
+              "field": "dma_addr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        },
+        {
+          "name": "fw_cfg/acpi_mr",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "table_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "linker_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "rsdp_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "m68k-irq-controller": {
+    "Name": "m68k-irq-controller",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "m68k-irqc",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "ipr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        }
+      ]
+    }
+  },
+  "virt-ctrl": {
+    "Name": "virt-ctrl",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "virt-ctrl",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "irq_enabled",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ]
+    }
+  },
+  "m68040-m68k-cpu": {
+    "Name": "m68040-m68k-cpu",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "cpu",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "env.dregs",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.aregs",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.pc",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.sr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.current_sp",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.sp",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_op",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_x",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_n",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_v",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_c",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_z",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.pending_vector",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.pending_level",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "cpu/fpu",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.fpcr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.fpsr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.fregs",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 16,
+              "Description": {
+                "name": "freg",
+                "version_id": 0,
+                "minimum_version_id": 0,
+                "Fields": [
+                  {
+                    "field": "tmp",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 24,
+                    "Description": {
+                      "name": "freg_tmp",
+                      "version_id": 0,
+                      "minimum_version_id": 0,
+                      "Fields": [
+                        {
+                          "field": "tmp_mant",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 8
+                        },
+                        {
+                          "field": "tmp_exp",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 2
+                        }
+                      ]
+                    }
+                  }
+                ]
+              }
+            },
+            {
+              "field": "env.fp_result",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 16,
+              "Description": {
+                "name": "freg",
+                "version_id": 0,
+                "minimum_version_id": 0,
+                "Fields": [
+                  {
+                    "field": "tmp",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 24,
+                    "Description": {
+                      "name": "freg_tmp",
+                      "version_id": 0,
+                      "minimum_version_id": 0,
+                      "Fields": [
+                        {
+                          "field": "tmp_mant",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 8
+                        },
+                        {
+                          "field": "tmp_exp",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 2
+                        }
+                      ]
+                    }
+                  }
+                ]
+              }
+            }
+          ]
+        },
+        {
+          "name": "cpu/cf_spregs",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.macc",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "env.macsr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mac_mask",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.rambar0",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mbar",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        },
+        {
+          "name": "cpu/68040_mmu",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.mmu.ar",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.ssw",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.tcr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 2
+            },
+            {
+              "field": "env.mmu.urp",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.srp",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.fault",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 1
+            },
+            {
+              "field": "env.mmu.ttr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.mmusr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        },
+        {
+          "name": "cpu/68040_spregs",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.vbr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.cacr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.sfc",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.dfc",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "goldfish_pic": {
+    "Name": "goldfish_pic",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "goldfish_pic",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "pending",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "enabled",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ]
+    }
+  },
+  "goldfish_tty": {
+    "Name": "goldfish_tty",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "goldfish_tty",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "data_len",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "data_ptr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        },
+        {
+          "field": "int_enabled",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "rx_fifo",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 24,
+          "Description": {
+            "name": "Fifo8",
+            "version_id": 1,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "data",
+                "version_id": 1,
+                "field_exists": false,
+                "size": 0
+              },
+              {
+                "field": "head",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "num",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              }
+            ]
+          }
+        }
+      ]
+    }
+  },
+  "m68000-m68k-cpu": {
+    "Name": "m68000-m68k-cpu",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "cpu",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "env.dregs",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.aregs",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.pc",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.sr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.current_sp",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.sp",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_op",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_x",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_n",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_v",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_c",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_z",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.pending_vector",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.pending_level",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "cpu/fpu",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.fpcr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.fpsr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.fregs",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 16,
+              "Description": {
+                "name": "freg",
+                "version_id": 0,
+                "minimum_version_id": 0,
+                "Fields": [
+                  {
+                    "field": "tmp",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 24,
+                    "Description": {
+                      "name": "freg_tmp",
+                      "version_id": 0,
+                      "minimum_version_id": 0,
+                      "Fields": [
+                        {
+                          "field": "tmp_mant",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 8
+                        },
+                        {
+                          "field": "tmp_exp",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 2
+                        }
+                      ]
+                    }
+                  }
+                ]
+              }
+            },
+            {
+              "field": "env.fp_result",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 16,
+              "Description": {
+                "name": "freg",
+                "version_id": 0,
+                "minimum_version_id": 0,
+                "Fields": [
+                  {
+                    "field": "tmp",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 24,
+                    "Description": {
+                      "name": "freg_tmp",
+                      "version_id": 0,
+                      "minimum_version_id": 0,
+                      "Fields": [
+                        {
+                          "field": "tmp_mant",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 8
+                        },
+                        {
+                          "field": "tmp_exp",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 2
+                        }
+                      ]
+                    }
+                  }
+                ]
+              }
+            }
+          ]
+        },
+        {
+          "name": "cpu/cf_spregs",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.macc",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "env.macsr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mac_mask",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.rambar0",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mbar",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        },
+        {
+          "name": "cpu/68040_mmu",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.mmu.ar",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.ssw",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.tcr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 2
+            },
+            {
+              "field": "env.mmu.urp",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.srp",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.fault",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 1
+            },
+            {
+              "field": "env.mmu.ttr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.mmusr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        },
+        {
+          "name": "cpu/68040_spregs",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.vbr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.cacr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.sfc",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.dfc",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "m68010-m68k-cpu": {
+    "Name": "m68010-m68k-cpu",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "cpu",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "env.dregs",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.aregs",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.pc",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.sr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.current_sp",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.sp",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_op",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_x",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_n",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_v",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_c",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_z",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.pending_vector",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.pending_level",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "cpu/fpu",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.fpcr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.fpsr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.fregs",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 16,
+              "Description": {
+                "name": "freg",
+                "version_id": 0,
+                "minimum_version_id": 0,
+                "Fields": [
+                  {
+                    "field": "tmp",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 24,
+                    "Description": {
+                      "name": "freg_tmp",
+                      "version_id": 0,
+                      "minimum_version_id": 0,
+                      "Fields": [
+                        {
+                          "field": "tmp_mant",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 8
+                        },
+                        {
+                          "field": "tmp_exp",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 2
+                        }
+                      ]
+                    }
+                  }
+                ]
+              }
+            },
+            {
+              "field": "env.fp_result",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 16,
+              "Description": {
+                "name": "freg",
+                "version_id": 0,
+                "minimum_version_id": 0,
+                "Fields": [
+                  {
+                    "field": "tmp",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 24,
+                    "Description": {
+                      "name": "freg_tmp",
+                      "version_id": 0,
+                      "minimum_version_id": 0,
+                      "Fields": [
+                        {
+                          "field": "tmp_mant",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 8
+                        },
+                        {
+                          "field": "tmp_exp",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 2
+                        }
+                      ]
+                    }
+                  }
+                ]
+              }
+            }
+          ]
+        },
+        {
+          "name": "cpu/cf_spregs",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.macc",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "env.macsr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mac_mask",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.rambar0",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mbar",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        },
+        {
+          "name": "cpu/68040_mmu",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.mmu.ar",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.ssw",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.tcr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 2
+            },
+            {
+              "field": "env.mmu.urp",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.srp",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.fault",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 1
+            },
+            {
+              "field": "env.mmu.ttr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.mmusr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        },
+        {
+          "name": "cpu/68040_spregs",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.vbr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.cacr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.sfc",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.dfc",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "m68060-m68k-cpu": {
+    "Name": "m68060-m68k-cpu",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "cpu",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "env.dregs",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.aregs",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.pc",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.sr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.current_sp",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.sp",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_op",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_x",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_n",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_v",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_c",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_z",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.pending_vector",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.pending_level",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "cpu/fpu",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.fpcr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.fpsr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.fregs",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 16,
+              "Description": {
+                "name": "freg",
+                "version_id": 0,
+                "minimum_version_id": 0,
+                "Fields": [
+                  {
+                    "field": "tmp",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 24,
+                    "Description": {
+                      "name": "freg_tmp",
+                      "version_id": 0,
+                      "minimum_version_id": 0,
+                      "Fields": [
+                        {
+                          "field": "tmp_mant",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 8
+                        },
+                        {
+                          "field": "tmp_exp",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 2
+                        }
+                      ]
+                    }
+                  }
+                ]
+              }
+            },
+            {
+              "field": "env.fp_result",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 16,
+              "Description": {
+                "name": "freg",
+                "version_id": 0,
+                "minimum_version_id": 0,
+                "Fields": [
+                  {
+                    "field": "tmp",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 24,
+                    "Description": {
+                      "name": "freg_tmp",
+                      "version_id": 0,
+                      "minimum_version_id": 0,
+                      "Fields": [
+                        {
+                          "field": "tmp_mant",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 8
+                        },
+                        {
+                          "field": "tmp_exp",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 2
+                        }
+                      ]
+                    }
+                  }
+                ]
+              }
+            }
+          ]
+        },
+        {
+          "name": "cpu/cf_spregs",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.macc",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "env.macsr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mac_mask",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.rambar0",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mbar",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        },
+        {
+          "name": "cpu/68040_mmu",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.mmu.ar",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.ssw",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.tcr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 2
+            },
+            {
+              "field": "env.mmu.urp",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.srp",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.fault",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 1
+            },
+            {
+              "field": "env.mmu.ttr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.mmusr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        },
+        {
+          "name": "cpu/68040_spregs",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.vbr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.cacr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.sfc",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.dfc",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "fw_cfg_mem": {
+    "Name": "fw_cfg_mem",
+    "version_id": 2,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "fw_cfg",
+      "version_id": 2,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "cur_entry",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 0,
+          "field_exists": true,
+          "size": 4
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 2,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "fw_cfg/dma",
+          "version_id": 0,
+          "minimum_version_id": 0,
+          "Fields": [
+            {
+              "field": "dma_addr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        },
+        {
+          "name": "fw_cfg/acpi_mr",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "table_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "linker_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "rsdp_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "any-m68k-cpu": {
+    "Name": "any-m68k-cpu",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "cpu",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "env.dregs",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.aregs",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.pc",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.sr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.current_sp",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.sp",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_op",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_x",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_n",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_v",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_c",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_z",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.pending_vector",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.pending_level",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "cpu/fpu",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.fpcr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.fpsr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.fregs",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 16,
+              "Description": {
+                "name": "freg",
+                "version_id": 0,
+                "minimum_version_id": 0,
+                "Fields": [
+                  {
+                    "field": "tmp",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 24,
+                    "Description": {
+                      "name": "freg_tmp",
+                      "version_id": 0,
+                      "minimum_version_id": 0,
+                      "Fields": [
+                        {
+                          "field": "tmp_mant",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 8
+                        },
+                        {
+                          "field": "tmp_exp",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 2
+                        }
+                      ]
+                    }
+                  }
+                ]
+              }
+            },
+            {
+              "field": "env.fp_result",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 16,
+              "Description": {
+                "name": "freg",
+                "version_id": 0,
+                "minimum_version_id": 0,
+                "Fields": [
+                  {
+                    "field": "tmp",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 24,
+                    "Description": {
+                      "name": "freg_tmp",
+                      "version_id": 0,
+                      "minimum_version_id": 0,
+                      "Fields": [
+                        {
+                          "field": "tmp_mant",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 8
+                        },
+                        {
+                          "field": "tmp_exp",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 2
+                        }
+                      ]
+                    }
+                  }
+                ]
+              }
+            }
+          ]
+        },
+        {
+          "name": "cpu/cf_spregs",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.macc",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "env.macsr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mac_mask",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.rambar0",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mbar",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        },
+        {
+          "name": "cpu/68040_mmu",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.mmu.ar",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.ssw",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.tcr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 2
+            },
+            {
+              "field": "env.mmu.urp",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.srp",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.fault",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 1
+            },
+            {
+              "field": "env.mmu.ttr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.mmusr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        },
+        {
+          "name": "cpu/68040_spregs",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.vbr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.cacr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.sfc",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.dfc",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "fw_cfg_io": {
+    "Name": "fw_cfg_io",
+    "version_id": 2,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "fw_cfg",
+      "version_id": 2,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "cur_entry",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 0,
+          "field_exists": true,
+          "size": 4
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 2,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "fw_cfg/dma",
+          "version_id": 0,
+          "minimum_version_id": 0,
+          "Fields": [
+            {
+              "field": "dma_addr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        },
+        {
+          "name": "fw_cfg/acpi_mr",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "table_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "linker_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "rsdp_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "virtio-serial-device": {
+    "Name": "virtio-serial-device",
+    "version_id": 3,
+    "minimum_version_id": 3,
+    "Description": {
+      "name": "virtio-console",
+      "version_id": 3,
+      "minimum_version_id": 3,
+      "Fields": [
+        {
+          "field": "virtio",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 0
+        }
+      ]
+    }
+  },
+  "goldfish_rtc": {
+    "Name": "goldfish_rtc",
+    "version_id": 3,
+    "minimum_version_id": 0,
+    "Description": {
+      "name": "goldfish_rtc",
+      "version_id": 3,
+      "minimum_version_id": 0,
+      "Fields": [
+        {
+          "field": "tick_offset_vmstate",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        },
+        {
+          "field": "alarm_next",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        },
+        {
+          "field": "alarm_running",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "irq_pending",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "irq_enabled",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "time_high",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "tick_offset",
+          "version_id": 3,
+          "field_exists": false,
+          "size": 8
+        }
+      ]
+    }
+  },
+  "m68k-cpu": {
+    "Name": "m68k-cpu",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "cpu",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "env.dregs",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.aregs",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.pc",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.sr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.current_sp",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.sp",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_op",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_x",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_n",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_v",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_c",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.cc_z",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.pending_vector",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "env.pending_level",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "cpu/fpu",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.fpcr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.fpsr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.fregs",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 16,
+              "Description": {
+                "name": "freg",
+                "version_id": 0,
+                "minimum_version_id": 0,
+                "Fields": [
+                  {
+                    "field": "tmp",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 24,
+                    "Description": {
+                      "name": "freg_tmp",
+                      "version_id": 0,
+                      "minimum_version_id": 0,
+                      "Fields": [
+                        {
+                          "field": "tmp_mant",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 8
+                        },
+                        {
+                          "field": "tmp_exp",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 2
+                        }
+                      ]
+                    }
+                  }
+                ]
+              }
+            },
+            {
+              "field": "env.fp_result",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 16,
+              "Description": {
+                "name": "freg",
+                "version_id": 0,
+                "minimum_version_id": 0,
+                "Fields": [
+                  {
+                    "field": "tmp",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 24,
+                    "Description": {
+                      "name": "freg_tmp",
+                      "version_id": 0,
+                      "minimum_version_id": 0,
+                      "Fields": [
+                        {
+                          "field": "tmp_mant",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 8
+                        },
+                        {
+                          "field": "tmp_exp",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 2
+                        }
+                      ]
+                    }
+                  }
+                ]
+              }
+            }
+          ]
+        },
+        {
+          "name": "cpu/cf_spregs",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.macc",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "env.macsr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mac_mask",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.rambar0",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mbar",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        },
+        {
+          "name": "cpu/68040_mmu",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.mmu.ar",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.ssw",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.tcr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 2
+            },
+            {
+              "field": "env.mmu.urp",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.srp",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.fault",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 1
+            },
+            {
+              "field": "env.mmu.ttr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.mmu.mmusr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        },
+        {
+          "name": "cpu/68040_spregs",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "env.vbr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.cacr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.sfc",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            },
+            {
+              "field": "env.dfc",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        }
+      ]
+    }
+  }
+}
diff --git a/tests/data/vmstate-static-checker/ppc64/pseries-7.2.json b/tests/data/vmstate-static-checker/ppc64/pseries-7.2.json
new file mode 100644
index 00000000000..330bbbefedf
--- /dev/null
+++ b/tests/data/vmstate-static-checker/ppc64/pseries-7.2.json
@@ -0,0 +1,1068 @@
+{
+  "vmschkmachine": {
+    "Name": "pseries-7.2"
+  },
+  "spapr-nvram": {
+    "Name": "spapr-nvram",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "spapr_nvram",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "size",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "buf",
+          "version_id": 1,
+          "field_exists": false,
+          "size": 0
+        }
+      ]
+    }
+  },
+  "xive-source": {
+    "Name": "xive-source",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "xive-source",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "nr_irqs",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "status",
+          "version_id": 1,
+          "field_exists": false,
+          "size": 0
+        }
+      ]
+    }
+  },
+  "xive-tctx": {
+    "Name": "xive-tctx",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "xive-tctx",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "regs",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 64
+        }
+      ]
+    }
+  },
+  "pci-host-bridge": {
+    "Name": "pci-host-bridge",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "PCIHost",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "config_reg",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ]
+    }
+  },
+  "ics-spapr": {
+    "Name": "ics-spapr",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "ics",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "nr_irqs",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "irqs",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8,
+          "Description": {
+            "name": "ics/irq",
+            "version_id": 2,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "server",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "priority",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "saved_priority",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "status",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "flags",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              }
+            ]
+          }
+        }
+      ]
+    }
+  },
+  "scsi-cd": {
+    "Name": "scsi-cd",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "scsi-disk",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "qdev",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 608,
+          "Description": {
+            "name": "SCSIDevice",
+            "version_id": 1,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "unit_attention.key",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "unit_attention.asc",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "unit_attention.ascq",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "sense_is_ua",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "sense",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "sense_len",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "requests",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 0
+              }
+            ],
+            "Subsections": [
+              {
+                "name": "SCSIDevice/sense",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "sense",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 1
+                  }
+                ]
+              }
+            ]
+          }
+        },
+        {
+          "field": "media_changed",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "media_event",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "eject_request",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "tray_open",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "tray_locked",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        }
+      ]
+    }
+  },
+  "spapr-xive": {
+    "Name": "spapr-xive",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "spapr-xive",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "nr_irqs",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "eat",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8,
+          "Description": {
+            "name": "spapr-xive/eas",
+            "version_id": 1,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "w",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              }
+            ]
+          }
+        },
+        {
+          "field": "endt",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 32,
+          "Description": {
+            "name": "spapr-xive/end",
+            "version_id": 1,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "w0",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "w1",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "w2",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "w3",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "w4",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "w5",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "w6",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "w7",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              }
+            ]
+          }
+        }
+      ]
+    }
+  },
+  "scsi-hd": {
+    "Name": "scsi-hd",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "scsi-disk",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "qdev",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 608,
+          "Description": {
+            "name": "SCSIDevice",
+            "version_id": 1,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "unit_attention.key",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "unit_attention.asc",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "unit_attention.ascq",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "sense_is_ua",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "sense",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "sense_len",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "requests",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 0
+              }
+            ],
+            "Subsections": [
+              {
+                "name": "SCSIDevice/sense",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "sense",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 1
+                  }
+                ]
+              }
+            ]
+          }
+        },
+        {
+          "field": "media_changed",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "media_event",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "eject_request",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "tray_open",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "tray_locked",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        }
+      ]
+    }
+  },
+  "fw_cfg_mem": {
+    "Name": "fw_cfg_mem",
+    "version_id": 2,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "fw_cfg",
+      "version_id": 2,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "cur_entry",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 0,
+          "field_exists": true,
+          "size": 4
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 2,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "fw_cfg/dma",
+          "version_id": 0,
+          "minimum_version_id": 0,
+          "Fields": [
+            {
+              "field": "dma_addr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        },
+        {
+          "name": "fw_cfg/acpi_mr",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "table_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "linker_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "rsdp_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "spapr-vty": {
+    "Name": "spapr-vty",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "spapr_vty",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "sdev",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 848,
+          "Description": {
+            "name": "spapr_vio",
+            "version_id": 1,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "reg",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "irq",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "signal_state",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              },
+              {
+                "field": "crq.qladdr",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              },
+              {
+                "field": "crq.qsize",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "crq.qnext",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              }
+            ]
+          }
+        },
+        {
+          "field": "in",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "out",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "buf",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 16
+        }
+      ]
+    }
+  },
+  "spapr-wdt": {
+    "Name": "spapr-wdt",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "spapr_watchdog",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "timer",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 48
+        },
+        {
+          "field": "action",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "leave_others",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        }
+      ]
+    }
+  },
+  "fw_cfg_io": {
+    "Name": "fw_cfg_io",
+    "version_id": 2,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "fw_cfg",
+      "version_id": 2,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "cur_entry",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 0,
+          "field_exists": true,
+          "size": 4
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 2,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "fw_cfg/dma",
+          "version_id": 0,
+          "minimum_version_id": 0,
+          "Fields": [
+            {
+              "field": "dma_addr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        },
+        {
+          "name": "fw_cfg/acpi_mr",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "table_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "linker_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "rsdp_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "spapr-vscsi": {
+    "Name": "spapr-vscsi",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "spapr_vscsi",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "vdev",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 848,
+          "Description": {
+            "name": "spapr_vio",
+            "version_id": 1,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "reg",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "irq",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "signal_state",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              },
+              {
+                "field": "crq.qladdr",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              },
+              {
+                "field": "crq.qsize",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "crq.qnext",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              }
+            ]
+          }
+        }
+      ]
+    }
+  },
+  "spapr-rtc": {
+    "Name": "spapr-rtc",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "spapr/rtc",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "ns_offset",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        }
+      ]
+    }
+  },
+  "spapr-vlan": {
+    "Name": "spapr-vlan",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "spapr_llan",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "sdev",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 848,
+          "Description": {
+            "name": "spapr_vio",
+            "version_id": 1,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "reg",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "irq",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "signal_state",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              },
+              {
+                "field": "crq.qladdr",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              },
+              {
+                "field": "crq.qsize",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "crq.qnext",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              }
+            ]
+          }
+        },
+        {
+          "field": "isopen",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "buf_list",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        },
+        {
+          "field": "add_buf_ptr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "use_buf_ptr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "rx_bufs",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "rxq_ptr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "spapr_llan/rx_pools",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "rx_pool",
+              "version_id": 1,
+              "field_exists": false,
+              "size": 8,
+              "Description": {
+                "name": "spapr_llan/rx_buffer_pool",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "bufsize",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 4
+                  },
+                  {
+                    "field": "count",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 4
+                  },
+                  {
+                    "field": "bds",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 8
+                  }
+                ]
+              }
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "fw_cfg": {
+    "Name": "fw_cfg",
+    "version_id": 2,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "fw_cfg",
+      "version_id": 2,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "cur_entry",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 0,
+          "field_exists": true,
+          "size": 4
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 2,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "fw_cfg/dma",
+          "version_id": 0,
+          "minimum_version_id": 0,
+          "Fields": [
+            {
+              "field": "dma_addr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        },
+        {
+          "name": "fw_cfg/acpi_mr",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "table_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "linker_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "rsdp_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "ics": {
+    "Name": "ics",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "ics",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "nr_irqs",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "irqs",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8,
+          "Description": {
+            "name": "ics/irq",
+            "version_id": 2,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "server",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "priority",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "saved_priority",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "status",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "flags",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              }
+            ]
+          }
+        }
+      ]
+    }
+  }
+}
diff --git a/tests/data/vmstate-static-checker/s390x/s390-ccw-virtio-7.2.json b/tests/data/vmstate-static-checker/s390x/s390-ccw-virtio-7.2.json
new file mode 100644
index 00000000000..9698852bd38
--- /dev/null
+++ b/tests/data/vmstate-static-checker/s390x/s390-ccw-virtio-7.2.json
@@ -0,0 +1,475 @@
+{
+  "vmschkmachine": {
+    "Name": "s390-ccw-virtio-7.2"
+  },
+  "sclpquiesce": {
+    "Name": "sclpquiesce",
+    "version_id": 0,
+    "minimum_version_id": 0,
+    "Description": {
+      "name": "sclpquiesce",
+      "version_id": 0,
+      "minimum_version_id": 0,
+      "Fields": [
+        {
+          "field": "event_pending",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        }
+      ]
+    }
+  },
+  "s390-sclp-event-facility": {
+    "Name": "s390-sclp-event-facility",
+    "version_id": 0,
+    "minimum_version_id": 0,
+    "Description": {
+      "name": "vmstate-event-facility",
+      "version_id": 0,
+      "minimum_version_id": 0,
+      "Fields": [
+        {
+          "field": "receive_mask_pieces[1]",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "vmstate-event-facility/mask64",
+          "version_id": 0,
+          "minimum_version_id": 0,
+          "Fields": [
+            {
+              "field": "receive_mask_pieces[0]",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        },
+        {
+          "name": "vmstate-event-facility/mask_length",
+          "version_id": 0,
+          "minimum_version_id": 0,
+          "Fields": [
+            {
+              "field": "mask_length",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 2
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "zpci": {
+    "Name": "zpci",
+    "version_id": 0,
+    "minimum_version_id": 0,
+    "Description": {
+      "name": "zpci",
+      "version_id": 0,
+      "minimum_version_id": 0
+    }
+  },
+  "sclpconsole": {
+    "Name": "sclpconsole",
+    "version_id": 0,
+    "minimum_version_id": 0,
+    "Description": {
+      "name": "sclpconsole",
+      "version_id": 0,
+      "minimum_version_id": 0,
+      "Fields": [
+        {
+          "field": "event.event_pending",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "iov",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "iov_sclp",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "iov_bs",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "iov_data_len",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "iov_sclp_rest",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ]
+    }
+  },
+  "virtio-serial-device": {
+    "Name": "virtio-serial-device",
+    "version_id": 3,
+    "minimum_version_id": 3,
+    "Description": {
+      "name": "virtio-console",
+      "version_id": 3,
+      "minimum_version_id": 3,
+      "Fields": [
+        {
+          "field": "virtio",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 0
+        }
+      ]
+    }
+  },
+  "sclplmconsole": {
+    "Name": "sclplmconsole",
+    "version_id": 0,
+    "minimum_version_id": 0,
+    "Description": {
+      "name": "sclplmconsole",
+      "version_id": 0,
+      "minimum_version_id": 0,
+      "Fields": [
+        {
+          "field": "event.event_pending",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "write_errors",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "length",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "buf",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        }
+      ]
+    }
+  },
+  "s390-pcihost": {
+    "Name": "s390-pcihost",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "PCIHost",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "config_reg",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ]
+    }
+  },
+  "s390-flic-qemu": {
+    "Name": "s390-flic-qemu",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "qemu-s390-flic",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "simm",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "nimm",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        }
+      ]
+    }
+  },
+  "fw_cfg_io": {
+    "Name": "fw_cfg_io",
+    "version_id": 2,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "fw_cfg",
+      "version_id": 2,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "cur_entry",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 0,
+          "field_exists": true,
+          "size": 4
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 2,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "fw_cfg/dma",
+          "version_id": 0,
+          "minimum_version_id": 0,
+          "Fields": [
+            {
+              "field": "dma_addr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        },
+        {
+          "name": "fw_cfg/acpi_mr",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "table_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "linker_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "rsdp_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "s390-ipl": {
+    "Name": "s390-ipl",
+    "version_id": 0,
+    "minimum_version_id": 0,
+    "Description": {
+      "name": "ipl",
+      "version_id": 0,
+      "minimum_version_id": 0,
+      "Fields": [
+        {
+          "field": "compat_start_addr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        },
+        {
+          "field": "compat_bios_start_addr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        },
+        {
+          "field": "iplb",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4096,
+          "Description": {
+            "name": "ipl/iplb",
+            "version_id": 0,
+            "minimum_version_id": 0,
+            "Fields": [
+              {
+                "field": "reserved1",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "devno",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 2
+              },
+              {
+                "field": "reserved2",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              }
+            ],
+            "Subsections": [
+              {
+                "name": "ipl/iplb_extended",
+                "version_id": 0,
+                "minimum_version_id": 0,
+                "Fields": [
+                  {
+                    "field": "reserved_ext",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 1
+                  }
+                ]
+              }
+            ]
+          }
+        },
+        {
+          "field": "iplb_valid",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "cssid",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "ssid",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "devno",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2
+        }
+      ]
+    }
+  },
+  "pci-host-bridge": {
+    "Name": "pci-host-bridge",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "PCIHost",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "config_reg",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ]
+    }
+  },
+  "fw_cfg_mem": {
+    "Name": "fw_cfg_mem",
+    "version_id": 2,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "fw_cfg",
+      "version_id": 2,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "cur_entry",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 0,
+          "field_exists": true,
+          "size": 4
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 2,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "fw_cfg/dma",
+          "version_id": 0,
+          "minimum_version_id": 0,
+          "Fields": [
+            {
+              "field": "dma_addr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        },
+        {
+          "name": "fw_cfg/acpi_mr",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "table_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "linker_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "rsdp_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        }
+      ]
+    }
+  }
+}
diff --git a/tests/data/vmstate-static-checker/x86_64/pc-q35-7.2.json b/tests/data/vmstate-static-checker/x86_64/pc-q35-7.2.json
new file mode 100644
index 00000000000..e527dffacca
--- /dev/null
+++ b/tests/data/vmstate-static-checker/x86_64/pc-q35-7.2.json
@@ -0,0 +1,3297 @@
+{
+  "vmschkmachine": {
+    "Name": "pc-q35-7.2"
+  },
+  "fw_cfg": {
+    "Name": "fw_cfg",
+    "version_id": 2,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "fw_cfg",
+      "version_id": 2,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "cur_entry",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 0,
+          "field_exists": true,
+          "size": 4
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 2,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "fw_cfg/dma",
+          "version_id": 0,
+          "minimum_version_id": 0,
+          "Fields": [
+            {
+              "field": "dma_addr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        },
+        {
+          "name": "fw_cfg/acpi_mr",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "table_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "linker_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "rsdp_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "pcie-host-bridge": {
+    "Name": "pcie-host-bridge",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "PCIHost",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "config_reg",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ]
+    }
+  },
+  "isa-pit": {
+    "Name": "isa-pit",
+    "version_id": 3,
+    "minimum_version_id": 2,
+    "Description": {
+      "name": "i8254",
+      "version_id": 3,
+      "minimum_version_id": 2,
+      "Fields": [
+        {
+          "field": "channels[0].irq_disabled",
+          "version_id": 3,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "channels",
+          "version_id": 2,
+          "field_exists": false,
+          "size": 56,
+          "Description": {
+            "name": "pit channel",
+            "version_id": 2,
+            "minimum_version_id": 2,
+            "Fields": [
+              {
+                "field": "count",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "latched_count",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 2
+              },
+              {
+                "field": "count_latched",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "status_latched",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "status",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "read_state",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "write_state",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "write_latch",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "rw_mode",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "mode",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "bcd",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "gate",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "count_load_time",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              },
+              {
+                "field": "next_transition_time",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              }
+            ]
+          }
+        },
+        {
+          "field": "channels[0].next_transition_time",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        }
+      ]
+    }
+  },
+  "mch": {
+    "Name": "mch",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "mch",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "parent_obj",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2608,
+          "Description": {
+            "name": "PCIDevice",
+            "version_id": 2,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "version_id",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "config",
+                "version_id": 0,
+                "field_exists": true,
+                "size": 256
+              },
+              {
+                "field": "config",
+                "version_id": 0,
+                "field_exists": true,
+                "size": 4096
+              },
+              {
+                "field": "irq_state",
+                "version_id": 2,
+                "field_exists": false,
+                "size": 16
+              }
+            ]
+          }
+        },
+        {
+          "field": "unused",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        }
+      ]
+    }
+  },
+  "pic-common": {
+    "Name": "pic-common",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "i8259",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "last_irr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "irr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "imr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "isr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "priority_add",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "irq_base",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "read_reg_select",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "poll",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "special_mask",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "init_state",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "auto_eoi",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "rotate_on_auto_eoi",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "special_fully_nested_mode",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "init4",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "single_mode",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "elcr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        }
+      ]
+    }
+  },
+  "ICH9-LPC": {
+    "Name": "ICH9-LPC",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "ICH9LPC",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "d",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2608,
+          "Description": {
+            "name": "PCIDevice",
+            "version_id": 2,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "version_id",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "config",
+                "version_id": 0,
+                "field_exists": true,
+                "size": 256
+              },
+              {
+                "field": "config",
+                "version_id": 0,
+                "field_exists": true,
+                "size": 4096
+              },
+              {
+                "field": "irq_state",
+                "version_id": 2,
+                "field_exists": false,
+                "size": 16
+              }
+            ]
+          }
+        },
+        {
+          "field": "apm",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 304,
+          "Description": {
+            "name": "APM State",
+            "version_id": 1,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "apmc",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "apms",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              }
+            ]
+          }
+        },
+        {
+          "field": "pm",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 6480,
+          "Description": {
+            "name": "ich9_pm",
+            "version_id": 1,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "acpi_regs.pm1.evt.sts",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 2
+              },
+              {
+                "field": "acpi_regs.pm1.evt.en",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 2
+              },
+              {
+                "field": "acpi_regs.pm1.cnt.cnt",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 2
+              },
+              {
+                "field": "acpi_regs.tmr.timer",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              },
+              {
+                "field": "acpi_regs.tmr.overflow_time",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              },
+              {
+                "field": "acpi_regs.gpe.sts",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "acpi_regs.gpe.en",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "smi_en",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "smi_sts",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              }
+            ],
+            "Subsections": [
+              {
+                "name": "ich9_pm/memhp",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "acpi_memory_hotplug",
+                    "version_id": 1,
+                    "field_exists": false,
+                    "size": 304,
+                    "Description": {
+                      "name": "memory hotplug state",
+                      "version_id": 1,
+                      "minimum_version_id": 1,
+                      "Fields": [
+                        {
+                          "field": "selector",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 4
+                        },
+                        {
+                          "field": "devs",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 24,
+                          "Description": {
+                            "name": "memory hotplug device state",
+                            "version_id": 1,
+                            "minimum_version_id": 1,
+                            "Fields": [
+                              {
+                                "field": "is_enabled",
+                                "version_id": 0,
+                                "field_exists": false,
+                                "size": 1
+                              },
+                              {
+                                "field": "is_inserting",
+                                "version_id": 0,
+                                "field_exists": false,
+                                "size": 1
+                              },
+                              {
+                                "field": "ost_event",
+                                "version_id": 0,
+                                "field_exists": false,
+                                "size": 4
+                              },
+                              {
+                                "field": "ost_status",
+                                "version_id": 0,
+                                "field_exists": false,
+                                "size": 4
+                              }
+                            ]
+                          }
+                        }
+                      ]
+                    }
+                  }
+                ]
+              },
+              {
+                "name": "ich9_pm/tco",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "tco_regs",
+                    "version_id": 1,
+                    "field_exists": false,
+                    "size": 320,
+                    "Description": {
+                      "name": "tco io device status",
+                      "version_id": 1,
+                      "minimum_version_id": 1,
+                      "Fields": [
+                        {
+                          "field": "tco.rld",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 2
+                        },
+                        {
+                          "field": "tco.din",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 1
+                        },
+                        {
+                          "field": "tco.dout",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 1
+                        },
+                        {
+                          "field": "tco.sts1",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 2
+                        },
+                        {
+                          "field": "tco.sts2",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 2
+                        },
+                        {
+                          "field": "tco.cnt1",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 2
+                        },
+                        {
+                          "field": "tco.cnt2",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 2
+                        },
+                        {
+                          "field": "tco.msg1",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 1
+                        },
+                        {
+                          "field": "tco.msg2",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 1
+                        },
+                        {
+                          "field": "tco.wdcnt",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 1
+                        },
+                        {
+                          "field": "tco.tmr",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 2
+                        },
+                        {
+                          "field": "sw_irq_gen",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 1
+                        },
+                        {
+                          "field": "tco_timer",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 8
+                        },
+                        {
+                          "field": "expire_time",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 8
+                        },
+                        {
+                          "field": "timeouts_no",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 1
+                        }
+                      ]
+                    }
+                  }
+                ]
+              },
+              {
+                "name": "ich9_pm/cpuhp",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "cpuhp_state",
+                    "version_id": 1,
+                    "field_exists": false,
+                    "size": 304,
+                    "Description": {
+                      "name": "CPU hotplug state",
+                      "version_id": 1,
+                      "minimum_version_id": 1,
+                      "Fields": [
+                        {
+                          "field": "selector",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 4
+                        },
+                        {
+                          "field": "command",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 1
+                        },
+                        {
+                          "field": "devs",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 32,
+                          "Description": {
+                            "name": "CPU hotplug device state",
+                            "version_id": 1,
+                            "minimum_version_id": 1,
+                            "Fields": [
+                              {
+                                "field": "is_inserting",
+                                "version_id": 0,
+                                "field_exists": false,
+                                "size": 1
+                              },
+                              {
+                                "field": "is_removing",
+                                "version_id": 0,
+                                "field_exists": false,
+                                "size": 1
+                              },
+                              {
+                                "field": "ost_event",
+                                "version_id": 0,
+                                "field_exists": false,
+                                "size": 4
+                              },
+                              {
+                                "field": "ost_status",
+                                "version_id": 0,
+                                "field_exists": false,
+                                "size": 4
+                              }
+                            ]
+                          }
+                        }
+                      ]
+                    }
+                  }
+                ]
+              },
+              {
+                "name": "ich9_pm/pcihp",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "acpi_pci_hotplug.hotplug_select",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 4
+                  },
+                  {
+                    "field": "acpi_pci_hotplug.acpi_pcihp_pci_status",
+                    "version_id": 1,
+                    "field_exists": false,
+                    "size": 12,
+                    "Description": {
+                      "name": "acpi_pcihp_pci_status",
+                      "version_id": 1,
+                      "minimum_version_id": 1,
+                      "Fields": [
+                        {
+                          "field": "up",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 4
+                        },
+                        {
+                          "field": "down",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 4
+                        }
+                      ]
+                    }
+                  },
+                  {
+                    "field": "acpi_pci_hotplug.acpi_index",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 4
+                  }
+                ]
+              }
+            ]
+          }
+        },
+        {
+          "field": "chip_config",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "sci_level",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "ICH9LPC/rst_cnt",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "rst_cnt",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 1
+            }
+          ]
+        },
+        {
+          "name": "ICH9LPC/smi_feat",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "smi_guest_features_le",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 1
+            },
+            {
+              "field": "smi_features_ok",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 1
+            },
+            {
+              "field": "smi_negotiated_features",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "pit-common": {
+    "Name": "pit-common",
+    "version_id": 3,
+    "minimum_version_id": 2,
+    "Description": {
+      "name": "i8254",
+      "version_id": 3,
+      "minimum_version_id": 2,
+      "Fields": [
+        {
+          "field": "channels[0].irq_disabled",
+          "version_id": 3,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "channels",
+          "version_id": 2,
+          "field_exists": false,
+          "size": 56,
+          "Description": {
+            "name": "pit channel",
+            "version_id": 2,
+            "minimum_version_id": 2,
+            "Fields": [
+              {
+                "field": "count",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "latched_count",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 2
+              },
+              {
+                "field": "count_latched",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "status_latched",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "status",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "read_state",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "write_state",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "write_latch",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "rw_mode",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "mode",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "bcd",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "gate",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "count_load_time",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              },
+              {
+                "field": "next_transition_time",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              }
+            ]
+          }
+        },
+        {
+          "field": "channels[0].next_transition_time",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        }
+      ]
+    }
+  },
+  "vmgenid": {
+    "Name": "vmgenid",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "vmgenid",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "vmgenid_addr_le",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        }
+      ]
+    }
+  },
+  "ioapic-common": {
+    "Name": "ioapic-common",
+    "version_id": 3,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "ioapic",
+      "version_id": 3,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "id",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "ioregsel",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "unused",
+          "version_id": 2,
+          "field_exists": false,
+          "size": 8
+        },
+        {
+          "field": "irr",
+          "version_id": 2,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "ioredtbl",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        }
+      ]
+    }
+  },
+  "isa-i8259": {
+    "Name": "isa-i8259",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "i8259",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "last_irr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "irr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "imr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "isr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "priority_add",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "irq_base",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "read_reg_select",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "poll",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "special_mask",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "init_state",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "auto_eoi",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "rotate_on_auto_eoi",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "special_fully_nested_mode",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "init4",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "single_mode",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "elcr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        }
+      ]
+    }
+  },
+  "cfi.pflash01": {
+    "Name": "cfi.pflash01",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "pflash_cfi01",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "wcycle",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "cmd",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "status",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "counter",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "pflash_cfi01_blk_write",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "blk_bytes",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 0
+            },
+            {
+              "field": "blk_offset",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "i8042-mmio": {
+    "Name": "i8042-mmio",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "pckbd-mmio",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "kbd",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2328,
+          "Description": {
+            "name": "pckbd",
+            "version_id": 3,
+            "minimum_version_id": 3,
+            "Fields": [
+              {
+                "field": "write_cmd",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "status",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "mode",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "pending_tmp",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              }
+            ],
+            "Subsections": [
+              {
+                "name": "pckbd_outport",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "outport",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 1
+                  }
+                ]
+              },
+              {
+                "name": "pckbd/extended_state",
+                "version_id": 0,
+                "minimum_version_id": 0,
+                "Fields": [
+                  {
+                    "field": "migration_flags",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 4
+                  },
+                  {
+                    "field": "obsrc",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 4
+                  },
+                  {
+                    "field": "obdata",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 1
+                  },
+                  {
+                    "field": "cbdata",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 1
+                  }
+                ]
+              }
+            ]
+          }
+        }
+      ]
+    }
+  },
+  "isa-serial": {
+    "Name": "isa-serial",
+    "version_id": 3,
+    "minimum_version_id": 2,
+    "Description": {
+      "name": "serial",
+      "version_id": 3,
+      "minimum_version_id": 2,
+      "Fields": [
+        {
+          "field": "state",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 656,
+          "Description": {
+            "name": "serial",
+            "version_id": 3,
+            "minimum_version_id": 2,
+            "Fields": [
+              {
+                "field": "divider",
+                "version_id": 2,
+                "field_exists": false,
+                "size": 2
+              },
+              {
+                "field": "rbr",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "ier",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "iir",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "lcr",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "mcr",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "lsr",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "msr",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "scr",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "fcr_vmstate",
+                "version_id": 3,
+                "field_exists": false,
+                "size": 1
+              }
+            ],
+            "Subsections": [
+              {
+                "name": "serial/thr_ipending",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "thr_ipending",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 4
+                  }
+                ]
+              },
+              {
+                "name": "serial/tsr",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "tsr_retry",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 4
+                  },
+                  {
+                    "field": "thr",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 1
+                  },
+                  {
+                    "field": "tsr",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 1
+                  }
+                ]
+              },
+              {
+                "name": "serial/recv_fifo",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "recv_fifo",
+                    "version_id": 1,
+                    "field_exists": false,
+                    "size": 24,
+                    "Description": {
+                      "name": "Fifo8",
+                      "version_id": 1,
+                      "minimum_version_id": 1,
+                      "Fields": [
+                        {
+                          "field": "data",
+                          "version_id": 1,
+                          "field_exists": false,
+                          "size": 0
+                        },
+                        {
+                          "field": "head",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 4
+                        },
+                        {
+                          "field": "num",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 4
+                        }
+                      ]
+                    }
+                  }
+                ]
+              },
+              {
+                "name": "serial/xmit_fifo",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "xmit_fifo",
+                    "version_id": 1,
+                    "field_exists": false,
+                    "size": 24,
+                    "Description": {
+                      "name": "Fifo8",
+                      "version_id": 1,
+                      "minimum_version_id": 1,
+                      "Fields": [
+                        {
+                          "field": "data",
+                          "version_id": 1,
+                          "field_exists": false,
+                          "size": 0
+                        },
+                        {
+                          "field": "head",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 4
+                        },
+                        {
+                          "field": "num",
+                          "version_id": 0,
+                          "field_exists": false,
+                          "size": 4
+                        }
+                      ]
+                    }
+                  }
+                ]
+              },
+              {
+                "name": "serial/fifo_timeout_timer",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "fifo_timeout_timer",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 8
+                  }
+                ]
+              },
+              {
+                "name": "serial/timeout_ipending",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "timeout_ipending",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 4
+                  }
+                ]
+              },
+              {
+                "name": "serial/poll",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "poll_msl",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 4
+                  },
+                  {
+                    "field": "modem_status_poll",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 8
+                  }
+                ]
+              }
+            ]
+          }
+        }
+      ]
+    }
+  },
+  "ps2-mouse": {
+    "Name": "ps2-mouse",
+    "version_id": 2,
+    "minimum_version_id": 2,
+    "Description": {
+      "name": "ps2mouse",
+      "version_id": 2,
+      "minimum_version_id": 2,
+      "Fields": [
+        {
+          "field": "parent_obj",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1104,
+          "Description": {
+            "name": "PS2 Common State",
+            "version_id": 3,
+            "minimum_version_id": 2,
+            "Fields": [
+              {
+                "field": "write_cmd",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "queue.rptr",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "queue.wptr",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "queue.count",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "queue.data",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 256
+              }
+            ]
+          }
+        },
+        {
+          "field": "mouse_status",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "mouse_resolution",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "mouse_sample_rate",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "mouse_wrap",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "mouse_type",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "mouse_detect_state",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "mouse_dx",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "mouse_dy",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "mouse_dz",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "mouse_buttons",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        }
+      ]
+    }
+  },
+  "kvmvapic": {
+    "Name": "kvmvapic",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "kvm-tpr-opt",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "rom_state",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 124,
+          "Description": {
+            "name": "kvmvapic-guest-rom",
+            "version_id": 1,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "unused",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 8
+              },
+              {
+                "field": "vaddr",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "fixup_start",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "fixup_end",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "vapic_vaddr",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "vapic_size",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "vcpu_shift",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "real_tpr_addr",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "up",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 44,
+                "Description": {
+                  "name": "kvmvapic-handlers",
+                  "version_id": 1,
+                  "minimum_version_id": 1,
+                  "Fields": [
+                    {
+                      "field": "set_tpr",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 4
+                    },
+                    {
+                      "field": "set_tpr_eax",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 4
+                    },
+                    {
+                      "field": "get_tpr",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 4
+                    },
+                    {
+                      "field": "get_tpr_stack",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 4
+                    }
+                  ]
+                }
+              },
+              {
+                "field": "mp",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 44,
+                "Description": {
+                  "name": "kvmvapic-handlers",
+                  "version_id": 1,
+                  "minimum_version_id": 1,
+                  "Fields": [
+                    {
+                      "field": "set_tpr",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 4
+                    },
+                    {
+                      "field": "set_tpr_eax",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 4
+                    },
+                    {
+                      "field": "get_tpr",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 4
+                    },
+                    {
+                      "field": "get_tpr_stack",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 4
+                    }
+                  ]
+                }
+              }
+            ]
+          }
+        },
+        {
+          "field": "state",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "real_tpr_addr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "rom_state_vaddr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "vapic_paddr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "rom_state_paddr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ]
+    }
+  },
+  "ich9-ahci": {
+    "Name": "ich9-ahci",
+    "version_id": 1,
+    "minimum_version_id": 0,
+    "Description": {
+      "name": "ich9_ahci",
+      "version_id": 1,
+      "minimum_version_id": 0,
+      "Fields": [
+        {
+          "field": "parent_obj",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2608,
+          "Description": {
+            "name": "PCIDevice",
+            "version_id": 2,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "version_id",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "config",
+                "version_id": 0,
+                "field_exists": true,
+                "size": 256
+              },
+              {
+                "field": "config",
+                "version_id": 0,
+                "field_exists": true,
+                "size": 4096
+              },
+              {
+                "field": "irq_state",
+                "version_id": 2,
+                "field_exists": false,
+                "size": 16
+              }
+            ]
+          }
+        },
+        {
+          "field": "ahci",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 624,
+          "Description": {
+            "name": "ahci",
+            "version_id": 1,
+            "minimum_version_id": 0,
+            "Fields": [
+              {
+                "field": "dev",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 6088,
+                "Description": {
+                  "name": "ahci port",
+                  "version_id": 1,
+                  "minimum_version_id": 0,
+                  "Fields": [
+                    {
+                      "field": "port",
+                      "version_id": 1,
+                      "field_exists": false,
+                      "size": 2304,
+                      "Description": {
+                        "name": "ide_bus",
+                        "version_id": 1,
+                        "minimum_version_id": 1,
+                        "Fields": [
+                          {
+                            "field": "cmd",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 1
+                          },
+                          {
+                            "field": "unit",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 1
+                          }
+                        ],
+                        "Subsections": [
+                          {
+                            "name": "ide_bus/error",
+                            "version_id": 2,
+                            "minimum_version_id": 1,
+                            "Fields": [
+                              {
+                                "field": "error_status",
+                                "version_id": 0,
+                                "field_exists": false,
+                                "size": 4
+                              },
+                              {
+                                "field": "retry_sector_num",
+                                "version_id": 2,
+                                "field_exists": false,
+                                "size": 8
+                              },
+                              {
+                                "field": "retry_nsector",
+                                "version_id": 2,
+                                "field_exists": false,
+                                "size": 4
+                              },
+                              {
+                                "field": "retry_unit",
+                                "version_id": 2,
+                                "field_exists": false,
+                                "size": 1
+                              }
+                            ]
+                          }
+                        ]
+                      }
+                    },
+                    {
+                      "field": "port.ifs[0]",
+                      "version_id": 1,
+                      "field_exists": false,
+                      "size": 984,
+                      "Description": {
+                        "name": "ide_drive",
+                        "version_id": 3,
+                        "minimum_version_id": 0,
+                        "Fields": [
+                          {
+                            "field": "mult_sectors",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 4
+                          },
+                          {
+                            "field": "identify_set",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 4
+                          },
+                          {
+                            "field": "identify_data",
+                            "version_id": 0,
+                            "field_exists": true,
+                            "size": 512
+                          },
+                          {
+                            "field": "feature",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 1
+                          },
+                          {
+                            "field": "error",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 1
+                          },
+                          {
+                            "field": "nsector",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 4
+                          },
+                          {
+                            "field": "sector",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 1
+                          },
+                          {
+                            "field": "lcyl",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 1
+                          },
+                          {
+                            "field": "hcyl",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 1
+                          },
+                          {
+                            "field": "hob_feature",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 1
+                          },
+                          {
+                            "field": "hob_sector",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 1
+                          },
+                          {
+                            "field": "hob_nsector",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 1
+                          },
+                          {
+                            "field": "hob_lcyl",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 1
+                          },
+                          {
+                            "field": "hob_hcyl",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 1
+                          },
+                          {
+                            "field": "select",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 1
+                          },
+                          {
+                            "field": "status",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 1
+                          },
+                          {
+                            "field": "lba48",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 1
+                          },
+                          {
+                            "field": "sense_key",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 1
+                          },
+                          {
+                            "field": "asc",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 1
+                          },
+                          {
+                            "field": "cdrom_changed",
+                            "version_id": 3,
+                            "field_exists": false,
+                            "size": 1
+                          }
+                        ],
+                        "Subsections": [
+                          {
+                            "name": "ide_drive/pio_state",
+                            "version_id": 1,
+                            "minimum_version_id": 1,
+                            "Fields": [
+                              {
+                                "field": "req_nb_sectors",
+                                "version_id": 0,
+                                "field_exists": false,
+                                "size": 4
+                              },
+                              {
+                                "field": "io_buffer",
+                                "version_id": 1,
+                                "field_exists": false,
+                                "size": 1
+                              },
+                              {
+                                "field": "cur_io_buffer_offset",
+                                "version_id": 0,
+                                "field_exists": false,
+                                "size": 4
+                              },
+                              {
+                                "field": "cur_io_buffer_len",
+                                "version_id": 0,
+                                "field_exists": false,
+                                "size": 4
+                              },
+                              {
+                                "field": "end_transfer_fn_idx",
+                                "version_id": 0,
+                                "field_exists": false,
+                                "size": 1
+                              },
+                              {
+                                "field": "elementary_transfer_size",
+                                "version_id": 0,
+                                "field_exists": false,
+                                "size": 4
+                              },
+                              {
+                                "field": "packet_transfer_size",
+                                "version_id": 0,
+                                "field_exists": false,
+                                "size": 4
+                              }
+                            ]
+                          },
+                          {
+                            "name": "ide_drive/tray_state",
+                            "version_id": 1,
+                            "minimum_version_id": 1,
+                            "Fields": [
+                              {
+                                "field": "tray_open",
+                                "version_id": 0,
+                                "field_exists": false,
+                                "size": 1
+                              },
+                              {
+                                "field": "tray_locked",
+                                "version_id": 0,
+                                "field_exists": false,
+                                "size": 1
+                              }
+                            ]
+                          },
+                          {
+                            "name": "ide_drive/atapi/gesn_state",
+                            "version_id": 1,
+                            "minimum_version_id": 1,
+                            "Fields": [
+                              {
+                                "field": "events.new_media",
+                                "version_id": 0,
+                                "field_exists": false,
+                                "size": 1
+                              },
+                              {
+                                "field": "events.eject_request",
+                                "version_id": 0,
+                                "field_exists": false,
+                                "size": 1
+                              }
+                            ]
+                          }
+                        ]
+                      }
+                    },
+                    {
+                      "field": "port_state",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 4
+                    },
+                    {
+                      "field": "finished",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 4
+                    },
+                    {
+                      "field": "port_regs.lst_addr",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 4
+                    },
+                    {
+                      "field": "port_regs.lst_addr_hi",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 4
+                    },
+                    {
+                      "field": "port_regs.fis_addr",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 4
+                    },
+                    {
+                      "field": "port_regs.fis_addr_hi",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 4
+                    },
+                    {
+                      "field": "port_regs.irq_stat",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 4
+                    },
+                    {
+                      "field": "port_regs.irq_mask",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 4
+                    },
+                    {
+                      "field": "port_regs.cmd",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 4
+                    },
+                    {
+                      "field": "port_regs.tfdata",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 4
+                    },
+                    {
+                      "field": "port_regs.sig",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 4
+                    },
+                    {
+                      "field": "port_regs.scr_stat",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 4
+                    },
+                    {
+                      "field": "port_regs.scr_ctl",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 4
+                    },
+                    {
+                      "field": "port_regs.scr_err",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 4
+                    },
+                    {
+                      "field": "port_regs.scr_act",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 4
+                    },
+                    {
+                      "field": "port_regs.cmd_issue",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 4
+                    },
+                    {
+                      "field": "done_first_drq",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 1
+                    },
+                    {
+                      "field": "busy_slot",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 4
+                    },
+                    {
+                      "field": "init_d2h_sent",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 1
+                    },
+                    {
+                      "field": "ncq_tfs",
+                      "version_id": 1,
+                      "field_exists": false,
+                      "size": 112,
+                      "Description": {
+                        "name": "ncq state",
+                        "version_id": 1,
+                        "minimum_version_id": 0,
+                        "Fields": [
+                          {
+                            "field": "sector_count",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 4
+                          },
+                          {
+                            "field": "lba",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 8
+                          },
+                          {
+                            "field": "tag",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 1
+                          },
+                          {
+                            "field": "cmd",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 1
+                          },
+                          {
+                            "field": "slot",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 1
+                          },
+                          {
+                            "field": "used",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 1
+                          },
+                          {
+                            "field": "halt",
+                            "version_id": 0,
+                            "field_exists": false,
+                            "size": 1
+                          }
+                        ]
+                      }
+                    }
+                  ]
+                }
+              },
+              {
+                "field": "control_regs.cap",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "control_regs.ghc",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "control_regs.irqstatus",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "control_regs.impl",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "control_regs.version",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "idp_index",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "ports",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              }
+            ]
+          }
+        }
+      ]
+    }
+  },
+  "i8042": {
+    "Name": "i8042",
+    "version_id": 3,
+    "minimum_version_id": 3,
+    "Description": {
+      "name": "pckbd",
+      "version_id": 3,
+      "minimum_version_id": 3,
+      "Fields": [
+        {
+          "field": "kbd",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2328,
+          "Description": {
+            "name": "pckbd",
+            "version_id": 3,
+            "minimum_version_id": 3,
+            "Fields": [
+              {
+                "field": "write_cmd",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "status",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "mode",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "pending_tmp",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              }
+            ],
+            "Subsections": [
+              {
+                "name": "pckbd_outport",
+                "version_id": 1,
+                "minimum_version_id": 1,
+                "Fields": [
+                  {
+                    "field": "outport",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 1
+                  }
+                ]
+              },
+              {
+                "name": "pckbd/extended_state",
+                "version_id": 0,
+                "minimum_version_id": 0,
+                "Fields": [
+                  {
+                    "field": "migration_flags",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 4
+                  },
+                  {
+                    "field": "obsrc",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 4
+                  },
+                  {
+                    "field": "obdata",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 1
+                  },
+                  {
+                    "field": "cbdata",
+                    "version_id": 0,
+                    "field_exists": false,
+                    "size": 1
+                  }
+                ]
+              }
+            ]
+          }
+        }
+      ]
+    }
+  },
+  "fw_cfg_io": {
+    "Name": "fw_cfg_io",
+    "version_id": 2,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "fw_cfg",
+      "version_id": 2,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "cur_entry",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 0,
+          "field_exists": true,
+          "size": 4
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 2,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "fw_cfg/dma",
+          "version_id": 0,
+          "minimum_version_id": 0,
+          "Fields": [
+            {
+              "field": "dma_addr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        },
+        {
+          "name": "fw_cfg/acpi_mr",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "table_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "linker_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "rsdp_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "vmcoreinfo": {
+    "Name": "vmcoreinfo",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "vmcoreinfo",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "has_vmcoreinfo",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "vmcoreinfo.host_format",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2
+        },
+        {
+          "field": "vmcoreinfo.guest_format",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2
+        },
+        {
+          "field": "vmcoreinfo.size",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "vmcoreinfo.paddr",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        }
+      ]
+    }
+  },
+  "ps2-kbd": {
+    "Name": "ps2-kbd",
+    "version_id": 3,
+    "minimum_version_id": 2,
+    "Description": {
+      "name": "ps2kbd",
+      "version_id": 3,
+      "minimum_version_id": 2,
+      "Fields": [
+        {
+          "field": "parent_obj",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1104,
+          "Description": {
+            "name": "PS2 Common State",
+            "version_id": 3,
+            "minimum_version_id": 2,
+            "Fields": [
+              {
+                "field": "write_cmd",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "queue.rptr",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "queue.wptr",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "queue.count",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "queue.data",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 256
+              }
+            ]
+          }
+        },
+        {
+          "field": "scan_enabled",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "translate",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "scancode_set",
+          "version_id": 3,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "ps2kbd/ledstate",
+          "version_id": 3,
+          "minimum_version_id": 2,
+          "Fields": [
+            {
+              "field": "ledstate",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        },
+        {
+          "name": "ps2kbd/need_high_bit",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "need_high_bit",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 1
+            }
+          ]
+        },
+        {
+          "name": "ps2kbd/command_reply_queue",
+          "version_id": 0,
+          "minimum_version_id": 0,
+          "Fields": [
+            {
+              "field": "parent_obj.queue.cwptr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 4
+            }
+          ]
+        }
+      ]
+    }
+  },
+  "ICH9-SMB": {
+    "Name": "ICH9-SMB",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "ich9_smb",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "dev",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2608,
+          "Description": {
+            "name": "PCIDevice",
+            "version_id": 2,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "version_id",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "config",
+                "version_id": 0,
+                "field_exists": true,
+                "size": 256
+              },
+              {
+                "field": "config",
+                "version_id": 0,
+                "field_exists": true,
+                "size": 4096
+              },
+              {
+                "field": "irq_state",
+                "version_id": 2,
+                "field_exists": false,
+                "size": 16
+              }
+            ]
+          }
+        },
+        {
+          "field": "irq_enabled",
+          "version_id": 0,
+          "field_exists": true,
+          "size": 1
+        },
+        {
+          "field": "smb",
+          "version_id": 1,
+          "field_exists": true,
+          "size": 384,
+          "Description": {
+            "name": "pmsmb",
+            "version_id": 1,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "smb_stat",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "smb_ctl",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "smb_cmd",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "smb_addr",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "smb_data0",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "smb_data1",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "smb_index",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "smb_data",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "smb_auxctl",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "smb_blkdata",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "i2c_enable",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "op_done",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "in_i2c_block_read",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "start_transaction_on_status_read",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              }
+            ]
+          }
+        }
+      ]
+    }
+  },
+  "isa-pcspk": {
+    "Name": "isa-pcspk",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "pcspk",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "data_on",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "dummy_refresh_clock",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        }
+      ]
+    }
+  },
+  "acpi-erst": {
+    "Name": "acpi-erst",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "acpi-erst",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "operation",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "busy_status",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "command_status",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "record_offset",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "reg_action",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        },
+        {
+          "field": "reg_value",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        },
+        {
+          "field": "record_identifier",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        },
+        {
+          "field": "next_record_index",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ]
+    }
+  },
+  "i8257": {
+    "Name": "i8257",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "dma",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "command",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "mask",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "flip_flop",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "dshift",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "regs",
+          "version_id": 1,
+          "field_exists": false,
+          "size": 40,
+          "Description": {
+            "name": "dma_regs",
+            "version_id": 1,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "now",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "base",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 2
+              },
+              {
+                "field": "mode",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "page",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "pageh",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "dack",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              },
+              {
+                "field": "eop",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              }
+            ]
+          }
+        }
+      ]
+    }
+  },
+  "port92": {
+    "Name": "port92",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "port92",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "outport",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        }
+      ]
+    }
+  },
+  "q35-pcihost": {
+    "Name": "q35-pcihost",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "PCIHost",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "config_reg",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ]
+    }
+  },
+  "ioapic": {
+    "Name": "ioapic",
+    "version_id": 3,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "ioapic",
+      "version_id": 3,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "id",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "ioregsel",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "unused",
+          "version_id": 2,
+          "field_exists": false,
+          "size": 8
+        },
+        {
+          "field": "irr",
+          "version_id": 2,
+          "field_exists": false,
+          "size": 4
+        },
+        {
+          "field": "ioredtbl",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 8
+        }
+      ]
+    }
+  },
+  "smbus-eeprom": {
+    "Name": "smbus-eeprom",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "smbus-eeprom",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "smbusdev",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 216,
+          "Description": {
+            "name": "smbus-device",
+            "version_id": 1,
+            "minimum_version_id": 1,
+            "Fields": [
+              {
+                "field": "i2c",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 168,
+                "Description": {
+                  "name": "I2CSlave",
+                  "version_id": 1,
+                  "minimum_version_id": 1,
+                  "Fields": [
+                    {
+                      "field": "address",
+                      "version_id": 0,
+                      "field_exists": false,
+                      "size": 1
+                    }
+                  ]
+                }
+              },
+              {
+                "field": "mode",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "data_len",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 4
+              },
+              {
+                "field": "data_buf",
+                "version_id": 0,
+                "field_exists": false,
+                "size": 1
+              }
+            ]
+          }
+        },
+        {
+          "field": "data",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "offset",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        },
+        {
+          "field": "accessed",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 1
+        }
+      ]
+    }
+  },
+  "pci-host-bridge": {
+    "Name": "pci-host-bridge",
+    "version_id": 1,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "PCIHost",
+      "version_id": 1,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "config_reg",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 4
+        }
+      ]
+    }
+  },
+  "fw_cfg_mem": {
+    "Name": "fw_cfg_mem",
+    "version_id": 2,
+    "minimum_version_id": 1,
+    "Description": {
+      "name": "fw_cfg",
+      "version_id": 2,
+      "minimum_version_id": 1,
+      "Fields": [
+        {
+          "field": "cur_entry",
+          "version_id": 0,
+          "field_exists": false,
+          "size": 2
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 0,
+          "field_exists": true,
+          "size": 4
+        },
+        {
+          "field": "cur_offset",
+          "version_id": 2,
+          "field_exists": false,
+          "size": 4
+        }
+      ],
+      "Subsections": [
+        {
+          "name": "fw_cfg/dma",
+          "version_id": 0,
+          "minimum_version_id": 0,
+          "Fields": [
+            {
+              "field": "dma_addr",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        },
+        {
+          "name": "fw_cfg/acpi_mr",
+          "version_id": 1,
+          "minimum_version_id": 1,
+          "Fields": [
+            {
+              "field": "table_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "linker_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            },
+            {
+              "field": "rsdp_mr_size",
+              "version_id": 0,
+              "field_exists": false,
+              "size": 8
+            }
+          ]
+        }
+      ]
+    }
+  }
+}
-- 
2.51.0


