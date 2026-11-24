Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B57F606A33E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y7Nd8mhq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DrTkD+xE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVvsn-0003RT-IN; Tue, 24 Nov 2026 14:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVvsi-0003R5-SB
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:08:45 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVvsh-0003wB-6J
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:08:44 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOIXKNK1767112
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S9J1lg0QvHYa65ulaElEr8MOiFfuspahAkzS0DlLT0U=; b=Y7Nd8mhqH3Tvfhs+
 buqpwbf8lO8nAiwJ9koTCq2SkxCrdnNqo8SN5KXGK62ACPaqPILPMtfrs38KYact
 qHco6LlOnL+Pi9CCyMA09HaIXy7DLQ4ubAlbQto8kzCgdWR0Mk2z+olTXHNQe4Q7
 VEv7uh+8NL3vGWGgcQHNiEVm4tsWZtFbgaBlO3ozccve80NmHjoB7dT1TWT5Kdiz
 9009ZhJD6dvHDLN2TKFLc19f6+tXIt2p5olMNjYm/CZZqkQp2CCXrcX38tQBaGX2
 T2ZphymF8cc3qsrZNU/IK/wmJpHlGy9Iy9olex5QBtkNcmTnU3NjaQmelNkUTYDU
 eJJ2rQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5egs8n95-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:08:41 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5edf86a8c00so1389484e0c.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 11:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795547321; x=1796152121; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S9J1lg0QvHYa65ulaElEr8MOiFfuspahAkzS0DlLT0U=;
 b=DrTkD+xE+Kk3F2iRrfHl8ZpRerHeOxFHA8S6nbfkv0IG5jclvLgEHbBzlE9YO/2xbE
 PXmirf4HcPVp+HrC/AdZn4rS0qydOrTPTRF+WXkozZsFY0vhgeNIT9ZCsVXnFA4XRTxj
 lg8puvRZdTAFMaIt2pCm/nV/JVQvKTEUJn3mvRN0fUki+5ztet5w8uJxzCaCsqkFUltQ
 wU3Ci3w+LosiT+kHxqZ8BQxKpDyyEF18CIzOIA6xscM/XLJ6pBAJUiWv5qIFah0dWNMs
 LRO26XUvKiffcUaaQ6fqeeBHpAa1+c0QFidbVZjctKqrG9GqWMkS3jRGcgMN92gv/Bgs
 4y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795547321; x=1796152121;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S9J1lg0QvHYa65ulaElEr8MOiFfuspahAkzS0DlLT0U=;
 b=aeY+R3pDgFq+Pe6lVbhCtJBUw3qj/TUQnn2eC7o96SIVruEpz1aSDgYP34d2Lq6o4H
 2JvSrwukB5HkBTl4q2SL+Q4rL42wL7tdkXBVF5gbanTSUbkgym72Qt7FBVeY/A7/6K7B
 IK2jna1cE1ShKXsWSu2l7g4Y60Nfvsu8XOP+mNFQR2KERSj81dxam/2PLtFYXmd48rSZ
 fBoE5fyMfLt+KyFHxwD7Lexw6hHv75b6V4sKl/tQhUA9r3qOJ0klJDWy+AIF1PRVQT6o
 QYD2MbXfol9B/PwH89h5EoJDeMwXc9vgZefYTzsF2m4qayncrwtd9dYRzRWKcTaoxqop
 vY8Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHQ+Xb6F4k5Ubo1+9Qi7fsv2jv0JZCvXGBaE1t50WBS4LBBY3ELqHHF4Fx/MyI4EeNHChbECKDDycfG@nongnu.org
X-Gm-Message-State: APuU4Z8qVgYzguq9ii9S3Zcx0JUH/v8C6YjU4S/j6ZiNQZo0VlJT6KQJ
 JLuijaULBvNM1AtsHZsR/VvSYZB3zJDCG+0dcFB31JK+StGU/YzrtjHPpDhFN0dRIHcpQ+jGoGI
 XIU2+RiOZRw4EKRJSSCfW6fzewW6vpMzwteFlY3MKoRu/84YPhf1AIwfFGA==
X-Gm-Gg: AZFdTZcmpjGr7lAKJV+/L08W2shOt6M9Uio2WFjFMsm1ESh1L7C1xZTu6v1oMnYyZcW
 tGUiQc0ILMEzaMmERVd7QrwAIzYi95lz/D/6KgvCgiK1toMM1sQllfbOpDDW/Cdj2L2ZvJbRhGs
 GhoJbUagUGksyFiT5lTynt1tU/PJxXFwJOpveYnhbfUCrmlacrm1iaMnOCVm5GNmbX4LXa3Z0NG
 8mUQxCBtJC+szHx0Y+7Ylg7RmJ/Ee0mrJ/AjMYM74TvlFuorwDYmmV8zZo32PswCIsqiSxb/Pfz
 tAEIFwWPNndK0YaSQxeP4LB0Vee5cZcnMoauJlNw90NLQ8gIiSveVpx4VS57ivcSPkJGcMIcpVA
 kkpPUX5V0VBtgjiXLkYtlhV/FjH6rHWkcQ6BPCVjGY35WDnBgwxd1FE0h7WLkSBk8Ukyfiq/hJw
 h55yYxSQE=
X-Received: by 2002:a05:6122:78c:b0:5ea:b9b5:8c43 with SMTP id
 71dfb90a1353d-5ee8af35e3fmr8874354e0c.18.1795547320403; 
 Tue, 24 Nov 2026 11:08:40 -0800 (PST)
X-Received: by 2002:a05:6122:78c:b0:5ea:b9b5:8c43 with SMTP id
 71dfb90a1353d-5ee8af35e3fmr8874317e0c.18.1795547319873; 
 Tue, 24 Nov 2026 11:08:39 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853ca452sm446441695e9.15.2026.11.24.11.08.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 11:08:39 -0800 (PST)
Message-ID: <a95ab43d-b61e-4818-a463-ce090d639b56@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 20:08:38 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/dma/i8257: Zero the reserved bits of the mask
 register
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261119220838.52034-1-philmd@oss.qualcomm.com>
 <20261119220838.52034-3-philmd@oss.qualcomm.com>
 <c2927ef9-3a99-4fa0-b708-474d7cdb34f2@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <c2927ef9-3a99-4fa0-b708-474d7cdb34f2@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3NSBTYWx0ZWRfX3qMyFHPl3gFB
 VM3x7p2mRHZi/V8h3Qhh9RbUQK4iprg00ZrUAJ9aMWRbsgj/awa5mk1II8UXIxIoZBYlKDEUyKu
 Xgac3ZBv9Mv7ZDNlLhYVIXPLbPGDQf5S1h8r9xTBIvHBGqAKZ6n/u/3I3fuLxDStVYvvn0xM0uo
 3O9FO/+1WHPtLUPBoCC3WmobMVdvpquwi5soEMhPqaTvjZfH7FQ32sja8kEJOWkmMig3P31rWgc
 nsQAd9EkbkgknyMGGgoiFHTmfkvBqJr53srGqWCsy2lUeXcP9COBzx4VqAiMFKBeCKdNP0AZhld
 m1Y1nUt/4mBxur895Q59COv980vxZ6wLI/+hPmxAjF2g3YuCnhY2/A6y6U8XsUwtE35IAWhU61C
 ieMvKPxvVXxpV7Cvt7DewFb9ueQyqBbM2ayHKq9poqXtd97eBRoDUGGFOhJFStl0LxqT0zcVF5K
 +yhtfd64yEPirQWVI3g==
X-Proofpoint-GUID: iwoLKBfbRrhR0tOgzxNizkVcr-0RUT3X
X-Proofpoint-ORIG-GUID: iwoLKBfbRrhR0tOgzxNizkVcr-0RUT3X
X-Authority-Analysis: v=2.4 cv=Zt54uN7G c=1 sm=1 tr=0 ts=6b05e0b9 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=a21YVJ72y71kBvQZupwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3NSBTYWx0ZWRfX7jIRXeK8nP+J
 iR43R7xATPCD6KW3yWX0e3dQ5VHyJNTw+c4rSPfKsVtadQY8Ipu0WshFOKNagWeiYh0nbqJ8m0G
 cVe5vFKRRkI+PPFvw2ruvY6s7UJ0mS8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240075
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23/11/26 21:48, Mark Cave-Ayland wrote:
> On 19/11/2026 22:08, Philippe Mathieu-Daudé wrote:
> 
>> The 82C37-compatible read/write-all-mask register has four
>> channel-mask bits; the upper nibble is reserved and reads as
>> zero (PIIX3 datasheet, section 2.5.1.5).
>> The model reset it to all ones and exposed the reserved nibble.
>> Keep only bits [3:0] in reset, write and read paths.
>>
>> Fixes: 27503323968 ("Soundblaster 16 support")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 
> Out of interest, does this solve a bug in that a guest OS functions 
> incorrectly without the top nibble being all zero? Or is it just bring 
> the emulated device in line with the behaviour described in the datasheet?

I'm playing trying to model the MIPS Jazz ISA I/O ASIC (not datasheet).
It is closer to the old i8257 but QEMU models via PIIX3, I don't want to
break PIIX3 so use its datasheet, and was trying to avoid modelling
i8257 differencies. I'll see what I can do, no hurry here.

> 
>> ---
>>   hw/dma/i8257.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
>> index f44632de3db0..ade8609ff438 100644
>> --- a/hw/dma/i8257.c
>> +++ b/hw/dma/i8257.c
>> @@ -242,7 +242,8 @@ static void i8257_write_cont(void *opaque, hwaddr 
>> nport, uint64_t data,
>>       case 0x05:                  /* reset */
>>           d->flip_flop = 0;
>> -        d->mask = ~0;
>> +        /* bits [3:0] mask the four channels; bits [7:4] are reserved 
>> 0 */
>> +        d->mask = 0x0f;
>>           d->status = 0;
>>           d->command = 0;
>>           break;
>> @@ -253,7 +254,7 @@ static void i8257_write_cont(void *opaque, hwaddr 
>> nport, uint64_t data,
>>           break;
>>       case 0x07:                  /* write mask for all channels */
>> -        d->mask = data;
>> +        d->mask = data & 0x0f;
>>           i8257_dma_run(d);
>>           break;
>> @@ -282,7 +283,7 @@ static uint64_t i8257_read_cont(void *opaque, 
>> hwaddr nport, unsigned size)
>>           d->status &= 0xf0;
>>           break;
>>       case 0x07:                  /* read all mask bits (RWAMB) */
>> -        val = d->mask;
>> +        val = d->mask & 0x0f;
> 
> Is this one actually needed if the above hunks guarantee that all writes 
> only affect bits 0-3?

I guess not but that help to be closer to PIIX3 datasheet. Can drop.

> 
>>           break;
>>       default:
>>           val = 0;
> 
> 
> ATB,
> 
> Mark.
> 
> 


