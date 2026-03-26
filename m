Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D996110A88F5
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 17:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5ooG-0006dW-6R; Thu, 26 Mar 2026 13:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5ooE-0006dB-Aj
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 13:47:54 -0400
Received: from p-east2-cluster6-host11-snip4-8.eps.apple.com ([57.103.76.239]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5ooA-000270-T6
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 13:47:54 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-8 (Postfix) with ESMTPS id
 9EEE41800186; Thu, 26 Mar 2026 17:47:46 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774547268; x=1777139268;
 bh=e60CpPIliaWzKe5yxQEgwKgNuj+3sq00Dc16uZr/nT8=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=K2zAkgI+vpWSxpcuaIoaKo62zBVKIKJS/uFAibUXWN1/AtiJjl+LoHQ18PvPePMwyzdtnLDKEkd1Iy2s4s9CoCdKuGb7ZVPeElzK8R2RXtWw6ZQMGXyU6LrIWgK9CHpGDBMGLi/S1bgoMwR/i1DhUmmwz1hBlJV+jL/1CxVSSqnpPl2J65P/NxIOiebY9Fvwn8ya+XZkL3J+6V/1AC9whetbs1yIHg0m+r72ja5/i04TJA3iPmxp99kh1yomRq0kzDq9AQ95eyOCgOZhEiaVrPwzxwUHuJxR4w25iediP8UprQo2os4/7DbdecJaVze6ET5OQmCNJsj0lxNWZfTscQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-8 (Postfix) with ESMTPSA id
 B2B3718000BA; Thu, 26 Mar 2026 17:47:44 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH 0/7] Misc changes to allow building with Windows Clang
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <81ba1e13-5dca-488f-bfd9-19927ed9dbc7@linaro.org>
Date: Thu, 26 Mar 2026 18:47:32 +0100
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?Q?=22Daniel_P_=2E_Berrang=C3=A9=22?= <berrange@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EBE1ED22-9B34-4A3D-B39F-FD1BF9658909@unpredictable.fr>
References: <20260326160033.68318-1-kkostiuk@redhat.com>
 <E4E91C9F-222E-41CA-B51A-928480FDC405@unpredictable.fr>
 <CAPMcbCoPfE+c1851esnnWRgxFcgm1CRr9CGtOmBNWphX5kt1tA@mail.gmail.com>
 <09297e78-b1bd-4281-919d-99de0a5a33ab@linaro.org>
 <CAPMcbCrwv-Q=iP04iYHi5QTfE9RjWjJwEnLmH-9W2vghfOHEpw@mail.gmail.com>
 <1760bba7-04e6-441c-aec2-96bf722c93c1@linaro.org>
 <81ba1e13-5dca-488f-bfd9-19927ed9dbc7@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=SeD6t/Ru c=1 sm=1 tr=0 ts=69c57143
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=MrylxDkSAAAA:8
 a=NEAV23lmAAAA:8 a=EvwygJQkC33RWRpwR-IA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=ZWqyT8odc8aVHPXL_V4W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEyNyBTYWx0ZWRfX0G2Y7+TEm1o/
 23r2EU7CAO+7CEpnWKOu7nqpsp6JwIShEB0oInaIBYEmO2cdvPcVttJDVEQ5r2wnY0Nt1J+d2qa
 wMeeLFP6tsxPkpwIAOGUTJEoLl90TvCUwOOQuaKskccrJasPPjETQah6COS4wK6q3PMwhnnK0Py
 a4t86xDpysKqHm501gK5c5t6qoCyvBZ7aKAKc4WaBjZpCU+8C706fBtkHp+6yc8j/w7KVBxlFh9
 k8FL3Aq+ARWpF+vSkD6z5nB6eSgsfyh+H/Eqhf5XRBzruNBEHZgE5IhDsRJohMbCS6Ds1lgWP7W
 R+J7OlrPgwiXUES+tC731eQnF7LvKOhMXaWlRkh4Svhml4uRCJbHQKziee8r6w=
X-Proofpoint-ORIG-GUID: OhlwjpI4oV2nxiRYQqYOrS_jQgF88EP3
X-Proofpoint-GUID: OhlwjpI4oV2nxiRYQqYOrS_jQgF88EP3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=660 clxscore=1030 mlxscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603260127
Received-SPF: pass client-ip=57.103.76.239;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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



> On 26. Mar 2026, at 18:44, Pierrick Bouvier =
<pierrick.bouvier@linaro.org> wrote:
>=20
> On 3/26/26 10:38 AM, Pierrick Bouvier wrote:
>> On 3/26/26 10:11 AM, Kostiantyn Kostiuk wrote:
>>>=20
>>>=20
>>> On Thu, Mar 26, 2026 at 6:48=E2=80=AFPM Pierrick Bouvier
>>> <pierrick.bouvier@linaro.org <mailto:pierrick.bouvier@linaro.org>> =
wrote:
>>>=20
>>>     On 3/26/26 9:43 AM, Kostiantyn Kostiuk wrote:
>>>      >
>>>      >
>>>      >
>>>      > On Thu, Mar 26, 2026 at 6:35=E2=80=AFPM Mohamed Mediouni
>>>      > <mohamed@unpredictable.fr <mailto:mohamed@unpredictable.fr>
>>>     <mailto:mohamed@unpredictable.fr =
<mailto:mohamed@unpredictable.fr>>>
>>>     wrote:
>>>      >
>>>      >
>>>      >      > On 26. Mar 2026, at 17:00, Kostiantyn Kostiuk
>>>      >     <kkostiuk@redhat.com <mailto:kkostiuk@redhat.com>
>>>     <mailto:kkostiuk@redhat.com <mailto:kkostiuk@redhat.com>>> =
wrote:
>>>      >      >
>>>      >      > This is the first set of changes to allow building =
qemu-ga
>>>     with
>>>      >     Microsoft Windows Clang.
>>>      >      > It includes some cleanups and fixes that also make the
>>>     code more
>>>      >     portable.
>>>      >      > The main goal is to be able to build qemu-ga with the =
MSVC
>>>     toolchain
>>>      >      > because MinGW-w64 is not available for ARM64 Windows.
>>>      >      >
>>>      >     Hello,
>>>      >
>>>      >     MinGW-w64 is available for arm64 Windows, although it=E2=80=
=99s more
>>>      >
>>>      >     mature with Clang as a compiler instead of of MSVC.
>>>      >
>>>      >
>>>      > I expect to use clang from the MSVC environment, not the MSVC
>>>     compiler
>>>      >
>>>=20
>>>     Is the difference that this clang does not come with mingw
>>>     preinstalled,
>>>     and thus require using msvc headers/libraries instead?
>>>=20
>>>=20
>>> Yes, the difference is that MSVC Clang comes with MSVC headers/
>>> libraries, not a Linux/MinGW one
>>>=20
>> I'm surprised you don't run into other issues than the one this =
series
>> fixes, that's great!
>>>=20
>>>     In all cases, it's just better to use msys2 environment. What is =
your
>>>     limitation with it?
>>>=20
>>>=20
>>> This requires additional maintenance of the MSYS2 environment.
>>> Also, MSYS2 is a rolling release distribution, while we definitely
>>> need to know the version of dependencies and control them.
>>>=20
>> The maintenance is quite low in my experience, but I understand the
>> concern with the rolling release aspect of it.
>> By curiosity, for dependencies in MSVC environment, do you use a =
package
>> manager (vcpkg, winget, other) or build them from source?
>>=20
>=20
> As a complement, you can use msys2 and install manually the versions =
you want for dependencies, and mirror them for reproducibility if you're =
concerned they disappear. I would not worry too much about following the =
toolchain and build tools from the rolling release, and you would just =
have to do it for libraries QEMU use.
>=20
> See for instance index of packages here:
> https://repo.msys2.org/mingw/clangarm64/
>=20
Hi,

There=E2=80=99s also this: https://github.com/mstorsjo/llvm-mingw for a =
full build from source.

My own setup is LLVM + MinGW built from source and then a hacked up a =
bit version
of MXE to build glib, gtk and others, but those aren=E2=80=99t needed =
for the guest agent





