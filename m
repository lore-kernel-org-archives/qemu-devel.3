Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F398CCAC5A8
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 14:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzyBS-00071w-7t; Sat, 20 Sep 2025 10:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uzyBN-0006v6-GP
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:03:21 -0400
Received: from p-east3-cluster2-host3-snip4-2.eps.apple.com ([57.103.87.153]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uzyBG-00089R-Se
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:03:18 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPS id
 EBC0E181722C; Sat, 20 Sep 2025 14:03:06 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=qHgEAm0T48qcnuuyvEGL0jYZIN/Qj9qDonPyqKnSW5o=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=MtzGnu+kCzFJnQ47hOLw+4LWUtk2XOfmPEEejEPpXr8EzdEEMVWYj7y0BUfEB/PQ4YZVioAr22u8Pp3BXdWGInXRnH+ja0dvrpRDoXGSFZZD/ZFjAgBVNJBwLI3FqFyP1u0IJDakZiva7hiecPIevaXpolOhm15tbylGJVgMRxbnNo4myjrNYkCW0sA+a62bJ9X8w2UotyDWEnnhF1qIB1t5w7xXOZgUpUVSYuvEqJgY8ehVAWZV5TQmLWl0btSq3+etIpNNtYcPi8EpyGSMxQy6LfRxEmQa+Y/5ckSK0wy8k4ISyowNhr4sCBgJkVW4xVRAm8icelSiJNm8bt714Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPSA id
 AB17A18170B6; Sat, 20 Sep 2025 14:02:26 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 kvm@vger.kernel.org, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v6 20/23] whpx: enable arm64 builds
Date: Sat, 20 Sep 2025 16:01:21 +0200
Message-ID: <20250920140124.63046-21-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250920140124.63046-1-mohamed@unpredictable.fr>
References: <20250920140124.63046-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fHfNnrj4DjiPpriNYLihesMCbT9QAhYs
X-Proofpoint-GUID: fHfNnrj4DjiPpriNYLihesMCbT9QAhYs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDEzNiBTYWx0ZWRfXzCvWheqLsfm2
 H4weXvftQEBpsctey7OgoqA1CLUZDFT1abME1rB5dnYmfNiCLgFgjfiAfKB2uUF6jwclPL/TC3P
 rJnRM8XZwSkc2mIWz9221p+217zUK4uYG0roDjP9GlzSagIZexA0WGKurXCemuhPLuGkZ5SGQfL
 GU/lsTa2Bo/b8Lgwho12JVhlv34HAKviPfYCA5thTQRASyBrpf5ZwHtGCdDo/iAE226YdZYhZYp
 JY5FHHlsaucY2stmf7gLReKKS+bYw1D3FxngTZZSsmsr1+FSG6VRMpQ7eBwi2PZuML5vqK2z0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_05,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=797 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509200136
X-JNJ: AAAAAAAB79Z/XZi5MOK8TKrJWDv2jh5CCZ34gC0VTOC8jxc6nuOGCkHtBdTgcHPlPasYSHQkvLBRS7pVPJpjulLNx1qwqUBTstBAhsUXGD/tgNBWVp6NCVi9rhS/ijud6jg90fhNpB8dSDVfHdTWalmG0CJ2wBqRf2PYKcp5Oe3Al+VTRKrXSzU4amucvk2NldN3+4TCWrZW1ep9UxkM3MaDVcnhm0akzt389gzeS/UQBz4Dl8j0Y5+KYhLxccbvvBlnSadoIYWjmrubrMBKlR8qc8etRK17MlMUbzHflzI3mX4Rgd3oqJX+cG+zxhTFR8idFw6Y9nknC7BKD93lX38vImKQqgpzN03L1YDQ45FfelSgu4u0TRK6U4yeug6wCvXP6Uk/Aa54EtaatZewxc5ZPORPJGPfLCcXPNwsyCRt9yPkRbYv+1eHp1yZTfZaXdeVIo1F2lp7T/zj8Dx6FE5C2u295JL99AYEnpjuMCGp6dYZ0szJkIrcxbHauTHWmqKIIjC04rhVPVO9RcxgMg9gSSXD3IAfiwEqADZRjnhFqELpipH8/qBZKz1Mij3y9W8Gx6rULVieUtFhWav+SnDE6rcUvamST5tFZHc4a99Qh2tvMWDk2o9gV6VWEGWNBO88IwZFKzerl1a4/3TdXAogdwKEm0Z4PDZtPAJMYxDN69X9TVLKeUrpKtS40tTUPPOjXugpPlMDn5y77WthxEBSrfuUYMENTywGGWiEE9f1UPt1o3uoABoL1V6KUqeJj7/uafIuf/FBEms8R2UUquDK3P+Kr9UWGlaiDZr7EMAt8L4MLoU52iRuqEtjkGqIsvDRabwNQyBNebMHWOs6U199m7Xg8e3G
Received-SPF: pass client-ip=57.103.87.153;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 meson.build | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index 72da97829a..ca333a35e4 100644
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
@@ -880,14 +881,20 @@ accelerators = []
 if get_option('kvm').allowed() and host_os == 'linux'
   accelerators += 'CONFIG_KVM'
 endif
+
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


