Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49772E9A77E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 23:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Aju-0001PA-6z; Tue, 24 Mar 2026 19:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5Ajo-0001O9-Uc
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 19:00:41 -0400
Received: from p-west2-cluster3-host1-snip4-10.eps.apple.com ([57.103.69.113]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5Ajn-0005NX-JV
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 19:00:40 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-1 (Postfix) with ESMTPS id
 5DCA618004CA; Tue, 24 Mar 2026 23:00:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774393238; x=1776985238;
 bh=09xeY8yay6zzXffvko7mwK6HV3z+mTIHX12OyZQa3YE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Ko5XHDCkY264B6iu34WSsWf1sAMbY2b8wU7KJX/PgmcVY6v1eZOzBxdDVm4sRGpl5iExM+R4Emu3QQDE3EYFvdKaRKK5Rmo2BrQIqwTK+rXQthrh9Q7q/O+9oNwV/AaZKkJde78UplaWwsb+m19PLnFQKpIXJCBC6zuutgIAJiJAkKRnos/0YbvZPBI4VkNm+pi6km97SZ+Iki1vpenawEUH/HWSp8lYCgSmqpIeKr0mK4cKjsCS76oedn+71Mon3A/tVUJ1/nDThT4j06RddJTmYmj6y6vWFR5RZRTo2piennr5osRBv3S0Wp/T/798aLVN0YBW1rIeA/306IWFtA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-1 (Postfix) with ESMTPSA id
 E608018004A5; Tue, 24 Mar 2026 23:00:33 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 1/2] target/i386: emulate: set PG_ERROR_W_MASK as expected
Date: Wed, 25 Mar 2026 00:00:15 +0100
Message-ID: <20260324230016.80914-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324230016.80914-1-mohamed@unpredictable.fr>
References: <20260324230016.80914-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1-Kc9np0e4yZD-NlM0Z3fk4PiDCirFID
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE3NyBTYWx0ZWRfXycXUGRS1ZLcz
 UhqIChd+rCC+fuGkruu3nLN0u4MBD8J7Q2GLoNFNhIhJGauNv5la8OM1Yl6RkN6MMnhVq42Wd6/
 e6c6c/yIiPdcigaUU+UZ1WaQnj5GqY4MLziETcxaOlqGc2VhvUG5MkrMlletbb+nl9OGY9SYa47
 nPE0t48SexaRFVePlpwct32wVvCmjz/lpkJWCHSkJMxIqTFjlSXFJdVBvQia162DsCmb/RmresE
 vP9kcFFaOnosncjXdQzfM1GqgjQkWKwBUh9UiulkiJPUu01G7dFWcV7cYQRKfNVK5JiJQ+xmANX
 0ZB497Xv0w0HEA82vbEARWV4+ssWz0YK0/w4V0fECgSEOxofC3u4E5a6dAvVo0=
X-Authority-Info-Out: v=2.4 cv=Rt3I7SmK c=1 sm=1 tr=0 ts=69c31794
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=84Oi3pPGXU6VO-9GTPEA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: 1-Kc9np0e4yZD-NlM0Z3fk4PiDCirFID
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxlogscore=893 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 clxscore=1030 lowpriorityscore=0 adultscore=0 classifier=spam
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

Make setting PG_ERROR_W_MASK no longer dependent on the access
being a priv violation.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index ba0ebe4268..1aa373f5b3 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -248,7 +248,7 @@ static int translate_res_to_error_code(MMUTranslateResult res, bool is_write, bo
     if (!(res & MMU_TRANSLATE_PAGE_NOT_MAPPED)) {
         error_code |= PG_ERROR_P_MASK;
     }
-    if (is_write && (res & MMU_TRANSLATE_PRIV_VIOLATION)) {
+    if (is_write) {
         error_code |= PG_ERROR_W_MASK;
     }
     if (res & MMU_TRANSLATE_INVALID_PT_FLAGS) {
-- 
2.50.1 (Apple Git-155)


