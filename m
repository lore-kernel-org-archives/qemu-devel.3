Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6D6FC72AD
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2026 12:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4Hol-0002Jr-S2; Sun, 22 Mar 2026 08:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4HoI-00028H-Rv
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 08:21:41 -0400
Received: from pv-2001j-snip4-8.eps.apple.com ([57.103.64.101]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4HoG-0003mK-4o
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 08:21:38 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-7 (Postfix) with ESMTPS id
 82F44180021F; Sun, 22 Mar 2026 12:21:31 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774182093; x=1776774093;
 bh=NRNYftw+F8W4wdc8Q0+jqmNDbjfOs9Ll7J9c3EldO+E=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=W5ts3ccAG5r4yxsFabt47P+RiGpMU0KdNL/clhWW8fmPk6sXY+Yiewj6urizREIKnR4mavJz9lfa89zdOe4OQMVNlgIqS4kiQU1Nv0XiyHom3gjPgZ/DWJZ2JksdA5wPbmVBgYsTKEPJd5FtwjcuU6aiwJlnSgxQVG1FtqLMrqMl+hG1xBWoBOTWq7J8LFpWBRZHvgNDIG32MvvEimlA4hj6dtDs3q4KZ6lSq2MiV8Bdebuzw0sjP9uQoBwXffJDeiztB/6ySOa+2jbtc5xO+jH+TQ1itR1SyAarusmYVtU0YGvh6sPAi8OVgrPq75TGxyJgi28p018m7Beyvry6hQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-7 (Postfix) with ESMTPSA id
 B175F1800229; Sun, 22 Mar 2026 12:21:29 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH] meson.build: Add --enable-use-pdb option
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <9c5998db-7368-4345-8d87-bdc0a0c9da78@tls.msk.ru>
Date: Sun, 22 Mar 2026 13:21:16 +0100
Cc: Steve Aarnio <saarnio@qti.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CD39E113-FAE4-457D-A5C1-16BED1A94774@unpredictable.fr>
References: <MN2PR02MB6622718572E2A2B5E4EE3C039B4EA@MN2PR02MB6622.namprd02.prod.outlook.com>
 <9c5998db-7368-4345-8d87-bdc0a0c9da78@tls.msk.ru>
To: Michael Tokarev <mjt@tls.msk.ru>
X-Mailer: Apple Mail (2.3864.400.21)
X-Authority-Info-Out: v=2.4 cv=NLDYOk6g c=1 sm=1 tr=0 ts=69bfdecc
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=9qUTvQc-AAAA:8
 a=Dw3r2Dz2FUu6so0R2m0A:9 a=QEXdDO2ut3YA:10 a=axOgMmt4Ejcwn1cqzmsR:22
X-Proofpoint-ORIG-GUID: JHuA3XYAIJQveKTDMPMvHdqYYi7x4nKG
X-Proofpoint-GUID: JHuA3XYAIJQveKTDMPMvHdqYYi7x4nKG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIyMDEwNyBTYWx0ZWRfX6uTBcIwhXRbZ
 6PBMQ0YmcwzZoXhmXY/zplc64JMh3wkeVXcN3ADNLOgD9zEWave/+SNe5fTLOk7K8aCZ1IGqsII
 KCxuajKcrJHbvyl/dN46qWbAhbPPundBLsVM76vAC2rbvOPLvwuIfHw37CuI6VSBndy8yp1b+vg
 5Nu4PFvRauS5lVaWAsSxjkW/zafCmvnI2Sci6Z3iwHcFPlk7xmqezJ2WdwjeO/6OAe7CQgnDOkN
 ft1T56NPIJ8f70SXjaxIYeWw6JjgJvzhn4ubpQAO+2s/41pQlOUQQPhtAGD7c9B/2HTtLoh+edy
 s7Xb480TUePdacUlS15lo6MHYzbRr7qSuKGKQcik4X+QeC9Zml5suTZgB/jb68=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-22_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 bulkscore=0 clxscore=1030 phishscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=753 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603220107
Received-SPF: pass client-ip=57.103.64.101;
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


> On 22. Mar 2026, at 12:56, Michael Tokarev <mjt@tls.msk.ru> wrote:
>=20
> Overall, I think there's no need to have separate option especially
> for pdb, - it can be enabled on windows when --enable-debug is
> specified (or is it --debug? I don't remember).
>=20
> This code:
>=20
> option_cflags =3D (get_option('debug') ? ['-g'] : [])
>=20
> can be extended to add the necessary compiler options.

Hello,

I think that=E2=80=99s a bit suboptimal because while Clang can generate =
PDBs, the same
isn=E2=80=99t true for a GCC build, where gdb + DWARF is in practice =
preferred instead.

A converter exists at https://github.com/rainers/cv2pdb however to cover =
the GCC
case but the compiler won=E2=80=99t do it by itself.

And people might also want to use gdb/lldb when they can :)

Thanks,
-Mohamed=

