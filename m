Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC7AEA3C4E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 12:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAoP8-0004Xo-2A; Thu, 09 Apr 2026 08:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wAoOu-0004Wc-Bt
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 08:22:25 -0400
Received: from p-west3-cluster4-host2-snip4-10.eps.apple.com ([57.103.74.191]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wAoOm-0003Hy-Fu
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 08:22:20 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-8 (Postfix) with ESMTPS id
 8ECBC180013B; Thu, 09 Apr 2026 12:22:13 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775737334; x=1778329334;
 bh=KLnrO8mL5IStMbEJrR29Ubg8WAQVNNtCaURRaszSkxE=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=ArqFR8UoM6+OLhNX3hN0O5dionaKL6XrzEuzfRQPuY4DyF0mLp2y7yDpy2DuvPkuwb4EmzfABJ9VmnnVnvhB2mfa9O+0wGAInACJkxsrYm0eQwA3nwEQEdPNgmWjp3WqTUAP4jPYaX65/J3PRlBcK/m02dvfqwvqWhvXgEj+DLwll1uqE2RYhWX31Z8xNqKAcm6EXK2A23Rr7kUSC8PMjrVwAwV9BwvwsQWlA0DrPPUFttiDMs0IKgMvG0uPAktluUa/j8KujW+I0j4oip2EpQKvDnFlqaHZYDPPIRxzeE0z3pdMP4z6S1bkwgvZCwHb+d9G8Qw+VmPuIr5t0AoTqA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-8 (Postfix) with ESMTPSA id
 F3F38180009D; Thu, 09 Apr 2026 12:22:11 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] ui/sdl2: Fix assumption of EGL presence at runtime
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <87qzoo9vzu.fsf@draig.linaro.org>
Date: Thu, 9 Apr 2026 14:21:59 +0200
Cc: Anthony Roberts <anthony.roberts@linaro.org>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <627204A0-8806-4420-97A2-CBDC36C41981@unpredictable.fr>
References: <20260409110256.684-1-anthony.roberts@linaro.org>
 <87qzoo9vzu.fsf@draig.linaro.org>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=Cp2ys34D c=1 sm=1 tr=0 ts=69d799f5
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8
 a=9-IEq6fzTblGp0NDw5YA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: mFrWPupSsVhFjFdbpEdHI3YXOC0cbGUS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDExMiBTYWx0ZWRfX6ps+huV8UeYi
 S2S8bVDycrm+Yyk4WT5vbhf263RlMPI8mpIwdfbj8qElNJJEZODFrKkiJEFvmo+u+7wUwLJZnBY
 eKp/OeNrpjEqFPTPi2kwPniNpAIqlc4by07knc57tr2MKPMLb/86gQp1uxi3RaHuJwMwBTOZO7E
 hFeeNXodsObOw2tJdGKy+d5463Pm3yf21uuFdHD1MNIwCGU83CleOm5Tc+FJNCF2Z5yltUDrC70
 +yTCxUsBnbG53G3c/Jxx3Y0I4Pc0XUacTdM0omD4CDBhNUZS96YGjovgQ1eBRS0B05XYCB0a5vB
 GUwi2tAIBk9nTnlbcYYE/hM30oP4Ndzg5abRt+QvYfUT1oTIxMVN8dcEHNvAQs=
X-Proofpoint-GUID: mFrWPupSsVhFjFdbpEdHI3YXOC0cbGUS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1030 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604090112
Received-SPF: pass client-ip=57.103.74.191;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 9. Apr 2026, at 14:08, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>=20
> Anthony Roberts <anthony.roberts@linaro.org> writes:
>=20
>> The original commit had a section of code which worked on the =
assumption
>> that if OpenGL was enabled at build, it was present on the end user =
machine,
>> and calls could be made to it. This is not always the case (such as =
Windows
>> on Arm devices).
>>=20
>> This line should have also included a runtime check.
>>=20
>> This commit moves the relevant line to inside a runtime check for =
OpenGL.
>>=20
>> Fixes: 52053b7e0a0e ("ui/sdl2: Implement dpy dmabuf functions")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3347
>> Signed-off-by: Anthony Roberts <anthony.roberts@linaro.org>
>=20
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> --=20
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>=20

Hello,

As a related note, modern QEMU is built assuming EGL which Windows does
not ship as a system library - and doesn=E2=80=99t support a WGL-only =
configuration...

For those distributing QEMU binaries on Windows, they should bring an
EGL implementation along such as the one in mingw-w64-angleproject=20
or Mesa for Windows if they wish to support OpenGL functionality
instead of having crashes.

Wonder what=E2=80=99s the best place to document that requirement=E2=80=A6=



