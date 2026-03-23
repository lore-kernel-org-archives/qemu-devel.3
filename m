Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63173F483E9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 19:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4l5Q-0005pL-Gw; Mon, 23 Mar 2026 15:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4l5A-0005m2-Bx
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:37:02 -0400
Received: from p-west3-cluster3-host6-snip4-2.eps.apple.com ([57.103.72.143]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4l55-0004WJ-F7
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:36:58 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPS id
 D5C6B180025F; Mon, 23 Mar 2026 19:36:50 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774294611; x=1776886611;
 bh=pWzKo8PZ1LhCZHNnADOX7A+F2R0UBx9d0wtO1m61iAI=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=LcRewj5BuvLq0qpODLk1jU06S8FLwn+oYS6PWPMHIpyQ6RLecueS2NYDlX9U3H9bgZi88hfx/H1wxpyLM1qNH7La3bZGpNliyUcDkRgybh4TfJPoMYLbgYwnsG0JDjm9O6Aw7FYmzkIXUBS+GJHRo7hopf1BksPRnHX+PUOEtoS3Y45VfDscE0eAmukiMYpCh8lKwk1Z2E4hk4KBUO2vWCnYwquTRLKkTZT7VxpNe/plf0B2c4h+ar+gxbk+JYCxSfDQFaCLDGiVWGL4ygZTKe2Mw7wzNAA+RJd0wEj4HT2TvYbzKVol6FksVVzGZNTH9GhP7dvZghPF0Z8S946mwQ==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPSA id
 E03981800342; Mon, 23 Mar 2026 19:36:48 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH 00/12] whpx: i386: Windows 10 and performance fixes
Date: Mon, 23 Mar 2026 20:36:33 +0100
Message-ID: <20260323193645.82602-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=MsRfKmae c=1 sm=1 tr=0 ts=69c19653
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=p0WdMEafAAAA:8
 a=td4nV04XUHi7FXuGOJ4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NDfAIJnYV7v4NEA71dtWA7_F8jmwQQDA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0NSBTYWx0ZWRfX7F01+NVwxoc6
 Drx1MOf4mCje74EkZf8syS43dBufceS+zc+33d2OssX3ey1x5+sp39SPctGWiKX510qW6GvyEOM
 vnBXykINvoX9eGtQehFAuFzfzq7oesQJSLUbowtnhHOXjGUzTKvH+Db2vASKwkvGTwdch/m/MnI
 GO+OvjjzwXsBs0cAFBkFtTvkSAaFq+86XMFlztH1wPg3AJXv5LC09lH7tYlfcLIIqvO0VINgVYN
 6T5FIAx6MyW4RjjvGvKYtQ8BvSPZJDeneYxm26FFmMRBX1f0P+onRAFN/CFY6Um+pbFsZfCto0V
 jwZrKUZGM1k3gZJzsD5zxRo25qCqWl0BZ9eLMULHJwDWrZmTJw6HeiZ7DOBdpI=
X-Proofpoint-ORIG-GUID: NDfAIJnYV7v4NEA71dtWA7_F8jmwQQDA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 mlxlogscore=387 clxscore=1030
 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230145
Received-SPF: pass client-ip=57.103.72.143;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
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

On Windows 10, the paravirtualisation enlightenments aren't available.
And neither is performance monitoring. Using the former as a gate to
operate in a reduced-functionality mode on Windows 10.

And on the performance side, some state is really expensive to fetch
or write with Hyper-V so switch some less-essential state to on demand.

The effect of this is magnified on Windows 10 because Hyper-V enlightenments
are not available there.

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
 target/i386/emulate/x86_helpers.c |  84 +++++-----
 target/i386/emulate/x86_mmu.c     |  11 +-
 target/i386/whpx/whpx-all.c       | 263 +++++++++++++++++++++++++-----
 4 files changed, 274 insertions(+), 90 deletions(-)

-- 
2.50.1 (Apple Git-155)


