Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17374F54AC5
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53TN-000692-Sk; Tue, 24 Mar 2026 11:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w53Sq-0005t8-Be
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:14:42 -0400
Received: from p-east2-cluster2-host11-snip4-2.eps.apple.com ([57.103.78.85]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w53Sn-0005sv-9V
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:14:38 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPS id
 59FC21852A0D; Tue, 24 Mar 2026 15:14:29 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774365271; x=1776957271;
 bh=NZnj8yCbumSadExeNcgwgqV2muxnORrhx0HseCqyro8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=BBpOFmIY9jOYCzKbBcK1KyUjsIoJEJHw/OgAM6Q9abqceGxy7fcM2jHyC4rPym6T0ji/nBTh/bwL/cJYjMpgW7JzEa2p9u1oYAEhIUfO44LaJ8nMmNdBO8a7vId2++Nrb84B6HtQ2aaUuS6XSEKGJm6lR9rsEQaMnxidpSEdKBYZvJWzAH9TCsDMRxfi1JMDyHmg903FrF0h52axph7vB3QTAfvkKIGc+fpnVkKB66ZraIuJ5z4KriMOPcmtYt30haNbpoBro4Z9Wtt2g+xr41eZkGLgODkGYP7fSXKHmsOnVTidI/0rPgZan8L2Hcug8ThwomfAPx0sCvvmtegzVQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPSA id
 9108A1803125; Tue, 24 Mar 2026 15:13:47 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v3 06/12] target/i386: emulate: add new callbacks
Date: Tue, 24 Mar 2026 16:13:17 +0100
Message-ID: <20260324151323.74473-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324151323.74473-1-mohamed@unpredictable.fr>
References: <20260324151323.74473-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfX0Kqrv/S6y25A
 /pFs/V/O59/4uuAXWYhmX6+XFR1iyjkJPstm3gkE9PaqARVKCFt332uNJV1ahm3oOuIUoqtTfIw
 Ohiy5zrhTWYvHFF2yHgWsbqJ9E3Fx7IDOjW8PTybXL3WJ7U0RBetZkUdY+0/WL/QFeqFuiZ7TLk
 2nwsttObXaZUFfBGXHckw4rn6SGGzvrgYEub1T3P/HyO99bYf799ozoTnWNO+D0r+WggQ5fbF2o
 9fiF6ER3ltpA0oJLgpNUD037FqxcnG3C/yznBhV6gL5qjjvbBfjgJqYQvDBPCwDGSAwbNcbBTIp
 cd22jRR7Qmv0B6pNVeFUQbI/syVRM5gTcidZQcBa7OA98g9ICSkmctuF3+bm0w=
X-Proofpoint-GUID: imozCZEi2w2nkECidPf5DWTvyx7xNeJQ
X-Authority-Info-Out: v=2.4 cv=H/rWAuYi c=1 sm=1 tr=0 ts=69c2aa55
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=AM0uniIKGEjy2BpxYl4A:9
X-Proofpoint-ORIG-GUID: imozCZEi2w2nkECidPf5DWTvyx7xNeJQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1030
 mlxlogscore=884 bulkscore=0 mlxscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603240119
Received-SPF: pass client-ip=57.103.78.85;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Hyper-V fetching some guest registers is really expensive, so
add a way to query some state from information provided by Hyper-V
to save time on vmexits.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_emu.h     | 3 +++
 target/i386/emulate/x86_helpers.c | 6 ++++++
 target/i386/emulate/x86_mmu.c     | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/target/i386/emulate/x86_emu.h b/target/i386/emulate/x86_emu.h
index 0f284b0c3d..4ed970bd53 100644
--- a/target/i386/emulate/x86_emu.h
+++ b/target/i386/emulate/x86_emu.h
@@ -32,6 +32,9 @@ struct x86_emul_ops {
                       int size, int count);
     void (*simulate_rdmsr)(CPUState *cs);
     void (*simulate_wrmsr)(CPUState *cs);
+    bool (*is_protected_mode)(CPUState *cpu);
+    bool (*is_long_mode)(CPUState *cpu);
+    bool (*is_user_mode)(CPUState *cpu);
 };
 
 extern const struct x86_emul_ops *emul_ops;
diff --git a/target/i386/emulate/x86_helpers.c b/target/i386/emulate/x86_helpers.c
index 024f9a2afc..ebbf40f2b0 100644
--- a/target/i386/emulate/x86_helpers.c
+++ b/target/i386/emulate/x86_helpers.c
@@ -211,6 +211,9 @@ bool x86_is_protected(CPUState *cpu)
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
     uint64_t cr0 = env->cr[0];
+    if (emul_ops->is_protected_mode) {
+        return emul_ops->is_protected_mode(cpu);
+    }
 
     return cr0 & CR0_PE_MASK;
 }
@@ -234,6 +237,9 @@ bool x86_is_long_mode(CPUState *cpu)
     uint64_t efer = env->efer;
     uint64_t lme_lma = (MSR_EFER_LME | MSR_EFER_LMA);
 
+    if (emul_ops->is_long_mode) {
+        return emul_ops->is_long_mode(cpu);
+    }
     return ((efer & lme_lma) == lme_lma);
 }
 
diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index 4e39bae025..670939acdb 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -49,6 +49,9 @@
 
 static bool is_user(CPUState *cpu)
 {
+    if (emul_ops->is_user_mode) {
+        return emul_ops->is_user_mode(cpu);
+    }
     return false;
 }
 
-- 
2.50.1 (Apple Git-155)


