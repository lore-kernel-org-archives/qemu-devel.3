Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E4AD73E80
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 19:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlXbq-0002M6-TS; Thu, 29 Jan 2026 14:23:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXa2-0006gH-R3
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:21:29 -0500
Received: from ci-2002i-snip4-3.eps.apple.com ([57.103.88.214]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXZy-0006EA-7G
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:21:26 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPS id
 AA0BC1802020; Thu, 29 Jan 2026 19:21:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769714480; x=1772306480;
 bh=AR5+P3ByVRCcao9rpUQ2S01dSZ0kValf9JD31mq5Hvg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=IL9B3Nu1CoHdE332xVttmkCJmPryQksnC043rnCXUj9k2L2No4wRy+s29q9K3nbFUtrFQP7BLYDuZxX/zQwPDJoBV3i+nZwksGbMBMMTpCKKxvQeIz6YJKJv91uz7lthmhze7TSrTqDoaTQD1ATAuKI0wyE+aT6chx6p87JpdRo0owGBjwcSWlJPa+mi7Kl3dS449mdsA0G1836ITQewGIMAXf9JMwt7b5NqQ7rR69fvHSeRF1x5WP/BUdbdciT5nEi/QrPParSUyK4iYbLJqaoLIk/LNmTLDb6q6VFuwFJpFcoLEOadhFOcmwXWvHhOyTJIhbiclC2jMmw9dh6v3Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPSA id
 936BC180200B; Thu, 29 Jan 2026 19:21:14 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v19 21/22] whpx: enable arm64 builds
Date: Thu, 29 Jan 2026 20:20:06 +0100
Message-ID: <20260129192009.14707-22-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260129192009.14707-1-mohamed@unpredictable.fr>
References: <20260129192009.14707-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=EonfbCcA c=1 sm=1 tr=0 ts=697bb32f
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=Ck9h3XeVBPDugYI9Na4A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 8H8Al2MJzZ4oS6SOSpjLXL7gIimCY6jE
X-Proofpoint-GUID: 8H8Al2MJzZ4oS6SOSpjLXL7gIimCY6jE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzOCBTYWx0ZWRfX8gyDA+Ssfy6a
 HobZWhX3bGiWUpSuG9bnozRmiP02CvxPE2tAWljqWF52glH2IW/jZCBzUKQqSdQ0vI5Ai8TrpCN
 NeOF61IdwwDG+6QVwOXfT9WvPolbF3beFXgloAlm/USfsJyh4KNXMWQPtmMch/49n3TdiZYiQk3
 zXySs9H31dfeXoBggFcKW2/jucxVSfp9swFGE55Fqrzl7/l1ZwCYVUkWQJz5GnH33jynmSCjFbZ
 p5kiUsG2SCNJgw7UiAkw8iRyL3s+1k6Ym/xzP9yXnPBHDA3s1Vem5Fyp7gdM8UjenB+8jpjR5qO
 c3CCL+T1g9oAOVwKKV+uTcyH9JFozoJOu67t65EFPZCvVunBkmxTK3KwkDA4Ow=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=912
 clxscore=1030 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290138
X-JNJ: AAAAAAABqWuFKoqHE67Du1j4vht0c70MnRnAEzoanvzrW2iOeK5NnnovoEuyuSWSpXFJU/bsYngV/1kVZTsUD4/ByHXzZxm4dJwKfOm3T5IUKzIOFix94dLCvCOaedJvH+5eDbtq+w6LirWlXCAQi5DJRZ9AYScEffLOqdAf47droqLaR/GydKQMLkCltDFvPKkiFhp2T6BJF+JyVEnphuh7ZnNA8hQmlpiS2eRb7TUZqJVibdsDTC10gPR54azsf57X4q61RtJ7Nl2XZ11YTrXneuILX1OA+qWnhnW92GH4kC968WMlkwQdkZK1UZ89JMdymXckrVo0IRRoJHWy0vP/rBWswSs7V5T36JGM1bGAsu8iZS9BQohpw9sKoRfxj0v5LfjzJu+/vzMDstvVPq86RLHYVPZZz/y1li3BFDYQLMWvZKQiXokNhqraD/xbshbA4cYbVZ2IN9o8uB1F/l1i7R0D6IT2iSsolQL/RXcshvrdDKX0cX3wLeshEKrQ0WDlCB8bd4w5jqj/e08afNqd0yJ7qh4589Xlj4fM16vwdzBGacE+XmTfKNXDFvVg+KBr1WQlv3fwCYGfNHvVKb9Sdcu+BQGJUj7SoZH9hzgoCXIx5uqYtxPJXTS7TEkCwW4GAX9pKJGAUUlMhqB1duMkUSOdh+l2Tjm6JWeFtHzU1x0mIAPtsdr+Ea9qxlUT1sR0+RNoObuJrQTl291ZW4H5jZ+yp+dR1NJPUgwI0QSvHlP1olzF64+/RGIUetLMVlx4sv/8MLuJufLCVPXAeno1jaqpPZtE8El9OQjqlZM9efcm7VzReQSVxBiwW3YLk2hqhGGlRQIm9HbS9zXchQ==
Received-SPF: pass client-ip=57.103.88.214;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 meson.build | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index cc0dfed066..c2cf9304e3 100644
--- a/meson.build
+++ b/meson.build
@@ -300,7 +300,8 @@ accelerator_targets += { 'CONFIG_XEN': xen_targets }
 
 if cpu == 'aarch64'
   accelerator_targets += {
-    'CONFIG_HVF': ['aarch64-softmmu']
+    'CONFIG_HVF': ['aarch64-softmmu'],
+    'CONFIG_WHPX': ['aarch64-softmmu']
   }
 elif cpu == 'x86_64'
   accelerator_targets += {
@@ -856,13 +857,18 @@ if get_option('mshv').allowed() and host_os == 'linux'
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


