Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8825C27C55
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 10:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFX7s-0000GZ-8a; Fri, 07 Jun 2024 06:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1sFX7o-0000G6-Qw
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 06:47:12 -0400
Received: from qs51p00im-qukt01071501.me.com ([17.57.155.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1sFX7n-0003y4-8K
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 06:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1717757227; bh=5VPpkxIv4qSeSXjxKk3cVUF/jAopaZ1NdrEr+y+ic10=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
 b=epsljat0wgrZSLBEgqUMKnssyg3MZ4rBto1GU3jqkFk8MTnjMtl+fZ6SDvRbjSQsS
 tUm/c/LCDWy35B2t4fzQTuTZpjc/iSYmQf2zcuYBIwQ/4oBXksD5DQLc/Il1LYHtbb
 DTeiu2OffD90qa9pL/AHH6+4YFkHzNIv6DiNaVSBkKGpZeYhF4PR3VlX7cvT5IAWBJ
 Nq+vLiGdh7tQSwiprNnyfaPiqNhkWK2a3QkrvIRGsP7HiQtaVDqNUwiMKBJ/mmbMVX
 4z7E/JIMT/QOzJIUMVd5Th8NmrSOhBcTFJY1fv7PxGVRPeBKoMt5nmOJKV6a2geCWV
 KMNMdScBJscrQ==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com
 [17.57.155.28])
 by qs51p00im-qukt01071501.me.com (Postfix) with ESMTPSA id 221D61C402D0;
 Fri,  7 Jun 2024 10:47:03 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH 0/5] trace: Remove and forbid newline characters in event
 format
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20240606103943.79116-1-philmd@linaro.org>
Date: Fri, 7 Jun 2024 12:46:50 +0200
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <867D16AD-D9FA-42BE-A51F-8CE6274941EC@ynddal.dk>
References: <20240606103943.79116-1-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-Proofpoint-GUID: lS6ppaj8x9GvUssqWmQcgKMHpXw4hD9F
X-Proofpoint-ORIG-GUID: lS6ppaj8x9GvUssqWmQcgKMHpXw4hD9F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_05,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 clxscore=1030
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 mlxlogscore=711
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2406070078
Received-SPF: pass client-ip=17.57.155.4; envelope-from=mads@ynddal.dk;
 helo=qs51p00im-qukt01071501.me.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

>=20
> Trace events aren't designed to be multi-lines.
> Few format use the newline character: remove it
> and forbid further uses.
>=20
> Philippe Mathieu-Daud=C3=A9 (5):
>  backends/tpm: Remove newline character in trace event
>  hw/sh4: Remove newline character in trace events
>  hw/usb: Remove newline character in trace events
>  hw/vfio: Remove newline character in trace events
>  tracetool: Forbid newline character in event format
>=20
> backends/tpm/tpm_util.c       | 5 +++--
> backends/tpm/trace-events     | 3 ++-
> hw/sh4/trace-events           | 4 ++--
> hw/usb/trace-events           | 6 +++---
> hw/vfio/trace-events          | 4 ++--
> scripts/tracetool/__init__.py | 2 ++
> 6 files changed, 14 insertions(+), 10 deletions(-)
>=20
> --=20
> 2.41.0
>=20

Acked-by: Mads Ynddal <mads@ynddal.dk>


