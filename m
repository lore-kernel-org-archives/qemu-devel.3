Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFCFEEC2AE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufX3-00064W-5r; Mon, 23 Feb 2026 18:40:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufX2-00060Z-04
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:04 -0500
Received: from qs-2007h-snip4-11.eps.apple.com ([57.103.84.211]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufX0-00049p-I7
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:03 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 DC23E18000A3; Mon, 23 Feb 2026 23:39:57 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890001; x=1774482001;
 bh=RBeGuU3g66EpifK7auesB/uat8+GKJ5tjIXtWZ1mj1k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=bV68NBJLDrm4ZCdCIMZ14hBbTUNcdS+9qZ7nj72s1LXWY0pWQpMp48lIOGTdvO3r4t+jiCN+rpXE9AwG7DAYFcuoatd7zteKJp8cXHsH0Y4BwncrfeNH/oaf7be1sww54M7nqudGwOcGTYATVLcdvSs8easx9Cz7jhLmjtI26S42f9yPtyPWlQAfJKmIT6qzlSH1X9ty5ibl6KqDawA759BwF2TJORnwVHf26+S+pT3V6QOwSzGAngnctxY0e04PcL6OyLDeEvLhaEQN4BeO+fhd99cxuxRulF6uPJuffEiDF4FEnYIBbwgW6ZeFzTJawiri6aaLxfT3GlrpqBRn2A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 4035D180013D; Mon, 23 Feb 2026 23:39:55 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v6 01/28] target/i386/emulate/x86_decode: Fix compiler warning
Date: Tue, 24 Feb 2026 00:39:23 +0100
Message-ID: <20260223233950.96076-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: V7j4-DWl8vcnLw_0zkdNu9dFQd1lVCt8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfX8dc5gCi7ohzc
 Zj/IALeYlW0neZjNZeZy9BXN9hHTmYvjxv3mKyn87SPirGULsknwUOV8X3YgCHEfyDVn+1W/KaB
 OkBc7oiMu6I6H0/yPTwUDwdXiBc8A2dtdKurmIw0Ka0kKm8FMFQkQcltru410MJG5CmGLlQFD64
 MEsZWeVH3cSALBlER+y1GqX+sSF5ldfgcDoeyFBE1HXNriO6JwmrzNySDPL7Hi6k4Bq2gXt/i6M
 fPeVC880da0noYm0BZYYntCD9e66b0indrDl2TbW1IIlRDCH94f0K4hVrtJkICyuJ4EwDcn81F4
 8/UH4tUNizeNG0N4zFYccZU6chdm9/LjVTkUpYMxE2yC5ENqUu4vR1s5NqgB4Q=
X-Authority-Info-Out: v=2.4 cv=cMntc1eN c=1 sm=1 tr=0 ts=699ce54f
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=1g1V9cNuhepT8r8r7IUA:9
X-Proofpoint-ORIG-GUID: V7j4-DWl8vcnLw_0zkdNu9dFQd1lVCt8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 clxscore=1030 mlxlogscore=782
 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230206
X-JNJ: AAAAAAABEz6UxY0M6sQoLrelT+3L0ibsNbJJEog+sADX6CA5KOUAp0HznsRSxEOqYqgcy6RUU8WwTxkUQaK7bc6yZLZCwfeZ/MXYyEgJ2dgB3YwPCKJqrZzNj3jnkS4tbj7dnroZD/yjdgtd4eGRUqgiG+HpXMbkMSJlST9L9qm0eyDIekZvva1h8QMREgRNOZaiVHZeKmVaEOYxOFNZtZKd2XYu6KEXNH7hp1VNltLizwitBMHLIeSejFJnaCCVl9UHOAX8V8G//uBtbe2MdW/UsHQiXr3w8wkSgrucIGu7DtttVss+ZiK559K92bzKBDoG7hgfhRoVGAHo2D9oQcyzhr8WPgM7HuT41fdTBnIPUY9fRMWAT6KKRKYrZIDmSb3uuExHyLp8xI+LAWk57AygPYJr3lIIEW7SG0C1fIR/bDwgXkTzRkR0G8lMBbyvrY4TQFgDrfzpWAj1PcTvk/KqVg07pkEJpQ1pf7nMgrmtNmEZBeny6THCb5Cc5Pqv28F7o4PWLyn0+zpQFErAVuzhdBoOSjUbAEIQ8avwCZMy/+14Tc4fjVqNno7RDPD8nrQL305YK9SLAqlcMuTIUuhx4qDPB3dv44+7beKbQcJ9JCnE+wR8P/2a/xQEZqDx1Vq49zYGQ5B4ldp03NoyxDp0my/iMmC/Ee75ukhrDln5/TnQ42gVZgaCWh2JQoAKni+qVYCLuRasYW3iBtlw0GjGheT+bsHXVxnQ5ZS7wHHFNjAD58nbexrFHohq8TkDGhCf/wt2PO1YplzJjwfmJ7OdLcUTvf9eARbcmO8TuuoBxBTqHHJZJI6F+td3u+1dLjvGJKR4
Received-SPF: pass client-ip=57.103.84.211;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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


