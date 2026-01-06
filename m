Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34FECEFD03
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 20:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdDg9-0004fu-Sb; Tue, 06 Jan 2026 15:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vdDg8-0004f4-7K; Tue, 06 Jan 2026 15:29:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vdDg6-0005xd-E2; Tue, 06 Jan 2026 15:29:19 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 606HOnCm000759;
 Tue, 6 Jan 2026 20:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=shfspT
 0WJQdIecexm1v8svzIBSmvJRFDKnYf5TpGeRo=; b=Ehh0CiV5BPTWf7kBQgupg7
 sRMrCx1/XX+v6YzhHZwpquf2Eb90tb+QF0zSru43bE2v2VyzgN8V2j46x1bNT38t
 2GOIblGXll7JpAmeVli70JOWm1X9JMERYVNWXzgRkZ0Z2ZtFJFlPRq3QHY1As4jC
 fMNaOVxnpr5FZaEQ4cfp+dWMhPsiFz5glCr7ub9uXGDGLZpwpVohd5fCdpvAzWzI
 qlGvQXdP7khH6JLYIZUVpbxicxMjM0LFTmzJWJo9XR6TxM3K294175IW4I74uO4d
 EAkCSy3CMWrW9g8PsJWzO7ktmBs/8IHw/IhDeSB93L728IJd6PaiqnlnrTSuiSlw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtmsyc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 20:29:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 606JcNSv012590;
 Tue, 6 Jan 2026 20:29:13 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bffnjd9bm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 20:29:13 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 606KTCsa27066900
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Jan 2026 20:29:13 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E33715805A;
 Tue,  6 Jan 2026 20:29:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D64BA58051;
 Tue,  6 Jan 2026 20:29:11 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.132.176]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Jan 2026 20:29:11 +0000 (GMT)
Message-ID: <41ab3dd6807e59420117f200b390be3544735347.camel@linux.ibm.com>
Subject: Re: [PATCH 8/8] configs/targets: Forbid S390x to use legacy native
 endianness APIs
From: Eric Farman <farman@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 Ilya Leoshkevich	 <iii@linux.ibm.com>, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>, Halil Pasic
 <pasic@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier	 <laurent@vivier.eu>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Farhan Ali	 <alifm@linux.ibm.com>, Cornelia Huck
 <cohuck@redhat.com>, Anton Johansson	 <anjo@rev.ng>, "Michael S. Tsirkin"
 <mst@redhat.com>
Date: Tue, 06 Jan 2026 15:29:11 -0500
In-Reply-To: <20251224162036.90404-9-philmd@linaro.org>
References: <20251224162036.90404-1-philmd@linaro.org>
 <20251224162036.90404-9-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=695d709a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=Q2ezHdhlEfllvczGAIkA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: -TcJhUF-zfs6XSh7GEEiHDVKzxfdgsv4
X-Proofpoint-ORIG-GUID: -TcJhUF-zfs6XSh7GEEiHDVKzxfdgsv4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE3NiBTYWx0ZWRfX5ez/GcrSLnl4
 +JBV9p5tbLUbD+0MwI9/2yHlmhPeJqXzXfJUdFe7tpSAP1B4SQ+Ia6uxgY7l1FZuNWkglMJJIGp
 3kFE2HYMBcaytjRr0huBNckHacnbO3EjQT5dAwWCXSoD9wiDIf2Ud/2SCZgdnFAXpgS+EQshHfy
 kWd6kkN/H3O51BqGdFDRJeA/u3a3GRotEQDGvOhXRI2FKvPU71h5pQ25xx57KoFuXx0Vm+hSnN6
 jdYuUuGNzPkgX04ni13V/aNZNLzcK0DL1d0LI+5rV62M0nVwBnibFtTMxhWiCmN2IvEO142F0lI
 IQ1W+9AQX98ADKZJLmnkrbkHh2oKv2Sf6Rfal/URNWjJSLloVaAw62q41MQTFgvKtbx3KkenBA2
 14kzymNLurba1FUyHD6XuQSU3sZsAdtWm6p8Vuc7bzPl3PD8A96tUPdVlb9UWbGq36Cig8m6G2L
 m//BBqRcZNrvGZgVA1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1011 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601060176
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, 2025-12-24 at 17:20 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> All S390x-related binaries are buildable without a single use
> of the legacy "native endian" API. Unset the transitional
> TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
> further uses of the legacy API.

One nit is that this text confuses me, because the code below sets
TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API rather than unsetting TARGET_USE_=
LEGACY_NATIVE_ENDIAN_API.

End goal seems the same though.

Thanks,
Eric

>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  configs/targets/s390x-linux-user.mak | 1 +
>  configs/targets/s390x-softmmu.mak    | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/configs/targets/s390x-linux-user.mak b/configs/targets/s390x=
-linux-user.mak
> index 68c2f288724..e3723f5dc54 100644
> --- a/configs/targets/s390x-linux-user.mak
> +++ b/configs/targets/s390x-linux-user.mak
> @@ -4,3 +4,4 @@ TARGET_SYSTBL=3Dsyscall.tbl
>  TARGET_BIG_ENDIAN=3Dy
>  TARGET_XML_FILES=3D gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xm=
l/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xm=
l gdb-xml/s390-virt-kvm.xml gdb-xml/s390-gs.xml
>  TARGET_LONG_BITS=3D64
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> diff --git a/configs/targets/s390x-softmmu.mak b/configs/targets/s390x-so=
ftmmu.mak
> index 76dd5de6584..544657cfe2d 100644
> --- a/configs/targets/s390x-softmmu.mak
> +++ b/configs/targets/s390x-softmmu.mak
> @@ -3,3 +3,4 @@ TARGET_BIG_ENDIAN=3Dy
>  TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
>  TARGET_XML_FILES=3D gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xm=
l/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xm=
l gdb-xml/s390-virt-kvm.xml gdb-xml/s390-gs.xml
>  TARGET_LONG_BITS=3D64
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy

