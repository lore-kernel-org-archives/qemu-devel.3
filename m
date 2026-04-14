Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73905F9D0F0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 18:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCiPY-00068e-59; Tue, 14 Apr 2026 14:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCiPN-00065e-Kd
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 14:22:45 -0400
Received: from pv-2005i-snip4-5.eps.apple.com ([57.103.66.196]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCiPL-0006T3-EA
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 14:22:45 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-9 (Postfix) with ESMTPS id
 50A6118017A6; Tue, 14 Apr 2026 18:22:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776190958; x=1778782958;
 bh=NVxxxPHNZR19YqKhkbdqecMHsddaxqh7WDU8dhWlP/E=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=edyM3tzpj3gn4dYwFy+YWDiVA3KO53py0CsHh9BiQxXYKxmn1sMtkIqDdIITVEJ/t3FSqG6EPzHLgIRA4T3R5GhBwX372MMZaCIpCZPMBIL7lXeVRat4Hvc6fzfpOOaSCe6OAf+JyvE0GDhGU4iyoIn1hm9GCVhI6ZrPcgEcaNi7YvcaC9xRBm8J79ty1p9oViAINqgAVNnnKAy5dHdFYN1XaHy/Q3FFlvfqytMXIcg9E60x9INdOhWRVHmvJByMcwEC0B3/cbSXLgQiYXS/cdBS9hU50PHD2byK9h3vmvBXvQ+R4W1aX7YRfT510J7t8CGVq6a/wV0GQjDj5RenPA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-9 (Postfix) with ESMTPSA id
 5D0BF18001DB; Tue, 14 Apr 2026 18:22:34 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/7] whpx: i386: Some more changes
Date: Tue, 14 Apr 2026 20:22:24 +0200
Message-ID: <20260414182231.18776-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=U/qfzOru c=1 sm=1 tr=0 ts=69de85ed
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=oOLWm9IBL3BG_uuw-oUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Bwy4s5e7HmDEjrxFgZDGBuNQHX5YhvUS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE3MiBTYWx0ZWRfXwljp5hcHXi4F
 qb7HXb7UkVV3FUErhBBJWZEij7CbfyOqNBThOzkh0BztEx+JvLtqOuhY8erR19lrKUBT/QiPNpd
 LvV5z6W5NmnHUkcaz2t1K2AdfhjgyVftYf/EFnMDtRwLA00eTlEy1HzBI4RLeVqTPMwbMTqJOID
 lGnOZGDIXGMMP2aVTeg+QBPVhQO8fJmGGcKscTQZGFzIQ38r8hf3z/hN1I3y+1xmyShhT/ROUgS
 u5f9yOSunbFw6N1BkaOhSFtGsv2g+zd2HeZSRHQtmNsiGmMhEjGlMJ+YPOvRNbsnsk94GyTAkrP
 G9a8G5fGQQuE6WHym9/qgZFQIK39q40JSxMPIBbWh0vKyR9/N3sEE7o0KVGBBo=
X-Proofpoint-ORIG-GUID: Bwy4s5e7HmDEjrxFgZDGBuNQHX5YhvUS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 clxscore=1030 phishscore=0 mlxlogscore=710 spamscore=0
 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604140172
Received-SPF: pass client-ip=57.103.66.196;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This applies on top of the "whpx: i386: bug fixes, feature probing and CPUID" series.

"target: i386: HLT type that ignores EFLAGS.IF" is probably the most worthwhile patch
here, and that not-quite-an-HLT might be what's needed to reduce CPU idle on KVM on
recent Windows versions too..

Based-on: <20260413205208.50643-1-mohamed@unpredictable.fr>

Mohamed Mediouni (7):
  whpx: i386: set apicbase value only on success
  whpx: i386: unknown MSR configurability
  whpx: i386: enable GuestIdleReg enlightenment
  whpx: i386: tighten APIC base validity check
  whpx: i386: ignore vpassist when kernel-irqchip=off
  target: i386: HLT type that ignores EFLAGS.IF
  whpx: i386: add HV_X64_MSR_GUEST_IDLE when !kernel-irqchip

 accel/whpx/whpx-common.c       | 38 ++++++++++++++++++
 include/system/whpx-internal.h |  1 +
 target/i386/cpu.c              | 10 +++--
 target/i386/cpu.h              |  2 +
 target/i386/whpx/whpx-all.c    | 70 +++++++++++++++++++++++++++++++---
 5 files changed, 112 insertions(+), 9 deletions(-)

-- 
2.50.1 (Apple Git-155)


