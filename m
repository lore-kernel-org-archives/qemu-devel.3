Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69692FCB61C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXaD-0006be-GD; Fri, 06 Mar 2026 10:59:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXaB-0006aw-S0
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:59:19 -0500
Received: from qs-2006k-snip4-5.eps.apple.com ([57.103.85.236]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXaA-0003kJ-Ac
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:59:19 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-0 (Postfix) with ESMTPS id
 29FDF18005EE; Fri,  6 Mar 2026 15:59:12 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772812757; x=1775404757;
 bh=Fyz3ryItcZ4ADCR/SPWQ/ANtkjCHPk8yyqKMtjBpHtY=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=JXkIeyNXe5vhml+vS76R10uIbRhDx28nIYY49hj3OzK/rvfr1680DznZ3fAzhezxTM2060TNrswZUWT9mt+ihKkSrEUoZtVSexSU88A4LCA215HCsbZM1os4yO+oHPQJvyjbLIHP+DMTMrT+s7GUUq4KVYr67W0KgmxySm0CrNiOfpg+qMkSRqwio3aS8lZPq2k6MDC+hKwXd46E560Z5ESmLofqSKaEdz4fRqXXzG0gLqrXsj6qW/lvaUcKu6NwM1lY3MOh5ZbLLa3dh56HqcGYzd3mYD1rUnF9c7idJJUTgqSM1Y97Q3QH9I6G+5QI+z/4LBUdg2FGLDEL/Hlwvw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-0 (Postfix) with ESMTPSA id
 414A418005CB; Fri,  6 Mar 2026 15:59:11 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v15 00/17] HVF: Add support for platform vGIC and nested
 virtualisation
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA-uxtCoawErLdM0HVuy_h-uxxcmFjJsZf1rTgNiov-JWw@mail.gmail.com>
Date: Fri, 6 Mar 2026 16:58:59 +0100
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Alexander Graf <agraf@csgraf.de>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1A192D09-EFA1-4515-A655-6BEB19CDDAA5@unpredictable.fr>
References: <20260306130107.35359-1-mohamed@unpredictable.fr>
 <CAFEAcA-e4GZB_TRG7Jm3O-RNJneUtk_WufiXNn6=UDHsgG4kdw@mail.gmail.com>
 <CAFEAcA8gB-36c1TvJSwJ0MkVMy5z_dqKpVY7KTJ-cMV5rAX1_w@mail.gmail.com>
 <83E62271-E3F8-432E-8499-D1D8D065B162@unpredictable.fr>
 <CAFEAcA-uxtCoawErLdM0HVuy_h-uxxcmFjJsZf1rTgNiov-JWw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-GUID: 6SpC4uRrGeGqtaKK9vxoXuhFfbFWnr8c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE1MSBTYWx0ZWRfX/ec3wGFN/XZI
 pcDJMtEuHKWHxqPKWuy4p5MTXXd9L+WnoYXDtbpzkzsSXjf5wYlbTmEe2RRpxCAKn8qxEelbASx
 w30IsV5hdhrPVkvxy202lZFCcYRJCqyFLs0KU4JmsLO+FmsPJenWn7XkMvqMW1zCHVLGvpV8YF1
 QqBdPxe71pGF30IWtRflBntWB/HDVojxXGbYvplmJSGcXJfts/vQlQFtARjRqZRl+moZvT2R7yH
 Z/noOFDlvT/Hbwq69zyIFDjSpuYg6wLCryEoPW1zNDFAqZIUK94ZFpWSA5o1zJ5dvg445c8ZodG
 NT/V2/WX7T8FYWOCiH2K2ZCWlCqT1A2VDjyz9O08NrAtTWINANEUJaZOuZpfTg=
X-Authority-Info-Out: v=2.4 cv=M6VA6iws c=1 sm=1 tr=0 ts=69aaf9d3
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8
 a=EF2e-7aIslusM--uXj8A:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 6SpC4uRrGeGqtaKK9vxoXuhFfbFWnr8c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 clxscore=1030
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060151
X-JNJ: AAAAAAABh4+URV80+9+iqiwoY6x5jr1ACa2Tfe+JP8bfpjzN1E2s8RiJvbJxJND2xTF0CS4A0H7GL8Zq2lfBKIA3AnYBxlNCa1BAeZ+mL3yUV5Ak0i59PmK2KUAzUuS7YtXHrv5rxt58rt3cSg68DlUNUnJb6SJrnvHFWAb+igHFylcj7rVu02dFeREvQboXvEKXyCDbABNhjoMPuVu2j9u7VKuxd0VE46uJbmM2myK5IdJ21v8mniWTn2R4SKybpEz52Eg+0hEhTdBL9N4nNJ5JsObYbAIChpVgZZ/njvwppEJc1x17ft2kTaN1Htp/bKJeRSaRHnzufp+xv2gMSQuS6aXgGMAEx74lGI2+xT5pJycPk8HWb5R0UgOsYLj6oQ52w7V6AyavoTbXi835G/xjqA7G5AMeesQHZujp1BLSozbcxOI65LJ4Up9+9RSYBDgqzNuMcVN6cU6bQ/TZmT8CRIPLQgslgSU7nD5kmBQxJGGF1TnzxP8PnV7WEfLaMSH/ujSU4GcE1W6nkT6Z+jzZflrMLInhTp8NtjoqR6WHBwdB2SD9/bU1jYkKuVDWxiR2IlP1no6zoAhuJnzXfj6QXkoGh+o4vDOf7AqYEAJ9Qx6UBSLp9qm6PanJbTGHaSMDQNTmpSc1QbkCV/YMQJORgowG6oM227gyQJPLFfiz1RFlEpScx7vatY1PukNKkr0UW/qxiQC11JvGvAavDbsVmTJTkYMAqfHj+IhHr47j6yCArcilMz43Q98MWuY4WaH3cFcN
Received-SPF: pass client-ip=57.103.85.236;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 6. Mar 2026, at 16:56, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Fri, 6 Mar 2026 at 15:53, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>=20
>>=20
>>=20
>> On 6. Mar 2026, at 16:44, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>>=20
>> On Fri, 6 Mar 2026 at 14:58, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>>=20
>>=20
>> On Fri, 6 Mar 2026 at 13:01, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>=20
>>=20
>> Link to branch: https://github.com/mediouni-m/qemu =
hvf-irqchip-and-nested
>> (tag for this submission: hvf-irqchip-and-nested-v15)
>>=20
>> This series adds supports for nested virtualisation when using HVF on =
arm64 Macs.
>>=20
>> Reviews would be very welcome :-) It's maybe a bit unlikely that this =
will make
>> it to QEMU 11.0 I might as well try.
>>=20
>> The first two patches are from the SME enablement series and are =
present for the
>> series to be buildable on its own.
>>=20
>>=20
>>=20
>>=20
>> Applied to target-arm.next, thanks.
>>=20
>>=20
>> I'm afraid this failed to build in our gitlab CI job for macos:
>>=20
>> https://gitlab.com/qemu-project/qemu/-/jobs/13388426185
>>=20
>> In file included from ../target/arm/hvf/hvf.c:489:
>> ../target/arm/hvf/sysreg.c.inc:174:21: error: =
'HV_SYS_REG_CNTHCTL_EL2'
>> is only available on macOS 15.0 or newer
>> [-Werror,-Wunguarded-availability-new]
>> 174 | DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHCTL_EL2, 3, 4, 14, 1, 0)
>> | ^
>> =
/Applications/Xcode_16.1.app/Contents/Developer/Platforms/MacOSX.platform/=
Developer/SDKs/MacOSX.sdk/System/Library/Frameworks/Hypervisor.framework/H=
eaders/hv_vcpu_types.h:312:5:
>> note: 'HV_SYS_REG_CNTHCTL_EL2' has been marked as being introduced in
>> macOS 15.0 here, but the deployment target is macOS 14.0.0
>> 312 | HV_SYS_REG_CNTHCTL_EL2 API_AVAILABLE(macos(15.0))
>> API_UNAVAILABLE(ios, tvos) =3D 0xe708,
>> | ^
>>=20
>> and similarly for other registers.
>>=20
>> I'm going to drop the last 4 patches from the series, which I hope =
will
>> fix the CI problems.
>>=20
>> =E2=80=94 PMM
>>=20
>> Hello,
>>=20
>> Will submit a new rev of the last 4 patches with a workaround for =
this then=E2=80=A6
>>=20
>> (Ugh @ compiler pragmas but there aren=E2=80=99t better choices =
unfortunately)
>=20
> Unfortunately the problems aren't in just the nested-virt part:
>=20
> https://gitlab.com/qemu-project/qemu/-/jobs/13389185563
>=20
> still complains, including about hv_gic_config_create().
>=20
> I'm going to drop everything except the first 2 patches.
>=20
> thanks

Ok, will try to see if I can repro the CI config. My apologies.

(It all builds locally :( )
> -- PMM
>=20


