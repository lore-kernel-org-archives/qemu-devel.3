Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F071EFD8FF2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 18:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvfxc-000054-TP; Thu, 26 Feb 2026 13:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vvfxa-0008WE-Lw
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 13:19:38 -0500
Received: from ci-2002f-snip4-1.eps.apple.com ([57.103.88.182]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vvfxZ-0005a9-3R
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 13:19:38 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-3 (Postfix) with ESMTPS id
 341D41802851; Thu, 26 Feb 2026 18:19:34 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772129975; x=1774721975;
 bh=UZEiVUH8PTumZu+dKr4xRElWHFHSNrqWvWIbetiBsag=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=LKsIWgGMWMgmunfg3MZGaI4ZmUHvGeUXBimY52LQ2xI/hCT/+sREFaNId6GyvHwdlTG9A0I4bPQT9O+iMMa01eWkTtg3Hfk6FHAjrgkP3x1MkmAm+LI7Z2QQbhtxjrrF0PX4tsDWcIge1059XThBLQbVVQv3BmyHXcpezlOkXoidwNFIZlcQ7GhAxG6F1JqcCEzvk73TEJpBdIDHfhp41hNvCJzlnXuW9rzCRHTdl/ZRKCR0UFbb0xBNKoMe+KdhHGwAvqifvGNvRMa4eAmwlQtzqelreNZou12HVp6wM6AiMp2iKhQmFwbWhtbAH3+lP5kxEG2M07SQ8W5u1pEIsg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-3 (Postfix) with ESMTPSA id
 8FDE118000B5; Thu, 26 Feb 2026 18:19:32 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/3] whpx: i386: interrupt-related updates
Date: Thu, 26 Feb 2026 19:19:27 +0100
Message-ID: <20260226181930.53170-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE2NyBTYWx0ZWRfXzram6pxqwsuJ
 jEa5GdenwAGCzjMV+nUHbUbsrHvqouWufrmjmVwFl7w0I5B0O9Owqlhk2dcjmPKnlCNBw+9tIYY
 o5anAk9WcQmgsqk8CarHBgQ5sq1AniVkxMPgukFBEARkMcvuGbFSR2yE+1tdRkB4SF+v5ucX/4w
 RBVccCaJyuqpDnF6tJDNW3BsXZvLgqsvjg/MAyfBfzGYqbwTea8PuI/NCa3bW6im8vbeXpDayB9
 Hm3xhHgjIpmG5ZTRVgl6cF4pnnNTl1f84KYQo1r1ePcNLZ5SPvfV3+gOIcLOGjA9pkwOtVJuYCf
 UvprKS4shMTBYu64UnAPgJZfyA36tTm59ef9RvQBQw3l2zYXCVSmPpJmo9Q9GA=
X-Proofpoint-GUID: y7yUrJURqWw4yI59MOKtmlYnHI756zvT
X-Proofpoint-ORIG-GUID: y7yUrJURqWw4yI59MOKtmlYnHI756zvT
X-Authority-Info-Out: v=2.4 cv=K8Av3iWI c=1 sm=1 tr=0 ts=69a08eb6
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=5X9BP1-cnhhvBUnzg3QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 clxscore=1030 mlxlogscore=322 bulkscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602260167
X-JNJ: AAAAAAABVJzjTWqtuDZhAfnLUrL0OwiLno6bOfCS/dON92L9IMrnbKsX/B5/ZzaPSWwTGq75HbM0BPlAL0DCr/d7a4sRJduEOyWne1Lc8wnWzjSny+ZPuf/cRWCXwidqu14oyWjTvXkxWiUOkdy9fEOfoV/CO9CsecTzgJZ+XddlaHDtB9AIKwRmHXhs6X7wRd+tf8dsx9QljyRuUZhenTE5kavduOg9Ti0RfNwXPmBAnlZyHwYWdozMiR4nVAonbkb8tmLpkuvbb4gOdg/ZXZ6EWEal1OUhtcvoYuCU5c+G8lLYg3PEXF/1a/DWPKV/E9IH0jUPaFbRTCmOSVQBrYpSeyG1VqK6NEvhTxlACweDx3bsxj6FcUVqm8VoUdkMe7yenmLlWkPA+YqtJV1rBFDCvqDGHJT0K3+Nr3qkNSNSqKvqxnMrRwFOojAjM/zCJXXay4iiPJfsj8/Ay4kw9/XiG9aRTps6s0E7EV33Yy0QfwnSOVj/s9oz3xN6v/VZSov41d3xDVDgBrXDkkGVEXtq1SNVqEthqnQEjP/Xm9Qw7ausSko1uK47HxlWFzAwH58piUsC/3RpnM+NJ1Uoe9X4hVQdhB/xgG5pnOdDrnSqmKrPCPwvc5d83NgAbws+4WcxC7EbAjvI/b9ESza+UzfqzYByPo4kkc4fc5Bym9jeCjHPNvwyWcQ90ErHkDHyfd/eIcdTxFrfRTUOcU/Z
Received-SPF: pass client-ip=57.103.88.182;
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

Kick the CPU out of HLT manually after an interrupt has been raised through the non-MSI
path.

Make legacy Windows guests (Windows XP) not run very slowly when kernel-irqchip=off.
Windows XP doesn't currently run with kernel-irqchip=on on WHP. Previously sent this
as a standalone patch, removed some dangling space characters.

Mohamed Mediouni (3):
  whpx: x86: remove inaccurate comment
  whpx: x86: kick out of HLT manually when using the kernel-irqchip
  hw: i386: vapic: enable on WHPX with user-mode irqchip

 hw/i386/vapic.c             | 25 +++++++++++++++++++------
 target/i386/whpx/whpx-all.c | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 49 insertions(+), 8 deletions(-)

-- 
2.50.1 (Apple Git-155)


