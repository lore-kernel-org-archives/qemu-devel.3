Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FA5F5580B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 10:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEm74-0008OF-7p; Mon, 20 Apr 2026 06:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm72-0008MG-5C
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:44:20 -0400
Received: from p-west3-cluster4-host1-snip4-10.eps.apple.com ([57.103.74.181]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm70-0000nC-QD
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:44:19 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPS id
 3856C1800151; Mon, 20 Apr 2026 10:44:16 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776681857; x=1779273857;
 bh=rb0GOIlqaOFPi1Yf1WKY/tBOvMMic05yErCimlciyYU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=VIJ6loHicV/QUogjLDzv2jEqHtGMmcwUXZjaboHXkkXFhK0xhtnEBV5QQfv6jU+OOrgTdBSZinB7fKOz/3WvOLcxd8oUOPEdEmC0PjjSAAcb8Bm20Ujf5hCr9MyeZAcVya8Wm3mqbvL7LKIDS7DwakNTDo6HRX6h29AwnEI2pXvpN0MOfxDzIkjYneSi+PPMFsMPcgdbBUHFmmfKEcEDhiFn+zT6d2vssiUBHXCJuwU7HTkRKay3eGyKpDKcitpPbrq6UpjjbAhC4rcINF7Dc6dV9pFcirF9kdggju21qA9CU3h20DjppGaHUgNNORrj0taqO8v51lE5TcTApsq4Xw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPSA id
 7E3E0180017C; Mon, 20 Apr 2026 10:44:13 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 33/38] whpx: i386: update migration blocker message
Date: Mon, 20 Apr 2026 12:42:43 +0200
Message-ID: <20260420104248.86702-34-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260420104248.86702-1-mohamed@unpredictable.fr>
References: <20260420104248.86702-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: E8NtGfp6P629HAHk1EOEx-hDxvGJFgR_
X-Proofpoint-ORIG-GUID: E8NtGfp6P629HAHk1EOEx-hDxvGJFgR_
X-Authority-Info-Out: v=2.4 cv=GJUF0+NK c=1 sm=1 tr=0 ts=69e60381
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0IeqtQ1xXW1zzRo-U5sA:9 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwNCBTYWx0ZWRfX/h8CLLLw0T+4
 yd/ODz8AZaE3tNjqh7+L8MlJdPlzFu5H0gTMh5T5DCjbwjUqrp7dzF9t9GttG+uyUp7oihs37Db
 McSMb4jPAf4Bc37gujTjaTBse2YMDdZfTenY3pSa+6f/Aq05bcbnVV7Q5xi2pnbOZqSj9KrAYHa
 jCzVx9DxtHAoL3WFKT4tQLMyeArYjIxAasNpKDixPROf/MtpwA1aHkAL4jNCKN44YBh4fz6cZJv
 IX+fK9FF8t6JHF2kHiqyk1FeZkIwrxDMVzUajv7vwgFsB2v8CeHFj/gYHkieYfYuzunKriYvJmb
 98mZP16oQxkyfDg54l++5OdNto6DxD/Blbzb5hkVC646jmawhfnytRzDb0mSz0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 adultscore=0
 clxscore=1030 mlxlogscore=637 bulkscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604200104
Received-SPF: pass client-ip=57.103.74.181;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 208ff0c35c..f9f12484c9 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2569,8 +2569,8 @@ int whpx_init_vcpu(CPUState *cpu)
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


