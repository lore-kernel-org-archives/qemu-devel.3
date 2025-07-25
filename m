Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA34C83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 08:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufEDq-0007YW-8c; Fri, 25 Jul 2025 04:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufEDg-0007Ne-5F
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 04:56:03 -0400
Received: from p-west3-cluster1-host10-snip4-10.eps.apple.com ([57.103.73.231]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufEDb-0001pk-L8
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 04:55:58 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-0 (Postfix) with ESMTPS id
 4AB891800211; Fri, 25 Jul 2025 08:55:51 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=YLJlRVPFE10lkA4OEwEQJRpNecPcp3NCHOFGlsQjJkY=;
 h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version:x-icloud-hme;
 b=M9C63TBDt5zuwRQ5OoAO9g79tKanPtUMB/1gXeuCIdB4bQXBUA2SkonSPqonGCHbflquwGLpvNou266mRRIa6wWpw34H045whMl4EmeWWmneOeqWjIjNHHZqWMCPYMhs0uCmQLdOP23QCuGyebjeOZbqSIXamM2xpgZ9QjTm5KiIzAPPMwwDy5i5QJNvJXDMgXSqZ0b7JM8vpiqUXIn2NsVZd5SYSZtUE7PG+agEcdGEIbV3FJfig2uTZ+fStK7pFwNJgkKuItjSN1cBQQ6NOXREmpFgtnRXVpEZ89phqzOyfNYciXCrl/jjpRWiGZUXdP01w4Def+EOMU3FU1Bsag==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (ms-asmtp-me-k8s.p00.prod.me.com
 [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-0 (Postfix) with ESMTPSA id
 24F071800221; Fri, 25 Jul 2025 08:55:47 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 0/9] HVF: Add support for platform vGIC and nested
 virtualisation
Date: Fri, 25 Jul 2025 10:55:36 +0200
Message-Id: <20250725085545.93619-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA3NSBTYWx0ZWRfXzUhZiKgLafUN
 KLhRMST9UpWkeIywkyTEE02EeAtTalR+JQH0Qwoid+LNLHmpz1dFvDVf91veAGbbL5Wc/vqrpJv
 7FFSj8w3SPDwBT4JZ6nRIw6Qbpt/l9X0a+j8PLnmUC37sQ66lX4MAQrJk2GGRqHZmY+gsP6cru3
 7Vkenq/t5StywFz6v/f3WGRwHvpxqg77rbRd0PuKQz8BlXsFrs68LvC8/FJlqFawdBfbqrlA6yP
 I2oTSYNVWupviEjbHbC1EjoYHMc0etL/Q4/nKVm0B8Ci4Pyveo8xVvYtJpoxjPdkGLIlg8/c0=
X-Proofpoint-ORIG-GUID: FmvxNJOlZ1dtu9g8MPdIQdJLu9atJxuM
X-Proofpoint-GUID: FmvxNJOlZ1dtu9g8MPdIQdJLu9atJxuM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=887 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1030 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2507250075
Received-SPF: pass client-ip=57.103.73.231;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Early series.

Known issues:
- when nested virt is enabled, no UI response within EDK2
and a permanent wait. Workaround: -boot menu=on,splash-time=0
- Save/restore of GIC state isn't complete yet.
- Save/restore of HVF state when EL2 is enabled isn't complete yet.
- This series doesn't contain EL2 physical timer emulation, which is
needed if not leveraging the Apple vGIC.

However, this is usable and there seems to be some interest for it. Hopefully
it'll be at least somewhat useful.

PS: I can step up to maintain HVF support if needed. WHPX arm64 patch series
is coming soon too.

v1->v2:
Oops. I did a mistake when preparing my patches.

- Add hvf_arm_el2_enable(_) call to virt_set_virt
- Fix nested virt support check to add HVF

Mohamed Mediouni (9):
  target/arm: hvf: stubbing writes to LORC_EL1
  accel, hw/arm, include/system/hvf: plumbing changes for HVF vGIC
  target/arm: hvf: instantiate GIC early
  target/arm: add asserts for code paths not leveraged when using the
    vGIC
  hw/intc: Add hvf vGIC interrupt controller support
  hw/arm, target/arm: nested virtualisation on HVF
  target/arm: hvf: pass through CNTHCTL_EL2 and MDCCINT_EL1
  hw/arm: virt: add GICv2m for the case when ITS is not available
  target/arm: hvf: use LOG_UNIMP for CNTP_CVAL_EL0/SYSREG_CNTP_CTL_EL0

 accel/hvf/hvf-all.c        |  44 +++
 accel/stubs/hvf-stub.c     |   1 +
 hw/arm/virt-acpi-build.c   |   4 +-
 hw/arm/virt.c              |  34 +-
 hw/intc/arm_gicv3_common.c |   3 +
 hw/intc/arm_gicv3_hvf.c    | 624 +++++++++++++++++++++++++++++++++++++
 hw/intc/meson.build        |   1 +
 include/hw/arm/virt.h      |   2 +
 include/system/hvf.h       |   3 +
 system/vl.c                |   2 +
 target/arm/hvf-stub.c      |  15 +
 target/arm/hvf/hvf.c       |  91 ++++++
 target/arm/hvf_arm.h       |   3 +
 13 files changed, 817 insertions(+), 10 deletions(-)
 create mode 100644 hw/intc/arm_gicv3_hvf.c

-- 
2.39.5 (Apple Git-154)


