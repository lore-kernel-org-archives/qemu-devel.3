Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBB4C636A1
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 18:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuDnL-0008Ot-Lz; Sun, 22 Feb 2026 13:03:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnE-0008MA-O6
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:02:57 -0500
Received: from qs-2007h-snip4-1.eps.apple.com ([57.103.84.202]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnC-0000Jo-0i
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:02:56 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPS id
 27BC818004E2; Sun, 22 Feb 2026 18:02:48 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771783372; x=1774375372;
 bh=RBeGuU3g66EpifK7auesB/uat8+GKJ5tjIXtWZ1mj1k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=KYuOWEffXWIkpZZj6zTHDaD0aDgpevkg/wI+t5/rvryldNKdS7GoE9rdxB6d02oXWQVCKsJ85mxzappOJIzkWFKc+XYMXMp/tjjWDG2rGFVlgsbIJ1wybFWrRZHE0GM5tKGtu2TCTUutqP2JdBR2NjpEzwdZChbqjIi0THz8pvseoFQ0q/DmBdHJlqOSI5AgX6IWr4OzLh+UH9D6EJ09ocYp9naJI+c9uex3qiuQHRoIOGU4A1oexsZhhGiVZIx1mcVt06lJFxHD37ZRSXKHoR1i+DkPfns5D9JGZBs5ixWPv5V1N8mVirbeLK4mv3eamC6npuzEWTZ+ZR+v71wvvw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPSA id
 5CE8918000B0; Sun, 22 Feb 2026 18:02:45 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v4 01/16] target/i386/emulate/x86_decode: Fix compiler warning
Date: Sun, 22 Feb 2026 19:02:25 +0100
Message-ID: <20260222180241.14621-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260222180241.14621-1-mohamed@unpredictable.fr>
References: <20260222180241.14621-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lAOQGNOPJg0VATLY8_yf32B4OY6c3DwI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDE3NCBTYWx0ZWRfX+JU5RG76R5ya
 ym9YPPKuCjxGOxB7DW7OjN/h8RQ4Gmqdu+h0cb516khPN5jQddA4jrz4NJ18Mw6Q39aVfsyjzIB
 4ZzsjoWS/ZepMEfuwL+YhfrpstwpJW2nXzJJ+QdMkdgmgCYROawyerrJYEM/0SxW2EQDfVkctwS
 wdGyHGGEBJTf7PIXG6ut1zTfdu2z4QIOXo3ZjlD4Bn9PqV3E6gYy8sFvnHQDUKVEWt4BdeI63kY
 0SP0C4szDWGZjYm7UcXayqc8sYCa8Ux0kA9ql1hGeBaOco5qQAwDUA4w2qH3IJ/ERYW8UB9WcSy
 VSGv9hCsZOyNmZJmFwFkk2PmQy0+iXAf6sbvw2pb3TqWve15gu6zrEjHo5UjNk=
X-Authority-Info-Out: v=2.4 cv=fPw0HJae c=1 sm=1 tr=0 ts=699b44ca
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=1g1V9cNuhepT8r8r7IUA:9
X-Proofpoint-ORIG-GUID: lAOQGNOPJg0VATLY8_yf32B4OY6c3DwI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_04,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1030
 suspectscore=0 mlxlogscore=780 adultscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602220174
X-JNJ: AAAAAAABVvA7+bPZG93u5a8cUIHBO51a9eIyt/OVh8efJOgEaa056nOdaYM6xwo3Cf3qOQ4hQP22XLNceznWDty69J44HUvqZZ0CrGPhgddkKtKts1PqAVJsLRE6NH4c2d5RXSTyq8nTJ7aLMovjg0c2FaCBsKs9a6cXbq5SEivw5nniRH0ZNlh6lR4ao0HynQLAKNLDihAzJWLqHKoAqE7VFxVe3eIgYY/meZkSa7HMClwKyW4ssxcVyzM0TKMhO7k3lNZPPG4HtjjkaaYkUfhFPr3V8MWE5T/iD8Gte6zvDMmL6zFksChnDcwZlYSezRoCmSwIoqxyThTLO6WBva/txDdDAFY3Eqz24MhIcTMl7G0H1KhtSCJ+jXWsFFStUxH06XAYz0zoQMDiEdx32lBVF50uqgijWBGjMNoE0/Mx+VS1QMeQnG/mlvvMTbM3821dAA25F5gRS5eet9sHy+51d+httbgPB3XFUFL/WKVJHdmwK76vew1yS/FftZTXRUW0KE73oznRHfJd7KplNog9/zdhgHzModMox5OTNeN3K3sVf1ZJzHW1Z7DsIYhU9sUcEFzCNzle26pvg2XMcUWmc8tVONPgUPet5pSp61v9p5NqpqKBYtsZH88YthU1RdcHuxIljd7CU/3osEmTxwp8uiwqekh11EL3mQG14CVgVw3hgZMjN/cfaeEER6cTP05nIjJrCsjqWoYInm9w8Ssto+pVBf+UZKUNAlGsK0XF9c4O0pdF0eXqWKVICguvuMapZkFRmu6AVoh8CmoG+bZkQLgeKhH6d2XfB3UHjhngv8PuwCKf59B7zef9AaCr9g==
Received-SPF: pass client-ip=57.103.84.202;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

When compiling for i386-softmmu under MSYS2, GCC emits the following warning:

  In function 'get_reg_val',
      inlined from 'calc_modrm_operand64' at ../src/target/i386/emulate/x86_decode.c:1796:15:
  ../src/target/i386/emulate/x86_decode.c:1703:5: error: 'memcpy' forming offset [4, 7] is out of the bounds [0, 4] of object 'val' with type 'target_ulong' {aka 'unsigned int'} [-Werror=array-bounds=]
   1703 |     memcpy(&val,
        |     ^~~~~~~~~~~~
   1704 |            get_reg_ref(env, reg, rex_present, is_extended, size),
        |            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1705 |            size);
        |            ~~~~~
  ../src/target/i386/emulate/x86_decode.c: In function 'calc_modrm_operand64':
  ../src/target/i386/emulate/x86_decode.c:1702:18: note: 'val' declared here
   1702 |     target_ulong val = 0;
        |                  ^~~

In the calc_modrm_operand64() case the compiler sees size == 8 to be mem-copied
to a target_ulong variable which is only 4 bytes wide in case of i386-softmmu.
Note that when size != 1, get_reg_ref() always returns a pointer to an 8 byte
register, regardless of the target_ulong size. Fix the compiler warning by
always providing 8 bytes of storage by means of uint64_t.

Fixes: 77a2dba45cc9 ("target/i386/emulate: stop overloading decode->op[N].ptr")
cc: qemu-stable
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Wei Liu (Microsoft) <wei.liu@kernel.org>
---
 target/i386/emulate/x86_decode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
index d037ed1142..6ad03b71b0 100644
--- a/target/i386/emulate/x86_decode.c
+++ b/target/i386/emulate/x86_decode.c
@@ -1699,7 +1699,7 @@ void *get_reg_ref(CPUX86State *env, int reg, int rex_present,
 target_ulong get_reg_val(CPUX86State *env, int reg, int rex_present,
                          int is_extended, int size)
 {
-    target_ulong val = 0;
+    uint64_t val = 0;
     memcpy(&val,
            get_reg_ref(env, reg, rex_present, is_extended, size),
            size);
-- 
2.50.1 (Apple Git-155)


