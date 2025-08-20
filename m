Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8D3CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 11:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uohN6-0005fw-Rj; Wed, 20 Aug 2025 07:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uohN3-0005em-KG
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 07:52:49 -0400
Received: from p-east1-cluster2-host2-snip4-7.eps.apple.com ([57.103.88.148]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uohN1-0005qx-LZ
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 07:52:49 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-7 (Postfix) with ESMTPS id
 AD61918001B3; Wed, 20 Aug 2025 11:52:43 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=Zy09phtL1II7k91Wj0EsJXfyA2sIe9h8kaT5cZNKO8s=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=nbxJEqUgFtoQZcHd8SokwHggou9CdsBaJng+4iSD5+UONB21uaCC8XvaE3I+HX4yOE33g0qpUoGp3G6IRI1zGm1fR8gyh1166U4+io5cfIyLtG/TZUZblq2ASQ7+7lvb8VpdTSgHp5N8ODJsSnMypCqO+selcAwR/i3TKDjEeihT6VizNsdY8MHMp1Ml6LewV3Ho23jt+n8CxXIGciE8oYZ/bmStvVfIgJFZB394BG1npFjjj4AkD0cg3OLgZVNRMbu4XjL6SMkxnEJoZqSvRbU9iZtLtMox/gS3nt5ij/xXmNbxVddetQ1dKoDjLj3y273lv3zTUtGzqjrvsAEMFQ==
X-Client-IP: 194.62.217.67
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-7 (Postfix) with ESMTPSA id
 400471800B82; Wed, 20 Aug 2025 11:52:42 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 0/7] target/arm/hvf cleanups
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250818041354.2393041-1-richard.henderson@linaro.org>
Date: Wed, 20 Aug 2025 13:52:30 +0200
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, qemu-arm@nongnu.org,
 philmd@linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A75918AC-58FA-467B-95A0-E5D54F68434F@ynddal.dk>
References: <20250818041354.2393041-1-richard.henderson@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-GUID: 3AAM5PxQeJG-jdVyDpzU4wpL6qf_g_9R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEwNSBTYWx0ZWRfX4Vadqmy63LlG
 rG0PSv5NS4j2iIOP4AcLbF0628aoNlymP5VqcsXJHX6awvsfFH/jhtSXKAZ4P3/30zDstyYHK+r
 LH24qARNrp9o4KkVEYukH458l0h7qQlWYcWBA1Kg+wnLraOTSIgXI4S4zt86ioO0HjpLXlT26hV
 JHkVx1tOS4LIIRVcfIPa8m3Z35CQxwTx4k0tYCCD03bWxpud3hCH8YzgwTiNKGS30BX4jhpQ4eY
 jKQlCONUptqA16r/gLRWBhwT7Qs1JPR3d33QBPT8TRLlt2nSZL1Pu6PEzQRZrl1qCmTcViKls=
X-Proofpoint-ORIG-GUID: 3AAM5PxQeJG-jdVyDpzU4wpL6qf_g_9R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=868
 clxscore=1030 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 malwarescore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2508200105
X-JNJ: AAAAAAABKAGIFYIcWJ36QY5FV9Bn7+/3cbTdnbYVUzJbAbe9DrutZsQAzrPey9PNVgkqIuxhCzKGrK3LYoDt4lvSbQtok4xjSlNQtRk7MUmhO8b2TLgtW23Z7at/zcoTXLz2W+R9KE0Yas7rV55mqPNIcpwFtP1v0MmCXq97WgVSJUQd9bqGaDtnOBVlSGtCdvM9xSj6a3ZTpj9PlP6T7Dv1aRcO0MTXOI0eJLwapsYdlBC1pEDBhr4Ky5TWTHDaz47o2zEo9VdNVOZJfaVxWjCFTcYpMb65TIGCMJp3Wt8KA7hvvtAAtysjmrklGjUf4VXbb1ANthFsPoqVARvUsqYAeXleb5kTnCTh2hERm96hWpUz0aJAKn8xRfqqevrRX8eT7BUi7VOyZoUdHih1cg/5fQFkxwGMk2qX4zL8v6GQ54DEdOE+kk+7dGe8FB7qktXCwqc=
Received-SPF: pass client-ip=57.103.88.148; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


> On 18 Aug 2025, at 06.13, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> While working on other things cpregs related, I noticed that
> target/arm/hvf failed to produce a sorted cpreg_indexes[].
>=20
> I wondered if that explained the migration-test failure that
> we have, but no such luck.  (I have no idea how to debug that
> test, btw; so far it is still just a mysterious SIGSEGV.)
>=20
>=20
> r~
>=20
>=20
> Richard Henderson (7):
>  target/arm: Introduce KVMID_AA64_SYS_REG64
>  target/arm: Move compare_u64 to helper.c
>  target/arm/hvf: Split out sysreg.c.inc
>  target/arm/hvf: Add KVMID_TO_HVF, HVF_TO_KVMID
>  target/arm/hvf: Remove hvf_sreg_match.key
>  target/arm/hvf: Replace hvf_sreg_match with hvf_sreg_list
>  target/arm/hvf: Sort the cpreg_indexes array
>=20
> target/arm/cpregs.h         |   3 +
> target/arm/kvm-consts.h     |  11 ++
> target/arm/helper.c         |  11 ++
> target/arm/hvf/hvf.c        | 230 +++++++++---------------------------
> target/arm/kvm.c            |  11 --
> target/arm/hvf/sysreg.c.inc | 146 +++++++++++++++++++++++
> 6 files changed, 224 insertions(+), 188 deletions(-)
> create mode 100644 target/arm/hvf/sysreg.c.inc
>=20
> --=20
> 2.43.0
>=20

I noted the issue with HV_SYS_REG_MDCR_EL2, but assume we'll fix it down
the line.

For the series:

Reviewed-by: Mads Ynddal <mads@ynddal.dk>=

