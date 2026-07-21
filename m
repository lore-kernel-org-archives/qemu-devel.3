Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C767EC4452D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7Kl-0004Tg-66; Tue, 21 Jul 2026 06:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7Ki-0004Sz-Ak
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:04:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7Kg-0006YK-5T
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:04:16 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66L96cHD527245
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4l5nYDzyjQzg7LcePgQpOJA/WP+TsjLazFZHtDqRUEI=; b=cbNMmYvNA4yQVsre
 ZsgJQKR60zH/+6PBpKudaYPaFzP1CgiG4bWS3f/a3weT/1EG5qs2ATPXnADTnLRS
 ckxXmER+I8NJB9Gr2kkPQFkqYb+3XpV9LUlJgzVK567hoNys+GUCc9MJdUW7gxju
 7WRPe2p7t14bPMzC+Ys6S0/A5gVrrLKOS6TlvCprLx8312klQiHCTcgQA9D2ZdG2
 CQkfEJzBQzKcCKL3HxKbeLTQioXWDqQBArI76bJqa5tK2g+GDpYnbRI+MzUBvAeh
 TzSo12NH6+YMM2I9cgYXD/M1ihpE3vbDJVYWaCr4qM2x9gj0x7T0V1RAvdG77CFg
 y4/DlA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1se1gb9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:04:12 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8fc92c5373bso210463616d6.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 03:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784628251; x=1785233051; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4l5nYDzyjQzg7LcePgQpOJA/WP+TsjLazFZHtDqRUEI=;
 b=YO8k7es2kt8yqm8VVhPHUJYJjMsovki5uS2cAlcH/wOP4JH68K4XXahKsSs8zrl28y
 se6PYTt3pjGy3JnnAMQM1aVCgYWZ38gwPP7KY5N6zC2bw0Xnj16j46AeEqGGpzuMzkCt
 eREw6BBQYrSC6Q7LZ4Tnra970CgSP1mZfC9r4TNajbnpz0N6FZTFuzb5Rb9zdFVv08UI
 VfHp/0tWA/ZMWV6jRs62y5dsFX4QW0zW5CSHik17wdxOlVO5ILWXP4xLdvMHZZ2PoZar
 xUOsBmPVxfVjXdcVmQo4Ix+y2lyjptj29/BzcAFELX8p/Dq6mkJpYmeZ/IBWrye+1A2z
 yWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784628251; x=1785233051;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4l5nYDzyjQzg7LcePgQpOJA/WP+TsjLazFZHtDqRUEI=;
 b=H/w9HjULrbgCJGU+xcAjjGYqODaN0IG1olO+6+T4R8etens8oNtyY0wj4M9rWbnW0G
 qeloxKJDeEWynm8IvLRoGK1FqgQxSRUBUjrswOm+uJzGpIsRDuvgYRi+HAn++oncp3nG
 iU1gvLO4Ne6f35jx9Pu8aDOtu8PgRxHm6KXUwS90DwYsuRRtT+WFQq1r8Q7AoYv0LaxG
 C5cNGUYJTP+Oose/BirJSBZYAlcUhjN25aFS+MeLduqaSSVCDMvdB6WVuicK8AJPl5XM
 8WoayX5R3jJXiIKiKjF1WHRy/5lzQxlzsJjmhLtZeMRFtE9XsoJoPrj7L2dCbii+krwr
 HO3w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoHT9xP41J6Yie+fqt5qexrBBQ2IDmoFvU4lp+dq+DvzpYMARoMhjYrDFxOL1SGAx1qnEW/9d8u7QtO@nongnu.org
X-Gm-Message-State: AOJu0Yw6T/qIHkkz5ogc+b3v/gxn2Fx/mTwd0oVOtcdjbEibXXogQmZM
 XkuZOay4KTeXO/UvGdJ9NQSt1SiYY8p3v/uuwkH8AAU+K+7pC9sW1VrjdVpM/TyL4NPKmICEArs
 TkdB0T96XDomUD6ibydWvak6/5iSZ9B/WU3iLRynUnfz1QIfoCQ1RCt6xgQ==
X-Gm-Gg: AfdE7cm2NIIS44U/NPqXfceG0gtbckGM3YagBmtcnbBXm7bHEXNjie6pgmkudX8QNfB
 vVMYhOgPWt/vJsuSwxMahGeoeemM7LP1XsJnxoliuKEho4V95qXr+O7p1NiDH53Ex7VheIqIjmj
 ms2zmbzMlckcPmUT3g1y9ec3wev9w+qDUBCq212mucJ/XSbaYULMNclumPN9gpuMi4WkjLf+Hns
 FxQZPi3v+Gyu4yphSPV3Sfyk2CLL3uhHXWEHh3VjyzL3CeXmme+NrTULwjOyaWcKMupUQ7UC0Rf
 kbWkZLkTBU20L/BFhLEndClAKb066Pd8LUP+xwQTu2KLTfAP9CbHCabugzH3qxc+QsftwwTBB99
 DKpvcAqXb08BKEaFRsLVQfOoSWOYcGvamJ9vURPWDtlDr2qThA78=
X-Received: by 2002:a05:622a:1196:b0:51c:1408:6c12 with SMTP id
 d75a77b69052e-5213daa1f40mr152076941cf.47.1784628251469; 
 Tue, 21 Jul 2026 03:04:11 -0700 (PDT)
X-Received: by 2002:a05:622a:1196:b0:51c:1408:6c12 with SMTP id
 d75a77b69052e-5213daa1f40mr152076431cf.47.1784628250881; 
 Tue, 21 Jul 2026 03:04:10 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49565473f76sm57914455e9.6.2026.07.21.03.04.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 03:04:10 -0700 (PDT)
Message-ID: <f066ffa7-a7ad-4e88-a921-31e3bfdbdacc@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 12:04:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/ide/core: Fix possible crash via NULL pointer in
 ide_cancel_dma_sync()
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, qemu-trivial@nongnu.org
References: <20260721070216.82984-1-thuth@redhat.com>
 <3f8027d5-f7db-4fb5-8386-1d5f93974a10@nutanix.com>
 <563e1a3e-1420-4f6b-9244-9ad4360c207f@oss.qualcomm.com>
 <e705d648-eaa2-404a-b654-a15b1648e0a9@oss.qualcomm.com>
In-Reply-To: <e705d648-eaa2-404a-b654-a15b1648e0a9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 19qmKjlc5NvXuo3RwdAc0lYE3Wv4_C28
X-Authority-Analysis: v=2.4 cv=TIZ1jVla c=1 sm=1 tr=0 ts=6a5f441c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=RpNjiQI2AAAA:8 a=20KFwNOVAAAA:8 a=crYC2Z-dkR0UYOLnY4IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEwNiBTYWx0ZWRfX0r9EavMbhjqG
 LMQqKWSfzGIPxyOFvF6FgJ6c5+N0cNgL00GNWRXOCufyXJHmtiHLX5hhZRZXzFcpMNRrF9iY/dW
 hHo7ESVG75PC7T6Z0fNZxBf7dDR+FIU=
X-Proofpoint-GUID: 19qmKjlc5NvXuo3RwdAc0lYE3Wv4_C28
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEwNiBTYWx0ZWRfXySfbS3yKzQiR
 U0KWgt45kMtDJPU0BylgSfZwv+CqUcQw7yb9oypg/zME399qGany55EybB/U7H0+oTKrj47EDNN
 iG8nGYZerzkQ2OJQbpedNabEu5GzSBIqcvTuo/6F2blr654s+Az4WLgueV2xEmxhj6E0vXBQGqR
 PqZIKFoS88WtR8XTNEw4ZiFaK7EkKvb5gsb8pDiUl8dsnbGsDa7FjhdDlwCrmCYH506bFTVkRx7
 K6zu5djDS4tpyzguPy5l1MWPwb3c3Ohh1Ly45qh4IVLm4o3GDZp28u7vgcb9lvTAft94ERFrlHF
 DwfDj+5/76LATJ90XIV2H3Txvv+QFU675k/h8p5v0/fCSaxh9wkiRSP9m2GOW7MZaQx/Kve6X9a
 QLGQ4NyN8Q0DrrwuAhk+aKyKJS9nc5MOHcH7dShq2k8G8aPpaojDZId37cJVIzdZQ6b4NiOJ6aS
 JcU2yjq6NgpSzvd/y1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210106
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

On 21/7/26 11:58, Philippe Mathieu-DaudÃ© wrote:
> On 21/7/26 11:51, Philippe Mathieu-DaudÃ© wrote:
>> On 21/7/26 10:29, Mark Cave-Ayland wrote:
>>> On 21/07/2026 08:02, Thomas Huth wrote:
>>>
>>>> From: Thomas Huth <thuth@redhat.com>
>>>>
>>>> ide_cancel_dma_sync() is called with a "IDEState *s" for one of the
>>>> two IDE drives on a bus (primary or secondary drive) to cancel all
>>>> pending DMA transfers on the drive. The code then checks
>>>> s->bus->dma->aiocb to see whether there is any IO in flight on the
>>>> *bus* and then calls blk_drain(s->blk) to wait for its completion.
>>>> However, s->bus->dma->aiocb might belong to the other drive on the
>>>> bus, and if there is no disk attached to the current drive, s->blk
>>>> is NULL. Since blk_drain() does not check its parameter for a NULL
>>>> pointer, QEMU can crash in such a case.
>>>>
>>>> To fix the problem, we have to check that "blk" is not NULL before
>>>> calling blk_drain(). And we have to call blk_drain() for both drives,
>>>> otherwise the assert(s->bus->dma->aiocb == NULL) statement after
>>>> the blk_drain() might trigger if the IO in flight belongs to the
>>>> the other drive.
>>>>
>>>> Resolves: https://urldefense.proofpoint.com/v2/url? 
>>>> u=https-3A__gitlab.com_qemu-2Dproject_qemu_-2D_work-5Fitems_905&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=BbZFP82dEZMyWzN5GnJ9XaxwmyrmYGbqWbEBNSUM_afB5JRRF3InIaZAr5UpUUh2&s=rCgSz13wVfk11Z-Uw5WTQViAQKkSvwpQqf_dJX1tiro&e=
>>>> Reported-by: Alexander Bulekov <alxndr@bu.edu>
>>>> Resolves: https://urldefense.proofpoint.com/v2/url? 
>>>> u=https-3A__gitlab.com_qemu-2Dproject_qemu_-2D_work-5Fitems_4052&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=BbZFP82dEZMyWzN5GnJ9XaxwmyrmYGbqWbEBNSUM_afB5JRRF3InIaZAr5UpUUh2&s=B-AkqMAsQwA0LzU5ptwPJ3ZIBAA8ncf5ZbQg8GTwaME&e=
>>>> Reported-by: dong ling
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>   v2: Drain both drives
>>>>
>>>>   hw/ide/core.c | 9 ++++++++-
>>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>>>> index f78b00220b8..f43ab95b07b 100644
>>>> --- a/hw/ide/core.c
>>>> +++ b/hw/ide/core.c
>>>> @@ -741,10 +741,17 @@ void ide_cancel_dma_sync(IDEState *s)
>>>>        * In the future we'll be able to safely cancel the I/O if the
>>>>        * whole DMA operation will be submitted to disk with a single
>>>>        * aio operation with preadv/pwritev.
>>>> +     *
>>>> +     * Note: s->bus->dma->aiocb might belong to the adjacent IDEState,
>>>> +     * so we have to drain both drives to get it cleared.
>>>>        */
>>>>       if (s->bus->dma->aiocb) {
>>>>           trace_ide_cancel_dma_sync_remaining();
>>>> -        blk_drain(s->blk);
>>>> +        for (int i = 0; i < 2; i++) {
>>>> +            if (s->bus->ifs[i].blk) {
>>>> +                blk_drain(s->bus->ifs[i].blk);
>>>> +            }
>>>> +        }
>>>>           assert(s->bus->dma->aiocb == NULL);
>>>>       }
>>>>   }
>>>
>>> Doesn't ide_bus_active_if() do the right thing here for in-flight 
>>> requests?
>>
>> bmdma_cmd_writeb() already calls ide_bus_active_if().
>>
>> Is the issue in the caller, bmdma_cmd_writeb(), instead of
>> here in ide_cancel_dma_sync()?
> 
> i.e.:
> 
> -- >8 --
> diff --git a/hw/ide/pci.c b/hw/ide/pci.c
> index 7ce1ae67ab2..e7c6af9a49e 100644
> --- a/hw/ide/pci.c
> +++ b/hw/ide/pci.c
> @@ -384,7 +384,7 @@ void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val)
>       /* Ignore writes to SSBM if it keeps the old value */
>       if ((val & BM_CMD_START) != (bm->cmd & BM_CMD_START)) {
>           if (!(val & BM_CMD_START)) {

Also, shouldn't be calling ide_transfer_halt() first?

(Without IDE expert it seems late to get a fix for the release...)

> -            ide_cancel_dma_sync(ide_bus_active_if(bm->bus));
> +            ide_cancel_dma_sync(bmdma_active_if(bm));
>               bm->status &= ~BM_STATUS_DMAING;
>           } else {
>               bm->cur_addr = bm->addr;
> ---
> 
>>
>>> I'd expect to be able to do something like:
>>>
>>>    if (s->bus->dma->aiocb) {
>>>        trace_ide_cancel_dma_sync_remaining();
>>>        blk_drain(ide_bus_active_if(s->bus)->blk);
>>>    }
>>>
>>>
>>> ATB,
>>>
>>> Mark.
>>>
>>>
>>
>>
> 
> 


