Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1999CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhak-0007pc-Bq; Fri, 16 Oct 2026 09:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeXw-00064L-Bu
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:48:16 -0400
Received: from out203-205-221-205.mail.qq.com ([203.205.221.205])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeXu-0007l9-Bi
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792144087; bh=CFUuWfDjwJ1xmZXGGkNFyAd7r7YLRzsuXu6bJyNXd4w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=If/bcq/koeZsai7ed2mfQBEcWVnRKXZOg5JHNEyWEgySAIJOFk1zD+a8skVsTXyqf
 1DWVcMVK2tZfpTH5Uho9UA+TQTMRB5b4hT8fiuq0gVRAhXUdrcdaQ7uwi/a8k9FfgX
 4aDw99H8U3Xu2vi1kgmGrYrWc+Dog9E4aNl7AviY=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id BF4A1837; Fri, 16 Oct 2026 17:47:52 +0800
X-QQ-mid: xmsmtpt1792144085tnxi1b822
Message-ID: <tencent_6C7ED336265811796EE3A442668C8E275709@qq.com>
X-QQ-XMAILINFO: NmhoXJR/eu5xX3X8CfzNyecIooM8VpASQpoaR1xUWNRPTamGHhZWO4bn1LnsRN
 OBoX4M8sLO5WOioD+MsDbjRt+LO+ZLRh+HUe7dShVNxj5Cb7OrYOdcP5UMZZz8TiYSborE2qta0s
 GrRTcNsN9FTI8elN6Y/7uBY4qXa9uiTjwYFyYMnfKbYxzYlWh5unjo3Tbxeuj3BMjdJNxDK14bX9
 WpN7RgdFhYGzv4RdPemmU+rB5mqQGkMScN6GebPk9jd3Xc3H0zhZa1dXq1JjEhipA788OWu4jBfZ
 d3R7mrBWNX5FSUIxc7l0bchWG3LGtgplQx3fzpbWkewQH5MN60u/NAnhYKkGTtGLsKxDvxsr2gZM
 +iQoAAuSkearn3THT2mSJWv/igSOHo5gZpqj8v9KD+3EPkns3GwQbkeJDGHipobjLIDPdxRH3IPt
 DZHjh81qKAxhmBemw2QvNoDwHjkp8E6/3JrrJjT656We8M0N/+AJHiMdyKjWJjcxAH6fECzw5HO9
 LcHJwlEHRs+Tpbq9HRkg2nuewraipQOEsfVRggR+VzoGl1zUsPlc7mQwg7ZPMCasGwJDtXoEaVkM
 scZXQDUdFbowRIyU7AxBGnQQ3B+mUfd5mqGa+FG5dHJzHuMWRezXkrbKKjIKoxMKUUqPFjuMIsk/
 STKcwAy7HWHDln8r1w/R233IW4vyNZrVsJ2jkXqphz8lxRTFQEkDfRMqlm8kEPLh/2Alur5JoF4c
 0SQ577mNWJtaBFUnisF+0vhR4i6YS8fo6SmUV5nefLuUKjzwVgQIsiIa6xbVMrGk4kLcrqFbeZ41
 a0jFA8GlPjvBjarwSA1w4OBjz948vqBAQyTXHV/7BzAvLvrrhYaYp+SOvs/arcTN80cYPL5y3dT6
 oQSpJADgCQXUsUSwGJuWcjWfHnOVSyJ6VYc3TtRmrTQMuVl4rIkReb0T/gpnYPkOtEYyXDKRuZ+E
 1sAtM+GVNjmUNxkKuVGH9lCzJmNIU2G/lAvqz537gnHPNfvSzT31yvUNDA7R/Pi2ssgcbOXdCsyq
 G1Fd+OkIQvBzrgJ+uTS1Wcqo+kocd4nog5Q9tL25g7L4C5Rft0jP/eLlrXxQSHjP7lvjKGbVsV1+
 Zu7dOU
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 11/37] hw/arm/mpam: Implement CPOR cache portion partitioning
Date: Fri, 16 Oct 2026 17:47:05 +0800
X-OQ-MSGID: <20261016094733.1898485-12-2118537295@qq.com>
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

Add the cache-portion controls: MPAMF_CPOR_IDR advertises the
CPBM bitmap width (MPAM_CACHE_PART portions) and the cache
subtype sets HAS_CPOR_PART, and the CPBM array registers become
readable and writable per selected internal PARTID.  Reads and
writes of CPOR_IDR/CPBM on an MSC without CPOR support are
logged and ignored.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/mpam.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
index cce9355..2b1401e 100644
--- a/hw/arm/mpam.c
+++ b/hw/arm/mpam.c
@@ -356,6 +356,13 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
             return 0;
         }
         return mpamf->impl_idr;
+    case A_MPAMF_CPOR_IDR:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CPOR_PART)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Unexpected read of CPOR_IDR with no CPOR support\n");
+            return 0;
+        }
+        return mpamf->cpor_idr;
     case A_MPAMF_PARTID_NRW_IDR: {
         return mpamf->partid_nrw_idr;
     }
@@ -367,6 +374,19 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
         return mpamf->mbwumon_idr;
     case A_MPAMF_CFG_PART_SEL:
         return mpamf->cfg_part_sel;
+    case A_MPAMF_MPAMCFG_CPBM0...
+        (A_MPAMF_MPAMCFG_CPBM0 + ((MPAM_CACHE_PART + 31) / 32 - 1) * 4):
+    {
+        uint32_t array_offset;
+
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CPOR_PART)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Unexpected read of CPBM with no CPOR support\n");
+            return 0;
+        }
+        array_offset = (offset - A_MPAMF_MPAMCFG_CPBM0) / sizeof(uint32_t);
+        return mpamf->per_nrw_id[nrw_part_sel].cfg_cpbm[array_offset];
+    }
     default:
         qemu_log_mask(LOG_UNIMP,
                       "MPAM: Unexpected read of %lx\n", offset);
@@ -410,6 +430,21 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
         mpamf = &s->mpamf[s->ris];
         mpamf->cfg_part_sel = value;
         return;
+    case A_MPAMF_MPAMCFG_CPBM0...
+        (A_MPAMF_MPAMCFG_CPBM0 + ((MPAM_CACHE_PART + 31) / 32 - 1) * 4):
+    {
+        uint32_t array_offset;
+
+        /* TODO: Figure out write mask to check this stays in write bits */
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CPOR_PART)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to CPMB when !HAS_CPORT_PART\n");
+            return;
+        }
+        array_offset = (offset - A_MPAMF_MPAMCFG_CPBM0) / sizeof(uint32_t);
+        mpamf->per_nrw_id[nrw_part_sel].cfg_cpbm[array_offset] = value;
+        return;
+    }
     default:
         qemu_log_mask(LOG_UNIMP,
                       "MPAM: Write to unexpected register Addr %lx Value=%lx\n",
@@ -538,6 +573,8 @@ static void mpam_msc_cache_realize(DeviceState *dev, Error **errp)
         /* Need to implement for RME */
         mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, SP4, 0);
 
+        /* Cache specific bit */
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_CPOR_PART, 1);
         mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_PARTID_NRW,
                                 s->num_int_partid < s->num_partid);
 
@@ -551,6 +588,10 @@ static void mpam_msc_cache_realize(DeviceState *dev, Error **errp)
         mpamf->aidr = FIELD_DP32(mpamf->aidr, MPAMF_AIDR, ARCH_MINOR_REV, 1);
         mpamf->aidr = FIELD_DP32(mpamf->aidr, MPAMF_AIDR, ARCH_MAJOR_REV, 1);
 
+        /* Portion */
+        mpamf->cpor_idr = FIELD_DP32(mpamf->cpor_idr, MPAMF_CPOR_IDR, CPBM_WD,
+                                     MPAM_CACHE_PART);
+
         if (s->num_int_partid < s->num_partid) {
             mpamf->partid_nrw_idr = FIELD_DP32(mpamf->partid_nrw_idr,
                                                MPAMF_PARTID_NRW_IDR,
-- 
2.43.0


