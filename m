Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278BBC4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wljOV-0000eI-62; Mon, 20 Jul 2026 04:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wljOB-0000OZ-BU
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:30:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wljO9-0002GZ-95
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:30:15 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6RmTS1263161
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:30:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4GbL/Bi34jpIGCIi4pSoC4Z5XYmH9HUQfSWr5eLg/tU=; b=ScQQnBNI1qo0seSB
 Lv0CMHGRP/eHIbEmCTv7A3uScu2CQOlJVO05VXhtAROowwtFcHQW6gQxAxc8gh+L
 8IoJ/cwmOaMQl2hf+y/l49PP545KPn1mp5bVQA8329WtuhAb5RE36C1ExA8ibLIN
 w348cKzTKEvFjvinoDIX7ARGKl5snKJE6vMGJhkmURa//4J3NfOMvcJz1rac823w
 wdjlTbz3b3VY+DxZpq5kguzuyEKeJrYiLCsBrVdu+iLaU2YcaLABVgiDOPQk9XVp
 aPoJcWA7LoylpUgKx8k9U6P4oauMEryNX7g+L1gbBBV56Ktc+JcJa26+gd09oewD
 SFXA1Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2nhn657-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:30:11 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c0f0a0760so235936571cf.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 01:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784536210; x=1785141010; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4GbL/Bi34jpIGCIi4pSoC4Z5XYmH9HUQfSWr5eLg/tU=;
 b=Q5U9VioJsTNFVdo950UFnBfktNrO06VRZCKYIWclTnL6EDpMZy1dAwcInXpegUTm6L
 /uyzXOJolw/CmeSEgeAwo/mJ+D0V5oSp+yE3xombN0C53E4GN+MHElfyEb0FRcD0NLTS
 +woE6GhF1GY1bQFGLebh2Pq213vKoYCiOGU++a7KtcTccxBbe5dYJl/UOHWUFxWfS7Hh
 VaVX4w7jcgxiLY55kK0YvoTUDwE7Kz7D59uolH5GMtC9GRWW2OGihC4Puo0HFrnCB8o/
 RoHzcMzi8l56eiuaaABkKwR1COi+MZAalWGTlmfsV8Vtt4Fi0R362TEaAwssj1an11zr
 IrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784536210; x=1785141010;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4GbL/Bi34jpIGCIi4pSoC4Z5XYmH9HUQfSWr5eLg/tU=;
 b=bRbw1ZQPmGg376+KPHGZi2H7kBS3sLMv6MYnoYqL1Lp4XSlU8LXlkgCwVSy8CvuCZL
 BkEf/vaIvVFqUO/IKVU2NeXbUqoovTWIsUBMuD9VvPluPvRnPe7wDnxwZeSPHTisquVg
 H7uzfLyENXX03rBbT4Rv4zFtKiyDJWEAZthzA5SnwTEENtwZWbZuH9WftGAz/Oh6jizz
 RBdT7UXbjFwvvmtXoqClJfWzI9uhmS9CBtzzHR4Xd7bPZvNOiWw+VSWmQgcNhsegYxYI
 VjNiIbTJn70i/M3GOUe0+eg+zRE6y6mse6/CmklZExBmn20Ih37TJUF3gQBjvvCn0pJy
 5V8A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqeOEXAYd+xUA0Cwe2pnDCNUcZ7ucfHM2/y5jgcgWyJp/PIgaSsACRLtEIDZ1AQAq3O3nCYWkzkXadZ@nongnu.org
X-Gm-Message-State: AOJu0YyMUvwTYxWcQIzMtD52jSkNF4udUgdUwwssgyPGZx4v8QC4Iytj
 spiF7qpHQswrfInbo5jzKj5Bu7ZKu/MUHfAEzLVz/BOeeg7okEOBJd3ipwEKIpy/OfLifGqBrgk
 EXrPk1T9h2GNG2n75gFZdCs4wVeWf+DWQvbzugsPDWeO0FmGoGzwa/1CwOGiUflbEGg==
X-Gm-Gg: AfdE7cmWcWc57tnpdmsa/LYiZ/1r7QIMOGp1mQd4kRNFeW3z6B5PSb/KUj1vq17grTU
 lw4SwW/5SnpDh7TdngeDA/hUVh8dfIRnutLsSX34G9JACmFje+70bkHEGXcgA7/cYSo9a/g3LIZ
 wqE18x/fEquiNxuAE3aJtc+tORqIKKEyxU6CMvqsUgwWGMdWHx9jZlth5jXeXdwuWW4U9RQ0dQZ
 K4dcp55nITWqfN36HCvFgnxwvugbPmFK64iXTZ2I3Vi92pXKNoNpZE601GrcT5nBj2KG4qs5Etp
 kLxuRlWdE+kfTJWiOCS+VUC+tDZA7D9AtIOl2+ZER2QDq2iozjWwk82Jl54kDwSTZUJy9AuhvU/
 kURJ+VpPAAQJAmxR50nHHiClSAN7qertwkXRsBTFEOpx3iACfjz0=
X-Received: by 2002:a05:622a:22a4:b0:517:57f5:e21a with SMTP id
 d75a77b69052e-5213e7825a3mr125502691cf.41.1784536210556; 
 Mon, 20 Jul 2026 01:30:10 -0700 (PDT)
X-Received: by 2002:a05:622a:22a4:b0:517:57f5:e21a with SMTP id
 d75a77b69052e-5213e7825a3mr125502271cf.41.1784536210011; 
 Mon, 20 Jul 2026 01:30:10 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63eddd1csm27884886f8f.29.2026.07.20.01.30.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 01:30:09 -0700 (PDT)
Message-ID: <6c43e974-105d-4f87-9a85-4e6e2905b52f@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:30:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/17] target/arm: Simplify invalid page test in
 allocation_tag_mem_internal
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260717232306.378988-1-richard.henderson@linaro.org>
 <20260717232306.378988-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260717232306.378988-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a5ddc93 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=F4whdlzREtsA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: tJiO-g9I9reYtN2-jIn2faMs6KNUrBIX
X-Proofpoint-ORIG-GUID: tJiO-g9I9reYtN2-jIn2faMs6KNUrBIX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5MyBTYWx0ZWRfX7YfcTNWilzoH
 4vACLm0K29QBmLeHpKlFUnF6gcMXMHFc+SptR3vJkIsMD71lQQKvGfxxq5+zJY5leejhr7qqnyu
 djcMlRwIP4kj47dKGEhKRpesauEUGhmNv7Vor9XRjk9kp3h1ebVch9MI5Vjsa399unDqfChqIGM
 Gc66MY8KqhkHkpjDZj+B1nZliC3T7+za1UTHU6Tq0nyZ22glccoERhIa4p6IjcNv8xnmSIzdfKY
 DuaI2Nd8hcm+/NpXske47AfkF3NeTpTtaGqtUY2UqM8aTPRBlT3VO6bS9u+mYbpy4hMgQ0ESGIa
 ep2AL0lUGSDc2O1RwotDxU3bOXdRz7pBuBQvDgcnIgo4jPy8gU/gJOci3qlksRCXHGiLu6XqZzD
 o48k5uW2AC+o5C3XiBQXjvS0xSQq2By9bvzBlwfAsiM+n/lqxB2tCRX80E5hdtz5VuQticKyixo
 nQ5hN6xfMEhXBqBwpMw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5MyBTYWx0ZWRfXyeW+4LvPbhqE
 iOPsDMnpUm131LrC8HS/vscwbthWhoeAOWrZp19Wjb1hdS5hRKbfgggc/7MRrqLERts2fXD2XHy
 8R75ixFANmD1LmDg2b7Ium0OP7972LM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200093
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 18/7/26 01:22, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/mte_helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

