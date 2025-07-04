Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E97C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 09:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXcbI-00011h-Ss; Fri, 04 Jul 2025 05:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uXcbH-00011O-4d
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:20:55 -0400
Received: from p-east3-cluster5-host5-snip4-1.eps.apple.com ([57.103.86.172]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uXcbF-0005OX-4o
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=LerEEwkc8yxfphpYBPoanqa5SssV8KcQm2F3J/oqn3E=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=CL7Ewk7tivSVs9QuYeBGL8Isd0sDZyLydcw5AJjAXgrsKfnz/9ASjWy0iOaG9DjaL
 IEFUiNMmViw6ck9pRi/0ZeP4uCZ83cNDfZG7iMag2a+cj/tfBqdCnhSWZdrDlq9Ows
 xb5xLJlKHK5BJjSS5+8YDS5xiNtgYbn3iwTcHPUhZIGj/Aq6XWmt98Ih3I62n8mVmY
 JT+s0BJRKxj5OAQlmSFdYLatEqY3DI7YLy15/t4CHR9zb/VdJIzdr+rjCqTefIGynq
 YcAoH0xae8gksymiXZfsvfkWzq9r6U8L94RxXsRXjWlDtzeJeZSQNyzH5Xjwr5KUMJ
 xzhvEnuzonOkw==
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by outbound.qs.icloud.com (Postfix) with ESMTPS id 7301C1800177;
 Fri,  4 Jul 2025 09:20:49 +0000 (UTC)
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by outbound.qs.icloud.com (Postfix) with ESMTPSA id 710571874768;
 Fri,  4 Jul 2025 09:20:47 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v4 28/65] accel/hvf: Report missing
 com.apple.security.hypervisor entitlement
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250702185332.43650-29-philmd@linaro.org>
Date: Fri, 4 Jul 2025 11:20:35 +0200
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Shatyuka <shatyuka@qq.com>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <28D7CFAA-B19B-4F5B-9B2A-2DD4E3FE1770@ynddal.dk>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-29-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-Proofpoint-GUID: 0V-m4ugA8RLTEn5U9e9uhlk93mFZJlBw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDA3MiBTYWx0ZWRfX78u44BlWz1hp
 Fi2+nS+epsXw8622oIXZublM01s0OHHxAJL90RBglbIGFPIKMYVFgYHvtkA4dtj2m8SGgmVtzd9
 vToI2j0efjL17+VhjmnOpRsMi+mM/ULiRQAKE7+uQL3RnLhR5HvU28lhZSelcXn7QwrJEygzWxL
 XLV+8PsHod6YV2pi8qsqHbbn/QwYvoX3583o9wxsx+xFRYVj+AcfXjJycO9to+hPsmr6Eo1gU+I
 HtadG2nM9kIBkQUAPt2MCrHby1XmAj6JtZy9t9Hyq7v69OguTYv9V3BjN+rG/PUcMGIlw6VgQ=
X-Proofpoint-ORIG-GUID: 0V-m4ugA8RLTEn5U9e9uhlk93mFZJlBw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_03,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1030 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507040072
Received-SPF: pass client-ip=57.103.86.172; envelope-from=mads@ynddal.dk;
 helo=outbound.qs.icloud.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


> On 2 Jul 2025, at 20.52, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> We need the QEMU binary signed to be able to use HVF.
> Improve the following:
>=20
>  $ ./qemu-system-aarch64-unsigned -M virt -accel hvf
>  qemu-system-aarch64-unsigned: -accel hvf: Error: ret =3D HV_DENIED =
(0xfae94007, at ../../accel/hvf/hvf-accel-ops.c:339)
>  Abort trap: 6
>=20
> to:
>=20
>  $ ./qemu-system-aarch64-unsigned -M virt -accel hvf
>  qemu-system-aarch64-unsigned: -accel hvf: Could not access HVF. Is =
the executable signed with com.apple.security.hypervisor entitlement?
>=20
> Suggested-by: Shatyuka <shatyuka@qq.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2800
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> accel/hvf/hvf-accel-ops.c | 5 +++++
> 1 file changed, 5 insertions(+)
>=20

Reviewed-by: Mads Ynddal <mads@ynddal.dk>


