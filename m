Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCBB10A88E5
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 16:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5nfR-0002wG-QX; Thu, 26 Mar 2026 12:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5nfP-0002v3-9O
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:34:43 -0400
Received: from p-west1-cluster6-host9-snip4-5.eps.apple.com ([57.103.67.88]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5nfN-0001nk-8x
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:34:43 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-1 (Postfix) with ESMTPS id
 70C2C18005FF; Thu, 26 Mar 2026 16:34:37 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774542879; x=1777134879;
 bh=/XsmZsE7t169LBlFSfaEOUcCKSCVlhhpZpyFhFLVTA0=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=SxEqCGvERew/+rcDYuVMcjDVXG/xYWx7Kw0gHw1pUv06+RcpzchziaLgiGIV2iWl1s6igZkzRxc8KxVAmnqh9Wl7IxdzVRphlErTVX/2RAljs/rJuOaFN83alSCQDs4FAoXeCmtUXrAWQQYpIDR3OvPxe8/BGYLyOeLDwt89dlpmoHXLwE3uBgCD6ESFGtNyXrPoFdFh7gdOYvM4gsSn9lZ3ct2mEcNN3pW/rV+oj58tYXmvMpfGSFdi2uQLQx7UZUYZ3Mw6+dsngdJ9mLYzAYa+WaM/0hIeNALlennyB+kDKAekItm4hYJyCRH/+jPyF+egOGvZiX1JPK7DeriWGA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-1 (Postfix) with ESMTPSA id
 EF4A8180033B; Thu, 26 Mar 2026 16:34:34 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH 0/7] Misc changes to allow building with Windows Clang
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260326160033.68318-1-kkostiuk@redhat.com>
Date: Thu, 26 Mar 2026 17:34:22 +0100
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?Q?=22Daniel_P_=2E_Berrang=C3=A9=22?= <berrange@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E4E91C9F-222E-41CA-B51A-928480FDC405@unpredictable.fr>
References: <20260326160033.68318-1-kkostiuk@redhat.com>
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDExOCBTYWx0ZWRfXwlw1QccDcW5c
 ua+Ca6GGQkWh8hMut1TtOC1TJSadcJ1RZhwQhmGHB70LO53YcfY/Oe4N0Tc+8DwPUCBOfzTPMEb
 zNhUEklUhSLZNY2bQR5Bprywedn24bkGKYAnJAsfC10Vn+Y4+DeZuahUc2YbvP+1+DZH9D6DBie
 WMeHuc7tzsxKBEBbDye9HONdqGc2qqTaTDAt8y7VFaj9JLvdXxNh0T60+zOHKXqnrEXcO2LYDjT
 yNOCdWFds2Z23Ilv+pZ2OCuzHNPn4HixaBWLkGijzQHgSqIDM3T3Npx5RtW0g3fphOPWewAHjCl
 7HewN0Koa3FOLMMVaLOCoT7SlOWP8X3zwHqTa16iNMcwmzZPoI458mqaydXmEo=
X-Proofpoint-GUID: _cLviY2t-nOn2j_5z68ou_I9G9sYmCaK
X-Proofpoint-ORIG-GUID: _cLviY2t-nOn2j_5z68ou_I9G9sYmCaK
X-Authority-Info-Out: v=2.4 cv=C7fkCAP+ c=1 sm=1 tr=0 ts=69c5601e
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=iaFFB3VQxh4Zur26TvYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0 clxscore=1030
 malwarescore=0 mlxlogscore=634 spamscore=0 suspectscore=0 phishscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2603260118
Received-SPF: pass client-ip=57.103.67.88;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


> On 26. Mar 2026, at 17:00, Kostiantyn Kostiuk <kkostiuk@redhat.com> =
wrote:
>=20
> This is the first set of changes to allow building qemu-ga with =
Microsoft Windows Clang.
> It includes some cleanups and fixes that also make the code more =
portable.
> The main goal is to be able to build qemu-ga with the MSVC toolchain
> because MinGW-w64 is not available for ARM64 Windows.
>=20
Hello,

MinGW-w64 is available for arm64 Windows, although it=E2=80=99s more
mature with Clang as a compiler instead of of MSVC.

Is it more of a packaging issue with distributions?

Thank you,
-Mohamed


