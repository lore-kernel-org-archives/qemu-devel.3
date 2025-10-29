Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EB7CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEA6Q-0004Ny-0V; Wed, 29 Oct 2025 13:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5o-0003n7-Gb
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:36:17 -0400
Received: from p-east2-cluster4-host11-snip4-10.eps.apple.com ([57.103.78.181]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5U-0003Sl-6m
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:36:15 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 BF8DE1824483; Wed, 29 Oct 2025 17:35:48 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=w3P/pjd9SPTWUADMWm5TSzmLlO2TAvpYEIX8vxIZRXs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=OgvunuWpLaKCom1NacconB+cv9N7sCeZ+fVdulohQ+BBTluapFoFW/TtwKFKFCcZ6lIdA43uijHNXY7pha5UwCAMREpmQfuIAebHXHGWIPj0HrPqk41Fkvw8n1kXmZ4vcRa/7NMVJaIqDilzU95N7r9j9twZ51P8uiyUBTGrlxyIsghdnr7UxNuM9FSG1r+E86tezuRGTPgi/JpRiwLcbpTUzHWNE2uux/1ktzMBsX3qOQKxrRiYiiw+oV5HxZaZUrDCVyJyor1AM+MnDDEb2Pue8ig+jXk0k7PvvvS4kPYfCBBNU1jvBqWeKYKkOm7SJwZdMuiVIJFXHiKdXS5Ixw==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 B41C3182A801; Wed, 29 Oct 2025 16:56:01 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v10 24/28] whpx: enable arm64 builds
Date: Wed, 29 Oct 2025 17:55:06 +0100
Message-ID: <20251029165510.45824-25-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029165510.45824-1-mohamed@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE0MCBTYWx0ZWRfX+dcQi7zlmUYO
 AX9d4jv4yAYtleQeY9bLS61CgK5r5iIPNFTizB4iyNzke+azDE7eTbc8ELHlHNtYyLQeXNDfnrw
 unMPbucttwNFiD5Ie0qpilT2ke3dGizmIucJjgtPU+JOvIoWZiG4uuKtT31tQqvUNcanwEA5vql
 5e0Kv3INEmBv2XT003M5on0mi9YVh4pM6PRSXdBHx565zO29ayFCTYaJoNVTKAbYDlOjM3hayx7
 YX2fBnwNPG27+Use1CofMLpdbSimcQERoSRvhBPUjXposK78jINXnxf5jnBPqwBhrGNS92BOc=
X-Proofpoint-GUID: I3Q3kw4xSCbJU6QujTnVSNVGM4wrtI9P
X-Proofpoint-ORIG-GUID: I3Q3kw4xSCbJU6QujTnVSNVGM4wrtI9P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 mlxlogscore=627 bulkscore=0 spamscore=0 malwarescore=0
 phishscore=0 clxscore=1030 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510290140
X-JNJ: AAAAAAABTyYB3IyHmoXdl5wldOs4RJ2Rfh3B7o3T5Vx+ViEiuU4jsEDwQ3K+rGTLoXgTjW56X9L/0ExF7riSXoYApgBy2azVW4kpB5LzhYEdwsO6LMRKdGQiqR43IMPNKMiz1Oizb2CzxmH+hosuXXsWVOX/VeBByzI0a3pb9Cetk7dN6Wj4VvIxApqZb39H1cFR13Ir3NHYMau/v+0HEbdH1F7IKXgAf7pgqmjOhgq0qIl/5IrpbZEtnHAT4j0HMNI9Zxi39hl5//WvEm7fF/LgSaNy1IwUATCzo9KaFQ03F7lW2/6JNNq4Jj2/B58dK5XsGuSBz9Wb6tGeYZYtLQ6aSclwo/h/nTdup7nV/VNVJluuKCgeD98t5whgOTsmZjRoKySbDAyZEE+iU2F1jhdwhg7UYXNndhXo7RiXaL2GE+VxwPOTNVlfdmWZqnbKjhjDAzOs/A2k7aFUV5v2SQ9lJheICA/Kg8gMCge/NLpeZW2OA4OreZWUg/6TvYVEzYgqrCbX6JoaRHLNHn/37i3+iRchNedHR2mEP/u5QWH3bu6WqancFIzJJSrIp0pI2Jy2zsEdEGZfvoFxYC+RDmTkfBZJJXmUs8RHmhCDZlFd4Xv4g6L/EtGydOxogCqRZnux+gSnUDut3AuHwbQehot3pdBm5RQZwKBHtiaCNqeBSZBN4XLvIlUBaXH1uciiSjvTqDbxT2mO7SwCtZLVmkde3FzYfUnfqBr+O5t24O1lpZXYbmSTc39G2sTed+4+wSOLyuxl
Received-SPF: pass client-ip=57.103.78.181;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 8ad37c992b..065cb1c493 100644
--- a/meson.build
+++ b/meson.build
@@ -325,7 +325,8 @@ accelerator_targets += { 'CONFIG_XEN': xen_targets }
 
 if cpu == 'aarch64'
   accelerator_targets += {
-    'CONFIG_HVF': ['aarch64-softmmu']
+    'CONFIG_HVF': ['aarch64-softmmu'],
+    'CONFIG_WHPX': ['aarch64-softmmu']
   }
 elif cpu == 'x86_64'
   accelerator_targets += {
@@ -891,13 +892,18 @@ if get_option('mshv').allowed() and host_os == 'linux'
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


