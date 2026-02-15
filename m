Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA9AEF586A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 05:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrUbI-0000S5-SV; Sun, 15 Feb 2026 00:23:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUbC-0000QH-Gr
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:23:15 -0500
Received: from p-west2-cluster1-host9-snip4-3.eps.apple.com ([57.103.68.106]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUbB-0004uj-3U
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:23:14 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPS id
 B812B18001A2; Sun, 15 Feb 2026 05:23:10 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771132991; x=1773724991;
 bh=Vttj+j51gIwe8qYZQGWWnUdsSAMgUnXFBJrpZ2xldhI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=CKQbGhf+P2ESvavJOA4jQHdiUleZ8Jgj70ueJkYYOf0Ber96XpweQnk9oUuq9z/P83XXCVEkeW1SjkOEs9ufaMAqW5cGM1bDb1n/OekZjotmNR7cLAz02heyRqMS2d2U4XWhZn3XgwmFjhuJQKPYtSbdb8hXScIIWRURqUfHA3iMyqKAHzhEXEsAUouiqh9piNJ1UJhgLkAkTdP00D+rLGvNfLS2sZI5pwFcdITazEPST8/cbrbvO227FPIasmJO/z36oIdC+xDo616BHR8LFtSJoq0t4HxtKVyZlxt7dWSStm5Wi/6HHF48Ph24SrwOINtWE0Cnr2I/fkUaOp0j6Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPSA id
 407EE18006A9; Sun, 15 Feb 2026 05:23:07 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>, Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 11/14] whpx: i386: remove messages
Date: Sun, 15 Feb 2026 06:22:22 +0100
Message-ID: <20260215052225.22513-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215052225.22513-1-mohamed@unpredictable.fr>
References: <20260215052225.22513-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=KqVAGGWN c=1 sm=1 tr=0 ts=6991583f
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=tHCKdM3VofH7q6B9RbgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: MJ0iRddAETSp_zlHWv_m_wMxGHpVuhZw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDAzNiBTYWx0ZWRfX8bcUQRoxhcYw
 sIaoRx5lxVYvd/TtL4zOOb6pHRM8tLCaHDlMTlbNb84BDO4dS5noPT/tDlqb0F7OpQrnekbYVvR
 FZ6m9rswAK/WZsfwYNj7dwbLG4JBQxbUWctadFLPsvdnVT7JQw5Ev5HLGviXs3TiUKiyvp7uRQi
 hXFHvgGKEKtNZHonWOVkC4nZvJlJC6yF2C+PhEfDOTfBOGDFOa7UeThyoR31sJ8bxwS6n0HkASE
 Ej/Z3z/4x9G8AxcrzHOkxanJv1hbU5LMdVmiOQN0uluN4PSCZHkP994xQQbvo/cq57CTVU2Ex+l
 eZjoZa8+gkAGZ0SJAppYYeUPqJOkH00/dwB2s6SpJb3pm0Csx+GuwCaIfrBo7w=
X-Proofpoint-ORIG-GUID: MJ0iRddAETSp_zlHWv_m_wMxGHpVuhZw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_02,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 clxscore=1030 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150036
X-JNJ: AAAAAAAB5PSlxgFnFJXOZsauCT+tptalWAeCMhi4TM9aFLGQ+PY+LfEtjZHPwmFAogIadNNwmV39bfJFH+wuG8+2szZ1DccH4EPZMQhA1GV4zEBgMs7wYi/rMqaoJGcx+EUNqn2zDaJisFeMzJonaA/lGJGSGgvpQIBCDLwLL51QynfPMbtWDtcyVhpYuMjkVuY/WyAA48spDWP+UdHBQNkK3F1PMQUNQtL2LLb/XwM9gGTZ720OZiUfucu7f34IdROlwbqtM26P3/blZfFxJwPU2aBeHGFwd8+/0ak4TXUcyGFkSf9Kut1fZvm8OwjT/dG30A8lCp59D3l3c9qV3uKkgBJM8GXbiFa/tNn+uzjDX4000B2LfOV2F4jFFSJmo1vhDH5nbI5ZLzSLJSKBMz1KU8smmFecv0RQwHDgq/Wwyie//jB8rKTnpCgvJxTYzj73kIgIycmioc2HtDIQqrKaJ1c2KeptAmvMh0l4c3Vhh6tk6/iSMggPd6X8YUZBQJ2u5UrlgejNYFnYeRvnPe3i/xfCm7lWYo4i7XYGF+4oXVL6XAa/WLvg5JgTQRMbLSTttfsYAO+eWX3wiw1iXfGOF0ecdet/I1/bltXyxo6UlakGQKaJd3/Bs8v+DpqlGfsbR6ImKYKvAB24InZWHY5RcOuy/frKgkiXuHGLcykEG1d5Vi4CLQm2kuOAIqWBDU7nX2DurkqkNG5sVAS5SX/xScoqyLr29B2yDi03cRjUPm40CNOeIlMnc0uVcDWL0WVUWG4TMp/GCJRLaK8+QgVll2DZTqpkiAbIvc4ahKZV/pJvYUGy
Received-SPF: pass client-ip=57.103.68.106;
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

Remove some messages printed by the WHPX backend that don't
have an equivalent elsewhere and don't convey an error.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/whpx/whpx-all.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index eabb0ef913..e815ca9bfa 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2161,7 +2161,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         whp_dispatch.WHvSetVirtualProcessorInterruptControllerState2) {
         WHV_X64_LOCAL_APIC_EMULATION_MODE mode =
             WHvX64LocalApicEmulationModeXApic;
-        printf("WHPX: setting APIC emulation mode in the hypervisor\n");
         hr = whp_dispatch.WHvSetPartitionProperty(
             whpx->partition,
             WHvPartitionPropertyCodeLocalApicEmulationMode,
@@ -2235,7 +2234,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     whpx_memory_init();
     whpx_init_emu();
 
-    printf("Windows Hypervisor Platform accelerator is operational\n");
     return 0;
 
 error:
-- 
2.50.1 (Apple Git-155)


