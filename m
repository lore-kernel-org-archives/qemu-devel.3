Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1004AE9462E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 04:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpf2H-0008UA-SI; Mon, 09 Feb 2026 23:07:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vpf2F-0008Tu-An
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 23:07:36 -0500
Received: from p-west2-cluster4-host6-snip4-5.eps.apple.com ([57.103.69.166]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vpf2C-0002Aj-P9
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 23:07:35 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPS id
 01C831800165; Tue, 10 Feb 2026 04:07:27 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770696449; x=1773288449;
 bh=T0iU8wJ+vOOlSFXGIbgkfVg9I+JFCy6eqso1D1hnxzM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=f6k8Zn1OMy5xwL0bT87PmVhhbiG4XoImCDCFFmCQh4tPRQKa6KLCzLLD71ouQuqFkplj95Sl8syrqP5/GoHJ0Lq/EGkyQDXPCkD4Fg1gA7dMMOhSEofKs7F4kpcdgWvvjAH3uZGAKwLdmGpp08BBzEr/5fc6SJefppPv90IkOij0uSLGynkxxorl6ddGrWx4Y2NaJA7he76u+NwgBEZNTx9jyPu82cN1aKpGyoZ/t2X/KUU9jJe7JMQkWsYugPCwM5tLxLfsB3adL4cWHFm0hTYHMApu+leT1gd7MQilMCmoDw7BK2fAhaMefVywvbxA5wGIiFApc/aeZWWezM2Yeg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPSA id
 BEB361800163; Tue, 10 Feb 2026 04:07:25 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 1/1] plugins: fix cross-build using LLVM for Windows targets
Date: Tue, 10 Feb 2026 05:07:22 +0100
Message-ID: <20260210040722.11375-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Mv8tKwJXjdyYFrYOrl8O4j-0NcUC2Ejc
X-Proofpoint-ORIG-GUID: Mv8tKwJXjdyYFrYOrl8O4j-0NcUC2Ejc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDAzMSBTYWx0ZWRfX+ddsVPGx1Tbe
 hy4eZXsjmNgmZRqXhlNgqH8IXsPiW0lMTiWew0KXbCdfH8ExDm9z8dOhmSO/vp1+qsH7OQ99dZ0
 ilyS9PZygFYQSOCQ4RkKYLeDkvzHoJocpxSsr9+CSPs9jgOE+KVSNUlNo1wTOi7Rr5xOSJwI5RG
 lK8hk3UTnd1rfbexjYQRbmKlgvltJeuUTa0QM2ENFs6upLmSs8AAnAej706fBc5K3aNWLtxyGJF
 nUXdsYkKNYOFCC4oalGQWNJreERzFcXXWqdvMLBu1/RQDMnuKbBcY0+JRfFYo00nCPTL4ZuwNBa
 x1gCGx2uLBmV4gqvOJt0UcYniyiCFzw2j0R4OH854UxFlzk0OGOo+5cudZkpys=
X-Authority-Info-Out: v=2.4 cv=LPFrgZW9 c=1 sm=1 tr=0 ts=698aaf00
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=t9XZTqbI_2a7PR9UbogA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=828 clxscore=1030
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100031
X-JNJ: AAAAAAABfjHdVqY77Q2YY/3OaIuMrFprFTtLN265oPJSzCahcWKist7UWRsATrGLlj9y7RKEUdFvLJggD/RfH2HWQ3gyzzM3yXkdfgQlKJOm6f3Bj1/XRKcVwgHpj3yU4fFVXJKDWtEPDgoarYR4s7d+qy8nqFHxLfK7nMdj8D/so5aEFGG70KWy+vLprZZ906t2xuth/M74/FkYDWsLnwoKdb1WDwCUmHJfLEfuziP0TxnB3qrDqKyNd9HlFCmMaHZFTsehWKtn+rILxKyZo44ZJpLHFlCbass8cuFatJ11HbIJkwX2ZwXJinMr3ja7RPtH2EF1e2mXsl8z6aG6sycgpydbsvE7fI1+pdsKfdhcMuuQoAOIZLXk2jbe47F3weUt8jJArgCCxm7DoBTUq4imUvP61deppgPdyemokd6U78rrPzl95hFwm28v6d/n7aUs9QdXXVvf1cgQIKRaFOw2xAQV361xB8ceLjiYw16w/40k8OvldJ2FnKleHrER/vhzWujKwLgZ5CnuC9zR12RLZAI4AeVqsCfK2Uob6cLt3mqK+zbpbLXeB8ZZUZxWJd6yuEXLyEssS5pLqXtvZ1IllfJxVDEDyb/2th1Y+THZLm7DUEpYA0HBZyWl7sUADQI9hxKkOsgCaJLH0JD5tHj+0frkFLTyOg==
Received-SPF: pass client-ip=57.103.69.166;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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

llvm-dlltool assumes that it's by default targeting the host architecture
it's running on. That assumption doesn't hold true when cross-compiling.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 plugins/meson.build | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/plugins/meson.build b/plugins/meson.build
index 34643e2cea..9899f166ee 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -41,9 +41,16 @@ if host_os == 'windows'
   # to find missing symbols in current program.
   win32_qemu_plugin_api_link_flags = ['-Lplugins', '-lqemu_plugin_api']
   if meson.get_compiler('c').get_id() == 'clang'
+    if host_machine.cpu() == 'x86_64'
+      dlltool_target = 'i386:x86-64'
+    elif host_machine.cpu() == 'aarch64'
+      dlltool_target = 'arm64'
+    else
+      error('Unknown machine')
+    endif
     # With LLVM/lld, delaylib is specified at link time (-delayload)
     dlltool = find_program('llvm-dlltool', required: true)
-    dlltool_cmd = [dlltool, '-d', '@INPUT@', '-l', '@OUTPUT@', '-D', 'qemu.exe']
+    dlltool_cmd = [dlltool, '-m', dlltool_target,'-d', '@INPUT@', '-l', '@OUTPUT@', '-D', 'qemu.exe']
     win32_qemu_plugin_api_link_flags += ['-Wl,-delayload=qemu.exe']
   else
     # With gcc/ld, delay lib is built with a specific delay parameter.
-- 
2.50.1 (Apple Git-155)


