Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA603606A320
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BdLpYBx2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GW4oIFUc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIuxE-0001me-Ej; Mon, 19 Oct 2026 17:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIuxC-0001mF-S8
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:31:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIuxB-0006ro-5r
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:31:34 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJK1UA3627888
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Rrvuh0hRskV2B1TNymmN2TKyxkO3drFsj/VFFySVLAM=; b=BdLpYBx2WImvG3y5
 hKxhwKkoqF9FL+gV9oSKhEuv/JV8/y1UBdByktugfstFKTi/chjs1iSVhS3Jmzyh
 cuHRFv98NfscpXPW4NcrhO/Qmzm0RsIzO2ndHQVxhK29Uk4ZClPDOPGOQOcW5tw1
 lPAvS/jVrEit2fzz4M/SAdnSAXS77mzaUt6g9W2kuCla+VE6Fg3gnIkAdZQKEM04
 YA+MDA2bLwQjbf7lDVrepUVdy9x8/ZFMEgT1S4h240fu/51S7I9VfAEczKlZ0RwY
 LdfaqfoxJRS/kocAqdGk/ZGugZ0brCsIcaNS3HeYx5euG1qTJndujcserjYMSOE8
 lWHguA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr42gqvs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:31:31 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33713e5e6daso3773334eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445491; x=1793050291; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Rrvuh0hRskV2B1TNymmN2TKyxkO3drFsj/VFFySVLAM=;
 b=GW4oIFUcj55xUyUE0AsJ8qNNOiqMCVoSbWEtv0QRFpqlx0en3BJ+suxmt8LOiDpDHy
 DRs0qAHz5xwkzkhH22ACpaywEMdlCVuLavIpZKf2C7Y9CDrvHf4dp1a2YtzJ9MVK4SNe
 RXqpRoVYxgfKXD8RYbVQvb+OQUeWl9uOhHZ4EgwqIU/OWjRkpKkY163jP5znE2D7h2TA
 ww9XrkR1q+3qddVrmtg1CcL1KuhSOjKaLfWZ1iZWDdzwQu0dm04KFl/TiGyjWtVyONFk
 h5CqC1z2UjsZC4JA1uwcceukuxEvKtZX761c+UGQdaiCfyxryCEM5WSrI7yyaCS1JwgG
 pfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445491; x=1793050291;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rrvuh0hRskV2B1TNymmN2TKyxkO3drFsj/VFFySVLAM=;
 b=hUPHEy8sABVtdqmKqOI0y0G8vitRp2BmJBSw6nEVDWPOyLhNUTqQNYcizyYmfYZOWm
 bLJwOnZoEjjmXlV1nfIpMd+KyxU6VQIDWcpsHeZsPJN0PWk0Xo/LDDerFOeSSrQk/nSb
 Zx0DzHrBJEJb05TuVuWbjtVY5OpA4XWlJAB67UcinWSeSHETiWsBFhYVK1B74nQBX9hM
 vWpkCU5OxH0vFnKrO+YtY4oEYCMNtNJ+SoxZmxfigE7Auf9AautmsWphd01jP8sGIQLf
 un1+owY/8poRlMqyem9rwfmczDAzFAt3kLjHfsfg4Hv6ZF/vmW3zbMliU3venD6ov2cd
 scNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByvmdZUbkBseAWlOtAm1MoChlxYa2xY1cp0mdfuDxqwidtqjpnkm5ZQ1Xo42F+CZgCZySiPHeLWmU4/@nongnu.org
X-Gm-Message-State: AFq9FYKqbZmwnmM4bdQat5xql5H1oSAV/nIsACNESz3L9UruTfbo4gKX
 9bUeXu8Hj4gIZB7+9O6i71TTqWzW1WrWNVnGuI/FetnVBSaaJdQkv0xHY5DlN2SRYPPaQyc6r3W
 gPcw+0YFKRTnONGq9CsXaFcRjcz/CCE86BzmrDS55Cbs3PdaZ1D5CtaFbvQ==
X-Gm-Gg: AYBFou0+3RqnPOh/6v2uRYCcrwRwYFUNoB6biluQZWI0FMppHQBaYSgmcKLDc9BZzw3
 uy2nZWqYoJT0/RgH68jsHFx/z3uiK8jdikCj/O5Uo0uixKKNNtT3X4DETvL3TayidOBExNQx50d
 yJJAYTXyNo4RPpaDcBGzlcDp9ZK5Dwj8RAbRqJPSxoR+dK7iL/+qonMjsv72jEbNg5AHRRu5D3d
 wvfkvVa5u2nk491xIhSSy+ACEGXquqfTJ34BH+hFad9dFTrvVxiB1z1WaxsGbEAT5KjAejqqD+T
 UdjOgj/40rGZSNdmrtwFwVekPa3rSvZjx8lYwS0eSLakw0I5P3JyVBEe6hRcbzaoyVoF04BkGVR
 T5mArc4Rwrw5rspIS4vwPXtA4VkVTlYY9TMNNvMHOKrg5gUpQvJ/Z7hNHl+9fYuuUmRnuJQ==
X-Received: by 2002:a05:7022:e88a:b0:154:dc96:c1d8 with SMTP id
 a92af1059eb24-1850c9cf54emr13677965c88.2.1792445490692; 
 Mon, 19 Oct 2026 14:31:30 -0700 (PDT)
X-Received: by 2002:a05:7022:e88a:b0:154:dc96:c1d8 with SMTP id
 a92af1059eb24-1850c9cf54emr13677931c88.2.1792445490037; 
 Mon, 19 Oct 2026 14:31:30 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1830f213ba7sm36507141c88.0.2026.10.19.14.31.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 14:31:29 -0700 (PDT)
Message-ID: <88dd9e79-0802-4365-9755-b47be7723a20@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:31:28 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] target/hexagon: add v83 trap2 and vector stack
 instructions
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Helge Deller <deller@gmx.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>
References: <20261019172603.2625677-1-brian.cain@oss.qualcomm.com>
 <20261019172603.2625677-7-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019172603.2625677-7-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX+h4kYSsuTwji
 WsJQ0KdhoCr/FJa9UxT7NyvZ9fID6XEcbpI17eWwED3ykSm87MW7ksYVxmEhwLNrEN60Ai9z7Va
 VEdWrCNokPznvKXDs2dy7AMqkvf13dgVLLTsAKoomkhFFa/ftE7W7d6XMgCnSKCnbbK5IyETOva
 lIAElJxy6jJWtUWTqxmtDoXEmFguAyDksSMbcuq/KIkGvLMCPQk7AzV+MqpPqQCTB7gB9Reg0G8
 eUkT+2TJsxpGOFzGnpfEQjsGCJ13ExieH9ZnK5Fgl4DoZhKONObWUKOvIdJiOk7SjSmnx2XDRgl
 64ZgDzECQgTj/FmJ4ocWoZ+sgQVtYcYEx1Ziau4m/pUL9GYhKYjwxwxicYhGefCdKFOAcKWK8Mk
 iuxDIQg06bsctmpwJmVjPOVfHNAWaZf2iX4JNPUqUiA7jhK+FmpFbomPR2mMHnPAXD2D2vE8fba
 KWm6sfgJzuBkgPLrIzw==
X-Authority-Analysis: v=2.4 cv=Ve9ir1p9 c=1 sm=1 tr=0 ts=6ad68c33 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=5xtm8qgpkIS5Le6_e4IA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX0TNLH/WAXku6
 6B28LZ4w+ubxOOSiSUsJtntAW3+F/poFXZLbxknUYd/R0LE/MAVLDhpZRwerbdsLVhrg5ADDuN5
 euEtCYNlhdSNyAKmtQf0tVFn8RCqCPo=
X-Proofpoint-ORIG-GUID: VaKwqDQubTsXsIKtfIH0ABsV3TVPHlu8
X-Proofpoint-GUID: VaKwqDQubTsXsIKtfIH0ABsV3TVPHlu8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190085
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/2026 10:25 AM, Brian Cain wrote:
> Add decode and translation for trap2 and the vallocframe and vdeallocframe instruction forms introduced with v83. Model vector stack overflow as a precise exception and report it to linux-user as SIGSEGV.
> 
> Teach the IDEF parser about VSP and vector frame checks. Describe the vallocframe and vdeallocframe instruction semantics in system.idef, and move the vector stack overflow check into a shared TCG generator helper.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Not a problem in itself, but reviewed-by tag is duplicated.

> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_bits.h                   |  1 +
>  target/hexagon/gen_tcg.h                    | 51 +++++++++++++++++++++
>  target/hexagon/genptr.h                     |  1 +
>  target/hexagon/hex_regs.h                   |  2 +
>  target/hexagon/idef-parser/parser-helpers.h |  1 +
>  target/hexagon/translate.h                  |  1 +
>  linux-user/hexagon/cpu_loop.c               |  4 ++
>  target/hexagon/cpu.c                        |  2 +-
>  target/hexagon/genptr.c                     | 21 +++++++++
>  target/hexagon/hexswi.c                     |  5 ++
>  target/hexagon/idef-parser/parser-helpers.c | 14 ++++++
>  target/hexagon/translate.c                  |  2 +-
>  target/hexagon/tag_rev_info.c.inc           | 10 ++++
>  target/hexagon/gen_idef_parser_funcs.py     |  2 +-
>  target/hexagon/idef-parser/idef-parser.lex  |  8 ++++
>  target/hexagon/idef-parser/idef-parser.y    |  9 +++-
>  target/hexagon/imported/encode_pp.def       |  5 ++
>  target/hexagon/imported/system.idef         |  8 ++++
>  18 files changed, 143 insertions(+), 4 deletions(-)
>

