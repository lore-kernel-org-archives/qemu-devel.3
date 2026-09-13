Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902E4C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 03:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5asY-0003ph-0G; Sat, 12 Sep 2026 23:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1x5asW-0003pT-0r
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 23:27:40 -0400
Received: from sonic301-20.consmr.mail.gq1.yahoo.com ([98.137.64.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1x5asT-00061l-QN
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 23:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1789270054; bh=Hevw5B+Wr7DTBK/0kWmrMKgRnH/bAgiz5/Fykn/Eyuo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=uY2lp5G1atnaUMVr0UscmeYJdwP0iwLvqcIb5ek5Yx7Jk04f2MuLHly8JbL038h+Dz5j6g00HJB53lMFolBUFiKDhenuE7OiftMW4oGSWCLXAz/rgz7srt4ORRoMNHPi0ZyUYUHbULJ5saf9Vmel1wTVrZqa12gn3FCD82QDCTz5cfPK8ItEOP60DItPbd6AUkxKy6VEn3phhH2oZiyDtcc7yvFT+duXFP5c7u7QuWVdHnTVaBpvidn4Jrmd2ksOS/OPudnFvgKG5IR4TkWbz+t8alo65i/KFbd0p3VcgElxW/LJNaHDOlJ68pMhM9HaNhMVtgb0IbEKtRsAyanuAQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1789270054; bh=L/S97QuLM5PBrc49OcJhPUSRtUyjGcV/+NyI/8Pj037=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=UFQlu9zugYRcYYk+bet5IhgBoCs09GbijWWiC0cZ6E4Sa9RvGmLfeVf0VGi4FEOq4hhKDCRB7wyiPNeE4uNy3FpOKw0sCO1YxrKHRv2cI3YV6cQWjaKbhEc9OVuJE+WYVkDwe+ddLqhCb2dF8kreSccF+saeBDml0OOnhX/SrUhDjd7nUGmZCeYpNx/7nDa+cqOXgdS6bz8yKG1tXmzxkmXhOy5NmD/+bPhVP6NV3rE/8ztPXeC28PY005Mc/HelGrHw7+dLLFrfWygeyptEofMfbo8+R47yId1S8Fj2xA3T1e/R/lMBz46PbOLt4UzgwmHiym0Q5nTOtru6DLahtw==
X-YMail-OSG: MABzF34VM1kLtJmAr1eV5IlNnii6cA6572ltl2Ut9a2FKZEgqP8dpOG53E35F9Q
 MMEkiElQEqUu3q9MJtkEUHjtnWQGqJXvzvWvnnhuyXVfbrX0CWnnmJeGgTU3W48tLC2Z5X8S8xwB
 wGiEsHHWI3zf0txp_8LyQB52YzEjUFuGqIq7DWtsmYzm7DKGcpYT8jqd223hI3sjQcx5Qa9krlIL
 diwlzVjPA3_uB.lDeyGeeG8NTRCATq.YYg7OtOr01JR1I13zeW.5wdAIpF79ssQKbIQ1Gj0ylNtN
 hF4tsLDZtSr4HjNOTuD6x93jdODa3YUpCS9QuURhjELyJw8T9YXnwyfIM.CrKtCrqazvPx.d6lhE
 SOoUBFuA80Uy4YAKxqFvM1hadL1XahH1My_bHZ4QVfYCrgaAoX0YaR_7rpMV76tPjs4_z9LvHwWC
 reRq54QDMluMPyQUUO4GFzEpCS3G7VVZNlJvJt8AcjsR9U1sLZZJ0qdR1t9HfGSRJOddPTXlX0Ts
 LEVKkb8ZoQqg0HjU_F3SuV.xHs2nC8W.TVgGQMGEHpV.6.0CDJxOH1kDfM5VIKbEzpiYrUuuSYkU
 ydUVqIzlrUcw9gXtAUFrDdTl9G6JQ_5U0b4MDQYm32K98Ub5GGk9kJy0wkV2udEO8QjpCT1DhTqR
 8sU0L7AvFTu.SpydNBvHhVeDJFQDAoharDvTz8dQmJI5ha1j0Ay8PsXB00y82mjAglPsXEZ4oPjD
 SJRVM7MFYtlpths95YmXGJYMGHw78PPsBKxvfUYJnvzx8u3hYRqK4UjLwWz1caWG1DRSdDtVkNNQ
 .7Km9kc43nQcFKm2ToSTaaKaAMuu7N8ThN14KUHv2r37BEtXJHbG.vyClLPoyMhLfyARdkC9A7WZ
 2rxniiviN8w_P7WSrQxZyglyNIKqIByvI4lptHSLCmF_miPu27BEQNcNYyDPyqhMGtHCmBSy.dsM
 gecEXRynxPBOAlCTKeQLQ3A6RM8_TLq4yb7CzLzqoB3IlZFWbCa7kR7r6OYLiFR7Dt8K8fO9yyRl
 czxC0t06WLjcjuJK_uZbBTcFRjUWEIwyGKVfBDHUomVCyyGG1eY4nllRLbIMkz2ECuT2sAEl8l3j
 5UoZ17yWD4CRB0RLXDljPBroJKW3AOD2yhzfcxdX2Ak89evT3sdeXzCTWhtT1e8PcZmw7n2wDHz_
 0Sgn7Uu4bWSAdwpALaFqBEyD9BFFfQzfXsNulmf1QqyqKcpR1SIpxr3HyPL0D.ZqAFWC0AVX0jm.
 AVvvCwQtN7briAtzjGJ_CNL8qrZZz.OZh.q3EjYedFjFfY_Mq7jHn8DHWqIQM1v_kzl_NSAxn_H0
 cjyqFy98NgcCDhd9_3r86H6NSkt6g9j2OZ3aX8j_x.MwGbAGD_qHiJnHH4ToQMJdTZgItsRddjm9
 j_g0Y7fttDMw8PlYJMNw4SlPemyURDpQGUUY2YWTyDjQFqk9b8zbMcSv6WE_P5AtOsZjRy_aFWB3
 UbRceVrRb6MpxiN6JBp3GQACgBE9Hh6l52osbv1ybWa2VXEqfsUr2AS6aWJfUWE4RAm5VIru49Xa
 prVQjhXynxxi1c3K2Nd1fOzbEgJrHPSxCaGC2KJ.yrtUtmVogp_CXA8L475NMxZ4lNxrkKnZiWVA
 Rx_i56tvlWWmzvTRBB61k1FPgjnd2pqcVAmx5ypcds2bLaB4puHzS6_St2joQ2Cc5mnkoJtTL4p0
 5tkOzdFr3Tv1.efS8bxZAmiW1L.K0ZQIdbFmg3R2RBU4GyZsczCsEMJssfHoq5KbfIEB6UpocOmt
 SWOP38VFcWk3._iVmVFv9X7UF.edlDzXbwNOZ0Ed6Igk5HoSPTkrNu4ARCFGS5PtKsfXWwFuYVJR
 3LCAzeqg3FtCJGzu.ymwnpxwqtS.88ksc152oaa99FT5K5k0n9FAJB_ORVYbYJukgjjaxTPaAXES
 Opk0xGvy3SjlKpZ0_mPDqij3SjJkTqgvBQ.v3oLXtr4XFHVIu18mdOCYLcb0bj6pH8kae8Zti1wb
 WFxJaYpUB2ztgxGxoXpllYRp5GmcvgBc3tTBFWGMKbRw_GaHxR89xb5NWXtInszNSwR0NYHOxi8o
 b4rs5n5Oc.zlbbBasnOhvphFbVK9.A6YN_fZF4Zgu.1gsFN.f6EVRseumFdKgN2R.yh6iM6.pD5o
 znmoIKD96PiOmj6L9lebFHVejVFSSG10uLMZBp7tm.9ZQgRxgJ3WzZ3o88_.kXzbeBZAlhVLY_Tq
 D..zwK7DEpCKjGU..8rRyQAP2P8fAQ14GJ9M-
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 25657ca0-4f28-40f3-9cdb-11cc86d67d9e
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.gq1.yahoo.com with HTTP; Sun, 13 Sep 2026 03:27:34 +0000
Received: by hermes--production-ne1-6dbcb84f44-w9zrq (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 14c5b846713c82b711c43225786a63a7; 
 Sun, 13 Sep 2026 03:27:28 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: xen-devel@lists.xenproject.org
Cc: qemu-devel@nongnu.org, Anthony PERARD <anthony.perard@vates.tech>,
 Juergen Gross <jgross@suse.com>
Subject: [PATCH v4 2/2] libxl: add OpRegion and VBT to firmware when assigning
 IGD
Date: Sat, 12 Sep 2026 23:27:24 -0400
Message-ID: <20260913032724.62438-3-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913032724.62438-1-brchuckz@aol.com>
References: <20260913032724.62438-1-brchuckz@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=98.137.64.146; envelope-from=brchuckz@aol.com;
 helo=sonic301-20.consmr.mail.gq1.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

To provide support for newer IGD devices with an extended video bios table
(VBT), the device model needs to access the host OpRegion and VBT when the
IGD is bound to the xen-pciback driver but the Linux kernel only exposes
them in the debugfs when the IGD is bound to the i915 driver. Although the
OpRegion and VBT can be manually copied to a firmware directory from the
debugfs to a directory where the device model can access them when the IGD
is bound to the xen-pciback driver, libxl can do this automatically by
copying the OpRegion and VBT from the Linux debugfs to the Xen firmware
directory before unbinding the IGD from the i915 driver. Since the copying
of the OpRegion and VBT are not required for the device to be made assignable,
don't return an error if the only error is that the attempt to copy the
OpRegion and/or the VBT to the Xen firmware directory failed.

It is necessary to read the RVDS field of the OpRegion which stores the
size of the extended VBT. We cannot rely on stat(2) for this which returns
a value of 0 for the size of files stored in the Linux debugfs. This patch
relies on lstat(2) only to determine if the OpRegion and VBT files already
exist in the Xen firmware directory. If the value stored in the RVDS field
is 0, then there is no extended VBT and the VBT is embedded within mailbox
# 4 of the OpRegion, in which case we can assume the size of the VBT is 6
KiB.

For users of the Qemu device model, if the Xen firmware directory is not
configured as one of the Qemu firmware directories, the "intel-opregion"
and "intel-vbt" files must be moved or copied to a Qemu firmware directory
to provide proper support for an IGD with an extended VBT that is passed
through to a Xen HVM guest.

Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
---
This patch also depends on the companion patch for the Qemu device model
available here:

https://lore.kernel.org/qemu-devel/20260911072453.46256-7-brchuckz@aol.com/

There is not an up-to-date specification for the OpRegion and VBT available
to the public online but an older version is available here:

https://www.intel.com/content/www/us/en/docs/graphics-for-linux/developer-reference/1-0/opregion-specification.html

Despite the fact that we do not have an up-to-date specification, patches
to the Linux kernel i915 driver and the igd-related files of the Linux kernel
vfio driver provide enough information about the specification to provide
support for the Intel IGD in Xen HVM guests. These patches to the Linux
kernel vfio driver were particularly helpful for this series of patches to
fix support for IGD passthrough for Xen HVM guests:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/vfio/pci/vfio_pci_igd.c?id=bab2c1990b78
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/vfio/pci/vfio_pci_igd.c?id=49ba1a2976c8

Many more details about the support for Intel IGD passthrough to Xen guests
is available in the other patch in this series and the 7 patches of the
companion patch series for the device model. Please refer to those patches
before asking questions that might be answered by reading through those
other patches.

Changes in v4:
  - This is the first version of this series of IGD fixes with this patch

 tools/libs/light/libxl_pci.c | 82 ++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tools/libs/light/libxl_pci.c b/tools/libs/light/libxl_pci.c
index 49d272d..ff28387 100644
--- a/tools/libs/light/libxl_pci.c
+++ b/tools/libs/light/libxl_pci.c
@@ -25,6 +25,9 @@
 #define PCI_OPTIONS            "msitranslate=%d,power_mgmt=%d"
 #define PCI_BDF_XSPATH         "%04x-%02x-%02x-%01x"
 #define PCI_PT_QDEV_ID         "pci-pt-%02x_%02x.%01x"
+#define PCI_OPREGION_SIZE      0x2000
+#define PCI_OPREGION_RVDS      0x3c2 /* offset of RVDS in OpRegion */
+#define PCI_VBT_MBOX4_SIZE     0x1800
 
 /* PCI Interrupt Line is an 8-bit value, 0xff means disconnected. */
 #define PCI_IRQ_LINE_LIMIT     0xff
@@ -765,6 +768,17 @@ static int libxl__device_pci_assignable_add(libxl__gc *gc,
     const char *name;
     int rc;
     struct stat st;
+    uint32_t rvds = 0; /* Intel VBT size */
+    int fd = -1;
+    char *spath1 = NULL;
+    char *dpath1 = NULL;
+    char *spath2 = NULL;
+    char *dpath2 = NULL;
+    uint8_t *buf1 = NULL;
+    uint8_t *buf2 = NULL;
+    uint16_t pt_vendor = 0xffff;
+    uint16_t pt_device = 0xffff;
+    unsigned long class = 0;
 
     /* Local copy for convenience */
     dom = pci->domain;
@@ -797,6 +811,74 @@ static int libxl__device_pci_assignable_add(libxl__gc *gc,
         return ERROR_FAIL;
     }
 
+    pt_vendor = sysfs_dev_get_vendor(gc, pci);
+    pt_device = sysfs_dev_get_device(gc, pci);
+
+    /* Check if the device is an Intel IGD */
+    if ( pt_vendor != 0x8086 || pt_device == 0xffff ||
+        sysfs_dev_get_class(gc, pci, &class) ||
+        (class != 0x030000 && class != 0x038000) )
+        goto skipigd;
+
+    /* These filenames match the filenames used in the device model */
+    dpath1 = libxl__abs_path(gc, "intel-opregion",
+                             libxl__xenfirmwaredir_path());
+    dpath2 = libxl__abs_path(gc, "intel-vbt",
+                             libxl__xenfirmwaredir_path());
+
+    /* Check if the OpRegion and VBT files are already present */
+    if ( !lstat(dpath1, &st) && !lstat(dpath2, &st) )
+        goto skipigd;
+
+    spath1 = GCSPRINTF("/sys/kernel/debug/dri/"PCI_BDF"/i915_opregion",
+                       dom, bus, dev, func);
+    spath2 = GCSPRINTF("/sys/kernel/debug/dri/"PCI_BDF"/i915_vbt",
+                       dom, bus, dev, func);
+
+    /*
+     * Try to copy the OpRegion and VBT while IGD is bound to i915 driver
+     * but don't return an error if one or both of the copies fail.
+     */
+    if ( !lstat(spath1, &st) && !lstat(spath2, &st) ) {
+        fd = open(spath1, O_RDONLY);
+        GCNEW_ARRAY(buf1, PCI_OPREGION_SIZE);
+        rc = libxl_read_exactly(ctx, fd, (void *)buf1, PCI_OPREGION_SIZE,
+                                spath1, NULL);
+        close(fd);
+        if ( !rc ) {
+            fd = open(dpath1, O_CREAT|O_WRONLY|O_TRUNC, 0644);
+            rc = libxl_write_exactly(ctx, fd, (void *)buf1,
+                                     PCI_OPREGION_SIZE, dpath1, NULL);
+            close(fd);
+            if ( !rc ) {
+                rvds = *(uint32_t *)(buf1 + PCI_OPREGION_RVDS);
+                if ( !rvds ) /* VBT is embedded in the OpRegion */
+                    rvds = PCI_VBT_MBOX4_SIZE;
+                fd = open(spath2, O_RDONLY);
+                GCNEW_ARRAY(buf2, rvds);
+                rc = libxl_read_exactly(ctx, fd, (void *)buf2, rvds,
+                                        spath2, NULL);
+                close(fd);
+                if ( !rc ) {
+                    fd = open(dpath2, O_CREAT|O_WRONLY|O_TRUNC, 0644);
+                    rc = libxl_write_exactly(ctx, fd, (void *)buf2,
+                                             rvds, dpath2, NULL);
+                    close(fd);
+                    if ( rc ) {
+                        LOG(INFO, "Failed to copy VBT");
+                    }
+                } else {
+                    LOG(INFO, "Failed to read VBT from debugfs");
+                }
+            } else {
+                LOG(INFO, "Failed to copy OpRegion");
+            }
+        } else {
+            LOG(INFO, "Failed to read OpRegion from debugfs");
+        }
+    }
+
+skipigd:
     /* Check to see if it's already assigned to pciback */
     rc = pciback_dev_is_assigned(gc, pci);
     if ( rc < 0 ) {
-- 
2.52.0


