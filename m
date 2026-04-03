Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFACE85372
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 14:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8fSL-00058x-Jo; Fri, 03 Apr 2026 10:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8fSJ-000559-SB
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 10:25:03 -0400
Received: from p-east2-cluster6-host2-snip4-10.eps.apple.com ([57.103.76.191]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8fSH-0008W7-Ab
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 10:25:03 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPS id
 B4B2E1800F9D; Fri, 03 Apr 2026 14:24:57 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775226300; x=1777818300;
 bh=jSFEY3OW57r5Gmf0SB6G349rIgUNCT10rXc1M/CBSww=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=QiOTHyVBhfWs0nRNfodaKjBQXbkEsrSBPLnUwM2JtAkIsmAUMYpSwevVmnAOeMZ/reVnGWqcN4App9IgwU7T7f19e+q+91khuzkU9I/QQFHFNOp060T44voPSalZDm7ONrRzq07ObrlvQy8nYNKJmq/2X3lGq8ONStmhiApwErUwGx49unCJcjv72ZGfx9gMUhmliIB5cdp7wmT9+1FsSD89VuH01u+H0Gl4mIhblEaUJwqWOAdMv5XuyJkJwyLEebIsqvqKc1McnFcFtQxMaBAVR4hAp8x7t8yqLDm5h9SaL8FQaUzi6XxcNo3IttFURXCOLzRBt5BPKriRhIylRw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPSA id
 955211800F83; Fri, 03 Apr 2026 14:24:50 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v5 1/9] target/i386: emulate: include name of unhandled
 instruction
Date: Fri,  3 Apr 2026 16:24:38 +0200
Message-ID: <20260403142446.36964-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260403142446.36964-1-mohamed@unpredictable.fr>
References: <20260403142446.36964-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: x-9NNpEARmyAATwHdmOMhVocoGONG7lJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDEyOCBTYWx0ZWRfXz82qcSqbgKNB
 J3/OD3r0oHn8TSWwhBvxwg8BEIS08X9XDC0iQH39GSFYP7XZkUddfgIckXdry2KgrNDucv8qvvN
 9cZaA3XPp1KR3OwDx5lp5+Bf5TIGxfoap5+3F/SMqCNMVzQKma5OndISwKdA8jXoR27rF7F4Jyf
 jzZM65nBKG/MKjZbkKXZeGo5IUuU3gBYeV9dE2MRkvjEho8ewimbbzHv49uvnqIg3MPbi32rQFm
 3zgIJYviApv53a0rLoYMKgnsdHHFiKVEOWLc89AN5LrgS1ExMUJDXpJL8InrbEFXkjQXs5vgQDP
 mZGSgeXvJ7ab6zpqr9klkKapCur3bFkvbSZc8KUVqQgNEUGv/3K0xIhtgp5JW8=
X-Authority-Info-Out: v=2.4 cv=D71K6/Rj c=1 sm=1 tr=0 ts=69cfcdba
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=x0iqa3ucmZZh0HPruXgA:9
X-Proofpoint-ORIG-GUID: x-9NNpEARmyAATwHdmOMhVocoGONG7lJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 spamscore=0 clxscore=1030 phishscore=0
 lowpriorityscore=0
 mlxlogscore=903 suspectscore=0 bulkscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604030128
Received-SPF: pass client-ip=57.103.76.191;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


