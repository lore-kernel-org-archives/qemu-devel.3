Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10861CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhao-0007wX-DE; Fri, 16 Oct 2026 09:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeXy-00066t-TM
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:48:19 -0400
Received: from out162-62-57-49.mail.qq.com ([162.62.57.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeXw-0007m1-0j
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792144091; bh=23heApddqi8Yq+uJLb/ye8UGbMA3otM5Zqfxu6DBkCM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=v0mTTsMknjZBqEVr71ojM2mEaaXZeLKca2h2mwWI6hhw8xEM7WnaKRjRda2eYwZ4U
 ch21d22LtRrIzu+gfF1HvznUN7fMzgobd8L2TjY6kt2wGgRjZWO6WCpthsLKRIgzJv
 /wmm1YIAtEH9Yblev30DP45dpl1F9gCrV9Ltr8O8=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id BF4A1837; Fri, 16 Oct 2026 17:47:52 +0800
X-QQ-mid: xmsmtpt1792144089trr1zyxzn
Message-ID: <tencent_8DD3E62650105B6EF1A4F266B88ED1569E09@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+5/WbLq4Hmyg+zawQ/4etoyCE8XaL9kFBnqs394sajHw+z92xQY
 uFEXalvThofEZlu9caL+fFWzYNCB7FJqrH5z9AAt3hz0+IJmuoWDY+AxWBR1bG7DSojQW1mDz5GI
 VHahX/SIBmIz6KBK3W061Ftu4LwrnZcZg8Qfnr6nzmrit4PdKxsNNb4iKdyZ0fHOXEbLZdeIsH4z
 LM4BqtHN4N9JCiYQ0O9OWlZAukDSoStKiWPFiGx7IX4LvXf6/6fBOebUIkk+cmm0GTMq6+C18lBC
 AF7AYrS8UGt3V2nMX+4pisa/5SwoLU5tLytuNFKxypZDlYVOqqWLBnscFWSjo6cvhVCuPM8vaCF+
 TPR5XfXOT8Fp7V37ICWqQO9GivdK4t5vP1J0Oqg6q820FRauOTkxR1lpQGY7GQGyxTS95+JP0B7m
 kS7JMS3RO/ymuC4YqWQTXbR3I9FIzEIqSz9InO1e/DW6MBCFWkqrqtjXmETtXMCVcwvgHFCjuRIq
 cy8tzHOI9dEdmQ0yWPmI2jREb/YUfssmV5EtDJlg8MtPm4bYvOpzaiqCx2Z+Kl5+OjLZg/lFt9CT
 1t7c4s3kiXkkiE5y3DzCjPP5iNqOzYyt2WER7V4VyCmnSRNv9KSbv2C2chJESCRV7jyPWXtmDWJI
 TMNi/KqU7/J7uCq/wzcNB+IeTnUfsEz5dI5RjuyP19yQvNXV8Nn7/4hC7oRSOF5ZTQP3DTIYPszV
 QzkYsPuptfeqO5e7cOu1RGy7Oz6P8aYn6HPl07x5Ocp4pSDWbi+OI+5wyNXyl0HSw8HLkmTLZ/Ii
 qIudDu8co1IX1UFUAVYCBtm0PGstrI8XF+TGpzIztvPOt/eo5ehFWYxeiCfQUQo8mrBXVTg0H10f
 +Av/AuY7V8FTNKXSmGfxVQe/s56f0CQTnHHuIrTQxivu6tPRDWsltippbrzVGn4fL3OvOjUfv3Sd
 lFAPbiSQF7Fxty8J7jUdffxYbwi4M5KDfsNP7SZuSyWWNk3WqjXblLR2IJp0GR2ImVznY885tST9
 PahsFPDkFq+Y37/dHJCSPvFshJ7PMMe86EsFm0HHX1rhvZdFpOZBc7daJrJQG9Q4v7vWLB8jBn2x
 VqS+ab
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 15/37] hw/arm/mpam: Add ECR/ESR and error MSI register storage
Date: Fri, 16 Oct 2026 17:47:09 +0800
X-OQ-MSGID: <20261016094733.1898485-16-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016094733.1898485-1-2118537295@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.49; envelope-from=2118537295@qq.com;
 helo=out162-62-57-49.mail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:37 -0400
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

Add read/write handling for the error report surface as plain
per-RIS storage: MPAMF_ECR (INTEN write mask), MPAMF_ESR and the
ERR_MSI configuration block.  Error recording semantics, the MSC-
global ESR view and the interrupt outputs arrive with the error
reporting patches.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/mpam.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
index fafe74f..441356e 100644
--- a/hw/arm/mpam.c
+++ b/hw/arm/mpam.c
@@ -388,6 +388,20 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
         return mpamf->csumon_idr;
     case A_MPAMF_MBWUMON_IDR:
         return mpamf->mbwumon_idr;
+    case A_MPAMF_ERR_MSI_MPAM:
+        return mpamf->err_msi_mpam;
+    case A_MPAMF_ERR_MSI_ADDR_L:
+        return mpamf->err_msi_addr_l;
+    case A_MPAMF_ERR_MSI_ADDR_H:
+        return mpamf->err_msi_addr_h;
+    case A_MPAMF_ERR_MSI_DATA:
+        return mpamf->err_msi_data;
+    case A_MPAMF_ERR_MSI_ATTR:
+        return mpamf->err_msi_attr;
+    case A_MPAMF_ECR:
+        return mpamf->ecr;
+    case A_MPAMF_ESR:
+        return mpamf->esr;
     case A_MPAMF_CFG_PART_SEL:
         return mpamf->cfg_part_sel;
     case A_MPAMF_MPAMCFG_CMAX:
@@ -555,6 +569,14 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
         mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_pbm[array_offset] = value;
         return;
     }
+    case A_MPAMF_ECR:
+        if (value & ~MPAMF_ECR_WRITE_MASK) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to ECR Mask=%x Value=%lx\n",
+                          MPAMF_ECR_WRITE_MASK, value);
+        }
+        mpamf->ecr = value;
+        return;
     default:
         qemu_log_mask(LOG_UNIMP,
                       "MPAM: Write to unexpected register Addr %lx Value=%lx\n",
-- 
2.43.0


