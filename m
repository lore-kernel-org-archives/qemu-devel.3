Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B689CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RJ5-0001Xz-II; Thu, 16 Oct 2025 12:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RIn-0001Dv-Oo
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:58:10 -0400
Received: from p-east2-cluster1-host6-snip4-10.eps.apple.com ([57.103.76.103]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RIR-0001fh-QG
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:58:09 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 99880180031E; Thu, 16 Oct 2025 16:57:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=/emOJC8MVUV/uiHpi2m5tS4QeiaPLM29PVhym/FdJcU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=bGK6tL68CZkL65E06+61khANtcYjpq3PARdtmvowceiOa5ZPv6jgqDjp8bwc0PrldqVk0byHCWeOsPxqa2eyFj1G0AkYid5/xFxbRF/PixLXeyevvtKCMY+Hb/hlFcV/1Eg4OYvPkGeKTVP+6G14ZDp45Fe9j6Fl2H5bi/S3xt39vMM8XHjk+JA7u7hZoMexUonEUey0gXMpACgCU9JalYLDLC4jIzY3lnRB5BhFVU6V0D1TQnN0uDiYV7QRWNItizzEnL6kXPtwX0G8VaVhLqZN43jTDYxe6600lKcwsAzaBY0ARgeERQ4DUXWQCAmbOYhdV4KP/CdSTXg0Dy92IQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 131AB18015E4; Thu, 16 Oct 2025 16:56:37 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v7 22/24] whpx: enable arm64 builds
Date: Thu, 16 Oct 2025 18:55:18 +0200
Message-ID: <20251016165520.62532-23-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016165520.62532-1-mohamed@unpredictable.fr>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMiBTYWx0ZWRfX8MN4+8TqD7wo
 UXxbavPWFbBsjCt5f3M61/LFp6EeSWudxukeX7ZE/W8ycrEUGwjtWwllKmGBXM9N5/XVtUyomWn
 d0FgfA7Gbrxncz0YUb3z1pxVqaHQBJaCUkrg8LbCNPblfId5HE3xMnpGJhbpH9aHX8XIe4WDVpa
 roQfsJpBpQaLVoRGvm9Q0gdLhU8pIG/AV6Zb/wIVRcWVO4YBSYlKFBmOBvoM1j03m3fh8/0X2/Z
 woBvQmCHD1CD02wU1GoE0hVx3judYumFOiczVQCGM282PGxUM/5v3bDIHK0UDWcQ2ll8Lyafs=
X-Proofpoint-ORIG-GUID: Iiet0wwArAWtXoR-ODLyJF7wR8btH79_
X-Proofpoint-GUID: Iiet0wwArAWtXoR-ODLyJF7wR8btH79_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 spamscore=0 clxscore=1030 malwarescore=0 mlxlogscore=815
 suspectscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160122
X-JNJ: AAAAAAAB2aQCkDaWtKQwb7EF4MxiDDJAP8+apyChU1fz6cSz2Jl59dZfBQlu4RSJ+AD2D2cp1SVqiGzihKiXys4LUhwOT2sJCZYN2CYrNH6mg6TqxHWATkidzUvtgNA4d6nD/A1dnWjfGAG5FWvmPAgHj+uNRAGa0eCVvd7t0SnV8jrBx14R6m336GPgo0fYzJGy8Gr1HbS094f8BIlbs5nH+CUxXnFIsv+vA2aalXG6lrd2eeCMi9dIlcZAFJe2A3z2HrXrATmAV0vBlYhQnoagE8kOLbsssru5lCNh8zYi6DTiETghz1kAlgipu3k6Tsx2sNZrnUCtyaxT42dIy4mERiDm22jyu8kIiLhue+l9eBvG+sUOgPrOexORaVFXWE0JbyKPZ8XyUZvWGCMY9Wm6LjIj51cCRdcCBOHo7aE8YmbeGaaBstfuRimO+3TM6afsuh483GK2YKhUuuLv+nJKZpYma3s6sCutFwPIzKNZSZaE5Qak2wy7E1YhFgLJyH43uAXBnNSd8RVB6r+MMhJmDhdcXCSvMja7V0Ipr3MdT0h8LeZqMWXp9F9a1fRrbJXu7ko6OKXm4h1EptS+Ohv2cKlB+YczJbHL/rnJv7ps4/gn5BOphQmp/M0XPlAZruk5VEJXb1gJL1S+veTUs5pAWLQqcTPvk/9o6rHrgiahmbVLK2oPBrHGCnQifiCzxE7bCwwsvHKz1NjkoO1P//uRoCGPS6U9g85kba0/jrJbGXJn793hAHEsHPGL74PLjU3V4gOqXaZ8SsAx41PpJJQXyOoZnrVzq21Rlu0nZbCL5Glqt9SUbYVxcwjV1lx7upmCnI6qYMCJfMnXWQY4LXYVl/Um+PNXHPMoEbtru1Ojc1UUXPof0paItQI=
Received-SPF: pass client-ip=57.103.76.103;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


