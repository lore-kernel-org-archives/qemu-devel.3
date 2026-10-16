Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D249CCF2C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhaU-0007kS-6A; Fri, 16 Oct 2026 09:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHeXu-00061w-Fl; Fri, 16 Oct 2026 05:48:14 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHeXq-0007l0-5i; Fri, 16 Oct 2026 05:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792144086; bh=2d+4Rsau3NiT1beS6m9afp36KQFEo9wEHKrVLrDK18I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CvsDotn8ZUJcoDhzE2c/3qU8E9YAq9mBCdjMd1fwv31xBQp1AFHIuCvrwdDem5v3Q
 KG7Qs0jSWgCL+6tIUoGhMKT6WZAB1a2JdtqXu9cGWpp3FyB/mk9EKTDmoUBw61e+UV
 Xs4LpxM0NoArxPzptfg4WLhbcvjQZN+ARmtvurTQ=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id BF4A1837; Fri, 16 Oct 2026 17:47:52 +0800
X-QQ-mid: xmsmtpt1792144084tfvy8cyil
Message-ID: <tencent_EC6CDAD1841362E72DB694D10CF7B1D80A06@qq.com>
X-QQ-XMAILINFO: Mfa2ogpi8We7cvXCLKLfTzyMbSr86/MUUZW4af9u79jplB08K7gn2b5lVA60o9
 oi2jU4xQuMhtkOdkmnf0rwFXzK7G2cdJ3z2WVonQGwxlt9hj2saCqEB4ejYh3GRDo21OGsp/cWvX
 hWf2MwItrIZl4ipWbKx1ga41+g7TgMCY1GwHLiDT9qmbLAjKD8MXWBRG3e6NNhQaks8VU5vjcZS6
 QPehvekoQf0Nm9zehcFnPx3fvY8dnkf9hMphXytQFU+7rTk3D3eVM0J1At6eam2jSgWvpPkPK5/r
 8j9SCBbU+iDIViCyNYxcWZXXwDz4tSeev+sZkwuA60r8tR4h5guGzQaaje+66qRiFyTiaWEZbAvM
 /EcwqX4S7/cVBtQHqDwxs2DvL9PWu4eZXrxk4wuNT403FMUB7fJH10JXo+uPpMpifCmg5+zW5PTE
 VZWEvWN613/HGf77Qz9PwwGsPg/25348esB6NnBHDqx6HSBGcwPoQmQ91oR7xR6pyXzZZxKT0C3y
 l5slrmRjw4K0lsveGKBSGqXh0YcewxQs23ZJr7dgV1NHkpv+3Tq0eNfp0ac8pKOGxjzw31H3PBzE
 Irex22IwLJFVkjVdjp3HpgbJ3J5SHIvWJj2XfSyJy6JRWWi5q0F1yWP+FlxOcsz9VMd3B2YyJIT2
 3/KVbPNJTiqR9GRTDQMkcKSd0Pi8/vrQAfQPo9tR68c5zIRMWPtYVrD5QCJZgV57vYmg5NKqS/13
 vi0JzU+gwcsKs9yOvrBT3bLL78lhWKzJNzwEdDLF4X22OwKf/H6N8Zg/QBvb+fM680VineIb6Kuz
 UTFRW2bglIU1Afoqj88iRnjbYA1s0jhFZ7QTiBv2mw9AgtWAgZA5bUZFi7FB+CYC1cQxn8RCHByl
 Hi3q3Bvk0MDtmlzFPerw7ctYosVbfdSeJH0zqmhFZy3EUI3W57tcoyz+bhCLF9IIu4FPnSzBHiQd
 S0pZbnzhTgoqw3h3XJfeD8lYLjWxBY+xv6w1aAHXkQ9rgy08ZH2D2nLuGTyAu8f/CvKh53SSSCAl
 jt/2AcyxcfR2LheDmXIf2MXzo99fvPKF3N1IMXGzDhKe6gH9G1rWzGhyCvz2aKL07YDKUvuwNLgh
 bPvihs
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 10/37] hw/arm/mpam: Add per-RIS partition config storage
Date: Fri, 16 Oct 2026 17:47:04 +0800
X-OQ-MSGID: <20261016094733.1898485-11-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016094733.1898485-1-2118537295@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.44; envelope-from=2118537295@qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:27 -0400
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

Add the per-internal-PARTID configuration storage: MpamfPerNrwId
holds every partition's CPBM bitmap, bandwidth, priority and
capacity settings, allocated per RIS at realize together with the
request-to-internal PARTID indirection table.  mpam_get_nrw_id()
resolves the currently selected partition for the configuration
register accesses: with INTERNAL selection the selector addresses
the internal PARTID space directly, otherwise the indirection
table maps the request PARTID.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/mpam.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
index c21a737..cce9355 100644
--- a/hw/arm/mpam.c
+++ b/hw/arm/mpam.c
@@ -222,6 +222,16 @@ REG32(MPAMF_MPAMCFG_MBW_PBM0, 0x2000)
 /* MPAMF_IIDR.IMPLEMENTER: ARM JEP106 code for Huawei (0x736). */
 #define MPAM_IIDR_IMPLEMENTER 0x736
 
+typedef struct MpamfPerNrwId {
+        uint32_t cfg_cpbm[(MPAM_CACHE_PART + 31) / 32];
+        uint32_t cfg_mbw_pbm[(MPAM_MBW_PART + 31) / 32];
+        uint32_t cfg_pri;
+        uint32_t cfg_cmax;
+        uint32_t cfg_mbw_min;
+        uint32_t cfg_mbw_max;
+        uint32_t cfg_mbw_prop;
+} MpamfPerNrwId;
+
 typedef struct Mpamf {
     uint64_t idr;
     uint32_t iidr;
@@ -243,6 +253,10 @@ typedef struct Mpamf {
     uint32_t ecr;
     uint32_t esr;
     uint32_t cfg_part_sel;
+    uint32_t *cfg_intpartid;
+
+    MpamfPerNrwId *per_nrw_id;
+
 } Mpamf;
 
 typedef struct MPAMMSCState {
@@ -260,6 +274,27 @@ typedef struct MPAMMSCState {
 
 } MPAMMSCState;
 
+/*
+ * ID narrowing may be in effect.  If it is there is an indirection
+ * table per RIS mapping from part_sel to the internal ID. To make things
+ * more complex, the Partition selection register can directly address
+ * internal IDs. That works for everything other than the ID map itself.
+ * This function pulls the right internal ID out of this complexity
+ * for use in accessing the per_nrw_id structures.
+ */
+static uint32_t mpam_get_nrw_id(MPAMMSCState *s)
+{
+    Mpamf *mpamf = &s->mpamf[s->ris];
+
+    if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_PARTID_NRW)) {
+        return s->part_sel;
+    }
+    if (s->internal_part_sel) {
+        return s->part_sel;
+    }
+    return mpamf->cfg_intpartid[s->part_sel];
+}
+
 typedef struct MPAMMSCMemState {
     MPAMMSCState parent;
 } MPAMMSCMemState;
@@ -285,6 +320,7 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
 {
     MPAMMSCState *s = MPAM_MSC_DEVICE(opaque);
     Mpamf *mpamf = &s->mpamf[s->ris];
+    uint32_t nrw_part_sel = mpam_get_nrw_id(s);
 
     switch (offset) {
     case A_MPAMF_IDR:
@@ -344,6 +380,8 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
     MPAMMSCState *s = MPAM_MSC_DEVICE(opaque);
     /* Update in the ris setting path */
     Mpamf *mpamf = &s->mpamf[s->ris];
+    /* Update if cfg_intpartid being touched */
+    uint32_t nrw_part_sel = mpam_get_nrw_id(s);
 
     switch (offset) {
     case A_MPAMF_CFG_PART_SEL:
@@ -397,6 +435,7 @@ static const MemoryRegionOps mpam_msc_ops = {
 static void mpam_msc_realize(DeviceState *dev, Error **errp)
 {
     MPAMMSCState *s = MPAM_MSC_DEVICE(dev);
+    int i;
 
     /* IHI 0099: MPAMF_CFG_PART_SEL.RIS is 4 bits, so at most 16 RIS. */
     if (s->num_ris > 16) {
@@ -412,6 +451,11 @@ static void mpam_msc_realize(DeviceState *dev, Error **errp)
     }
 
     s->mpamf = g_new0(Mpamf, s->num_ris);
+    for (i = 0; i < s->num_ris; i++) {
+        s->mpamf[i].per_nrw_id = g_new0(MpamfPerNrwId, s->num_int_partid);
+        s->mpamf[i].cfg_intpartid = g_new0(uint32_t, s->num_partid);
+    }
+
     memory_region_init_io(&s->mr, OBJECT(s), &mpam_msc_ops, s, "mpam_msc",
                           MPAM_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
-- 
2.43.0


