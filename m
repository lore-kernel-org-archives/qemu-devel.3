Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20908606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g9EhfEMy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Whv26kWk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLNqS-0003Np-9q; Mon, 26 Oct 2026 12:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xLNqA-0003LV-Uo
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:46:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xLNq7-00030Q-Jc
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:46:30 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QEvwJm2707734
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vyAJ21mZKfIQu65nd5P2ct7/RouIqd0e2NzPSyCs7AU=; b=g9EhfEMyj8NUroCJ
 z47TfYhITs3lzNe8hWbWUFA5aP2+i9E4y2lFWtWKQm98Ye20ElwVdqmV0Zt2ZMsM
 d7bocyZ0YUeur14kaOc+/W5aFF5TTTX+vgPGo2/l8IkBrNKOvblnWMoeOe+AEHDM
 vzULxKUX9ui7b7fXjAjJ2om2GQkhpPWRoRu+Hcf9qS2wHkr6cPeSQ1po6aw3Cee7
 7kiyrUNLXhifoSdzSkQzgedQi5UbFInnfVMZmlfXKOCm2na1Crf3RnryJDqb7H+t
 SrIoUmm458jXW772KVwax3En9slLxsHt++V775haqyrO7WlIw9kzfVd8RS2Qzb3R
 2i9sPA==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj3u61shf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:46:23 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4b28deb7ee3so5256891b6e.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793033183; cv=none;
 d=google.com; s=arc-20260327;
 b=qKx80UfVsgkNfLCGagpS+rwOfrB/elZeIIbTjq4lf7RljVqCRH0VciarnoXiEdsTCi
 f2XzcSsnbWGDscp2CPLANNpth3uCmbdrru3UX8VOzqpfFdhgemj0w6BA7Ep3wl5GYZfh
 YYU+rObSwAZIWXCfTSNbCjr/0UyapnUjhPtKefiViobJ/LohAi7Zf2Vv1+UciZA3YJgH
 7OSUJJbGm78gTel+M5NgMkXsIDCd/ss9k8TOhxvkG/8q+WD/fKqctghi2ZnkAI77zMSY
 hxjI77wogL5ueWaTtmJqxSpOcHXvh1yzlDKmma0scu5a3rN/C1e2GobEOEePU3MXvq8m
 OP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vyAJ21mZKfIQu65nd5P2ct7/RouIqd0e2NzPSyCs7AU=;
 fh=AvdUgREFPBGnLKtDjjPes0731VMeA8MKp16N55VMDg4=;
 b=Z2yxmkYO1zYdYPcQRo+0Vr/lHTSy4jXEe/KFjdffvlUZs2X+lPvhS2yN8OaMAmUoIZ
 TO/oTBcni+Vaw3kcAwStstvsoA5lkl1NFqvcb3Cf/83Gi/r75x3HxlV6DxB+khgrvJrh
 7hAKtHUXvfAc3Vtbyjj67NAGAAl21fIcoYxM2FvTWJ8egNkEuZDkO1op93+KVk9n/EPK
 lpDfj2YGGM9mDE/Ush8j3Cuq1a4Adm/2aI7RSFnBuluSQXvyGhV28PfqZZ9ArDvm5jKh
 DzQen/8hM/Eb3lALPPfMEqkGIDELSSFLa0tEAVT8Y0FxnYxqWY3iLZgabElsAcdQeZAH
 5tug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793033183; x=1793637983; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vyAJ21mZKfIQu65nd5P2ct7/RouIqd0e2NzPSyCs7AU=;
 b=Whv26kWkHTsAMsUAmqedlIq/zxFRJxMUSpd76e+qKB5TEhhxcghYupjtZexaX0NDlE
 X5/dDl7fRpeiMpc+GEGU3eJ6FVhxF/PS/CyZTkuYXG89uKsZ7byLunFyPqQafHQJDRHJ
 MpN6a3vRIFhE8U6w54eAUE4+IpK59zi/0/0ubj1Ci3mSyalLEgub6XxfXYyFm5x4+ye4
 HuRegyHUv9XfJfKRqZRYEM3SBr6cc9XdlQ/moADafGhfAOdeO3tS+EoPjB0223vF6t5g
 WYPR3sx0Mkfk4p+S2Bg0nwsrfGumRSaP8cUlWutmyKjWbJKUEuLNeP0VoPgITY1Zl0px
 KoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793033183; x=1793637983;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vyAJ21mZKfIQu65nd5P2ct7/RouIqd0e2NzPSyCs7AU=;
 b=JVjq85TIAvJeR6k9pnNQb0U1w1YnW5AhxJwMVdljqpRaFDvrCTatgQXFbuKogvrhOc
 F3On1NNkrY8raisnZT5/y2/kOY4mha42V/p4+Z5JPiWxywNaYhQYi6UfpHEkRHimT4z8
 33eAcqqWA2+OGvgAUHTuDo5ruNnR3vSzyXbylUmhr1Bfsiuo48FkmUSHGPAj0n6k6U0j
 VHQIOlowr25uy3/C/RO4J544ntdU/av+EbZa7ZcYnDNeCntauYb9Q/f851ikdVjU79KJ
 dhKhwiYnJ0b6VpFKkKuWc1xSyjb2USqCuBLZAjfnOF+Lm8WsM7hw9GBdq644uQ2y1t+L
 wXKg==
X-Gm-Message-State: AFq9FYJfUGX0bzr8+gZmeoKOsagZbs6U9MWOEzsiKRDtl9futLxw+SZc
 nwTOGCqjxrv+e4CRQ93gDqNyD/qGe2No5e3ySw4gqDfYmUq+S34I7cxU1Iww4yY8SrlvN5aCESd
 vEThxO+u9pSQAKffi8ilhUHf3JXlxEZ/3iYKc/1l5lzIRFDKoNlxk+6STLvO3bezzR1vO/MHkjY
 /RSv5T1MN0AhRoU7l2TPNSFdCqdmIIusl4
X-Gm-Gg: AYBFou3bFcN70Z/D7wI49rsymdLyNNnVUvebT5k9td/Am/A8A8fJOzsCuNQJ6aEwIrs
 0FgAgjKQJUsWElR5H5T9I7aTYfPz+Q0TIQVn/fS2xKAZfUHU2ksRRw5ai0b7v8FCiH3yi7Albo8
 gv3svhNRiIAksdUDr7cbU0offVAHJrPCH+weWE0GzYcTYbe3f5ZZRNxrPolVffqG2TDWZJ0ck6F
 IHqYdeHw/swk75yfQ==
X-Received: by 2002:a05:6808:3447:b0:557:883b:3f42 with SMTP id
 5614622812f47-55c003640famr4897195b6e.46.1793033182738; 
 Mon, 26 Oct 2026 09:46:22 -0700 (PDT)
X-Received: by 2002:a05:6808:3447:b0:557:883b:3f42 with SMTP id
 5614622812f47-55c003640famr4897174b6e.46.1793033182306; Mon, 26 Oct 2026
 09:46:22 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261024180817.2037169-1-brian.cain@oss.qualcomm.com>
 <20261024180817.2037169-2-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261024180817.2037169-2-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:46:10 -0500
X-Gm-Features: AclHuK8mt0lMCPUJq0PAK6_7fhOg_2FBeObHKn8LbLWZEx54VE-Q37cSphKHD4g
Message-ID: <CAJ+KCYMd3MCmRN=McRQ1jKbMf10hZ-DSXFe6iiLdUiY=TvCOMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] target/hexagon: add v79 HVX vcvt2 instructions
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: ZfRA9ZF9PzLF1lp8bbeDkDAloF4Q-YHT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2NiBTYWx0ZWRfX1pq/W00zhe6r
 twWSIa2J0KjqkvIyUL5EisbPexpdm1iZTL9E9NZ369MEknwEMRy6+lHmP6iUZAXTGFbwDyqZxdX
 klZqmuFPb8AUvTrfAy2AA3tYTvgVKVPqtJ1mf8L+vkCUysv6juKw+oZvL3K71G2VjBeIFQpRUC8
 6et8ZN/z/P1YJxtEBD+TEZQxvROKWJkPN/KEvhE4MVbkZ4G5w8aZr1TjJeEoREfhY9TktfWMi9a
 tXRQdVBSX4BY9rLklRTpqAA5REKD419JxjtSUA1/2CEJQG11iWQQ2/HJhopu95+6LikxBikDrnp
 vpn2zAnUQAgMeFE1OZFMVj6qwLdR5pTL3fARxsyMPzyDFf/RouWMrR9+nu0GrzPauUyHyTgIQNh
 7omboPTg9vFjopRSGhwIEkBNI4Wym+mzMYehLOktzKFImx8+O3mFb6/FNgHgP27k6TqGoXr4mVh
 UZC4w49E4tFZPEygh/w==
X-Proofpoint-ORIG-GUID: ZfRA9ZF9PzLF1lp8bbeDkDAloF4Q-YHT
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6adf83df cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=Q04Eqmf8i0iOwTaXaXsA:9
 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2NiBTYWx0ZWRfX0jokRfwmDw6K
 tmuMe4QFscOGNTz/BMA7BvRu9leHvY6sZQxG7oN+vg6qK18oIoWRIyCFw3icIdJ3TrS7e6eCFoW
 Xnzcaf+awQWZ+FXhvFuFyASQ1goTldU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260066
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On Sat, Oct 24, 2026 at 1:08=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Add V6_vcvt2_{hf_ub,hf_b,ub_hf,b_hf}, which differ from vcvt only in
> element interleaving.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/check_rev_gating.c         |   6 +
>  tests/tcg/hexagon/fp_hvx_v79.c               | 110 +++++++++++++++++++
>  target/hexagon/tag_rev_info.c.inc            |   4 +
>  target/hexagon/imported/mmvec/encode_ext.def |   4 +
>  target/hexagon/imported/mmvec/ext.idef       |  33 ++++++
>  tests/tcg/hexagon/meson.build                |   2 +
>  6 files changed, 159 insertions(+)
>  create mode 100644 tests/tcg/hexagon/fp_hvx_v79.c
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

