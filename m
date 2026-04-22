Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B581F9EDC9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFXaO-00062H-WC; Wed, 22 Apr 2026 09:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFXaN-00061p-MB
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:25:47 -0400
Received: from p-east2-cluster5-host5-snip4-10.eps.apple.com ([57.103.79.93]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFXaJ-0007V6-Qz
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:25:47 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-4 (Postfix) with ESMTPS id
 BF47618008F9; Wed, 22 Apr 2026 13:25:38 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRAEwVSB11NVg1HD1geXBQXC0dDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTApNAl4DU3E2FEF2VQ9GBjR9PR4sdloLXQtOAVVzXHNCAUByW3ceXABLHVcEVB9TElUdHQtFVRIEQAhWUFQeQQRWFWwJWAZTGVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776864341; x=1779456341;
 bh=DwCwwab7tv0CYRhwvb/eZwUgn9C1Kl+QfpKBXNKsDFs=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=HlKUWNj48nY5pl35Y+UKB+8G1ZE9Ega/nuEVqUxIFFxHPWWcYFPlxHl6kzW1sah+YcjaQEE0Vt2UhDOds/G7SmEughhxIAW6yT23hn7FwBjrB905unq+MENx8GSn1z7JeZS8MEq0adUMtLJZj6KceuU1Z6yIZIVrVsdKw5zzmrrcvTbcFTbM6RbZpYxD/ntlglZj94k6/Ue4UVkON2gWHsuxxoTnsQclztvwz835ggvTOvi1aSjruwX8WIl+t2m2qWnMK+5raRdcauqbEzKHhggIzRt/uFkr565OJuYnh4l93gfU95ESHugHtnuZGLaTHKfnJz1Wpr+LKI1lO8YGHw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-4 (Postfix) with ESMTPSA id
 B074818008E6; Wed, 22 Apr 2026 13:25:36 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v2] whpx: i386, arm: do partition reset on boot CPU reset
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <94C6AAAA-BF20-4202-9965-081192A392A2@unpredictable.fr>
Date: Wed, 22 Apr 2026 15:25:24 +0200
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <351348CF-9E88-4DDE-AA19-2628D7A288A6@unpredictable.fr>
References: <20260421205749.55060-1-mohamed@unpredictable.fr>
 <a8cb94f0-9970-40b8-912b-3ab81a5907f4@linaro.org>
 <94C6AAAA-BF20-4202-9965-081192A392A2@unpredictable.fr>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=b+m/I9Gx c=1 sm=1 tr=0 ts=69e8cc53
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=rO6M6RRrFnvplcZrBd8A:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: UepB5Nvh3Z8GCk7NZt8IjIjVnwr_ny7I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEyOSBTYWx0ZWRfX2X29vwngeI3K
 ZzQrhiR1cy8Dt6HNkTLNapSklbUIAG6ChKqOZzgpkwHJl+5qjN2730287x1ItEGvDru6u0PXBU+
 wt84Q2QVi1fSDPFeIMjt8LTCl1B7Kdh6lBgZwTLyMT1tNlqll4Xu1+rAd4tcjbXK+VCKuK0kbAg
 hr1799G6sZLNAYR5WRDxBbCizG7d/l6ozHqFF/KL6RWpQQsnjMxJw0A3TkBWVnyrGr2ULZdn/7U
 vlZ6ndEx/1brn2B/YSOmCtO/Z+KTHzkpyDggm/rfK0OhIKOybjgwJ4+/YxYWuNbyqLy1ZHuc/3T
 0E3isF2GjPfwAZma2u5ilFQSNhQCG1ieof8DEJN3EKAHeJogE+UsZkOBjRMhB8=
X-Proofpoint-GUID: UepB5Nvh3Z8GCk7NZt8IjIjVnwr_ny7I
Received-SPF: pass client-ip=57.103.79.93;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On 22. Apr 2026, at 15:08, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
>=20
>=20
>> On 22. Apr 2026, at 14:46, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>>=20
>> +Ani
>>=20
>> On 21/4/26 22:57, Mohamed Mediouni wrote:
>>> WHvResetPartition resets partition state, and is not supported on =
Windows 10.
>>> On Arm, it's supposed to be used for reboots. The prior location of =
the
>>> WHvResetPartition call wasn't right, as other vCPUs might still have
>>> been running, causing the call to fail.
>>=20
>> Is it very different from the conceptual step introduced in commit
>> 4003e5e65fe ("hw/accel: add a per-accelerator callback to change
>> VM accelerator handle")?
>=20
> Hello,
>=20
> The difference is that we reset the partition state but don=E2=80=99t =
have to=20
> re-do any of the memory mappings in the Hyper-V case (or otherwise =
tear
> down the context).
>=20
> We could fallback outright into the CoCo case which would work too.

More context:

Another potential option for the arm64 functionality issues on reboots=20=

is to poke the proper activity registers for PSCI state and skip=20
WHvResetPartition() outright (we might need to do save/restore those
registers later on for proper anyhow for migration).

But Microsoft told me that I=E2=80=99m expected to call =
WHvResetPartition().



