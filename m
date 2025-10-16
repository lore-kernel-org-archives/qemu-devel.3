Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A335CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 18:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9SyJ-0001uj-SJ; Thu, 16 Oct 2025 14:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Sxz-0001ju-Dj
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 14:44:50 -0400
Received: from p-east3-cluster3-host4-snip4-10.eps.apple.com ([57.103.86.43]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Sxo-00028Y-P4
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 14:44:47 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPS id
 5F9C018004C2; Thu, 16 Oct 2025 18:44:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=oFfVBa0udOCE/o95fatBC5yS0H5jQ+cldNGamZUiiDs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=cRIhEW0XeH6rjX2grh2hVDWOrewL3EaeiYRf+Ve9UtMKqDN4XIAd5LeEeJR0r+OgTp9W2kaOnc/Cl0IftuJeJoTeGSdkzTGMgEjne7k5VKKqUAVJp1aMbT6rDsgICunyXHkFD99uofXGh9JKaR4UUy2eL1q0bqhhZouSxZzZS9ELbersmQfqmtnAPFa3CQ/TAfbVjwidpVZocWu8xfiUUtlqH+VpEtwBUgCjJTIN4Hu2XxjkTgHQcTh51xhGFikNjAsdz4LfqUwG0Hit34RIWgSSzigUzIFZOPKxzgRVqCIili0FDa+qvxPu2ElmYd7RpGvGICPUFi1WqTNz6gbqjg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPSA id
 9FC8218004D8; Thu, 16 Oct 2025 18:44:26 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Mads Ynddal <mads@ynddal.dk>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 22/24] whpx: enable arm64 builds
Date: Thu, 16 Oct 2025 20:44:11 +0200
Message-ID: <20251016184413.69870-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016184413.69870-1-mohamed@unpredictable.fr>
References: <20251016184413.69870-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aDYTq7ILJflezNIvps_AiPBfjdQnX9sQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEzOCBTYWx0ZWRfX8FIqlHpykta/
 Q/2x8GeYq8txm/miIeSZxGFBHwJykp3xxPoETHTpKo+DzdrhRb6BD1tEqVfg7XRiB+AhxNbSTV+
 muA7VdRHrMJRsRIpRohJnzoi0DTXUW3PIn6lWQCa6DwD6xOO+RKF6Wc4iCUxm7saUoEW3+PuHg6
 oYoFZ8xYIlQDa8LXZT/WISCdtOHbm+FehgWDx0bMLB0WccYXAIvyMVtR1d3XN2igDrXkxsCEBRO
 XgACeg9lLfLCZtiwlaVuQw0zRJ4cM/uSlj5eWLO1s6QRzzTpT7ps+iMtuU9DgiNP7Nxn4neMQ=
X-Proofpoint-GUID: aDYTq7ILJflezNIvps_AiPBfjdQnX9sQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 spamscore=0 mlxlogscore=730 adultscore=0 suspectscore=0
 clxscore=1030 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160138
X-JNJ: AAAAAAABt16rXmt9QH+U639acW6uAAUTfur5+4wo7hXKZ4G7PXm8QzPis55fnFdEnk+AmJiAXXNkLUg7kHxG4sq7nboHaM+uO25iV2dJl4mhvidz5/P41pWUfychwVcXCWjvWjkql1M/7l+ngyQoKx9YLWxJDsntAKUBS+b9R1E9i6UCr/FmjhWwpawD0r5kiEnvBmgTqzHTL+m+sHPFL3o7WXF5OaGdX6wV/JUiCWxslNi/Ij9Vm3iqwmHNamFvLiVq8i3UAsqmRINydM1mxgwE0GgNZzJxSFNfRsbb3Ar86TwM50jo+EpjMGsoL5NBoNGHqdR6MWTpsHTxfUSsDfG86YIiqQqlocPbGqP4J0Zhjf+xtq/qyzoyKEIZ3H6fDUKBrZcRJtszpZs5M2erxu8QobfVTDQ1yOR8JS0rfhZlGxZLbJoIP8Wi5c8AXSKgtZYQ/yyLFeojusiom5q3z/bOO21H5hgDQ87jt53fKegDFzMhxbtt9H0N8SansbKRn5zRdsmh30TqjKlll27bu4vMR4fkJxPQeNHp/Tc5ohxdcK5qSfZZ3mjrQKiymk1pkF7wd2RSN0IaaMgi0n+c38OMVcu3HAX7bNILTZw2M3hlx2jYSjoZpv6OkCDledqgN+r8Nkcr+z8p2Af7ORyTDTysSM2PI2YhKlf65gD3hisfVegvNI6fA9VOpIJMHJQewQ==
Received-SPF: pass client-ip=57.103.86.43;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index afaefa0172..51561ce020 100644
--- a/meson.build
+++ b/meson.build
@@ -327,7 +327,8 @@ accelerator_targets += { 'CONFIG_XEN': xen_targets }
 
 if cpu == 'aarch64'
   accelerator_targets += {
-    'CONFIG_HVF': ['aarch64-softmmu']
+    'CONFIG_HVF': ['aarch64-softmmu'],
+    'CONFIG_WHPX': ['aarch64-softmmu']
   }
 elif cpu == 'x86_64'
   accelerator_targets += {
@@ -893,13 +894,18 @@ if get_option('mshv').allowed() and host_os == 'linux'
 endif
 
 if get_option('whpx').allowed() and host_os == 'windows'
-  if get_option('whpx').enabled() and host_machine.cpu() != 'x86_64'
-    error('WHPX requires 64-bit host')
-  elif cc.has_header('winhvplatform.h', required: get_option('whpx')) and \
-       cc.has_header('winhvemulation.h', required: get_option('whpx'))
-    accelerators += 'CONFIG_WHPX'
+  if cpu == 'i386'
+    if get_option('whpx').enabled()
+     error('WHPX requires 64-bit host')
+    endif
+   # Leave CONFIG_WHPX disabled
+  else
+    if cc.has_header('winhvplatform.h', required: get_option('whpx')) and \
+      cc.has_header('winhvemulation.h', required: get_option('whpx'))
+      accelerators += 'CONFIG_WHPX'
+    endif
   endif
-endif
+ endif
 
 hvf = not_found
 if get_option('hvf').allowed()
-- 
2.50.1 (Apple Git-155)


