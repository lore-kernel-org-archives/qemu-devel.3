Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26949FD8FF7
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 18:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvfxd-00005K-IV; Thu, 26 Feb 2026 13:19:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vvfxb-0008WM-9J
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 13:19:39 -0500
Received: from ci-2002c-snip4-5.eps.apple.com ([57.103.88.156]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vvfxZ-0005aR-L8
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 13:19:39 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-3 (Postfix) with ESMTPS id
 820021801802; Thu, 26 Feb 2026 18:19:35 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772129976; x=1774721976;
 bh=3hz+2ZbkV//CV7dGJNInNfCP5pRpi758BYB1c4SIE5I=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ZBd13PKkFLWsRMPe7HcwiFQOPN/h8NIQCwz3Ak9aq4ax84gEAL4A4/U8+Nyhj8f5YoC1D0AHzSQbrxdlbAx6kLBiY4GAy3IDTvqjExWe1VPvTX/HnixVMOGIliQATcLrb6wp/X+8EdghRI85NBmFTXOgBvFLrqrL2CmCaKwkVOubcYeAHD8zThSs6pZfZPI02U+UQ9l0gFZ83avFH9PN+Dt5n4QuFFKECkp0wLEsEFiwcGxKP2VrVAqc04GaCgluMUVSQx6Rk3d5NV4E6mIAUtpRt69uEkY4LRrDg2RQy51DLTEvtng6bwey4yIfIm0ROvvAGO+FxBNVhliIRQ5Y6Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-3 (Postfix) with ESMTPSA id
 124CB1801811; Thu, 26 Feb 2026 18:19:33 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/3] whpx: x86: remove inaccurate comment
Date: Thu, 26 Feb 2026 19:19:28 +0100
Message-ID: <20260226181930.53170-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260226181930.53170-1-mohamed@unpredictable.fr>
References: <20260226181930.53170-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE2NyBTYWx0ZWRfX4yIB0jCuptNY
 ITe5cG/4okWo/PxIM1+QCcfvLZqaIKrxTlhIR3/z9rnU7ukrX6VHEqIyKznWsSmR6aCVjjOR8TN
 Y7YBH7VxTUBADboipacENfluUJMR8H40ZS9J3Xaoa5cO29NJbrxzTYNMh88KPWyvnfIrlNSCZzF
 IW8HyZ0t5i2TkimFblmYEVOZ4ss/DZ+xfI5QfoRwkeaDp+DEyj8bg0R7MLaxUHvG+LZVpQGNG6Q
 /n01yR/xdUrZX4mO2k8R7KCDpX5Lch66huA6B7obee53x99w0ljdJQCcfhHVqsAjL58PzDqXN2x
 2vUGkxkgn/FwIrxRvhUXJG7dpINue/8s9cFT8+KWE6IPMo+r3n6Sik2Lj34nRk=
X-Proofpoint-ORIG-GUID: Osd76zlfPEdFQpraLHbQyIbnb6Zbpl2N
X-Proofpoint-GUID: Osd76zlfPEdFQpraLHbQyIbnb6Zbpl2N
X-Authority-Info-Out: v=2.4 cv=MspfKmae c=1 sm=1 tr=0 ts=69a08eb7
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=u3u7fs_Vgx2Jn5GsYsQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 clxscore=1030 mlxscore=0 mlxlogscore=743 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602260167
X-JNJ: AAAAAAABCWNJcFRbBYzrbio8ky+5FP2YmWudnRH2zjMUbKtHSBcm7izPdqpWZicQCj0zGYYR2xjrNdZX4oOhTeE+NPdwTevyoq5MgSu2+6MxZaVxIsnUhg3hou6UIeBYq8p24Qcxo8IJt+t8RM1RJee7JTip93ojbjtHV2FJO7qJA+Z4yt9NmjihrEi8/XXkiLrsy34o3FsRuCngKkxeWhMfhXW0t838zzu8zsSQy8lumXUoRFpGZrZktUfLY8eb7SgqnemhWH2vMkEcUJedEITvexVpl77+sExb2p0JQtM5s7tCCRuyclkQTBBbl0iND1+m1WIrHDlmFYCTx2ECP+raNBh1om1wx6k8GIfwBP1dskbUcNplaBL18GeOo2ku/sdoJh/uHzVWx2iU55Z51dCXzQZkl4kO5wIoeT7ci1J0CGDUA1aAenDkWOM5HNwkPLfd5/JL1uFwNf4SED6/23esCqhz1Mz2LO4iGscilPDwxhMvGnNj3PplTR8iENTcAf6qBM46cJkvGXgKjnXwZXvPDbM8ZwVz97HrVpUKVh3nUWdmn26ek5Z1kmIuak6JGfVPvQRcG+OtG9KL4h1+/JKHssw/UaGclZ2pIvF2LGoksWTo4AMBrNftwgVgZevhqXxzFjyxCA/+y0IJEdfwXqG8x05RuLD6lruDOXbx67yFIqMpPOZRJJx28foc
Received-SPF: pass client-ip=57.103.88.156;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
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

WHvRunVpExitReasonX64Halt _is_ triggered on halt with kernel-irqchip=off as of Windows 11 version 25H2.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 8210250dc3..bd3a1c49c6 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1648,8 +1648,7 @@ int whpx_vcpu_run(CPUState *cpu)
 
         case WHvRunVpExitReasonX64Halt:
             /*
-             * WARNING: as of build 19043.1526 (21H1), this exit reason is no
-             * longer used.
+             * Used for kernel-irqchip=off
              */
             ret = whpx_handle_halt(cpu);
             break;
-- 
2.50.1 (Apple Git-155)


