Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD918F3C260
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaiy-0006h5-Mo; Mon, 09 Mar 2026 09:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vzaiu-0006gA-Eu
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:32:40 -0400
Received: from qs-2002h-snip4-3.eps.apple.com ([57.103.87.204]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vzair-0003WZ-0F
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:32:39 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-13 (Postfix) with ESMTPS id
 D301B18000B8; Mon,  9 Mar 2026 13:32:30 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773063154; x=1775655154;
 bh=2f3mZngrlCjrpD345GYh9MZyPEcNHLPv7h0q0hJWUgA=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=eU50/tVmfuQ9aWXqhmK2XC17JKPHAZ4RN+qp88KQ5xxF3fMkUTS29XL7G4fb1+z2VOwkFes18P/cRG07HeC6yI4iRyuDvRi14SAkFIud4iKWTcE8rEAYheNqsNvkwjLVcUoD7Yj4LCQsKEg5bcRK5lrbm+hxjEkApyCUj2r9ixqI6vfzPKAfAd9bhJXBBka+OF0Gw3vToXEmQkTNumtMeZgKHNaRy0NdCfDBe4xPq8/6x6RgSY2MjssD5iariGy/5VMhP3vpplwP4zZP/APkNc3t3Ks684USs5jZDbhcQl2n3T4eFllJuzuXoOmvazamiG/1XamZ4VP/Zepq3ktATA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-13 (Postfix) with ESMTPSA id
 9D6641800238; Mon,  9 Mar 2026 13:32:28 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v19 00/13] HVF: Add support for platform vGIC and nested
 virtualisation
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA9TSQEVEVeQc4rPtz4HEJJbZUs9LaeVbz-y3=tB9zv4EA@mail.gmail.com>
Date: Mon, 9 Mar 2026 14:32:16 +0100
Cc: qemu-devel@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 qemu-arm@nongnu.org,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7C4D7803-46A3-430C-A66E-5C3B63E92E0D@unpredictable.fr>
References: <20260307180330.75168-1-mohamed@unpredictable.fr>
 <CAFEAcA9TSQEVEVeQc4rPtz4HEJJbZUs9LaeVbz-y3=tB9zv4EA@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Authority-Info-Out: v=2.4 cv=VsEuwu2n c=1 sm=1 tr=0 ts=69aecbf0
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8
 a=T-yAbbo14RZL4WwGmcsA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEyMyBTYWx0ZWRfX9Zf48JICSGk2
 E6h95N8aCH3FlHvT1bQJIw7SEhfYOvH/l0N+BecuNEcAb1zc4tLJX56Xg1KOuIAkFyZ6hF2zkkL
 rRHJlLBnwkcu5x/aSqLUwCli1ECpKlZCqLpa68FA5YHlwb0uIYc/jiV3V8vcsFAo0Z0ZTesjW+H
 SmGOANQSJTLQTUWppMUAHIU274JzBiFchWgoAHqeXKVcDs0S7Vs6+LwIvRH6fJ+SQcrmpxgQL48
 rwneSw7yaMAOC6T5zlbg+ry2YfKiTqYRKXPQSPcgLqtHPglgWj9Fmr1yKuaazVdQcoeo0V1vpNH
 bw57LYkXtRZskCoAxzXM6nf4BcHawGC4o68MKE7EcwJL+xgefUNP4TYZB0PFP8=
X-Proofpoint-GUID: pTi7OCFACnpoqce0Gh5Nv9P-3qRz_9jJ
X-Proofpoint-ORIG-GUID: pTi7OCFACnpoqce0Gh5Nv9P-3qRz_9jJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 clxscore=1030 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 mlxlogscore=950 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2603090123
X-JNJ: AAAAAAABdgORzdNmNixU7HKlEg7cwd51kBjNXavDolUa9UjceZaM6kZ8InfsBOrUtTnEXwCdO8MXyz8usz3nChJauvZ7NQXNB/TaklkjB9xbKZstbGVXCYWLrDeeYdx1e907BxZ4uza+o6yesrj7jbq9Sn7xgtdsPQYbPf2efFN6hU5zrwmKTmjWsmpDvmJzAWA+MJXirkWYa1mhShZpK3TazSqdceR/tAAS1ZAg9w3X1EXcoGFbrvkJA9AqTYG1oeHCrlA3BYnrHxNM6y7cEEczYkZhdlaVvaM+LXSuiaUo5SbzHCtTI5EMhE7M5z5m0vse/5fWa1Xb3F3FheBxUpSxPuYWhbQwa00XlljynDrkGau+1WKXQoBRerePMH7qAeigLboq0PfSQ6AAPyLQVzgBXapkHeSCcpf6OfZkwOj0pj4cGMrXO1mK6zXeaju+O3JdyL2FKC3wps7wAAYu8tXZGHs9nwiZhTjGHlE08apYqHsFFcXd9/htpGtiMHoNVuXmInUnATsknYrQ+rNMvAxH9CsvB5t8Vap+AhZvjjjxPOk98A9fv9lUv7c43whcFeMYGzy66WLNsFz681t+aYhL6iEBMvSiJ8PRxUBk8tsPnQLdmXgExKQzthBwRE7jejVt+GWqjBhI6wkdTaaCc1/Tcw5sBjWZ2AeYpX+2UaHfVv2ZCal3n5IgFho3ayzAooL2tiMagtRxDPDdoSCHyUaA/ANZd8Ywm7I9LY/92ONAn0BB8P680NBNUafFcCJ5
Received-SPF: pass client-ip=57.103.87.204;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



> On 9. Mar 2026, at 14:20, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Sat, 7 Mar 2026 at 18:03, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>=20
>> Link to branch: https://github.com/mediouni-m/qemu =
hvf-irqchip-and-nested
>> (tag for this submission: hvf-irqchip-and-nested-v19)
>>=20
>> This series adds support for nested virtualisation when using HVF on =
arm64 Macs.
>>=20
>> The first two patches are from the SME enablement series and are =
present for the
>> series to be buildable on its own.
>>=20
>> It has two parts:
>> - Apple vGICv3 support and necessary infrastructure changes for it
>> - Nested virtualisation support. Note that the nested virtualisation =
implementation
>> shipping as of macOS 26.3 is nVHE only (but it _does_ use VNCR as =
shipped).
>>=20
>> This series doesn't contain EL2 physical timer emulation, which is
>> needed if not leveraging the Apple vGIC. As such, nested virt =
requires kernel-irqchip=3Don.
>=20
> Hi; I think at this point this series has unfortunately missed the
> softfreeze deadline for 11.0, and we should be aiming to get it in
> for early in the 11.1 cycle. I will keep it on my list to apply then.
>=20
Hello,

That=E2=80=99s quite unfortunate :/ Too close to the softfreeze tomorrow =
I guess?

Thank you though, think we got quite close to it with even an attempt of =
a pull before
last-minute issues resulted in it not getting quite there. Hopefully =
future series will go more smoothly
than my first ones :)

Thank you,
-Mohamed

> thanks
> -- PMM


