Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9464C9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB8tK-0003qh-Vx; Mon, 28 Sep 2026 06:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB8t1-0003m5-57
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:47:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB8sx-0005Nk-K2
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:47:06 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9MHoM954498
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 10:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S+/nYMf2SuyIoNtR7go2FiR2l7+JJFOGteA+TzXIpBY=; b=VrCCL/5Sau1TRs1I
 7AaTKm/dKrBWDwcH6NBJmC+kFmO3inDzLUvXQgCCl7RlS5TjK9h4A6RnNyuRW94P
 8b30RhZ9v3huGzIy6PbJRx5V5rmki20fOg9Tp4f88LcF8G5QYMtRmsZxNCk2xlv+
 zoftTF8XGHUioBFb4mIKDsvVTGh5R8eHquqd9IYpq9hz2yosdTWO9yKBnZYXlvQ+
 3Ew5Yxd94zQvZESn9WsPxGroRwxQwkgFOCzZCVw0DTyUUZddo8dFYQXH1Hlyr7CD
 Yv5+La/R9qI09+wMpfw1jZet4VyKVnwC7WEKrKnB96nTYe6AOw3k1tQpYCcwNFYc
 1NTlYg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynbc0bm0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 10:47:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a1de6d5c3so750932585a.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 03:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790592420; x=1791197220; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S+/nYMf2SuyIoNtR7go2FiR2l7+JJFOGteA+TzXIpBY=;
 b=bHNQVFL6HMS3vzzbrkfP5nEf83IVt9GfHulG2WDIq98BEqeS/h+z+AnAu/uquKuyEU
 yId5LRCKxFIFRhM1A/3128ONPuet1bAWdc11hDN/+mCC1HBODkVvraFbKLxL0DKLDyy5
 NGUIGQHHIBkDycNBDF0bLCmOIHZpsWeNFwG4//8DxR8Ma87JLr8O8uVpYGPL576smiP6
 ejm0+zBvXnpN1/V25Lw/IsCSHGTDG1ArwrYC4S+V4K/OfdRliVYpDDSkw91NOvLwVPSy
 kUxARrWhZmGADZ/mrc/tXN24aLsq1iEniddFmsQnHj2jgR+5M7K+nZmhYrOciZ7pAleH
 9AxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790592420; x=1791197220;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S+/nYMf2SuyIoNtR7go2FiR2l7+JJFOGteA+TzXIpBY=;
 b=en+CLNDYEoXXTmmpFccaBjKmNXQjzTxEZoxgzLR/gy37tMEs8LzIE9W3Sum4IXfQOf
 MN9TifWWZG6zEi9l/l9fjJmjRQAWWAL/P2y2CbhrMeCbM3TPr1hVMmPgXctS5LgbkWRX
 0GKFQRW1/BuWKJG30JbJsUDpwE4Bg7pt26+fipRzkV4B6FJqFATBvsQldF8h4FqArZD2
 070nnFaZYvXF621ZuB522MvbN0bQuzWLeJ1NrrrcvPcDq3qp0XZhcVFDF7BvYXm6g8B9
 w5wdYYnASceC2EM30qjQKaKotIh8Q7LgnkMTceHea2T14QENTVLuvuzCLSSXwRaKdITb
 aXpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByLh1BY1HOluYmYuY704iElH7gEz3SgnFLurLXWQPRyZBGIfC3ZsCkSrXVWQTdSnbifNNuS1V6qaFjn@nongnu.org
X-Gm-Message-State: AFuF++mI12cD33wWMFK+V0O3gPzALhaAKy9yNTlVjEtaNIaFtzZJYix+
 m+BlEeVTUQDERA5HDCMU1ctPw+m8zqi2lVk/EOMLV6pkm7ZQwhxkWS51Exxw8ZCVQNgj4jnnKJN
 mKpR2AEUen7dFEw+X9QxnKirXLaNiweVLig0QzIA3BVBqFW/jziylGewOqQ==
X-Gm-Gg: AYBFou1HfJBqGUOtNob+cRTSzKGm0kiIf+Moi4ZnNWXaaScTkl4hfSO6xloByCD3j2P
 0S92YX/P+uAkxX5kMKzB3JQlFaLOpV4hxRnZfQkpwPP1NVP0607NiMgEVyAZ/iJEmd5TMTOaO1v
 oofHJFwVD8Djmv7Gow9X4OOgZgpKOasjj/qUbloTupdlpCLgSHe+Qj8q76L/1EyVan/QAwHd0K2
 16tvlCvtUFjmUBLH3ZgVjh1mT+20F4n7e9HgpuGIl9YzWuqPiS2ypv/0++oMB6hsWTpsF5dfj9r
 ihrJNKjSk2SBf5Soug9aVVl0ovRrNiHMf5cyd504hGE1cwQzWktsyY/RNojv5wxco7ZAFsq7uJA
 2z+8u+mJHddA+DOpsRYE2vuR+uCtY8AvsxA==
X-Received: by 2002:a05:620a:690d:b0:937:5298:7820 with SMTP id
 af79cd13be357-93c43cc592cmr2019429885a.8.1790592419736; 
 Mon, 28 Sep 2026 03:46:59 -0700 (PDT)
X-Received: by 2002:a05:620a:690d:b0:937:5298:7820 with SMTP id
 af79cd13be357-93c43cc592cmr2019427485a.8.1790592419338; 
 Mon, 28 Sep 2026 03:46:59 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017998dbsm191972255e9.14.2026.09.28.03.46.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 03:46:58 -0700 (PDT)
Message-ID: <bc88b031-70c1-47fa-ab0a-3de743bf4d43@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 12:46:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 073/101] tcg: Generic expansion of tcg_gen_umin_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-74-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-74-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Sq4Fe/O0 c=1 sm=1 tr=0 ts=6aba45a4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: LRD26qc2fRWtcwRK3H7KIjH_Gkusrmfa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MiBTYWx0ZWRfXzE/N9XKLxlpB
 zrmXFKQ0kI4TAR9RGVAI+QAdgrLu8/vwkDBjd3KplKGy5c6eESgsWb0DNqDH3g73dmMe1JTB3Wi
 Vo5MvFMsU2ioo+QHh6d3+hsAgQ86SAfb9xQMcUBa33bmD37u4APe6eiMOi1Vk08NQ7M73wWLQow
 lypbUj2x1uFCY08Gxk0aTZgeqD2MZb3RZ/uW5wO3IcAwSA0hlV46uMTnfGynY3ak1tAV88fUNiw
 kwgUe9Cbp+ZbwPc6BHVZaRW6s8jqymNeiABnrWIM22Y00MNC3WnVh4HqVpUfrVDFVgZXgXgG450
 4lUg+1mAMaI5wzSIix/IOAOXVXW3LP/Yoe/+prb9S1ewqVPksr65b7tBK+lsV20JdmXxxoYhNE2
 cdOJl7DWFPO5dmhSKZsJCiYldTxbsLEvG7qmA1S88lYnfN/xuBYkj2p15vFh+C+9mO/PIVfe2EP
 CQyg7bX12EsKJk43OoQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MiBTYWx0ZWRfX8rGeBY6weJhv
 PX8xjhYA+tMl6DYzYv4/u3KwJVr3kCPggH8xEjJl3+kbTnjzQfD4os2ApPco6wripD5eM7aJUw4
 s1sdv9h9vxr6WqkqdGMaDuz+Uy4f3NM=
X-Proofpoint-ORIG-GUID: LRD26qc2fRWtcwRK3H7KIjH_Gkusrmfa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280042
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 27 +++++++++------------------
>   3 files changed, 10 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

