Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450C4C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 19:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJzpV-0003wh-T3; Tue, 27 May 2025 15:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@icloud.com>)
 id 1uJxH1-0005jh-Mn
 for qemu-devel@nongnu.org; Tue, 27 May 2025 12:35:32 -0400
Received: from p-east3-cluster7-host7-snip4-10.eps.apple.com ([57.103.84.201]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@icloud.com>)
 id 1uJxGr-0002IC-Mz
 for qemu-devel@nongnu.org; Tue, 27 May 2025 12:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
 s=1a1hai; bh=Kgc1eFLA775ubmbKqhaqEzJUCp1tDihVnBuMpuR064g=;
 h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To:x-icloud-hme;
 b=zyqQTGB6p8SYq4h4NQb31K+2mQhwZ4VVCNY9fH/Wu5C4sDLxrhXNGws29JKxTu3Fm
 juBmYmaQLVYN4z4mLiXVnaDe1rgnaQhQI1ui5VxbrbQSrZYNCYni0zH4XMApo5To0t
 cShFOP6B1sDGL7olJLKPLvzLpZibtmL+Dw8ptRsVXs3wJcbYEt6Yg4UETZ5HycX1QM
 ffO3NSrN+C6Xe34IdBf2ISMEBFHRlebM8wSg6vKbyaPUuSiOHHp+0CopJuRUxqFK+g
 xy0F9N+/fWeAkaQfDxpsY8hxDA/utQnfG/sLn/1RJPtV9CfGCmnWP0qavf88R8oiza
 A85dbds0tBWRg==
Received: from outbound.qs.icloud.com (localhost [127.0.0.1])
 by outbound.qs.icloud.com (Postfix) with ESMTPS id 1CB1C1800418;
 Tue, 27 May 2025 16:35:11 +0000 (UTC)
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by outbound.qs.icloud.com (Postfix) with ESMTPSA id 7379F180051E;
 Tue, 27 May 2025 16:10:59 +0000 (UTC)
From: elisey.konstantinov@icloud.com
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: [PATCH] Revert "i386/cpu: Set up CPUID_HT in
 x86_cpu_expand_features() instead of cpu_x86_cpuid()"
Message-Id: <0C532D10-33ED-41F5-BBA7-13C64AA0633D@icloud.com>
Date: Tue, 27 May 2025 19:10:27 +0300
Cc: elisey.konstantinov@icloud.com, pbonzini@redhat.com, zhao1.liu@intel.com
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-Proofpoint-ORIG-GUID: Tx6S_xx93UKT5yZdXuEzfVQzEkCnmZB0
X-Proofpoint-GUID: Tx6S_xx93UKT5yZdXuEzfVQzEkCnmZB0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_08,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 clxscore=1011 malwarescore=0
 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2503310001 definitions=main-2505270136
Received-SPF: pass client-ip=57.103.84.201;
 envelope-from=elisey.konstantinov@icloud.com; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 27 May 2025 15:19:15 -0400
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

=46rom e2f3eab60e9b9787c5c8f87bea5d1bd7079d982e Mon Sep 17 00:00:00 2001
From: Elisey <elisey.konstantinov@icloud.com>
Date: Tue, 27 May 2025 17:17:35 +0300
Subject: [PATCH] Revert "i386/cpu: Set up CPUID_HT in =
x86_cpu_expand_features() instead of cpu_x86_cpuid()"

This reverts commit c6bd2dd634208ca717b6dc010064fe34d1359080.

The original change caused a regression where macOS guests (XNU kernel)
would panic during boot with a divide error (type=3D0) when using SMP
configuration. This affects multiple macOS versions from 10.6 to 10.14
and possibly others.

The issue occurs during kernel TSC initialization and can be worked
around by using single-core configuration (-smp 1), but reverting this
change restores proper multi-core functionality.

Buglink: https://gitlab.com/qemu-project/qemu/-/issues/2933
Tested-by: Elisey Konstantinov <elisey.konstantinov@icloud.com>
Signed-off-by: Elisey Konstantinov <elisey.konstantinov@icloud.com>
---
target/i386/cpu.c | 15 +--------------
1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9689f6374e..c648a1cf04 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6859,6 +6859,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t =
index, uint32_t count,
        *edx =3D env->features[FEAT_1_EDX];
        if (threads_per_pkg > 1) {
            *ebx |=3D threads_per_pkg << 16;
+            *edx |=3D CPUID_HT;
        }
        if (!cpu->enable_pmu) {
            *ecx &=3D ~CPUID_EXT_PDCM;
@@ -7838,20 +7839,6 @@ void x86_cpu_expand_features(X86CPU *cpu, Error =
**errp)
        }
    }

-    if (x86_threads_per_pkg(&env->topo_info) > 1) {
-        env->features[FEAT_1_EDX] |=3D CPUID_HT;
-
-        /*
-         * The Linux kernel checks for the CMPLegacy bit and
-         * discards multiple thread information if it is set.
-         * So don't set it here for Intel (and other processors
-         * following Intel's behavior) to make Linux guests happy.
-         */
-        if (!IS_INTEL_CPU(env) && !IS_ZHAOXIN_CPU(env)) {
-            env->features[FEAT_8000_0001_ECX] |=3D CPUID_EXT3_CMP_LEG;
-        }
-    }
-
    for (i =3D 0; i < ARRAY_SIZE(feature_dependencies); i++) {
        FeatureDep *d =3D &feature_dependencies[i];
        if (!(env->features[d->from.index] & d->from.mask)) {
--=20
2.39.5 (Apple Git-154)



