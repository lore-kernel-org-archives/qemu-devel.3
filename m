Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7CA108B8E6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 09:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3WV4-00026d-En; Fri, 20 Mar 2026 05:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w3WV2-00025t-A0
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:50:36 -0400
Received: from p-east2-cluster4-host9-snip4-10.eps.apple.com ([57.103.78.221]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w3WV0-0004wK-0R
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:50:35 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPS id
 7F87818000BE; Fri, 20 Mar 2026 09:50:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774000231; x=1776592231;
 bh=6JHx9mTtuFQjRuYkqnRbXnW8jM/mFHKaQp7UkNbxU4k=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=gi5sBiwRMIadV+6I/j+rnP9mcoHktsnBrXOajs9Sqsfe1jpvYgef0dQPrANZEwZOkoNcSDYKoMfs9mVMGIcZWCY2ZFYszZUOuyRMm1UiUZjCUM9W/CIEArYnZWM7YKL9rhdeUeNhCvFKs1MCMpj4n7oXFTRYuVpz8RhEUCMwK3IAqw6v8OQLcrqM9fh1BZbvksEsnLZj8hFBiOaOC/IaT+Mfsh6zzKP8eD87ad3xBRnBGLfpotInu+voGs+yu+FZcx0BYjR0ul4CV3QV9R8FY+nJpXVP6hJGKbVeYI6sUShXSskyeH77wVdj9g/VGUPGY9RgtbNzYykJNqPoVdvbIg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPSA id
 D7847180015C; Fri, 20 Mar 2026 09:50:26 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v3 3/6] whpx: arm: enable more enlightements
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA_wVD+mMFhwzDyHx1pY_aMtBvdHjZqQoFoniM_JUCcceA@mail.gmail.com>
Date: Fri, 20 Mar 2026 10:50:14 +0100
Cc: qemu-devel@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8B799F60-05AD-49F3-8BAC-4D36EBA8E196@unpredictable.fr>
References: <20260314221529.47841-1-mohamed@unpredictable.fr>
 <20260314221529.47841-4-mohamed@unpredictable.fr>
 <CAFEAcA8v59wSwRvig6NRjWHyvBGY=gPhWFN1B_jD9k+aXqo9Ng@mail.gmail.com>
 <4387E53A-E140-48E9-80C3-721F9C0B9A9D@unpredictable.fr>
 <CAFEAcA_wVD+mMFhwzDyHx1pY_aMtBvdHjZqQoFoniM_JUCcceA@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-GUID: irwTAuhgFlC3q4FTS0N8saUS0GEJGzjb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDA3NSBTYWx0ZWRfX9BPa9tuPpuj4
 ZhopOvlv+TeiFwf+kaTDUGqAYhJobWSe5uqkGERxKlS0XZcCi7ZRz2/BafL7KZWIP9v8Mb5jxAE
 9uhpD6i9+oyUwCmw/qDB+AHNoa0++jfYZkvMI1iyNTao1WMQ4odPDNRu2aHCh6AENMk7SBbJaEl
 vGCEZAlDY1yeZSd3BXKWQd9LnwRHLai3VvR+bxLV2R6XdPNh3PvwWt2WXBwZY3NamileLmaIIDy
 YWW6FBXesWDedvMg1IIC9VHdWVlaSETEnIOcQIfp+ZWTBh2Hf5/GI4IEnW+mWPQcmITZ9K966zd
 D8wC1Y44kpuxnJ7b9u+aHQkvbcqt/Q5pZwAkuxPh7Wv81dkyJbuPMwY07LKoDA=
X-Proofpoint-ORIG-GUID: irwTAuhgFlC3q4FTS0N8saUS0GEJGzjb
X-Authority-Info-Out: v=2.4 cv=NIrYOk6g c=1 sm=1 tr=0 ts=69bd1865
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=W0AeO356w_Fv_2sdRokA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=802 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1030 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603200075
Received-SPF: pass client-ip=57.103.78.221;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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


> On 20. Mar 2026, at 10:17, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Thu, 19 Mar 2026 at 18:50, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>=20
>>=20
>>> On 19. Mar 2026, at 19:13, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>>>=20
>>> On Sat, 14 Mar 2026 at 22:15, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>>>=20
>>>> Linux uses AccessVpRegs without checking availability and panics if =
it's not there. Expose it unconditionally.
>>>=20
>>> The commit message subject says we're enabling enlightenments...
>>>=20
>>>> @@ -953,13 +953,15 @@ int whpx_accel_init(AccelState *as, =
MachineState *ms)
>>>>    synthetic_features.Bank0.AccessPartitionReferenceTsc =3D 1;
>>>>    synthetic_features.Bank0.AccessHypercallRegs =3D 1;
>>>>    synthetic_features.Bank0.AccessVpIndex =3D 1;
>>>> -    synthetic_features.Bank0.AccessHypercallRegs =3D 1;
>>>=20
>>> ...but the code change seems to be removing one as well as
>>> adding the three new ones. Intentional?
>> Hello,
>>=20
>> The AccessHypercallRegs bit was set twice - with the first one being =
two
>> lines earlier - removed a spurious one of the two.
>=20
> Ah, right. How about this for a commit message ?
>=20
>=20
>    whpx: arm: enable more enlightenments
>=20
>    Unconditionally enable some more enlightenments for whpx. In
>    particular, linux uses AccessVpRegs without checking availability =
and
>    panics if it's not there, so it's important to expose it.
>=20
>    We also had a duplicate line where we set AccessHypercallRegs =3D 1
>    twice; remove the duplicate.
>=20
>=20
> If you have more rationale/info about the other two we're enabling,
> that would also be nice to include.
>=20
> thanks
> -- PMM

Hello,


```
whpx: arm: enable more enlightenments

Enable some more enlightenments for whpx for -accel whpx,hyperv=3Don.
In particular, Linux uses AccessVpRegs without checking availability =
when
Hyper-V enlightenments are exposed and panics if it's not there.

We also had a duplicate line where we set AccessHypercallRegs =3D 1
twice; remove the duplicate.

Microsoft=E2=80=99s VMM exposes SyncContext on arm64 and =
FastHypercallOutput=20
regardless of architecture unconditionally, so add those two to match=20
that configuration.

```

On arm64, Hyper-V enlightenments with QEMU whpx aren=E2=80=99t on by =
default
and are a more research-y configuration - as the case when it was needed
to have a properly-behaved VM on Snapdragon X laptops has been worked =
around=20
in Hyper-V.

Snapdragon X has broken CNTVOFF_EL2 with an interrupt flood when=20
HCR_EL2.E2H =3D 1 + CNTVOFF_EL2 !=3D 0 and Hyper-V synthetic timers were=20=

used on arm64 to sidestep that. Nowadays, Hyper-V has a workaround=20
so that the virtual timer can be used instead of needing to resort
to using those.

Thanks,
-Mohamed



