Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D316606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C+OLEM8+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K12t83AY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJzZy-0005La-Ds; Thu, 22 Oct 2026 16:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJzZw-0005Kd-RQ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:40:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJzZv-0000Bn-1c
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:40:00 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHHh24086712
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 20:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 418+7rgblxZ++HlKyQ4KqsYEuCx+LH3dgU1jTmP44pM=; b=C+OLEM8+B8cGJ+3z
 06DHycHPDVU1CpHVnacJ0bBOuhWNUcXFNMHGWzL9jAk+rgLbtghzat+IBIMAcMh+
 SPs2XSffLzBQJ84l43spM2nq6SpJgsQ6LRi9tJhjK223zpFRAO4r0krVijak6v5v
 qrq+K7TVPU0/imk4BLk+1E0/4GassQLZqfiBdrl7wObNkcN7jzZwXd45TgriHDTC
 OI5u5ii4pbtZ8yqimr7BBjDniSR5e6UfYFxOP0/KWyNcrmi7HBSO6+rEx9P4Et2O
 ulqQbUzx/Z5bT8h6EwXKOBG0mlrjOmu5Sj/YIgyCT3nd3BcWSJoknAMY5s/TvYpt
 iEzXkg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtrfjm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 20:39:55 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5363fa3d3e4so3072271cf.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 13:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792701595; x=1793306395; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=418+7rgblxZ++HlKyQ4KqsYEuCx+LH3dgU1jTmP44pM=;
 b=K12t83AYFywYT/9Wogyp066tGS3ocx1O275Dm99mXr1JTlP+HV9wCtS2xytfyHANpM
 5Bmdr139kDfGQVgb91/9rVIKsOsM5TGD8L5gZgMkBzpl0V9pANcKbW/qQOWI3fkJGOIq
 oRHU2B1o76UK1sfG12fqauwrUpQ8uSwjrlX3BahI5HTDgdYxgMZs5PRcaGxmkYJ94wn1
 CLUqJVP9ESs5gB/0nmSVROsWWVaCm4pskZixnWOrLKrLqhnYIs4q3LSK7Mt3z2jdEawp
 Pk1pv9gwH+npaeHqngFFr/fWazgvY4pO6S7AEC6bAQNeALDNv8Afb+Nai1aQQaz3cW+S
 vVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792701595; x=1793306395;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=418+7rgblxZ++HlKyQ4KqsYEuCx+LH3dgU1jTmP44pM=;
 b=OhLw4yULmkaBCj+PKhrLUnpqXGYlgejE8at2wsicMI88N66I8iCljBJMuqXRXVaBm6
 UlSJ49XC4CZeguAyYfZh+7siCqm+/CIJizrxIp+bk6TKQhDc7XolNk4OCqhyfnEzgi55
 eePv9W3ELgbovkeGSgRxSWPaAbwdMGsNnnwSgUxgb6fsXeIEh00CODppYU07wdDot/Mm
 /5SOWYmbDwnKpOejjhlUeutYYfc7rY6zsc0L1thpWwwZSZYKa+SBfCr/UND10IhM2d0Z
 Ygpd2j3o0icwxbQUTBit5qjwDdIsOJsYs3Es/w0x73NitOc3fa8O2QzkqicJPOpobXby
 kL7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+Cl0Xe8JjToUwD34xuMOqxnLJLrETBloL0hhvs2mHaJpqJTkJvrPaY65WhKqbeMAx1vUIT05+kj8C@nongnu.org
X-Gm-Message-State: AFq9FYLxmVQPNRGb2YH9u6ES0fb7L6YpgOUlupI946jxz+lQJze3NABT
 F2TXj79almkPLroQ/MxyQveWLyR04Szf3nfyVOpZmEw86hr1Yt3tNToi3llG5bW6HlbYpF/YzZ2
 GhUyz3bBx11+xoy4529ciXdDAxe/kYH2OH1aszFYuoHPU7QOLzzekrcuudg==
X-Gm-Gg: AYBFou2AjVVv2CPcdAEK8R2oWlomnW4tljgRQCNx+KGHUeSWBZ84hxsay1Mpaa2hWC6
 kZ/IB4ijbbUJL4KANB0TtiKr71Z9YPlf6fMpPp9z1XwIPgU60vKbM/7vILL28Dpl18Qk2l5rJyz
 VjfU/iRLO74JDD5EBC3P/aVsJ7apjkQW0e18aLSp18gZTggaWGNA9BaZdTQe/GyoKS1WuenA3ox
 qIsN90k6z7ZcLUTPXCJhwR8AuAbEui5CrQLKMmOd69nnNt9DPNJdBYF9saUsqmLSr3MCi+7t2op
 MANK+v4kWQp53nLXgAIlORHfOStDwgTy5bOdl0FtB9Vyk0QvnoIuvj8m/1cgeAYHw/vJSiwx1KT
 8Yj20FOmFbRB7ra//uuvrhi0r4pXKg7K3s+mG
X-Received: by 2002:a05:622a:22a2:b0:536:98da:f790 with SMTP id
 d75a77b69052e-536c2695f53mr726891cf.6.1792701594719; 
 Thu, 22 Oct 2026 13:39:54 -0700 (PDT)
X-Received: by 2002:a05:622a:22a2:b0:536:98da:f790 with SMTP id
 d75a77b69052e-536c2695f53mr726451cf.6.1792701594096; 
 Thu, 22 Oct 2026 13:39:54 -0700 (PDT)
Received: from [192.168.68.100] ([152.234.125.162])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536c17b32cfsm1834291cf.6.2026.10.22.13.39.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 13:39:53 -0700 (PDT)
Message-ID: <6cbd401e-54c5-4ef8-be97-900af8cc0764@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 17:39:49 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Use 1ULL for a value we're going to shift
 by 63
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20261022201037.764619-1-peter.maydell@linaro.org>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261022201037.764619-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6ada749b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=AgQEunjic7gIBKSbIeB6Ag==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ovYhUq7p_jiGD7MGxLgA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: FpaTtnz1Q3-O28jhqvXldkyaiIOBy2ds
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4MiBTYWx0ZWRfX9/O94G8pnQvJ
 qAIR85PyAzJrUwLHVP+OuoXT/tvTl9LqKQDTwfa6CjIQ0FhieBP6tchtgPFMoHFT+DuwUG7+GYO
 xnh0/feTefD4LHN+9fKJQME896jA/kLEQIpTcawNpQwTbnlUrRvX1I8l98hEj5jfGN6FvBmXfIZ
 VZpEaWUf5Gg39++mQEW1J098RmyAmg1zlxFn4mh1VMdK+cM47cSvyNCJeqqilXZZS3TRoTXz6fa
 QjlVITlHBFvm+OQHCOiozkOK/YWMw4xzW5364GzZaWwnEhTzurtPibed3UiGoRql2ooEVEYlFP9
 BfEt6GoAKwaQX0T5BaYD74+++NAFpyGKrDK2oZPGSdkKkvkFiKiIB2Z/0bnQpvSVOUQ8puvYoLu
 yrksrIVmHKVyITQEORoj8jOp8IfsJwThS5XENCuG3SHODyBomZmE/fXFuMVnBkFpL2QrizfKQjo
 V911tPajK0haaWiNOHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4MiBTYWx0ZWRfX9DxgKtOC1i/8
 uMNXEKG5B12JciJS90Ycw15PbEgAQ5DG2sxu/L/zSXolTS93gY6C6SPFKl+0gQ3EDhBlvT9xq7D
 QOiCkj8B5xxaU661ZxApGhlgAeS3wBk=
X-Proofpoint-ORIG-GUID: FpaTtnz1Q3-O28jhqvXldkyaiIOBy2ds
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220082
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 10/22/2026 5:10 PM, Peter Maydell wrote:
> In prop_marchid_set() we set mxlen to either 32 or 64, and then
> calculate
>   invalid_val = 1LL << (mxlen - 1);
> 
> which shifts the signed value 1LL up into its sign bit when mxlen is
> 64, which Coverity complains about.
> 
> This is not UB for QEMU because we use -fwrapv, but it makes more
> sense to use an explicitly unsigned 1ULL here when we clearly want to
> be treating it as an unsigned value and the 'invalid_val' variable is
> of type uint64_t.
> 
> Resolves: Coverity CID 1547552
> Fixes: d6a427e2c0b24 ("target/riscv/cpu.c: restrict 'marchid' value")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 08a4d14ea1f..d47a69bea7d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2298,7 +2298,7 @@ static void prop_marchid_set(Object *obj, Visitor *v, const char *name,
>           g_assert_not_reached();
>       }
>   
> -    invalid_val = 1LL << (mxlen - 1);
> +    invalid_val = 1ULL << (mxlen - 1);
>   
>       if (value == invalid_val) {
>           error_setg(errp, "Unable to set marchid with MSB (%u) bit set "


