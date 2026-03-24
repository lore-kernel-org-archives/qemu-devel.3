Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C04CF54AC5
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53U3-0006v1-Qc; Tue, 24 Mar 2026 11:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w53Sq-0005t9-CH
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:14:42 -0400
Received: from p-east2-cluster6-host5-snip4-2.eps.apple.com ([57.103.76.213]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w53Si-0005r4-1A
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:14:37 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPS id
 5A8EB1852A20; Tue, 24 Mar 2026 15:14:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774365260; x=1776957260;
 bh=PrnaFVMUvIIHha2SMJ3Sjt+yf2yJCuYxgQgmrdLyu/Y=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=QQJNasMhWilJNK4csqFGjQFGDzUNd6CAYeA3SJUQDzlmMu66JO+svjhWh+gPKX1p3r53dwiTsWeGL+0mm5dPiNxWurmKrvWyJ06jhDu1vm8trWxEiKyrqgyBn0hB8+8K/ZF5nr2EK+LG1aWzBYI/M48Aw3Fa0gy/mBjb3TT4G5cdDFRzJcRmldY6zheqx51Py6+8twcjMy2UpcD2OKeqlPEcALT5f4+eKMWRU94B/A7J36GX10SzN6u9cnivkr60gTchBWHZJ4wM8ErTgZJ0VFhYNdkl0CT+Oug25XQJURkVlSAQmXssdPyDeKC1DrLF8+eaNoZlei27kae8HGFkOA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPSA id
 922BF183530B; Tue, 24 Mar 2026 15:13:37 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v3 00/12] whpx: i386: Windows 10 and performance fixes
Date: Tue, 24 Mar 2026 16:13:11 +0100
Message-ID: <20260324151323.74473-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfXwihaOKXjl/NM
 IOXxGbW8hUE37m5i3e+21SgRdkQXnVpt5/jMjjGKh/vUK4a0h37DrJYq71TIbknOSllU0mQaN4w
 a6mZcRPqBN6kgcBW9j0WSr2FoCzCiPaOklsriiW3gsJ8A2EGS3n/sZTz5VsAI4tpL4dgaYfz7MD
 TpY8btwBSBHBiUoRPnYATXlpFZXcuY6lfth9g0ZBXtnmZ6xiHKMhBMhHz2b1DHkw3osKklH28Ze
 Eb8smL1vMSOYXs1FKGoEkt2whw4z8o06gfpfNNI33iWX9IJZluFSQisNgrrF0BzSVhRdrGogCH1
 bwhAeFesML6WDbgHOa1dvsIx4ab0Ed0pPcvwAx6jtHu7p5jCt3FwrpY0xsRziY=
X-Proofpoint-ORIG-GUID: ACL_HkhRyiKjPiMMetcvd0t5fjGyH9-P
X-Authority-Info-Out: v=2.4 cv=TaybdBQh c=1 sm=1 tr=0 ts=69c2aa4a
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=p0WdMEafAAAA:8 a=td4nV04XUHi7FXuGOJ4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ACL_HkhRyiKjPiMMetcvd0t5fjGyH9-P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=652
 mlxscore=0 spamscore=0 clxscore=1030 malwarescore=0
 lowpriorityscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603240119
Received-SPF: pass client-ip=57.103.76.213;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Windows 10, the paravirtualisation enlightenments aren't available.
And neither is performance monitoring. Using the former as a gate to
operate in a reduced-functionality mode on Windows 10.

And on the performance side, some state is really expensive to fetch
or write with Hyper-V so switch some less-essential state to on demand.

The effect of this is magnified on Windows 10 because Hyper-V enlightenments
are not available there.

Side note: On Windows 11, use WHP with kernel-irqchip=on. On Windows 10, looks
like issues there are still lingering, with issues #289 and #346 still problematic.

v1 -> v2:
- fix x86 HVF compatibility
- small nits
- added workaround for an issue that showed up during 32-bit Linux boot
on AMD

v2 -> v3:
- Remove ad-hoc workaround in segment fetching and replace it by something
more proper.
The affected commits are "whpx: i386: fetch segments on-demand". The old
workaround separate commit is no longer present (or needed)

Issue number: https://gitlab.com/qemu-project/qemu/-/work_items/3349

Mohamed Mediouni (12):
  whpx: i386: workaround for Windows 10 support
  whpx: i386: enable exceptions VM exit only when needed
  whpx: i386: skip TSC read for MMIO exits
  whpx: i386: skip XCRs read for MMIO exits
  whpx: i386: don't restore segment registers after MMIO handling
  target/i386: emulate: add new callbacks
  whpx: i386: add implementation of new x86_emul_ops
  target/i386: emulate: indirect access to CRs
  whpx: i386: indirect access to CRs
  target/i386: emulate: segmentation rework
  whpx: i386: fetch segments on-demand
  whpx: i386: fast runtime state reads

 target/i386/emulate/x86_emu.h     |   6 +
 target/i386/emulate/x86_helpers.c |  83 +++++----
 target/i386/emulate/x86_mmu.c     |  11 +-
 target/i386/hvf/x86.c             |  11 ++
 target/i386/whpx/whpx-all.c       | 280 +++++++++++++++++++++++++-----
 5 files changed, 302 insertions(+), 89 deletions(-)

-- 
2.50.1 (Apple Git-155)


