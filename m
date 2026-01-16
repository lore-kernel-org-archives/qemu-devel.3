Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A055C79FBE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkHK-0004mB-92; Fri, 16 Jan 2026 08:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkGm-0003gN-Sr
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:48 -0500
Received: from ci-2004f-snip4-2.eps.apple.com ([57.103.89.55]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkGk-0002Kz-PY
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:44 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPS id
 B2B75180F923; Fri, 16 Jan 2026 13:53:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=mHpwCSJe5qNtqv1FPZQ+j6j3+DfNnaO+7ccebHARuys=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=DIGlId4Oipm2VfhMRQiCwSP6BcOF2ZbdhDXHdqY3fwlWI6cJY1NdHEBq2CpJdu5twSRMceJhWjWD0Jk+w5U0/qjd8HGDSUSw4HMVllYxs9oQMD8irhyZKfNHmBYvJZY0rFwZpoNts5kZ+BFupobZQJ5AHxIsdgW8/3d5KUxfn9V1TYAYlI5gpt6tgm2gAvPK65ThVCXxDgYRM13E4BXhIeQZ5PlU3zCTsAf72CsFq2f9rTXWWDPPabyda92iK/65dOVy8orAgRPDm3eVymPp4o/uVAhH3Qtg80yFcqgeV6kINbVsJeZBuI2/s66o7KjrDUUML2B3kpVOYNpiO7LxZA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPSA id
 71BDF180F91B; Fri, 16 Jan 2026 13:53:33 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v16 23/26] whpx: enable arm64 builds
Date: Fri, 16 Jan 2026 14:52:32 +0100
Message-ID: <20260116135235.38092-24-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260116135235.38092-1-mohamed@unpredictable.fr>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: digriShW2JPS8kWQxuiS3YOOC9mdhVSV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA5NyBTYWx0ZWRfXzHYhcLX1Bdgi
 uOlJTJZxA8swHq5UKloNGGDPvy4ohbkFNTyEqaJw2KCDBsEv0CNG/CdyUml8pS0oUUYf3Ulu3q0
 +VJ9xkC2XJYKr5/W/SUW47bbHyOA06ezzBvMeuZDgJ/Y5FB27PFK024Gqu1/PQ6tOBG6aLBsQdw
 x1DWcRf/ayl7NXFQKYZgMt3k0V9uUOkZ/Eg84WOfls9LnUxqG8K6zQCnpTTAW+qw4qoMopC6Oah
 U5h9737/mMF8dWxu5bXNsWhiXAIyDWj0nA+c2hUXAIbnEUhbCLlwAXxu9QAWs5kM5au7oxqFhL8
 kdcq3YuLkEQqZTKXscU
X-Proofpoint-GUID: digriShW2JPS8kWQxuiS3YOOC9mdhVSV
X-Authority-Info: v=2.4 cv=H4TWAuYi c=1 sm=1 tr=0 ts=696a42e1
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=Ck9h3XeVBPDugYI9Na4A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_05,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 mlxlogscore=758 spamscore=0
 malwarescore=0 phishscore=0
 adultscore=0 clxscore=1030 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601160097
X-JNJ: AAAAAAAB0KwwxMzk+9youiqu9S57aY3Gg9yJ2GUmAbrg0JZ3F9dZ2ZRISHgd7kXafZNcT58fCKGSlYeRkjC0G47E+2thfJ+OL46Bhtl8acF43xEXXQvSMUUkNvcbJlNA6T4AJJwMKghude80CNcf4bZtCXEABdq+V+Va2gAAFZrES5rHFg4h47UHjCMrDkdGlUz12u7ufI6nPkdmFYgd3XbUPPNe8UXxhhTT0nb3woFhTdzD3XkYqwCW+3Uy2lNuGPdkut4hUBGWVHukOvnKQ0iugM67QrF+5WvPQNhfzOPBBbXLGqkyhP8f7nKGAo2SDbej1A956r3FMHgxVD7VjY/lKlFp1Vyg00Bw5opZWs3yO+pdFVlVXUoupwy1JmLUOo0mfi04b8FN99ZVZKBeY75zTCpzGV/SwD7tSLCDm5dLkbuHvjeY0b4/lU2m8GzF3aKgjd0Oc+nLbWi4p6wDA0vSnZi/eb9lc9U/nffYdEVImamI730cYhr9AzykbV25gHNOoF3U+R6tKMPH4Zj81I3KuMTkg6is+R5ZtUIdIo27ZTRUnYllnipTxQkRaGTXzjDpQrNGCPXb1tdIRY80xq2h3cyT2FnRgwzAwvdmaoUTog96uQH7YVTbXzxx+4WRDF1HexqyLOHr34+ih/J5fawdYUtFbvGlkUdGwOhP8sc7aMuDOdikfE1fmnpfnzvHykVjaHTINVJ5mJj3WqOj0O0sbs1cv1V1xwLbE25LTzlZcIpopBRhM7IuaoUcABr+raZKy/frcduju3iRtGly4GZaM/WqYA==
Received-SPF: pass client-ip=57.103.89.55;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
index 600c50007d..99fbf3ab8a 100644
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


