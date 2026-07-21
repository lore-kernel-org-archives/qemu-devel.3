Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA173C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm88x-0007Ti-3I; Tue, 21 Jul 2026 06:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm88v-0007SS-4P
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:56:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm88r-0005Bh-Kw
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:56:08 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LART9v1230186
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mhydVc2NwLlNOLaFqB5Z9f4lqxRRFuE0Eh/pblaYSfI=; b=bPIWu+iDHZRwKd7Q
 hRdbfn9kCXZFPYo/fc4mS2gaze11Rqga0a9d5IErcj53WJUh83QHg6MPl5udaCIC
 T2zCpbOofDyljxCh6dfBAgS4CEYueK+0Rv2HORpn1CtmLI+Co2Wr3Xvj3Iv1B0NW
 ymzC/cr9n2kgyfJJLDkw9IsO5bd+LmIEZZF61EDKJDUqvlYMWd5h98KF/ehUPimd
 4vaCt4aozp9H1yuMhDkd9jZ1NLhNASgXCkLyDyCMjzNBnf+UT6QTQJbqeTg6+Wca
 lZ8ZD17yHT0jDPZOOcShkg+2uhZibr+0hv5EV4DoVAsTls+KTxv1ai5fT6UK/dMF
 SnnUlw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj01aa6jd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:56:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d30035dso142699421cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 03:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784631363; x=1785236163; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mhydVc2NwLlNOLaFqB5Z9f4lqxRRFuE0Eh/pblaYSfI=;
 b=jjlA1b6Aa7Z+mQD4A+CfVj4XLcF+VRzHHpsZBvvV2Kd85y7bovlWSS8FBLWXOAVIGr
 rvSzy8J6GU244ig5iGo7SHSzxf/verj0nS2sk9M9MurVyP9V1kAm+Aw9JTs7IQqHIIgn
 WyOF6OWUz8BH4Wgocbm8H52kVz/VZuPAaKBhTwLVO+O+xNIaITIvCBGRByV6A/pPp7rh
 oe0PjgBYlv/P+gGMY52oGngcZ6ZUhu405bNbBcuQJD4rd0LkfvF1uXrweJBcd7nll8WV
 4TYnMhZ34PhHNjnbZNtR2lm2KiC1HsTdN2eqHGqWNbV5MtkMEdHlg7dnQNUOTJaV88RS
 O05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784631363; x=1785236163;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mhydVc2NwLlNOLaFqB5Z9f4lqxRRFuE0Eh/pblaYSfI=;
 b=TXNDKBNcIQcwa6DL8kqfA/LQcxieeKXDfUe+Na35yFBWCHNPqbgW67uXQkNudY12co
 grVqfRAgrQa+13Ni4C3K0JHERAARjCAZDLOwFo4OXBnxTxlVqRLVCLIFAy65eVT/BpYf
 e54IEEe5zIeRXFXdB96G0lOTMud272pO5VPUpIuOLtEad1pyKq1V6NFI/c3SV2hIBz8I
 e8BQ280jYHFzYEEzxa2Popt+ou81i0n+NpzA0G6aQ6zDqWEYkHhPU4TLSa8z4ADrUGvB
 TN9sWzw6p1wpGglkmp9bACoF1u9ZyK2u9s+9/V4JO8T9KFlJvd8xlH/U+0tEWas2E+zN
 dy9g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrXAJveS6zEsEx7trEsrmVTLASHTK2mYWFZIHP3BbvVA94gobxthGSSrvtn3XgiVUmMfhpKx01LO/oP@nongnu.org
X-Gm-Message-State: AOJu0YzNUo0SldMtr5umxf+Cga0zmOw8V5zKtKQNOolBeqXpcbt73HHg
 tEluCVcShyI5WEXwFV0jKZ2fHdWUufisPmqwci2FEiWW8+NzT/riEXMlxds0peC/ewIu7E5Z3Fu
 uO118lrjtO2izKQcYVNvl1A619ZO9cF8V/yW5Pc4UXvoCw4qkItwCQJqzEg==
X-Gm-Gg: AfdE7clPfUmyRyLfd6dKORes/MLAs51qv8/5X5KPSytdYq4zZvJ6zFqIP9kOv/c1oEV
 ax5cRXvT7IHLBTt2h5IYLlLOWVWwEwE1/s9JleKMMEcuodKY5Awo75IK7Lg39rcHmNHr8LEu0F1
 mFxDWjUVBLAW6oQxw/hP42JvRh/XIsA6Q7wnFmJgjqmhagIELJxETP+4PBCu+6hRfXD0Pk7fJ3I
 knCGP/FiA3eJUYIFSWjiji+AqcPuE/XYz5+N209uCQdeipP16ezMS75pTklilUQAGPrMHkmdCAr
 IEZYpKuCNYpMkiPXBEEJo8Abag7G5tqqUoxdgQMa7X5Nzlep1339yCBifFQTrXa2DWP0k6CMzuJ
 vwOzcHHPXaFWTFcGIOoHQvY56pr8TLPKmBLTlUWSLQ4QwX6KIK5c=
X-Received: by 2002:a05:622a:991:b0:51c:640:231f with SMTP id
 d75a77b69052e-5213daa1d60mr180897401cf.45.1784631362591; 
 Tue, 21 Jul 2026 03:56:02 -0700 (PDT)
X-Received: by 2002:a05:622a:991:b0:51c:640:231f with SMTP id
 d75a77b69052e-5213daa1d60mr180897151cf.45.1784631362103; 
 Tue, 21 Jul 2026 03:56:02 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653bfabesm67335225e9.10.2026.07.21.03.56.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 03:56:01 -0700 (PDT)
Message-ID: <500f7d75-f8a5-4152-bf5b-17cf047ad24a@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 12:55:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/ide/core: Fix possible crash via NULL pointer in
 ide_cancel_dma_sync()
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, qemu-trivial@nongnu.org
References: <20260721070216.82984-1-thuth@redhat.com>
 <3f8027d5-f7db-4fb5-8386-1d5f93974a10@nutanix.com>
 <563e1a3e-1420-4f6b-9244-9ad4360c207f@oss.qualcomm.com>
 <e705d648-eaa2-404a-b654-a15b1648e0a9@oss.qualcomm.com>
 <06ede776-5505-4154-a4d4-a74b77d5cb90@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <06ede776-5505-4154-a4d4-a74b77d5cb90@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BL6DalQG c=1 sm=1 tr=0 ts=6a5f5043 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=RpNjiQI2AAAA:8 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=xo6y5mzXw5BTvs1Glo0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDExNSBTYWx0ZWRfX9cxQTzeCotFU
 Oj/CZXd7NPabf1QFQ7Q4Iw1IEPJgxrB4U3wl5hTIpQ6/6cDZ6d8qQt9Xf5LsV4xgyvni0hF6ry3
 OKIN4Xwbsa1erX1/6O64p5nOfRn9slI5116z5/M1EV9J9pBPJX1LxWvs7uH23v5jpu8d/LqJpHC
 tU3+FXxfDVIUK/QhF3CY6WAdTTHuFskDqXro1D3EzwiouwBb7IRd7hZIDl6NrkOGCg88KfaVrEJ
 Qhw40YQruio0i7a1yqZ6XDK5TDm0kubw1EUMZXCanMQArm+ytT2FwTYNixMtLYfuzOGgNjflea3
 NzINLNWoEOsrMLORE8PaF6Ejh/xbMg7ciD1VW1tixQLarYW9yC+/5Ww/UbhlS1OUOYQKG9FCYRY
 Q2s89NbG+6jV3S9xG7iI0UU5rs472buAryf/7WDX6GTy7ZoER4LMa2rFsEbdQBJQE0uVMGx7OuE
 22XoftYXOaZVgxyWJuw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDExNSBTYWx0ZWRfX1+sLHGU4VL4q
 92JCKIVYQi6HnqKFF+cCtw8eNEbxdnuyQU27z8KsYUh1mBAVMZdujD4TuJTQS7FAEW4Jf5b9PhL
 I5V6mJHNP+U1TPwCrr1WzT180QtHS5M=
X-Proofpoint-ORIG-GUID: -474NRZU4f-cpPM-5Za3FWTxmzEJuSye
X-Proofpoint-GUID: -474NRZU4f-cpPM-5Za3FWTxmzEJuSye
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210115
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

On 21/7/26 12:21, Thomas Huth wrote:
> On 21/07/2026 11.58, Philippe Mathieu-Daudé wrote:
>> On 21/7/26 11:51, Philippe Mathieu-DaudÃ© wrote:
>>> On 21/7/26 10:29, Mark Cave-Ayland wrote:
>>>> On 21/07/2026 08:02, Thomas Huth wrote:
>>>>
>>>>> From: Thomas Huth <thuth@redhat.com>
>>>>>
>>>>> ide_cancel_dma_sync() is called with a "IDEState *s" for one of the
>>>>> two IDE drives on a bus (primary or secondary drive) to cancel all
>>>>> pending DMA transfers on the drive. The code then checks
>>>>> s->bus->dma->aiocb to see whether there is any IO in flight on the
>>>>> *bus* and then calls blk_drain(s->blk) to wait for its completion.
>>>>> However, s->bus->dma->aiocb might belong to the other drive on the
>>>>> bus, and if there is no disk attached to the current drive, s->blk
>>>>> is NULL. Since blk_drain() does not check its parameter for a NULL
>>>>> pointer, QEMU can crash in such a case.
>>>>>
>>>>> To fix the problem, we have to check that "blk" is not NULL before
>>>>> calling blk_drain(). And we have to call blk_drain() for both drives,
>>>>> otherwise the assert(s->bus->dma->aiocb == NULL) statement after
>>>>> the blk_drain() might trigger if the IO in flight belongs to the
>>>>> the other drive.
>>>>>
>>>>> Resolves: https://urldefense.proofpoint.com/v2/url? 
>>>>> u=https-3A__gitlab.com_qemu-2Dproject_qemu_-2D_work-5Fitems_905&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=BbZFP82dEZMyWzN5GnJ9XaxwmyrmYGbqWbEBNSUM_afB5JRRF3InIaZAr5UpUUh2&s=rCgSz13wVfk11Z-Uw5WTQViAQKkSvwpQqf_dJX1tiro&e=
>>>>> Reported-by: Alexander Bulekov <alxndr@bu.edu>
>>>>> Resolves: https://urldefense.proofpoint.com/v2/url? 
>>>>> u=https-3A__gitlab.com_qemu-2Dproject_qemu_-2D_work-5Fitems_4052&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=BbZFP82dEZMyWzN5GnJ9XaxwmyrmYGbqWbEBNSUM_afB5JRRF3InIaZAr5UpUUh2&s=B-AkqMAsQwA0LzU5ptwPJ3ZIBAA8ncf5ZbQg8GTwaME&e=
>>>>> Reported-by: dong ling
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>   v2: Drain both drives
>>>>>
>>>>>   hw/ide/core.c | 9 ++++++++-
>>>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>>>>> index f78b00220b8..f43ab95b07b 100644
>>>>> --- a/hw/ide/core.c
>>>>> +++ b/hw/ide/core.c
>>>>> @@ -741,10 +741,17 @@ void ide_cancel_dma_sync(IDEState *s)
>>>>>        * In the future we'll be able to safely cancel the I/O if the
>>>>>        * whole DMA operation will be submitted to disk with a single
>>>>>        * aio operation with preadv/pwritev.
>>>>> +     *
>>>>> +     * Note: s->bus->dma->aiocb might belong to the adjacent 
>>>>> IDEState,
>>>>> +     * so we have to drain both drives to get it cleared.
>>>>>        */
>>>>>       if (s->bus->dma->aiocb) {
>>>>>           trace_ide_cancel_dma_sync_remaining();
>>>>> -        blk_drain(s->blk);
>>>>> +        for (int i = 0; i < 2; i++) {
>>>>> +            if (s->bus->ifs[i].blk) {
>>>>> +                blk_drain(s->bus->ifs[i].blk);
>>>>> +            }
>>>>> +        }
>>>>>           assert(s->bus->dma->aiocb == NULL);
>>>>>       }
>>>>>   }
>>>>
>>>> Doesn't ide_bus_active_if() do the right thing here for in-flight 
>>>> requests?
>>>
>>> bmdma_cmd_writeb() already calls ide_bus_active_if().
>>>
>>> Is the issue in the caller, bmdma_cmd_writeb(), instead of
>>> here in ide_cancel_dma_sync()?
>>
>> i.e.:
>>
>> -- >8 --
>> diff --git a/hw/ide/pci.c b/hw/ide/pci.c
>> index 7ce1ae67ab2..e7c6af9a49e 100644
>> --- a/hw/ide/pci.c
>> +++ b/hw/ide/pci.c
>> @@ -384,7 +384,7 @@ void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val)
>>       /* Ignore writes to SSBM if it keeps the old value */
>>       if ((val & BM_CMD_START) != (bm->cmd & BM_CMD_START)) {
>>           if (!(val & BM_CMD_START)) {
>> -            ide_cancel_dma_sync(ide_bus_active_if(bm->bus));
>> +            ide_cancel_dma_sync(bmdma_active_if(bm));
>>               bm->status &= ~BM_STATUS_DMAING;
>>           } else {
>>               bm->cur_addr = bm->addr;
> No, I don't think this will fix all cases. While https://gitlab.com/ 
> qemu-project/qemu/-/work_items/905 has a call trace with 
> bmdma_cmd_writeb() in it, https://gitlab.com/qemu-project/qemu/-/ 
> work_items/4052 is slightly different: The backtrace shows 
> ide_bus_perform_srst() ->  ide_perform_srst() -> ide_cancel_dma_sync() 
> here instead. I'd say let's play safe and always drain both interfaces. 
> WDYT?

I dunno I'm kind of lost. Can't blk_bs() handle NULL blk?

-- >8 --
diff --git a/block/block-backend.c b/block/block-backend.c
index 37ba7e9fc40..b5d84c9789a 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -760,7 +760,7 @@ BlockBackend *blk_by_name(const char *name)
  BlockDriverState *blk_bs(BlockBackend *blk)
  {
      IO_CODE();
-    return blk->root ? blk->root->bs : NULL;
+    return (blk && blk->root) ? blk->root->bs : NULL;
  }
---

