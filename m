Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91339F5141C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytmL-0000i7-3Y; Sat, 07 Mar 2026 10:41:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytmH-0000gt-0B
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:41:17 -0500
Received: from qs-2004k-snip4-11.eps.apple.com ([57.103.84.113]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytmF-0001uV-Ed
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:41:16 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPS id
 0CD081800A8C; Sat,  7 Mar 2026 15:41:10 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772898074; x=1775490074;
 bh=+NoH88IZWNOWXHn7XiZHTQBxVxI8RNautRlaqzdVGdA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Y23r2EG39LyxkyLoIR/+z3jnCquCa7SOERCabDpZxurrpIzDJTwosKfHKmUCCwO6Ba4VCv0H4bBfDMpOX2efUWypfVO5ibsEKJanHg8pgRPyokA4nm8Pb35+paaEb/sFpyTAPMGxroW8zRH5zVsAhYX2iLwJyEjjKT/9wUADoaVtcJXGM+wQLkCv2dO5XKMHvz8ku9Poo28B7QBFOQ3X8XB1CbdZ1yXbP/tKi1ZInIOmdMuTMm3v7xDXaAgfxL+vxY5T5ka7ORZgvVEfojW9Z7kht6iUq90cBYeZE8tI/4AqDAXdAy6jzR6t+MI6x0OlDL3bKmQ5S3JJdzB2nkUirQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPSA id
 618A8180089E; Sat,  7 Mar 2026 15:41:08 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Wei Liu <wei.liu@kernel.org>, Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 1/9] target/i386/hvf/hvf.c: fix compilation
Date: Sat,  7 Mar 2026 16:40:56 +0100
Message-ID: <20260307154104.84567-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307154104.84567-1-mohamed@unpredictable.fr>
References: <20260307154104.84567-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Br5hv4kUyTGacZ4R-mybtFcNc1tXxyWb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE0OSBTYWx0ZWRfXzQsMxclCsRgP
 Nez6D5ZQh7nBUGHOHkb6Inthsbj5COSA7AKuKNz6Na3zDogAC8CbvSEZePPjqXQyJS176A+VXyi
 6sO/kqF3fBSEWJCNrlfk+oHwictq+uEpjJ4WiAU7dfcMPMoSfYA+VOTDoVrvRVdT3soOEbqSsAW
 YRdJrAmEO8tPehasCpN8253whoieGK4uRg5hnQlU49R+XR6IJ0G6+i/IZC8JiWNSCgWPY4Smvyi
 hklWg5N+YkRdie7QxWY+qEhXkDN7PH0P6xAL0JPCJCgVV9E5kBnQYNv1ZdYftO0DsmsiMkRps11
 mttVpCzh+oWpK0/CWZ/vN87Oxa1Iu51Q2r6jsrgPT51sg7whB9HiP6/9B8VE5c=
X-Authority-Info-Out: v=2.4 cv=FcI6BZ+6 c=1 sm=1 tr=0 ts=69ac4719
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=prbQHjbDPxtVlcUdaJMA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Br5hv4kUyTGacZ4R-mybtFcNc1tXxyWb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1030 phishscore=0
 bulkscore=0 mlxlogscore=975 lowpriorityscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070149
X-JNJ: AAAAAAAB2si0L1mH7Gwh7fHTGZqa89095+ufJf1IH9/qUVJ7/1g5VWBgWU+BGVMZuq+KZaKnp6QUQwOz/C9wF+BzyeKUWKfEsyYOdvl3NL4vdQ/5YlIrGbIeu7045ZSHXKpqk54JqhvRPSwrPEOb7iuAJcnbEeWosZChvewfQe2gwaeMQGznM/hhopQZCYENSgq0KqB49VoV8u5/o3VUGZ5p1XCO6Cdu3yH+Y3dIN7bYlwYdD/uT4qXTJb4Acn4g5jggKpS6fC5tAF9mPx10Eru/7KWu2xfKS4atDm+Qek3kOCW1KkSfaDgXTn7XCxWqf/aNB3hzabbNyEPw33OyJskXnNz8dugkrJV5oWmglH31WuXhTRAxYYVbRdCzjSv7z34hzUQXLdZqUtJNMnFMX/PYIRA7ay9cbIf3sqGX7GNFBwuU4z4Av2ynmSfqxZIZ48KRpY+BSzi7y8h5iv3NEjQZXHBn/y4cZwPxX5eK8ukNbx7kIqKFLT1Rz0nU1LcuWM4sgnmCxKRhf21opscgSUL+4iqr6RH1FJZL5aQn69+rti3EvcKRbvMRKg0QGy0feypJMr7bplor0/vR717y9fBbacroOcPFaDSd5DupYI6+TIwr7oPQlhmzcEYKNneNYoD0alLaWyWcizBINAXANGp3wJP+C4PZXElCbVoHU6asTR6XT7V9RW+oS3wH+GYnARyOQP+MfoUKJnPEAyVoo41qJMeUFrIXxZ1rLzMBlzyloFA/DzyEX+L0KDFYdwMIRlyTFyZdV6BA3XFewLspFzf3eTZyY4ZmpyKsJBG2iAso2g==
Received-SPF: pass client-ip=57.103.84.113;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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


