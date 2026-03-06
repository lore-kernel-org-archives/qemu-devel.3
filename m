Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE83FCB61E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyY0z-0003bQ-Ek; Fri, 06 Mar 2026 11:27:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyY0x-0003b9-MB
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:26:59 -0500
Received: from p-west2-cluster1-host4-snip4-10.eps.apple.com ([57.103.68.83]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyY0v-0001Yz-JN
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:26:59 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-5 (Postfix) with ESMTPS id
 B89A1180029D; Fri,  6 Mar 2026 16:26:54 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772814416; x=1775406416;
 bh=jDKiyyxqIXN5/prXrwqj18NmOIHioqVOmDlEAHoJ90w=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Ev2Iiuo1QEjdp39EQNOTDQ0gQTXEg1E9fF7pg2KgOfSHdeiCWtZeP4B8mZSnJ1yoSjtDnoRCaxjc6NwcrH6iUIJLjK4choSJ2fUKTQqzQjYGzbBraDTpxo3RmvFXUDbz9eg/tLuzUMVkuk95T2ppfzRQ2/L83r7dgrrWRiKZlIXbpYZli0vUz/utULiKwSaNgzSMHUa78NGg1d13sydN0a5tiynCdQgiuaf2sc5IkW0TW8PNUk19fFLQXDL7NqwvY3Pn3iuU/NiKUR22LaAWIBCuQcJKU9gLTlEqfO7wcNj9yTLn2W+FqRyDSQVIVUJ5mGuklUn538GPJp7DhzQp8A==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-5 (Postfix) with ESMTPSA id
 9CFEF1800258; Fri,  6 Mar 2026 16:26:52 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v15 00/17] HVF: Add support for platform vGIC and nested
 virtualisation
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <1A192D09-EFA1-4515-A655-6BEB19CDDAA5@unpredictable.fr>
Date: Fri, 6 Mar 2026 17:26:40 +0100
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Alexander Graf <agraf@csgraf.de>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <79D8264F-1954-4626-9EBE-4577388D951E@unpredictable.fr>
References: <20260306130107.35359-1-mohamed@unpredictable.fr>
 <CAFEAcA-e4GZB_TRG7Jm3O-RNJneUtk_WufiXNn6=UDHsgG4kdw@mail.gmail.com>
 <CAFEAcA8gB-36c1TvJSwJ0MkVMy5z_dqKpVY7KTJ-cMV5rAX1_w@mail.gmail.com>
 <83E62271-E3F8-432E-8499-D1D8D065B162@unpredictable.fr>
 <CAFEAcA-uxtCoawErLdM0HVuy_h-uxxcmFjJsZf1rTgNiov-JWw@mail.gmail.com>
 <1A192D09-EFA1-4515-A655-6BEB19CDDAA5@unpredictable.fr>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE1NSBTYWx0ZWRfX1A8fClMdzZJO
 Q/nc1pER0F8l/QG6JOhCvN4LN1JW1CR06rh3rizBy53IUWYGhOxB0OqHvFc0gIBn3lveTp/vxsX
 +qZ9C0k9mdAXDyRabFQXeHy8IuQF7P/y/X8yPcbQ2G2/ZygkzMizV5A4wFDeVWyr78OAsGi8i4O
 CM6yzmmQz/pOdvTwu04fF4ovdsWYd8cjQvE3Xu6FprJ/jdEkvguxOPijLmk+0f3dumgCpwrlLiO
 CX6+AEhrOLgWS+WkImFxvxqJszq4G/klRtzte0/mBN1ADcpQU2ARVRzkLaavBktd6uQrzx74067
 0OnmPmhPLoo6wtQXEuR6WlU/kFq1nzp/1c55DSpn1CQJ1OqXcaAk4411NwzPSA=
X-Proofpoint-GUID: PudYvlaGxOD5SMP8ZnYqeD4IQ1SInc5z
X-Authority-Info-Out: v=2.4 cv=Q6ffIo2a c=1 sm=1 tr=0 ts=69ab004f
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8
 a=bU-1vNr_xgfpa6VbDIQA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: PudYvlaGxOD5SMP8ZnYqeD4IQ1SInc5z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 clxscore=1030 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060155
X-JNJ: AAAAAAABoZ9jUAfvgGV2bDwyMcXZApxfAYqlqdLq8YVV2RMU/KZVf4ltGLCcSiaW4I1AzL4W/cs51hXCsKtcWeN/tBJYIWaSIMH2211K9z6UL0yVoYIvTHJQdCKulPcYHVoWQ+/LpsmK7lWhCiEhnEoSzLYWFW+o5jfKHf++/EgNQR585cytDc9OneUpnDaf07ZrH45tcPlV2bLnf4TkjGY5h4GZEMC1qMBzGLGAA8FC1T/0UQHE9wyAoEQdDd1HuH7TSdITaeBZs1RkC+ZqX6J9nM8HuvP/SeOHn9jKO/0yx0U2WvT0ZQaT9qesyXSIaukOmmEr58l3CRkphynXfe3S4Ua3ZUS188hlcY4WTh9K7xNd3hUnT0mO/+3YyyRapTlAkpLW+ATOdGrO9l0MlonjYOPQRZMEa97pxBN2LDof7WnPRhLNk90IMH/YvUZbZHBsTzIN18lJUuINsT2i4ZLBziEOvZ2kIPPhOnaJkxfHbVuWjGkJo+es2ExTKd4ufeZHPnO/8Oxhyix5WqJj/ZrDq8G6gNdllbo51wpB5eaONOTF5tS4NKdUUrshADV0eBmpgHrD5EPaYwmn7U2j0hfNojCjxnmDxgc1sxAlksZXgKWvP7AUbEZWK15RtkNBATAAh9WCIFdQAQdu2ga3TcVIfCniF/vvfBYwLFR1e16pzfxGQ6t/8OFi7z0KAHIOcmgTP+QbfaIjM4VXX8mtO5I5uLcKn22QgEWysRT0cj5BJKDdcrgwimjYdsBNEHsu3Fc=
Received-SPF: pass client-ip=57.103.68.83;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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



> On 6. Mar 2026, at 16:58, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
>=20
>=20
>> On 6. Mar 2026, at 16:56, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>>=20
>> On Fri, 6 Mar 2026 at 15:53, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>>=20
>>>=20
>>>=20
>>> On 6. Mar 2026, at 16:44, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>>>=20
>>> On Fri, 6 Mar 2026 at 14:58, Peter Maydell =
<peter.maydell@linaro.org> wrote:
>>>=20
>>>=20
>>> On Fri, 6 Mar 2026 at 13:01, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>>=20
>>>=20
>>> Link to branch: https://github.com/mediouni-m/qemu =
hvf-irqchip-and-nested
>>> (tag for this submission: hvf-irqchip-and-nested-v15)
>>>=20
>>> This series adds supports for nested virtualisation when using HVF =
on arm64 Macs.
>>>=20
>>> Reviews would be very welcome :-) It's maybe a bit unlikely that =
this will make
>>> it to QEMU 11.0 I might as well try.
>>>=20
>>> The first two patches are from the SME enablement series and are =
present for the
>>> series to be buildable on its own.
>>>=20
>>>=20
>>>=20
>>>=20
>>> Applied to target-arm.next, thanks.
>>>=20
>>>=20
>>> I'm afraid this failed to build in our gitlab CI job for macos:
>>>=20
>>> https://gitlab.com/qemu-project/qemu/-/jobs/13388426185
>>>=20
>>> In file included from ../target/arm/hvf/hvf.c:489:
>>> ../target/arm/hvf/sysreg.c.inc:174:21: error: =
'HV_SYS_REG_CNTHCTL_EL2'
>>> is only available on macOS 15.0 or newer
>>> [-Werror,-Wunguarded-availability-new]
>>> 174 | DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHCTL_EL2, 3, 4, 14, 1, 0)
>>> | ^
>>> =
/Applications/Xcode_16.1.app/Contents/Developer/Platforms/MacOSX.platform/=
Developer/SDKs/MacOSX.sdk/System/Library/Frameworks/Hypervisor.framework/H=
eaders/hv_vcpu_types.h:312:5:
>>> note: 'HV_SYS_REG_CNTHCTL_EL2' has been marked as being introduced =
in
>>> macOS 15.0 here, but the deployment target is macOS 14.0.0
>>> 312 | HV_SYS_REG_CNTHCTL_EL2 API_AVAILABLE(macos(15.0))
>>> API_UNAVAILABLE(ios, tvos) =3D 0xe708,
>>> | ^
>>>=20
>>> and similarly for other registers.
>>>=20
>>> I'm going to drop the last 4 patches from the series, which I hope =
will
>>> fix the CI problems.
>>>=20
>>> =E2=80=94 PMM
>>>=20
>>> Hello,
>>>=20
>>> Will submit a new rev of the last 4 patches with a workaround for =
this then=E2=80=A6
>>>=20
>>> (Ugh @ compiler pragmas but there aren=E2=80=99t better choices =
unfortunately)
>>=20
>> Unfortunately the problems aren't in just the nested-virt part:
>>=20
>> https://gitlab.com/qemu-project/qemu/-/jobs/13389185563
>>=20
>> still complains, including about hv_gic_config_create().
>>=20
>> I'm going to drop everything except the first 2 patches.
>>=20
>> thanks
>=20
> Ok, will try to see if I can repro the CI config. My apologies.
>=20
> (It all builds locally :( )

Hello,

For future reference what it takes to reproduce this locally is:
export MACOSX_DEPLOYMENT_TARGET=3D14.0

That showed a bunch of spurious warnings though:

/Users/sunrise/workspaces/qemu/include/qemu/cutils.h:144:12: warning: =
'strchrnul' is only available on macOS 15.4 or newer =
[-Wunguarded-availability-new]
  144 |     return strchrnul(s, c);
      |            ^~~~~~~~~
=
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Devel=
oper/SDKs/MacOSX.sdk/usr/include/_string.h:198:9: note: 'strchrnul' has =
been marked as being introduced in macOS 15.4 here, but the deployment =
target is macOS 14.0.0
  198 |         strchrnul(const char *__s, int __c);
      |         ^
/Users/sunrise/workspaces/qemu/include/qemu/cutils.h:144:12: note: =
enclose 'strchrnul' in a __builtin_available check to silence this =
warning
  144 |     return strchrnul(s, c);

Sent over a new rev with guarding squashed in as needed (for the vGIC =
code, availability skipped because it=E2=80=99s=E2=80=A6 whether the GIC =
is available or not is checked in target/arm/hvf/hvf.c, and for =
target/arm/hvf/hvf.c, checking across the board except for EL2/vGIC =
register availability which are handled via a separate mechanism)

Sorry for this :/ should have anticipated it better

>> -- PMM
>>=20
>=20
>=20


