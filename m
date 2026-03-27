Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6527010AB83C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 01:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5vkC-0005HL-IQ; Thu, 26 Mar 2026 21:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5vkA-0005Gf-4g
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 21:12:10 -0400
Received: from ci-2006a-snip4-10.eps.apple.com ([57.103.90.140]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5vk6-0006Ki-9D
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 21:12:09 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-8 (Postfix) with ESMTPS id
 2DD601800791; Fri, 27 Mar 2026 01:12:01 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774573923; x=1777165923;
 bh=5S7KGKEy49UgCD0FUZ1I15cZ4AJCf9WeQ1uRb+nbjmM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=WEt13kj5l+4uTtz8PfYB41PuFuoko8xXoFQ52u2Osy20FwJF4gs9Qo6n7CIbntp+X+feNOydHQkRznFl4BsOUMJ2n0taVjS6MNzWfy4N9lJZywPlw5JqDulj13LQqGyO8b76xLsEl6k4ZORSBR6A3rpd3wmWnU+uMa/XzUsm2Bz2cvRcGVKHah9eF5YSbh62fzgh3HE7Gl9eYPK0AExO1HZDKdn5YX8U20RdNhTjqHlvHbiWQMLnibGgSvUvOEvVybErZH50KPSr2FDsi+CuXiTrXVr3i3gNKBBAbW6YgkK7BIAFVBKeJzgoWzQcVK8HkFfeXc46BDEBGNgXtUonCQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-8 (Postfix) with ESMTPSA id
 D1B1A1800144; Fri, 27 Mar 2026 01:11:59 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v6 4/4] target/i386: emulate: remove redundant logging for
 unmapped MMIO access
Date: Fri, 27 Mar 2026 02:11:52 +0100
Message-ID: <20260327011152.4126-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260327011152.4126-1-mohamed@unpredictable.fr>
References: <20260327011152.4126-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZydV8DToMU2TVMR528hx2macgQ-8eN7n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAwOCBTYWx0ZWRfX0WNvLpytuKvp
 2fIbTJ3KZxleyqhoBlYLwzF1Z3JwamY7MgJ9IeGV9neWgysEiRTkdE+WbOcOe3uj07IfJ7hPELi
 TMddtmXTWpNzuuKUQPyO5jc7O4PvU2WBlHWmji+FRy26kSl71ZZZqQXrMh9b8iRZhYDW4WF3z3+
 PiiA761jFpvFMqt+gwv19hAwT8bmkD3zf7hkOERfDfL+lRFP4+otVilFY7FCh63blh1FmsC1UPs
 uMenjWFx0JheLdARGCHoiZ+TJO0rHUMa+fYeJScUwC9DtifoEnHunTb8Ej6FyDwFeMZ88VXbgHC
 mySRrrnlADD/K5bDYfDCt5NlLXx5m3ACSX5sv9zOLY41XJC0wP6UobN2ABYoGs=
X-Authority-Info-Out: v=2.4 cv=PeXyRyhd c=1 sm=1 tr=0 ts=69c5d961
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=nKRBnGPCAAAA:8 a=Pf3sjxmatUTUh5CUccMA:9 a=JhrwjW1jOIvqYJKOqOMI:22
X-Proofpoint-GUID: ZydV8DToMU2TVMR528hx2macgQ-8eN7n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 malwarescore=0 phishscore=0 mlxlogscore=879 spamscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603270008
Received-SPF: pass client-ip=57.103.90.140;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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

ReactOS's install ISO does a bunch of 4-byte accesses
to 0xffdff124. This doesn't happen for the boot ISO.

It looks to be an access relative to the Windows KPCR
which is at 0xffdff000 but mistakenly done prior to
paging being on...

As this logging is redundant with -d invalid_mem,
remove it.

https://geoffchappell.com/studies/windows/km/ntoskrnl/inc/ntos/i386_x/kpcr.htm

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_mmu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index c69ae96acb..007de582de 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -21,7 +21,6 @@
 #include "cpu.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
-#include "qemu/error-report.h"
 #include "emulate/x86.h"
 #include "emulate/x86_emu.h"
 #include "emulate/x86_mmu.h"
@@ -287,7 +286,6 @@ static MMUTranslateResult x86_write_mem_ex(CPUState *cpu, void *data, target_ulo
                             MEMTXATTRS_UNSPECIFIED, data, copy);
 
         if (mem_tx_res == MEMTX_DECODE_ERROR) {
-            warn_report("write to unmapped mmio region gpa=0x%" PRIx64 " size=%i", gpa, bytes);
             return MMU_TRANSLATE_GPA_UNMAPPED;
         } else if (mem_tx_res == MEMTX_ACCESS_ERROR) {
             return MMU_TRANSLATE_GPA_NO_WRITE_ACCESS;
@@ -339,7 +337,6 @@ static MMUTranslateResult x86_read_mem_ex(CPUState *cpu, void *data, target_ulon
                            data, copy);
 
         if (mem_tx_res == MEMTX_DECODE_ERROR) {
-            warn_report("read from unmapped mmio region gpa=0x%" PRIx64 " size=%i", gpa, bytes);
             return MMU_TRANSLATE_GPA_UNMAPPED;
         } else if (mem_tx_res == MEMTX_ACCESS_ERROR) {
             return MMU_TRANSLATE_GPA_NO_READ_ACCESS;
-- 
2.50.1 (Apple Git-155)


