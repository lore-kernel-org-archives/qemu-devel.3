Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B504CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 12:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvaYV-0006vf-Ug; Mon, 08 Sep 2025 08:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvaY5-0006nc-7O
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 08:00:41 -0400
Received: from p-east1-cluster3-host8-snip4-4.eps.apple.com ([57.103.91.205]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvaXr-0008Jf-1A
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 08:00:40 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPS id
 4F6EB1806A59; Mon,  8 Sep 2025 12:00:21 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=FcFFtm23vr3ASicvjTJ60JHD4ub6D7rxeKyezhRF8Sg=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=BAwm1o+3KUQeip5HF6+GuPEAg/GWQG98T0J+4wZNiG5uXvMOrsfh67chBvYOHntXnVD3Y1YulT9kkJVd7tduivJVbX5VS+RENxbnW5VpVu8JE1q3rxbHIDaIdZXXtJk2WmrbGXP8fHp38zyhIvwlH9O1p8C9mz+EVz/hxy5SSQmFjWmOtno0a+rN3ynX3RM3VNUCP8oH373VGfgldrCM2s3iPltA95TNE5O8W2stt5DQb2/2NDB70XsP7gXKtwOkyhpX4kUXxshGnOjZEsHb2HQP1jH6IG0J1umrDSJh674YzOaE2kDmBOe42096ufU4s4uGsSH7oRXbUvZvoAkFOA==
mail-alias-created-date: 1632407063367
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPSA id
 744B91805530; Mon,  8 Sep 2025 12:00:19 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 13/24] accel/hvf: Implement hvf_arch_vcpu_destroy()
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250903100702.16726-14-philmd@linaro.org>
Date: Mon, 8 Sep 2025 14:00:17 +0200
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C12C91D6-F8AF-4C2A-BAC4-90DF0498926B@ynddal.dk>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-14-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEyMCBTYWx0ZWRfX2jXmSZX0cfQu
 se9+pv7PDwLCa9WezwS4+wUld+4aqw+FfE7iR5a0DmajAr4iLq5LGOc9Ai7pDDsy5YBCjEpiGO7
 RgF0U6PBp2ndHNLs2X+mRvHKjFCqeZAQmG4TcQu9o8drskGeN2bwhEwZbvc4jaeyUwhAYOt8qIL
 oIXLfqrIA4hnmrrIp+y6YXcHPr0Ic2SAn4JlCYwCHv6H+tz4blqS3ifIaNE8uvvrbTevEu1am3l
 Pt6DLDtz7JO6ICE8j2SFU4iEpzNuX+n87mz70+mihhkt/j2B5c2PB14oU+Qwi0D9RMTLwxfbQ=
X-Proofpoint-ORIG-GUID: W-1sovzfObFYlo-B74A5jsVx_3dXth3Q
X-Proofpoint-GUID: W-1sovzfObFYlo-B74A5jsVx_3dXth3Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 clxscore=1030
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2509080120
X-JNJ: AAAAAAABvKfb8GBRfVuDAJdOvjDLg2PBxcQGKQwmOQIYVdzMfApWPZwxYtlyU7aDK66OnMb1DlHnRJX8tv+R2y+IN7AcOVY2kgTrF4w8ZbxAdHT+k+x4z5LGV3cWDOFSuuFE3akcsTUX3sGX1Fb6vOI/c9Ea/OlqorzS5kB60BKMwc2Q2EkRBqa4nwdI80uBCp4O8QZgsE6HhcB6GlCvHBEjGmlK6rCa3JLrMEmzN53xlDozb9dpR7EsSsHT9WsKBfLLcyICX2Fzt+OaQrPIZmRdwZZ+jkO9AAOVZlzo6ZouNV1YSu6Xo7f2HqBsp8a8ItYXpAEzjG7nLGBG/yPxH+3Q7WOz6mXRTlNfigjRX6kcLUF9p5I65WdMKet+1/ImSgLWclLI18AbBUH2DZ1zJ7s38uHcqyKxUXS4cDTMLusSDKQGnd+NqbSaTFatcY3fDQB5dBuOIWGB3oYyDLPEZ0auO2CIB/TbRNwi1QjPlTkNTsoxrJb4eCOY8IF7fmqsWZNPXYh89yxOEEpw6U6w6HddkBSlP5XyyeMltQICNvUEoooH8VCf6hfufhCNTVJt9q7Xu3BqcsewO9fHxrGJfj8nI1DdBAVuKismb3Ugq0xnvD3b1SPDHb5OScD1G/6FRbnNeUIAVOo2QtO1yb155zRkRmv14JSNxq3BXKuPirxNrNrqB7nkESS27y5ONbJYtVjRs77R6ouaa8LVKn+wToo=
Received-SPF: pass client-ip=57.103.91.205; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


> On 3 Sep 2025, at 12.06, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Call hv_vcpu_destroy() to destroy our vCPU context.
>=20
> As hv_vcpu_destroy() must be called by the owning thread,
> document hvf_arch_vcpu_destroy() also does.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> include/system/hvf_int.h | 3 ++-
> target/arm/hvf/hvf.c     | 4 ++++
> 2 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
> index 241c668795e..195d64dcf18 100644
> --- a/include/system/hvf_int.h
> +++ b/include/system/hvf_int.h
> @@ -71,13 +71,14 @@ void assert_hvf_ok_impl(hv_return_t ret, const =
char *file, unsigned int line,
> const char *hvf_return_string(hv_return_t ret);
> int hvf_arch_init(void);
> hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range);
> -void hvf_arch_vcpu_destroy(CPUState *cpu);
> hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
> void hvf_kick_vcpu_thread(CPUState *cpu);
>=20
> /* Must be called by the owning thread */
> int hvf_arch_init_vcpu(CPUState *cpu);
> /* Must be called by the owning thread */
> +void hvf_arch_vcpu_destroy(CPUState *cpu);
> +/* Must be called by the owning thread */
> int hvf_arch_vcpu_exec(CPUState *);
> /* Must be called by the owning thread */
> int hvf_arch_put_registers(CPUState *);
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 4a535d65b7e..5b3c34014a5 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -992,6 +992,10 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU =
*cpu)
>=20
> void hvf_arch_vcpu_destroy(CPUState *cpu)
> {
> +    hv_return_t ret;
> +
> +    ret =3D hv_vcpu_destroy(cpu->accel->fd);
> +    assert_hvf_ok(ret);

Interesting that this was missing. I can see x86 is missing it too.

> }
>=20
> hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
> --=20
> 2.51.0
>=20

Reviewed-by: Mads Ynddal <mads@ynddal.dk>=

