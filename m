Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B57F54ACF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53YY-0003X9-GU; Tue, 24 Mar 2026 11:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w53YV-0003Vs-LF
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:20:31 -0400
Received: from p-west3-cluster1-host10-snip4-10.eps.apple.com ([57.103.73.231]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w53YT-00071U-KZ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:20:31 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-4 (Postfix) with ESMTPS id
 AF9D41801060; Tue, 24 Mar 2026 15:20:26 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774365628; x=1776957628;
 bh=m7mAT4upwcxrp87zHJdKW05vucl4iAz7/i6tJAV9lqg=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=QKoAWovFCLLMblWf5+7ww5eHtvIRNd6Zzc14n+WnhbwLHWj0DLVemHB1E1/Phy4ALO3O5is13fBNJ7IeDwZuZUab8S80UAoOGkN998FrCyYNgwGxZ+4RY8INRJ9HdNCDasSNtftmfPL3yKwvUxAYIpsxRvLCb6yIUl9Th65qYBz4W3E5I9wBKCeFsPOqvqFVH/tV32bKtlB9VCD6kO7G5cq1bj3l3ITAcdDaDMSEEtrmj9taqjrIGhhhizB8Y3behyu86yg0TeTiKdGUqPXx1n16LeUDwrHkHcKz3taPn9IGx6Z7JyU7HllXquUJRrjedE9BhHetluZLpCQNGeh1GQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-4 (Postfix) with ESMTPSA id
 A17DF1800859; Tue, 24 Mar 2026 15:20:24 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v3 00/12] whpx: i386: Windows 10 and performance fixes
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260324151323.74473-1-mohamed@unpredictable.fr>
Date: Tue, 24 Mar 2026 16:20:09 +0100
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <777690A0-00B9-4594-BEC1-01F0C85BD438@unpredictable.fr>
References: <20260324151323.74473-1-mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-GUID: 4qT0gnWmqswChlSlSbjm5mgtBr6LqDg8
X-Authority-Info-Out: v=2.4 cv=acpsXBot c=1 sm=1 tr=0 ts=69c2abba
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=p0WdMEafAAAA:8
 a=9cL9ESpxoZm89UfrzisA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 4qT0gnWmqswChlSlSbjm5mgtBr6LqDg8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfXx6QH3u2oJgnD
 xSFWuqGuwQ8bC4zMLayrTfKJXnHOXyOa9SKcvcerFm+BUZckZ9lfOfn2SFqEIlgA48PSXsTSTpK
 jw+hzy2el9tcML1Yn1XV1KJJk+2fM82iwORu4KihwoKj32suMT6zygh3qJFCLGJOlX+dw0P/J8o
 Qtmet/BEdBNIlYSaapO53Oyi2mHHacq4SPfO9BHmrIzZNcagKnQrofFMky9wRpYT/suF2AXzbRt
 FPlOns0vxeHwjkwVGSZpfNjkkqmx4Q75Q9Ag0u5m10vGYiO3WPWQBCE6VxlNMH5bfgD+NGv8uQM
 9dWkq7JpM9r66Pi/ulL3KK/ZQBBSEntBiRge2cBH66FGyjrRBMP8fs9pCg6uck=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=681 phishscore=0 spamscore=0 clxscore=1030 mlxscore=0
 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603240119
Received-SPF: pass client-ip=57.103.73.231;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
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


> On 24. Mar 2026, at 16:13, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> On Windows 10, the paravirtualisation enlightenments aren't available.
> And neither is performance monitoring. Using the former as a gate to
> operate in a reduced-functionality mode on Windows 10.
>=20
> And on the performance side, some state is really expensive to fetch
> or write with Hyper-V so switch some less-essential state to on =
demand.
>=20
> The effect of this is magnified on Windows 10 because Hyper-V =
enlightenments
> are not available there.
>=20

Some performance numbers from =
https://gitlab.com/qemu-project/qemu/-/work_items/3349
on Windows 10:

QEMU 10.2: 2 minutes
QEMU 11.0rc0: 8 minutes
This series: back to 2 minutes

This brings us to performance parity with older QEMU using =
winhvemulation=20
on Windows 10.

> Side note: On Windows 11, use WHP with kernel-irqchip=3Don. On Windows =
10, looks
> like issues there are still lingering, with issues #289 and #346 still =
problematic.
>=20
> v1 -> v2:
> - fix x86 HVF compatibility
> - small nits
> - added workaround for an issue that showed up during 32-bit Linux =
boot
> on AMD
>=20
> v2 -> v3:
> - Remove ad-hoc workaround in segment fetching and replace it by =
something
> more proper.
> The affected commits are "whpx: i386: fetch segments on-demand". The =
old
> workaround separate commit is no longer present (or needed)
>=20
> Issue number: https://gitlab.com/qemu-project/qemu/-/work_items/3349
>=20
> Mohamed Mediouni (12):
>  whpx: i386: workaround for Windows 10 support
>  whpx: i386: enable exceptions VM exit only when needed
>  whpx: i386: skip TSC read for MMIO exits
>  whpx: i386: skip XCRs read for MMIO exits
>  whpx: i386: don't restore segment registers after MMIO handling
>  target/i386: emulate: add new callbacks
>  whpx: i386: add implementation of new x86_emul_ops
>  target/i386: emulate: indirect access to CRs
>  whpx: i386: indirect access to CRs
>  target/i386: emulate: segmentation rework
>  whpx: i386: fetch segments on-demand
>  whpx: i386: fast runtime state reads
>=20
> target/i386/emulate/x86_emu.h     |   6 +
> target/i386/emulate/x86_helpers.c |  83 +++++----
> target/i386/emulate/x86_mmu.c     |  11 +-
> target/i386/hvf/x86.c             |  11 ++
> target/i386/whpx/whpx-all.c       | 280 +++++++++++++++++++++++++-----
> 5 files changed, 302 insertions(+), 89 deletions(-)
>=20
> --=20
> 2.50.1 (Apple Git-155)
>=20


