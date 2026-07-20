Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C659C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 20:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wluXN-0003Ss-P7; Mon, 20 Jul 2026 16:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wluXK-0003Q1-2C
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:24:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wluXF-0000Pa-La
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:24:24 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJTauw3284324
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 20:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YmvF2FkOvfrDG9pg4eUONKv9+oF97+HKMxgB5hR7SDs=; b=l1CE6mwIAElAWfi9
 F9xWPikaLeOmciWy5sal2XKNzd5jff/jUHgIucUhQO8i8lasAIxgLvfzlncvHG/z
 3yo8ewIiq/7PmLB5n5BDPQflL3VxGmTu4u1zeZpvxkNOrXpezZLWAEWuBFqHtDjt
 jV/xB58+0qDpXcyhcZsBHlMShaPjEB/+Yu18TMZOV4UZ+DV/LcYRtNJOGEzzf9ft
 yhOJPUeLr+EKIKS7GgOisYsmrLVCR0cl7ZVFpJF5w+BDCO/GtkYqDULU5HBcrOJ9
 uSBj9Z7LMnz9BJiOkKzCAGqid6HTlzNGEx+My3vNd1YweGGBv0cFURuQJAc/PAiv
 EgYHKg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhh5y2urp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 20:24:18 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e820609d9so1300383985a.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 13:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784579057; x=1785183857; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YmvF2FkOvfrDG9pg4eUONKv9+oF97+HKMxgB5hR7SDs=;
 b=O+EQUFFXHkCDu+Y7QS+xBk9DkSDBZY+8rvD4bDJNAtmhEilAs4UTU2xbVNZthenkiX
 kPOqa9wRn2UVSvYBR2XOaO5MwvdEKrw86j9HFAgwHzr0i8XLcoSk/AS+eLadjbWbCiRs
 w+4GsZw8X20TEQGIK3AK6MmSs2xTK0BG68YB4Dt7kcMRBpP6DLdI0pONxZjdATd3XS+Y
 fyz7BkiqlX4Zc861OQh6HfGPCgL6SxEYTuRRYMT6LoKjVkYDnNBYgf5oBNyXEpa1TwDl
 +Cndnij/e8sB3yJjbBjymhJkeCza81OSAQgEIKXSmxC+bvjRZ3JHokxF3GsnOD0WMM/1
 Uu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784579057; x=1785183857;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YmvF2FkOvfrDG9pg4eUONKv9+oF97+HKMxgB5hR7SDs=;
 b=BMLKVYTummXNGkmKH1pKqnccviD4yEyT7e8Oxb4TKlD+kiZVlWUSo7C6OZLsyADH1a
 X+N8MepjiovtNffpA1uc5lyaEKTrajXaLVxUC2yEe5i29QirjkH49zjaVu+xuZc/V5k6
 nQ+QWe/DstPP3QQh2qXHDd7tE5bHL5X5PMQ5v749dCWbhjShhpQyIJw8sn7jCARjRywx
 hNPoh4FF8PO3qNNz4SU9cxQUUGfjp6oEgfIMTzaIj1yJr/W8b0NETgeaPvhCfPql02JX
 +kQaqZqamfWUOn5s9QTfwiuYdZiJ8+UIX8yQWgf0qfdoNNNhNhRDHDaagF42zpYAxdOz
 5DTg==
X-Forwarded-Encrypted: i=1;
 AHgh+RogU8bd8djvv68xUuHotDBDXObMRx04qtyU6PnE6oe67iexjXvYIk6gqvfDvpQLc+K3tVGpWze4/697@nongnu.org
X-Gm-Message-State: AOJu0YwpwexWh8SZm4MgZfri1PUq8u0+Vw2Sd7OnY7sMp9YmZN2FelVC
 xHxAgKrrod1GJ6hFn5NIeuYipPxIOLQiIjEFUvUEEEOsB4WOZbPjuaen0p9p/ZYltz+ejqqCmHw
 G04rdv1aRa7DjsjvkIE8W+N8++Xc6HeTY/xMmpRLM0yENl2yA4PATFzLapA==
X-Gm-Gg: AfdE7cl598ZqGzcKthIEsPq3Kk2rX4WzKjh+lhs5EQBAetzLghtgLkG4BtgfV2ZlHyo
 ub2KpAhzUqDx2SA2zbpEnYYjcGfGEa4In8fiSaDWL7iOIqENQfO/2NIwNhI4+61GtGRFaF1ZMom
 BVa9vp+aogYIKvwMBOI9LFAp5vhD35TezQMKSjv2ojKE5IKaVHom5CCpVQVP3p8v4floC3lT9AZ
 GC+JYxuGICzf8M/YVNuW3LsFHhC0cqar262D5og3c9W4MULk8t8siMM/vDhnVutsRVOxkiny83i
 QhmNIuo19PhZFTf2R+7MkDirl3dZia/pMuXzB4aRHK2Bfm/PoqCccxw04W9GPd9M75NEbVzGHxn
 g9YKZr7aVNzx4e/c5GXzOH22NqUIz3xgVFGTl0/R673GKzG8rqlc=
X-Received: by 2002:a05:622a:1909:b0:517:8470:2d2d with SMTP id
 d75a77b69052e-5213c9dc20bmr147351571cf.29.1784579056994; 
 Mon, 20 Jul 2026 13:24:16 -0700 (PDT)
X-Received: by 2002:a05:622a:1909:b0:517:8470:2d2d with SMTP id
 d75a77b69052e-5213c9dc20bmr147351331cf.29.1784579056445; 
 Mon, 20 Jul 2026 13:24:16 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63edcd13sm32293685f8f.26.2026.07.20.13.24.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 13:24:15 -0700 (PDT)
Message-ID: <be2ad7c2-1a56-49b9-b9a9-c91c025d168a@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 22:24:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc/cpu_init: make cpu listing determnistic
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20260720192403.66694-1-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260720192403.66694-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIyMiBTYWx0ZWRfXwkM7zZEvMswR
 ORZrl8UJPQfWuuORpZPWQUrEIQj4v34ZnUURp7bqmGkdozhj2K7F25CQb7lHm0ec/nwYERVylb6
 fBvawGqhkJ0KUbXQcKqyNCVthVmr/0A=
X-Proofpoint-GUID: eb4afYvzxrC7gurVfgQhaffF7NZUTvdL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIyMiBTYWx0ZWRfXxjUyaofqkKkB
 WPPyxUCGTE/xnOhA8APbGYMSPAFdVlAwTyyH0+bOWFY4u0z1fnIv5JabOHKUDlOr62JxUozlXIe
 fij+yoxzMiYa19rGisgtVeiMlMndDm4AC6YK7fhkQfHCONjAgxIULE17j4Dfbh31SKQnW4X7RAP
 j28i7HHHOWHYzFSBkMSRM7flS1p+VjYcU8VDsQhL6S7LLA2ar9OMwq0d1CjylOo7OGdnRnMVY01
 X9OM1Kj6CFP07qTfHE+RB19YunNe9bj/DSZtBtcA2orVROE5sUQ7Q2JpvG3o9jJ/93+qR9JIng1
 qFbTpDl9E4Vid1QaOqmNqq1F89V/KdLGY06UQDYNoMDClMQTIzMrMwCsnGNvcyACTnFeY8A8Na1
 HBdaztMHGdIUfpxR7tZted+QyomNk7aWdUFlSQ0BIVDQYfpTc5s/HWIAnrZPn5K9K2+lbdxNIZp
 yYP+5pNl2yXmdWd5NwQ==
X-Proofpoint-ORIG-GUID: eb4afYvzxrC7gurVfgQhaffF7NZUTvdL
X-Authority-Analysis: v=2.4 cv=f/x4wuyM c=1 sm=1 tr=0 ts=6a5e83f2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ybKMF2EBzz_YHPg-y3kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200222
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

On 20/7/26 21:24, Pierrick Bouvier wrote:
> The existing compare function only make sure that we list cpus with PVR
> order. However, we never compare cpu names.
> As a result, while cpus are grouped per PVR, the order within a group is
> non deterministic. Depending on QOM type initialization order, we get
> different results for -cpu help.
> 
> For instance, previous output could be:
> Available CPUs:
>    755_v1.0         PVR 00083100
>    745_v1.0         PVR 00083100
>    755_v1.1         PVR 00083101
>    745_v1.1         PVR 00083101
> 
> While a sorted output should be:
> Available CPUs:
>    745_v1.0         PVR 00083100
>    755_v1.0         PVR 00083100
>    745_v1.1         PVR 00083101
>    755_v1.1         PVR 00083101
> 
> Fix it by comparing cpu names to have a stable result.
> This allows us to record and compare various command line results across
> versions to make sure we didn't break anything while working on
> single-binary.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   target/ppc/cpu_init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

