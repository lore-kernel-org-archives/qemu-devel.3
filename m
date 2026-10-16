Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1D8CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhaK-0007Zz-8x; Fri, 16 Oct 2026 09:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeYy-0006ZN-Vq
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:49:21 -0400
Received: from out203-205-221-153.mail.qq.com ([203.205.221.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeYv-0007ui-1S
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792144150; bh=brp23fJA2yAN9/CTw2NxwDN4h2X1SVIO3Ep9wCGihF0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=STjm1iuY9LVxZ5hfZtTS1J2BbTfG4ijfcsAV3FGzij3rKBB5FNRk0HAx7NFuDuSGG
 UXFztkKB5+U5t3AxaNAuflgekFF0Jri+xlXhrQ4HQk2nZlaix0qmPUs9prmJft6KPs
 3ED/N01GOTMGb2nyNYto8wROccxF9srOR1eNPO2A=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id BF4A1837; Fri, 16 Oct 2026 17:47:52 +0800
X-QQ-mid: xmsmtpt1792144080th0nhfjzc
Message-ID: <tencent_2A6A4523CD66C21191EC56406A7866E2B805@qq.com>
X-QQ-XMAILINFO: NAvK98dRmgdft9v3NnDrrX+syVMeGMiE1oTrvB++xMtW4qtE60U+LstPJ+JMnS
 RvkTBVBwr3IWTu+ILFHcc2YzVunGTzCCGAW3Pc7EIJCVJsFE6mR1w4OSv2u093R4Oo0z8bYsoHB2
 R75Piv8Y3YXFFcnpzo1FpsYO/KH0k/aaUODzGJtSwu0qMUv73TEIjK7ARTKBuwZYDOs9PLZR/EG8
 +YkrLd7C6JgmJxfG74huwYAoKhW7fuuyKk4Yk9GScIZgQvhtgJ1YrFwfP7iRW0N3SY7g5mvKEOIb
 0lam7/cr/TTY1eMKuZWHI4LHHzskzcw7MGAi/vUxhu0RbMqZJMM7VNvz/jBiQotgz7JGWwXZwREC
 GBZBxRUB84xfy1nznxAyNp3B8M8C0PzOqY86OIA1LNPKB8DGJ5GOdOO3OQ9mbN/v/gHcd+sCM8bh
 Z6p5FrUWXVvS45mrG+P59sRIbFSabMnCO/yS1xEqyTY7E1B8a24I3YYraQq30s9fa62DfYlVoCUB
 CPBG5YZulB+iLeag69HR6wZwbFTVLXPfV4gJfzs92GdwIsKJ7oRlmfMAf8PywQaJSdMtnVqRPK6G
 fG7rP1g6HpSa0EN3tqGCEvzg5q6lYjhZJu2mtgt8uAC9tvgQRpYgN7y/m4RKoJMxo8ibfA/IN2nQ
 l3VAYt3hcTFsJxnu78dZi4AgBc0aUd8/7Kgz/YsgMZop8NBgm3C5PKLm3ZtA9qFwgIiD1f6QTHdJ
 Whk1chaxGdtsEPbwTvmntZ3poxrZoNmnVyGOtmhOjcIB8a8Me9IGDVnfAM7pvQ3RignNCU/YkENL
 iqQA/dWMuxXRRQm2zUcErrfkV8qs00iLJOJ7BpF2UcuPR+OkmXHqarJmJzrC5dZMYx+k4f6hD9aB
 HmgFc+IjV3EdtXLazwkhQyY6AcvsfpSJetda9xzVLpNdxQSX9Xaj0JLVkqxCinv5Oi8inI+esLjQ
 ij97lH6aaohOyrKHA4Q3NZDEXbN9KmvPOh8g7GmMa9AB+TTWuG3LQ3vmHL+9SNOUCgy+Qa6hHDie
 Rmb3I7GyE8Txh1GQMrHpQvAbphchdi7WM18hqBGQ25RcvIQS2sf+bOIdqqkCTNttbV0v80JRz9rB
 hHWVmG
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 07/37] hw/arm/mpam: Add mpam-msc-mem memory-side MSC subtype
Date: Fri, 16 Oct 2026 17:47:01 +0800
X-OQ-MSGID: <20261016094733.1898485-8-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016094733.1898485-1-2118537295@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.153; envelope-from=2118537295@qq.com;
 helo=out203-205-221-153.mail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:41 -0400
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

Add the mpam-msc-mem subtype for memory-side components.  Its
realize assembles the identity view of MPAMF_IDR (PARTID space,
optional RIS support, HAS_ESR/HAS_EXTD_ESR, HAS_PARTID_NRW when
the internal PARTID space is smaller) plus IIDR/AIDR, and
advertises no partitioning features yet: the bandwidth controls
come with the MBW patch.

Based on an RFC series by Jonathan Cameron.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/mpam.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
index b1d6472..8a85c3b 100644
--- a/hw/arm/mpam.c
+++ b/hw/arm/mpam.c
@@ -260,8 +260,15 @@ typedef struct MPAMMSCState {
 
 } MPAMMSCState;
 
+typedef struct MPAMMSCMemState {
+    MPAMMSCState parent;
+} MPAMMSCMemState;
+
 DECLARE_INSTANCE_CHECKER(MPAMMSCState, MPAM_MSC_DEVICE, TYPE_MPAM_MSC);
 
+DECLARE_INSTANCE_CHECKER(MPAMMSCMemState, MPAM_MSC_MEM_DEVICE,
+                         TYPE_MPAM_MSC_MEM);
+
 static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
                                   unsigned size)
 {
@@ -367,6 +374,52 @@ static void mpam_msc_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
 }
 
+static void mpam_msc_mem_realize(DeviceState *dev, Error **errp)
+{    MPAMMSCState *s = MPAM_MSC_DEVICE(dev);
+    int i;
+
+    mpam_msc_realize(dev, errp);
+
+    for (i = 0; i < s->num_ris; i++) {
+        Mpamf *mpamf = &s->mpamf[i];
+
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, PART_ID_MAX,
+                                s->num_partid - 1);
+        /* No PCMG for now */
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, PMG_MAX, 0);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, EXT, 1);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_RIS, s->num_ris > 1);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, RIS_MAX,
+                                  s->num_ris > 1 ? s->num_ris - 1 : 0);
+         /* Optional - test with and without */
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_ESR, 1);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_EXTD_ESR, 1);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_PARTID_NRW,
+                                s->num_int_partid < s->num_partid);
+
+        /* We won't implement any implementation specific stuff */
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, NO_IMPL_PART, 1);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, NO_IMPL_MSMON, 1);
+
+        mpamf->iidr = FIELD_DP64(mpamf->iidr, MPAMF_IIDR, IMPLEMENTER,
+                                 MPAM_IIDR_IMPLEMENTER);
+        mpamf->iidr = FIELD_DP64(mpamf->iidr, MPAMF_IIDR, REVISION, 0);
+        mpamf->iidr = FIELD_DP64(mpamf->iidr, MPAMF_IIDR, VARIANT, 0);
+        /* FIXME get allocation for this emulation */
+        mpamf->iidr = FIELD_DP64(mpamf->iidr, MPAMF_IIDR, PRODUCT_ID, 42);
+
+        mpamf->aidr = FIELD_DP64(mpamf->aidr, MPAMF_AIDR, ARCH_MINOR_REV, 1);
+        mpamf->aidr = FIELD_DP64(mpamf->aidr, MPAMF_AIDR, ARCH_MAJOR_REV, 1);
+
+        if (s->num_int_partid < s->num_partid) {
+            mpamf->partid_nrw_idr = FIELD_DP32(mpamf->partid_nrw_idr,
+                                               MPAMF_PARTID_NRW_IDR,
+                                               INTPARTID_MAX,
+                                               s->num_int_partid - 1);
+        }
+    }
+}
+
 static const Property mpam_msc_props[] = {
     DEFINE_PROP_UINT8("num-ris", MPAMMSCState, num_ris, 1),
     DEFINE_PROP_UINT32("num-partid", MPAMMSCState, num_partid, 1),
@@ -380,6 +433,13 @@ static void mpam_msc_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, mpam_msc_props);
 }
 
+static void mpam_msc_mem_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = mpam_msc_mem_realize;
+}
+
 static const TypeInfo mpam_msc_info = {
     .name = TYPE_MPAM_MSC,
     .parent = TYPE_SYS_BUS_DEVICE,
@@ -387,8 +447,16 @@ static const TypeInfo mpam_msc_info = {
     .class_init = mpam_msc_init
 };
 
+static const TypeInfo mpam_msc_mem_info = {
+    .name = TYPE_MPAM_MSC_MEM,
+    .parent = TYPE_MPAM_MSC,
+    .instance_size = sizeof(MPAMMSCMemState),
+    .class_init = mpam_msc_mem_init
+};
+
 static void mpam_register_types(void)
 {
     type_register_static(&mpam_msc_info);
+    type_register_static(&mpam_msc_mem_info);
 }
 type_init(mpam_register_types);
-- 
2.43.0


