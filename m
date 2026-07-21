Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384DFC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 09:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7F7-0000rP-Dw; Tue, 21 Jul 2026 05:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7F5-0000pp-Pj
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 05:58:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7F3-0005m3-1R
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 05:58:27 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66L6CoB53884161
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 09:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AvmPEeXORihifk6lBg/ffgkbdyeGUuLEFjdKJ1RgRqE=; b=RceIT9Xvp1zmjIsA
 uMjLDbsS+LusM9gF7au7lsv5QMpfV0g8Hve8969revEFRxM8FCRaGqm7nM6yvU/r
 AhOtBLN3O0y4Fk0tOPWxTUA13vlkLmIL6FmEqzHOKCCUAhjSrLJE6Bp77VOro2vo
 WjEq4jr+xd6Bqb3kM1kETK47OONv5/2ok6BlSyEXqFGzGBPmeivd1H++PHf8qsK1
 WdvQEHlsZrV/kdv0UTkqmxHu8Ys5rvVORZAaaqbkuEZ12sS8jR8yP8/KsWP3p5LK
 q2HoLHMdmPZStw9Vf6QyQvhHlVQCi1Bb5Ia5mIUOupJDffZAvE3bXVt9ktNKz+c0
 tIFfyw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqvcbtsp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 09:58:23 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so171153291cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 02:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784627903; x=1785232703; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AvmPEeXORihifk6lBg/ffgkbdyeGUuLEFjdKJ1RgRqE=;
 b=VXVhZMfsHCEpPDc+b7o+1K4+Xh08Hd2g4DJ7h3iF20Td3skPO9X1z4jdvq9/KnM4H7
 2mxIGE6d2xWxLvK5iovwcJHc1euq1D7t8EP8BjOopLDiV4oycBiMFf9mmsUABPYr+MiI
 2S0JrRdKdGLQPkxfjqAM+xQ27Q0eT5ij9lwGVXfkbDDga3iDOk8RhMebAKE4sjLtrBRl
 yWUPsYYwAfct7BF7/8RlhIVLvqS7or0iHEWqU+zFDZHs9Ju8P815MDkfMW2kZDwd8SVz
 lWG8QlIRks4LXJC59cGDhqBMAtN4whcbVK4usoFU0gdWzwuXTqqtXIiRXpy5ZvCQKB74
 E6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784627903; x=1785232703;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AvmPEeXORihifk6lBg/ffgkbdyeGUuLEFjdKJ1RgRqE=;
 b=h7x8WKjUmHxucbLbfx+ka7MLNV3nkajimsKP0N8pi0pnv95hQIlWzUqF9vQZs8D+rD
 TuGePCTbt4MFo2+AiFWJO9VwSMWNjZOztIIN2KZDsLSho3A3k+43Ujw3EvOuf4fO9Kn1
 Nb5/y0/hF9cDU162oDUx9+YqddRF2eVFE6f56Lc4SIU2WlVFZG/V0CA6tYgqQ5hz1ftv
 OzA3Qs94CDGKqbbLtq2113maEJeT+/N14BNG1BhqsAqzIeQVO5v/XxRSuSVcR1383F0S
 8KKD3dLwQ5XnHr00Jzv4Lr1bQKojywpmpQogEQYdKmsaOBs7+jrKvBAhnAgOPoYQynnH
 3A7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqiwcBbiBz86q6omaJyJtNFL0kk1nYoWLDd0OGsXYDtlPObGH3MZNnDPfUDyFIZRocs2AFxNsFzCB6m@nongnu.org
X-Gm-Message-State: AOJu0YwdlQiWIjdP92CddqskZ4y5rao7DnBXwDMeDDdf05MUvWgTOfxP
 c1o4Jl3hw7l6TSb/CT4lENgLqHsPL6CDWwW9L1wrKdVbq/swSHK3JisPLBLdV4w/802Ac4IIuJU
 bFloxEvADtMkpKffQrdzeYH1X31MmMikZ1Z01Q3qMjdCtIJejFyIVTZG1wg==
X-Gm-Gg: AfdE7cmvU3IMpfCuaJ4QYlQRY1op6+EQPAct+vEL4qoNBRCWnXDBPROMPUIAlc7DhHD
 szJl6+YwFE8b2evzMVIK7EUZRomoacSBatbjUTxk90C9j5YjUSHRgBqu1PocMQpNQmImvIl+h0R
 3r0DiTuEtonaV5Q0UUPswyCkTdZQ0uObsB0laVao6AFUCA8FzksoLgA635xnniTW4iob1FbMPUT
 pt5aq+vth9R98nOc0p4Kx45oMKfemcWuKETIEzjAnLEGojxTKMdmvT7DJzfXgj+jdeZ7zahTwVJ
 GW6wdhOAJoisnxL7h+h71biHCdEMqaxDcMfUaJ2WbtqRtPuGkhmeSkm4rCMxo7l3/vnk9DzzbSA
 161qo6ZtfYRe9Zx7QW4I5nw2VPCTVo+/BWkIhDx2/ANjppTdZSTE=
X-Received: by 2002:a05:622a:38b:b0:51a:8c97:fb9d with SMTP id
 d75a77b69052e-5213fc58323mr161022531cf.70.1784627902869; 
 Tue, 21 Jul 2026 02:58:22 -0700 (PDT)
X-Received: by 2002:a05:622a:38b:b0:51a:8c97:fb9d with SMTP id
 d75a77b69052e-5213fc58323mr161022421cf.70.1784627902461; 
 Tue, 21 Jul 2026 02:58:22 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49acesm36251511f8f.6.2026.07.21.02.58.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 02:58:21 -0700 (PDT)
Message-ID: <e705d648-eaa2-404a-b654-a15b1648e0a9@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 11:58:20 +0200
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
In-Reply-To: <563e1a3e-1420-4f6b-9244-9ad4360c207f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEwNSBTYWx0ZWRfX4Ly80+n9GI52
 ZzalbustIMDr28XwNu86tsErnFWkBqBPdwZvUTpyTHvLBlu1WaVzcvFtagrazMtdv8EH0+vU93l
 Tmw9+XrOJQrRor/1ic4Arb7YEIT8pXY=
X-Proofpoint-GUID: bFVEHTuollM6-zCeLqQNPzV4vDvYifYl
X-Authority-Analysis: v=2.4 cv=OMYXGyaB c=1 sm=1 tr=0 ts=6a5f42bf cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=RpNjiQI2AAAA:8 a=20KFwNOVAAAA:8 a=2QUrxFv762PGgihxwb4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: bFVEHTuollM6-zCeLqQNPzV4vDvYifYl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEwNSBTYWx0ZWRfXzmimU7anTUvu
 apuV7pYZnNjsDfNc2ifEFR/EYm9Yc1U4P1Cf7YRMuS1n0ICax6knW8cZy3Zzt5vPNwlLfCspPUO
 cV0GNdWaR9pakY55ff4oAnOUIzV9TUQL1hP31qFXJlrdbDyD0AzBm/X+jyC8OTpgLPl8hG+9AtD
 euUq39vkW+ydKZyyec004BA6Mwcpv/A+t1sMB8cK5keCpWNJ+o5dV1XJ3qFqAV4yx7zHd/kMSyE
 0lauPDslWTSwq0GZPlrkBZHXwbdPjo9KFGW+31GM9LlSmdWlca/y1uZt1QjGV2BM/LtqfhmmDTB
 odDeQn4SVkyBfUX/RNPBd959AKFTRe5lmRVj3262qeayLHaIpgDIgj3phRQC4kZeOJ+0QIMuIAn
 4ZJkdW+1l40jXl1WgGy6yjzXd6zENZwgn0DKTZkQ0ghALtRo/l96sYOghcPe7r1dB9sl5mVmjvO
 E4FwJz6GjDes6IR8vnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210105
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

On 21/7/26 11:51, Philippe Mathieu-DaudÃ© wrote:
> On 21/7/26 10:29, Mark Cave-Ayland wrote:
>> On 21/07/2026 08:02, Thomas Huth wrote:
>>
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> ide_cancel_dma_sync() is called with a "IDEState *s" for one of the
>>> two IDE drives on a bus (primary or secondary drive) to cancel all
>>> pending DMA transfers on the drive. The code then checks
>>> s->bus->dma->aiocb to see whether there is any IO in flight on the
>>> *bus* and then calls blk_drain(s->blk) to wait for its completion.
>>> However, s->bus->dma->aiocb might belong to the other drive on the
>>> bus, and if there is no disk attached to the current drive, s->blk
>>> is NULL. Since blk_drain() does not check its parameter for a NULL
>>> pointer, QEMU can crash in such a case.
>>>
>>> To fix the problem, we have to check that "blk" is not NULL before
>>> calling blk_drain(). And we have to call blk_drain() for both drives,
>>> otherwise the assert(s->bus->dma->aiocb == NULL) statement after
>>> the blk_drain() might trigger if the IO in flight belongs to the
>>> the other drive.
>>>
>>> Resolves: https://urldefense.proofpoint.com/v2/url? 
>>> u=https-3A__gitlab.com_qemu-2Dproject_qemu_-2D_work-5Fitems_905&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=BbZFP82dEZMyWzN5GnJ9XaxwmyrmYGbqWbEBNSUM_afB5JRRF3InIaZAr5UpUUh2&s=rCgSz13wVfk11Z-Uw5WTQViAQKkSvwpQqf_dJX1tiro&e=
>>> Reported-by: Alexander Bulekov <alxndr@bu.edu>
>>> Resolves: https://urldefense.proofpoint.com/v2/url? 
>>> u=https-3A__gitlab.com_qemu-2Dproject_qemu_-2D_work-5Fitems_4052&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=BbZFP82dEZMyWzN5GnJ9XaxwmyrmYGbqWbEBNSUM_afB5JRRF3InIaZAr5UpUUh2&s=B-AkqMAsQwA0LzU5ptwPJ3ZIBAA8ncf5ZbQg8GTwaME&e=
>>> Reported-by: dong ling
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   v2: Drain both drives
>>>
>>>   hw/ide/core.c | 9 ++++++++-
>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>>> index f78b00220b8..f43ab95b07b 100644
>>> --- a/hw/ide/core.c
>>> +++ b/hw/ide/core.c
>>> @@ -741,10 +741,17 @@ void ide_cancel_dma_sync(IDEState *s)
>>>        * In the future we'll be able to safely cancel the I/O if the
>>>        * whole DMA operation will be submitted to disk with a single
>>>        * aio operation with preadv/pwritev.
>>> +     *
>>> +     * Note: s->bus->dma->aiocb might belong to the adjacent IDEState,
>>> +     * so we have to drain both drives to get it cleared.
>>>        */
>>>       if (s->bus->dma->aiocb) {
>>>           trace_ide_cancel_dma_sync_remaining();
>>> -        blk_drain(s->blk);
>>> +        for (int i = 0; i < 2; i++) {
>>> +            if (s->bus->ifs[i].blk) {
>>> +                blk_drain(s->bus->ifs[i].blk);
>>> +            }
>>> +        }
>>>           assert(s->bus->dma->aiocb == NULL);
>>>       }
>>>   }
>>
>> Doesn't ide_bus_active_if() do the right thing here for in-flight 
>> requests?
> 
> bmdma_cmd_writeb() already calls ide_bus_active_if().
> 
> Is the issue in the caller, bmdma_cmd_writeb(), instead of
> here in ide_cancel_dma_sync()?

i.e.:

-- >8 --
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 7ce1ae67ab2..e7c6af9a49e 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -384,7 +384,7 @@ void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val)
      /* Ignore writes to SSBM if it keeps the old value */
      if ((val & BM_CMD_START) != (bm->cmd & BM_CMD_START)) {
          if (!(val & BM_CMD_START)) {
-            ide_cancel_dma_sync(ide_bus_active_if(bm->bus));
+            ide_cancel_dma_sync(bmdma_active_if(bm));
              bm->status &= ~BM_STATUS_DMAING;
          } else {
              bm->cur_addr = bm->addr;
---

> 
>> I'd expect to be able to do something like:
>>
>>    if (s->bus->dma->aiocb) {
>>        trace_ide_cancel_dma_sync_remaining();
>>        blk_drain(ide_bus_active_if(s->bus)->blk);
>>    }
>>
>>
>> ATB,
>>
>> Mark.
>>
>>
> 
> 


