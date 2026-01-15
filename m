Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2405D3CC8C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 00:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgB3d-0004kw-Q6; Wed, 14 Jan 2026 19:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB3c-0004cq-CX
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:17:48 -0500
Received: from p-west3-cluster4-host11-snip4-1.eps.apple.com ([57.103.74.212]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB3a-0002HB-O8
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:17:48 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPS id
 19E201800452; Thu, 15 Jan 2026 00:17:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=Rk0URHLzFbQb2J2pqqyT/zI1JsK2Hqgs3DZKJWsJ2S8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ZLxKHhwddhUTljJce5T3qCBKngBTAgv3lQ1P91iaIGzwNfCQyZhJtK67Q72vh0rT0WIldxnKw4uGDvrQU/8G/TLZ3tEL7Plg0ftE4EqnvxrIsgbvbAFp3Rris047ve1zpUy1kFJo1OkKI45m/QVwFTpfd4cL0EPEUbiCgneCMkqH0HtzUWpdu8C2KZ40HX5nbU3LegyuCIVl33WrBMX3SWrYdyHLdJ0uUiC7x951w7o/UbrlpRE4oQDbvoIBwHzM+//xFiM/6b1tXfz354rIhp8uQH+5oGilU78pRRaKBF+yfPWY7qwCyIfu74c6LvGsPwEhJ10T3OpwdB0xPej/gw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPSA id
 490C71800435; Thu, 15 Jan 2026 00:17:36 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Peter Xu <peterx@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v15 23/26] whpx: enable arm64 builds
Date: Thu, 15 Jan 2026 01:15:02 +0100
Message-ID: <20260115001505.57237-24-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115001505.57237-1-mohamed@unpredictable.fr>
References: <20260115001505.57237-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EFDse8HgdwV1SDUF3J5Iwzn-LsN9dZaq
X-Proofpoint-ORIG-GUID: EFDse8HgdwV1SDUF3J5Iwzn-LsN9dZaq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAwMCBTYWx0ZWRfX4BHCCU7Rh0KV
 MCwToJxKDSNCjkCaFQ0aZOrUov7eTief/oy2TS0hdKhLV83C8LkXIN0X+7WGqBuUm676LzgVONI
 wuGWRsQiDt2uvHBn5A8AV+msl2CH9Al7KTudYamDzgNVrdOdKP38JjlE4GyNg8Rfs4e7MwgFskI
 mzdXAVCmQHlEcvG1/yH/oC6NcsF/7KLq1xsoUgyQsA9CGVhj9GBmbehLvHIMGL3AtQJRL2ha5zA
 FmzHufdgNsED7lQLdTnjAi9gf/gKOGQRnG0QkrOl2dY5ehSIpbOg2Rnf44lrLja0pDL7JrauzsJ
 IzvD+I4m32SZFtk6ubZ
X-Authority-Info: v=2.4 cv=WoYm8Nfv c=1 sm=1 tr=0 ts=69683229
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=Ck9h3XeVBPDugYI9Na4A:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_07,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 mlxlogscore=848 adultscore=0
 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 clxscore=1030 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601150000
X-JNJ: AAAAAAABBUffu0PRf7M3htzPKtcU9n6nMChP7Gcoqc+li9Oi9TnvvOjVtcvmOU1dAtL8CRNia2hOLDHjxiC+cPerwXE6fTLXTGqpYNXFwRmIkxjeX/aui8YOs+eUGzvl0HigBM584LUw72yLnnLPdzcvBRIQTYKiX2izOrJo3QlTPSakFrnxombo3FO2hG67AP4zeZ0L11lJmDSL2ipYEuoFIl78u2RNqYITtN4ma5+ZEztM2HEEwc49jWXUCzJneoGlXdP0r0PizwODTrTVyMxD9Qh3RDAliwj6t3E1VYoXd2HCCRA/Cx6qO2LIc6Tqj0ILV1AW/NsOJUyZtk6YlZiTwiBBB7aPVMIAl0YhuWgqntXPKrSjP4lF7oOMkB4MbANynlEUMICDH2JuyJ3qLDQzcgXoVQYCaPJz5suKQyo3l7k1UCClCpAYBIRw6duOwYP7JnIYkujqsLeOSVTMAGz7OzzFYdb3JDIyiPVOtSQzyw1zVt0wyM33kcKft6JFd0oBj61hB1x0H/4Qhj6v93bfjvGkfQjc7l+q9GLZa3kCZFhiVMQbiAacuUlp8VSWO2Ag23EcmduSOFbaaDJCWczPtwxg5BSwH1kDwdnR27pHDxYmyO9alaYEZu67PjjVlM009hSAupU9fy4qNdjRHYdRjb0LM9Q0NFG/H1ZHB2pWc7qAAagWINN9nlfZddvzrYghRt4ef0rZWKKVoV+EMovEqtgVuVHX1zdHJjS7EYzIi4niH/arAZ4uy4K1Qkt2ygjxWqVE/vPCa1G8TLfD5V3Kr6P80Ml7RFeb+m4S26QOuR7pUrcX96Ba6EhlBRiKjk4GF1JGBZuqIe9bn2IHkTlH8KF0iwBGXH4c6KCs5GW/Of542sqyhh/uwGvtaplldIWL/i0M8clrTvhZzteXWCOv5gsCh14N7eGKrOnF37Q=
Received-SPF: pass client-ip=57.103.74.212;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 meson.build | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index c58007291a..34c799e066 100644
--- a/meson.build
+++ b/meson.build
@@ -317,7 +317,8 @@ accelerator_targets += { 'CONFIG_XEN': xen_targets }
 
 if cpu == 'aarch64'
   accelerator_targets += {
-    'CONFIG_HVF': ['aarch64-softmmu']
+    'CONFIG_HVF': ['aarch64-softmmu'],
+    'CONFIG_WHPX': ['aarch64-softmmu']
   }
 elif cpu == 'x86_64'
   accelerator_targets += {
@@ -892,13 +893,18 @@ if get_option('mshv').allowed() and host_os == 'linux'
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


