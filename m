Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF32AF531CA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 20:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCOGe-0007Mi-Js; Mon, 13 Apr 2026 16:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCOGZ-0007LW-RU
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 16:52:19 -0400
Received: from ci-2007e-snip4-11.eps.apple.com ([57.103.88.53]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCOGY-0007tp-5W
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 16:52:19 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id
 7C3EC180016F; Mon, 13 Apr 2026 20:52:14 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776113537; x=1778705537;
 bh=jSFEY3OW57r5Gmf0SB6G349rIgUNCT10rXc1M/CBSww=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=UYw3IAS8ndwoCx3n0WEgDoCzqTCJ8txe9uVnnCUIgzMbC5dpjHhXaN/diBIcIbFTtQ/UqCqoF6C0FKZy4Bt+kCbK88YPBQeCqhPERqkwKPBfe8L+TD3Ydbt1E0JP6aRIj2LMfONVuJvYWRfGxt0NmcDLmBy/OIrCLIgmk7YwRakWz9OziZgwHLOyvU0nZf33wlk/liKKNLKEFveMlD0p1raCgNl4891C3DI6dgpyxw3bgSIARXQYtwwZxuVeT613kDVZE3I1lUbB4WtSx/CIlWzRqqZLXWseshyWo2GMgYThsKPKImCscRj9JxenSgqVqTPJDpOGnzvH0OEOV9KuGQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id
 7A2821800206; Mon, 13 Apr 2026 20:52:12 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v12 01/15] target/i386: emulate: include name of unhandled
 instruction
Date: Mon, 13 Apr 2026 22:51:53 +0200
Message-ID: <20260413205208.50643-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260413205208.50643-1-mohamed@unpredictable.fr>
References: <20260413205208.50643-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CYG-t-37XGIgiOmn8q8rFbJkxRSmFyj5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDIwNSBTYWx0ZWRfX6zaM1b+F8x5E
 AAF4SIc6iQBX3kJpl3H+wHMhY/FOneXGHqzXME/d55ea+ejC273l5ySHhBfoGO2S5UCajN64uiE
 XRCIEv4CU81QM/CNFTwLKQ9BdXOEqRTR9kdazRee1rNrZOXL65U8IrQnExChJk/+FF4VhcVrtc7
 0sIdfntHFU6GNCr4fAccCr6B6X1ABD5GkC4gcvkqq/x2K5VIlZKI2dyIVedLhljsWH/datPzP3G
 8l5CuX1UK2k46AR7vK/MwhLnUShuaDrrVQwYYmazjBKerE9KU3X8MujcMgRC2ltbkjOhiCI79I0
 SAKI+kyZSMgyyyQbNLuGrNaVPT1BI7juuwi9OZTgwWO3Fr2GQ2rZ8tvIVeI6JE=
X-Proofpoint-GUID: CYG-t-37XGIgiOmn8q8rFbJkxRSmFyj5
X-Authority-Info-Out: v=2.4 cv=DohbOW/+ c=1 sm=1 tr=0 ts=69dd577f
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=x0iqa3ucmZZh0HPruXgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 clxscore=1030 mlxlogscore=900 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604130205
Received-SPF: pass client-ip=57.103.88.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Instead of just the command number, include the instruction name to make debugging easier.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_emu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index 55b1a68eb6..c2da1a133f 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -1399,8 +1399,8 @@ static void init_cmd_handler(void)
 bool exec_instruction(CPUX86State *env, struct x86_decode *ins)
 {
     if (!_cmd_handler[ins->cmd].handler) {
-        printf("Unimplemented handler (" TARGET_FMT_lx ") for %d (%x %x)\n",
-                env->eip,
+        printf("Unimplemented handler (" TARGET_FMT_lx ") for %s - %d (%x %x)\n",
+                env->eip, decode_cmd_to_string(ins->cmd),
                 ins->cmd, ins->opcode[0],
                 ins->opcode_len > 1 ? ins->opcode[1] : 0);
         env->eip += ins->len;
-- 
2.50.1 (Apple Git-155)


