Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604F7CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 11:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulnCv-0004ej-OS; Tue, 12 Aug 2025 07:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ulnCt-0004eJ-RZ
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 07:30:20 -0400
Received: from p-east1-cluster5-host3-snip4-3.eps.apple.com ([57.103.89.154]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ulnCk-0004ih-U7
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 07:30:19 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-0 (Postfix) with ESMTPS id
 66B221800198; Tue, 12 Aug 2025 11:30:01 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=9V/Qi0Vyf2p/OIULlNa2Xuvyf8y0LvDbfTFTT+2jd94=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=WjlLZWNN8BHGdVUuglSJq5z6go0uFPSSrAGvmSbLByeD7F5MVtljBsKmuonkShoJh4Sa2DAmLpX+gEfJ9aKg6PTIcf6u7EuQ03GmY1ZyOEx57ULXcUmKagrZtE1hVzfIJ2fwMaM9xjFdSH8om9Vw6/ExYfX/Nw+DeyIJwpNS5z0IMfDbYAYHX+xe6b3VRf0UfYBD2WP0u3lIW5zj15nKjHDoUKvemHxfX0T+prAQnMRErNjwuPvaB92jXa+boTL9eUyW3BjWYgZ08CSLrRncuv5aObuUbszCOoVbKaJEfoi+b8bNkzOxNGwFg5tO9f2eSNI/NIDHa9oEtRv/ivT+fw==
X-Client-IP: 194.62.217.67
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-0 (Postfix) with ESMTPSA id
 D06161800191; Tue, 12 Aug 2025 11:29:58 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v5 06/13] target/arm: hvf: pass through CNTHCTL_EL2 and
 MDCCINT_EL1
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <CAFEAcA-TKwH2pnvK8YcwXnZ56eX-dOpzb8Q9e9HN8BoebjJ+WA@mail.gmail.com>
Date: Tue, 12 Aug 2025 13:29:47 +0200
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Cameron Esfahani <dirty@apple.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6617003D-BE18-4642-BE40-7B1CE7DE041D@ynddal.dk>
References: <20250728134114.77545-1-mohamed@unpredictable.fr>
 <20250728134114.77545-7-mohamed@unpredictable.fr>
 <d2e93df6-bbb4-427b-828e-b6f5466ae2be@linaro.org>
 <5CB6CE7B-B122-4BE1-B031-EF44D0A79B63@ynddal.dk>
 <CAFEAcA-TKwH2pnvK8YcwXnZ56eX-dOpzb8Q9e9HN8BoebjJ+WA@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-GUID: C5_18-_mNBXrYEb4TOSXVQNC8f06_ZlQ
X-Proofpoint-ORIG-GUID: C5_18-_mNBXrYEb4TOSXVQNC8f06_ZlQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExMCBTYWx0ZWRfXyTIiu/4Zqulw
 aO1rbWmzY5Lit7rEcaY7rrQCPfJDZmvrx9uzFU5it2ObEwHLPv2f40URH6yODYyoIyBpK4jEOM1
 nCH+otzDufIbqGPDv712KcX6pI3jFasN8UM89pMSxd1D7IFI9Eg37BVffngmuTTuUEXE6otLVQQ
 q+10GnfPOgCV6zn714xaFySfyskckMpvIQvPwpP6776MjxbPQFl8vbqiJyCD4Ieml6slYa3cz1q
 r+01LBsJ28C9hynMHiRr7veeXaxCgXdeU2dIONZFtX5Z0x9LB7ALH/AX8qXHwalZ3J+Y1Wzh0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_06,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 clxscore=1030
 suspectscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508120110
Received-SPF: pass client-ip=57.103.89.154; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


>>> We'd like to remove the assert_hvf_ok() calls, so adding more isn't
>>> really helping. Anyhow,
>>>=20
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>=20
>> What is the preferred method going forward?
>>=20
>> Apple designed the HV API to be able to fail at every function, and =
it's
>> rarely something that can be recovered from.
>>=20
>> In [PATCH v4 04/15] of this series, we saw an issue that was hidden
>> because the return code was not properly checked (not calling from =
the
>> owning thread). Previously, I submitted a patch (d5bd8d8267) for the
>> same issue, because Apple had changed a function's behavior. This was
>> caught by an assert_hvf_ok.
>>=20
>> I agree with you, that generally adding asserts is a bad design, but =
at
>> the same time, HV is designed in a way, that the code would be =
littered
>> with checks otherwise.
>=20
> This suggestion was I think mine, and I think partly I was
> misled by the name of assert_hvf_ok(), because in fact it
> isn't an assert(). (assert() should be specifically "if we
> hit this this is a bug in QEMU", and "hvf returned an error"
> is generally not that. It does call abort(), though, which
> isn't much better.)
>=20
> But also I think the existence of assert_hvf_ok() encourages
> it to be used in cases where actually we should be doing
> something more sensible with an error return. For instance,
> in hvf_accel_init() if we can't init HVF then we should
> return an error code to the caller, which might fall back
> to the TCG accelerator -- but instead we have an assert_hvf_ok(),
> so fallback won't work because we'll just bomb out.
>=20
> The KVM API is also one where any API call (ioctl) can return an
> error, but we don't generally assert() that they succeeded, except
> in a few cases of "given where we are, for this to fail would
> mean the kernel was broken". Instead we propagate error values
> upwards when the function has a mechanism to do that,
> and where appropriate we print an error message that's
> hopefully reasonably comprehensible to the user and exit.
>=20
> -- PMM

Thanks for the clarification. I think I understand the sentiment.
Propagating the error codes when possible, is much preferred. But
letting the calls go unchecked is problematic too, so I don't know if we
can get around assert_hvf_ok in some shape or form.

You're right, that it might encourage use as an easy fix. I'll keep an
eye on it in my reviews.


