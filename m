Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F322BCDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbZ6A-0003lu-4i; Mon, 22 Jun 2026 03:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbZ61-0003lX-IB
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 03:29:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbZ5y-0008Mw-DD
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 03:29:27 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65M59ASp3786541
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 07:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4ymd8TmAtlbLqHBrgNDTYyEBUd1WEgYd6UYkvotfiEM=; b=hxluKwzmTbvDhVpy
 S7H/FIHhlHgk3OPJbjtede4DG8Us+FSJHpyWh89hqHnsuD3HqJzyRmPA9mpOprN5
 zgdj/qYH559YTq3fo4YqfPgp0BX0vj86tNdDhvLw2NRd+DxKVxbImzZH7P25oA09
 HJ6XLitouG60x1wcYuEFbg6nnqLS9GIwKhdOr5gaUorO0MrOmZmB3BWfG/G9QIGZ
 j04gLD6uLoka8P0e9CHrlikMLhaLYWLzo/T9ACTkD2VTOKtQCK/t/Bob2Dlnh1BM
 LTTM0pldcmAZVRaTnEhkFRbzZC2MyeB72X5gj+wnJGmHhf4f9W+py4cz6QCh1bxi
 YTBH3A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewkmed5mm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 07:29:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-915d3261c5cso858552385a.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 00:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782113361; x=1782718161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4ymd8TmAtlbLqHBrgNDTYyEBUd1WEgYd6UYkvotfiEM=;
 b=JCi9PmAXwqG9/oiqcWLE3epb4qWBsP3Kuu9PZSZIPeW7ReLZHyp8PCUNtblRXN+8Fa
 fWJk5JfxeEufdjtbc3tuqmezk79hzrTt0Zs/R2SU7EyHNnZdnXlSAUfGmJAqm5woAEPq
 8FuSXrexZ59FtOErLDZDCp+0nMR9nW3AkT0QmKGT0v+EhiInzyZtfMbcEW/+OIX+QfYe
 PCiBiFOKZHlNI18y5r5c0tMr06awqkytwnMVRHGZkEtkwTfCYBwwWVxIUXxydQX++f3X
 la4tOvr0O6+c4fIPPoINXjYJDKcYq3z5RkwXmCBuWJpESI9q0nnHqvhVZChE/sJPZFU9
 7WGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782113361; x=1782718161;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4ymd8TmAtlbLqHBrgNDTYyEBUd1WEgYd6UYkvotfiEM=;
 b=M1dpMCNJGOoOI6l9u69v/hg8yBiXtu9Xpj//6fg75EYtjVumeS2xiH8K0mHkTypLaF
 ZT4k6FA7mOeVzz2l+eSKJAjXRklsyqu4BUwmqh4oasiiAU+9ovRWpxtiFHs2IQry3vF6
 l/jMGKV57zO00P/1y9IPdPuhOJCkQIBECVsWD4mdco/gXzehwgS4a8lfBoRd8/l8KToq
 h/RXw3HPOOdnvEzHREueZHf6FZEE6hEQXxDgikU5FdyuUMWCYnLEfCdhEC7LuIBj+9vq
 a08jL3qzQihbvTVxV9F3FmrzPoyWPUDEmAyKQV1nEAK/wsEHPM8O0WBZP17sNKo6r7IO
 MaXQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9rxdujPI+kqvN1zwFaM7Bff6THlX8VvpEheSAQ5GV09HdIUvNLutPRCNTu4loxBKDaoOjm2QJ2YdGe@nongnu.org
X-Gm-Message-State: AOJu0YwYccZ9WH2G40/X+jw6yS8169hUfe66nAQ6XL/sWThzotZDb23h
 lP17T/IzEB8+dXqshOSozPiTewTeKCsEu5ikEeNBWM8fri+kjJZtOhgX7kBv8P0EVmo0f7EmORg
 EyOTah/NWCpvPagCQdys6qvv7rwztEgzh8Q8Uvy0sqesxMGfzV6jaKJrCvQ==
X-Gm-Gg: AfdE7cloqa4kVL1rFvsaoA3rtt4JhjQSHyUxdGbfd5iUXhhqBXZetwHPBbYNt7mm/KE
 kKbf9q6GepxtxX1tDCbuRTXilVjPPFXyQu5d0bZzxiC88PHi7CB92+cSPn+Y2PkSGCrK2ottR4O
 Net8kfkXKrLkogvOp54kqJApdHKk98lYvgT2jSV7YYb9azwHgnmDOL1J+QUanLyPxsdmiTXL9gf
 BgttUT7jEkgEGSyOYsWzzXPRO3h67+ACqiXet5A5csHCXGOW3nKp86WaFG5fXfrQiBwidUZFCoO
 XKpFVd3o3hALBqNoP0f3d9ETmfe5tCM/VL28bA90zJCm03apAsjvXuHEi0WBJvTVZJHrqbCm3Je
 RMRRibm3giMTGKUaeHhC/PR8yF2HWPrwUyjMLUfUEfvpv8ZiiMwOZRbkhcMXOGtcnPY8=
X-Received: by 2002:a05:620a:d8e:b0:915:a111:86ae with SMTP id
 af79cd13be357-9209119a689mr2294522185a.35.1782113361376; 
 Mon, 22 Jun 2026 00:29:21 -0700 (PDT)
X-Received: by 2002:a05:620a:d8e:b0:915:a111:86ae with SMTP id
 af79cd13be357-9209119a689mr2294519885a.35.1782113360950; 
 Mon, 22 Jun 2026 00:29:20 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f4e9esm22612193f8f.1.2026.06.22.00.29.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 00:29:20 -0700 (PDT)
Message-ID: <fd7e9e56-647a-47c0-86da-9790ddbece4e@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 09:29:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 40/40] bsd-user Update random_seed on thread creation
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
 <20260620-misc-2026q2-v3-40-f6ce23ad8dda@bsdimp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260620-misc-2026q2-v3-40-f6ce23ad8dda@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA3MiBTYWx0ZWRfX5AjYrcDTI3Pv
 j7pzAT0VtUVYvJMV8rGyqDTBS/rkQ6h7TaKSCqb+ZvSVXs/1mtSxNnKZulql2PzKAP6YvunVOBr
 9iUQXi9podR+JfInNJucL/S1EZKzKAcj4E1Iy9gUgKCKwv8ziyn9+4U3EmmO4oVRRrnQKqKMYgQ
 g7Getzv4KWXLv5UPThS3PJ2D4pg70DcdO4ciSnLEhK50q6cjSsh1MWw0/76hjFRncthZ2ML2MYA
 TkzNBckSc8BTSfrDKRueOH201/djBA2Xm5zGOHc6HPBtgp+Nkye6j0qo7wJSUd/pmQGQHAUniew
 v47ecjF1GFhHjHwMv69hwLa2kG3C7U/YOvT9IvefgHYkA2uzxhRetKooh0y2YSdb/dKp/HAas/F
 KKcWTZxMncsV140ecpPVSaGPXzdtfIg3V9MyzVOduswWbbQgF53DFdryNYchHsVSRqNsoE6ULlm
 EVG5VMIskz5GHekvwNQ==
X-Authority-Analysis: v=2.4 cv=MtFiLWae c=1 sm=1 tr=0 ts=6a38e452 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=xt-mzBTFr2Kth5l1m7AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-GUID: kVc8kRv2cHWGQMoCaOdMj_DCDDkeIFt1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA3MiBTYWx0ZWRfXxqHBHQLIMWWp
 HaJ2+vIW09sYpsJXpo7tlJRloCFrmE3Xc163bsMf7ZYcArL/7idfX/S94hQtBAc0LzUUjZozRPl
 MmDWhimfa0UEa1rOeuCIx8qMF0fHPgk=
X-Proofpoint-ORIG-GUID: kVc8kRv2cHWGQMoCaOdMj_DCDDkeIFt1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220072
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

On 21/6/26 06:20, Warner Losh wrote:
> Initialize / update cpu->random_seed in similar locations to the
> linux-user code. Set it just before we create the thread, and update it
> in the thread startup code.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/freebsd/os-thread.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reported-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

