Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE57D10854B2
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 22:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1XGo-0003xK-6n; Sat, 14 Mar 2026 18:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w1XGm-0003wQ-CT
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 18:15:40 -0400
Received: from p-west1-cluster6-host6-snip4-5.eps.apple.com ([57.103.67.78]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w1XGk-0001Uy-Cb
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 18:15:40 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-15 (Postfix) with ESMTPS id
 A1B6518000B8; Sat, 14 Mar 2026 22:15:34 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773526536; x=1776118536;
 bh=vtyg7pEdi4erY1D9NEPdpOdl23I1WCj58Z2t4m3thg0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=fVlBu3Wvr1znrna0+sCsCAcl+1HlbpohjVbwa8IAGE3c+PfkJcNiuyH9tL7oC7gVxaQGXC4Ug6p4E+exwsy7489yS6CVWqAQo+y3plJJlAnk9+fi6lKshVvI4tw0VU2g+IqZOHXfab5feczLYJQP8kbXXHVNfHYSqcEhhxxnhFfryZc1fyxjMAfwwGAo8L/2oQcDkhb1h48L0jJVlovJyeeCucx7uS7MdO2EFdUv9eIAfmwyREZbzNvBxYlQFQK/dxNX4LGELhqjF8U+t7gpL0NnMSbnFE0OQu32W8qS3RHWDyiu4wB083PoektZiKd29uVfv3HYxK8DjeBSRKt3Ww==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-15 (Postfix) with ESMTPSA id
 702BB1800244; Sat, 14 Mar 2026 22:15:32 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v3 0/6] whpx: arm: set of small fixes for QEMU 11.0
Date: Sat, 14 Mar 2026 23:15:23 +0100
Message-ID: <20260314221529.47841-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 317_j8pPJOfnGWkfyCvy7-6MoBM44Qjq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDE3NSBTYWx0ZWRfXyMjIe689JTgP
 QAkwWxm/bDp5rjJfVyx+tAwkovh87G0Kk9Mdvs2JjSa2OOBiiZ2fTwHlJ9dRiYEVryq3Pp5njFf
 caGizRXZhhSR4kIedhVG+nCCSwoDsOGGk+U6imIkZJczvBK6G3RiaoCJFaxkmMPQUOwdpekRy4l
 e8vBw4uB96+CAZTrqxjN0Q4/3YRsJ2greuTkXepGQ5ylC2SZGiE8L8e5wQroXB7COcXsq2+E+YB
 fnhfwRkKM3BUuZfuIpOqUDMick+Z1XZDlUY38v7qm5HQS0AIpM2FwLPN8JkQFTch52nkATkrasm
 i5R1qpCec6A5ExyH08RfNyt1Due4RW54Fkt/obR13Ri8AlPZxYHZwbYkfMINs0=
X-Proofpoint-GUID: 317_j8pPJOfnGWkfyCvy7-6MoBM44Qjq
X-Authority-Info-Out: v=2.4 cv=aoa/yCZV c=1 sm=1 tr=0 ts=69b5de07
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=ZQo066cDFu1GxkA6GkEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_06,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 clxscore=1030 adultscore=0
 mlxscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603140175
Received-SPF: pass client-ip=57.103.67.78;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Localised fixes for QEMU 11.0:

- fixes for -cpu host, including an ID_AA64MMFR2_EL1/ID_AA64MMFR3_EL1 mixup
- add EC_DATAABORT assert for WHvRunVpExitReasonGpaIntercept/UnmappedGpa

This one doesn't functionally change anything today, but is good to have and is a single-line change.

- fix Hyper-V enlightenments

AccessVpRegs turns out to be necessary too. Linux doesn't check for its presence and panics in an Hyper-V arm64
configuration without it exposed.

Fixing a mistake in not following the QEMU code style and having had AccessHypercallRegs included twice at the
same time. Also add some more privileges because it looks like guests don't check for presence of each one
systematically...

- SME support shipped in Hyper-V now

So remove a code comment. Another one-liner.

Mohamed Mediouni (5):
  whpx: arm: fix -cpu host
  whpx: arm: add EC_DATAABORT assert for
    WHvRunVpExitReasonGpaIntercept/UnmappedGpa
  whpx: arm: enable more enlightements
  whpx: arm: remove comment bit that is no longer accurate
  target/arm: cpu: alter error message for host CPU type

Osama Abdelkader (1):
  whpx: arm: fix ID_AA64MMFR3_EL1 host feature register index

 hw/arm/virt.c              |  2 +-
 target/arm/cpu.c           |  4 ++--
 target/arm/whpx/whpx-all.c | 11 +++++++----
 3 files changed, 10 insertions(+), 7 deletions(-)

-- 
2.50.1 (Apple Git-155)


