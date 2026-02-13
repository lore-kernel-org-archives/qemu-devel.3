Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751D3EF48C2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 03:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqk8c-0008Lt-3v; Thu, 12 Feb 2026 22:46:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqk8a-0008K4-78
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 22:46:36 -0500
Received: from p-west1-cluster4-host12-snip4-10.eps.apple.com ([57.103.65.231]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqk8Y-0005li-Ml
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 22:46:35 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPS id
 7721718002E1; Fri, 13 Feb 2026 03:46:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770954393; x=1773546393;
 bh=NfP9NhkIXfWFxsOWMzbJrX5g2XsAZ34OoMJgPQ5NTe0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=H9a5iMY71RX8nke4tNoqqG3Q/pL+PICs5af4Ke4e6MNEG2482Lhp89XjNw2DDq2Dd8VVpBmEMVBfQZ9LZMe9OyTgqHWdTwYVbMjeePf15a7gML/TdWqfWAcUw85ffzufzUrf37XlnvgPYgETxhbdv7DxNqElqBZRGOIP7ledZNN0II2XICiEY+onXdaG4KcljIyqUdpImYcqrL/hMWKO6j3ceLbI7DwkaV6XE5L8hfckIEoBVT23cgjdOhbAd0zlQ6gqg2M6E6gJGzO9CsCuCqpDM0SA3IyjkKZ5eRVKzcaTNbwlQ3ibSJUNB11S8PMgCPnRUPZt6wKaj1T60xFNaw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPSA id
 2DB1318002E6; Fri, 13 Feb 2026 03:46:28 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 08/10] whpx: x86: remove messages
Date: Fri, 13 Feb 2026 04:45:51 +0100
Message-ID: <20260213034556.13471-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260213034556.13471-1-mohamed@unpredictable.fr>
References: <20260213034556.13471-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDAyNSBTYWx0ZWRfXxxXhtvuYNTnL
 UdM2+5cRYuk1lWA8VHvuV6Jx3wjk5q58fcopufBOe+itAq3nee28uqboE0bziGbqXStcYLgpgs4
 QcwzpeaWBlp8xKnzdCvGksVxoXYFHLP76JJytCyedW6LzHHfVCuuQOlTzUBWYup0nzZPedswOJb
 azcAg9vmCH5pzijuX5QrUhCbxy6jCLaSw77n6p/1dHcoPGPTYfQE2cMw29TZo4QsCwBgVo/1dqj
 hv7zVS9wbRISWZWQCx4T72V41Wns7RcnXH6n7Z+v//zO7gHq6MHVI0meh3SNzrI8Uk7qar21Faw
 bVcar5sTFNcpa/75gTUUp/5ULV7DQaOki6qzBvf8u8aowNfDvcUp+JAbLAcbIs=
X-Proofpoint-ORIG-GUID: Mv84W_wcXPJsbF8_GxSK-vcXkZFYcZ7u
X-Authority-Info-Out: v=2.4 cv=WLxyn3sR c=1 sm=1 tr=0 ts=698e9e98
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=tHCKdM3VofH7q6B9RbgA:9
X-Proofpoint-GUID: Mv84W_wcXPJsbF8_GxSK-vcXkZFYcZ7u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 clxscore=1030
 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130025
X-JNJ: AAAAAAABU0/eBXE/FGf69TnZTYe+Td827Os1ZoyZrXFmOle0owSDEkGUePj4LpXmQHkp+ULIxCzSnl4ld0dZ6jQxSIBI6wshbKxlAZQgqbqJYLEPIIam/Q06EDBvI/58jfkkN7p9PPHBnN5CEl2X6kI1F9w3dXvsAsV0hUla2/gOQxADH9uxE8WltTZNandeXJiDYkpbrQSqrMajKbYxouQP1Y/MEojDnh5N4xzBdFk56GLxFe/AI2sHKJlzJV53/sVsQmlOgLe+JOH1yCOAZYav6PbskeDpv1wwG7R3IBpLtL/unwNko7zSnYGslMCXJF0ZF4VYg5RbtSmJGQgiVtCsr4cVvThzB431iC4xdo0BW6RaIPmj3Qk3LYsfMaBMGFF9BucH2Cv9ubkDCA1zNXB9B+BE163aflTZnZKCHShCT7Rj8TstrhjHC9EbBRLXpaq9pwe3ZNOu+mwyIzHA56tBuCZ4t8jl9iNB/V/H005maVvvHYVKp2zoc9z/L+iWpP2sm3dCaJJG3GQw9gJ11P3mlbh1Rm1DOz4dEtdaMQ3+K5VtyStLVbBVjQJ26oof6k6/CoBPUZh/klxTFfYz1OpPynx0Lk8eJd7oDgJ7j7mCZiQaTXjnRZYNEnxS7OndOJfBCgDobIMKV6iPVloe3ruAlr5HepiUsfkdHq4elsQ229uD7OHipoz/oTEErC/szvO+I+kybSdSUD5IpuJ71LTD3wMpMf4D0aMbki/ONlfxaSnOp4T6uD0DByxLGlvtM3IwV87A7ToddASvnAo8dpGENye+hjv73tuFpjbZ
Received-SPF: pass client-ip=57.103.65.231;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


