Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3158CCCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhaI-0007We-Lj; Fri, 16 Oct 2026 09:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHeXu-00061y-Fd; Fri, 16 Oct 2026 05:48:14 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHeXp-0007kW-NI; Fri, 16 Oct 2026 05:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792144084; bh=Xa9doJjWGNLZgCC2kqUUefqJvMPAAInX41a9yFJtRvE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qq4s6L30Nx5cVGf8/AZw2eus3jRh3MTS0QgaSBeNEGMh7thqhd55e6obP3/mQLmMt
 mr+xbghFcqzSFtwg5/nFum7M9TECWbCXn4IIJ3itldbmNQ6VRQK9ExR0f89EghhWID
 cC88AFTNsAiw1Y/59UX6kK1pIyJI3tcaD4WTPgVE=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id BF4A1837; Fri, 16 Oct 2026 17:47:52 +0800
X-QQ-mid: xmsmtpt1792144081t5uoo0jli
Message-ID: <tencent_1A2B9A692313EC887BB7C152CC339DC74808@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25G5UnjbUhRFgY18rdfj3YH0lRRyvrllADRgFaG8V5cfwt0kv9XKi
 +XcmB4ZA8PIz36sTlOoqeqs+VHMB8c6tjE0L+MXvAyTOWvKE3bXEMwI9Lqg7KBrXhX1gP9w0r/8d
 TyDlb2k+T0Gbfs12dXV3RjsZzeEqtf5gZLFQGlApwRYEJSdKUFWBNez/hsgvGtB3R8WhCLeyvADf
 UakUr1ETEZoRPNyHbeG0WcTCO/2O0w/tcZ4NFmqunM0wjKuTveZp4Zp9VS67xaNrpyicuv3zBSQT
 CSVUEKOJkl8VXIXBt9rYbjAgT0vkBnrgjifb1pNgsT17C9Z5iWX7mTkPCf+l/55vKKZ3ekt0XQW0
 HsVGGaS/EqSymvitBJbzlkVPorqIKi9glOMa+QH07ERmMiA/32Wb6/IyfnAgCr4TTxh/y7avuwIU
 /cl5chFUPvdzafZ5u0g0FERB8+qSLQjvsu1IxJG5mZJ6DBGv5jxUJTnnj9GKEiaB+ztm/qWylOvB
 JRc1Iek7dRpqasQWTDVuQ+aEdpOgBTwyIZxOcs7pJ26+qq+MdFJPjvffuiGw/CztJF57sPHg4l0L
 ElqdG+QAaRYqz+7AaJzv3EHYuBnYatQ28+GInf5EzEVuJt4ysk7Sf++Mw3YlJRjYPZYL00RiCbPd
 cXDjthmER7+vGEb4Bx+joZV5MGTAGJ58DPDF5VntSPQmGG+Z83xPoW+iMvSN8NfAzgl3h37LROdd
 Pv1pQeoola8qvCkfWODUlcUMjkn66LM9suQjycw0XqkuZOX3+e8llck9pHNUwHP4Pm/ApByISIpi
 u39y2ySt0FXb2wnv1MouiByVlaQ1HfSzpz76DiD1YDQP41bTTNCqPvTmRt52pbOQJQR95vuCH6d7
 h3TxsyVnjX5EdYxhSWd/rPzPTYflvQkSRKEk7dN0VGLIO1QztcB4T8gWSl2gTqVq6+qiLbq7pXqy
 H0F1gRJhkXfcc0eFCNigjSaoWWyAKoLQiltOmHP01HE76DDYsaH37FtREO6SE2emRyAsw+bvYDCx
 xFYseXFUAbqBnxQvb4/itxXgDn2XIghCaDqgyadPuBsepBJQ4L/WcUMB8470oUbGMDOAoF0tYLy2
 Yq9Bix
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 08/37] hw/arm/mpam: Add mpam-msc-cache MSC subtype
Date: Fri, 16 Oct 2026 17:47:02 +0800
X-OQ-MSGID: <20261016094733.1898485-9-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016094733.1898485-1-2118537295@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.50; envelope-from=2118537295@qq.com;
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
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:33 -0400
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

Add the mpam-msc-cache subtype for cache components, with the
cache-level/cache-type/cpu properties the board uses to place the
MSC in the cache topology.  Its realize assembles the cache
identity view of MPAMF_IDR (same as the memory side, plus SP4=0
for RME) and IIDR/AIDR; the CPOR/CCAP/PRI feature bits arrive
with their respective partitioning patches.

Based on an RFC series by Jonathan Cameron.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/mpam.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
index 8a85c3b..17ca286 100644
--- a/hw/arm/mpam.c
+++ b/hw/arm/mpam.c
@@ -264,11 +264,22 @@ typedef struct MPAMMSCMemState {
     MPAMMSCState parent;
 } MPAMMSCMemState;
 
+typedef struct MPAMMSCCacheState {
+    MPAMMSCState parent;
+    uint8_t cache_level;
+    uint8_t cache_type;
+    uint16_t cpu;
+
+} MPAMMSCCacheState;
+
 DECLARE_INSTANCE_CHECKER(MPAMMSCState, MPAM_MSC_DEVICE, TYPE_MPAM_MSC);
 
 DECLARE_INSTANCE_CHECKER(MPAMMSCMemState, MPAM_MSC_MEM_DEVICE,
                          TYPE_MPAM_MSC_MEM);
 
+DECLARE_INSTANCE_CHECKER(MPAMMSCCacheState, MPAM_MSC_CACHE_DEVICE,
+                         TYPE_MPAM_MSC_CACHE);
+
 static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
                                   unsigned size)
 {
@@ -420,12 +431,72 @@ static void mpam_msc_mem_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static void mpam_msc_cache_realize(DeviceState *dev, Error **errp)
+{
+    MPAMMSCState *s = MPAM_MSC_DEVICE(dev);
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
+
+        /* Optional - test with and without */
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_ESR, 1);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_EXTD_ESR,
+                                s->num_ris > 1);
+
+        /* We won't implement any implementation specific stuff */
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, NO_IMPL_PART, 1);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, NO_IMPL_MSMON, 1);
+
+        /* Need to implement for RME */
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, SP4, 0);
+
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_PARTID_NRW,
+                                s->num_int_partid < s->num_partid);
+
+        mpamf->iidr = FIELD_DP32(mpamf->iidr, MPAMF_IIDR, IMPLEMENTER,
+                                 MPAM_IIDR_IMPLEMENTER);
+        mpamf->iidr = FIELD_DP32(mpamf->iidr, MPAMF_IIDR, REVISION, 0);
+        mpamf->iidr = FIELD_DP32(mpamf->iidr, MPAMF_IIDR, VARIANT, 0);
+        /* FIXME get allocation for this emulation */
+        mpamf->iidr = FIELD_DP32(mpamf->iidr, MPAMF_IIDR, PRODUCT_ID, 42);
+
+        mpamf->aidr = FIELD_DP32(mpamf->aidr, MPAMF_AIDR, ARCH_MINOR_REV, 1);
+        mpamf->aidr = FIELD_DP32(mpamf->aidr, MPAMF_AIDR, ARCH_MAJOR_REV, 1);
+
+        if (s->num_int_partid < s->num_partid) {
+            mpamf->partid_nrw_idr = FIELD_DP32(mpamf->partid_nrw_idr,
+                                               MPAMF_PARTID_NRW_IDR,
+                                               INTPARTID_MAX,
+                                               s->num_int_partid - 1);
+        }
+        /* TODO: Initialize all on as if firmware had done it for us */
+    }
+}
+
 static const Property mpam_msc_props[] = {
     DEFINE_PROP_UINT8("num-ris", MPAMMSCState, num_ris, 1),
     DEFINE_PROP_UINT32("num-partid", MPAMMSCState, num_partid, 1),
     DEFINE_PROP_UINT32("num-int-partid", MPAMMSCState, num_int_partid, 0),
 };
 
+static const Property mpam_msc_cache_props[] = {
+    DEFINE_PROP_UINT8("cache-level", MPAMMSCCacheState, cache_level, 1),
+    DEFINE_PROP_UINT8("cache-type", MPAMMSCCacheState, cache_type, 1),
+    DEFINE_PROP_UINT16("cpu", MPAMMSCCacheState, cpu, 2),
+};
+
 static void mpam_msc_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -440,6 +511,14 @@ static void mpam_msc_mem_init(ObjectClass *klass, const void *data)
     dc->realize = mpam_msc_mem_realize;
 }
 
+static void mpam_msc_cache_init(ObjectClass *klass, const void *data)
+{
+   DeviceClass *dc = DEVICE_CLASS(klass);
+
+   dc->realize = mpam_msc_cache_realize;
+   device_class_set_props(dc, mpam_msc_cache_props);
+}
+
 static const TypeInfo mpam_msc_info = {
     .name = TYPE_MPAM_MSC,
     .parent = TYPE_SYS_BUS_DEVICE,
@@ -454,9 +533,17 @@ static const TypeInfo mpam_msc_mem_info = {
     .class_init = mpam_msc_mem_init
 };
 
+static const TypeInfo mpam_msc_cache_info = {
+    .name = TYPE_MPAM_MSC_CACHE,
+    .parent = TYPE_MPAM_MSC,
+    .instance_size = sizeof(MPAMMSCCacheState),
+    .class_init = mpam_msc_cache_init
+};
+
 static void mpam_register_types(void)
 {
     type_register_static(&mpam_msc_info);
     type_register_static(&mpam_msc_mem_info);
+    type_register_static(&mpam_msc_cache_info);
 }
 type_init(mpam_register_types);
-- 
2.43.0


