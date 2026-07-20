Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C40C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlmO4-0003MH-GF; Mon, 20 Jul 2026 07:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlmO2-0003Kp-GH
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:42:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlmO0-0001fd-KA
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:42:18 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KAvUD52542111
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8mHGGwbfGIhPeGkBfLxh3tEn98cuUvWzMniTWdbDASs=; b=QCFwyZFclW7ygL10
 dm28kMNmKanDa0jtSGuSi2Sae0MOZUdJtc4K0/uUcmWjfCEw84RlAdy0wtrYaW2a
 wJgT8aTJz38k18ySBISWv1G+qQZUMHpVdKLy3CcQrWnzwZjKst/8tOe6yrokKjL2
 MZzgVxYeuuvp27b+GAjS/yQ2j11MV4qJO3cDMM8h67iQp/OqFjxUg/OSCpKa63YY
 YIPhn8cuKmO6JRL0ZYpiLRSwq8/2BXVBrXorb5Yp+7/gEMxJrgyGGKrQpK7PZ2E1
 PlnLSLwhSuEM+KHP3GoFxBZL782cLND/OwgGMIhKbK7XGyNGSk4Yp5R/w13A1b+t
 XYNR3g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfdch3se-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:42:14 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso86977771cf.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 04:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784547733; x=1785152533; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8mHGGwbfGIhPeGkBfLxh3tEn98cuUvWzMniTWdbDASs=;
 b=jFA+yhosNXvdg4WTg4EzpURPj3utjHNK8QbeYo667W4ethRYr7yUpzsAYA7UOhW5jJ
 uYyhSNa4vgPYa7xlV3d+1IsDbSu6+EtfzCeLEFFX7uAFgTTdiZx1s+aj1LAiKFznAiyg
 LdXTc0Ck4C+6nkZrv+zRyiJF4wNISTNBmsrtuQO0PAtgnP7XfVXS2W7qmSUhMH9hIgvW
 pIzmMsOb4+lSmvZoOVIwhrAyEAYuldFhzYKabGXGuoUgYmmVE/4COzl4KLlFZj3jYcgZ
 WP/costt4+TdiQ6rNQqP8cjU3teB6H0Q9/g85uW4EDeVQe/rrzUNJyoBacoriTuc27kP
 ah+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784547733; x=1785152533;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8mHGGwbfGIhPeGkBfLxh3tEn98cuUvWzMniTWdbDASs=;
 b=dN/RLlD+crv0rU9AJNMottxO68iagcPpt2IjXCcwSrhxFD7PE9/UFin0mWPlAXXmCw
 4/mM3MVFGpPQUV1vYH/0vYjv8z5jgPQUGdLB8/q8r1zvyacLmvqTL7KxgcPlsa1h+NLb
 rWKfRNfWFIX27Gm8/ovZbAHNPZIUMBGtTIbSfBfDLeLhIBQQo9nOpglPZwMASOut0ATe
 Ay8kER7Cj+A/DR51lUB6yvMq4cGgFazXLH5htZkOjeXwUP8TqpEx11j2ZuZbhUmbJ6dz
 cLTDj0W4Cccm7nXoCwgnX3ZHhyYG3v3kNjawQLRiMevCDlXXHKNxviQ0shtL6/8r8GJ4
 nR/Q==
X-Gm-Message-State: AOJu0YwfQaW9e7m9DJUH+KehkraNGfZ/xev1AmkD4Rah5UfBOEFuKclL
 /YD8Yl00B4ON/7XABzq4HC08t52nx/6DUKrrkF1IsSeLoLzqI1dP7PfQGwdOJbg8AMuKM4p7mTQ
 dPOD4nZ1cuei2qY9YBrYgbxJlKemibngpoHkcdIfT5WLzkqgmkMy1gOq4qA==
X-Gm-Gg: AfdE7ckhfN2aBHjuEW/yJ1PYjhhNcCT7KC1PjvcPTUzTPCsZ3qR1ioC0aqmP9E2euQ5
 sTz93k26185Nrx16yrViPMFYy3fHZErCGgZMCAVdWjQyRJWqGlm55Lp1i8Ce+Z5uj6pw97ap9qK
 f4CIaRH1VJgMicFReFudk/0FQsV1iZKLsDgBbcgSRhqJ8FKflgLv/j6c9j/eoq/39N2WNy+RVKI
 AURlN+qj8JgmpwE5wmBUIoozVpwxINOjyG41/QdyaMgOuf47FUWQjuCvsSTTL/75t0UjL48W/sM
 1nF/1PhOtPw2A3ZYRYHqnzY3pq+24g7ZjayGbYlVxs0A3JtohV9CEIJ+/SXv4wlYcClGlf46ACy
 EoiVWSw6I+KUmEl+huwLR98+EXZwKTyTmnDIlaH/WE8HsPM5c1is=
X-Received: by 2002:ac8:5d49:0:b0:51a:1a44:101f with SMTP id
 d75a77b69052e-5213aa6a5dcmr133938491cf.21.1784547733237; 
 Mon, 20 Jul 2026 04:42:13 -0700 (PDT)
X-Received: by 2002:ac8:5d49:0:b0:51a:1a44:101f with SMTP id
 d75a77b69052e-5213aa6a5dcmr133938231cf.21.1784547732841; 
 Mon, 20 Jul 2026 04:42:12 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49562709500sm41951155e9.14.2026.07.20.04.42.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 04:42:11 -0700 (PDT)
Message-ID: <56a25874-cb6f-4510-8946-bd60e11fde43@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 13:42:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/xhci: clamp interval exponent to avoid UB shift in
 xhci_init_epctx()
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Feifan Qian <bea1e@proton.me>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <sXJQOREScD4G6fYInirO2wbLtvZf6EK1yuTrP6U3GQBM5dIq7dhRnCm9uxSSiRRK0b4m7OEZRqEgjzHCTFoS0DruFvYUXh-UUXhkY0x786A=@proton.me>
 <CAJ+F1CK=jxw1Nf8UYa6jx344HknSXyj5A4MaoUWr5xJSK-ohjg@mail.gmail.com>
 <f8f6b689-eb5f-442b-ae69-f09c226ea9f2@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <f8f6b689-eb5f-442b-ae69-f09c226ea9f2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -WFkv1uyu5CtoNynJeMNrzwgGBNToB4v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEzMCBTYWx0ZWRfX/AusAfzdpkyL
 iRxQYLPmreVkj1t43Apf414MkqaRIYfK+OgWC/BDv2qPuzsFq1hBScuw3rTOLlvbQ1jlG4bDTLL
 FMfJ1dbUQKZxNRhHHZ9XRkpqpr9h5IMQscDj6Hl2QESl4jG8vNBTtAZKjclaoyGE1d8rPyQX/lO
 Gez2KpGsTqW+9tz8KTJpDDDKmS9i6+AJzIq67+mT4bVHmP/fzQzgAPNwG43fzC/IYi0kDwtPWur
 IauB5s9BkinnoAPR6u8e0+Jt8TkXh2kOH9LNetk9Olk1nCJiL+LrzhdDIK5DU6l1zms97digbx8
 mYP+eyiSyvK5SSYwgo1ijYvYBp9rN9/F3ls1S6G1ke+9RopgAym7hgujiDpOIembT/iqHcMrLw7
 W/wwtXUbnz6vOXWGo8rJttawNRDhsPMN61uzB3+GPc1pg7GWkC/Hwi9CEZ3mDfeuwXzUHyatNjN
 Forl8grPOq8J28rjlhQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEzMCBTYWx0ZWRfX+4vNYUarpE/6
 cuMRf79mpQd7BLAHiC5BDgCtT8iezZZvz8TEYBml0qMZq5K7SBCRgSnCq+cYHEbb8InDu5DFjch
 GcD3ws4yeWepGPMdgyQo4qb627U1fKU=
X-Proofpoint-GUID: -WFkv1uyu5CtoNynJeMNrzwgGBNToB4v
X-Authority-Analysis: v=2.4 cv=bv58wkai c=1 sm=1 tr=0 ts=6a5e0996 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=tTXoP5QR1v55suf8amIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200130
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

On 20/7/26 10:37, Thomas Huth wrote:
> On 24/04/2026 16.54, Marc-André Lureau wrote:
>> Hi
>>
>> On Fri, Apr 24, 2026 at 4:37 PM Feifan Qian <bea1e@proton.me> wrote:
>>>
>>> The xHCI endpoint context dword 0 bits 23:16 ("Interval") are written
>>> by the guest and passed directly as the shift amount in:
>>>
>>>      epctx->interval = 1 << ((ctx[0] >> 16) & 0xff);
>>>
>>> The shift amount can be 0-255.  Shifting a 32-bit `int` left by >= 32
>>> is undefined behaviour under C11 §6.5.7p4.  With UBSan
>>> (halt_on_error=1) this causes QEMU to abort; with aggressive compiler
>>> optimisations that assume UB is unreachable the result is
>>> unpredictable.
>>>
>>> Clamp the exponent to [0, 31] with MIN() before the shift, and use
>>> `1u` (unsigned) to avoid shifting a signed integer.  The xHCI
>>> specification defines a maximum meaningful Interval value of 15 for
>>> most endpoint types; clamping to 31 is the minimal safe fix that
>>> preserves the full unsigned 32-bit range for any compliant value.
>>
>> I think we should clamp it to 15, to comply with the spec.
>> Otherwise, the patch looks fine.
> 
> Some endpoint types seem also to allow up to 18, so I'm going to pick up

Which ones? I agree with Marc-André they are using illegal values.

> this patch with 31 replaced by 18.

If we don't want to report the illegal value as GUEST_ERROR, I'd
just clamp to the spec and call it a day:

     epctx->interval = 1u << extract32(ctx[0], 16, 4);

> 
>   Thomas
> 
>>>
>>> Reported-by: Feifan Qian <bea1e@proton.me>
>>> Signed-off-by: Feifan Qian <bea1e@proton.me>
>>> ---
>>> hw/usb/hcd-xhci.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
>>> index 0000000000..0000000001 100644
>>> --- a/hw/usb/hcd-xhci.c
>>> +++ b/hw/usb/hcd-xhci.c
>>> @@ -1119,8 +1119,8 @@ static void xhci_init_epctx(XHCIEPContext *epctx,
>>>          xhci_ring_init(epctx->xhci, &epctx->ring, dequeue);
>>>          epctx->ring.ccs = ctx[2] & 1;
>>>      }
>>>
>>> -    epctx->interval = 1 << ((ctx[0] >> 16) & 0xff);
>>> +    epctx->interval = 1u << MIN((ctx[0] >> 16) & 0xffu, 31u);
>>> }
>>>
>>> static TRBCCode xhci_enable_ep(XHCIState *xhci, unsigned int slotid,
>>> -- 
>>> 2.43.0
>>>
>>
>>
> 
> 


