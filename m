Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A71606A327
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yxkr5AvY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I/b7yRQp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMARj-0007FZ-7y; Wed, 28 Oct 2026 16:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMARd-0007Cj-R1
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:40:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMARb-0004eP-2Z
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:40:24 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIjQl31443139
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lfm29UFOCvEO/TwqvxDo1Lo1rqti8WHEyvanP9uYlJw=; b=Yxkr5AvYskFWnEAO
 NMgJoUslng+gMYjQFvhcbCwtsIs7ZZuh0s9BKywuxrmMvADQcEUs2KXAoBHJ4hMq
 uBvX/vkJboL0FJa/t+3y+8Qa/e9uA4qOYWHB2dPU7NgmHwGBCYnRgoM/IskCFDg8
 P8HGt70pR/NJ8HK1Jro0QYpTI6ogA1WxGlmcTL2pq5WvQy5pXu8poj/Sst0Ks8/M
 GdYqKD3BuPyfhcU3pgo6CM+oOz8sk90/tmfMWX2Lw20PovcIh5udRg5M9TmK0eTd
 LdeMUHshOY5XRMvZ9+avmwd60fZBc3Mt5HGDDSrb0uiY1xbZswf8aslMznDwUvVF
 4MVaAg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkhtjhw0b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:40:21 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35cbea41088so1892563eec.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793220021; x=1793824821; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lfm29UFOCvEO/TwqvxDo1Lo1rqti8WHEyvanP9uYlJw=;
 b=I/b7yRQp5pljme1FvZc1/dY/O0Jq7MQcrGGDyo5ox3TNcJ1QmhfBaaS4apcpPV+ynN
 HwQ+jwro9xd4Jt1Y10QTx+qMqFFgddEVtKsehl+2YLOpNERre49BXWS8p7Ga8YAp+Z/8
 57PTf12HBROoNKv07NE7mtFUe+0Uzzcxn+co2d/+RynyHKjFlPIw9vMEXYEHXP+w0w9A
 0/bDc4kJedeQxSuij1UFUvPJlQo2NE3ROfhiItVOsUVxFv7FWmNKataXYLcN41gWwBRF
 nR4QnrkpsNrHmQCjjm/dChKjzJW3QqM+qaC0u/H5ljxmBrMoHyjOJjSdxBn1gdxxuhZk
 urtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793220021; x=1793824821;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lfm29UFOCvEO/TwqvxDo1Lo1rqti8WHEyvanP9uYlJw=;
 b=A4nIzB13Xaaoeqx2mPZKnUVrR7rFVxJOagwX7dv1+iViba4XFH/hJwOxMZvtPHDdsc
 /Fpb5j0Nfyx6sTlTmr7LPlFcOac1cBF0t7H00KXMumIQApxNQQOBqL5QgXiv49SMk3X7
 vhwsSECXifKsbX4/6nR4/1DHvv5KQQRjh0E6vFnSEPiCpNAsADXEjOVWScjsm4arjl0R
 qqRJ9eEVgJ8Fd9Aq9vNSIBJh5MUUF9kFdBsdziVJFAv3uOT694hhQEqEekS7gINaxZf2
 KQHRTU7GXu5hm51TlfyCieqHe4Cx2+ES8pY+fvhqbnE4yTdEEtiJ6tpBrq0gMZitRxVW
 WldQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKNjF/ROTILoFWVV8gvcMagOO+Pbq9NCZamj4C+QqS0ppLy94ChaORt0lAHt/siuLZPc8+sSXmZpgy@nongnu.org
X-Gm-Message-State: AFq9FYIrMOcD4vuWf0NhdYdivZMoVBBw+eJVD4pGxaSz1WXu3H/RpePI
 9+1vaTiHlGVFvti/R0/KhL7vIlI1rPQdRd3gDIXMKkk5Uq+1FMvMJeDh498iv0gwFJkedlDSdxH
 szy9EKQAlEzr++U2xewzKGVeWK5jP/1WvtKXuw4iU4LC2jUhr2JaPr9yewQ==
X-Gm-Gg: AYBFou22FNh1QkZCgPKvEkcvJfPFSKnkYr/5qXT/Zu//K24EHhRsfx/vG4POA8i6Odd
 2z/ZjBekMn3EK4m40cVbt3pzRI19LUTatKS93JUhbtwkAOhsvd23fiEDiaV5mPHy54KuUDNdk9l
 4AMXqz4Ozdx8jEJP4YagKeufw3YgDJjYDyTYlfGaClsmsSctfSxGw1xL/etFriSNFZGmTMpJ26L
 TZsgt3AWqWjcVW4Smhr/iyc2kjkYigF2YPrrn7eQ0aJip8mFvrVbjE+FVQbrYN3UnbzTLLrkWyd
 HroiBHEHo2ERRUDU0QH9pJvoq7QfBGkjx2AIQY7WIhT/SabflR+3mlhdLSVUti7dNqzUnM648fK
 HIAn7BTbaD8BTh80ZwhzVRVEo+ZjXBtehguVTTqRn62S7kw14aKQ9aQsw81EFulTCVpvqVIOc/5
 NZ7Y76fF4WY8qMVG3NSCi8Ig3r4PRthwKBp073RPbSR1U=
X-Received: by 2002:a05:7300:a95:b0:34d:7ae5:8d78 with SMTP id
 5a478bee46e88-36a200febf0mr4273627eec.31.1793220020708; 
 Wed, 28 Oct 2026 13:40:20 -0700 (PDT)
X-Received: by 2002:a05:7300:a95:b0:34d:7ae5:8d78 with SMTP id
 5a478bee46e88-36a200febf0mr4273590eec.31.1793220020185; 
 Wed, 28 Oct 2026 13:40:20 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a2399b05dsm9330969eec.25.2026.10.28.13.40.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 13:40:19 -0700 (PDT)
Message-ID: <29e3a9ba-0513-4f2b-817d-b92921bb5d7d@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 12:40:19 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] target/mips: Factor mips_gdb_read_value() out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
 <20261028192538.31600-7-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028192538.31600-7-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX3BxYJiPqDwiU
 PWlqwk2CHv7MRqOR6BeoI+ptZO/7EaZjos+qiP2nNptCGMpH951C7l68aBSH8ua24UFRxEGPZxi
 6yL1EIt76xsauqX6RATAPIwyDcVWYmMRE+I3Bf2ByNOqOP56Pk+vJ7hQ7r0GFF0+x12ZsYj44A/
 h8g0/tovBdOJCiVHPpkHWcDmSX0JLsM8cQbxHmxmZdmtPKh5VNfQr0pG1Gl61X3nnoP2+jrscf0
 RVOMT2d0n7wfDwo5iq37H5EX2HNmnesv59/XOJEDL768ZzPd4DuI1V2RrxYP4OtC6/xgO362MoO
 x2tMAf3WALs2rNIFceEPMErgENH71GNO0qEk73ug15R+dmPCar08n2pLbwyA31w+2PNTxzI+iSR
 EgGemryI5rBTKpM/9KuGpBAixlDMCWQMQ0UcwaH24BP/t+OKgSHrsxGcm0CjRi7EOUQTc6S8BjR
 qqsDZV7j3l6u+aEfZpg==
X-Proofpoint-GUID: Yibt1x7nedtEumENiajLVdt_ZV_rns84
X-Proofpoint-ORIG-GUID: Yibt1x7nedtEumENiajLVdt_ZV_rns84
X-Authority-Analysis: v=2.4 cv=LdipeTfi c=1 sm=1 tr=0 ts=6ae25db5 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=fCYGJDBpQf17Zcv0PRoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX/X1pXJJ+VLF5
 pQVZ9iIV4zO332ilo10KofX4vWYWX1T2uyDNSBbL8AKUp0w09F/7KU+WiMOVPdAebP7trLhucdS
 +LGNsiYJH6dgHZ3d2d6wcB8qHuFB4Zk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280082
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

On 10/28/2026 11:25 AM, Philippe Mathieu-Daudé wrote:
> Factor mips_gdb_read_value() out of mips_cpu_gdb_read_register()
> for re-use in the next commit. No functional change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/mips/gdbstub.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

