Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093E5CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 20:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9UTU-0005oO-PV; Thu, 16 Oct 2025 16:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9UTR-0005nE-TI
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 16:21:21 -0400
Received: from p-east2-cluster5-host5-snip4-2.eps.apple.com ([57.103.79.85]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9UTI-000101-Aq
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 16:21:21 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPS id
 5C96618005FC; Thu, 16 Oct 2025 20:21:08 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=zNv66cYWOjcoM4iD8mPZ0d3N5D4+2q07Wwy2NtrQNPs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=W6ZRRW9WjVcT8LadtoaMwzaFSPveccJgZpqgCGUwbb4++wZFIe3uklFZ22J/ShTCYlW3y2q65yNfyKzWYfdft5yxak91pwO0/aQ6DO1M6ROpaZw8OSGN8J9M8BNmL9zUejgcWHxj66ZyVrNFFa0Oau2uuerizxd7CxL/QdMbEv2Yt6pO4j6Vw5InAk8CoCnt4gkg5qsiuJWzNCLALPOTZcSH4Dla6UCBPM9KDn/HzpOkrXrFzjNLcQIjW03D3kYG64g4FHcdCq9Ts0+zwJl+gNqnGZyJZ+rUWwwZeY8J25Axg3q9jr+ae/y4/6e5fWws+p2/BB8bhaG+CsgG7wwDeA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPSA id
 0447418002C2; Thu, 16 Oct 2025 20:21:02 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v9 09/24] whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
Date: Thu, 16 Oct 2025 22:20:29 +0200
Message-ID: <20251016202044.75261-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016202044.75261-1-mohamed@unpredictable.fr>
References: <20251016202044.75261-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDE1MSBTYWx0ZWRfX3e7cXEZdh77M
 vzVYkV/+Y6Q+zdamyj7Mr4a6JW+CP6YIuxx0nnUJzG1wcWx7bRZquSU4BXBP0IYTGE2FPWST4UG
 nOZ9ZOkX1OMoBFdraK7fY4dXuNxIYXDfSKt0iGrQsl3a7QQUVEtOgNCjdbq5RWNIo02UL2fK1vd
 uJE2/ZxSXzY94PDBU0NSIjZjw3Q1qA7s+H+eN9mkxLDD4IGQTT+i5QbbH/w5uF3lz3Tl4QKMu70
 7ja5yTCK6cnbX/whFtNE+FeX/Xmlg35EZfv934ujXJBjySIRyGnw6GvIVZiW66gvU63JQVEXU=
X-Proofpoint-GUID: 5O3kbIDbN_VMbsOIEKtupij_8oXVRtp8
X-Proofpoint-ORIG-GUID: 5O3kbIDbN_VMbsOIEKtupij_8oXVRtp8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 clxscore=1030 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 mlxlogscore=885 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160151
X-JNJ: AAAAAAABa3LZafIKtXnsOJlE7Nvnk3R1tFLJRYpESo/qBOe75Ha8TbQgIgKta636QY6sJK5iryB2a0vWuhtTurs/NSNzf0FDkRXZpYvxFglaPjWAI7RPOm5fPVNaG0s9w5dX+dXdm4/bWZ+Gi3uO4Q8xqfuBqQhBsnMuK1De3p/ccpkBtZYnf+ddd8fAZAVB4yly+l+JxykBkhGrM3IoGlyTVgwwCa6UO+lNdbjfNq8OwiZpMYGd2swk23eFEai+Q/xnJCBmlyjGvw+Y2ucBnpHaxcnghAJ3MOHD/S4HWodzIRJrHEkkOA2yfRU218NgXbM7c+qyJVNwZEQBNYJ1as7IHu2oo6AC0/mVmUS4WLPcYfAirF1nsKpRwdPvhURu7t7/WRzy/tkK3FC53F7ksCbOLT5N68bKUi91+MyUmA5ughKu1Bvx3IDZfOer29AfM12YyizcwpOMV3sX1qgnKpw6pHHSU8Su3bjbqyJwamSPvANsDouAiRNk7TujaR0BALR1YhvVW2xNfgeRmw2gDBLX0/veXgknAVMtHrT+quGjvU2Z9IF78932zrgA5DjlAV7tzkpk2lw1TmjLBtnALCnObHOkpFTkBDlzUPrGvKfSONxI/G+LAO7ZNJDAWUY5nYMRHnAx3G+FHSrOx4VdsQfe/v/8jr+EFgFHqtCZHgYqrgCpuYIGRoiObruiHFci8Dr6S+4VIpRp
Received-SPF: pass client-ip=57.103.79.85;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

As of why: WHPX on arm64 doesn't have debug trap support as of today.

Keep the exception bitmap interface for now - despite that being entirely unavailable on arm64 too.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/whpx/whpx-common.c     | 2 +-
 include/system/whpx-common.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 95664a1df7..c0ff6cacb8 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -123,7 +123,7 @@ int whpx_first_vcpu_starting(CPUState *cpu)
          * have one or more breakpoints enabled. Both require intercepting
          * the WHvX64ExceptionTypeBreakpointTrap exception.
          */
-        exception_mask = 1UL << WHvX64ExceptionTypeDebugTrapOrFault;
+        exception_mask = 1UL << WHPX_INTERCEPT_DEBUG_TRAPS;
     } else {
         /* Let the guest handle all exceptions. */
         exception_mask = 0;
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index 7a7c607e0a..73b9f7c119 100644
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


