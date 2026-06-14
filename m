Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40473CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 16:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYntH-0001tg-7W; Sun, 14 Jun 2026 12:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wYntF-0001tY-3k
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 12:40:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wYntD-0007pX-DX
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 12:40:52 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65EGHKt1080101
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 16:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rrsAEgadN0S0zN/zXy5uAvi55/YRwQF57zY8ovGr9xI=; b=MbTuFpJh6jb0MMKu
 PpNj/HfcZVOTTwpu/LZ/ATc3vaSEc1dou7maDfbbGLacr89U2cBQ2jA3tFTZiq//
 a/lDEnnRPWKgbpVc5YaqE8EIxoLXxufK/XyWnKHvySyK6REQVEc/XTJCw6U+45Ek
 Gk0s24gSpaCU3eJt2eD5S2vSVyXk5+Wbg2wXA6eIGLo8rAlUby5AVqdxNCj1KIcz
 HbZylIiHGLkKCr0caevfF+uMvcv2Y3BxTQ0t4DJmco4SWgTs0xK1Z4IQSBs3rFFQ
 j6N5/Ru2nquEsB5ZP7LKSW8to6u1bnKdWDuyU25Dm88gHpza0ippkNwGNUUlnt/5
 yEwUFA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eryffm179-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 16:40:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-915767b341eso241763385a.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781455247; x=1782060047; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rrsAEgadN0S0zN/zXy5uAvi55/YRwQF57zY8ovGr9xI=;
 b=CHSJQL5tsxCCOtMcdmOuPiHuRFHA8W8kAhcGYGB3NFGmxWQIBDgQTbmURDZKXl+wLZ
 lw9nOCuMi/kjR9nssg/3YvSjMQ5++RMFL7pb6kR0he0aBdlaJRk9dmdmyP2DKf4PITnA
 Vl0JynKQtl0LkO9j4mdJPWkdtRj6LIyuoM4Kb8hU65n0+ajcuVyQaNFLXS4QE14kMhRa
 tj+i0O1O4gE1Rj9kOpR36mWULTJuXeRNw7HkJKCGEPNsBcDBHxD0BW17V0x4jU2EZGr3
 raTL6OwtPkiIkImmyHMr81QKIhbirgyCzEoVkkgjWx8ye88rtipPSq7CTqdJCens0AEK
 +5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781455247; x=1782060047;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rrsAEgadN0S0zN/zXy5uAvi55/YRwQF57zY8ovGr9xI=;
 b=IuhK6gj89+fe8VlUTSVwCtu7PVY9lzXKVCOHJJetXnTWBHtjw7kyKwdvUjhLronA8m
 0Ck973xRywSnRl8Z67uzJIWuRthbnlZMXs/TJkUPTuBHWpMOCEuSnjxveTze/rI3LE58
 vf/IgCXcTVSzC72J5NO1LDexxQ0fIQLWyzojtoIUjAbkfQy0YoNDiRa73XBhQ52uKLNy
 m5yG2+Mn0LzieSFOTpm1w423PCKM0hQ+6MHyvNhY07usto7qa0HXo5VcHVcbt1vD7OuP
 KQEBHnUpeyHLO7E5Z8ywdRP5rQEVXNf5piX6dH0ElAjLFkSyxibplWM90jmuBpoaSRvH
 pKuw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+EsHrwouup8/Jp85sjltjSR8o2CdqM9R8GDqas0HfJZoYZC/dZiMPJkLhlT3pqRlQGR8Fk+bz36EfB@nongnu.org
X-Gm-Message-State: AOJu0Yz6dJt45OuxRZGNrbmEcexx2MJ7qgo5qD7vLuczI0q/W6Opdcbe
 3AoPchxwKGWAebXI9eTVA74U0T9uOHTGlJkKWhXtl+dhyghKKUzuNaNr4fYikUFO5C16nzf0XLU
 LWe+B/GkM13/CB9Vve+lnvR9DAvIktU4l8HJPEuwUCMbSjX8gZvePOTk4svy3AjYa0g==
X-Gm-Gg: Acq92OEvs/tvP+1aytLCcDF9htAw91Q/KQmi0Jl79fkZIQnm+0W+qBeS2qzbMS/n/RQ
 CUZxsxoGXIn1yjR3dXbgYzwdFV11eZYzQfz5inW/axRzgB0VFaGkISMhTa8XDJZPmx/iASVGT2C
 r8A190sjEuj3qddG8int4+40cKm3mcv+om6fIp2uP0mSbNS0ibhHVOmfulJyb6mKdZHJlOY7onR
 P7TRDt0iFoEjSq5HSmVfmmUSytn0JQpelPF7SI6pZelQ7jxy8NLlk+G0eTBs5UbS3P42SagZs1N
 rpAEl+Y5wEN4r838yB0UqEK/P015nVUXGnSi+aAD85ebePHZnPqRKZB/h7yhJ+xl5Cs8DO7++BY
 rKK62VwSwKei0ROzIoWe8M6lDMhO6rbU+01OI5Vq8Z56DWF74Xdo3Vl1P3x9vb/TrDcbcjzvV
X-Received: by 2002:a05:620a:bd3:b0:8f1:5e8f:fff3 with SMTP id
 af79cd13be357-9161bd220cfmr1647976085a.26.1781455246540; 
 Sun, 14 Jun 2026 09:40:46 -0700 (PDT)
X-Received: by 2002:a05:620a:bd3:b0:8f1:5e8f:fff3 with SMTP id
 af79cd13be357-9161bd220cfmr1647973985a.26.1781455246035; 
 Sun, 14 Jun 2026 09:40:46 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f4f6sm28076640f8f.16.2026.06.14.09.40.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jun 2026 09:40:45 -0700 (PDT)
Message-ID: <c15fb219-8769-4786-9749-d75ce686c4f8@oss.qualcomm.com>
Date: Sun, 14 Jun 2026 18:40:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/xen/interface: Remove pre-C99 checks
To: Bastian Blank <bblank@thinkmo.de>, xen-devel@lists.xenproject.org,
 qemu-devel@nongnu.org
References: <20260613175151.1357-1-philmd@oss.qualcomm.com>
 <20260613175151.1357-2-philmd@oss.qualcomm.com>
 <xuuzvpxooyhkbqluaxszcizjxrqzjczejhdqiso6q2mc4cnhjl@kszikmaagunj>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <xuuzvpxooyhkbqluaxszcizjxrqzjczejhdqiso6q2mc4cnhjl@kszikmaagunj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HuxG3UTS c=1 sm=1 tr=0 ts=6a2ed98f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=mDV3o1hIAAAA:8 a=bxkv4MIWnuf4gb2VlVAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: NnEjx5tO40dyLsjszhsquLcwRxZ88PUC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDE3NCBTYWx0ZWRfX3MwM6qTC1rE7
 enT4K+KEpTZVTuygde+r/MQjfSf+xVSe8w8HluLAkQce1f+xGpDn2Tixn+heWRqWqz9JLJMWzw5
 puq+WdSQpqq7iym/Wsn2uGGTyecSmX8=
X-Proofpoint-GUID: NnEjx5tO40dyLsjszhsquLcwRxZ88PUC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDE3NCBTYWx0ZWRfXxestiwy1g3Xh
 k9pZRE8OOMiz4DgV8ULFiS0gqvFRzxo1wMrBXpNvuR9hHRwk4EcWEcl602jHJT8i9hoJWdclsN+
 NRRJeBklqnGm4g6NynQUnKVklR9Plwalddmtbf6z35mYPxPmCkmFc72Th3/Mwhq8VkY4wheySiQ
 I7+zeO9S2EiM84bUFbWzr+PGmjeQWkxVW8GVNW4nD9WDQzd6jyfJzAIjViKP8q7pchFqe3GAT0H
 tohhVAE/C4TILi7QLLylNGtV2kWn8FKjMrNUAfGmK4yh/TpGFPIYhYwnJKo0C1kkYpklyWopvLT
 CvrKOlt3/LThhLGK6VEhvFKQ5m5lN/zFIkqTnXKE4+nJMI6zH4OPhgN/ckAWCWxgVrEoyZEQ6lj
 notHne3/Y8/AA7mPN3/aRLvinhPEPxx2Urm8DVagjxc/sCg3q13L/oRKTvcjf6sU/fXfndS+PeA
 gt2H6WCOWBEdphhQk3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606140174
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 13/6/26 20:13, Bastian Blank wrote:
> On Sat, Jun 13, 2026 at 07:51:50PM +0200, Philippe Mathieu-Daudé wrote:
>> We mandate a compiler supporting C99 since 2019-01-17 in
>> commit 7be41675f7c ("configure: Force the C standard to gnu99"),
>> thus supporting flexible array members. Remove what is now dead
>> code.
> 
>> +    uint32_t optarr[0];
> 
> This is no flexible array member. "optarr[]" would be.

Oops yes you are right... This is what we want here.

> 
> https://www.gnu.org/software/c-intro-and-ref/manual/html_node/Flexible-Array-Fields.html
> 
> Or are you talking about something different?
> 
> Bastian
> 


