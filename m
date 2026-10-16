Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB6ACC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhaw-0007zP-5O; Fri, 16 Oct 2026 09:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHey6-000277-MQ; Fri, 16 Oct 2026 06:15:19 -0400
Received: from out162-62-58-216.mail.qq.com ([162.62.58.216])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHey3-00026v-W1; Fri, 16 Oct 2026 06:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792145708; bh=CUj2a2AYTfSAEYBl9krYSC6dbxG0a7Z61HPTvLUXMGI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Y2x+YujYsa/WtpjcqLYLxqHwevuOhPLuZdSdeE6/cvQmOQPsbAlUGMLAvekCKQl/d
 70htMAUf00pDU+qzWZ8XEHei0lGbv9saNSL48vTljuhRdnmCAopIQgvPYZKW8NAEyV
 wEW8ZI9nI5hB+Dd6KKkEF+m79kIMyvNl7w5tfbdM=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id 3C60D8EA; Fri, 16 Oct 2026 18:15:06 +0800
X-QQ-mid: xmsmtpt1792145706tb4q44b34
Message-ID: <tencent_F4EA7DE6EF9866E530AD70A209F1F7565805@qq.com>
X-QQ-XMAILINFO: N4Zryz/ZOxrhT4kCRKg/plEJbO1QFou/ymdS16S3vALlrPblxA9RlhsTwy45oN
 W0U2COMxOlTgnRZUHkGHdhDTF1g3urWJHVL7/eAmHZRgF2xT3iYEVpXpFHMmmxPkDdeqY+0OL1sz
 qeZwSXGE3ewBZ4530zUb8lme091LyBWk2e6jYuRFYTkXnHKxz7jSMklUmIOJf8iD7y5TOx6ffKjh
 6D1XeuzjmK32JFmP7WRDFTgHxI5Vcx59PMY+DPeBzSnDFYeIEx16GRlbne92AvETG8GkFLCICgrm
 89xJelZE7YfDzYxyXKc+EUtwqDGQSjdtEB/6twhGbtirl0x76BGojSSLnPqQm3zIhNxeOX9BjGla
 yvAXHv6nJeuoAxOkGGqbSM1U/lNlbv36PBJmcuE0Y+iSmtpHRnvtY7m+8yUPs6wwAceKz2YVLdZ+
 CwHZPgNDYxgmH2Dlk7KG5vp7aYZvkbx7JSknYeHpPjKXW1+PsSxKt5eEjz1lsIVtfg0AH1PeuAKK
 UxVXQ5tNRZDEVSEGTHmXYLw3dHzGCH+ess05WadqsRglKZur1WF9kFRKAMon5ReYBw2ijecxOT7s
 2brZPmoEpuTxPpdCW2guqcDchv367zgwoj4GGFAZqHLR9rqKd9CJ/MhpvB3GbjdMouhwNZh3wmWt
 CpUgr3NWylh3o5iV01+kQ1tIYUpNvcFPaeKjR2lvDeXPTk/8pPBAdwuTsb+BOhfWyx+x43SZxtIl
 YEp4Rgt0K92NrhRzyMpigLav19y+48ytpWhlDlwkL6ZdG6SR6TjlXv7xJb1WIVEGCH+4LRUlHZBD
 FHiDujbdP3ULBjSmK+M5RQzu2JrQLqYIQ7G+Z9c+LQ0XfO/LzDDA/YzKEpAqdaMdcfvVehKSfYBs
 lv6KlpOrgypkH2klJDWnJuerTkyu+bBR8CIPQalalskDR06DewWpyycZrK3U/Wn4cNvlOZX6pJ72
 b6rw1++8hAeKv24vyqf6xBzKc7Np11zjgL9nADHyEkeTe7S1ow4JtwOxzd7qWAT+IFzuY2+juFUn
 U4DLHldpUTelwaC1U95KeRSKjkHEDcfnykYoKaSZmTBa5ykLBxvP612aUk6iiC/zSauy2zrBXQ6X
 +MWD75
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 19/37] hw/arm/mpam: Add node and interrupt GSIV properties
Date: Fri, 16 Oct 2026 18:10:39 +0800
X-OQ-MSGID: <20261016101058.1900808-5-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016101058.1900808-1-2118537295@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.58.216; envelope-from=2118537295@qq.com;
 helo=out162-62-58-216.mail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:43 -0400
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

Add the qdev properties the board and the ACPI table need: node
(the NUMA node a memory-side MSC serves, UINT16_MAX = unset) and
err-gsiv/oflow-gsiv (the wired interrupt GSIVs the board assigned;
zero means no wired interrupt and the ACPI MPAM table reports it
as not present).

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/mpam.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
index 91d1c31..b484509 100644
--- a/hw/arm/mpam.c
+++ b/hw/arm/mpam.c
@@ -272,6 +272,19 @@ typedef struct MPAMMSCState {
     uint32_t num_int_partid;
     uint8_t num_ris;
 
+    /*
+     * Wired-interrupt GSIVs the board assigned (INTID = SPI + 32).  Zero
+     * means "no wired interrupt"; the ACPI MPAM table reports them as-is.
+     */
+    uint32_t err_gsiv;
+    uint32_t oflow_gsiv;
+
+    /*
+     * Memory-MSC locator: the NUMA node this instance serves.  UINT16_MAX
+     * means unset (single-MSC mode covers every memory node instead).
+     */
+    uint16_t node;
+
 } MPAMMSCState;
 
 /*
@@ -832,6 +845,9 @@ static const Property mpam_msc_props[] = {
     DEFINE_PROP_UINT8("num-ris", MPAMMSCState, num_ris, 1),
     DEFINE_PROP_UINT32("num-partid", MPAMMSCState, num_partid, 1),
     DEFINE_PROP_UINT32("num-int-partid", MPAMMSCState, num_int_partid, 0),
+    DEFINE_PROP_UINT32("err-gsiv", MPAMMSCState, err_gsiv, 0),
+    DEFINE_PROP_UINT32("oflow-gsiv", MPAMMSCState, oflow_gsiv, 0),
+    DEFINE_PROP_UINT16("node", MPAMMSCState, node, UINT16_MAX),
 };
 
 static const Property mpam_msc_cache_props[] = {
-- 
2.43.0


