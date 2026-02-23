Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E22E98E06
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRSW-0000kf-R8; Mon, 23 Feb 2026 03:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSN-0000QA-7r
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:22 -0500
Received: from p-east2-cluster3-host2-snip4-10.eps.apple.com ([57.103.77.231]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSK-0002Fl-B4
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:18 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPS id
 A57201800213; Mon, 23 Feb 2026 08:38:10 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771835894; x=1774427894;
 bh=YKGmjTwasOTKHJc2TN0N83W04DQ/70JvOkGojdqvAPY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=L44vC6hLQ1BFnVyABO6kJ6U2nLcWWgAdL2D77RGVeWtc+hYsnpxJbMVcysroL0sTPCu3Zcp7/DtZKSmx+mi+Q6tClpYVL1TzhyzmCw8f+6euVl7Kf7dKcbX5KTBZMm6vt6/rOtrKWsdm2ja/fJmLSOg2y0AoNvOwg19zjukItlCWuB6P7gp0z06yFLnOM+u5nioQDVGMOfotHO8/f/X4F03xQX+iZa0UUUjfB6CLvRkhY7Q0uh8WMZvtFrS5q4XLSyTNDmD6zwum5kOwFAdC6GsI/dkYop+xvdeaPch7x++TkDz+Dat/bE1zVuoIq7OrshcNjaQA0g3LEVIQdzzCJg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPSA id
 E2C20180016F; Mon, 23 Feb 2026 08:38:07 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 13/27] whpx: i386: remove messages
Date: Mon, 23 Feb 2026 09:37:19 +0100
Message-ID: <20260223083734.48533-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223083734.48533-1-mohamed@unpredictable.fr>
References: <20260223083734.48533-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfX6kHtHgqPysUD
 ULzNFQ8nnuLk0Gvv+FiOiP1xvuXVh4yZCj7DkorXBgwnqb5ei9M0rXbbhiBRxFYG+ZfddrhX8c7
 kapw3MsLLlTtUAQ5b6Xc+NCoL1C+Ghv4GrREKk3Ws/eVF1U45rxh7t+Tg0mXpQe0uZuWXV0f+lW
 MwSCiHinB+uL70JvCh1wsZaSUzoIfs/+TBz0qxQQvMU7WG9CAZnPIP9CUi2gkaGJ491FUn8b74G
 WogH67xYHSDvuJJLS+DimsRc+awTCKp26AqGPHpxyRoUggSVMN60Rpe71H5GDia5jmhbKnyyoNO
 CTaHeMefY4DSiHfw6yePCgEBKrE2dAeXXJRiu0bHAp9boXSBPhQqdXuAu4ZPe8=
X-Proofpoint-GUID: oM5km0EWyGKi4mm0glYQ-6Oxkd4pr1mJ
X-Proofpoint-ORIG-GUID: oM5km0EWyGKi4mm0glYQ-6Oxkd4pr1mJ
X-Authority-Info-Out: v=2.4 cv=Ra2dyltv c=1 sm=1 tr=0 ts=699c11f3
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=tHCKdM3VofH7q6B9RbgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxlogscore=999 spamscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230076
X-JNJ: AAAAAAAB3NZcXgrYcCl8tvGPtUGVbRvvj8yamMnZBrQjUMcZAEPolQfjIbkLiETP1RVClBCN4/bvPy3632Tij/JiyG7FrsPncwnIORv5axVJtmVEe2i/RubuoTNKOV/DTfZtu1MvHOkqUST70Ko72qONahewQRp+Gb1ehbS62jS5G1AnzOzO3HQj4Wyvv4UKdbOKg4Nf9hPoe6AlKHBxqWHlBCWyJATk4NeRtBPa0tTRzB3sLKT45rlQ6tmblfZGB+914l+7ChwV9HQyYaeNTDzLjhKTqJntYc7iSPg1KFlIhCoBnaFVFPLBjMxXZ5aHHRy7sqquwcbwMkQ/Mc9+hmfgGzHw3abRc1jLf3KIPGZacOmpsWMcigcGWVjv069c4LXg9kgC37jnA1o6giKaau3B+rD3QiCVkuFEpyJR7Vfh3E3smPNiQgpQiXhv71JHvmKH3kjfflvNZveB8/3b9VI1JfuXlkJ2Vb4rqkl8cy1m/Ittli9IJJXuShwuH3fkJI8wClTk9/gMDmCoITafFEEFEFHt+xJDn7+wK2TEtq6ymcxNno7C8uJzBP9twCJa1DtHazIS/Wm4MIvWAfASb49h2r1xucwSZKEH28KjxLPbnAFUNMUcjE3GMRSwvSNjBmnnWD9eJgs/r/4NgLEnQfYtMRLECeopFA8/GnOpGrCk7l38ewNF0d8lBfit01ac4ahAZa7c69diiHynBmWmHS+gxBiBL5AbT45s95nUnziKNsCmPpYA1yJPLnX/Q2pEJDEzOX7phGGeIX+WOYu/R5zmrlx6UBg+uzv7Tqp/6mZ+vO9lRF1r7xE=
Received-SPF: pass client-ip=57.103.77.231;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
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

Remove some messages printed by the WHPX backend that don't
have an equivalent elsewhere and don't convey an error.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/whpx/whpx-all.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 0524885053..2f2c613eda 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2163,7 +2163,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         whp_dispatch.WHvSetVirtualProcessorInterruptControllerState2) {
         WHV_X64_LOCAL_APIC_EMULATION_MODE mode =
             WHvX64LocalApicEmulationModeXApic;
-        printf("WHPX: setting APIC emulation mode in the hypervisor\n");
         hr = whp_dispatch.WHvSetPartitionProperty(
             whpx->partition,
             WHvPartitionPropertyCodeLocalApicEmulationMode,
@@ -2237,7 +2236,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     whpx_memory_init();
     whpx_init_emu();
 
-    printf("Windows Hypervisor Platform accelerator is operational\n");
     return 0;
 
 error:
-- 
2.50.1 (Apple Git-155)


