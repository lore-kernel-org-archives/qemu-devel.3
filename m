Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D35FCB638
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytmM-0000j0-VB; Sat, 07 Mar 2026 10:41:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytmI-0000hm-KF
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:41:19 -0500
Received: from qs-2004k-snip4-7.eps.apple.com ([57.103.84.110]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytmH-0001uz-3i
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:41:18 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPS id
 D854B18000BC; Sat,  7 Mar 2026 15:41:12 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772898076; x=1775490076;
 bh=XrC+A2cdwnTtrklru5J6gKiuM0nyKsFULUgUC4G4lrc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=DIPS8MpDjKl5sNNCcaUVFKHmk8sOhNjR+vh/oPZdCaNp2XrJC7Xc1f3LZpAn3PZp05n+i3yvNioqwUfP6HzOK4RSO3UrvBj10CR2BkTjXUB/Loz4Qe8DyM5etlACZOoSMGv9keZzIzgim0p6nF5+CE7YCzb3MvxCK+fqTE4CMFuo70bkdXnPKRLD5t2lEq/S+exaNzCiqrEb2T0Dhw0Wv8q0vvIIAADPCFmPDU/KfkQVD2pXN8sSeLmy0dQF5W6WABZYS0UI8jyOuRFGT6O0vk2r79ftkfFKYvON5J2jG14YToL0h3SzXhFAa42Sy+NFU5CMCnghawYPjSGdkA7BJg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPSA id
 4BBC11825302; Sat,  7 Mar 2026 15:41:10 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Wei Liu <wei.liu@kernel.org>, Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v5 2/9] meson.build: older macOS targeting compatibility with
 macOS 15.4 SDK
Date: Sat,  7 Mar 2026 16:40:57 +0100
Message-ID: <20260307154104.84567-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307154104.84567-1-mohamed@unpredictable.fr>
References: <20260307154104.84567-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FW8S7K-Y2vpRuCXyuRyrgQDZbwcvliec
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE0OSBTYWx0ZWRfX9Rx3LngyKgaW
 i6TbgXH17sBZ91Pwn/D8PSeBc80xSWW7PPt6yKg3DmWcRah4qbnZv6G2qUoK/BeZLwsvfEJgK9g
 DcG6AI8JjYAG8PiffYqOI5yOEJTMXCxQSnkv+VdUW/Va56PJxAaTYEfHYi+zVRwi7evttnd5ivb
 1qMFOU/j5Hhlb59bgmh5XeinXVYZjfoHEmQblDk0IBiFV1NgzHK+oDczwyjbRD+diI7vRhnCRMY
 aC7nc7auNN0eTbRVSS3eJNUZbqHkx6ydsGIjCODAO3cmQFJq/JxjfsV83TjKuRNePBoGXpJaU8q
 H1wyI0BpfT6Ozavy/eWw1gMs5m0odejthp14tP2KYs4bF4lTQTLhPgBpNXeSfs=
X-Authority-Info-Out: v=2.4 cv=XfmEDY55 c=1 sm=1 tr=0 ts=69ac471a
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=11mQs7XRU_pcqQXa4wYA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: FW8S7K-Y2vpRuCXyuRyrgQDZbwcvliec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1030 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070149
X-JNJ: AAAAAAABJaAZRThjeL+VdbNBBO+NsGQUxrZeLv64CxKjVb8mUKzR8wQ7oH4yfhTREVI49BfUO+unMaYmf0X+osR1F4Kf038V3oMvT/reyzfuTfB2dpH0NFZEA5gVy9UAYBhW32z05f4YrRLZh2LSMhCGlUHnfMkiwzp2iJtnSDIP10Jx5v5tml7rGCgdzK2OXNkN9TsLvw6e2JRcon2OLAAaE6RzyRvd8wpyPFBOwBtSWM8b73lzvjmmFidrdMsWvLQpUv+GrGFSPILdwh5bhtvuxPjZ+3EDsDkFow5QTkmCuKFtt4DYlyKEjR+2GT5QPD9LnQxHK0ww7iz16xU9nsWJINBFscRgBQdCzO4xi1PixoBV6Ipg90ZgsC7STwJho+tDrcdDKLfeNKZ+90swAh+TPHatZZvK9kgz+LzqePIKy1s3ViN9AH+UrBfeQA/yb69TarsgwknNZXcZVIcUoml4ReSCPzD4KpQVzYZ14+N1lUPIKHg/8SLJrXuk9tuoTGN8SugWXx3t/Jr/wD4PBArc6hGCTCG/9O5BOWXGIq+n52MJA8H4IzWcFlsiyWUcRLuMlHq9ExZxSWL/crgHMUhYNcwbesGvKOw4C8NlmDbjgFnu9SZwAxrk7MuW90cCKhADgqn8hk8MqnmxytueJUBjk28Ki4IQSov2OLBfZYsVPGQOVtNKLqT/pU61XGLubB3e03ny5Aeg03xPMh8aqyY05ip/fVkLCtVBq1fbch9tqVgSWZWPO0vmlWeK2G3dSt7+QsIDao3rRa7vjAztJwllo4mbESeRvQzM
Received-SPF: pass client-ip=57.103.84.110;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Using strchrnul eagerly results in a failure to compile when using the newest SDKs, with:

error: 'strchrnul' is only available on macOS 15.4 or newer [-Werror,-Wunguarded-availability-new]

Working around that by not using strchrnul when targeting macOS.

This didn't show up on the CI because it used the macOS 15.1 SDK instead of a macOS 15.4 SDK or later.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 7b4e5bc72b..78bde0611b 100644
--- a/meson.build
+++ b/meson.build
@@ -2646,7 +2646,12 @@ config_host_data.set('HAVE_COPY_FILE_RANGE', cc.has_function('copy_file_range'))
 config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs'))
 config_host_data.set('HAVE_GLIB_WITH_SLICE_ALLOCATOR', glib_has_gslice)
 config_host_data.set('HAVE_OPENPTY', cc.has_function('openpty', dependencies: util))
-config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul', prefix: osdep_prefix))
+
+# strchrnul was introduced in macOS 15.4.
+# Keep this condition for compatibility of new macOS SDKs with older releases.
+if host_os != 'darwin'
+  config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul', prefix: osdep_prefix))
+endif
 config_host_data.set('HAVE_SYSTEM_FUNCTION', cc.has_function('system', prefix: '#include <stdlib.h>'))
 if rbd.found()
   config_host_data.set('HAVE_RBD_NAMESPACE_EXISTS',
-- 
2.50.1 (Apple Git-155)


