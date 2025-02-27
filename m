Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67828C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 09:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnaDx-0007jj-DW; Thu, 27 Feb 2025 04:30:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tnaDu-0007co-8x; Thu, 27 Feb 2025 04:30:30 -0500
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tnaDr-0008EQ-NK; Thu, 27 Feb 2025 04:30:29 -0500
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id 19B591382F68;
 Thu, 27 Feb 2025 04:30:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Thu, 27 Feb 2025 04:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1740648626; x=
 1740735026; bh=dAVRViJuqfc0dcxFnHqF/2fKV606ih1LEeXwmuraMI0=; b=e
 Bwt5stGTMeh8ACYRWw53kbt2r9TCf4fqR+C0JxRd2vHxEOhKebE4UbfDIXiv7qtP
 2R3nZJZfKyMJYjcc4ehgoaG0wOV35Tt6bxQIamDEXoGIIWgy6UrlCIF49xxTPqBi
 beaevuLiaBGmkRrcrAI0KcugxhcDB97KhFylyynfc7A99KQGBgtGdafDK0AuK2+U
 bur1A6Vbe8BfjWFnS3TDNEDJS9qQ7gEnWrH/vXglU8Nn+bJpWldTZWrAXVY6G7T4
 pbQtpkunlKYJKP4nAnmP3t89sZTCSdN3G+ttsVmGQuQbHQ70ftizWcOM4zqAipa4
 lPpB/autY42VAyHFcb08w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1740648626; x=1740735026; bh=d
 AVRViJuqfc0dcxFnHqF/2fKV606ih1LEeXwmuraMI0=; b=wM6u1ZfynP+nHxeK4
 Vq2yTrJWAWCX6hQS73XrZLB3nQf2Zr8TMjB3bL/xVOXN7DJYSfv+7iesvolxRmt+
 CfyQ/gVNtAlwJ5wxmgoOTvmRJ7p0Q3wjtfmcN4PYf4OOFtRHnCo95HYJzxv9sAdc
 CmRIJyiGSOcESvqVxiYJwfdeLixm2nSSestoA5EJLwdm8aSvTDcdKR1fRFgVGkls
 a76QSsNAbKa+EDufyONeMukt3ZDslKO+6UB/ISPN0Jrg1WYq7uv9UD1iN0ScBxh6
 l//5a5UdeVptcWoTexsz1stXMgnvhKfwT4R8EGfqONnwDf6ezXoT+fhR+l+RzcFJ
 lwYvA==
X-ME-Sender: <xms:sTDAZ4knRVerQ2mH0u5EdwZszuMTlEJx8eAirJ3j5bW8HmCDcGu9ng>
 <xme:sTDAZ30HOdKmz2Rx5MN5hxqxr421eaSNu_uPGsFe407x0HIBy4wtVevDvzxsjOUkT
 KTPnOkJ_tXFr-mGQKo>
X-ME-Received: <xmr:sTDAZ2rWngNh2PaKFbUMQMk1u_7VrBRByv9jl06QzCK1hIloci2BWa3DgJWSarP7R4PETzKGY5BeOxg_oIImXHv0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjedutdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
 drughkqeenucggtffrrghtthgvrhhnpeeguedtleehvdevfefhvefftdfgveejjeefgfek
 ffejffeuueehuddtteduuddtgeenucffohhmrghinhepohhpvghntghomhhpuhhtvgdroh
 hrghdpnhhvmhgvgihprhgvshhsrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfr
 rghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspg
 hrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdq
 uggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvg
 hllheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshgsrghtvghssehrrghithhhlhhi
 nhdrtghomhdprhgtphhtthhopehjrdhgrhgrnhgrughoshesshgrmhhsuhhnghdrtghomh
 dprhgtphhtthhopehkrdhjvghnshgvnhesshgrmhhsuhhnghdrtghomhdprhgtphhtthho
 pehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhtshesihhrrhgvlh
 gvvhgrnhhtrdgukhdprhgtphhtthhopehfohhsshesuggvfhhmrggtrhhordhithdprhgt
 phhtthhopehsthgvfhgrnhhhrgesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:sTDAZ0nz3xmyhumF93fVNfXBxXv7je07Chq1QLf7kwFDdVYPrA2akQ>
 <xmx:sTDAZ23wfQokqUSNX9ZkxIebWp0K8shWR5u4wtBipepVXo6bJX5wbQ>
 <xmx:sTDAZ7voA0mWK3sPDxEUOBfGN_BAMezfhpOp1DDttp5Imn6Wb7U_OQ>
 <xmx:sTDAZyWrw8KVycdep9oOB3FHD_ROwfQyOBVCigZ9mNkvBCw4PyHfJg>
 <xmx:sjDAZwPA2Q8sKgNHUvv5_YZ7fOJwnI9WXcHvQoNE-mDGZhhfHQMW6jf1>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 04:30:22 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stephen Bates <sbates@raithlin.com>,
 Joel Granados <j.granados@samsung.com>,
 Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 01/10] hw/nvme: Add OCP SMART / Health Information Extended Log
 Page
Date: Thu, 27 Feb 2025 10:30:08 +0100
Message-ID: <20250227093018.11262-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250227093018.11262-1-its@irrelevant.dk>
References: <20250227093018.11262-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.149; envelope-from=its@irrelevant.dk;
 helo=fout-a6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Stephen Bates <sbates@raithlin.com>

The Open Compute Project [1] includes a Datacenter NVMe
SSD Specification [2]. The most recent version of this specification
(as of November 2024) is 2.6.1. This specification layers on top of
the NVM Express specifications [3] to provide additional
functionality. A key part of of this is the 512 Byte OCP SMART / Health
Information Extended log page that is defined in Section 4.8.6 of the
specification.

We add a controller argument (ocp) that toggles on/off the SMART log
extended structure.  To accommodate different vendor specific specifications
like OCP, we add a multiplexing function (nvme_vendor_specific_log) which
will route to the different log functions based on arguments and log ids.
We only return the OCP extended SMART log when the command is 0xC0 and ocp
has been turned on in the nvme argumants.

Though we add the whole nvme SMART log extended structure, we only populate
the physical_media_units_{read,written}, log_page_version and
log_page_uuid.

This patch is based on work done by Joel but has been modified enough
that he requested a co-developed-by tag rather than a signed-off-by.

[1]: https://www.opencompute.org/
[2]: https://www.opencompute.org/documents/datacenter-nvme-ssd-specification-v2-6-1-pdf
[3]: https://nvmexpress.org/specifications/

Signed-off-by: Stephen Bates <sbates@raithlin.com>
Co-developed-by: Joel Granados <j.granados@samsung.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 docs/system/devices/nvme.rst |  7 +++++
 hw/nvme/ctrl.c               | 59 ++++++++++++++++++++++++++++++++++++
 hw/nvme/nvme.h               |  1 +
 include/block/nvme.h         | 41 +++++++++++++++++++++++++
 4 files changed, 108 insertions(+)

diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
index d2b1ca96455f..6509b35fcb4e 100644
--- a/docs/system/devices/nvme.rst
+++ b/docs/system/devices/nvme.rst
@@ -53,6 +53,13 @@ parameters.
   Vendor ID. Set this to ``on`` to revert to the unallocated Intel ID
   previously used.
 
+``ocp`` (default: ``off``)
+  The Open Compute Project defines the Datacenter NVMe SSD Specification that
+  sits on top of NVMe. It describes additional commands and NVMe behaviors
+  specific for the Datacenter. When this option is ``on`` OCP features such as
+  the SMART / Health information extended log become available in the
+  controller. We emulate version 5 of this log page.
+
 Additional Namespaces
 ---------------------
 
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 8175751518f8..11687e597a11 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4917,6 +4917,45 @@ static void nvme_set_blk_stats(NvmeNamespace *ns, struct nvme_stats *stats)
     stats->write_commands += s->nr_ops[BLOCK_ACCT_WRITE];
 }
 
+static uint16_t nvme_ocp_extended_smart_info(NvmeCtrl *n, uint8_t rae,
+                                             uint32_t buf_len, uint64_t off,
+                                             NvmeRequest *req)
+{
+    NvmeNamespace *ns = NULL;
+    NvmeSmartLogExtended smart_l = { 0 };
+    struct nvme_stats stats = { 0 };
+    uint32_t trans_len;
+
+    if (off >= sizeof(smart_l)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    /* accumulate all stats from all namespaces */
+    for (int i = 1; i <= NVME_MAX_NAMESPACES; i++) {
+        ns = nvme_ns(n, i);
+        if (ns) {
+            nvme_set_blk_stats(ns, &stats);
+        }
+    }
+
+    smart_l.physical_media_units_written[0] = cpu_to_le64(stats.units_written);
+    smart_l.physical_media_units_read[0] = cpu_to_le64(stats.units_read);
+    smart_l.log_page_version = 0x0005;
+
+    static const uint8_t guid[16] = {
+        0xC5, 0xAF, 0x10, 0x28, 0xEA, 0xBF, 0xF2, 0xA4,
+        0x9C, 0x4F, 0x6F, 0x7C, 0xC9, 0x14, 0xD5, 0xAF
+    };
+    memcpy(smart_l.log_page_guid, guid, sizeof(smart_l.log_page_guid));
+
+    if (!rae) {
+        nvme_clear_events(n, NVME_AER_TYPE_SMART);
+    }
+
+    trans_len = MIN(sizeof(smart_l) - off, buf_len);
+    return nvme_c2h(n, (uint8_t *) &smart_l + off, trans_len, req);
+}
+
 static uint16_t nvme_smart_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
                                 uint64_t off, NvmeRequest *req)
 {
@@ -5146,6 +5185,23 @@ static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint8_t csi, uint32_t buf_len,
     return nvme_c2h(n, ((uint8_t *)&log) + off, trans_len, req);
 }
 
+static uint16_t nvme_vendor_specific_log(NvmeCtrl *n, uint8_t rae,
+                                         uint32_t buf_len, uint64_t off,
+                                         NvmeRequest *req, uint8_t lid)
+{
+    switch (lid) {
+    case NVME_OCP_EXTENDED_SMART_INFO:
+        if (n->params.ocp) {
+            return nvme_ocp_extended_smart_info(n, rae, buf_len, off, req);
+        }
+        break;
+        /* add a case for each additional vendor specific log id */
+    }
+
+    trace_pci_nvme_err_invalid_log_page(nvme_cid(req), lid);
+    return NVME_INVALID_FIELD | NVME_DNR;
+}
+
 static size_t sizeof_fdp_conf_descr(size_t nruh, size_t vss)
 {
     size_t entry_siz = sizeof(NvmeFdpDescrHdr) + nruh * sizeof(NvmeRuhDescr)
@@ -5396,6 +5452,8 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
         return nvme_smart_info(n, rae, len, off, req);
     case NVME_LOG_FW_SLOT_INFO:
         return nvme_fw_log_info(n, len, off, req);
+    case NVME_LOG_VENDOR_START...NVME_LOG_VENDOR_END:
+        return nvme_vendor_specific_log(n, rae, len, off, req, lid);
     case NVME_LOG_CHANGED_NSLIST:
         return nvme_changed_nslist(n, rae, len, off, req);
     case NVME_LOG_CMD_EFFECTS:
@@ -8971,6 +9029,7 @@ static const Property nvme_props[] = {
     DEFINE_PROP_BOOL("atomic.dn", NvmeCtrl, params.atomic_dn, 0),
     DEFINE_PROP_UINT16("atomic.awun", NvmeCtrl, params.atomic_awun, 0),
     DEFINE_PROP_UINT16("atomic.awupf", NvmeCtrl, params.atomic_awupf, 0),
+    DEFINE_PROP_BOOL("ocp", NvmeCtrl, params.ocp, false),
 };
 
 static void nvme_get_smart_warning(Object *obj, Visitor *v, const char *name,
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 724220691057..e307e733e46a 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -545,6 +545,7 @@ typedef struct NvmeParams {
     uint32_t  sriov_max_vq_per_vf;
     uint32_t  sriov_max_vi_per_vf;
     bool     msix_exclusive_bar;
+    bool     ocp;
 
     struct {
         bool mem;
diff --git a/include/block/nvme.h b/include/block/nvme.h
index f4d108841bf5..975d321c5c08 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1015,6 +1015,40 @@ typedef struct QEMU_PACKED NvmeSmartLog {
     uint8_t     reserved2[320];
 } NvmeSmartLog;
 
+typedef struct QEMU_PACKED NvmeSmartLogExtended {
+    uint64_t    physical_media_units_written[2];
+    uint64_t    physical_media_units_read[2];
+    uint64_t    bad_user_blocks;
+    uint64_t    bad_system_nand_blocks;
+    uint64_t    xor_recovery_count;
+    uint64_t    uncorrectable_read_error_count;
+    uint64_t    soft_ecc_error_count;
+    uint64_t    end2end_correction_counts;
+    uint8_t     system_data_percent_used;
+    uint8_t     refresh_counts[7];
+    uint64_t    user_data_erase_counts;
+    uint16_t    thermal_throttling_stat_and_count;
+    uint16_t    dssd_spec_version[3];
+    uint64_t    pcie_correctable_error_count;
+    uint32_t    incomplete_shutdowns;
+    uint32_t    rsvd116;
+    uint8_t     percent_free_blocks;
+    uint8_t     rsvd121[7];
+    uint16_t    capacity_health;
+    uint8_t     nvme_errata_ver;
+    uint8_t     rsvd131[5];
+    uint64_t    unaligned_io;
+    uint64_t    security_ver_num;
+    uint64_t    total_nuse;
+    uint64_t    plp_start_count[2];
+    uint64_t    endurance_estimate[2];
+    uint64_t    pcie_retraining_count;
+    uint64_t    power_state_change_count;
+    uint8_t     rsvd208[286];
+    uint16_t    log_page_version;
+    uint64_t    log_page_guid[2];
+} NvmeSmartLogExtended;
+
 #define NVME_SMART_WARN_MAX     6
 enum NvmeSmartWarn {
     NVME_SMART_SPARE                  = 1 << 0,
@@ -1052,6 +1086,12 @@ enum NvmeLogIdentifier {
     NVME_LOG_FDP_RUH_USAGE              = 0x21,
     NVME_LOG_FDP_STATS                  = 0x22,
     NVME_LOG_FDP_EVENTS                 = 0x23,
+    NVME_LOG_VENDOR_START               = 0xc0,
+    NVME_LOG_VENDOR_END                 = 0xff,
+};
+
+enum NvmeOcpLogIdentifier {
+    NVME_OCP_EXTENDED_SMART_INFO = 0xc0,
 };
 
 typedef struct QEMU_PACKED NvmePSD {
@@ -1899,6 +1939,7 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeErrorLog) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeFwSlotInfoLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) != 512);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLogExtended) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrlZoned) != 4096);
-- 
2.47.2


