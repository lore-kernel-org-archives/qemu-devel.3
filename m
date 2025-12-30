Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAE0E94106
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 00:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaNK8-0003V3-Ht; Mon, 29 Dec 2025 19:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNFp-0007oQ-KP
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:06:26 -0500
Received: from p-east2-cluster1-host4-snip4-2.eps.apple.com ([57.103.76.15]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNFm-00046A-8o
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:06:25 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 0AB6C1800109; Tue, 30 Dec 2025 00:06:13 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=KNda2FnGVdB+1PuvMJJo6JwnL0/5/2Oo7u+nyBw0Jtc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=awrvnds6IEwOk0HyMSeh7+sEDoTzrdbtDoEXDbAQAJu50Q9X+8Kmscco0Dx7nfb3CdWILDptvYs63IcL2yIGOAhHzZBZuPEk5xJQA7uQ7TlgsDpb1GOepridLoxjCAfqQDKH0ELJKMCV7imYl7xSPQPz5y39c6Sx7VQvsGJ3MGu/XI+HB0E7SdezURujyAijWgwYWqbh1Snd8lPA6lBas+JvjHRPz5e6uimSsPBIXdmX1dZZwrp6lZH+bmeIk7g8s3Hm+G7rdLlbp5L0rwAXRR5fLAtd+F5Xk0Arqlm9znhh7FnprdfrtooPzsrc4NS1BeAVfqTUMQLl8Nwk/rmnoA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 A4D7A1800476; Tue, 30 Dec 2025 00:06:07 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v13 24/28] whpx: enable arm64 builds
Date: Tue, 30 Dec 2025 01:03:56 +0100
Message-ID: <20251230000401.72124-25-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251230000401.72124-1-mohamed@unpredictable.fr>
References: <20251230000401.72124-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDIyMiBTYWx0ZWRfX2mnlKykaMPme
 YQEPteqQdO6+U7PpqRFyDPFCbJvArrn5OVbX0hLCFon/Wx0h7JRPeKo4rxoIXnbwBh9t1iT+7ge
 mVdMrI9RHUY3/UaH4dzXR1ZPHhuwCDOLrO0OsY2940oODsmmu9ZaRxid7PWdC5j+nAbMuk2kgKR
 4JGPfqMYeeAJe5IWPIqs/O2RJ6fDzWG2lNnFwKX+E/AxfW5wB3Lh3l/iHaB/aI+6mCXUB7op/Z5
 Eh2eoAYTjRQ8RM+C4bWNwlCDjT6V+kTwAZ49/j/ZinQCiuNbE+Xox/xxQnoyaPXyD2/zK1frOFE
 96ESGBO+HbLSrTXF5L0
X-Proofpoint-ORIG-GUID: WnOG1Vsu-o_DW8mL4lYuu7QpdTdZJFY1
X-Proofpoint-GUID: WnOG1Vsu-o_DW8mL4lYuu7QpdTdZJFY1
X-Authority-Info: v=2.4 cv=d/r4CBjE c=1 sm=1 tr=0 ts=69531778 cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=Ck9h3XeVBPDugYI9Na4A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 mlxlogscore=849 malwarescore=0 clxscore=1030 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512290222
X-JNJ: AAAAAAABW/OlLP15Xo68fHyTNMCU4z8WqNgraFKKilsXDonoOyWPg0r1QWGzwriL077aCJrcY1ML/ynldOUzqDsV+PmHuV8yzujfqzBbeNl+oeYSJvJoQ3FXJMVnWND/T2/O0XoETQN+cevegCY/afFTWymOx2Gzbe/SYVTgiiZFQlhOm6By2Yl4fyozmjfZ3i5RHj6b6pS8FyqtolxG3wV3G49ihgBx01ensQDDhMt/+f2Jxc5nF9M371n3e1cbGmGG7WByKEyhrAiFIQ0FjkpHQkqVxXpFfyfxCfSY/8kTmhun/ngLMRAvMIkC09vYAT51ZGRSSME35LHhWcmnZj/Dk9VCnJ1AnVsH7nT9wXOvLeQTEo0gKqN03XGzTkaonTfo0txkVxBl0i+asyNJIOlHlfwT30yECm65jcNfFBUnSsvMTnwm2MlGQBv5M0iTgTaReub8XLQLlSR/xaJisAoA1Qd2uiu1PU7HYPICbtFmBwWBA9OTu6USeF9dZXU6D5Mrk/4kgMLP4G27jq5hsWnh78/o3zVmo020gaBWLT8TOyOuXBFuf1qhUF2oOpNHnYfCZrC3H42jJpzPUzVQS/K1/qus800cOxEjCzHBisBGpdi8EgO3TjaB4mkKdmcAYjcqZJaZoq6QeuMx8s/AKPNJOB62CIkwke7K2m+8J56Yc2vNVdKditATisQEqmAKo3R42ZbTlqVeNMAGrQ208b5OvZgLERc2EljBTcxgz4WqYyreoYoU2VY/+wRsppxqna/yRX82qNo/pYH4IO1aFNB/iNwmoFDdFS5H6dUiBtrwxf2bei1GgcJ683k/Dv96SFI6h3MMiBpCEa+CSX8v3h5yzFvVNl/T0CGTcxAIWIN9nmlMAQgrqdmlFugZRNrEFP1/HQMiJIcceGZ1CVs60p6LbwexM2Tu7UQahJFGFnBu9G8=
Received-SPF: pass client-ip=57.103.76.15;
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
index 14b1160c15..7421ead19e 100644
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
@@ -883,13 +884,18 @@ if get_option('mshv').allowed() and host_os == 'linux'
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


