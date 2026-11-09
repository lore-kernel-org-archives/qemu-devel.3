Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985FB606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pL+bqXvQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KzqfnGCu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQWD8-0005wX-TT; Mon, 09 Nov 2026 15:43:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQWD6-0005u0-CK
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:43:24 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQWD4-0000b9-O5
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:43:24 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HHHmh899586
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 20:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vFsUNxzBgfxBRBMaTjPwOSduz2I1bYUHLab8PMl/5r0=; b=pL+bqXvQE/77n8FW
 mKtJsXtkDILeWLz2L7YNPG0dj4h4v7exKvoOV4bFL2RBOItz9JaKPI50UwU6Wx43
 989t54eM2aPhFHIanzosyaR/eoR4FH/14e25EXvrKG46U0A8MGSKjTlQuG/Mq1SI
 QkPMQJWtFUfJGk5YID7Jp11HsmJaX6k4AhyzihIylXUId0WIY62a/UVkxeqvgblo
 FdJYeAryhiqjaNFsh945UDcCGB/AAjODh5vtswE6+CXZBdS0FwEHL2MA6ch2XMgM
 dWWTCOlOgLRD53LNoSS+OcE47962QyVYUAk3gvOw6X5KXJwBk17aYRTlICPPMSYr
 HQp83A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2kfsm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 20:43:21 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5337ed1ba44so27461641cf.3
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794257001; x=1794861801; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vFsUNxzBgfxBRBMaTjPwOSduz2I1bYUHLab8PMl/5r0=;
 b=KzqfnGCuIdWtxX7yYpoOfqq4DaAFECza/CLJU5mEezRbCYW6QIiEVsIsaqEb++3NlW
 zfvntzFZ4KKlMNesWpj/f8HXhl8ColC/wAkFxCYWzQv+8g5hV5yTDNQGWwz1TJlvg1ld
 bbAV7K6UzlkWhcfLr1PNC2rC0kUHqjAn/f3WnupBFHLD7XQdGpburUMXg+x3YGqncLxC
 E4uugfeRVyV9ZPsn30h3hGFEn3ugexa7k58EgoKTCDP925FAH0oWJGqIoSijM8sD6lFn
 IeUpRzlv+8iXeGOmXyffto/31OLQ7mwXfs/59fGm7qmhhBIAkxFnWoiKuKaOALXKqjHs
 eFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794257001; x=1794861801;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vFsUNxzBgfxBRBMaTjPwOSduz2I1bYUHLab8PMl/5r0=;
 b=tLMgZRP2nd4BejJyrmfYLYFoA/JNzCSiiWmtC/2w7ZfzJsU9kJympqNCYWXgMafaRj
 slS4627X6Uv8IOm89bpfPNxfcz95XAKDDpHQt4NhKCDk8wi5THV5avzcLeAhxVjMw3PP
 gAPZV3A7HjOplOQPWeGCwJOkKTBQdIy8Ve1kEl2cOasNytjQvbammCmHv31MNCSsxNdx
 P0BqJFnpFsHy2jP5OUAdaO2mA7jnBBvxG7NJ6OFOloX4rpouEVGYww2tsyxMnd6ociP2
 lsAITiCblRJsfIbrDJPryFok2ootOSlb2KObvmtZ1p9OGVfz5DZqE9oH++1Qy1bbNP4K
 YmZg==
X-Forwarded-Encrypted: i=1;
 AL+hErHMwBTlAgf8fpnLu8cmPfs1xwqXqa4zJ5pLHj0rbQ+CDXooL81j+wpVe0bn2+OQ/Qndw5Y0jWH3KILA@nongnu.org
X-Gm-Message-State: APuU4Z9q+Y61TTiohZWdWUSgGEmIFXhP1cmKSAAlqqqF40wbS5bdlCXQ
 1hsjsoFQvJMeiaO0heHGI0GQ801rlMEbSg6/BK1cvNeTBT866u1I4+fn+/broKuHy9JAaAo7mei
 lhlAlk2Nv0lvaRu/iZ0AgnYL55SQAarveil+TF0w4ApXHhbfXcewa3iFv6A==
X-Gm-Gg: AYBFou1LptQbIt+7JhAzAElKVpxtPpoaTQ4c5nTsYpNrFfj9EXs4YsxEwgNJGrsa+2o
 nGDGFo7x7XFN7/QVpJ5/ZURMSsh/8Vf8jF9nTrN10/LlVfErn1DlBYiLsBwec83yYo9OdhEfmgI
 COY0z0N7AsRyYlflwTVtCZ8lPcJ9sks+MrR3Er0zVlHQtIlBfDArAI2uQnnzdILChheIVk3kAwf
 UVYDB8Dy3bW+RlFuRuoezEbQA3K/tlP3IHOSXhVkoXxgSwJ/YT+fJHbucyIiTDJkgSWDmKE6Wb5
 iwelu0jI3SeMtULl2GMaZ7u4F9y3n9CdjonR4KEURBRSpP0M98KqhOLifohEmTCACPSdBPlS+As
 WsJJ7GROVOurEPNvDZQm2ySUPuv/7OwaQSL0ZIKy3N3jXsQPNznapzR6zmtbgEuelKvEzzvZZD/
 ogfUB2W6kM
X-Received: by 2002:ac8:5707:0:b0:535:2521:f07c with SMTP id
 d75a77b69052e-5552609b143mr9029581cf.7.1794257000771; 
 Mon, 09 Nov 2026 12:43:20 -0800 (PST)
X-Received: by 2002:ac8:5707:0:b0:535:2521:f07c with SMTP id
 d75a77b69052e-5552609b143mr9029251cf.7.1794257000319; 
 Mon, 09 Nov 2026 12:43:20 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5550b44e6fcsm6294551cf.10.2026.11.09.12.43.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 12:43:19 -0800 (PST)
Message-ID: <8510dcd7-3955-49d0-8975-b3afc6520750@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:43:16 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 37/38] disas/riscv: Support Zvfbdota32f extension
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
 <20261104194155.679241-38-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-38-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af23069 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=YyB5S3pvMjFU-qa_WgEA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4MiBTYWx0ZWRfX59fsZyRUVhqE
 0A+IHcCzbYBMVJ9q0g4NwXUcAXk6UPXs68wp13FkbulKIGDu0OmgztAuxfA98bS1xRKycRxN6Je
 pyQ/YeSJjX6+BzGv2lqlGgi73nou6qhm1F7VYFPDMl3niuJVY4J7fwzmbQXX0mLsX7UCxonPjv/
 VunvtvEzbxITF9CSGeSlkI7cnK70DssNM5VDDuzOKgE4pz7vMDA11dpmK800jFUWK2HaYa0+aIk
 +oMwuwY/onOOxgAmZe3ZcfS36nw3yxMTV/1BSKGAtBo7WAR25Z0oZzAaplNwx2bcVP0wzLevtzB
 Y3imnFHPtXVVnXcuCyUVEst1B9bk1LasQ/MV/R527i86x2iszxHZdGp2RH/bAnxE12rboRldK3c
 hNNEog5tjEbmJyCOvaIDCqvXxmWcRDTITn0fUUnGl+3U78G9ieLhokZCS+4I+NJgsqECaKLwN4y
 DngHXY2Ho3pk/Jdqedw==
X-Proofpoint-GUID: 223CLwbo0Qq46M2BucdVMkHBHJl40AaX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4MiBTYWx0ZWRfX9H5mKnW7jpnf
 sgK1fqTnCVxUpcJmDBRQ+noSX8GYeyIwKBIlmaLnF2v7vUvwT3krZ8biK+BqXytVHzuG5ziRSha
 E0L6OVKyuu6z2HtmbuugMPbHj0+srUY=
X-Proofpoint-ORIG-GUID: 223CLwbo0Qq46M2BucdVMkHBHJl40AaX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/2026 4:41 PM, Max Chou wrote:
> Adds support to disassemble Zvfbdota32f instructions.
> - vfbdota.vv
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   disas/riscv-op.c.inc | 1 +
>   disas/riscv.c        | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
> index 58f6ddac35a..779fc26a27c 100644
> --- a/disas/riscv-op.c.inc
> +++ b/disas/riscv-op.c.inc
> @@ -538,6 +538,7 @@ OP(vdivu_vv, "vdivu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>   OP(vdivu_vx, "vdivu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>   OP(vfadd_vf, "vfadd.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
>   OP(vfadd_vv, "vfadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vfbdota_vv, "vfbdota.vv", rv_codec_v_r_ci, rv_fmt_vd_vs2_vs1_ci_vm)
>   OP(vfclass_v, "vfclass.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
>   OP(vfcvt_f_x_v, "vfcvt.f.x.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
>   OP(vfcvt_f_xu_v, "vfcvt.f.xu.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> diff --git a/disas/riscv.c b/disas/riscv.c
> index a124cbb4bbe..8330ba34a30 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2647,6 +2647,7 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                   case 36: return &op_vfwdota_vv;
>                   case 38: return &op_vfqwdota_vv;
>                   case 39: return &op_vfqwdota_alt_vv;
> +                case 43: return &op_vfbdota_vv;
>                   case 44: return &op_vfwbdota_vv;
>                   case 46: return &op_vfqwbdota_vv;
>                   case 47: return &op_vfqwbdota_alt_vv;


