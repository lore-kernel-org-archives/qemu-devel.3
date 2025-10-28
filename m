Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6ADCCF9F1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDtRu-0002Il-VL; Tue, 28 Oct 2025 19:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtRl-0002GB-Lg
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:49 -0400
Received: from p-east1-cluster6-host10-snip4-8.eps.apple.com ([57.103.90.229]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtR4-0004pm-Ai
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:49 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPS id
 186D418034F3; Tue, 28 Oct 2025 23:48:59 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=pef4PPcFVIJAL6pBQzzaJ8/pUKAGPGBCWFIwX7eqUAE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=XzQVlVK+38Yt46CN75ThYAfhKro80xxMMNOSgl6tMuZ/TuE13gbjZc+1cQ3JArC9VfeEDn59iFXKG0FmdOlDtPD7oaBonwn+jkxJZOaCisccLkyrwaw3K+rtdVPPlIZJb/Ia8GKbjO4v5Kt1j72HPJAw4dUAKtx/tIZPZQ8jaDJU/oDLASgxNQzwBV2fyODTa+IxXlUyKAyQ1snfzwIIp4ji5Nm94GAeZSs0/62BAg7qfAAafeCaMk2z9d4UNUqSFTEfsnL7cWyZEFuNb6fXKP0HeQqVQkgkeJWgkoR9k+s491l1AmE4Fwe0DiaMRVN03+dRt7K51JccXtAATasGXQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPSA id
 1814E18034E5; Tue, 28 Oct 2025 23:48:57 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v9 24/27] whpx: enable arm64 builds
Date: Wed, 29 Oct 2025 00:47:54 +0100
Message-ID: <20251028234757.39609-25-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028234757.39609-1-mohamed@unpredictable.fr>
References: <20251028234757.39609-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _IrdBYOWjrAyVpBNgZ0eea7NSg7pArMN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDIwMiBTYWx0ZWRfX5ogQG+qbu/OG
 HCbB6RIWSmNhi/sq2ZFUtWYzXNsURKLkGIKYZItXBnWNlD0sOJNbTOQt++JsT4aQy+NM6EgWo9U
 Kyv31wmMO54xYEgsq3qQ8jOsTCY560EU2+j97jfs/P0m8BDe1ysOvf3hNHBfve5m2fy2Q5FA9be
 DZHRheQd3jL16yZouObH7gcj5HgROROTIg04t3QurLiEzU9zRm3tiqxPlBQH1yqVo4SVccNDbql
 iRo/nkxdQqyj8eZSZQDxOaQ5P+4T1LPhO76rTp6Hgp6zptw0OCpSBucWTFHBPDPhD4NQ1QDbo=
X-Proofpoint-ORIG-GUID: _IrdBYOWjrAyVpBNgZ0eea7NSg7pArMN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=761 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510280202
X-JNJ: AAAAAAABdmyUK7BjZBYyMdjH9Yll7CrnEkK3sn1t+V+rAf+X6+JF5NyLTUTqOXl4labMdvwlWklCp5XSovx6l6Rl1h+hwmTKg+6CdtjyDAdFX5lHO7mOqjYMw0rjZ2ZxjtyzESdN//FJMqTXE8+roLUa+SgjgfL+7/RCiNsOm2GzGnNQx3aNc4D/cVfGWJ1D+Zq4TNKCWcWCE+NozZL0mQEuh97QLHvQjwH4tlIh9SlZki06f2YY13OXOKcRFBtwi0ckFhvH+JBJxJAfZK07wW/2qanydKu0FjZPsWKJlm1lMNCbEEqZs3h1RqlHAWPzJcyV5YueXoFIoAQt5M5uHmawmBK7L5G5c1YTGcJ9k/ec/qSC+H4TJubXy522hIiTeRHC76bpYN1YoWXqGDhm4Qwdr3XTF5xRg8t6i0T7E/4JOEsc10JJ59GxtQVi+l1S7V8tX5KRf+mjtycQZxmHccWM10Oo0OSjQ5B4tbxVg5xMdkk2rc82FvuSu7W66gwxbn68DtQmuYspsHf6eXJQ/CE6ZVkWlgXH8n0AGItmxjChP9QdxfBS1CYMoP2SAkfjDqPsfAYPViHCUlf15UM3yNdQnyqObcskwY2tAgQ5Lv4BL5gmY6qwGg7exDyEJ3EUYASFCsI3bu3BN6LY8jwPk5UjDygnXoj1cSnLOu7+hBR1PaHNFq+cVq1+OsX5htoTS75FzrA7RTsfcn5wBm8OfdaiFr9HfnDoPQ==
Received-SPF: pass client-ip=57.103.90.229;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index c5710a6a47..6759dbda15 100644
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


