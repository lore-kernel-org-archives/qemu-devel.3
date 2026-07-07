Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA70C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh6Lw-0008GK-N1; Tue, 07 Jul 2026 10:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh6Lk-0008FH-H4
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 10:00:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh6Li-0000uh-3F
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 10:00:36 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8s8e3542046
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 14:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SdY5Ss2f07htCAGCocOdfFmUS17CGfm6UvW1dEMRb9U=; b=KDWz6gPcRT2faT+l
 RRG1RFXuijvGevVFvmATeI9m5/W80JIlHFCbfV5YMfj7lywe4YR5P0BKO1crgwml
 Qv+JpZnDn0N9z/XJfqbgntxlHEt3xaXJLgSRgmDE/OhNysdo8u/LX/+OU6zr+Jx9
 p+e61TKBnJxqnkSWiTn4RpyK86+GUUeI4BADmMp7Rn1rrtTNz03omkJozTfK9JEV
 INQRKe21/hmwfJWdqqO3p9UjJwlopzS/EupkF4+opQkaH3HVR+nsEAd9GJgFrc5z
 GqYE6pbVckJFQ4EaMvFCzklsVSGdjRYR5jTyiSpnWcb9Sai3MGqeewGh+Ess3UMJ
 T20Ejg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8su729d1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 14:00:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1d30035dso35756101cf.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 07:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783432826; x=1784037626; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SdY5Ss2f07htCAGCocOdfFmUS17CGfm6UvW1dEMRb9U=;
 b=POAoACG9aEQXzMXgi9PwRXfKEKYnYzxUcrL4sO7U0gMbgSMRk6NlwjQX/TZ2NGgMR9
 P+LPcUyBIVqpTPOQIERapqmklaW3f8h5Hp9Qv4X0IRohEAgyKUfX2kgfA7GJr62He7q1
 d4QtLBywE5yD+fCXOQddpt1vfMdqecMtvcAtsBVfWW78EDIa0Xr0V22PuCBKdByAe64N
 AUUHIw1/ZIGFERxKlMz23M/ovSVvJ0DRJMvFpVX1mydmvdtvxHhlbB6LDpwj8m/ZefPu
 uAjfey3OFV8pjB9YM7oju8DoaZ+DTh8W/9EcPpbNrev455GXARRCsK3rCYP9LnyUX8G+
 lvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783432826; x=1784037626;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SdY5Ss2f07htCAGCocOdfFmUS17CGfm6UvW1dEMRb9U=;
 b=gj9/eyKlczvvaE+jmgWK0nkN9DKpjyUGwFney3lYK/i8A7qdSJHLsuNlM+7qrJsjbl
 cC6V5vAzdudlBqdfJPiH4OVhQp50GX2f9DFchW/l3JQTZ7hyYaqjQ1pZWSNrrbNjGQtC
 /y1QRNaZp71WdooxW63u/323Rp41hMsesdquWjEhNqidqi8dsL9+XkrB6u5IMvYtlT2K
 W1XlMlNkiZ9t+7wX2qQ/9cOd0xoy3rk6b8jdMLjoBHcgJxuhrBCPMqLXhBjP7fNCFMRM
 EwzIgQZ83mb6KW7iDNFBIW/EwW+WtsRUUO+kU0jR5IXbxjEFdSPtG+MLYg+X5pUql09Z
 u9BA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrviVDX/g4YqKsd6uxbfLFzHQfoZclVDI+ojI6O90mr0JDkXZIJgxEV8RdzWK09tpfpt5dk9RV9FSGQ@nongnu.org
X-Gm-Message-State: AOJu0YzFnbpA2j8TDHbBVPBS9FBiJjS+HUpHPdxSYUUfRfIxO43v7uDV
 LI3yHi1teQW6kSXoyNF6dm9eED1NHO4Nl9tUHfYpQtb5JmNSDYXHKJ541m+D5Vt3h5R5h0fq0lp
 0Twce70HWhRKBFh+Tbcz9qB066hwVhHNL51lpNKIJQHSTA348ioPnz0if3A==
X-Gm-Gg: AfdE7cmyjfNqHNWBnYDVhBQvW1yjFxZ6t0ngPtKPERY24KsLBgsyGIwffglZKBrmzDP
 gY74iYpt4ncLn8FIQVHSKa7y60vNTjHXWWwwQiInPNmAs9c4WtEH6R5fZt2tQqv92C9lADSuz+h
 QSq4inzi2EhZs0Qq/m2IR8OOv1mtrKO7Kuk7rhU0cPtZCmuHQa5AD3gtJPDv2btqURUey5qwRt3
 atKnPqXpoBACu+v6BmCxBBk7tzJhCCg93B00s6RcL4fU62jI6C4e9kj3tH4W7mybIbEbniETJV6
 H0dYA+GQFAaPE2OH0bLALau+7BI2qkct/V/Z0WO92qvEerQbvC0zgjDASaxGzHSmshaq568VdUX
 C65wti+KsU/+qfWx+Q6JqwSsaKSLtQRBrMnsCDFurGPuENPavCO8kEVOkBnTJ5w==
X-Received: by 2002:a05:622a:64a:b0:51a:8c97:938e with SMTP id
 d75a77b69052e-51c748ee544mr48971701cf.69.1783432825809; 
 Tue, 07 Jul 2026 07:00:25 -0700 (PDT)
X-Received: by 2002:a05:622a:64a:b0:51a:8c97:938e with SMTP id
 d75a77b69052e-51c748ee544mr48969691cf.69.1783432824155; 
 Tue, 07 Jul 2026 07:00:24 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ad9bcc26sm140966766b.34.2026.07.07.07.00.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 07:00:22 -0700 (PDT)
Message-ID: <85a6a1eb-fa68-44ba-8cbd-16e572347c5b@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 16:00:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] hw/block: m25p80: Fix dummy byte handling for
 Spansion flash
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>, Hanna Reitz
 <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20260707083431.219671-1-bin.meng@processmission.com>
 <20260707083431.219671-5-bin.meng@processmission.com>
 <92dd132e-e4d5-43f9-a207-c59697c87204@oss.qualcomm.com>
 <1e79dc11-0df2-47ac-a1c5-819398303e48@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <1e79dc11-0df2-47ac-a1c5-819398303e48@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEzNyBTYWx0ZWRfX2PBt5Oaddm6d
 vwRu/vl3sXSsTn2+lf89VjY6dZaLMq58gI3SXWHMwvn/5XmRjGXIOBCV2enzaEmrzQq0HpG9m9R
 pfL+B7jHPnwdLJJagGt/TSmo2B5cgdGaTAgzXyyJo/Q1fxkRWsgUWtUS68eH44/jV1q7xB1xzRX
 L28ahJ67zu408FqUP7PLfKqONBLojXGnwy+kM2COuibbs3CeA62dgYdi+C9Bc6ajpRCd6mTkUnv
 cFfGsQFiIX0vQC8ONcpz9XMUZbchnhgG9Se+HgknstHJyK5fOyL2BAin75tgo2LEOD0vBpTt4q0
 k3xkKrWE5QC6v/xSB1P9VEVgJ0vQR7AwNB2Spnlzv6pDR89nP1cGuOpcW74GPPzWvLzdDI/2rvL
 9PNarBadSghZl50C6y9v5cGhSawPmQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEzNyBTYWx0ZWRfX6VUHh0x7tRaV
 nBQWYZZEDU/E3w7jfjaEZGz1jCXgzFjpdLaYxlSysHVDo1/RNXCsEFcykn0Rmsy9MWBcuzSa2NO
 DVmPnql7uZggtzKz6W4upCGN5x4BtQM=
X-Proofpoint-ORIG-GUID: lMM2zPdOV1nYl_okOXrjIyLwr86ky1VH
X-Authority-Analysis: v=2.4 cv=HN7z0Itv c=1 sm=1 tr=0 ts=6a4d067b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=bUQKSiCPAAAA:8 a=FRSEYCzRAAAA:8 a=20KFwNOVAAAA:8 a=6_MUcFxZKTcQVPqAzMIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=-fHZXUhsFbuwFN3fwQAr:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: lMM2zPdOV1nYl_okOXrjIyLwr86ky1VH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2607070137
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

On 7/7/26 14:51, CÃ©dric Le Goater wrote:
> On 7/7/26 14:34, Philippe Mathieu-Daudé wrote:
>> On 7/7/26 10:34, Bin Meng wrote:
>>> Spansion flashes expose the number of dummy clock cycles through CR2V
>>> register [1]. The value is a cycle count, not a byte count, so the
>>> m25p80 model has to convert it to the number of whole SSI transfer
>>> bytes consumed while collecting read command data.
>>>
>>> Add a helper that multiplies the CR2V dummy cycle count by the phase
>>> width and rounds up non-byte-aligned counts, matching the byte-oriented
>>> SSI model. The default eight-cycle configuration keeps the same byte
>>> counts as before.
>>>
>>> [1] https://www.infineon.com/assets/row/public/documents/10/49/ 
>>> infineon-s25fs128s-s25fs256s-1-datasheet-en.pdf
>>>
>>> Fixes: cf6f1efe0b57 ("m25p80: Fast read commands family changes")
>>> Signed-off-by: Bin Meng <bin.meng@processmission.com>
>>> Tested-by: Cédric Le Goater <clg@redhat.com>
>>>
>>> ---
>>>
>>> Changes in v2:
>>> - change spansion_extract_cfg_num_dummies() to 
>>> spansion_extract_cfg_dummy_bytes()
>>>    to avoid confusion
>>> - use assert() when the dummy bit count is not byte-aligned
>>>
>>>   hw/block/m25p80.c | 32 ++++++++++++++++++++------------
>>>   1 file changed, 20 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>>> index d7a9d79373..545e0b5728 100644
>>> --- a/hw/block/m25p80.c
>>> +++ b/hw/block/m25p80.c
>>> @@ -1057,6 +1057,23 @@ static uint8_t 
>>> macronix_extract_cfg_dummy_bytes(Flash *s, uint8_t bus_width)
>>>       return dummy_bits / 8;
>>>   }
>>> +static uint8_t spansion_extract_cfg_dummy_bytes(Flash *s, uint8_t 
>>> bus_width)
>>> +{
>>> +    uint8_t dummy_bits;
>>> +
>>> +    dummy_bits = extract32(s->spansion_cr2v, SPANSION_DUMMY_CLK_POS,
>>> +                            SPANSION_DUMMY_CLK_LEN);
>>> +    dummy_bits *= bus_width;
>>> +
>>> +    /*
>>> +     * Assert that the dummy bit count is byte-aligned
>>> +     * as SSI core can only consume whole dummy bytes.
>>> +     */
>>> +    assert(dummy_bits % 8 == 0);
>>> +
>>> +    return dummy_bits / 8;
>>> +}
>>> +
>>>   static void decode_fast_read_cmd(Flash *s)
>>>   {
>>>       s->needed_bytes = get_addr_length(s);
>>> @@ -1075,10 +1092,7 @@ static void decode_fast_read_cmd(Flash *s)
>>>           s->needed_bytes += macronix_extract_cfg_dummy_bytes(s, 1);
>>>           break;
>>>       case MAN_SPANSION:
>>> -        s->needed_bytes += extract32(s->spansion_cr2v,
>>> -                                    SPANSION_DUMMY_CLK_POS,
>>> -                                    SPANSION_DUMMY_CLK_LEN
>>> -                                    );
>>> +        s->needed_bytes += spansion_extract_cfg_dummy_bytes(s, 1);
>>>           break;
>>>       case MAN_ISSI:
>>>           /*
>>> @@ -1111,10 +1125,7 @@ static void decode_dio_read_cmd(Flash *s)
>>>           break;
>>>       case MAN_SPANSION:
>>>           s->needed_bytes += SPANSION_CONTINUOUS_READ_MODE_CMD_LEN;
>>> -        s->needed_bytes += extract32(s->spansion_cr2v,
>>> -                                    SPANSION_DUMMY_CLK_POS,
>>> -                                    SPANSION_DUMMY_CLK_LEN
>>> -                                    );
>>> +        s->needed_bytes += spansion_extract_cfg_dummy_bytes(s, 2);
>>>           break;
>>>       case MAN_NUMONYX:
>>>           s->needed_bytes += numonyx_extract_cfg_dummy_bytes(s);
>>> @@ -1151,10 +1162,7 @@ static void decode_qio_read_cmd(Flash *s)
>>>           break;
>>>       case MAN_SPANSION:
>>>           s->needed_bytes += SPANSION_CONTINUOUS_READ_MODE_CMD_LEN;
>>> -        s->needed_bytes += extract32(s->spansion_cr2v,
>>> -                                    SPANSION_DUMMY_CLK_POS,
>>> -                                    SANSION_DUMMY_CLK_LEN
>>> -                                    );
>>> +        s->needed_bytes += spansion_extract_cfg_dummy_bytes(s, 4);
>>>           break;
>>>       case MAN_NUMONYX:
>>>           s->needed_bytes += numonyx_extract_cfg_dummy_bytes(s);
>>
>> This breaks the test_arm_emcraft_sf2 functional test:
>>
>> not ok 1 test_emcraft_sf2.EmcraftSf2Machine.test_arm_emcraft_sf2
>>
> 
> 
> No problem on my side.

Odd, I can reliably reproduce... I queued the rest (except the docs/
one which lacked a SPDX license tag which I couldn't add myself).

I'll let the remaining 2 via your aspeed tree (this one is a fix
anyway).

Thanks,

Phil.

