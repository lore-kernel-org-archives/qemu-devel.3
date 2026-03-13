Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E761B105F79B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 11:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w10iS-0004nu-Vp; Fri, 13 Mar 2026 07:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w10iM-0004mj-D4
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 07:30:00 -0400
Received: from ci-2001i-snip4-2.eps.apple.com ([57.103.91.75]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w10iI-0002Oc-Dh
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 07:29:57 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-9 (Postfix) with ESMTPS id
 7B339180041C; Fri, 13 Mar 2026 11:29:46 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773401389; x=1775993389;
 bh=ubBncClybEhK6XBrfLpa4ABehyNbDapv8hfDeikOGVk=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=cROP/b/KJeM74c1zowmZ9kCDTQXXiQ7K8YWxQSFXcWhVKREIZ5amDcs7b1+0tjD9wMXHSRePdFg92CEftAQ/xgHvXVFq41Gi8XPCT07/YqINQlwbEjmHzsgzdREtUvSicLOPBcJ7TxaRIQzKFHcqIxo1tSVz3Wz3yU3fDoIsuQwwh8yGWFSScWCiwHjRWAsmQvnrs1rMyjWxjCT0/8vskJ9qzXELL0MmVf2kFGHLG9OTLULt4e6TgRH8dOzp4k07012KK2uA4RIWnYarXt3Ut/s5hwru9XKcs1r43vlqTIcVUQIOAJf/FUCixOLa3i3FSyXQpOT5un4liDcHXB5dIg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-9 (Postfix) with ESMTPSA id
 42116180040B; Fri, 13 Mar 2026 11:29:44 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 08/14] accel/mshv: Add access_vp_regs synthetic proc
 features
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260313-quaint-educational-swallow-aac6e3@anirudhrb>
Date: Fri, 13 Mar 2026 12:29:32 +0100
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <675BD854-D0C3-4942-B32D-2684078DC4D5@unpredictable.fr>
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
 <20260311-mshv_accel_arm64_supp-v1-8-c31699b7bc1f@anirudhrb.com>
 <199EF957-0EBD-4E14-8453-1C5FA5B14063@unpredictable.fr>
 <20260312-lucky-cocky-whippet-2a5f3d@anirudhrb>
 <AA5B0DE1-CA87-43F6-9A52-2F9F91F3514D@unpredictable.fr>
 <20260313-quaint-educational-swallow-aac6e3@anirudhrb>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5MCBTYWx0ZWRfXy7+E6qQQ4C3C
 RGNqcaOD7rOE5R1e7YCfA29CApCBnDuAdq0zrrP/5M8SyJnFP8I69PDTh9hpVCThdNFDSURDsSn
 dqDksp739CPFsZwwE0z4ixbegLJlHA2Mw1FasorO2o1X1lyhw3ZEgXcsS2pFC5nrHcxIysS8WrM
 Ny9/ypO9KlS4cKSv80jszbsh/gB6fbB7gDjbl4YaBmkxk2O/QOkPBotCqq7kLn/Hdc8cLkVMQP7
 32LbsW1OZ9a5dUXR40mDuRuXO9FXxUJhJ0SPFoxT6Poq0PDN+xmdpSmeDyhG+KZHFHrO9za9H6h
 Q+7sv25Q3GQc92hdDoXsW+cIjuCkmfmShAee8w3bwICYAtolgxdaGQlxLGM3KU=
X-Proofpoint-ORIG-GUID: wRCLMcfSPFtHc6-N5626WlGxrdkKdLGh
X-Authority-Info-Out: v=2.4 cv=b72/I9Gx c=1 sm=1 tr=0 ts=69b3f52b
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=tFGNSmrwAAAA:8 a=yMhMjlubAAAA:8
 a=7S_PsIfMQ22EjxDurrEA:9 a=QEXdDO2ut3YA:10 a=LpD6Tdepsyerr7eS-Jg7:22
X-Proofpoint-GUID: wRCLMcfSPFtHc6-N5626WlGxrdkKdLGh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 clxscore=1030
 mlxlogscore=949
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603130090
X-JNJ: AAAAAAABwJoih0NZ3MBDYkDf5KIQr1rAokEbdu6n1xNnf506LE5TNepAEIduljuE9AVD022K5QYM39hnAaLB5qEgGzPZRwQxNYVTtnHPgzFKSRXVcgo6G+AtD95j4IiOmVHNcDlK/5gYfiFodtZENF5KpRyVpfQ6M9LFevBeI83uO30+u5EcOShBqNPO0OCoDt3NV399wJqWVSNYc1uY99XiTcI9LH3XKGfAZKpD2WjjI5jakWTzxgu6ef2LQPDyHB2RG3mUeUJu1TZCL4lF3W/P1K/4Ql9l56zd5IzKXbtBhOryLcuK9DGSzE3eEzNoAOtcUiTFFprDrLYLc3Py28Q5bW+k+HnH1COfQww1Sz5eI+D4jpHKcK7TxVZGqpgsu0diIryt++wCroKz+i/DbUEsytKfRFqv632Br9meOo10fX+FqclwcLB6/SVIP+rvTgHUoG+eIPJESqgwsVeWXkISmmHvU8IhzuvR6RJi+6+cF/Tg2WCY34Ew9iTU216IzpiKgumXm9lD179Mzqj4nA1FMgnXGAU+s8DslDDDNZWlCHxwtP6BwUZDaPwi+DUOMwdRhHHWgoHAid8kAmz9vELCDvquKCEg7wDiuO7bSZUs+E4wYoYj9GZ6HT9irzfIB9sJO3wTyBYRjVuS1BhqZJnpNyO/ZzdT02+JEQTzo+KsHe2hD0a+4GENmQqjOidKS/dwsvkC35syKoEkxSBCEYDdUZS/S69kiGG7bR84hD1ks4fOhUivdWsCKYU2RmL9y9uSerE53TFGVbcMb3dqmF7xPIF5cNUT4yUAAYE8wV9b5/+e5BuYjkFmqXlyPSo=
Received-SPF: pass client-ip=57.103.91.75;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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



> On 13. Mar 2026, at 10:01, Anirudh Rayabharam <anirudh@anirudhrb.com> =
wrote:
>=20
> On Thu, Mar 12, 2026 at 11:45:48AM +0100, Mohamed Mediouni wrote:
>>=20
>>=20
>>> On 12. Mar 2026, at 11:32, Anirudh Rayabharam =
<anirudh@anirudhrb.com> wrote:
>>>=20
>>> On Wed, Mar 11, 2026 at 04:35:31PM +0100, Mohamed Mediouni wrote:
>>>>=20
>>>>=20
>>>>> On 11. Mar 2026, at 16:15, Anirudh Rayabharam =
<anirudh@anirudhrb.com> wrote:
>>>>>=20
>>>>> From: Aastha Rawat <aastharawat@linux.microsoft.com>
>>>>>=20
>>>>> Enable access_vp_regs feature for regs. In arm64, this feature bit
>>>>> allows the guest to set VP registers using hypercall. This wasn't
>>>>> required for x86 because such registers are set using wrmsr =
instead of
>>>>> hypercall.
>>>>>=20
>>>> Hello,
>>>>=20
>>>> Could you split this into two patches? With the hvhdk.h changes in =
another patch.
>>>=20
>>> Any reason why?
>>>=20
>>> Throughout this series we're introducing hv*dk changes along with =
the
>>> code using them. Isn't that a good idea?
>>>=20
>> Hello,
>>=20
>> I think that because of some of the content of header updates =
aren=E2=80=99t immediately related to the commits at hand, it=E2=80=99d =
be better to
>> just have a single big commit at the beginning of the series for any =
GDK/HDK updates.
>=20
> I think that in this series all the header updates are closely related
> to the commits they're made in. Do you see a discrepancy?
>=20
Hello,

As a random example =
https://lore.kernel.org/qemu-devel/20260312202209.GA124403@liuwe-devbox-de=
bian-v2.local/T/#madb0f563a418a8fa1ebe35edd782aa4414893e5c ("accel/mshv: =
Add access_vp_regs synthetic proc features=E2=80=9D) adds a bunch of =
other bits that aren=E2=80=99t that directly related to it.

It doesn=E2=80=99t mean that this info is not useful to have upstream - =
that=E2=80=99s great to have - but I think that a separate commit for =
the header updates at the beginning (combining them all) is best.

>>=20
>>=20
>> Oh also, preemptively adding some header definitions before they=E2=80=99=
re immediately needed could be simpler for everyone
>> - especially given that WHP exists and is overlapping a lot.
>=20
> Could you please elaborate? How would it be simpler? Do you mean =
simpler
> for reviewing?
>=20
Yes.

Thank you,
-Mohamed
> Thanks,
> Anirudh.
>=20
>>=20
>> Also makes me think of whether it could be better to share some code =
between WHPX and MSHV, but that=E2=80=99s a separate
>> story=E2=80=A6
>>=20
>> Thanks,
>> -Mohamed
>>=20
>>=20


