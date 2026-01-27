Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95625D2FED4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknrw-0001yb-1n; Tue, 27 Jan 2026 13:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknp4-0003aT-PY
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:29:54 -0500
Received: from p-west2-cluster5-host1-snip4-4.eps.apple.com ([57.103.71.107]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknp2-0003sV-Su
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:29:54 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPS id
 784DB18000AD; Tue, 27 Jan 2026 18:29:50 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769538592; x=1772130592;
 bh=MAqqeKbQwR4WEZPLy9SVkmdTt6Yfi3jNZF5s19r1Uoo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=bx5F8uH15r1qssc44hZP1HpM4eo0JUChXH4jNPqLfCfqVMUti99SYS9AYTgsBJVNTEVXqC9ZyKOcc5QCoa/EcaSDj6rvUR0fWNj11F+hy26cd/MXOt0muEyh1CNO2cvN0L9jRTiwfaLXdPuF766/GE2WVEW9iSMvBpscSxikziK6pk1d+wTJgHwfeprfYjWchB9nC6v/BgW+tDAqbGGJECQ0sxkOfsURE3uczfc24R1+PinUsVyNBmIXQb89QvStLVOUFwtFbNOKRBCVBSZTu0JQY4Jj8pAMUqrh2udeuQ/OqPz3LSVFKrcTj4aSjLLIpMTmF3/numKwvWlme0ahMg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPSA id
 EED1A180013E; Tue, 27 Jan 2026 18:29:45 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v18 21/22] whpx: enable arm64 builds
Date: Tue, 27 Jan 2026 19:28:01 +0100
Message-ID: <20260127182805.73212-22-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127182805.73212-1-mohamed@unpredictable.fr>
References: <20260127182805.73212-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MCBTYWx0ZWRfX5I//y3Exorxx
 URmoT71gbWagpWttLCnxYVazr/SaZWE74Uvd3XyeiS0e2nfTd2DzUzrNWUUPVzJ/1iJDD401pQf
 v83JnC/FngAoAZnmC3h/SqKRC5dKyLk5vbGELaYBReWDz/G7fVuTDAKnF4Ey4Geb9sjtiivv60k
 ZKrNRRr4Zk1+ARvCG2UlnyVFymTGP1NbhDdT00dLAuECJf4ywiyrfw0DAuDSOXjExf7NmUsksV5
 IbnB4bOuWlgz1HWjg1JARwV8Ol7r19xjmaVGteSjESkpH105doFq4c1lAKU5ECh32JuB2/CgZV8
 TW+ERFye7p/Fq9Tji4HfSwZmcL+Z2DAW9dMO2hQUFmT8qzy55joMUF/sTK09wY=
X-Proofpoint-GUID: TLJ1g47XktAIKJphqRngLfQ8kbau0N_Z
X-Authority-Info-Out: v=2.4 cv=Jon8bc4C c=1 sm=1 tr=0 ts=6979041f
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=Ck9h3XeVBPDugYI9Na4A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: TLJ1g47XktAIKJphqRngLfQ8kbau0N_Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 clxscore=1030 suspectscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=955 mlxscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270150
X-JNJ: AAAAAAAB6nbOkU6G1DzihKzwYLMgBFRXxreg2uxg4pS+6J9ChSaP8dWfE74sSZ2FuhAqYqg4IxR89bKKggy0K7hu+6yzmfGyFxMac3aN+McaVWe12ULgfkT8R8lI4xtDvNVktNgeSyWrF61+9v57RGFe4XRZZzza05nB8L6QDEtnxRtU7k8cjBAXceI/qy7c//qP38PQVsrJQwT03krb7jb+pUKERKRSNTBtTBxObtbKPvvGMr0ZS4Im2y+fsYtTTYXd8Iw2ExjMl8GCNWTQouBoBN1rtlm9WG3SGNgRbQXKn2Ky/rn+Ge2lz+5HnqasvRaX/x7k+7DTvfGImzkOPTTUlEAcRryv+J5RykKyFsYdj5KqR1BZbz14hVqRT2uiwKd/dmQlhRCutqz4yD+yue2JinuJHnLvz58oGX4LPExlqgdZRcz9uZKxZu68HXA0J1H7zAVG99BRARystMdcAxE4QthVEdxXyiU8/uU7KZ1IjgnWNPLsoEIHDhL3dw0axCCu/BPvQLqimlopvWGHWvygrnapp3XfsMR+SX3PLcD9cCroy3YnQT3whYpFCTHAcWUpP0fwwE9NiDdP2P8lLIDkwRCPykI0dP0eNXyzNWnZy2LOROGsTTktM/6BI7cHHAToO1I+HbLuDMjbKNhXxPxhA9PTSW1gDo3bgCy8LJ9l5E7BICFWbP/gR8C/vsJDJMsk1uMC0TisZ18HeYTtnm5WCw58htYhedhBEOVajb0QUEbj+CWJaHKhBqzb4cM5LLC1NqbN2sxvamQbtOKA8qCBdiV/eT/C8/cCJMNWVHBWbuOaIrl9tKDRyILOkBQqDH/pfpmK+KBMTlpMME+YxP0LWI2K6XJYLHkSWWRLf570rZqK+HJiHbRCJVGH1/IdyLOrIBBT5KCtUgX+RGVI3sUQho3mKDnh7mDq
Received-SPF: pass client-ip=57.103.71.107;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index a84f14258b..286afca4bb 100644
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


