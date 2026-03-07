Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC6CF55103
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 18:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vywF5-0005Fs-Tl; Sat, 07 Mar 2026 13:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vywF2-0005El-G5
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:19:08 -0500
Received: from qs-2004i-snip4-11.eps.apple.com ([57.103.84.93]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vywF0-0005Nw-8q
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:19:08 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 9B4431800123; Sat,  7 Mar 2026 18:19:02 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772907544; x=1775499544;
 bh=+NoH88IZWNOWXHn7XiZHTQBxVxI8RNautRlaqzdVGdA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=FAtwahUd8/Iy0VuH6WHacaWyD9jpN0nSQbGVSXqZpMe1OlFRXBQhaUM+obY0GQx776wRUGfP9H8BCuPRYraM0Fw4pGh1DSwSOshhghJj2aI2RVFipQ1IXgXWuOAI4YmrUj3tHkbZY/anOiBJaY7+7f/MrxZUXrxIDjgmNBL1lnmGIebZoPGE08E8q0xfDfDeWiolqdvF9cs/XEwzcrEHselfV4nk73gSdGtlDXzcIlI6zGl4oIYj3X8NefIh5pYe/veWGsk84YmRUhUpDPtIruycxgMMl11C51F7VjoZnXd467IoCWie2//79O6pMVuVxKEUAU0RvdfsZEarBcNl7Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 4F1AD18000BA; Sat,  7 Mar 2026 18:19:00 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 1/9] target/i386/hvf/hvf.c: fix compilation
Date: Sat,  7 Mar 2026 19:18:48 +0100
Message-ID: <20260307181856.2209-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307181856.2209-1-mohamed@unpredictable.fr>
References: <20260307181856.2209-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: uSrkVuymGfkBnWNOM57bD5Bj1FosJ0IB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE3NCBTYWx0ZWRfX3Hm5TIgk7RIZ
 hG3TLoDC0/A2LRY1/7d12ceX1vKdU4lHwU5uZaZNmppQn3iaCbA2zs3gDOIEggK1Ejgmc5tuGyN
 dw/VZNT3XTIsdXtDNI7pLkbIMupDVN3unYWBBqQzLzmfftHZ9RHHhcoSQgg4g8J/ZA8/0NiInA2
 ry/YQhrm2mT1q7AJ92BTL4Fw4wYum45UIKZedACFBTfPMUTfIoQnglb1FNfKbA0C8nF6LGqiByk
 xQoRkecbaN0SYV37ddQotN+9d3hDDQgZQ66rgIJrh5UduBDhXA8AUfSEkEnL+gViGaEKqI4EifB
 kRLAXvDU4BpVJpx8oo9iHnwoW437RwULi4Tk82sWpX2PuDtvPWRqv31rN+KRxw=
X-Authority-Info-Out: v=2.4 cv=FcI6BZ+6 c=1 sm=1 tr=0 ts=69ac6c17
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=prbQHjbDPxtVlcUdaJMA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: uSrkVuymGfkBnWNOM57bD5Bj1FosJ0IB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1030 phishscore=0
 bulkscore=0 mlxlogscore=975 lowpriorityscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070174
X-JNJ: AAAAAAABB2P8bk2YHS8HE+B2PSL8pIINrd12YK4MRNFdehtb8A6YDhl+XV1qwCeOlrKnTCCx5FD3ZyfV4biZqrNezxbD3OVL6pBk6Qu5r6EOyU1RrRrFWq11q3xGcnoUiCTZfAQNSHszkZ+drMPk4eDJJDsig1Sawa2dT5dKW6kjCISm/GKubn26ftBE1f6EU7a4cE475a/P0NZaD76Keb50NDm3nWYrfD6sHNvdE98UNoYbpfV7wXp0INWgDoX2DUj9EqTlE0gUBpK6xrBIpp++n0L5LyD8qGciambCV0U0LE2EQEHqHMaDNCiX2m74w3XWkev6EaRY4R3sGtoyqVGpa7dcUrhNi24YeJUl9WK+6AqkQzFTqwLU1QlXecdYz3k5z3WZo38u6d/kHsfJgpwtAlgRmiM0am36nVGDPrFCCA+m4Ab5ZosinOLJXYe90Hs76TG/3T9VP9gAXtrPjj4NosBlIzvHVgt8mNlJ6WG8yEZI/oZUO6iyEplDiQQz/V2nGUGb07D11WXPxUv8p2XQXro4qxBdcRX1e+dJVxl0UdOTECw1RQkQHgUUTQgKjTACUYndz9VZD9PBwWozDuV5b4XfMwymBAE8RwqvBUtRkC2LfM3sCLIBb8ova9XHh07JPc/RQDTZAnA8iYlQitSiDYduo6yIjOl0OaCeup8taP8vSdCar+eG1qZhDBuq0j5AFEWJCfOWoDI34BOT9v0pL2l+Vr5L8PQE8b03HZ/b+nSg9lJfeiORDCFfvUHHj/cWBqHf7bx447bFh11QTwPUCN6+WKKDJCfz02h87g==
Received-SPF: pass client-ip=57.103.84.93;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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


