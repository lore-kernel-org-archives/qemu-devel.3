Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF71EF99C9B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEEFD-0007BC-6q; Sat, 18 Apr 2026 18:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEFA-0006uy-H4
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:28 -0400
Received: from p-east2-cluster1-host10-snip4-10.eps.apple.com ([57.103.76.123]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEF8-0005Cx-Uo
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:28 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 8FECD1800223; Sat, 18 Apr 2026 22:34:25 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776551666; x=1779143666;
 bh=MdExfT43UhW0TEktVljSUoe2lp3EKCmf2xhHSOPb+jk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=RHSeQFJXEaQc/01mwAgfszUCMPCwIBhULA4qa7hIhOPOAgTQ8uPKhui3Ktf2fa2BIQdQOWZYPaXOwyiRW+KQwtPaHFaKM4mCPqInJ7k8VmERfN2yuuLGdZNzA7nRxd9Eiw67CVg9dNG57cGAL853QhDaOAuQrhK/QudiKJhdZvGnaL0F2Qzc1AdpLLQ8b7r9o6sTvLQ83ox/0RHSocaSWPtWXQkRew6kDYh4wisBLuveWRyLCu5S5emwPUHpe6UmSQ2ge2zQpgfb7O5gsKBbyFxJtqkmIWD2IzQF+qStPpVIaI3JbTpj7Xzpy9Pz/iJRM8fxsY0tE6UJb9kEFnge8Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 B364818000BB; Sat, 18 Apr 2026 22:34:23 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 33/38] whpx: i386: update migration blocker message
Date: Sun, 19 Apr 2026 00:33:15 +0200
Message-ID: <20260418223320.51330-34-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260418223320.51330-1-mohamed@unpredictable.fr>
References: <20260418223320.51330-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=OoNCCi/t c=1 sm=1 tr=0 ts=69e406f2
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0IeqtQ1xXW1zzRo-U5sA:9 a=ZXulRonScM0A:10
X-Proofpoint-GUID: YM4rWn84DvxPSWo21FB10KB-tJvTSdU8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDIyOSBTYWx0ZWRfXz6up2eHRnzXT
 S9Npb9zDQanA/RIEDPU0XJyr+nHuZgR2svynkraNrNoZyoN/DC2A3hd8/4NYeg+cppiyT5n2eMt
 UrPh6j56YFV9YATxrI6yYt2BNC0IcsaVwJ6YbBmYbinXP/CAeawxmmydCG6qXz7LAsiv1aB/OzW
 m/zQy4S6GslDTsOdizW26ijrVVgYTMf3URVrmrbb1vtP8FZbAe1zDhyq2DpzsK3VEpxEcamRDPx
 KDNtmkGJXb2F20XmPY8ycPNJ7Nz0bJJ8pIUq4p9XB2ZJ5Uqp/JeX2awlvFQ1FFvUhInwFO/ZOkk
 ki9hf/HBvy9dNqwJ0SN8ZJT8t7e+1RmQFKOZ1Lw+RrDvMXfsiiR3e8qWI8u1Pg=
X-Proofpoint-ORIG-GUID: YM4rWn84DvxPSWo21FB10KB-tJvTSdU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_06,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 clxscore=1030 phishscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=637 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604180229
Received-SPF: pass client-ip=57.103.76.123;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Quite a part of it is from older times...

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 0f50cf098a..98b13676ba 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2568,8 +2568,8 @@ int whpx_init_vcpu(CPUState *cpu)
      */
     if (whpx_migration_blocker == NULL) {
         error_setg(&whpx_migration_blocker,
-               "State blocked due to non-migratable CPUID feature support,"
-               "dirty memory tracking support, and XSAVE/XRSTOR support");
+               "State blocked due to missing dirty memory tracking support,"
+               "And some system register/state save-restore ");
 
         if (migrate_add_blocker(&whpx_migration_blocker, &local_error) < 0) {
             error_report_err(local_error);
-- 
2.50.1 (Apple Git-155)


