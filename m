Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DA1C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjELo-0005kt-Gv; Mon, 13 Jul 2026 06:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjELn-0005kJ-Jv
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:57:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjELl-0004le-PC
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:57:27 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D98qVY793115
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 10:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SNuZ3bbn6U4Dg7zow7HCAWMjkGisgq84Sg6LG7Y4owA=; b=XvuTeiKqo30ie/MB
 Fj61MzxRRZPTw8BNlFJul+N/tFvkTWhbfiN9aW53+X5hm/kszel8QNR72fu66rlS
 2eSDas6Rs+E4dJCOPObTiULa66IN3TXN/cs7ljyVtRBj6KIC0hrJGl4DMNvz67lz
 8EAwFU2QhexFDGZ7iOQnZjqgO4NPG9A+mC84pmrPqNhecFxKHN42omvO3u2N7UEK
 BBWvGCJVMRffa9g8gxPPLX3k927rjHQc6X9cQx8FKUFWRPytdJlo0MYUmawDzLmR
 +1qqgzl9DBzLDjYObb6zJwkLPupGDJJShnekA4FyOlHmu1jlIAHktWUOkNkv0ZLY
 +S6d3w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcw4qrbwu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 10:57:24 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a8db414c7so43811471cf.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 03:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783940243; x=1784545043; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SNuZ3bbn6U4Dg7zow7HCAWMjkGisgq84Sg6LG7Y4owA=;
 b=V0chMq4sjpl1f0SMahQOC86gQgq+ONpKCPKIuEp7WB49qBU8jOcz5cWxBteVbY2+W2
 1dtmHTJ00rBla+p9vUTMMha5HtgFTuQvk1yQf5bcW+AeaQHBLSpgPvRrDwZ0qqz5D8Ud
 C5xYmjsus3MWxl2EGlPATGc++XpBz6RPclbuj8kdwG0E05BSjeiC/l/9fJ2dE7PaBSwQ
 1nHp9LfOvcOQY6SBuEPncb4UqddS/+oXAOqY86sZQUkqmTNBtokp6iueouDT0SRyQo8e
 2oowFPWPsitKUOjNkiFr/vD6UR4R/NMDCmGt511xTybAcgRe0grMw/NrH8gOwkVMg4My
 2DGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783940243; x=1784545043;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SNuZ3bbn6U4Dg7zow7HCAWMjkGisgq84Sg6LG7Y4owA=;
 b=cm4xFpuJDV6I5LzyXZVsVnYlbWuzK1U1DdhYVsNMd+JfKU6ZJ8JY4ZzXBiR9cjVxfb
 fd8DJGZjzYHpGeqc4dN3MtVm3/KFU7erer/0uvvaTbnLA+lLIVXzispRBOZaAolQEsOs
 O1TBi/3NsNln60e6hIEUDykZ3X0w7jBGmcVVulQ3TT6UdWkgg+m7QRux8MioLBQjgTga
 +Xnmtln8pXKufhUvLpCirSdIxYvnMOJ4PCwErSeD4zmPBNj/RwOMA7oVZ8M4YZ1/FqVP
 /NebT7+OYF8VaIUzLdYFcGs8mJvEN4ecaT9n5QVk9B8CDp19PZWhlAtavhlnVMj5DD5p
 96Fw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpB7vt1JhpsVlTLgiWL2CHWPNihExJMKRwoq5io1e+nwYJfBSc2QBwUtEwsbRExqegYtqWGZp6JGUWL@nongnu.org
X-Gm-Message-State: AOJu0Yz1VOFu91ZrA62Dx8Ep7I0FdcYJ3wtPNJzq+PLZcWvYqaiQffRv
 xrOhbUYzCT/5JXR8ZNuV1BfLQRrzYcu6ZsEky+EvBg084Gxl3tSaoh8sPoNy6x0jEZ9zRT5o4OG
 pat6H9rk6fJ9o/2Nq0hl1vq+sY2qHXaTzSdfrRkdM02roKa6I2mWsJehkfw==
X-Gm-Gg: AfdE7cmlwkcdJMX8shoxCCjpAp3A8+BmbGSxkPv9a1cqF4WPEUThkALFcWliyl5C/9O
 d63YW8ou5a0WuAQAycXN21lncY7+qOs9eQf6nzzJu7qq+77d+HybLf576p1v+mYMLKnqU5MYHdj
 KBINT04YBeE/q6vdQsXwZyLLBQUUdJTrGbofTo9bAlrQFXTWhA3rxuKDJsDSv2GS6w+vxGCYWiD
 2xsxQWdcjbknsca//6fYW+k9qfBRPTiIeYwE9nPuGwFCNDj15/KBgtdzLncqFUTiTteH04srg+k
 7rPS99xTvzByuxPW3J5WyvWjfuGIqgUkquk/kbYC4lnFNyWKUqsDUmjY/XMzlf1AIIPKv7Noa2J
 T1H2CP86nqLa+DBeWyMlMCgwlmdtGeUJa2S6rHDmEEZy2izUKkslqHIBnI/7Ijg==
X-Received: by 2002:a05:622a:1446:b0:51c:8439:14e5 with SMTP id
 d75a77b69052e-51cbf0c7fe6mr96986861cf.10.1783940243489; 
 Mon, 13 Jul 2026 03:57:23 -0700 (PDT)
X-Received: by 2002:a05:622a:1446:b0:51c:8439:14e5 with SMTP id
 d75a77b69052e-51cbf0c7fe6mr96986721cf.10.1783940242987; 
 Mon, 13 Jul 2026 03:57:22 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f25b23b7esm29489580f8f.18.2026.07.13.03.57.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 03:57:22 -0700 (PDT)
Message-ID: <3f70bfd4-a410-4709-9d50-a6ce6cd0253f@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 12:57:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] hw/dma/soc_dma: Remove soc_dma_port_fifo support
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
References: <20260710105907.2570621-1-peter.maydell@linaro.org>
 <20260710105907.2570621-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710105907.2570621-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExMyBTYWx0ZWRfX5InZdmfvEyGl
 Fu6D6DPs/VwxIVyELm+q9C8K95cWQCIU083GkUiZjGqUqdQfVWBjw9Ym30foS2svXGANAMTxt57
 vWjn7xyujgdFaY6f/JZS9VLfgQgFBeEgyb8poHa//I89qfd2kBU3EoNIaKvnQLkYiSD6wQZfB6W
 ULFhmvKePzf22nSEAv+1/c8xoELINlYQ5Vajb3jf0MNrDDf6we+rPedw5QQrgoy5XoRr8c36Hcm
 ZfmiphMlWn9ggGZ/CJ5hwo8zxy6KAusUOC5N6pZZ+5l/oWiuSSVSrAReP84IZB+QLnMizCvvR7q
 nyd1slfoqsMY9XB5LYeRzgcl8o+pb103r4F7ircSNdszR+kDdxmXNd9WpSxDyl1TXxdoqiax7ku
 gM9fMV7yxW/CQ7Btkis/3s7vXOlmEIA3NVP/gM6ZLX4I3T69MuXPL7KbUER0s+H41JCcXNC4+X4
 zEHfyHHr2wqcNpk4eVw==
X-Authority-Analysis: v=2.4 cv=HJrz0Itv c=1 sm=1 tr=0 ts=6a54c494 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: KQjHO-h2w36TghKsBYDNzXSOESIJbvMD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExMyBTYWx0ZWRfXxunuxGH9g9wp
 0fj7UAgsOgAIFTFi96ve4NXWIO4IgfQ88abuohv/iYrDF1dhsC3J8H5NkyoeRzPr4pZ6FvjU4dW
 pZj7/eSB4QNiDzzoiO0DO8FDgs+XHM8=
X-Proofpoint-ORIG-GUID: KQjHO-h2w36TghKsBYDNzXSOESIJbvMD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130113
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

On 10/7/26 12:58, Peter Maydell wrote:
> Our current single OMAP SoC doesn't call the soc_dma_port_add_fifo(),
> soc_dma_port_add_fifo_in() or soc_dma_port_add_fifo_out() functions.
> Remove them, plus the soc_dma_port_fifo handling that only those
> functions needed.
> 
> The motivation for this is that it removes a lot of code that is
> careless about the fact that the largest possible DMA transfer is
> more bits than will fit into an "int" variable, and which does direct
> accesses to host memory pointers into guest backing RAM without doing
> bounds checks.  Deleting this code means we don't have to audit and
> update it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/dma/soc_dma.c         | 105 +--------------------------------------
>   include/hw/arm/soc_dma.h |  24 ++-------
>   2 files changed, 5 insertions(+), 124 deletions(-)

Nice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

