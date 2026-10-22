Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700D6606A322
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ofLFntgx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BerAwO/A
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJwLV-0002qq-O4; Thu, 22 Oct 2026 13:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xJwLU-0002qT-A1
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 13:12:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xJwLR-0001Cz-SL
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 13:12:51 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MEFVqu4098325
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 17:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AzrQGOQebYJFUZ71s2dvCiEUbejpPIwtSh+JoNKOgfw=; b=ofLFntgxF6UP5ApA
 meRr5pmtcyRnofFWmn/AIB2KdIJdX2Nvq8d55PR4ClcmXsjHwKrfpYnerVm2Myp6
 SLLRFZOLkm7XIcowlhRCcKH7wvsj4FZXGqh+XzIxg2r3N+5bGFa+5znS3bqop7u9
 nolJdf/+WnM4pVKW7POeRmI7uD1s3suvsT/jwV2XtoUhCe3dhuFhkZSjWapl5Fdp
 SjHdxq9l/UnMFb3gNfmkUekD80WSMj6xHTA3Ic6D76lF0I3QL0HSbXYM0pffiH1K
 IKadjTOa0PFJwnPHypYYynFGqfKbTkvRFh4PG4bhJPJxJlrfk/6TgF7G0TnXD/nO
 EcjjmA==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfewq3qhn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 17:12:45 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-4519ef1babeso87289fac.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 10:12:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792689165; cv=none;
 d=google.com; s=arc-20260327;
 b=U66p0zQup9/1Fz9PeTGLNhX24OYmckUlQYHvpBy7v8pGGzxEgb8w0wJYNqM8SjiRNN
 XQQG74tqqUu1R7ApDW958zsksQ4XtFU089udpotkip4N11bzuJfZ6sZpWU0KtpYQLOY+
 I9mZqggfvs6pYWpDCXTefE4LnaYZTSZrmmKp4QDXDV1PivYwH7GDB19yPtSUjcsB4dhE
 Lmy5OPjclFZwu0Pbb+3om8cVl5qGS5vPJTChCV/f8bOilOwQMANk0L+MnOL0f1vdehbx
 b1Kvjd2MYCvPHQubp1b9C2GyqWA3QBcbau6SLHxvnen/RrrlLxx0tzqPUke12LcS5VtM
 ewNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AzrQGOQebYJFUZ71s2dvCiEUbejpPIwtSh+JoNKOgfw=;
 fh=91Qh0CwNy7hz/SABiv0vN2wob3TmMO2eFI2qsEc3U8o=;
 b=in/x6aQukwuE15g9r3Wl09Xz7PRVudrjZl3DjyJypBdLsX9KzBRl4ODrRAHIBKA3Bm
 gPEYjA7m5383XWPKYTAbvyGd5xwPXZlh1xin4z0mSaIOrS8RHwujM3Si6j3N/0XImT70
 26jmIM4DXv70RvmEFIOz25YgGBCEy/SMvhCG4tSLsQAqrX4bNuswEHQoEnF5AnukC17X
 GRUTandU5MoKb964r1xNbxuWUYwjuXafDZUgYlzeVQE/DwF1edcPG4cHZFb/NymaYKiu
 7QfRk5E4wnu4iLeNVfZBmR3KHdJqARwgswnK8fudcms1UhVemTBJQki2yps8JN2joLs0
 88Dw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792689165; x=1793293965; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AzrQGOQebYJFUZ71s2dvCiEUbejpPIwtSh+JoNKOgfw=;
 b=BerAwO/Ah2ClkGjG4FsG7zaXU4TRMHPfVm1p0kD2hUvQEUysDqKLaNQUuqkxsVzeAa
 ezj1LFppVUZYbzMCCN8LIA/17rh9HsDi6hLepLNlhJ3haPwoNNxWcxtnU+2wffvJ2Lsj
 wgrKfoLrb4EZW0nF6+uReZoisEsL3m7rhS8dHki6b4hs2gBb1ToyElnvce/MBmH6hqdN
 wy/AVXVhhamqcVy9Os/eU/Ndci/O+i84HPEqVYn0/Qtu/aACXxC0sckzqDvcJPGo1Gkx
 fdIeZsoYURvZATGkKQ+8j0rSVydi5+8A2DdT0bt6VHnSLuljN45PgQS1Y2KcROiV0m4K
 cFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792689165; x=1793293965;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AzrQGOQebYJFUZ71s2dvCiEUbejpPIwtSh+JoNKOgfw=;
 b=ljOlb+SS6PNXm9dVuQr6BSZgzODht2JgfBamjKcckNxHkQo9oloToyD3vGlPfJZUFd
 Q0/JMscRKCRRY6yDyBV/2oi6yOF4UVTSoZkBsq82zq9LpfmoM7k1t1GR7IoXxIMkaOU0
 IwJgH8STBi827UAcabV47cLIDqQm58ADhhdorIXK3K/DMd9rPXCSO27Nj383kS6TsH+8
 G2c0nXJFXSJJZleSMCtRaQMEYcw3nVPhJ3D3XQh+QGS5n2SXcoOfN32QsLVBLZ8xEhsQ
 Q+Mhg5+x/ZNzNX4pRNkqEbM34IxD08yBWMeJwqZxP/L/MyhfPZO0v6kkYXgQwT6hR2a+
 ztmg==
X-Gm-Message-State: AFq9FYKTabAL8tDsPBe+qmloutE3fGNUvTbBBmPOCSOI0chXvtjhRjAy
 IrVRFqauh5ar7qoKt91ZPE+dxtHSio/1nD2kWsh3gARua63Y58xVxcrcw0AP5NQbCN0wT2Hu8y4
 Aa/ecIh+0Jf+wQxg0tMXKkPhI8Fq8MmYXpeCLFPPB6rFbkvwv72e8IzDEQPBe5LMCsN36UNFwEB
 +HmpQ8xXmNPdojjT1FtB6sliFz1brpDCBM
X-Gm-Gg: AYBFou1dU2nCU2nFPZcIlHDgCBovrmyhYD6FLYRtGD7b7Qvc/Bu3U6SBmfia+m0oRh0
 km3GpucSgMcMFbXbiPyx5Bstu+NCvVwfQHEkG0BP5Kehwze7MIbqZeevM4XaToc1tQ6jnRMWjCL
 xTa9cD2x5rZwvMpHOfKoQn6uo/+muLZ2JxxSWszOJVMCUt7nAoKNMw9Snax3AWmVUsDm70XxXEr
 yiLd//2qo8wBlxv2GY=
X-Received: by 2002:a05:6808:f90:b0:4d6:90f3:74af with SMTP id
 5614622812f47-5535ae27209mr3817629b6e.47.1792689164805; 
 Thu, 22 Oct 2026 10:12:44 -0700 (PDT)
X-Received: by 2002:a05:6808:f90:b0:4d6:90f3:74af with SMTP id
 5614622812f47-5535ae27209mr3817608b6e.47.1792689164327; Thu, 22 Oct 2026
 10:12:44 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021224421.3786109-1-brian.cain@oss.qualcomm.com>
 <20261021224421.3786109-12-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261021224421.3786109-12-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 12:12:30 -0500
X-Gm-Features: AclHuK_wyaJJ8lCoHs6cOuQxRiRmCPsOHC_AIsfrkTDxYE95GzCDq-T1q-N4iYQ
Message-ID: <CAJ+KCYM+U_GzaW0_F2i7ZbEP0puOv_WmF=h0QLgUGqB4qO2vVg@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] tests/tcg/hexagon: add v85 scalar tests
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: h8jJULY_1VieraVGyeorNufr8XqgpOuU
X-Proofpoint-ORIG-GUID: h8jJULY_1VieraVGyeorNufr8XqgpOuU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA2OCBTYWx0ZWRfX2URHYnGn7ON7
 QsS0TdIzAZJ7x5u2OFCtvgVo/IyicwpzSEZq+kH0sZHyQEKg6nGUEGJbolNIVmkOIWH37gP0OLV
 63kz0FRDko5r8y5AD0bAs0WWBvYpKeU=
X-Authority-Analysis: v=2.4 cv=G4OJgNk5 c=1 sm=1 tr=0 ts=6ada440d cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=bOoxZ50S6rYDioB0W78A:9
 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA2OCBTYWx0ZWRfX3kFmlSGj4PLL
 qoRsoEF2YO7gFnTFXDtNEOOgGY7/ewFsmaKXnjcH7SKMT41WkRPh+Gl0yqJdHYIUWoafhMb9stO
 pxgTEVyLrMuXRHHkcCgOlwvM9Af5/An9ik+5oMDvFRd09dXAPH3oo8tVjOANO9m4XSeVFUdR/PV
 Aqkd7znU1P7NRmPcRlv/BtPzCwMZy3ua70ChtIGP6e0Y8sYTUe1NKV4QHSUwwdGD4q7CaQAUHRi
 HuH+UzeEtb+UBfLV8e9QwLJJQNsgUsPnBXqogbvvL9jspvVHVml7U1wOpubdfZMUvfaH+daLYzl
 5FOfLVaXi2mqmp2baXvQ0+YbQJ+119lXEXBHg8wB2cmb2Ha5A1VUGTxK5YvKpwxRL0SGKrpNi0x
 5dQM9vHK7Q5WwyzzjFHw2vtQC3zgFF32cfuJqF5sWewmS3xtLgvO6UcuCuZMS0nJcrTWYZs4c/K
 vmEIwGgRi5MS1Z2kqjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On Wed, Oct 21, 2026 at 5:44=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Add tests for: vallocframe, atomics, trap2, CFI/restricted branches, and
> scalar fp instructions.
>
> New instructions not yet supported by the toolchain are manually encoded
> with .word directives.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/cfi_tgts.h         |  18 +++
>  tests/tcg/hexagon/atomics.c          | 111 +++++++++++++++++
>  tests/tcg/hexagon/cfi_tlb.c          |  99 +++++++++++++++
>  tests/tcg/hexagon/cfi_user.c         |  73 +++++++++++
>  tests/tcg/hexagon/check_rev_gating.c |  10 ++
>  tests/tcg/hexagon/invalid-encoding.c |  20 +++
>  tests/tcg/hexagon/trap2.c            |  34 +++++
>  tests/tcg/hexagon/v83_scalar_fp.c    |  98 +++++++++++++++
>  tests/tcg/hexagon/vallocframe.c      | 128 +++++++++++++++++++
>  tests/tcg/hexagon/cfi_tgts.S         | 178 +++++++++++++++++++++++++++
>  tests/tcg/hexagon/meson.build        |  24 +++-
>  11 files changed, 791 insertions(+), 2 deletions(-)
>  create mode 100644 tests/tcg/hexagon/cfi_tgts.h
>  create mode 100644 tests/tcg/hexagon/cfi_tlb.c
>  create mode 100644 tests/tcg/hexagon/cfi_user.c
>  create mode 100644 tests/tcg/hexagon/trap2.c
>  create mode 100644 tests/tcg/hexagon/v83_scalar_fp.c
>  create mode 100644 tests/tcg/hexagon/vallocframe.c
>  create mode 100644 tests/tcg/hexagon/cfi_tgts.S
>

> +static uint32_t read_vsp(void)
> +{
> +    uint32_t value;
> +
> +    asm volatile(".word 0x6a1dc000\n" /* r0 =3D vsp */
> +                 "%0 =3D r0\n"
> +                 : "=3Dr"(value));

The r0 clobber is missing

