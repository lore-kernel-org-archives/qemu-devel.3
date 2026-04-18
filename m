Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA1BF99C9C
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEEEK-00060Z-VD; Sat, 18 Apr 2026 18:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEEJ-0005yZ-AM
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:33:35 -0400
Received: from p-east2-cluster5-host1-snip4-10.eps.apple.com ([57.103.79.13]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEEG-0004ni-RM
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:33:35 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 07FB718000DA; Sat, 18 Apr 2026 22:33:27 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776551611; x=1779143611;
 bh=jSFEY3OW57r5Gmf0SB6G349rIgUNCT10rXc1M/CBSww=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=YmFCPvOq0bVJOuuF9FcdQr0FHRSGpb7sEwk5rWG6ZbiWJS7WNBYW+kaOfY3CCKR3Ygdl1uahohfBl1BPqbg6KE6QiU+vBD0okv5vtSo7wriuxgU9w8CyfcA8ax5BaZbx0ZdWr9EPP8rGrfQJyl1BeIA9Qyx6cJeFUsPLOYP9ov1pa8dnch3L6YUoU5LA4SwSoFXxhjONAH92b6nNDr+xLyb2Kee7BwOBMIF4EBDNzQSF3UMQNajeR8+/09tMUpkt93ZM3u3IHLkSPmHWVU1ybuURFxXSKjiqtqEPRouNA8XtewUggJLf8K4bI16uHlk8M+5Pm2AMOHcSsR5vAivCAA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 6B9D618000B4; Sat, 18 Apr 2026 22:33:25 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 01/38] target/i386: emulate: include name of unhandled
 instruction
Date: Sun, 19 Apr 2026 00:32:43 +0200
Message-ID: <20260418223320.51330-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260418223320.51330-1-mohamed@unpredictable.fr>
References: <20260418223320.51330-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vaelIETl6ub8dSJcbBAp2zD2jtFNN4yo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDIyOCBTYWx0ZWRfX4RXSX5APzg+C
 hD6AJYqt1VoIzAqoXdavtFb0Fre+EtvHDcnP2lRWl5mlmezM0J7vxgL8wKUa4ymGmijV58x+Wpr
 OmjQ6kUgJyQI2/bwk+Rp61VFvI8OjT9DGYtiK0SddLII8BrxVlLeGEHkxJyIf5J/baLNjEON6xK
 6HrbL5LnKSIZmSixZRxVh0Y5CmSJAtqEehofR8zpzlfusB96OEMOYU5CDLnHVuunZM+J7UcW22F
 VC3eEtT+3ZKstAz0j0dcExDY3pAjI1y1iK6ginCAsczh6LqHm/+oITShQ2Vd0KemsqUFItCzpTZ
 2bpNhxJ1y4hl5tgK/O/LOoKWsKn+Mkv1jhArfOjVhig9ExBaFa4AcS6QVOQ+aA=
X-Authority-Info-Out: v=2.4 cv=WPxyn3sR c=1 sm=1 tr=0 ts=69e406b9
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=x0iqa3ucmZZh0HPruXgA:9
X-Proofpoint-ORIG-GUID: vaelIETl6ub8dSJcbBAp2zD2jtFNN4yo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_06,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1030
 lowpriorityscore=0 mlxlogscore=972 phishscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604180228
Received-SPF: pass client-ip=57.103.79.13;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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


