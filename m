Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9F8E98E06
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRRv-0000Bh-1S; Mon, 23 Feb 2026 03:37:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRRs-0000AV-QW
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:37:48 -0500
Received: from p-east2-cluster4-host4-snip4-10.eps.apple.com ([57.103.78.151]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRRq-0002B3-Td
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:37:48 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPS id
 E31BB18000A4; Mon, 23 Feb 2026 08:37:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771835866; x=1774427866;
 bh=RBeGuU3g66EpifK7auesB/uat8+GKJ5tjIXtWZ1mj1k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Zojjf4RX8JvJwmLKbqoI+Ca3pFPPEeuMo/9rv0dsqsi2WdUEvdjtsQscmNQUqiS5NoJ/B8m3/96wjXJExaZO5m/d7NgmzIjuDL1/R4+HWdynfRqgxi52yA3Cv6OqTHoiOxhkACXa1DMoENAmkLXeB5c2footRBacJxkS4kaQ2lDa10V5KI2RECe/FrmUzjZq1igXQ+qOcsOUQOjI/RejJS2Spc4yGQfnr6osc1/3FKZMGRqiSgjLCM5m1tN4lBz1nDyP/WSvdxvDAv/F0g6OD7EEzWMkeGiS1BJPdVmybndSuFtk+b+D9UJ6pIAd+UPx6mIdq8RG3V3ED1wl6vyDgA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPSA id
 D199E180017E; Mon, 23 Feb 2026 08:37:38 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 01/27] target/i386/emulate/x86_decode: Fix compiler warning
Date: Mon, 23 Feb 2026 09:37:07 +0100
Message-ID: <20260223083734.48533-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223083734.48533-1-mohamed@unpredictable.fr>
References: <20260223083734.48533-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfXxIKg5TO5sS+h
 HilzxcLRSU0dpqVACyUpSpBZUQT6uo2oaGLDaK4FTZHaOWVU9jqUQTXcn/RP8MateoKUBWIbTFP
 kvX0U/IOTwE3iiItDtVN6JxvPERpMmnOwTlBAwssOAhysktMkZgd7EfGFvqbX6nAuC5NfonhcKH
 9YK6K2x8U8DKuxAqSq95aAvodo0XHd3EBII2Bkn87RAwU7fXCHe11vr/4GDywQP6DLhJkNVn9Vv
 R7borf9dxmVQ9izTFI0M+TpFfgxYF12XqgtoRXnVBUovrAI+p+/bDGR3fgozbruNJHOddE7g01w
 vjlZTNwsAyWVNM/svvzEMNuInkvFbQkL1l8SFWt6JOBmPGQU1PtTn5P8GBdyrI=
X-Proofpoint-ORIG-GUID: 9N9p_tQU9AEHHmyZuCvX3s46rtZXLpwI
X-Authority-Info-Out: v=2.4 cv=asC/yCZV c=1 sm=1 tr=0 ts=699c11d8
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=1g1V9cNuhepT8r8r7IUA:9
X-Proofpoint-GUID: 9N9p_tQU9AEHHmyZuCvX3s46rtZXLpwI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxlogscore=782 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230076
X-JNJ: AAAAAAABi3XNyaDs4+j2tnP/elXxYzGTzC8exMmIU+RNdcgE3SSbZdVq0kn37RL6Z6MA+tdee/wfvjE+IndUeR/nG9beCXXuvVLkTECreIrcnQmo4FJ43tYhF4sy4d/P23mjEr9RbA8zjfqFyoux56ZQ85Old63vTl47hBpdAkdEMGyGMBn/RQ/JzOCc1ACTHxuFC8plJ5yguKD32/596iDNB2BwO2B2QReHS2asqymAPMdPNDjhjNXJPjEIy3EPWcE0H88JmECDd1LOLXJLHPtqZ+30DPs8A6f2wHBsEnb+BAFV+RLhxhPnSTZ/wAWKKxHDzvubOZF87ADPcYQqYeKzWShDNd9M46fFEBNGlKnK4oFpcrnpHVdx12zElJpB9Qjgq2esy3xnUb6Li+zRz4L/ODN0s/U50HDj5Bo28Ij+tWXEYGBn6UGaersSq5rUkKEKvjtr7a7Ms7ssJE50dtmJjLFF35v6mPjlWUs7NFPTedjcedffBC5dQopJxB/Y6+xcBdnszwN3XV1D52Cub6mM3LWzH1Dwuyi1LTcyBU1viKXvsFRVG5FJUeuE1mAM7Ygdd4Bvv0uaBmfdzmhCwlo27rluDceENuK2sTN/WhBnSnbRnYGNEt0/NqlPXD+C2Nh6pzfIVntVxcYInStJ7d8gcIDkyBqO/lTicJ6WAR32Lwxu8MiCY9da3IUrIiiiBSucpxqR4dAZGf3HptKO/UKrfB7wgI5y30LfUZ+DQLIRBpDE0/dj54+nXJ+wDm53CVJIAHtPgoECFosbYW9A3SXsNiTCGRPw0aIZUg886btUuiA0szpar+RMW3qYtd8qw86ev73P7DGAMUVsn/w2lHxP
Received-SPF: pass client-ip=57.103.78.151;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


