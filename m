Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF96FF01808
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 08:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQ5e-00084B-Vb; Fri, 06 Mar 2026 02:59:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQ5N-0007nP-0b
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:59:02 -0500
Received: from p-west2-cluster1-host9-snip4-10.eps.apple.com ([57.103.68.113]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQ5F-0006Go-E3
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:58:58 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id
 8A4C018001A7; Fri,  6 Mar 2026 07:58:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772783923; x=1775375923;
 bh=LEFgZ1OOYuBdw8dPiYVuEpb1uHIu9H7rtzkrkhw9XrA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=F3lRgdGi+/dJhuCxltT0+5WuHvjzEhBTaWBKr0LDxJMSRd+d1oYkQmZATLL19zxcri3NVTr+TmM66l+WLF6wVpGtDhC/3GJRlRx4lk5dQUOwCa5yITC1+WcKPtn97f2vHUIA/f9YAhbNy8EKQz2PDWw6foRiAwbB76xWjIpVHRpr1L5R7rTG2jAkKB4kHLhjyFLB9K2owtA2bAvn7qaznXYQuvBfFabhgSwntbL2flyMpcAKz/3zx55Kl7crJQXTuNR+n4buTpw/OiUC0hVIDCcT69w27O/Mg0fESVthfd+TszTu/kdKrrZ98ce8IAK18SjKjrpKsOCxYpoW8w0KGQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id
 3FB071800243; Fri,  6 Mar 2026 07:58:40 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v13 16/17] hvf: arm: fix SME capabilities reporting
Date: Fri,  6 Mar 2026 08:57:55 +0100
Message-ID: <20260306075756.88922-17-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306075756.88922-1-mohamed@unpredictable.fr>
References: <20260306075756.88922-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sNyj4jGDCVbhAJoJIy1qTkKN-34bagaK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA3NSBTYWx0ZWRfX2aEezUDL2Wrg
 vNZDI2Th19wJiqvObhODPe80erblJ8VLi8s8mTykyRT1adnqUhfGwn3zIOkwvIsxe9wj2eBX3hO
 7ZBrtx9Z//9WGlIedS9NcMWwLOT+N6I27RXIcvAwKtVgav0v9udBms94X9Qlx576QdshyWWBxUw
 E+T8ujGLOnNAWgH07mLUs1rxHWYrsO4OMZ++SqS0skAa1qPH6kc4JKS440koKjKTBYHVquPlZ51
 6EsIH6Wtc/ZOMOhyGSGqed/X9Qp8pzB/N4rf8JEj+fP9B7ABz6xJdlqf2DrIORqRo+KThL3REcW
 4rEVonP87MxKigX09NU0V+wAwxZX3v0kLDOU9pkRC7U4XpXGcPmdqYXEa3fev0=
X-Authority-Info-Out: v=2.4 cv=FcI6BZ+6 c=1 sm=1 tr=0 ts=69aa8932
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=-YisE-5-8EYoV4yVs6QA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-GUID: sNyj4jGDCVbhAJoJIy1qTkKN-34bagaK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1030 phishscore=0
 bulkscore=0 mlxlogscore=859 lowpriorityscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060075
X-JNJ: AAAAAAAB86vCyzEu6VMVHXEVmIHB8SVrkcR4Nrff1Q2ahHCqsYGUrMbxoxldbCwgSoOIf2T7uJufJqMi5m7z2ohC5do6X5qafpWxq7a1GK//C9P+OWEJoy4XqDkl8pTi7pWyK0kKYEahMDoiQ9/dMOHaqXh8okfdGd0hL2cAoflp3KGrdruGiDKacjuhHvndqOQ05ph0eSFt0y+1bVUrjFbxpw409zMZStGFgqCCnDtxuAOZvCLxJaanHD99wg8QTnFOIxhDiIKSB8OW3fDpq1Pyy7vl2j/khhWFhjZMVTuX9iUCq+AckcWCgWzU/eLRlCZUJDH6ooGeWAG1L4vL5G00cZA8dluBJfQbqGPtT8wm1QpPewD5LhgH+syW45zI1ixA4QlV0GULhpcGEnKf6a3O6e0GTYFF24gi+6/GMA6aeZRsYAvbBIH6umwwE4nv+8cqghNrlVzPtCpXEnKsCcZIdl/v/GSIQt7a4Rcl27M/D7XfqnHMh3t+Ke7VwT4N3HBWbzWGlFUqxUlguQUEhYzWTw/FdyqG7kZqbeleHLtK2V0htdI9/Z9xq8xM4jgbS/yhUQnv+iK7z+BSwf+ly665dbGEQNzeIG66Sqoj0dPMOCel6Bz4we4YT4LjazIoTznOltTrtuP2N024BDS/75BJOe4+/hRKS+6fpBJ5W8P+ugqagkmBtRr9ecMARqZuSoKCYI2SAZkmoWjVBAjFMgo/MYIZ31oKmo60I/hUOgcWflM=
Received-SPF: pass client-ip=57.103.68.113;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index cb05db2358..b7c5aea505 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1126,6 +1126,15 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         { HV_FEATURE_REG_ID_AA64MMFR2_EL1, ID_AA64MMFR2_EL1_IDX },
         /* Add ID_AA64MMFR3_EL1 here when HVF supports it */
     };
+
+    API_AVAILABLE(macos(15.2)) static const struct sme_isar_regs {
+        hv_feature_reg_t reg;
+        ARMIDRegisterIdx index;
+    } sme_regs[] = {
+        { HV_FEATURE_REG_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_IDX },
+        { HV_FEATURE_REG_ID_AA64ZFR0_EL1, ID_AA64ZFR0_EL1_IDX },
+    };
+
     hv_return_t r = HV_SUCCESS;
     hv_vcpu_config_t config = hv_vcpu_config_create();
     uint64_t t;
@@ -1146,6 +1155,16 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         r |= hv_vcpu_config_get_feature_reg(config, regs[i].reg,
                                             &host_isar.idregs[regs[i].index]);
     }
+
+    if (__builtin_available(macOS 15.2, *)) {
+        if (hvf_arm_sme2_supported()) {
+            for (i = 0; i < ARRAY_SIZE(sme_regs); i++) {
+                r |= hv_vcpu_config_get_feature_reg(config, sme_regs[i].reg,
+                                            &host_isar.idregs[sme_regs[i].index]);
+            }
+        }
+    }
+
     os_release(config);
 
     /*
-- 
2.50.1 (Apple Git-155)


