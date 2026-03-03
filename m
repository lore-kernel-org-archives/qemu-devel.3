Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E465EDEBF0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 20:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWh2-00060Y-Jv; Tue, 03 Mar 2026 15:50:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWh0-0005zu-Uf
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:50:11 -0500
Received: from p-east2-cluster6-host10-snip4-6.eps.apple.com ([57.103.76.207]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWgx-0000hu-TQ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:50:09 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPS id
 C0405180041C; Tue,  3 Mar 2026 20:50:05 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772571006; x=1775163006;
 bh=+NoH88IZWNOWXHn7XiZHTQBxVxI8RNautRlaqzdVGdA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=EdtEa42+k/Ny5dTUFvNPUFmj93PQzx8ZfkT1cVibctFntw2NjHx8lxboHAr6hEWLtrBwqXchut0eBvJdZoLIXBW7wfLHwxn2/dRTk946f68K8zMpYwJNyzcKpiBEbE0bnCRj99kQilKeI4qa9uKQyOHyfC5IZ5agef2XU8SPZFnUn6XPGq1RwfIAB8V4WXh4VcCybIu2bl1uDaSein7mlYSeCjSPBIeWeZ4qIIxYOu/dd9gDPh5xYRItbjXxNor36a90dN7yqpzqvYZja1pumd2gDm0KqjuGojWCa6yZZJXR5IQ+DC60xa4Yqxi6Cx3jw9MQDPHLTvSMKGFcFqbKpg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPSA id
 AA2DB1800593; Tue,  3 Mar 2026 20:50:03 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Wei Liu <wei.liu@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 1/9] target/i386/hvf/hvf.c: fix compilation
Date: Tue,  3 Mar 2026 21:49:51 +0100
Message-ID: <20260303204959.31156-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303204959.31156-1-mohamed@unpredictable.fr>
References: <20260303204959.31156-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=DL+CIiNb c=1 sm=1 tr=0 ts=69a7497e
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=prbQHjbDPxtVlcUdaJMA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: R-mrFFwMF76EepFwg0o4pI0aP8CGN7Yo
X-Proofpoint-ORIG-GUID: R-mrFFwMF76EepFwg0o4pI0aP8CGN7Yo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE3MSBTYWx0ZWRfXySbD2M6uZip4
 Du1Ch2CvvtuyFRtump1YF8CfnylqF4oeeR2QWbLMUxpINSsKaBTwEJlBb5rrbus/9/3/JqUhnki
 5S0sPY0plfPsS3+LcfokzUJ0KpAYFvaMwKeB09l4V6Kjdo/Q+zShonfCPcmdqjXRQnlYZONNnCo
 udo4+D1GEivCQFDgLl46E4jaSh0Zq+NnopOK8kVKJS1FV8cpVMrfz+ppPlJMLJiZFgVkGuSgG3O
 wLhaUUKy3LpvF6MFyS4tFG8VyCg5E6AUGkyGKF7uQ85rEpQP2opz8NXOO/V83HPF29jZj7X5Gg2
 nm+gSDAm74qxDws004RqwdG2/3Gq8qPRJ395e22ey7LG8D8FzDlYXsdICFyk8M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 clxscore=1030 mlxlogscore=978 malwarescore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603030171
X-JNJ: AAAAAAABaDCuzOb9wPdeANAxxXt9H0cqILnpkJhcAdN7VWrICaZ+psiuVQJNh3ouxmap7Hr+AFk1WmfiJLmEaqitoo493NBdiRl61rRTXPa4CMQZ9S6unxHC4TnhOAGO869bgkagZZ2h58MCoQVGn8ky/eSRW1f8iTqcrRgIXaew4JGE4KNejXELbqdDQHfNGacDaDMeuwGzVKji/IEynLDqyI79ZoFyZDAIC0W+js3LjRFh2Tl7nhuwwAGsQYU1UQ76II+IZfUEYX06q/BJiJvI+G0+hncVJH7aHA9ynmCwREc1/zhM+4QQ23QB6B7XjbQEf/44ETxdUJyVrhG7MbK8RaPFz6OX6eFOyJPv4x8EA0ms3nDf7VOWncX3oKF9M7VDAtHB6CrT6d+gkS1Sy1BJ0Xmq3OEE7OzyzkojKUsAZKJaFXV/UpD2fJREoJt/4xjHzEr9Rdhbpq3s69QTbmcz0J6u4Hk3LjIyoi9U+Z2WP8sbF2+S1dnl78rhfK9XkjeXNeq9qxrKgrgVp7uDAdbZqrUM2HNCh0ZaQ67V07xRUnasDcaGpYZtdU2tLTiBXGAeBN37Vf959clkz2OTD0ADocMmv0a6DZGLQ+sVp53Xv9CGgnyH1Iz5I8d0L1D921cBv1DeNKDGNSv8pfUY7eHgI3FK4XQxyscT0ZbXyQkvO/9BGvxCEys7tuvxiMf+pn/WFcMnDvOyvJmASF8tcDddJIxldwbGyaNJxBbtX1Dzj9k6/6G576jepghovbPFsf5IXpTDVrWLmOax
Received-SPF: pass client-ip=57.103.76.207;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

../target/i386/hvf/hvf.c:476:31: error: use of undeclared identifier 'cpu'
  476 |     X86CPU *x86_cpu = X86_CPU(cpu);
      |                               ^
../target/i386/hvf/hvf.c:479:24: error: use of undeclared identifier 'cpu'
  479 |     env->cr[0] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
      |                        ^
../target/i386/hvf/hvf.c:480:24: error: use of undeclared identifier 'cpu'
  480 |     env->cr[3] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
      |                        ^
../target/i386/hvf/hvf.c:481:23: error: use of undeclared identifier 'cpu'
  481 |     env->cr[2] = rreg(cpu->accel->fd, HV_X86_CR2);
      |                       ^
../target/i386/hvf/hvf.c:486:31: error: use of undeclared identifier 'cpu'
  486 |     X86CPU *x86_cpu = X86_CPU(cpu);
      |                               ^
../target/i386/hvf/hvf.c:489:11: error: use of undeclared identifier 'cpu'
  489 |     wvmcs(cpu->accel->fd, VMCS_GUEST_CR0, env->cr[0]);
      |           ^
../target/i386/hvf/hvf.c:490:11: error: use of undeclared identifier 'cpu'
  490 |     wvmcs(cpu->accel->fd, VMCS_GUEST_CR3, env->cr[3]);
      |           ^
7 errors generated.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/hvf/hvf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index a70f8461b0..c0d028b147 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -472,21 +472,21 @@ static void hvf_cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
 
 static void hvf_load_crs(CPUState *cs)
 {
-    X86CPU *x86_cpu = X86_CPU(cpu);
+    X86CPU *x86_cpu = X86_CPU(cs);
     CPUX86State *env = &x86_cpu->env;
 
-    env->cr[0] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
-    env->cr[3] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
-    env->cr[2] = rreg(cpu->accel->fd, HV_X86_CR2);
+    env->cr[0] = rvmcs(cs->accel->fd, VMCS_GUEST_CR0);
+    env->cr[3] = rvmcs(cs->accel->fd, VMCS_GUEST_CR3);
+    env->cr[2] = rreg(cs->accel->fd, HV_X86_CR2);
 }
 
 static void hvf_save_crs(CPUState *cs)
 {
-    X86CPU *x86_cpu = X86_CPU(cpu);
+    X86CPU *x86_cpu = X86_CPU(cs);
     CPUX86State *env = &x86_cpu->env;
 
-    wvmcs(cpu->accel->fd, VMCS_GUEST_CR0, env->cr[0]);
-    wvmcs(cpu->accel->fd, VMCS_GUEST_CR3, env->cr[3]);
+    wvmcs(cs->accel->fd, VMCS_GUEST_CR0, env->cr[0]);
+    wvmcs(cs->accel->fd, VMCS_GUEST_CR3, env->cr[3]);
     wreg(cs->accel->fd, HV_X86_CR2, env->cr[2]);
 }
 
-- 
2.50.1 (Apple Git-155)


