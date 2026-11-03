Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E46606A334
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UVgZX3J/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O1Xoplli
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOGZw-0006Vt-6X; Tue, 03 Nov 2026 10:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOGZl-0006UW-EU
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 10:37:30 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOGZj-0004F4-IZ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 10:37:29 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3EA3uq3048676
 for <qemu-devel@nongnu.org>; Tue, 3 Nov 2026 15:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CTERYEy7pZTf/K+uSEKL3XMniFBneBLzF9mcIQX8HVY=; b=UVgZX3J/xKFwjOo2
 zshD98sEV0ZalH8P3A5apsCzTafIbI49ClY3yObWzeFMo140g90/XKQD1bFubXbr
 S+ZCdYo9zJsXMO8ycTXtuV9m8fgq8t1D49ZwNgrbTCW2kq9fXozSvjjLZczW9n4f
 GpkNZiJPThSRBAc4An+CzIQmHaIL8kLEraegQo/x1tyVdYmJB8o0bAfmoVJqpghc
 IjX3M8vk+iPHF2VYszMVISfZ9u5JYFrjoO/cxqV8+IhRM6M8AgKoAZHXhCri1SCt
 xJoAUg/izPxUzTCN0X6Xgt9PfVkeiMZyz6RYBkDb+WIxc4iKWOWUK/VfbGNVaJRq
 0BRtPw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq4v5kdeg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 15:37:23 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7bf3a6cf1c8so3304587137.3
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 07:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793720242; x=1794325042; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CTERYEy7pZTf/K+uSEKL3XMniFBneBLzF9mcIQX8HVY=;
 b=O1XopllimhQLBh+lFlLiqwZEK18NEJS0KPoLLd8hCL45J4UKCW1YBQgvutkYVEArKD
 FPYzmcka1H5COnL+EXvXdpYP1mGGUll3jcFJGhSVuaJ44c2KeFTDHWenSeGqpa4pgEUW
 udUL04AkIRYsR4D+DZ6JqKOlBznaU1aCgj/gLCKW7fUWk3eOAbva7x88eSND6tj9qqrX
 mYL66g1enbyYFCF9BH9yB6CjZoB2OnQuUwX3LVw5uQMXxdz11l8atOgAsxqfjKNkOwMm
 qnXgFrYSy0EiXfdo+pf/ey6ISwui4POrxsabqfxjhLbMv3l7CxRqgS2NXNDVf3fk1yH/
 rSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793720242; x=1794325042;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CTERYEy7pZTf/K+uSEKL3XMniFBneBLzF9mcIQX8HVY=;
 b=iM6ORcUb+yWX37ukDfNLppjySfODAjTXtUEfWxAhkfjeLGQzwlwrI0K1kcXq2uqEiX
 xbUWvZQ1UlYaJXbppJAnt0Ohx02GE4ItQlsP06KRte894sdO/ujNYJkRqwMF1fHMs6Ly
 zTCUylKwsR1yE6D3k6vDw69tW14GwK82Ifzk4RKdnGeA1tdLL2b3oox6+lgpBVqdyzJq
 Y0WNHxfr21yrqliXpsO5AMVvWScJeiujCcWbUjOwX63UT7ldquUvIQuIAehBUgxl5CK1
 BTPFK0p2ARnODtOOVNlRCmbtGil/RNyfIneiyD87Mu5B2ef3skubk24nAxvLu2b9FQtK
 mrbw==
X-Forwarded-Encrypted: i=1;
 AKwUvByn5ON2q2EVCnjXuge/ptM9Q0S+/EEUMsY5XzzgqvvvVIDddymJJlhIQDiVSGPTS4jHn07DYJymc8K1@nongnu.org
X-Gm-Message-State: APuU4Z8oF5vUuycOmdS7Nf0mqxfCdOj1PlOxZLXOG9KEKDPs7gla/sNH
 WWTrWqwV/e0dJWvQrALhdvFSkhkAKSrLQnv9EmdCWEJNIdKmbGopoJxrSm5nUqcamLASOWDCfub
 KcIwSrM5S3Tz7Yz/GbnUEIvRYsQVwy2XI3bj96unv2wn046PNETJ2haIKbg==
X-Gm-Gg: AYBFou3lq7riWbRnkmpx5b7izcOJ/a6tKyZq7FruQ7L/91UdiHKPj9Fj7ip/9IBRAn4
 IgBgkv5SH9QVkQ7I5HuA6YkG1sFr2a7mEoP+BKofJNQLTwxUJLGeRhCdRJXBJXidhagGKW7UC5P
 kGa2DKXJep5H82Q9AbPuKH6QmtliXZlCT6gu4rLMwEp4Mxjyo1UDWRezpOoQkz9jQr7y92ORfV+
 TCoU/lAYvtUP9/eMJcM/V6Xemud+bpv/yFgbQSArR7mpwvzX3ZB45aDYIzxC9FFCiuB+yJnPH/V
 Qvs+MTuUesjxU8qrC6GlBaAg7rlCkuwRc9rxtrMY3hKlmb0gMBt4wRm1IL1fuaMuM/4mjHw/oxn
 g4RJm7fGG0osX1kQmtX9vtak1pyPw+XDaS2HmlF+F6Uln8Bf88M25I1xYhCWp/aDMXnPlfyDK81
 p9ihMrEdjoxYLn1JtnD9Xqag==
X-Received: by 2002:a05:6102:a51:b0:7d0:65f5:2bab with SMTP id
 ada2fe7eead31-7d072d15aebmr5753160137.29.1793720242059; 
 Tue, 03 Nov 2026 07:37:22 -0800 (PST)
X-Received: by 2002:a05:6102:a51:b0:7d0:65f5:2bab with SMTP id
 ada2fe7eead31-7d072d15aebmr5753142137.29.1793720241551; 
 Tue, 03 Nov 2026 07:37:21 -0800 (PST)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78a1dsm24796991f8f.24.2026.11.03.07.37.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 07:37:20 -0800 (PST)
Message-ID: <1840f65e-c484-4dea-819a-415cd692e08c@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 16:37:19 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] hw/sd: Improve performance of read/write/erase
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Christian Speich <c.speich@avm.de>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
References: <20261006094447.43491-1-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261006094447.43491-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ZTxaeMrEG9rWlimzVHem9NlGmDLFuu9X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2MiBTYWx0ZWRfX194TrJ4+Z/DS
 3l2RwNSUy3X49h/zi5yWONOqmlsJPmRdkvCWse0WpdXNdXhhN9BYZzjIYZYq4dltuwspFBz2B9v
 Q8DfIGY/Q2OOXWm/hZKku2tMLpiYvFLhU8Q6pQBQ7TbUFO8FYrREA6/NfwFbZ8wTbrA7VY9kt/5
 m8txL+yez5HLSrGMR0Fsz04R/yG0LvEKUr6NmtflvdzqBbzFmlRCzN3fiK3HFXoTsfLikCtApDW
 gKKZ06sH7uWLGa9ole2DjISrHJQ43Qzc9h5zZnhdRwoWJBFcMKwm62zWtQckMqrr2XG4xWDhbGc
 GytHVag12iGERFst6cP+bL1vLdB2yL6gsEdl9atIMs8LfAHoJYU+IakXYd2okE1RtaKzn9Eed5X
 sTQp4x2FE4hmpAhIjh4BaaYrfoZ2hS21hshFIhoakN1g3ys6uhHlzj5xcu2/GmfVg+pso59GeKE
 HO7shNysXwWYuNgb4YA==
X-Proofpoint-GUID: ZTxaeMrEG9rWlimzVHem9NlGmDLFuu9X
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2MiBTYWx0ZWRfX/+N5MbixWhmm
 iVgQahZnvzF2hSOQ10Jk0xWXLj3hOBeI46MOZXIE0dgFikOB6eaJTKQHFBjUMkqY5Lk1Y74wtSU
 0Z1sskbHYwxg5+GuojqmcjoqWCLgo1Q=
X-Authority-Analysis: v=2.4 cv=NeZzRGD4 c=1 sm=1 tr=0 ts=6ae9ffb3 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=FG_UeWTTKokQwsbpFD4A:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030062
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 6/10/26 11:44, Bernhard Beschow wrote:
> This patch series improves the performance of read/write/erase operations
> on sdcards.
> 
> This is done by increasing the maximum buffer size that is worked on.
>  From 1 byte (master) to 512 bytes (commit 1-3) to larger than 512
> (adma commit).
> 
> Testing on my system with fio I see the following rough performance
> values in MiB/s.
> 
>                read write readwrite
>         master:   6     6     3/  3
>   first commit:  51    43    23/ 23
> second commit: 392   180   144/143
> 
> Tested on a 2GiB raw image with:
>    fio --filename=/dev/mmcblk0 --direct=1 --runtime=60 --time_based --bs=128k --rw={mode}
> 
> The adma values are somewhat unstable but always >100MiB/s, I'm not sure
> why but I guess it has something to do with the host side caching.
> 
> The fifth commit fixes the DATA_STAT_AFTER_ERASE bit in SCR and
> introduces an option to allow to erase blocks to 0x00.
> 
> The sixth commit optimizes block erase when erase-blocks-as-zero=true
> is used, by passing the zeroing request down the to the block device.
> Erasing 2GiB now takes 0.1s instead of 26s.
> 
> Signed-off-by: Christian Speich <c.speich@avm.de>
> 
> I'm picking up this series with the changes indicated in v5 below. Please let
> me know how I could improve attribution to Christian in case I missed something.
> 
> The last two patches are new and are small cleanups.

Thanks Bernhard for respinning. I also had a local branch where
I was working the fixes needed for v4; I'm taking your v5 and
will respin as v6.

> 
> ---
> Changes in v5:
> - Rebase onto master
> - Split patch "hw/sd/sd: Use multi-byte/block writes for block path" into three
>    (first three patches)
> - Use sd_blk_{read,write} with additional parameter directly rather than having
>    sd_blk_{read,write}_bounce_buffer
> - Drive limits and write protect groups are preserved to be checked on block
>    boundaries only since these checks are redundant in case the SD host
>    transfers one byte at a time.
> - WP_VIOLATION is only raised once the first protected block shall be written,
>    rather than immediately at the beginning of a multiple block write which
>    starts with allowed blocks.
> - An off-by-one error has been fixed in the same case where one bye too less
>    had been written if a write protected block had been detected.
> - There are only two rather than three code paths each handling the multiple
>    block optimization.

