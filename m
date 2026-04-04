Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D0FE88D7E
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 04:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8sUw-0006il-Gg; Sat, 04 Apr 2026 00:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8sUp-0006eo-OD
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 00:20:31 -0400
Received: from p-east2-cluster5-host3-snip4-9.eps.apple.com ([57.103.79.52]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8sUm-00064G-PL
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 00:20:31 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPS id
 F2B34180016A; Sat, 04 Apr 2026 04:20:20 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775276423; x=1777868423;
 bh=jSFEY3OW57r5Gmf0SB6G349rIgUNCT10rXc1M/CBSww=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=QPwx+7z/FlhiJj233tMPLxZb8KZbr0cghtkPZbKIEfdS12IE/htmrya12CYRYd5dZA2siFihXwjlo4I9eBysuk+88589u9/8Y4I+lpxseyYh45FIpLghVpb2nZAJRoytH350kuF+Yo8n1/lW+fqBKf+CqJ3IIe8wyCg7Zjpyv4wlWBN2B04Gwx/JIkPykIymHHs3ZBgMYQV1grZd5RXs85siA2NYmcWqrVqs+AFq5PThGKaqx0zY0rnW5pU2fUgqwPlYr8n9xMAX9igUpmNJ61Rt2Z7AQuxQFNQpGFLcNK6MbKRlwkVh4LNqYVdaL4I3IDLE8GOcb0aueRav1Cs/iw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPSA id
 2949D1800146; Sat, 04 Apr 2026 04:20:19 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 01/11] target/i386: emulate: include name of unhandled
 instruction
Date: Sat,  4 Apr 2026 06:20:05 +0200
Message-ID: <20260404042015.86580-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260404042015.86580-1-mohamed@unpredictable.fr>
References: <20260404042015.86580-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDAzNCBTYWx0ZWRfX6dJJWTsAq5CP
 Q8cj5fMBdMS2jEf5cxVLyZG8S1MAO4hhL2iHyVkH4Na4DILzpSeZYwBDAlS7/r7VwKq7EUFizjB
 Wv12k8A1IuqG/p59tTopbn9GWOjuNT/HRS6FxJ+ZAZTOdHf9JVyRd8JlRYdwcQMNkDJvtqMS44/
 a4zNPrkEnUe/ohi6LmO6lZHf/he0W02i3E8NCnqINPQMw2zibJENtx7ZdvOUL/H/4Wo7fmJIS5w
 TYOl9uTmxwzHaE17qW5gskYzDyC/RM9+jHo9q30fgxVAr82ABlHMK5MlBOvwQ/z7QwafNBfme89
 5ewPqcPCN1UWCRBvDcd1BK4b5INNRsGhstKOE4TdYDkLODe5ApGeGq2iSdy9cM=
X-Proofpoint-ORIG-GUID: E5AwRs_THwTD60Lu73Fgkk9DvBhUO4oU
X-Authority-Info-Out: v=2.4 cv=GI0F0+NK c=1 sm=1 tr=0 ts=69d09185
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=x0iqa3ucmZZh0HPruXgA:9
X-Proofpoint-GUID: E5AwRs_THwTD60Lu73Fgkk9DvBhUO4oU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1030 lowpriorityscore=0 mlxscore=0
 phishscore=0 bulkscore=0
 mlxlogscore=900 spamscore=0 suspectscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604040034
Received-SPF: pass client-ip=57.103.79.52;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


