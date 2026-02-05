Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B453EC1EB3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 13:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnzB7-0001Cn-4F; Thu, 05 Feb 2026 08:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnzB5-000196-61
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:13:47 -0500
Received: from p-west2-cluster1-host2-snip4-1.eps.apple.com ([57.103.68.14]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnzB3-0001mN-MM
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:13:46 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPS id
 64B57180015F; Thu,  5 Feb 2026 13:13:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770297224; x=1772889224;
 bh=yJUrkA3wK08ViV31cAOA/Pb+MGLmCaTb/RGoYUR01yw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=AzTH7H3dnXCFQCA7cCDiVVH3CrfTz0BGTY2sBDSyFnwzLjKKFZA81540S3h9CBbVlcrEg5iGKaLxwA6DFMrxj+Ima2rwS4+N7HzJ6Udf4lGWAsFHccqDkZSEaQiEDbCXFEecy99QafrzN1jZEzuO23xeI7X7nDEQlVrNkjMeniGXQXqJ4EvB/A3T7U8LGzDXb7aJs+4a0zbVRV6A//SrDs2IxBAwO4/w9fsJLWYO0jlWmUoaM8M9Vm9p7mdGvSJir2x25YkPMlenNPFY6xBJC0g2c0zDX+xNKc6/WYrNHmtxFqYln59syLDtHCcRbgdj8j60i46bkmDmql99YXnl6Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPSA id
 6D2BD18000B0; Thu,  5 Feb 2026 13:13:34 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v20 21/22] whpx: enable arm64 builds
Date: Thu,  5 Feb 2026 14:11:50 +0100
Message-ID: <20260205131155.22780-22-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205131155.22780-1-mohamed@unpredictable.fr>
References: <20260205131155.22780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=JZCxbEKV c=1 sm=1 tr=0 ts=69849787
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=Ck9h3XeVBPDugYI9Na4A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 8pQvBFl5AzbIv_AUW2_76ypcncD_eJUj
X-Proofpoint-GUID: 8pQvBFl5AzbIv_AUW2_76ypcncD_eJUj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5OSBTYWx0ZWRfX571yD7Tr/5nG
 cnrqwgHslzCte5sASVInx4Kd3UJk19aBc7JEXEauZWM9NMqo6ko4CJOicgkuAKCd4SFJAFk/wx3
 3JjaZ8W+Z7YT3i1QQS9uCqT5J1oANhWpz2IBXFbemYrzfFlTMc4y46OFFYQbd12c4FUlNQfRIwo
 btxefpSlAAjzdaS4T6ejD8AqJ+VpsZMV9e93nIO2tAG1cTGFKIMYrxeuiZpZ+UJuGEDTOcEKvc8
 UlRRROKrZkDA7EK8utGZ5W/Y2RpxAYKwIFKBcwo5gqteP3+h3yTqoABQJg/w0w/P9PwqxCY3y6n
 86hLnexCpZu8uZnIGJz1XHin0xqBAjDNZF9WZs5TENyOe3GBXI3bO5J299JRHI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 mlxlogscore=955 phishscore=0 clxscore=1030 lowpriorityscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050099
X-JNJ: AAAAAAABOs8rz6s7zQzA7FlzJsMFvWbAWOG6lGtOUkrrgs+Z/UQ+btRCezmcfxptnJwUjQdrZpiHHFSvixMQpeXPohQ5M0BXZc9Vx2N/2CjgW0gHOQp7TW8jUGzRxwmMrmMivCrpQ9v2MTuHZVeLp0CYCmcjLks3k0NabI0j4OkRHuR+jDGpRBGPcrihIWZy/+UafkfJCPrai44VcKm6+DyNFyJIVa+cXnENUovvVnLGH3wNr4cByV0jFwBN+aOBg5voECAND3Y4SiYyAu5rMv1nojBnKP+WbOdGGa9UtkB2QXTpR1hLCv9W/4WSY+OWQXj8Yz3rd0W632VEtOc/ciK3Kdb0ngZPhe6F+5Fy2MoGFCvZAmNM8/4lUtWHEE97ZPUWCcvmCS1+pvbQhqV5abCKm9lSLqvuWwl6Pqvh8/6jmVf3NzQbJgTrU0claJLF1a/lsf181EeANsY9ASadVmnQWr/DOF12VmVEpF7cFoiJPm+4qfAPw09sqA0/IawWcvsAiEWhQ5HQXuwDL8dOZ4LQQlRYeRFJ9sqQZ6jFrINhBjsX6ANsQuinKP1KQIIEcUF2V6BTXKv9poYo1bfhObpXgV6CSThbdQ0UgioP6tzhIOeNk5pk9TzsQH5mwWU1rZxMcT7Wr9JJ0qULQKOmRBtQkBZlJLlUHP/3ZAaRwtmyVDWTDdR7iGef3qKuKDs8nHd9f92sUTvrKqZEioMpIN3CLTo5wK0ttY8yKZOe/51ncxDget5/m6tVP813RPZC0Mz/wR4dYigeQZy5rXXp7nZYZVrmT9uyz3GvA1vwLmdwQANUUOCNTHbjkRk6lLxdszF2FOlFcZhScxnRCSl+tygDptqgN1bBxn2ht2GPcJ0ho6bJo6mKTE/htKWY/UoteOgrgG8b1ftr6gDnV/jaaKzBCU6Rr3E2dujWI+44hm3ro9To
Received-SPF: pass client-ip=57.103.68.14;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 meson.build | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index 8c6c0a9a32..eeafd1d42b 100644
--- a/meson.build
+++ b/meson.build
@@ -301,7 +301,8 @@ accelerator_targets += { 'CONFIG_XEN': xen_targets }
 
 if cpu == 'aarch64'
   accelerator_targets += {
-    'CONFIG_HVF': ['aarch64-softmmu']
+    'CONFIG_HVF': ['aarch64-softmmu'],
+    'CONFIG_WHPX': ['aarch64-softmmu']
   }
 elif cpu == 'x86_64'
   accelerator_targets += {
@@ -858,13 +859,18 @@ if get_option('mshv').allowed() and host_os == 'linux'
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


