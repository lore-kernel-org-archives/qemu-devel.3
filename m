Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A40ACCF2C3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhdF-0001i9-4L; Fri, 16 Oct 2026 09:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHeXq-00060A-Bu; Fri, 16 Oct 2026 05:48:10 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHeXl-0007jz-Gf; Fri, 16 Oct 2026 05:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792144077; bh=YI1uTqwk6PgPa+hxwugkU+IJlKdvsHWkdlHjHmZxlKA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WCpwYVeMYzsXDnoTvP2iC7aGJu96dKV8F1iutBeZ7v4STAQ6LHJLBr2KYtIFxDEwl
 pjySy6LAr8EvwjbQEXR5BdnTlDQnPc5rv0qj0wJF2yk+EZ9XLSTFReNdElF2RUi2oL
 kX574cTyngqhsCyg5l7QTW9SXaoh7WHIu+T8V0Gs=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id BF4A1837; Fri, 16 Oct 2026 17:47:52 +0800
X-QQ-mid: xmsmtpt1792144075t6er0iz2l
Message-ID: <tencent_44485284331CC7902B6C69F413CC882EB708@qq.com>
X-QQ-XMAILINFO: OKOirRU4nj6hIs9I8I91mvScjlibRL7iyLA5H5Jmq8YxBn417PVsbQ1PmBlFqS
 VJxjPlHFupsmfei7LvVa3Vb5i+tKtJ4L2IfxpgvXRNZmGvr50Q6SQ5Q+p7IpC2XSdPiyCXkb6G1J
 ObyO9OfA7lZUhbeDOzNYYo9UcGO9B/HR4yuptAThEPcKztEHV/aPY/2+RH7RzaPqQYwPHqIx+cQG
 iVU8kPkn9ErAbG1TZ816DgX1yN/UU7PT8PYQF/WIHvB1iXEbQXH9i3bIGnRXlVRlH0neR4wbxPLd
 4awh8xqLVFa0cTZMTKTQkw90g5pMRSIQnjeuYyDYmJjgh9J0ETkaVh5R7AvoNjZYeAwANk7rhU/r
 KS8cR87qO85GN+9PB5vLk+Nu14EpSk94Wlu02bP1fjfbGVT8baPiZ94oWPV+EoXBuB1ZeJS5BZqE
 b5lBE6HiMcptFMR2Xx7l7HxG40Pu99nPJl3R7+9rjIP/wE05UYT8P+wgJiZBTNroEPnoPRyjotOz
 yQb+FcKmbuDkQ/FPSaxUnL+CFrC7v7LDfUx+jAge1XhgsKaev9PqerCktHOMGI/CHUHy4TKTWR5w
 a1EEPo2zUfzoy0VJbh2RuWSuqnoxmtxAXHuP77C4Vkd3gaHemAyV5P+sg8YngFv7VrCSH+M6kM65
 f4Xb9tlrEQBSR9cpxyyZ2IqMykG5q6rbifYXtSUvqsyWyyTwdae2HnjVvOzr6ctffSo+Ok0H2jo5
 aZ9xBLeNg2RZpqqSi7FNEg55QQO8ozzTjsuU2FjXP2ZrtjHtAHrqDdUQbIYHdycxprvE7nmvD5Gx
 3g1Pe4eZQfK/42H08xpUDmjshL48ChGUIE+rNgiyNRmKWrxI3qv0Tz0zu/+ncpAWr7l6Lt8CACg9
 A72172wY4h0/z74v1KUIWvuSqiZhwApd8BubDmTax8oQDH7vOWEwUsR2FNmMhKpkufUqRUiNZaVq
 l3JHm68HcvFNJ/3hKbbcC8WgbSZnNjyjiy9pRDQhumSg04fxsnttjDXQC2yRJ8SxpXvvhDjJTabU
 V2Q1P3jDcfMEgO06icEK5XzqrSGZWqyy9kQfrS2A==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 02/37] target/arm: Add MPAM2_EL2 and MPAMHCR_EL2 registers
Date: Fri, 16 Oct 2026 17:46:56 +0800
X-OQ-MSGID: <20261016094733.1898485-3-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016094733.1898485-1-2118537295@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.54; envelope-from=2118537295@qq.com;
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
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:22 -0400
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

FEAT_MPAM's EL2 registers were missing, so a guest kernel that owns
or drops out of EL2 takes an UNDEFINED exception the first time it
runs its MPAM capability enable callback, which unconditionally
clears MPAM2_EL2 (and MPAMHCR_EL2 when HAS_HCR is present).

Register both as normal EL2 read/write registers backed by CPU state.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 target/arm/cpu.h    |  2 ++
 target/arm/helper.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 51a36fa..218923a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -759,6 +759,8 @@ typedef struct CPUArchState {
 
     uint64_t mpam0_el1;
     uint64_t mpam1_el1;
+    uint64_t mpam2_el2;
+    uint64_t mpamhcr_el2;
     /* Optional fault info across tlb lookup. */
     ARMMMUFaultInfo *tlb_fi;
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 896ac0e..d5d96d5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6924,6 +6924,16 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .accessfn = access_tid3,
               .fieldoffset = offsetof(CPUARMState, mpam1_el1),
             },
+            { .name = "MPAM2_EL2", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 4, .crn = 0xa, .crm = 5, .opc2 = 0,
+              .access = PL2_RW, .type = ARM_CP_ALIAS,
+              .fieldoffset = offsetof(CPUARMState, mpam2_el2),
+            },
+            { .name = "MPAMHCR_EL2", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 4, .crn = 0xa, .crm = 4, .opc2 = 0,
+              .access = PL2_RW, .type = ARM_CP_ALIAS,
+              .fieldoffset = offsetof(CPUARMState, mpamhcr_el2),
+            },
             { .name = "MVFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-- 
2.43.0


