Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D34CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhaH-0007Ub-0J; Fri, 16 Oct 2026 09:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeXs-00061f-HS
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:48:14 -0400
Received: from out203-205-221-202.mail.qq.com ([203.205.221.202])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeXm-0007k3-PV
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792144078; bh=Je8Vl34WaovwXjpZ6RKU7YgeK1lXyC858OkOtBCiXj4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=uq7BsLT7yNxAS+OAy2ef/WxkjRHjqEBgQr7Hd9M32TOwqVGKdq73FOnRF1oGMYM4W
 MRahuSjdGElTSa73hHrHwxI3yG4/mXZfKvyqfFAQB+W4WRoDIA5Zr1hSOgzyqpanNu
 +imRP+KOMldrnzBtVHXW7MjuC6BhltQlmpftm+uo=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id BF4A1837; Fri, 16 Oct 2026 17:47:52 +0800
X-QQ-mid: xmsmtpt1792144076t36y0hpub
Message-ID: <tencent_83B7D852163320C7882BE1690E1334883308@qq.com>
X-QQ-XMAILINFO: NFhlv/8JdUU2cDXwar4GrmSxC/LsX4PLR96aypQYqeFb/LHxPzs9Lyb33269X1
 InbK5M/6O8INkc0MNAzaStPa8ZpP5BoJYQhtIxOEEpbibtEoLPdypipPDwdV9A0jySfdB351OGzj
 zNA+tR+8PMF3N7i3Kl7RD5oOHg6sN/YFzwd+wWvm137a/++j9HftAJ9ltu5DQdkvHToggTlhc2XE
 eWCI2/lzkInFJka0wixrBsgEK4Jc65pBn3OM4hXSwGEfDkPERjQBTkNASF/gtZ2+HW5lJqMLjwVs
 OrJjE3n/ilolTlPMaG2Ayoe1YhfOYXRUFmbwx+sj36u9lKE2T6JQY7CRDJNjzQAd3MTcuOVIgrAS
 k9iVq+g7w/mAh3ieuHPtMIptpDhsXQoUjTqWJ+c+wcYO4QAVw/FxgTke+Kbz9aTtvLCtaMl0V5sZ
 1i2fdx33sinzCamsGEX72lFl7M857NSagVbmB83FXtpV6J4RO0XEGSTcQy5GkseVb9vkNhfQVglS
 ACygNEnFdJkbZ57wV8GPnnWdVbcLiUUcYac/bLV7gT7Y1BLUb7vxxXxRNPwix4QrCLGFberL4X3H
 g+idY/ye9FG/Lk5RIK9A70Y9QMoVq+Wqif+3xJh43Gg9jieigOpJXauPlTardU36pmrvDZa+5/Vb
 bps1+HCaG2OGhXGuF/vYF2vbEcdytRUrlOFFgxktCAZFbONVkNfoQJc9C3S92K+hpQftAfNEM2qx
 1qYXDPW7CZJ39R+rhmWb1fmrU7ifEfc6u3xVxXrAPBvb5322RiB71qBmU08BUWp87dLqLc78z+I3
 WmKvoCaz/rVQnS6StLfUDOKrB70+blD6CJB+hrFcqSMQeLdsFQF6HytPdQ3bjS3nYZWOWJAmJvQm
 dQ3Ln4MqjmcRite32n7fe4Gs0Xzj+lLsRyWY2Vr/95el3t7UCrEi/nGWJbLU15MDyLsZD8k8Q+AX
 VPnWPqSA4uEQIdkuIyTNve6g0FDtyD+QcxeuvjZMSBP5WCSoAMVbMqgLqV/0W/sBp3Rv/dvH1g8T
 qSY8BZxJEMKPFHeKPXpqoNWkKFAhTcn6TwQSHVEo6RiWRwon447euagMeA6qlVo73UVZKB8hPDjn
 MOmPKL
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 03/37] target/arm: Add MPAMSM_EL1 register
Date: Fri, 16 Oct 2026 17:46:57 +0800
X-OQ-MSGID: <20261016094733.1898485-4-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016094733.1898485-1-2118537295@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.202; envelope-from=2118537295@qq.com;
 helo=out203-205-221-202.mail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
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

FEAT_MPAM_SMS's MPAMSM_EL1 (S3_0_C10_C5_3) was missing, so a v7.x
guest with SME enabled took an UNDEFINED instruction in
cpu_enable_mpam(), which writes the register unconditionally when
ARM64_SME is present. Register it backed by CPU state like the other
MPAM registers, letting linux v7.x boot with -cpu max unmodified.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 target/arm/cpu.h    | 1 +
 target/arm/helper.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 218923a..c60ec62 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -761,6 +761,7 @@ typedef struct CPUArchState {
     uint64_t mpam1_el1;
     uint64_t mpam2_el2;
     uint64_t mpamhcr_el2;
+    uint64_t mpamsm_el1;
     /* Optional fault info across tlb lookup. */
     ARMMMUFaultInfo *tlb_fi;
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d5d96d5..a9b1521 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6912,6 +6912,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_tid3,
               .resetvalue = cpu->isar.mpamidr_el1 },
+            { .name = "MPAMSM_EL1", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 0, .crn = 0xa, .crm = 5, .opc2 = 3,
+              .access = PL1_RW, .type = ARM_CP_ALIAS,
+              .accessfn = access_tid3,
+              .fieldoffset = offsetof(CPUARMState, mpamsm_el1),
+            },
             { .name = "MPAM0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0xa, .crm = 5, .opc2 = 1,
               .access = PL1_RW, .type = ARM_CP_ALIAS,
-- 
2.43.0


