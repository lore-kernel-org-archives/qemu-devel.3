Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F84CCF2C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhb3-0008JP-C2; Fri, 16 Oct 2026 09:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeXu-00061z-Fd
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:48:14 -0400
Received: from out203-205-221-231.mail.qq.com ([203.205.221.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeXp-0007kv-U5
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792144085; bh=WdrxrySbz6u27/kiKDAkrxpedauoXC1uwQh9a2Y8kVk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=w8+WZzijNrconKo9OXkSslpGF2qRpUbo4Lzh+Zl9AXfJgpvpDGpKuYwzv9A/YmFuI
 AbLKBDW8EubNnsZ1wTTc+zF1FyIyqZawdt8YNYB5lyV2BEBEMwe9Ou2YycdfrfYfJD
 vjih8lFSoQgagm3okghwHF9/ptxymzeU5TzrmlY0=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id BF4A1837; Fri, 16 Oct 2026 17:47:52 +0800
X-QQ-mid: xmsmtpt1792144082tajq8s6yq
Message-ID: <tencent_841229DA998C63C495D7B4DB092844DA5B07@qq.com>
X-QQ-XMAILINFO: NRE3CqqEpmvHoNtYfPL6qsxEQQWlsMrbAJGWEJE93PRqrEKcGMR5+kKfJ2mFW1
 gUhSC+8xxnjuiZD80qOP193GlP3/zAB/WQM0ay9H7VTkZuF3HRsq4YCtn56IaPD9qUh+pi8eZ0Gd
 Z2li9M/qL/qUoH5sTtReffKLUgPa9f8tQAflhSfMRxRwaaNrc3jP82/w5YX4Zbw7CRX6VYJfsQR2
 xEihSO/7Ba4fR3GCtDscOYRj8uXggP0cvV/KPn8cYca8phbaZT3KuVYcm0UdNodGM8rmTfWimoue
 3U7Ow9CJVciGy9+rNeEa62UTKfjsQoP6Ujs2/NzWHVl5pQ4WTd1kdeMOXs3hTVMCgi/rNjzT3NH0
 Yf8DJGjAIRolnV9qxlXLVa2RgaC9sCRpssa80GqYF8LlIBP0xa3o0Tf69F6Z8b4NMgj7NOVZqfPN
 FFqLvh3lQHhti/t5iVF3i8If5nNLR/XTNCTBaM+gitfq6vHGbzdW3ZKMpIa7ygxZ/ahD1vRdBScM
 zO9pcEV6KcYwqWzISQYqbJRXFHK6WsJDQP1KhH+HZxklw54vE1NJTAHujI5lmKiWHXeVUYpJzM+O
 tcABn6jhp36FrxJLv2yL6VeMNMqfdlnX6o5FtEYE6qA9mFpFklDzcv30knocDZV4Of5uKIAU+W82
 DVsGfxBt1s3vWXoTO7rVOqKEOB5NsLdRdzwOlbbxgWHCP+MZrep9TGcqspNYlc32cTseU4q/wcQB
 PegtZ4bD0fUUkp+ew3UgBUjD7oaEoXbJSyoQuUgPAy9hloB+TRXa1FuSoIkPILdt/Cw48KdfD3HH
 bN7xDzSZfvGGPQCcY7YZPfUIL+oJ+RzXIVl9sZZGkSpxbDv7lwP81LimiyGlJlswRVauVOEPtJn1
 UT+HPNFExMUXsVYHl1tLrG2DxhBAWbgTUUlnX1Gr2chQ7uTRV++mhdTTHLvUqJ/xOc80j0QZCPc6
 gMzPQEh4Pl5bJoU+ZEKOwnh0FIldGeVTNyCSYgJndS5RKDGDJsaPcpDXVB0mV8VkRZwWoEQ0aS0S
 YSFCXvayhBla2vuwAr2S5+kvrQSVxJcv2u76ztn2dxZQm7rcSK/Iib4Oq1cDgzNL4E7htzwiCR3M
 Y/AQQv
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 09/37] hw/arm/mpam: Handle MPAMCFG_PART_SEL selection
Date: Fri, 16 Oct 2026 17:47:03 +0800
X-OQ-MSGID: <20261016094733.1898485-10-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016094733.1898485-1-2118537295@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.231; envelope-from=2118537295@qq.com;
 helo=out203-205-221-231.mail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add read/write handling for the MPAMCFG_PART_SEL selector: the
RIS field switches the per-RIS register bank (rejecting RIS
values beyond num-ris, and nonzero RIS on an MSC without RIS
support), and PARTID_SEL/INTERNAL record the selected partition
for the configuration registers.  Writes are stored per RIS so
the selector reads back as written.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/mpam.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
index 17ca286..c21a737 100644
--- a/hw/arm/mpam.c
+++ b/hw/arm/mpam.c
@@ -329,6 +329,8 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
         return mpamf->csumon_idr;
     case A_MPAMF_MBWUMON_IDR:
         return mpamf->mbwumon_idr;
+    case A_MPAMF_CFG_PART_SEL:
+        return mpamf->cfg_part_sel;
     default:
         qemu_log_mask(LOG_UNIMP,
                       "MPAM: Unexpected read of %lx\n", offset);
@@ -339,7 +341,37 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
 static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
                                unsigned size)
 {
+    MPAMMSCState *s = MPAM_MSC_DEVICE(opaque);
+    /* Update in the ris setting path */
+    Mpamf *mpamf = &s->mpamf[s->ris];
+
     switch (offset) {
+    case A_MPAMF_CFG_PART_SEL:
+        if (value & ~MPAMF_CFG_PART_SEL_WRITE_MASK) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to CFG_PART_SEL Mask=%x Value=%lx\n",
+                          MPAMF_CFG_PART_SEL_WRITE_MASK, value);
+        }
+        /* Field matches for all RIS */
+        if (!FIELD_EX64(mpamf->idr, MPAMF_IDR, HAS_RIS) &&
+            FIELD_EX32(value, MPAMF_CFG_PART_SEL, RIS) != 0) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write of non 0 RIS on MSC with !HAS_RIS\n");
+            return;
+        }
+        if (FIELD_EX32(value, MPAMF_CFG_PART_SEL, RIS) >= s->num_ris) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "MPAM: RIS %d out of range (num-ris %d)\n",
+                          FIELD_EX32(value, MPAMF_CFG_PART_SEL, RIS),
+                          s->num_ris);
+            return;
+        }
+        s->ris = FIELD_EX32(value, MPAMF_CFG_PART_SEL, RIS);
+        s->part_sel = FIELD_EX32(value, MPAMF_CFG_PART_SEL, PARTID_SEL);
+        s->internal_part_sel = FIELD_EX32(value, MPAMF_CFG_PART_SEL, INTERNAL);
+        mpamf = &s->mpamf[s->ris];
+        mpamf->cfg_part_sel = value;
+        return;
     default:
         qemu_log_mask(LOG_UNIMP,
                       "MPAM: Write to unexpected register Addr %lx Value=%lx\n",
-- 
2.43.0


