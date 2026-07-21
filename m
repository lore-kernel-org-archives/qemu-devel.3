Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCFAC44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7Wy-0003vc-RM; Tue, 21 Jul 2026 06:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7Wx-0003ur-L0
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:16:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7Wv-0008MK-3Z
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:16:55 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66L8hoaf534739
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /ZXHq4MF7lH3EMSRkoGZWLXhin8D0GRMqMiGdC9iHfQ=; b=RphHM2PhB2n5JwRC
 I7kHsAFnbV/yL8Q8WKLlP5H/XhIEadSdLl1ahJAfLQ0XGEgM0rfU2qFbtz4GDisv
 OGvgQbSHvDq1Ch3pxKYEmGNnj35jm1ZwXy8Jo3EOOEQ2zRpjvSTF9P7zVq0ouu0B
 dTpKQkINTRLzSIcDMlH7I7RGddkM3CAepOjTlwg4aubzZJuWfG2wCo4y3UvVym3o
 qSwegUpuLTG6iXG1R7BI7VF3eZjQxY56iDYXqm811dSIEbE5esveYLvtT6xyjhpn
 KQhaX46pmQ05gZiQAP6kX8F9CSGAMzDhBoQxopK+wJ4mwBbrkkBo/OBos4u1TNKL
 UlOE5Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1duhpbd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:16:51 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5174a236220so205028401cf.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 03:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784629011; x=1785233811; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/ZXHq4MF7lH3EMSRkoGZWLXhin8D0GRMqMiGdC9iHfQ=;
 b=ej38AfWj2DIo0s5OZpCHxCKkAUUT3nNgzB5bq5oQLXm/Q5FAlNhLXc9UqndfTYitBU
 +eej5LkLdmV3GoJ86I26zHe+I1WLnzefK8Mh2rqiPE3GFY6EzOpcExZUYA3Z9BJLCTuG
 10pX5rSu4/S0rmCxIPULzkHHikad2hPx0j5+yBtJdyJgAfGfbQH261fwyfgFKmofhYaF
 d/zUjZRXYEJiTZtICKfINJcdxza2rfa2YNQ5lbLYKrKjV4XFb66IXZ1Dw75Xl3ViNv8f
 Y+Leq1yhZ1vi+elM/M7+iOfXy5hEz3N3KwN0s/aCG8uQrh8Yyv9Hw3vjoo7ZjctirP7g
 JKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784629011; x=1785233811;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/ZXHq4MF7lH3EMSRkoGZWLXhin8D0GRMqMiGdC9iHfQ=;
 b=PWIjeitzp7UptocGw6MOqCuqINMwg0La7PIGZAjVutR3ofEZ03Go8DZMvfc9Uz5vMg
 u28tbFX+rh/qZX7Fm87iZVbji4WBLpEMlNdCIccbuEK4HpT2FHh6WVlKyz/dt86wIfCj
 cgocVKmEitBo9ruxM3lbutgpOLnZN7nZSKF+jbXmtB0UTlnkER03jJI0yrY7na2J3v0f
 Sv2fbvFeGjpLj3cYrgZFM1MABkIY/V+G2xzGUd/ehiKM0Xy96fSexs6lvvYxbx7XBqNh
 sQvpjsAVeYJHNRJRhswjTWIVnIS0NTDMbsPuUE2nKaZYGM4c17GbCoQQNtA1fnJJskAQ
 l5Og==
X-Forwarded-Encrypted: i=1;
 AHgh+RrmaxcTmVTy8K4kEyKnileZFKi8Kj/d4RxAZh/RwO5NtKv3EGdCycwNV/hwcOQhO+Ta4NlQKbllf2lF@nongnu.org
X-Gm-Message-State: AOJu0Yx2n+sGFJ+Vvfw2syjxw6Xev00OPvu1BvnsQD8qRB6o3jcwf12j
 hmyGIaEK3kJut1dup3syvJF7TulCdNYR34yx9UTmmxwQXTeu7JK4qc5PZwKcJUZK9jKJIP941a+
 vvnuk0r00upWKNriHaPvaSyqoPo6U2R/K9B1JDlhBdZ85/hekpK4E/a0bgbN4zUVrzw==
X-Gm-Gg: AfdE7cm7YTe7pEze3Teee7txX201ipYJDsNWYyNf9hhyCL9zS3beh+74cLUf9CPAX2q
 6LU1W67Y8feapyR+K2lVJFWDpittQDimsuqr0fGOZhzTvTIuuPew+yt6LG4GLcyQo66M7DXYVuE
 qa7RJ7rhiOTDaPxJ07JqsKlDOTeFqhZ+QvdRcfaYl83jh13IDm6fErN4QPoJ36Dsr535oZiKE6q
 i6bkmCkLe4ubk7OHg9kswJX/m95L9aPfs6OOtEHPhdQnFimH3Bke4MjwTjZxqnkZ80Txnkdj9gL
 4ZWcUbqluY/KbZTxLde9v9xnIkIB1rsEQFJZeuQoLngHI81976O47RTy+iWRiiGzFIBr2t/mXh7
 9O9AJFdIC++y72ACAW3ERYbRmcoNXUiklmJAkycHIGjbme5YXewc=
X-Received: by 2002:a05:622a:2295:b0:51c:ba4:d837 with SMTP id
 d75a77b69052e-5213c012055mr159253641cf.18.1784629011093; 
 Tue, 21 Jul 2026 03:16:51 -0700 (PDT)
X-Received: by 2002:a05:622a:2295:b0:51c:ba4:d837 with SMTP id
 d75a77b69052e-5213c012055mr159253311cf.18.1784629010460; 
 Tue, 21 Jul 2026 03:16:50 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm60491435e9.3.2026.07.21.03.16.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 03:16:49 -0700 (PDT)
Message-ID: <be300233-ab2e-4da0-ae8e-f3afdfa27de1@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 12:16:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net: cadence: Return current Cadence GEM queue pointers
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: qemu-stable@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowangio@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20260720120731.2022475-1-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260720120731.2022475-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: t5CdAwb_DKjdyGmg67V-5EysN4Gro7Aw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEwOSBTYWx0ZWRfXyT2lTTOfgpRl
 2ErggbpoEZ7wXti9n1vkcmN5OoTMH5CnScGLA31RaN1MEE4kP/E2OFQd10YhB8Yn1F9w1zkPvJ1
 y99sVNPuOT2C22ZdgRHLzA9zLzki6F7FD0rhD8rnorfUxDobguixLjuTD9rnyJA5B2dhQ9S9Xjr
 fyU3SpSrXmPfyGdD89iIAYqZTcacywil9wNgPhM96//MrpomhFcP5Gj1XXBapYGdcn6RQbi49Rm
 MnNbJOvIWmyt3NvzXRu3K5z5/B1xR7qJ1YU0sK2k73yirCV6Y7uNjgrWxLbSWhgYyPHw7bOJFLw
 fdIT9QCOxDvRs4ZRMqwhSg25oVUQj2/VxUuPF0eEN6DOInw1G8U9drsWefr+oSNxQhA2tpwmWwX
 ZH3A8kS55RpaVV0M22sa2bIkLDBqFhbs2K18dOEyo3VPar1izv6VA83S7mp3liW3HZjt4sOjJuE
 p/qnlf+VSGZ+gY6Cx/A==
X-Authority-Analysis: v=2.4 cv=I9JVgtgg c=1 sm=1 tr=0 ts=6a5f4713 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=69wJf7TsAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=7Ce04qy9-wfap1NzfZcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: t5CdAwb_DKjdyGmg67V-5EysN4Gro7Aw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEwOSBTYWx0ZWRfX2u7/otvR3I5r
 GZvTllhujjpoSxMss6JXJl7+BLXRCae6F5P0sXRzPv/FXuwk2TZf4qYlV4f6T1VIFWJ3aIYyFzk
 rq7IJar++sqacuKtCcUK/nfooG0J+Ek=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210109
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 20/7/26 14:07, Bin Meng wrote:
> Cadence GEM queue pointer registers are programmed with the descriptor
> ring base, but reads return the descriptor currently being accessed.
> The model tracked the current positions separately while continuing to
> return the configured base.
> 
> The Linux macb driver uses the transmit queue pointer when recovering
> from a used-buffer interrupt. A stale priority-queue pointer can make
> the driver restart DMA before that queue handles its completion
> interrupt, causing queue 0 to repeatedly raise TX_USED.
> 
> The primary queue has had this mismatch since the initial model.
> Priority queue support later copied the same register-read behavior.
> 
> A single-queue machine usually handles TX_COMPLETE before TX_USED and
> empties the software queue before the restart check, which kept the
> issue hidden there.
> 
> Return the current RX and TX descriptor positions on queue-pointer reads
> and clear those positions on reset.
> 
> Fixes: e9f186e514a7 ("cadence_gem: initial version of device model")
> Fixes: 6710172501be ("cadence_gem: Add queue support")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> 
> ---
> 
>   hw/net/cadence_gem.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

and queued, thanks.

