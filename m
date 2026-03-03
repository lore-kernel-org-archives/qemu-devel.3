Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F638EDEBF0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 20:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWig-0008Rw-HC; Tue, 03 Mar 2026 15:51:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWib-0008Cw-0k
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:51:49 -0500
Received: from p-east2-cluster4-host9-snip4-5.eps.apple.com ([57.103.78.216]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWiY-0001V7-H1
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:51:48 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPS id
 BED3C180015B; Tue,  3 Mar 2026 20:51:44 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772571105; x=1775163105;
 bh=+NoH88IZWNOWXHn7XiZHTQBxVxI8RNautRlaqzdVGdA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=AKJmE2RacTeb83Jv/I0hCFjdBrv5Gq2SY63QlPZ9xyEtypG1nylE6aCZbiJr1mRREEfKdbRSPPuGxMN1T1O6BfYnd0EBGc/ApzvDohrZEkAdnJX5lb9XIgHIpn3Er4W72BJ3ZVZNjFK3wVpuL9ppNW9q47TAE5ShSZqFo+LJwX4X5HuQaFV2VMYfrj/KTLe/98+KxlP3OlSkv3wQMZaEZLdHCqEDaG44q92LEgXmqEIwgBYReuNS5C6+bEh/cm9jMYgpDkD75HNMtC6FuAOutxINiu3Hz9mmMUX7PKmZgRsVLWvM0pMKTtDolvJuOCa7OQgRruvtRt5QTWj9MrJ7Xw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPSA id
 E48981802BD2; Tue,  3 Mar 2026 20:51:42 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 1/7] target/i386/hvf/hvf.c: fix compilation
Date: Tue,  3 Mar 2026 21:51:32 +0100
Message-ID: <20260303205138.32450-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303205138.32450-1-mohamed@unpredictable.fr>
References: <20260303205138.32450-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE3MSBTYWx0ZWRfXxqBqYazqw4Iy
 7qC5K3ZCI59KeNJKSTTyyY/rBwuRK3gcz8qP+lv2NGVJPsewcUs2K2r8r0u4+LbOBpdYFIogbHk
 eswW/FZ/MXbwSup0EYiE6O9prtDhZUwmrk0jjrYZYTay03/rs3FZMhgXKsZ956tJBPbnHqpThji
 UZnFGHa3GptOuf8kbtbk7e7FaWYnj9oAkhVDyGzQ9GMsVnJwhyKgKLIp7i8BPQGH03Fn2MPOr7D
 17Tmj/LvERJwoxzqu/vzIIsn9nRkPQAYVcrWQlV8ZaAL0TaGer4P2CG5PSXvBmT4FGyeyono8kq
 lduUYtRhZy0wZ2yuCA4rfM5hwLmQtfZBslBHs6q1S9QqD3reLp4JMY3UTaxmss=
X-Authority-Info-Out: v=2.4 cv=e9YLiKp/ c=1 sm=1 tr=0 ts=69a749e1
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=prbQHjbDPxtVlcUdaJMA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: yfvEAfUO2aeZcOZQGtyey0ulgY2CCbDk
X-Proofpoint-GUID: yfvEAfUO2aeZcOZQGtyey0ulgY2CCbDk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=978
 mlxscore=0 clxscore=1030 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603030171
X-JNJ: AAAAAAABmbzDcrHbdc4NUZ70zzgtoVvVdHPxewZU/B7dfGTIDUF+s6xbGP00TwDdsLr1+UgsPhp0FKgmnR6R4nB45khHtWZ4o+7WlHPQ1WWs5AS+IXo+B1eFqgZy7/OoEoJex6UB+6gxZBoEMOTLK9a//kpmf9Iz3+ykNsGrXEp9cbm0rXMMQzJj1RFYoVvPBDbf5RzrcNLomjkL2ruj2bbfNQogFz/6avslDa0cWhmO/IvlHxkynCmsJ8BgDXW6b9Kjz6lT7/0muwG6dUIP0wBM4bAMUMLNOaBucDVVN8pQISIe7uX5RUqhNzo2LIz2ssEUO3WaIo3woywRAnfjF3FwO4HEk3K8Re6HWdtmSS/hUzKc7KnXTee2DQf88Jhk27nGx+NP5uTAdlfi0xy6yn8EYSstNo0i3FhIZ+NkqGjWGprLi9E/3Bptl0yTuL0VODNchM8SjAjMmXbT0+zia6MieZwJiUW6tajzHSJ2XHEYBvOf7zGxjTi+YsEqVpab0VAEunLlvJoyV/TcG/qPuXvRyJ4yXer1/irw+r87JJss43PtrGCXkRlX30s59FTKRuusNcBs27KYK6ZVX6wPbRz60zKe1MMXOZ4ihs088a42CBkjEHFOSmD/W7fuIz2EffGDpimKec3g1pp259NLCAgPWXGrQHz1musuBdObfiwwMJo7lr3POPk3ZhTR1KvdXCkXUOiZL4rs/U+QNzhjqXxnH/RYZWla7cn68P4J0CbjvtcGjBhN+BXqYtEdgOhZEXekYvRAFpoCxFxQDwQ3MN0=
Received-SPF: pass client-ip=57.103.78.216;
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


