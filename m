Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25212C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Y9u-00035G-Ky; Mon, 07 Sep 2026 08:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3Y9p-00034a-GA
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 08:09:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3Y9n-0006TM-Qu
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 08:09:05 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687AnAMC4064255
 for <qemu-devel@nongnu.org>; Mon, 7 Sep 2026 12:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0jHtTGREXemZU/LhEz9hMJ4+IdOhXCA4mOuFJdnUzjc=; b=isBhDLoq2JkA8RQQ
 R5EYSRrFPLOBn/xyEEo9tD3m47zUtJ3N5mnd5RWwJaHiWqDU8DE5xT4LVfRBaHzX
 Hd1JqQUlxCR7BDLD8T7uAtwp2988IRaCpa1wG6HSamwYJ8yZgaWlgMCxJ7sOjL28
 PBucnbkeA9usAJc4YV290a9KxLclksawlqumvPTcOQtDjlP3xr8r68vcjxycWbWg
 M1LlOnu5zPdHe5jCf6QGaJaySA/D4DNqFoGIuyKVSvrHI8yvRriJL0G+iOqhIqzq
 5sgvC4hvylstk1hzF5FYbtEzabEx6nKpxjJpgvpNFU8hw7oT2pDxhYp9n4Z9fLIM
 5XVdIA==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghs86s3yr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 12:09:01 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-8461ade272bso42440947b3.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 05:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788782941; x=1789387741; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0jHtTGREXemZU/LhEz9hMJ4+IdOhXCA4mOuFJdnUzjc=;
 b=Ves5yKHDNBI7TU9YNwwMDOM/dzt6sVJMUpP7FGFqHuDwaKlNxz5u/tatf2vZmwcZQD
 MU7pRbotjmkJ9ls+DCqnT5YQigU7PhyinAMEiBPp1Af8rIIbQqL1FXdT0XTj27jPT/lO
 60uRVIjtCgOLeG7VkUTOVV4FU8eixyhDcVBdJUKmjswBYuWJZoRkVP6yTOGtwjCOqWLT
 PEywluTjCKJm/vQt2BcMt9UFbej3uXb+6ONqlDsPICUIokzAibm99PvESAXW/SYbmqnQ
 KEr4qWOsaI5e3rncA9RD4WsibvjrOhFJsWFmZkAtHO+gWX6BkkMO8nn0wECqWaht7w38
 u/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788782941; x=1789387741;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0jHtTGREXemZU/LhEz9hMJ4+IdOhXCA4mOuFJdnUzjc=;
 b=BgHfcvnk4UjFwrLxWEC2+lF86J6+rWECxvv0IN5lNP+mRbhdE1DMql3j5FnqkRbkvv
 itznCByXlrS+Is+fi+ZkyJ2JmIJU0sSVkoB5ljSCs9DVJFI+aPvKzF8fidcDpNNY64MC
 O1Njyf6hESfBqHOyMG3J2em2h0GNz6kjzWQg8lvdXpmTYs3ZnGaZeEPEjJ6qBshH20Uh
 cYHfTVFMKLiG+lMHqHkEi6eBsYv3Pw6RqsijNXSL99GjpT/4WIBeNZI7onDqWWxTOxlz
 5M6h1rAijMwbJ9hj7YIsS3trE7qlE0KGzsAv8B7L1nnlk0xkPku3o9rhsdJVm2ZM71TM
 LClQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwRCk9pBm1z79EboKigj75xPk5dFEITwUzBIW09d0DndHaCsc0CtXaTSR2iV1Jjy8X5g6GTgO+Lj3TR@nongnu.org
X-Gm-Message-State: AFuF++lw58rXSNdypPQUmIERYXIwMNytSb927jV6wad9hNM+ia8OMnov
 gH8oGJI/u9Jq9kV+M+6+TSuaJMoJksH31T9T8mLzWdqlcmQd/HNlwR19at0rZQufk+Wq0vQZkXC
 /Y5tV884U+7qE3LzZ7Wiej9YocBezl07Dj15xCXxZ9WErc46beH/RfuDHpA==
X-Gm-Gg: AYBFou3+YZz5hst6yazKv9e/5JsITBXOhVXE4OX9QqldCL6BWDrU2nWkp+l5kXmYEZ6
 VV5nimQgEYUfadR4k8XN0GAwbL8XJ2Vhh7z63Z8+vTB90IhbSSn6CVK1zRM/uY3r2iGGpRkGkW7
 S0lof2HZiwtYVe6Qst/M/qg+nWUDcPQLqFOLq2D0I/rLaZj4KLpBpHCfCyjUMEptqP+CH3/bGp7
 FjKQIwgxjNNpLNvItfb9rAZZSHiMIUI3pdqQSvjuaZcNO5uV+u1uaQmiZt8rNa25eBCtJKRpIBI
 9qtaRUsYN146puI7zeZyJG23cNVq4ziLQaRgOqnegotUQwnqR/x+XjnZODKq7XEONfcYPof8FNm
 nPbk55yeTWeVMgwFngiPv7J7jCZwPPbJP5Rs=
X-Received: by 2002:a05:690c:d94:b0:85b:f1ba:ade2 with SMTP id
 00721157ae682-87c02b226a0mr1553227b3.0.1788782940717; 
 Mon, 07 Sep 2026 05:09:00 -0700 (PDT)
X-Received: by 2002:a05:690c:d94:b0:85b:f1ba:ade2 with SMTP id
 00721157ae682-87c02b226a0mr1552997b3.0.1788782940287; 
 Mon, 07 Sep 2026 05:09:00 -0700 (PDT)
Received: from [192.168.68.102] ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8714b720d82sm70974857b3.41.2026.09.07.05.08.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 05:08:59 -0700 (PDT)
Message-ID: <f76b09f2-3835-471e-9638-b8a826d000b0@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 09:08:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/riscv64: Set vtype before whole-register vector moves
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260903170011.3627720-1-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260903170011.3627720-1-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1GyGtkaIWPFBxV2jlsGQmshpj1EE0zlm
X-Proofpoint-ORIG-GUID: 1GyGtkaIWPFBxV2jlsGQmshpj1EE0zlm
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEzNCBTYWx0ZWRfX0UT1IsPgG1sY
 kEcdym2mbfZ9iQiJbFay9Bkxr93FLBSWO+AYRv1xjeIrxE0hOM9EvFSN9sqzg9nxZ+h/KPRL9KX
 ef89uaJVE15q81ta+WvnLYWz0rBq4Eo=
X-Authority-Analysis: v=2.4 cv=LseiDHdc c=1 sm=1 tr=0 ts=6a9ea95d cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=Uuzr4GicECs_swJ96S0A:9 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEzNCBTYWx0ZWRfX+ALW3xZD7ZIB
 SGfk+WyizDDEIAddCtCzt4bWTj2k+xOHTAd10HtxI/3BELF0ORtmrhM68eqTyvw09Ooup0LUGa1
 C3XbuYF23CvHXlTi2YNzcnuZNm7AiwelXcLJuNT3+y59E16sXyk2qQX4hHwYcdjd3MgmGvwOnju
 6JIYM8+012MjD4nM8Scnpb7jJ2l4NiCxd8W/u+Xt7uyTSECwxOysuwxdBvA9UrHFd+0/+rxfjew
 Hm5lbz0Sr3hL6Ubv06VX5ix4o6bP9ty1rkBCSp++Qn9pwFNhfFzIvljz5OVyp2zzGqfn91MsRCt
 ez0ZKdB+eMzSqY9LUaivGNO552DCuUAl3lFKkT9AfWlfYoD+IiS9XnQs/74dvN1NB5Ll3FPwj/U
 al4Ff1dQJbVMOoWPWpqAL3cdRsG8U12x+FkJDsNkDzDYrYNWg5UxZVle6oLTYSAD3gs3EAfEStn
 dq9L598eOArHdXXjoCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070134
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 9/3/2026 2:00 PM, Max Chou wrote:
> According to the RISC-V unpriviledge spec,
>    "vset{i}vl{i} and whole register loads and stores do not depend upon
>     vtype."
> The whole-register vector move instructions reuqire legal vtype that
> trap when VILL is set.
> 
> The tcg_out_mov in tcg/riscv64 missed the vtype setup before emitting the
> OPC_VMVNR_V.
> 
> Fixes: d4be6ee1111 ("tcg/riscv: Implement vector mov/dup{m/i}")
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   tcg/riscv64/tcg-target.c.inc | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
> index 2ce9d47a633..fbfb4c44470 100644
> --- a/tcg/riscv64/tcg-target.c.inc
> +++ b/tcg/riscv64/tcg-target.c.inc
> @@ -778,6 +778,8 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
>           {
>               int lmul = type - riscv_lg2_vlenb;
>               int nf = 1 << MAX(lmul, 0);
> +
> +            set_vtype_len(s, type);
>               tcg_out_opc_vi(s, OPC_VMVNR_V, ret, arg, nf - 1);
>           }
>           break;


