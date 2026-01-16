Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9020AC79FBC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 14:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkH0-0003nB-16; Fri, 16 Jan 2026 08:54:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkGN-0003GO-2o
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:20 -0500
Received: from ci-2004b-snip4-11.eps.apple.com ([57.103.89.23]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkGI-00028i-Uy
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:17 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPS id
 12C2B180F920; Fri, 16 Jan 2026 13:53:09 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=usn+5WRKOGJaDLoRmA1S0SGx2PVU5yWwDmjw2JCpvZ4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=bbTcOVaR1HRoBT9kCuQre+gfTf1YWh0bnSTJLQQAiqhMhjtqJUmfsk+zAL2CKktHfQFP+xHb5rdxce9m1UvLVO8MZhI59CBvI8G1TnwcgqAVbkTi062Gyk5DrOnIfwSxX2sny5G/610fmjxC9AQwx9Mudjt0HEhj9hoyEM+LOhXvhSdZ6OVZr1HBOosbm64up2mK7O13ydo89mljI6Jdjliv00KUoZKcWDib4Y3nVlZp1JQWtHh1N5d0XPGsxdRFHDAjFqgRyBYQBQ5HXbckTdULkW29OPHJ1X+HPaC+W2ZZIsE6cTpT5xhoJCUVw+L3b5p7mi4s0rmKs0aBY5IP4Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPSA id
 8E5AA180011E; Fri, 16 Jan 2026 13:53:07 +0000 (UTC)
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
Subject: [PATCH v16 12/26] whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
Date: Fri, 16 Jan 2026 14:52:21 +0100
Message-ID: <20260116135235.38092-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260116135235.38092-1-mohamed@unpredictable.fr>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA5NyBTYWx0ZWRfX+Se2HDRYoLyT
 rJEdNmB18SrwsxcjPGg5Hr9qTD3DAJghtx4piWdGWrX/GNfrL9F5LxGmryacvXB7XYF+LE/GMdr
 JRMEIt/FFSGMOUGx8gX+T4Cb9EKf9EJZL77ULVTgfnSMN7qylt0B+UgGDrTS8gg/R3gAQEc9eqg
 bIjreJsgZ5aC/6z7nGMx4DNX2ZmJaxwvKBXxsNmLUUDtRavsxpVdWIXvabYOLrKu1r3EHr+vLpS
 J+wXlxvOwL62rchgw8lN2Ta0aCXYQEc5dUbSbh8OeCW1+A52PAPg3r4f05H2zn1+FE0pbZNcXpx
 o+UDse6qMMFWiCeM1uu
X-Proofpoint-ORIG-GUID: 4DwXAfP2qen8uIIzVEchue9TeEM8-DW-
X-Proofpoint-GUID: 4DwXAfP2qen8uIIzVEchue9TeEM8-DW-
X-Authority-Info: v=2.4 cv=QrRTHFyd c=1 sm=1 tr=0 ts=696a42c7
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=2psWIPzlEfUqwKpUe20A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_05,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1030
 suspectscore=0 adultscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601160097
X-JNJ: AAAAAAABPEn+9ZKAE0/xM5Pa2cMDVGBfWEQE2EEmMOefmkALhX8QTSieCfj18+Pu2THBt+JLPpqTvI7XfF6u1oqNzNLUqx1sBo9UgqVCrEGEj6QoYwmWJIXvMliw6HneVnAY1igZmihx3GkEz/lvcNbxUCtP5VRhHqPQ0EO9FXN/XJcymypIXCS5pHn7UoU4OcPSJGGQOPPkVx59CtX16ECGHXpN4crvL+cnHCiGYZlmoiHZW4Ck7mS6bLtW/kQ+iQ7tE5o4+Ro5I9rqwYoEWfXZ9jWfZ/iBL5IjtJNv9v5YNUw1oXsMS79hDknBiC3GioF6KZ9w7tOkdwrT2AH8wUoyoc/E8rf8K6mJH2e3Dscw3BGO5RXvnrfxLDjN2MtGRgW5MxtaLqLxZqzd1yz2nSTZnzjF4Ygeof0+UGWrE4PjjAGGkLvfM4ltbgmwSwW/W5BX/ksZnBwtRUeMvE6sVbQ7OgLVHudloaBp4DAptFrJfn6YBIaaKxQQNwGH6XybPI5ERFLV+eKOs2g7iYs7pAxU7cGjlMoXTPFzZKFrrmTUzuTDsGQoKijb3Lu8bF2TUvFb/3XeEdfk5TzstiHlZbog0JDJ3kkQaYc1D/QAGYr6dkE4L4df66B0s0yMkgUvlY1mQrK9wnBg8hCblJKWHCskc39WFhK27PuDoUAR6xl1CXyA3J7LvRssVGPYirkFJjVVAKCcGDg57+1Cfmg2YtdyqLeUHIQEBjlCOqWaUIty1fJhMEiYrK8wm3GloL4IEg2tl5zwWI2Lm8jyDeg5LODYoVITU5xOjqJZpxTJd78A7Nl3Oht2PF1ovOkDF/KUaGs=
Received-SPF: pass client-ip=57.103.89.23;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

As of why: WHPX on arm64 doesn't have debug trap support as of today.

Keep the exception bitmap interface for now - despite that being entirely unavailable on arm64 too.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/whpx/whpx-common.c     | 2 +-
 include/system/whpx-common.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index c58344cb61..c0610815d9 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -119,7 +119,7 @@ int whpx_first_vcpu_starting(CPUState *cpu)
          * have one or more breakpoints enabled. Both require intercepting
          * the WHvX64ExceptionTypeBreakpointTrap exception.
          */
-        exception_mask = 1UL << WHvX64ExceptionTypeDebugTrapOrFault;
+        exception_mask = 1UL << WHPX_INTERCEPT_DEBUG_TRAPS;
     } else {
         /* Let the guest handle all exceptions. */
         exception_mask = 0;
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index 8f171d1397..b86fe9db6e 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -20,4 +20,7 @@ int whpx_first_vcpu_starting(CPUState *cpu);
 int whpx_last_vcpu_stopping(CPUState *cpu);
 void whpx_memory_init(void);
 struct whpx_breakpoint *whpx_lookup_breakpoint_by_addr(uint64_t address);
+
+/* On x64: same as WHvX64ExceptionTypeDebugTrapOrFault */
+#define WHPX_INTERCEPT_DEBUG_TRAPS 1
 #endif
-- 
2.50.1 (Apple Git-155)


