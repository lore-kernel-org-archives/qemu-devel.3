Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BC9C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 05:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whKWU-00078L-GW; Wed, 08 Jul 2026 01:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whKWR-000784-5F
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 01:08:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whKWO-0005PJ-T5
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 01:08:34 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66842aFP1667900
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 05:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XgR4wtmwP7w1QnHwTnQyNfbdL7Tc1aCAgLTf8gtHK7s=; b=NaaaaLRw7K1ISHTK
 HS90Qjx2eSpnq0cekODczZeutGr1t5T+c+IDQo6vVVwYQ8sthniRCiwvn0yROv1r
 57VZNtPb3mZaccDHbHFxBZh1H3CfJ1/zprKs5cjFCGHhNL5286WjEj8JYHeLo6QH
 yVJCwfAVvrFXPbSoMcjQ/wElFjG6T12LvisrL3W1Z8mjHpCUt9IX3RYaPM5JqfWq
 ywpxBptqwFriZBCCjqwOsdDTpFZuUvGA0Z2NjxBJZ6eLEx6iiCRFu/r/xDJ6AO0p
 ZzRpy8c2VH97NuoqZRPZ4OamEArmeRLIf9fnf0CKaJx0QLZwD3LUtSkdW4tLqyl0
 Utelng==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95e5tqbq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 05:08:30 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-517e054fe07so4960381cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 22:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783487309; x=1784092109; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XgR4wtmwP7w1QnHwTnQyNfbdL7Tc1aCAgLTf8gtHK7s=;
 b=Bak2hB+HX+TFEL+n/qB81sVcj6RV4rRyopjcAROSMj8a1++vNz3tY0ajMFlXTtdvch
 HO5ZQeBBUJewGrcaoI9eji2+tD5LIvQqz0DNxEXYfBfvieOMxbqXeR7Y7rY48T4zjwNe
 gc1m8rHebUivx14Q0yWwvnIuImw7o6Q5oJDOaWvv54SUfbzdUAV1uYONf4oYovi3NnSX
 DNMhDx6uPiZWzJne3AoB5np3xdShV9koFrPm7LqmHlgiOT9Jm6IZlVF9hOCWZopY1hyA
 EvsMIfON1P68OhyeZsqQ4DcZxjObb/RRRvIraVz8PrZAyj31zs/lRxHb2Y/YBBeglRXp
 8KLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783487309; x=1784092109;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XgR4wtmwP7w1QnHwTnQyNfbdL7Tc1aCAgLTf8gtHK7s=;
 b=LkLLUQ6ePJFD2G62WXXCHcZD8hsa0Mn5MgWLKPLaItYRcWzXaHyU6f3W5TnlTqFd2g
 qF0WGKz2P6ruBkbXe8/S4lHTfX+CBV9yPaE5ZAz/RSAmV4KyhPrxohXHye7Zq7ZCsWGM
 oltJnDW9cGxewivEvYUn7P7zwrfvA8lRVSaW+phrG8irVLXa4IRgCgd4irilNQLs9lFp
 t/mx5QpjVQ/6eAMf3xuaP0qDKiD0MQvLkvHeJIc5asVnnoZjmrSFYVSsJ+tpE9stQJ/V
 /oaRNZXp7aiFB9SJ0VuXgTzvcaQNCq5quVHzA32BFSNqTcyTNZ1UpPSmjMNBlwAkfgkH
 AMwg==
X-Gm-Message-State: AOJu0YxSpiFCgidbrPbOfDHEEijsMGpcSQkHbK0Sl8QT6DLTQZnYTzrc
 /1oofZ6Ep3E/0GDxTYnNA8Wf0It8EWKqzUvLNtHOd8K65cvtIkwY0Y3iPovqqF7IdW5hpzJTRRu
 ZJ9H8IDyFoLDPaVQgjjvEG1mzVqPqX2yG6xMrUesl+T4YJc86bLbjJYCWjA==
X-Gm-Gg: AfdE7cli/U5b3CqoMmF8WN7xPfVXCk5nGOMURjRJ1L5ABozvFIjOgnaPTFQHpJ0ydkl
 uVL0VuinKaOF3rAoLN4Z8uoqdWU9Pkwk4VxSgfCdfMMtW3zdUDZY/yOji5clw5abJ8ZCk3eZkCQ
 f3ILuYCzGhZSx2/IDKDU+/RfPVbrz6N/7+39EBSMRAK8HyVb2zATHhnzlB8ktJF1tmx9LOYcYWE
 Url9HwmXECbxUxTyCp2oIb9rOeaWEgplT5NrhPE2qJCVCirCkFZL2wj4LQBOTUCnqvUF4D3z0rG
 E645VaUDHgClBIOKPnKdkwDAgYSncXEdXtRCmtdIGrI/nZLR08J5rr7r/uzU4taKrhb8tdYgFa0
 12Yv152EerXLf5TadBDzfBmpujSYhp8M=
X-Received: by 2002:a05:622a:258c:b0:51c:c67:2042 with SMTP id
 d75a77b69052e-51c8b49aabbmr9682761cf.53.1783487309592; 
 Tue, 07 Jul 2026 22:08:29 -0700 (PDT)
X-Received: by 2002:a05:622a:258c:b0:51c:c67:2042 with SMTP id
 d75a77b69052e-51c8b49aabbmr9682551cf.53.1783487309181; 
 Tue, 07 Jul 2026 22:08:29 -0700 (PDT)
Received: from [192.168.69.209] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e54a067dsm27608265e9.0.2026.07.07.22.08.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 22:08:28 -0700 (PDT)
Message-ID: <a1a9ca36-7742-4c4c-bec5-4de5fe92bb7d@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 07:08:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 02/25] target/arm/kvm: Return immediately on error in
 kvm_arch_init()
Content-Language: en-US
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 jpb@kernel.org, lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-3-mathieu.poirier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707224306.1202330-3-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8d2FKgafyNd-suRb41wvSgzZYZnYtTdx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA0NiBTYWx0ZWRfX/gogay4x17Ko
 OS2dy6GUAP1gYWHu6YHpUd7LWoCeMwazgOdPlc2SWfBOqp73TvULJJ5AYibbUKYqId+xCoyamWK
 9JeaWBKx6ee/6h16H4pLWJ0URbuEMDg=
X-Authority-Analysis: v=2.4 cv=CNoamxrD c=1 sm=1 tr=0 ts=6a4ddb4e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 8d2FKgafyNd-suRb41wvSgzZYZnYtTdx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA0NiBTYWx0ZWRfX2jsSthy9aIhF
 t3XwGLFmTPNWssOPrHNhW+kqxYhwG1TPYVdMF8nHF3QOclRVE6Bn12EQdnaxHTDXizziksMsTa2
 2QIbQtNG4aGFchLkLKGRa/Bagz48X7sShGbVBQq3libW4sFLchkqVtvHBTKqQEJiT9MmitIIHUf
 lRW4HlCIo/ES4P7zfikaVmQwR2EOE9KAk/bGUPqDFbVgxS14hPCxRAflZ89H9ck+VbVsBlZmIzC
 ex5QYqwvHkkcnJq/NHgcmRZplCiGKvUEemQ/jCSPqzvAKjMh1MwKZ8jR1HtFzYS9Ilc9rRnNHXb
 TP7BL570OKJCBSzuJK6bG+kNKDZOGPPbz1zjQ9oZmDgi57bGzGqIR3vk0pKiw4Bf4Iw73fA4svd
 BZIU6BfQtFO/WY+23Eim8qDvz4ZC2NUOTA6q7knHr/8/c11o+zBKdEoVNiAlL//FeCUgfjWt5p9
 YIPMNO5ahFOvBt4H13Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080046
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

On 8/7/26 00:42, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Returning an error to kvm_init() is fatal anyway, no need to continue
> the initialization.
> 
> Leave the `ret` variable in the function scope because it will be reused
> when adding RME support.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   target/arm/kvm.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

