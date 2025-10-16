Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30DFCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 20:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9UTC-0005Zd-NH; Thu, 16 Oct 2025 16:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9UT7-0005Xq-0k
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 16:21:01 -0400
Received: from npq-east2-cluster1-host4-snip4-10.eps.apple.com ([57.103.77.23]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9UT3-0000wv-QL
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 16:21:00 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPS id
 AAFC818003B4; Thu, 16 Oct 2025 20:20:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=+fMggmtg/uZNHz3nywgemPAlDNuqwqAYkYrWDswgN9E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=P30vWGJ/1TZfumoFmzMjXd34f2HMB8KrduXeR2UMxz8CAMORFSfID2SM4n3Aav+kjshYpp5O7wL558p7RL6pP4OAJPM4V44uRN+DULFxs5D875d2ABgI1js2iUPW/5VKL67in8X1DnG4nn6F9LKXuIMlmUhLeuNJH6DiZczPIpT+2jeOvXhvjtNZTy3ia/BCaZuQqx2D2XchCWkzW6hCIMk5xM9GXJakbGWa5TtHJzgUz6mRWDlMum8qQgi6zzjC1VxFPEBQP48Pbja3ueSQahg0CdtRjRdW62FwRqIGMinAOR3JnMhHE4DmqaY/Nsim0QEHKAcoBcpc721U3NI3qQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPSA id
 A53E2180098F; Thu, 16 Oct 2025 20:20:48 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sebastian Ott <sebott@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v9 01/24] target/arm/kvm: add constants for new PSCI versions
Date: Thu, 16 Oct 2025 22:20:21 +0200
Message-ID: <20251016202044.75261-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016202044.75261-1-mohamed@unpredictable.fr>
References: <20251016202044.75261-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FdfD8WKeQDSyKKCFhmThGPeawK1inu4p
X-Proofpoint-ORIG-GUID: FdfD8WKeQDSyKKCFhmThGPeawK1inu4p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDE1MSBTYWx0ZWRfX5v+N+fUq3pEv
 ALIMjnWxkIuLxXqDjJeRN6n35E2yjkDKa6H6yMPIQ04YbUAL85besgWtJbMh9x58+qyOmCHGTKy
 FPLwL2yrzD/nkrO13AfsY8RNTQT/czJrgPBhiJtr9EttRKyLracfZADPxxu5LQ31tBxEmewvvEr
 IsYjqOl7RJ99PMDWNgbuzOfcG7apt/uQw14ALAbDVGqY0jOwqIAAbezGnAoFWUcSteaJ9KHoOSH
 6E7rrNKk1zWQLCag11YvMlF1D4SuYwmCKShHTE5UVY+lQeXZY1tiBrYPVpdg24Vo6KTPLHGJU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1030 malwarescore=0 mlxlogscore=879 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160151
X-JNJ: AAAAAAABPfxx+NljuqNd6iPCMobrm77Vf34qAizAo028ncM3DGwnV263TJvuUg+HdVBVHhoEGTGG5U0Q6Uwwmm91ntLI/itho9s3G+NKTWrPybsD6h5PuaZD7mmpdsbQWwh0rZBJqYiGhBjgdAbGtFHKmNEYlKh7rpd6rieRnpse6iLPNX+UaP+EvZSBKYdDxUCAGCOOIbpEPzK+Vrwdn3Jvr9Gu8hiGvmIrpIuzyRYTHhe0XP2J2Lf0CtKR7kAhpinjmFjDdl7gfQI73SHpgDNzcA4G+6tSihYiw7oklwX6iG/obd9EvNpQaQZzeBZw8CE7gu1cmKCy8gR5bdFn5eyPQR63k41adpX5JEoef1w470hZkfp4FJFlRxAWoReRsxluJqli1ehLwVD1jyGMJdc4q5IABYb2AFbkdAWvIqt5GeF/rjdasNRTd+Kz8N3I943oxeY5FDCCZ69UmUDP5pfGeBp/1P1WsL7t6acp0ZDuDShnnGOf3DnZcIBsevKSxvE7YLsclCq+MZl400bBbWGm6hza+iaqGSfa7Eh7bSX7P7Dmh5JXDexYO3taqGTywaz/8VvxAxjh1NE86djTxmmw1a8mrIlfC8Dm4lya2f6uyQWQ7IbPTvPO2aeMH/RbPSvC5ZXIowhM8/vo5e97+27z6Yat9UbbsZQ/ZS190cP9g5bcDQE91e5e4yYZylq3pXCcO7sp
Received-SPF: pass client-ip=57.103.77.23;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Sebastian Ott <sebott@redhat.com>

Add constants for PSCI version 1_2 and 1_3.

Signed-off-by: Sebastian Ott <sebott@redhat.com>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm-consts.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index 54ae5da7ce..9fba3e886d 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -97,6 +97,8 @@ MISMATCH_CHECK(QEMU_PSCI_1_0_FN_PSCI_FEATURES, PSCI_1_0_FN_PSCI_FEATURES);
 #define QEMU_PSCI_VERSION_0_2                     0x00002
 #define QEMU_PSCI_VERSION_1_0                     0x10000
 #define QEMU_PSCI_VERSION_1_1                     0x10001
+#define QEMU_PSCI_VERSION_1_2                     0x10002
+#define QEMU_PSCI_VERSION_1_3                     0x10003
 
 MISMATCH_CHECK(QEMU_PSCI_0_2_RET_TOS_MIGRATION_NOT_REQUIRED, PSCI_0_2_TOS_MP);
 /* We don't bother to check every possible version value */
-- 
2.50.1 (Apple Git-155)


