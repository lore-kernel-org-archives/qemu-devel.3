Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA93FC9ECA
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 04:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyjYt-0006ki-Jo; Fri, 06 Mar 2026 23:46:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyjYa-0006c2-Kw
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 23:46:29 -0500
Received: from p-west3-cluster5-host3-snip4-4.eps.apple.com ([57.103.72.27]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyjYZ-0004h6-31
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 23:46:28 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-4 (Postfix) with ESMTPS id
 BBA1D180008F; Sat,  7 Mar 2026 04:46:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772858785; x=1775450785;
 bh=CLyeZj/GfOb93UxqHuC1UwrRT6SXCCYzhO+nvypMIRo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=OAapau4/rXG2bxLrspmpCJZaIjyobFrgi+AzSjD39zRB9pWKkq3kcFirrdsIEV7xt6ttsJIucRClDVfne1Fcm1bCddcL2LBEy6bMAv4IDz8VT18iCzUtyX4eQ+wvHGoi0QHTAB0FFBTDsaI4h6P32q/ltOF3/bTVYlTdjujPjp5DmnDyP38mKtcsNRsliZ63IpNfbrAEZO8cZq4RJt2P4jURZTX1TwxZRSpbX+ZWutKBZQSiFz8F/svv1emMCC6H+rOT9WdDLYYc0pBfDTdLbsrT8dAptqmYwV4kShobhR6AnTZicxCdMV44I+TitPPj2lhPZoQxasT3+f6mys5GGA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-4 (Postfix) with ESMTPSA id
 AF68A18000B5; Sat,  7 Mar 2026 04:46:19 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>, Peter Xu <peterx@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v6 3/4] hw/vmapple: aes: convert MAX_LEN to a #define
Date: Sat,  7 Mar 2026 05:46:07 +0100
Message-ID: <20260307044608.25486-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307044608.25486-1-mohamed@unpredictable.fr>
References: <20260307044608.25486-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=M4pA6iws c=1 sm=1 tr=0 ts=69abada0
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=CNpkFlK3StMqgsPjqO8A:9
X-Proofpoint-GUID: kOFSOrbDrxQ-dbl29W8aijj67GWdctIf
X-Proofpoint-ORIG-GUID: kOFSOrbDrxQ-dbl29W8aijj67GWdctIf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDA0MCBTYWx0ZWRfX4DiDWMzsAEVt
 r6Mo9pvXa5WWujB9fDT8bWfww34Zlo5dLagwr1eiLaW7I8rQ6CIwXfeJaeOGkJZKibYGP/K3sm2
 xiTYAKEv8KISbxnyRgQeSwnBS2zkTTB295UKIHytC3cBUFwXxZvqvyTITW94vaw3Gd+ASuunEP0
 VdxsJUbJMNwRDfwwWmIJB78lbKmctkKoMTcDI0B7yjoLpK/3vNFtQ66bMPXLlGcebKsxqWCGy9V
 NrCqJVFMNRpzrjLD2wCtMs7Z+e9J6HvKQU1J59XWdqjBey0KEgSDBFaOb2o4DsVoNUdjUy8VbNv
 Rsif8I3veIAVzB0sVhtMpV5FEpUBOyZhx5KnLiT3wacEIwDU0Q8+p5Yf21b2Dc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=889
 bulkscore=0 phishscore=0 mlxscore=0 malwarescore=0
 adultscore=0 clxscore=1030
 lowpriorityscore=0 suspectscore=0 spamscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070040
X-JNJ: AAAAAAABaYXtVTKva9PhVB0d6/ouwA5pGtPGKsfx0lusiMk/qn5Tqy8l1xqjVMgs5Eyq6FSIw1m5XHG0OgqfiLztTeox3+sykU2cncikO76+9PfsiMXAIpMF6m2Igs7l5d5qiJ+c9hVUakJrVKseCaBGJTpia8orZwYZ5rWgSD5H7iSw9NvBzC1Poa/1novmjgVl+Q23PiLsWMHYleVjb8/vYEv1TyVGuSzLg4aV9ygpRWpeUBuKskW7q+9A7cU5g+bSpNQ23NAdNV8ERy0y2sUS3BXjKmTqdk3AGU1JFU1TTtUycOKB3+lAEhak4jCjRSoyaeljqZt+f5/mtJwSTI9K+A1Uc4gaQMQFMFQTAHe25NSurQf8oU1EsKZ4I5BRogJxUQ7DohXy5kJYk7VUZCPwKkZFYXgvQygWtJ9wL1YWIe0pI7dMoChPTKYMfePjT1q7z+514YwrSFV+308loaBMWQKAfG+mA+4uCL/R1+4oVh7C2J0R/aq2Vpq7S2TRvF+kAxHWsGCa20fPB8bIZwSSjzX0m8U+mTWd10+M5y5DR0+G96C5+dyGUmCAoNEBk3JzhdCpk7zGCaYf7IJIoGUZ+2qelPQ3Ne0u0ycS/gUC4l8NrhYGvNwInop9ypUy5siiwQ+oov/L6DV0rGOHK4ehCAfKptHp9/O6gl5qJsFWFmOVVEV9NBxJLL1Boga8QzPeXxaPHaPk8x993jm5w8gUslyIWrkoop9ifp4IG68XfwUFapmMDHLPP6uO2hRiCuDASOUVv70RaaVwfBJkqSTXc+zWoegntqLl33wrhds=
Received-SPF: pass client-ip=57.103.72.27;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Working around this compiler warning:

../hw/vmapple/aes.c:257:14: warning: variable length array folded to constant array as an extension [-Wgnu-folding-constant]
  257 |     char hex[MAX_LEN * 2 + 1] = "";
      |              ^~~~~~~~~~~~~~~
1 warning generated.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/vmapple/aes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/vmapple/aes.c b/hw/vmapple/aes.c
index 553e688adb..9d062d5a7f 100644
--- a/hw/vmapple/aes.c
+++ b/hw/vmapple/aes.c
@@ -253,7 +253,7 @@ static bool cmd_iv(AESState *s)
 
 static void dump_data(const char *desc, const void *p, size_t len)
 {
-    static const size_t MAX_LEN = 0x1000;
+#define MAX_LEN  0x1000
     char hex[MAX_LEN * 2 + 1] = "";
 
     if (len > MAX_LEN) {
@@ -262,6 +262,7 @@ static void dump_data(const char *desc, const void *p, size_t len)
 
     qemu_hexdump_to_buffer(hex, sizeof(hex), p, len);
     trace_aes_dump_data(desc, hex);
+#undef MAX_LEN
 }
 
 static bool cmd_data(AESState *s)
-- 
2.50.1 (Apple Git-155)


