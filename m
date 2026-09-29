Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AF8CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 18:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBcH4-0002Sj-Jc; Tue, 29 Sep 2026 14:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xBcH3-0002Sb-4r
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 14:09:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xBcH0-0007IW-8u
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 14:09:52 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TI3Y7m1724005
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 18:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zx0+NBBsL/PMo94m9ZR2SY1PlhwNhZP8WvHvHDV99AI=; b=ev8owSuD3O7YrC/x
 Z/Jo50Iz6AMtPkMoP9ed4iW4makV+4JJAct2qVGHjYi+e7lvDSq71LUGVOUk9qJo
 JWTqmo/ELiDZU/M/g3w8uxMXsI4pTdW4YyTLF45CGqAWn2MxoofEeD2nDs3IZkWM
 S3Y+9sI/rG8CM3/3wUlBVZ/z2KeF1jpfaCSzZbECEOhE/ikCU4SAhsOZqTTV5pSZ
 JDVfd+GIwb1a/YYXrD7sVFqWAIOMCEuYg9buaQr2CncWWmGbwOX0YzHzYzvbn7SF
 RLFzedk0JJF+9KDxkz98jnDe82Uh4iAWzkkLNGUq0IIhbIz+xpYCitqF+lhOMSIw
 rUyHwg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0j97r104-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 18:09:46 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-90c8da50f4fso67213016d6.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 11:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790705386; x=1791310186; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zx0+NBBsL/PMo94m9ZR2SY1PlhwNhZP8WvHvHDV99AI=;
 b=gcBEcn3mIk9aXSnCq8l7DW2ophxWkYtAS+ulfZfrk7qCbz7pbGHjz8CGIqkeQgv57E
 ZbNsiqpbnw4XS+Bv7NQBl/ddXDJVHHfQQ0XBElulSh3egxSQdoJZveIVyqtEj3o8o83b
 qYvSj/lk7MNvirLYTvXpRi8LuSaYSdRWyMmPkc/nY7R63rjOws7+FpNWsleB32btxXFw
 MHpBbqzxwkfUJ06ASZjEBZrATDAn+TnDlOIMomOEhzXV3zXqQDbOgtVTtRLQhNltwdPQ
 QyNAV9Ob8Qpt+3HjvmZtWooSDUKVwWKSrs/wjXE4CwaALj+p7UdCUn4zBSPgZWA0UNaK
 sIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790705386; x=1791310186;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zx0+NBBsL/PMo94m9ZR2SY1PlhwNhZP8WvHvHDV99AI=;
 b=o898UFC7vaYrFacYf+OR5/lDheoGfyfO6xNlDy7+cQx7IJlxSZjoxYir9yNLUmholg
 nkdAH02uQHqtTaY2SI8+pcYA0MKME0UDbeuPJ9q0Jat4h30WvXWgMVlgW4w1QDoCOk+j
 DAE38/eyTqZIjoY47K9zCtGhL8bwJACLlm+qUIrI9DatvXnpbYYAVbuhToSV8m8UHJ8T
 I8NRm+bu475hOBSwVuKZu0TAfCgS/2kSZ3ImdmbSSMqRa1TwrFTz2beOTNWeEH2CeRlN
 2ogbPU7EbwslREyN6UPgi/dCk8fe3NAQ+2ypEPiLw+vIGfvr7VMKecN2lWReNCT1b0C+
 17rA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZRjm6vkbDMSTtei3TnvKSxOmjt8JCPbrp5mU7cWfKqBcKv14w6ssfpfuy9+vqh7/+oPPv1ckFXAVX@nongnu.org
X-Gm-Message-State: AFuF++npdOupe/9oSfxlHqpgqZ6gky+l2osWUsHKLtZ5FTaNa+94d52u
 n+DVFUX7aFZv9eCrYxRPM0TFl1jJVoRk/LQ2AZ1jfaEItYI4JGdyGcFfjn4R8axyc4wRSL1SmQR
 lWWqrxAs3GQAdq237h98xzONKXDQsq3eor5K0aMlBxWfqfdmSk8S3Yrsd6A==
X-Gm-Gg: AYBFou233HWolZodQ5MjHsXkfxEHiif6d3+LOymeNojzPQJSiMocEm7LiZNgFnvMVnB
 E8tgxcbv2Bvb1HqxWOpY0TgGUZAKQr061jZWhlqTS9sRTu7wRVn9ALXfa5n6BdN6EdjhDBr5GLD
 1qcqYnMMWsF+xqgU3an+o2fpWa3Dkf2BGncBmJ+YJAIO2NrbxYUJtmWSBOTz5XgaFxaYsr83Dz3
 MhfmDZrMX71ZsImJTawwWYEN3lCWChx9uCsCZPz+N1PP/u8dwMTy7dxW8pRcIuGW6EmFOfVzi0Q
 zr+4SNQaDKDTiFT9SEQXWbqHRj0SZ6XJFRjBh/rcK0XmayigTJ+Fnmt+lR996tgoNqhpOcCu8GG
 Yy08RLq3bRJxuYv+QoqoiI5UFsB9R1opuLKVki0w2YjTFP9OaJiB1FYzaEKbiCacm8mIyEUnNJY
 xpVFmxBHizH+vwLkoDF7D7M4U=
X-Received: by 2002:a05:6214:5081:b0:915:e8dd:4c02 with SMTP id
 6a1803df08f44-91785e6e975mr67998036d6.23.1790705386292; 
 Tue, 29 Sep 2026 11:09:46 -0700 (PDT)
X-Received: by 2002:a05:6214:5081:b0:915:e8dd:4c02 with SMTP id
 6a1803df08f44-91785e6e975mr67997306d6.23.1790705385744; 
 Tue, 29 Sep 2026 11:09:45 -0700 (PDT)
Received: from [10.222.168.145] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9179895db42sm1075426d6.44.2026.09.29.11.09.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 11:09:45 -0700 (PDT)
Message-ID: <00d46b8b-0ee1-4162-8d4d-51d86d5cc477@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 13:09:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] target/hexagon: add v81 HVX compare, align, and
 convert instructions
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 richard.henderson@linaro.org
References: <20260926192338.2702952-1-brian.cain@oss.qualcomm.com>
 <20260926192338.2702952-4-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
In-Reply-To: <20260926192338.2702952-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Kb3Nembz8NpDY5n02rabM3FaRYrkk5Y3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA3MiBTYWx0ZWRfX7WEkKDOlSHsk
 OT29MX4AzDwm9LDlQaC5imT7qJUgHZScrQn0c9u5/zSCNQZ5ehHTf3rAwWNZATRDkj+Exg/RA7F
 ED/GSefNnEpCq3rdNCrxZoyGegUoSUiIJsvey34/K3gH17pGJURJ8Bxysh7tjmQHlW1m7NnDGL2
 gzqHYgJwj9VNONS/kZ5xv2hkMdJG3u6lCO5y7jobizGtpOqppQOe2neVA221Qn+7ML+wn9JRTDW
 fXsmMI2l5W0eyxuupxvDcMGJlOMn/6acfhq2gRa52a2gRVy53I3mrY3Qvbk2iC8+Ko7TNVO5c16
 Up8P/akEC0+i4jn46GXhiTWDfLng8VFHHjPS5flZbsZkt2eiO6L86TnJUx1rzVvXFIuF6E82fn6
 6lW/xdDmDWmWLewQP0n6UltvS7u+uwod889dXMzCzppUy/a1E6W8uFmM1/WvDIftsO9GBolu+43
 rX+A3uDCNPgp7KA6Zew==
X-Proofpoint-ORIG-GUID: Kb3Nembz8NpDY5n02rabM3FaRYrkk5Y3
X-Authority-Analysis: v=2.4 cv=BPImP1QG c=1 sm=1 tr=0 ts=6abbfeeb cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=MDwpa52Vp4aaXN2mUFEA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA3MiBTYWx0ZWRfX1Qli7jf4uVJP
 QBuJOizJTQRk3+N28/aWg0EFy9mDSBehUsOB+ieKwfY/NGHSoVPvuvXe2mRb2Y/qkrWHQ92ioVh
 5Mq6r3NVAhxvb1ch+8EsGgVYuBXt7XI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290072
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26.09.2026 14:23, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/mmvec/hvx_ieee_fp.h           |  2 +
>   target/hexagon/mmvec/macros.h                |  2 +
>   target/hexagon/mmvec/hvx_ieee_fp.c           | 15 ++++
>   target/hexagon/tag_rev_info.c.inc            | 13 ++++
>   target/hexagon/imported/mmvec/encode_ext.def | 10 +++
>   target/hexagon/imported/mmvec/ext.idef       | 74 ++++++++++++++++++++
>   6 files changed, 116 insertions(+)
> 
> +ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_h_hf_rnd,"Vd32.h=Vu32.hf:rnd",
> +    "Vector conversion of hf16 format to int hw, round to nearest even",
> +    VdV.h[i] = float16_to_int16_scalbn(VuV.hf[i], float_round_nearest_even, 0,
> +                                        &env->hvx_fp_status))
> +
I think there are two issues with vconv_h_hf_rnd. Because it's using 
float16_to_int16_scalbn:

- It hard-codes nearest-even instead of using USR.FPRND.
- It uses generic conversion, which returns INT16_MAX for negative NaNs. 
Hexagon requires INT16_MIN.

