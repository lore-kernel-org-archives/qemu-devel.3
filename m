Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C38AD58CBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 21:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4mtV-0002Ev-CC; Mon, 23 Mar 2026 17:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4mtT-0002Dy-7b
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 17:33:03 -0400
Received: from p-west1-cluster6-host12-snip4-4.eps.apple.com ([57.103.67.17]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4mtR-0007Sv-5y
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 17:33:02 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-10 (Postfix) with ESMTPS id
 11F941800221; Mon, 23 Mar 2026 21:32:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774301579; x=1776893579;
 bh=nrLXP1QTNd0Nhoo5J4KqUWSwEnP9mfW1pBNjQH6nsp8=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=ExtZzMUz1h+YH6ppD0szNTHbldAvweEdXLOiYz4qTJunT66Np6dOfh+Q4A5PbhXROZeDLql4gHIgzau1AmFWkeM3lCVj9+jWAkeEXbDKZ41ZLW9Xd8cDPSaVECFNyqexHL/oUzl7AR/8VyWUup45wCZ6GMYfkWP67ZWFrlwzLauWmklvQpMI5bkMkRzscvp3JlVTtZ2FFYp682uLB9dlKWmzU6MyPhBvsvoa7ve9+IVwqtOasBfPkgFCZ8sEANkrsL7i1wekX+nw7ip/NuEvwjMGw8/eGQFgePjCotMHdvu7N+JKmPo8JOdy59ehO2O8MIaamwgXgD6UCsqOYocz7g==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-10 (Postfix) with ESMTPSA id
 E33131800118; Mon, 23 Mar 2026 21:32:54 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v2 1/1] meson.build: Add --enable-pdb option
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <MN2PR02MB6622D6619419DCD792B5F3B59B4BA@MN2PR02MB6622.namprd02.prod.outlook.com>
Date: Mon, 23 Mar 2026 22:32:41 +0100
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BAECD617-8F87-4D0C-8F8C-725333B436B2@unpredictable.fr>
References: <MN2PR02MB6622718572E2A2B5E4EE3C039B4EA@MN2PR02MB6622.namprd02.prod.outlook.com>
 <9c5998db-7368-4345-8d87-bdc0a0c9da78@tls.msk.ru>
 <CD39E113-FAE4-457D-A5C1-16BED1A94774@unpredictable.fr>
 <MN2PR02MB6622D6619419DCD792B5F3B59B4BA@MN2PR02MB6622.namprd02.prod.outlook.com>
To: Steve Aarnio <saarnio@qti.qualcomm.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-ORIG-GUID: tJSF2aPdHm0DQq8mxkChIHi0cjLMvyOC
X-Authority-Info-Out: v=2.4 cv=fKA0HJae c=1 sm=1 tr=0 ts=69c1b189
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=_V6FMey7jbM-WiHA6EYA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE2MCBTYWx0ZWRfX+lEAauQqJEPl
 7A5y6FY1NuQXZUOIzFjAga9KJDlszchu8P69XY3KIN4Nvbogoxmg4eC/ByGg8tp3qfieOC82hcP
 CBeAUidkHE6mSp0qjoufZljxFyfmvWvZnFUZc8XZ0Oq88XV8AcN+hxdBFcG3Cpzdf3aiGD0z9iH
 zcMBgsfNTVgqXyziTGPgGcFIItps8S6t86h5XFyJytax2PL7aws88p7hUoHIrJO9Moqt6TMahKN
 r6V6cTVZZEiLAdTo5FqyWhm3gvv7rV7GC9+0U1yXQFfWa3XHthkxmUYEyFU9quQYlBaJvao3qmT
 gJyfaJBY8oeAn5BrfORc72Su1O8T9AjrnUsnN+x9b49drSG/QzO7NQGPWIpRQs=
X-Proofpoint-GUID: tJSF2aPdHm0DQq8mxkChIHi0cjLMvyOC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=907 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230160
Received-SPF: pass client-ip=57.103.67.17;
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


> On 23. Mar 2026, at 18:44, Steve Aarnio <saarnio@qti.qualcomm.com> =
wrote:
>=20
> This option will (attempt to) modify the QEMU compile and link flags =
to
> emit PDB symbol files rather than the standard (DWARF?) symbol output
> from gcc/clang. Prerequisites for this are host_os =3D=3D Windows and
> --enable-debug flag set.
>=20
> This enables using native Windows debug tools (Windbg/Visual Studio) =
for
> debugging QEMU.
>=20
> Signed-off-by: Steve Aarnio <saarnio@qti.qualcomm.com>
> ---
> meson.build       | 5 +++++
> meson_options.txt | 2 ++
> 2 files changed, 7 insertions(+)

Hello,

A small thing on top:

diff --git a/configure b/configure
index cd1dadd8bb..e355484921 100755
--- a/configure
+++ b/configure
@@ -709,6 +709,9 @@ for opt do
       meson_option_add -Doptimization=3D0
       default_cflags=3D'-O0 -g'
   ;;
+  --enable-pdb)
+      meson_option_add -Dpdb=3Dtrue
+  ;;
   --disable-tcg) tcg=3D"disabled"
   ;;
   --enable-tcg) tcg=3D=E2=80=9Cenabled"



