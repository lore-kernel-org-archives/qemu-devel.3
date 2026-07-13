Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAC9C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEoc-0006Yw-1N; Mon, 13 Jul 2026 07:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjEoa-0006Ye-AX
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:27:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjEoY-0000IV-9p
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:27:12 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DAQp42507388
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RTjzMXsLBbJ0LOu77n6+XLc2W3meQJWwjiZ9dKgFbWg=; b=iDq6iiYxuBQ7p1Q5
 vDHAi9+Rfl9zJ6WqMq3Iv80y34norXsOHOpi72/p99gpidooLNZ2m6/qQi+LryHq
 f6BNeh9B9HluOOphzYbz9c+YRzpWGOqZSkCKHPy+e9nsCFfEqozIlACtcfsM3hXk
 452fgqw6hQ5+6cZY5h/OUf9T0aHRwISEW2WmTBWuHLTtcGqDP1WUK1Q4pkct1nS+
 HvIdvY2NvwJp5XKGGo9WwxGQM9zbcCrW/5rJFipLSMzY7OL9iO/i1k2KtM3ddqAv
 /dKJs/ANPDcM7CdsIuHursMi4ivEd4d3e/qiCblkqAkfFo/GwVOyq7nG55K/uV5f
 czPfiA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fctc8h859-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:27:08 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a8c689b5fso44673541cf.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 04:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783942027; x=1784546827; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RTjzMXsLBbJ0LOu77n6+XLc2W3meQJWwjiZ9dKgFbWg=;
 b=CvUkUYA8Atb5dnt5FcSIgkFe3JbrvR/7QUfsx6S8mMXDeFucA0wkVzswSUS4r5cDES
 JsVni7hHoyeE8B/t5ubaHgQWpDBnKIPvwtBDfgVMzbkAuu/I4YUWyp1cJrTaFlEq4O9k
 g3Fi/oTLyv0TitwtIhAQ+qmAJpZetK7iIN3aTReBxvD0KIVKRClVJdJAfiLRDZFL2qw3
 jhnBhGnV/xxAgpMTgsyw7bdiY0ehWT9mnlU529ruUcWbWLlKZRRjRFlU/dpVzYRLgVTl
 aI/ZFOPGlRvg2g8xiKdKqkmKr0m+G4NLvWVn1OFovtvhyV9DEfnlGva1svHuyTEnJl4X
 zOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783942027; x=1784546827;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RTjzMXsLBbJ0LOu77n6+XLc2W3meQJWwjiZ9dKgFbWg=;
 b=ECX7R61QjSoLzv3orf1f9/CJrl629WXdPb0+jTAxtOhehg+Pt9LnI+SLOoao4XR4BY
 /EPkw7cdpUnxjWx9Xvd2EfGvE2oUGPr5Nf6wViqeG4nZieLsYzflj+aqNQTEEJhA6TbP
 /vSb71AUnKiTxcrfs/69p48RPBXLCuNoGn062z3Sbw84i1OplBXc/wAmfDyMoyFtJRrP
 nQGi/ewCtzk5cwW2IyG39Kv9pq5BLngAOKQ23n/xtuaMeOxW+c/Qh42XYMJll5Dc1rCG
 EPSkkLBAvL3AEfrBJg42cxiSwJwTiF97Ei3KqWHB1u8lzvOG6+1hdhdF22ABqsr9tSnD
 Zu8Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpQRYcbDuJbZ9d6QHEecAalStul8arVo3VqQaAmyaIPUwHGnY4/BRSNqfdleHbZ93P1Oe3/W8MmPSKM@nongnu.org
X-Gm-Message-State: AOJu0YxoO2yKq89WIt/jfZLOBTdj6bPwB/D+G5fbUb0h93dvJorU2c8r
 64rO6u+cGemAa9pf+xYrjx5m2svzryODcks8Ty+taWckDHo9pZxWXbGE6+xAPm2APj1w3wcKiI9
 hqxWU7hMasvfFQzi8q7F3ZssO/c80LEMm1COqZ+FJoz65qa0srvPBfZUeDw==
X-Gm-Gg: AfdE7cmIrKgHGhHfx2XO0DuMPM/1kDUUgNTtC/vlWOdXYPs/YmoAwUdj07VDOcwyf/p
 j4/jbSDwumi1xpSw1jKmJarHKcVGRKEOAEG0YFM6S1AUNwhZVOS6Up8uz2MsqkKjwIkpjpPitsO
 FUuk2ZlU3hE7Wh6EjMdsPkEpT03Ru4kthLZWsuZ8+ue26mbv2kLwgTviRsvT3VJ/EGhsdteCyAU
 ygzm/7IV2t5X6x06AGbsRkCiFDZDXamTLcittWeLT/U2U/cCh/aP6bo0S2htGWhW1RYhQOsqY+0
 FTzbHSwIQEt+7vYRseV/x3IEK5pMDoIm25GNPuTH/CkRCKfky9XK1pFPOctsgaUO0omduvima/g
 6AhcMDt+O7Oap7gccWUn6Cr1ET56QTf1SBIsKlu0WOa3N5LsnSqMyeFPc+fF6wQ==
X-Received: by 2002:a05:622a:115:b0:51c:7b11:41af with SMTP id
 d75a77b69052e-51cbf2e0d38mr85008461cf.75.1783942027386; 
 Mon, 13 Jul 2026 04:27:07 -0700 (PDT)
X-Received: by 2002:a05:622a:115:b0:51c:7b11:41af with SMTP id
 d75a77b69052e-51cbf2e0d38mr85008101cf.75.1783942026920; 
 Mon, 13 Jul 2026 04:27:06 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47df6a31dd5sm41878791f8f.16.2026.07.13.04.27.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 04:27:06 -0700 (PDT)
Message-ID: <7a7985b6-2a62-4159-8d22-d11d0739d843@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:27:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ui/vnc: validate color shifts in SetPixelFormat
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
 <20260706-fix-v1-3-4b83a70e9f3b@redhat.com>
 <98e1bdb8-2cfb-4661-8189-9071b09e2629@oss.qualcomm.com>
In-Reply-To: <98e1bdb8-2cfb-4661-8189-9071b09e2629@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ShYsMDxFlb-anCvJEyOQ2M-ZMgOtLq09
X-Proofpoint-ORIG-GUID: ShYsMDxFlb-anCvJEyOQ2M-ZMgOtLq09
X-Authority-Analysis: v=2.4 cv=UtRT8ewB c=1 sm=1 tr=0 ts=6a54cb8c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=QD95cOeK318sXTfxYfAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExOSBTYWx0ZWRfX62DdzR9e26mG
 d4d4I8QWBiKaaiEw7PCimIvUkj1kikrcbqLzZxl6d9mYaKJj1F8ZR4k22jvyAxrV/3VQWqCRiYS
 KzCwcFzFiDw1xijntKJriLV7ql/UJsw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExOSBTYWx0ZWRfXwvML+WLXvwI8
 FTSUwGIP4LnBdtf7w6zjyhSu5KJCVQCJcjQJdOZtn6X8cbNoiwG9ZTlUHIefFqimWaYnlHsOqi/
 KD8XRIaF/6SUBAKv/hBDOOIV4dqrROuDz5nxJHjPhGCaT+Pjt4t4eEHb/CZa+lcfA6U05o32leG
 MzjBoSGm+OBbdG0OSC67NPscKPSNMjql1WkSk+9KR5Bv5Kl8uLJ9IKuI/TRuKljcVD7uHTscfiO
 hjiowPU4LRpjKvv5kXqu5J+wUdZ9Uu2ETsP4Aw5V2HZgmL0MgkjP9HIwl0u9aE7KC8sHnvOa77O
 hMY994Q17d+6dlUA4sp7PISyu80DVWLeqkBZYLyzd2sGZ1LDA5YRV7tv1b8/yb0um+GhMZDufd1
 KahUTNMLLvOhD2Vm2qAUhj+abE7a93f9AD+vmISAJYi1aKqSwNsMF8gKQ3GvD9qeXdbcTXpIGjS
 Q228wspbeFI1ng+HaSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130119
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

On 13/7/26 13:23, Philippe Mathieu-DaudÃ© wrote:
> On 6/7/26 14:53, Marc-AndrÃ© Lureau wrote:
>> A malicious VNC client can send a SetPixelFormat message with shift
>> values >= 32, causing UB mask computation
>> (e.g. red_max << red_shift where red_shift is 255). Apparently, this is
>> not covered by -fwrapv.
>>
>> Reject color shifts >= bits_per_pixel before computing masks, and cast
>> the max values to uint32_t to avoid signed integer overflow when a
>> valid shift (e.g. 24) would set bit 31 of a signed int.
>>
>> Fixes: 9f64916da20 ("pixman/vnc: use pixman images in vnc.")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3948
>> Reported-by: huntr bubble
>> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
>> ---
>>   ui/vnc.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/ui/vnc.c b/ui/vnc.c
>> index 559d3954b87..94a38242c56 100644
>> --- a/ui/vnc.c
>> +++ b/ui/vnc.c
>> @@ -2276,18 +2276,25 @@ static void set_pixel_format(VncState *vs, int 
>> bits_per_pixel,
>>           return;
>>       }
>> +    if (red_shift >= bits_per_pixel ||
>> +        green_shift >= bits_per_pixel ||
>> +        blue_shift >= bits_per_pixel) {
>> +        vnc_client_error(vs);
>> +        return;
>> +    }
>> +
>>       vs->client_pf.rmax = red_max ? red_max : 0xFF;
>>       vs->client_pf.rbits = ctpopl(red_max);
>>       vs->client_pf.rshift = red_shift;
>> -    vs->client_pf.rmask = red_max << red_shift;
>> +    vs->client_pf.rmask = (uint32_t)red_max << red_shift;
>>       vs->client_pf.gmax = green_max ? green_max : 0xFF;
>>       vs->client_pf.gbits = ctpopl(green_max);
>>       vs->client_pf.gshift = green_shift;
>> -    vs->client_pf.gmask = green_max << green_shift;
>> +    vs->client_pf.gmask = (uint32_t)green_max << green_shift;
>>       vs->client_pf.bmax = blue_max ? blue_max : 0xFF;
>>       vs->client_pf.bbits = ctpopl(blue_max);
>>       vs->client_pf.bshift = blue_shift;
>> -    vs->client_pf.bmask = blue_max << blue_shift;
>> +    vs->client_pf.bmask = (uint32_t)blue_max << blue_shift;
>>       vs->client_pf.bits_per_pixel = bits_per_pixel;
>>       vs->client_pf.bytes_per_pixel = bits_per_pixel / 8;
>>       vs->client_pf.depth = bits_per_pixel == 32 ? 24 : bits_per_pixel;
>>
> 
> What about instead of the casts (keeping the if(shift) block):
> 
> -static void set_pixel_format(VncState *vs, int bits_per_pixel,
> -                             int big_endian_flag, int true_color_flag,
> -                             int red_max, int green_max, int blue_max,
> -                             int red_shift, int green_shift, int 
> blue_shift)
> +static void set_pixel_format(VncState *vs, uint8_t bits_per_pixel,
> +                             bool big_endian_flag, bool true_color_flag,
> +                             uint16_t red_max, uint16_t green_max, 
> uint16_t blue_max,
> +                             uint8_t red_shift, uint8_t green_shift, 
> uint8_t blue_shift)
> 
> ?

Haha this is what the next patch does ;) I got confused by the
(uint32_t) casts, they belong to the next patch.

So with only the if(shift) here:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


