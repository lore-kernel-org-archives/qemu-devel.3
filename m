Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87362FEC0FC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 20:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w58h5-0000vE-4d; Tue, 24 Mar 2026 16:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w58gw-0000pZ-AH
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:49:35 -0400
Received: from p-west2-cluster5-host12-snip4-10.eps.apple.com ([57.103.71.23]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w58gt-0004e9-QT
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:49:34 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-0 (Postfix) with ESMTPS id
 ABC171800455; Tue, 24 Mar 2026 20:49:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774385364; x=1776977364;
 bh=CLyeZj/GfOb93UxqHuC1UwrRT6SXCCYzhO+nvypMIRo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=YHLrR3e2drM6JqCVE/zD93YxiM591d2Li1MWlr7QTAnsBPEgaapfvzvCYzZUab6u9HtliT5Irh9Niew9cgxRyW1b1162LzpEBdO/NTwmkVkaYI/Wqv+RRgNNifUh1FVBxAxGg12dLT8CQdhs4dTv8Pi0Xzjo7iXu17nejrpVYtJMxxPF+EEbiWTd/7FH6aXiS6vnBOq1SMVv+8d3nIOQkkEgdVG+ESC2TtzN8yz4XtwnIYbVFeVcBpPjpA2IKKtOnwLggtsoDJu0UgwWozBhTcFTdvW+otdjbE3GjjUazJtTzk2UkQM1ssqIm7Tcq+MPX/yIXb5DaO+pZWcULZ4wcw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-0 (Postfix) with ESMTPSA id
 B9ADD1800444; Tue, 24 Mar 2026 20:49:19 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Roman Bolshakov <rbolshakov@ddn.com>,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [RFC PATCH v7 2/7] hw/vmapple: aes: convert MAX_LEN to a #define
Date: Tue, 24 Mar 2026 21:48:50 +0100
Message-ID: <20260324204855.29759-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324204855.29759-1-mohamed@unpredictable.fr>
References: <20260324204855.29759-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: z_dy_z5nbP2qRh63tb_SEwOrC_EnwgBs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2MSBTYWx0ZWRfX11GXr3MBspyw
 o9PrqMEuZ92wQTTAVLrXR5eqPVwRJemxsxiRt+fR1BVbpbRqT1dvVp2Qjrh+yGAqUL7zcs9StgG
 leY5tf3V4M3gzBKl8WQtpZ4PXs94GLLHumDc5w/UsvJ/XZBu5qegdgaVQL3A1srPETaPFjQJmPX
 OJ5I799W/XTt3vq6ZqOTtnwiedPNXAhmcxwWkZ8vv6+i9MG1GFb2QB+2R+on4T+EUpm76NRaK+J
 aT0Da5x/mpB5L4DEgKGQyMYGPzeB2u4yGzCsCbylofDdmCjiToF7uP3hidlXvTuQ4OfiSTLFYYi
 mTwThXVCVAeuZmonKOXys0xj+jCDAXhl/2cEjUyyvyztwPqoNlaxwpHIefFejk=
X-Proofpoint-ORIG-GUID: z_dy_z5nbP2qRh63tb_SEwOrC_EnwgBs
X-Authority-Info-Out: v=2.4 cv=ceffb3DM c=1 sm=1 tr=0 ts=69c2f8d4
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=CNpkFlK3StMqgsPjqO8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxlogscore=783 clxscore=1030 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603240161
Received-SPF: pass client-ip=57.103.71.23;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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


