Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3A9D58CC9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 23:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Aju-0001PV-Bd; Tue, 24 Mar 2026 19:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5Ajs-0001Ob-Bp
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 19:00:44 -0400
Received: from p-west2-cluster3-host1-snip4-10.eps.apple.com ([57.103.69.113]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5Ajq-0005Nx-Ru
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 19:00:44 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-1 (Postfix) with ESMTPS id
 DCA5E1800134; Tue, 24 Mar 2026 23:00:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774393241; x=1776985241;
 bh=h6BCEexiKnIJ4dElCdsFAg+vCqFrz9fEh36i9zNBRo0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=UhGD1Lsvn3S3tcspS1bWjQ3xLFnyNrBm/vkJfoMkhc6qoKHqmMg9Q6kjZXSzlMfgheTulsf6MfZUJlObTzIFXUsouUb9i1ICoiAeNK8CkwBHMs2VXOzGGiuKna1zWZ23/U/wYCIXFSE1I4Gfw5UlRfarNl7svjOMxKtMtjX164nKokU0/KTiOjKYIxP38nLve9lsH6GSClZva4jq9jh74inEVwxFS42qGUr97L+xGsx7fHxRcdXXq1u+ye7jz6/FPlWhlDfPS5vnBER9o5PWqxdtMglkTspJpvY7cAT1PUG11f+fUTThtzlXLPKNfXM82oivvmX8RH5gw/vuXNSrWg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-1 (Postfix) with ESMTPSA id
 25C5C18004B4; Tue, 24 Mar 2026 23:00:35 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 2/2] target/i386: emulate: follow priv_check_exempt
Date: Wed, 25 Mar 2026 00:00:16 +0100
Message-ID: <20260324230016.80914-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324230016.80914-1-mohamed@unpredictable.fr>
References: <20260324230016.80914-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE3NyBTYWx0ZWRfX2HVzpwl4ANsO
 Jg+JVSJ3fQsTxdkkmRLjgXDGchvRxmF6ctbfvzrgaB7GgItC1jokk9k+2h8rkbT3KUPVFhqbYxj
 K1RAcBlznnBTpAnTu5Gqdb36lUECkb6wcl50cK7tKzCHW6KrIqovPTyYqD9EO6SJoxxPpJJ3sJ4
 Q/5C7j3rflruFQBLqmYcXMtkkjAVy5vk5ee9wJuEwW28QevwjMraKgOx616jjTQO9SfUjmxX2c3
 rnVLfcGiyCjAEYlQwSbdWnNdBLeIxznapz2BDC53Rnz9IHqKhjnZ6t0pF7p2iwO9PHO4Q0Y7Rza
 z7aLvoPcDbQ05DHIUqdzA/uAIYFRTLu6U0gWW88kDWwuxjyvhetgAMyZGxj6tA=
X-Proofpoint-GUID: R_7YNTz_t7dMH2xixrmqV9HSVYDG47NU
X-Authority-Info-Out: v=2.4 cv=bIEb4f+Z c=1 sm=1 tr=0 ts=69c31797
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mgn8cvGc-2BrUGjq9NwA:9
X-Proofpoint-ORIG-GUID: R_7YNTz_t7dMH2xixrmqV9HSVYDG47NU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=881 spamscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1030 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603240177
Received-SPF: pass client-ip=57.103.69.113;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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

Follow priv_check_exempt flag argument for
x86_write_mem_priv/x86_read_mem_priv.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_mmu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index 1aa373f5b3..c69ae96acb 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -263,14 +263,19 @@ static MMUTranslateResult x86_write_mem_ex(CPUState *cpu, void *data, target_ulo
     CPUX86State *env = &x86_cpu->env;
 
     MMUTranslateResult translate_res = MMU_TRANSLATE_SUCCESS;
+    MMUTranslateFlags translate_flags = MMU_TRANSLATE_VALIDATE_WRITE;
     MemTxResult mem_tx_res;
     uint64_t gpa;
 
+    if (priv_check_exempt) {
+        translate_flags |= MMU_TRANSLATE_PRIV_CHECKS_EXEMPT;
+    }
+
     while (bytes > 0) {
         /* copy page */
         int copy = MIN(bytes, 0x1000 - (gva & 0xfff));
 
-        translate_res = mmu_gva_to_gpa(cpu, gva, &gpa, MMU_TRANSLATE_VALIDATE_WRITE);
+        translate_res = mmu_gva_to_gpa(cpu, gva, &gpa, translate_flags);
         if (translate_res) {
             int error_code = translate_res_to_error_code(translate_res, true, is_user(cpu));
             env->cr[2] = gva;
@@ -311,14 +316,19 @@ static MMUTranslateResult x86_read_mem_ex(CPUState *cpu, void *data, target_ulon
     CPUX86State *env = &x86_cpu->env;
 
     MMUTranslateResult translate_res = MMU_TRANSLATE_SUCCESS;
+    MMUTranslateFlags translate_flags = 0;
     MemTxResult mem_tx_res;
     uint64_t gpa;
 
+    if (priv_check_exempt) {
+        translate_flags |= MMU_TRANSLATE_PRIV_CHECKS_EXEMPT;
+    }
+
     while (bytes > 0) {
         /* copy page */
         int copy = MIN(bytes, 0x1000 - (gva & 0xfff));
 
-        translate_res = mmu_gva_to_gpa(cpu, gva, &gpa, 0);
+        translate_res = mmu_gva_to_gpa(cpu, gva, &gpa, translate_flags);
         if (translate_res) {
             int error_code = translate_res_to_error_code(translate_res, false, is_user(cpu));
             env->cr[2] = gva;
-- 
2.50.1 (Apple Git-155)


