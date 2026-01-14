Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFBCD37E3A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg1A3-0002Xz-IS; Wed, 14 Jan 2026 08:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg19o-0002DV-Uj
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:43:40 -0500
Received: from p-east2-cluster4-host2-snip4-10.eps.apple.com ([57.103.78.171]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg19l-0000iv-JS
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:43:31 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 35F5118004BF; Wed, 14 Jan 2026 13:43:26 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=Rk0URHLzFbQb2J2pqqyT/zI1JsK2Hqgs3DZKJWsJ2S8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=guzEcW1PpKgCwx0CTeDLFfRO5OI44lzquZKLmmLjBVd4cvAjoC7dvnpOqh8JrI4bQMPtujCp9zRby2cDqBivr7mcrB9KnVI5AkmgLOPLs/F2uu1zntLOkdNrduOA5EklppedNIei2qFmt1Dxarw25zXg1v1XxmkGfHBvXI+Pn9DhzusK46KteayHNRwFTrSFmyFGs5lsgS/xDVDeebGJg+bMXIOk0nUYtvfZXucBsKlafdM/vFv/ZmxKvYVI/6HgUu9l0h/CaTOQF5fJakZg6aW2Lum4TyNPQnNV09wrcsO7ygrRPB6jzszJSsoNAS2zqMNufLRkt0QwXlVNooEi1A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 BD6C518004A1; Wed, 14 Jan 2026 13:43:19 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v14 23/26] whpx: enable arm64 builds
Date: Wed, 14 Jan 2026 14:41:40 +0100
Message-ID: <20260114134143.26198-24-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114134143.26198-1-mohamed@unpredictable.fr>
References: <20260114134143.26198-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mxmVC-N0wOf7JgL3opJplJDyGIKnTrlD
X-Authority-Info: v=2.4 cv=IcSKmGqa c=1 sm=1 tr=0 ts=69679d7f
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=Ck9h3XeVBPDugYI9Na4A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDExNCBTYWx0ZWRfX+odbJu5CEdyw
 U7OKGVAQx1LS1OHMAWoI7iCiJ+bFA5PHZYbLRN6kAFr3NzJg56uZRZgHrbnaf+JXguMnPQruLDz
 +dqU7sr8npZwQOj7J5aUwvw6NYa8NtFmf4WMLPaSYHJnez7rbQk+2cNtHWHReHreN9Jen0HFbzC
 GSGGtsTVWkkHRqm6w2BQ5M09Vt1aMYtfFiysisGkHZiw97qx2jT0o1H8t2BBNMGCgenCyuPgp74
 yf3SM1cLbzyREs03JNvdGUenvdV8XFc4A//dry3fToA2vv4fxRsOAqr8voeBorCM9qNWu0Yh9Dm
 IRzCvYNiXzvvQ8VubER
X-Proofpoint-GUID: mxmVC-N0wOf7JgL3opJplJDyGIKnTrlD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1030 phishscore=0 mlxlogscore=848 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601140114
X-JNJ: AAAAAAABmhogIzCyjb3X0AglfJSDfMmA8EFPp+Y+EgNc0T7DoxBBobnUg3kmXMNPCdXsi8+kAlwCnhahyJzIgOC+iaeGPbKqV8s3Bb1i27pvaVIdEVAiWhf5rLgPxazsDlXBDLbOqTOOspnL1V/S7sZV111dn/YsvR0P1BIz89w7OJMr5lP9YV8XkyPSXo6XnB3CyP8wOxrRGFyrG2EvjtGJa7q2TFKmVqW5bEGxv2hjluHHPrLQmeqq/dh5bOnkYYRPNDGI8wSBRN2ylHlnN05byS+McXUuynp4NOdAajEiY3s7yBeBRfx3ExaaiPY6W7PUF5ZfkPWpS2lzkoxOCo5EvTayKKkt9pw4GuKq7QsxR1FfDr7YYPFFZtizJ5T5fgWAJKusIPkTpxBug45WoGl+fkVqxqRygJhFFjhcESejG4ObiqYbTOpmKEJ5Fdz7oZhJiU6lQOkI95EHeGsfa/k/NtNp2RVsFlx6G4Jr8fO/mE4T8DCS0VSEcor4PUH5E/btt+adlPAgmoAMYmLVNpvLgCU/zs7KbRitS4mtJkPQqsfHzTymRUshgADm/RnR22kG3+Gnzf+SSGyk0H7fPrT5oBPbrEPZ55o5i1XWnXCfKGmTq0bHiYb099F1o3ryY0wl0LevW2pncu/PhWUQn+xgi3FDMuAlvZ4Ls0iMGdtw/bP5tE5i4qVM+Xg+aw7u4CIhr6XWwObxBTtsvekf420ZPl7U33DAyrdhTpufwbNu7q9ALOpHDrMz+o5nqKb+wO18qL5JBJnZ1e7HxcG1/vyCLIZElhaVz+EjnJc84AQYjnNvfRDkbnmASbHVRVnMQMbaoHj9+w8iB3TZhxp7lhE17zSW6CJrAUi2vrPCaf2q54YpzG/1i2gtggEIlFioe6E3H+ZoMH7i1pl7OgN4
Received-SPF: pass client-ip=57.103.78.171;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


