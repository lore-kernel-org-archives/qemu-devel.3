Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CF0CCF2C3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhaD-0007Kn-2V; Fri, 16 Oct 2026 09:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeXu-000621-Fd
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:48:14 -0400
Received: from out203-205-221-205.mail.qq.com ([203.205.221.205])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeXo-0007kK-HU
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792144081; bh=4K4tXuy4N/WfzhzqSSLfGlX3v0njMaVxf+lSPeD2XV0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oABNzQHULkQAuNQkjYeZ3S9SxkseIBmMsJU5g++NaIUmQzkI4mITjVHWtbOLu45sx
 IUQKF1G5rdWAzPb72VEbx5eiq24NbUdEGbMvoVEf3gnwrxCPL90A62t2YEb4amBF4n
 8RCp42Hj8tEUUkeHVEyIe+7DBEgndiKWMqymLp1Q=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id BF4A1837; Fri, 16 Oct 2026 17:47:52 +0800
X-QQ-mid: xmsmtpt1792144079tevvq26r1
Message-ID: <tencent_8C2C6D66A20C91FD7641EA7206ED18672505@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJwtG1cvhK1i+V9L1xqqZom1L/uELsKkJJOB3fKQcZtWCgHSXv2N
 w/7JgILA5StTVY3rnC+heyDoVSC5tWgubJV5Uy9n3xI/5GmLoxdOTD7YrH58Rjo2K2FlyrMh8I10
 r96cYdVTVZuRnNaI1RcEDsy/CwIV7CBR0mz7cKcCox6NB8qUjxU4na5sirJ0JEnm36ZUJr/mlido
 OV6kPvjnixwsSk8aIb+W1BvzY5aCMoDDkADP9gBjW6hFo1eO3JVmvhaHDiUReP16cMS/8nuSzmRy
 U6goKonseMavLC6HAR8eVx5RtzDg3F8pUjWm1B5UjxAROwTt6rO2Hpgfjn07og4S6iabnz/korLR
 C92U89HIuBvL8DTIT4XdfLeWQqBxIRrBV5SlzdYFhom204WkxeRNYTl1DHbNaNeoVXYmaTcroduD
 ycT19kKNoWxC1QhrKxWfR/vx6E56VKOW9ouOP8u7KGdSVqZLgdIHJ8c82A82RGs09SKSmMkG9GBP
 t1/Ser65L2FkHG6bIe1GGMvTdE+1mliFmr/vWGzUq/ULBU4B6Ot9eN8LpBEco9kFqtBx70/s+cFl
 g8svfCw4mVUfWhVQqLt0Lc4vaW34K/4GuoMJlSFoGato3Nrp2vPXQVJb/HTwknTYUa7C8AwOdnAY
 Ohsr0AytXmywehj2Sg/gFUjkxvRlAiznfW6HPVRvDM5dsKVc9OsAN+lL4mV10ovrDIeNhZ9m6Qtb
 14fgAHJ1X+/8KCsugmhcWhFOpYupWdeorQTIetDvCtAQg8CBzyslbgUn4En3ygCN8qO6TNwAHbsk
 WfCFctL+DImSRFr5EC9fcrOt2nPKCnBcGIVKQPHM8Fzp78E8CvUYpsYrrAJOdOT678ZMRL+3lWGN
 h8QaVqD6Eldp5ZzFbwZfwunKtEuDLSMhWf5Z55KNrnxXI3txj25w/rPYIDKo99tHIWgpMkQJOU3p
 9liFviCIZOaHknnv4DRXlyb24fGnlK020a91VVyC/S4AiChkMAv3DV1ibA3rl4QOqrApMqcyqIxu
 yZW8rvYX5ChvjDNHobLRZ26Vxyo7K1Y9miXJXtW2vEXC1ex5t8
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 06/37] hw/arm/mpam: Add MPAM MSC base device
Date: Fri, 16 Oct 2026 17:47:00 +0800
X-OQ-MSGID: <20261016094733.1898485-7-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016094733.1898485-1-2118537295@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.205; envelope-from=2118537295@qq.com;
 helo=out203-205-221-205.mail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:31 -0400
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add the mpam-msc sysbus device core:
- Per-RIS register storage(Mpamf)
- The device state (selector state, num-ris/num-partid/
  num-int-partid properties), realize with the per-RIS allocation
  and the MMIO region (MPAM_SIZE window).
- The MMIO handlers covering the identification registers (MPAMF_IDR
  with its 64-bit EXT view IIDR, AIDR, IMPL_IDR, PARTID_NRW_IDR
  and the MSMON IDRs that read as zero until monitoring is implemented).

The base type registers no features; the mpam-msc-mem and
mpam-msc-cache subtypes assemble their feature IDR fields.

Based on an RFC series by Jonathan Cameron.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/mpam.c | 171 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 171 insertions(+)

diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
index 772a120..b1d6472 100644
--- a/hw/arm/mpam.c
+++ b/hw/arm/mpam.c
@@ -221,3 +221,174 @@ REG32(MPAMF_MPAMCFG_MBW_PBM0, 0x2000)
 #define MPAM_CACHE_PART 32
 /* MPAMF_IIDR.IMPLEMENTER: ARM JEP106 code for Huawei (0x736). */
 #define MPAM_IIDR_IMPLEMENTER 0x736
+
+typedef struct Mpamf {
+    uint64_t idr;
+    uint32_t iidr;
+    uint32_t aidr;
+    uint32_t impl_idr;
+    uint32_t cpor_idr;
+    uint32_t ccap_idr;
+    uint32_t mbw_idr;
+    uint32_t pri_idr;
+    uint32_t partid_nrw_idr;
+    uint32_t msmon_idr;
+    uint32_t csumon_idr;
+    uint32_t mbwumon_idr;
+    uint32_t err_msi_mpam;
+    uint32_t err_msi_addr_l;
+    uint32_t err_msi_addr_h;
+    uint32_t err_msi_data;
+    uint32_t err_msi_attr;
+    uint32_t ecr;
+    uint32_t esr;
+    uint32_t cfg_part_sel;
+} Mpamf;
+
+typedef struct MPAMMSCState {
+    SysBusDevice parent_obj;
+
+    Mpamf *mpamf;
+
+    uint8_t ris;
+    uint16_t part_sel; /* Technically per ris, but in same reg */
+    bool internal_part_sel;
+    struct MemoryRegion mr;
+    uint32_t num_partid;
+    uint32_t num_int_partid;
+    uint8_t num_ris;
+
+} MPAMMSCState;
+
+DECLARE_INSTANCE_CHECKER(MPAMMSCState, MPAM_MSC_DEVICE, TYPE_MPAM_MSC);
+
+static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
+                                  unsigned size)
+{
+    MPAMMSCState *s = MPAM_MSC_DEVICE(opaque);
+    Mpamf *mpamf = &s->mpamf[s->ris];
+
+    switch (offset) {
+    case A_MPAMF_IDR:
+        switch (size) {
+        case 4:
+            return mpamf->idr & 0xffffffff;
+        case 8:
+            return mpamf->idr;
+        default:
+            qemu_log_mask(LOG_UNIMP, "MPAM: Unexpected read size\n");
+            return 0;
+        }
+    case A_MPAMF_IDR + 0x04:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, EXT)) {
+            qemu_log_mask(LOG_UNIMP, "MPAM: Unexpected read of top of IDR\n");
+            return 0;
+        }
+        switch (size) {
+        case 4:
+            return mpamf->idr >> 32;
+        default:
+            qemu_log_mask(LOG_UNIMP, "MPAM: Unexpected read size\n");
+            return 0;
+        }
+    case A_MPAMF_IIDR:
+        return mpamf->iidr;
+    case A_MPAMF_AIDR:
+        return mpamf->aidr;
+    case A_MPAMF_IMPL_IDR:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_IMPL_IDR)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Accessing IMPL_IDR which isn't suported\n");
+            return 0;
+        }
+        return mpamf->impl_idr;
+    case A_MPAMF_PARTID_NRW_IDR: {
+        return mpamf->partid_nrw_idr;
+    }
+    case A_MPAMF_MSMON_IDR:
+        return mpamf->msmon_idr;
+    case A_MPAMF_CSUMON_IDR:
+        return mpamf->csumon_idr;
+    case A_MPAMF_MBWUMON_IDR:
+        return mpamf->mbwumon_idr;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "MPAM: Unexpected read of %lx\n", offset);
+        return 0x0;
+    }
+}
+
+static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
+                               unsigned size)
+{
+    switch (offset) {
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "MPAM: Write to unexpected register Addr %lx Value=%lx\n",
+                      offset, value);
+    }
+}
+
+static const MemoryRegionOps mpam_msc_ops = {
+    .read = mpam_msc_read_reg,
+    .write = mpam_msc_write_reg,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = false,
+    },
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+};
+
+static void mpam_msc_realize(DeviceState *dev, Error **errp)
+{
+    MPAMMSCState *s = MPAM_MSC_DEVICE(dev);
+
+    /* IHI 0099: MPAMF_CFG_PART_SEL.RIS is 4 bits, so at most 16 RIS. */
+    if (s->num_ris > 16) {
+        error_setg(errp, "num-ris must be <= 16");
+        return;
+    }
+    if (s->num_partid == 0) {
+        error_setg(errp, "num-ris must be <= 16");
+        return;
+    }
+    if (s->num_int_partid == 0) {
+        s->num_int_partid = s->num_partid;
+    }
+
+    s->mpamf = g_new0(Mpamf, s->num_ris);
+    memory_region_init_io(&s->mr, OBJECT(s), &mpam_msc_ops, s, "mpam_msc",
+                          MPAM_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
+}
+
+static const Property mpam_msc_props[] = {
+    DEFINE_PROP_UINT8("num-ris", MPAMMSCState, num_ris, 1),
+    DEFINE_PROP_UINT32("num-partid", MPAMMSCState, num_partid, 1),
+    DEFINE_PROP_UINT32("num-int-partid", MPAMMSCState, num_int_partid, 0),
+};
+
+static void mpam_msc_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, mpam_msc_props);
+}
+
+static const TypeInfo mpam_msc_info = {
+    .name = TYPE_MPAM_MSC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(MPAMMSCState),
+    .class_init = mpam_msc_init
+};
+
+static void mpam_register_types(void)
+{
+    type_register_static(&mpam_msc_info);
+}
+type_init(mpam_register_types);
-- 
2.43.0


