Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBE9606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=N2jNH1uT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7v6-0005UO-Q9; Wed, 28 Oct 2026 13:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xM7v5-0005UG-QV
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:58:39 -0400
Received: from st-2005j-snip6-2.eps.apple.com ([2a01:b747:3001:202::66]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xM7v4-0000B4-CJ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:58:39 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-7 (Postfix) with ESMTPS id
 E722118014CB; Wed, 28 Oct 2026 17:58:33 +0000 (UTC)
X-ICL-RepId: 01a183a9-ec6a-7699-8b02-eec1d980add0
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0ISxMFUgddTVYNRw9YHlwUFwtHQ14IXh9MHB0OWAYSAE0KDjYGWQVeCVYDQwU2EhRdRUYDRxlXFFAbRwxVB1deXwoTAF4PD0wNOgtfdi4ENRQ6clgPRgZGDUAeVQ9aBF16SnFVci9wRAA5BFt3HlwASx1XBFQfUxJVHR0LRVUSBEAIVlBUHkEEVhVsCVgGUxlX
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793210317; x=1824746317;
 bh=pKSd2pgp6CIxP5wK238H7KRXK/Yzyvb0yFwBI0LrgPY=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=N2jNH1uTUbIFSCd2jeamYJbWNS/KD/jByF2Gt/PXB2GobrcBqszSU9ihmBjYjq+L3OKBqQsqjWr+Dde7TAJXBBvk0b85tMRFPhOpxG5Kealdd64qjbSf8x61hstGWIQpiJxkbu7KCAjkZHDHFe44kut9R4HngxE9cbi/0OTEHq6LDxylXE6+HOU1mXvOhx0S1L5kdkEPU58gKeQzY3vCLOLV7OQN3w5IIP6Rh8nBbv75k6lTvNEMHiXvY+VXnW267AELqDDAAXLc11IFNhI7IW4SBDYNkwxcrP5ctQmCL+mGzAf5mwYKNvoe2qO+uHt3Hk6rStOOmow7iR1zWuUcSQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-7 (Postfix) with ESMTPSA id
 96BFF180052A; Wed, 28 Oct 2026 17:58:31 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH 2/4] accel/mshv: stop VM on vCPU execution errors
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20261028125308.147630-3-magnuskulke@linux.microsoft.com>
Date: Wed, 28 Oct 2026 18:58:21 +0100
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?utf-8?Q?Doru_Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>,
 =?utf-8?Q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Wei Liu <liuwe@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4B82AE6E-BA58-4648-8816-C2B8EDB49A76@unpredictable.fr>
References: <20261028125308.147630-1-magnuskulke@linux.microsoft.com>
 <20261028125308.147630-3-magnuskulke@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Proofpoint-GUID: fgMa-1X53w9AP4kQaFg-fRFQU_ouXTs0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3MSBTYWx0ZWRfX8UkjQfQZCxEN
 oR+KyJbn4GsriG9bKGiStsqe5PMA44Pm+mwymTE4K5MvUZJIGCCN+co59fD+a9HOdZaD53Q9HyB
 W7be2obPXZM65s/nE21VKPqIWQH/KE54pDdDPDRg9+3DN59eXy54w1EcCn4F6aV7wWlQv+JfQ5A
 xH7BXG8GpzlnUZvHrRa+MDCVHXJ7DJned7D78/b50jlncj9MNthVv0JvcIbfmRX3EhAJrJw4KUX
 3XQQXEiP4Ae1bV0esH8l9qdg5YzThaN2zpHQ3I5AS/ESzYGHIfPZhH0l//NadTlQWg9lxCb/M9H
 38JiKU5oTIlAWctidIsM3rQU3vwedN+yG8u8RpEkBRt5+Mv0Ypw/B4BtCSsoBA=
X-Authority-Info-Out: v=2.4 cv=L70QguT8 c=1 sm=1 tr=0 ts=6ae237cb
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=EuFfdPxwKaHQyvU2GcMA:9
 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: fgMa-1X53w9AP4kQaFg-fRFQU_ouXTs0
X-JNJ: AAAAAAAB97Ou3ZNsROesVX3DWxkB8rUec7ZFWY5xcfB1koAAf4cqujlcT/AvCVNdYjJNnT
 95GXWOcJu7ezPQ4G/68M1oYcecgPuATAOxsn3wyYUKNJLOMfjHcSg+29kRsEXZEy4KVV23
 n1CSgFRKYNxZ9PrajctSAJDFq020KJtQhkmV1BryQqDW318q2VwLNyL/IL4zfEMPjO5QYE
 ikb1Qn3QcHOYfVZ6PK3CTwD0Ab3VvpXLcPFnO7JksfX8wBNgaStXNzrGNCYpf7//pBlv7d
 pzKc9QvBsBclPvORBWI29bG1CzLSAypvNCW+vt4+ItX3W+DO0twLqhnnAtlsk3QyYS3sF/
 aFXJcp5RbnP5mOlgSwRYqNK2npv99B5Onr61d+z+/CaU2zu51lktuMkX/MM7P6FyiyAfFn
 u0c7khKFxSpcg5WZTahoM99n2VZ8EtRoz6fpxGc8vlzivTAz+mV/QR5SebJ/piRzqP0/b+
 DLRnHI94oqcoXk7Mt4oB8u8ZmEPleHpKLDPWeWYgDpodtd/YTt08gv/mVUevgQVkwf1OIU
 Hx20+zxu7ZwMFjoGM6iHA8nTmyDpnUS+QmBnkTfQgKq9YhFeLX0njqdEwLm2/qP1dbd2cA
 jqxFFTgVT/px5MtdW/pSZWTXtt5wUeXDrb7UTLlGqvm7VknsWBCYQn5EXPhPf8aFOmq9el
 vTnPJy/3oZVPxURZ9CRkyUln6+72xR6phb8LIQ5E/++SZn80vsAe/GNfYd6RO3HfmMIl/a
 TCGTaAQl/9cnLl5Z+887symAdes4JIySSNS2y7iQI63u682ythAnHyhhjID/J2jcrwcZtv
 DZ9mqStOugvHT2Fb5jgUFnMfjXSfn35HVjSneRmhXgdHQAYuf2paIXN74rGSb+4oXClyJk
 l7SmnKaZvmUTADg7hVoSnR
Received-SPF: pass client-ip=2a01:b747:3001:202::66;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 28. Oct 2026, at 13:53, Magnus Kulke =
<magnuskulke@linux.microsoft.com> wrote:
>=20
> Currently we abort the process immediately if the ioctl returns an
> error, so the error handling routine outside the loop cannot be =
reached.
> We also enumerate the enum variants explicitly to make it obvious how
> every exit reason is being handled.
>=20
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
> accel/mshv/mshv-all.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index d820a67b95..7289c8d1c2 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -778,8 +778,8 @@ static int mshv_cpu_exec(CPUState *cpu)
>=20
>         ret =3D mshv_run_vcpu(mshv_state->vm, cpu, &mshv_msg, =
&exit_reason);
>         if (ret < 0) {
> -            error_report("Failed to run on vcpu %d", cpu->cpu_index);
> -            abort();
> +            error_report("Failed to run on vCPU %d", cpu->cpu_index);
> +            break;
>         }
>=20
>         switch (exit_reason) {
> @@ -788,7 +788,8 @@ static int mshv_cpu_exec(CPUState *cpu)
>         case MshvVmExitDebug:
>             ret =3D EXCP_DEBUG;
>             break;
> -        default:
> +        case MshvVmExitSpecial:
> +        case MshvVmExitShutdown:
>             ret =3D EXCP_INTERRUPT;
>             break;
>         }
> --=20
> 2.34.1
>=20
>=20


