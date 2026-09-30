Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BC5CA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxDm-0003ld-NZ; Wed, 30 Sep 2026 12:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxDX-0003hd-EN
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:31:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxDV-0001VG-FS
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:31:39 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UDxpo23063756
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FWJYFCRGwZ36QO93eeTM8glMpUUsVmJa+tnJ2Uness0=; b=CT0hJwx9I3yoVAwk
 BVZL/XsuC/AEvBEFRRELUKvLAHMFcssCQJoM4GGVGgPPpJTh1ib1CDeUUpzEiROY
 yVjzUQCuhu2rm3UemWiyF+NUEo89vpPNbvEIzqziNciCMPCT04FOXdY2tmh3zhAa
 Axf7nB+WLxcyS6HH91Y5CYYNTh4QirYYDbRBmWYlGUyyc3OBdNQ/KbnUFssCdVff
 L75rxXfuVXtDAcwArInSyCOYENixevV0Bn/8QekEiOizRtcHqKuEucrsOcJzyHim
 k9YbHDDTYpLwowez0GDZ5da62Ag9bPJpqXHuy4k3ehnwcQnhLvWEEl5fGgObznMV
 Awquew==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0smjkk1b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:31:34 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7b43c5f2b6fso571241137.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790785893; x=1791390693; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FWJYFCRGwZ36QO93eeTM8glMpUUsVmJa+tnJ2Uness0=;
 b=Xn93po3t0sGwjppZwAK7aaDd0U+dJ6FNbMnNfP6hSSCOiF17ckd4xYhB9HGV4qbhP1
 2P4dCmN8/TSlXXwUQV41wayMIAzjjvWlmvOBvKERmJLp8lax7+L8O5L2M+uMFkVVYxsQ
 wCiYONsJxjetCdyjJd7qSRDp4Kv4p3j6iUbeGt+G3AMFv0cCq70qLmYPD8GGFLJ1SxR1
 7G1fjxAeb9j01ggjM6D6AiEftlNM+MDyDVVryBNWZXEqRXTSbmW7/lNVDqtnRu8BM1U6
 adFL3ihF9SNIi7gpPjbhtTt2wEbLNpl2MtVMlNLyE8GVgmpDm2RFJngH7FWnMmXn7i5N
 UFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790785893; x=1791390693;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FWJYFCRGwZ36QO93eeTM8glMpUUsVmJa+tnJ2Uness0=;
 b=NTe7w5zfjy1K5neP5ljsuRiffODYd1nRFo4PXYr5cSHYRiqQN9GYpgCYpAwNZs0RPs
 BhrNFyWL+tjnbhLJTfNvQzOSuhouxKm2W6FJ4v45sqw0x1YuGR4PhbQN55zbTz17/LQP
 YySisIP3SQOgJjaD+EuzatWjWaXaL6EdLDfPCON3sFHmiOp7MvQ0tiJbmg/V/gClFrHa
 NFaF1hSCtkgdy1L7UHAFdt3fsmsfUmO/aVFr+5DDLVnFgpr8mjynuGtdyxE0odsJqexd
 pO1NXuiujMYPRs6BC7KdM0O3yOsEzkgJrB/Ys8Y9ZX7Et8mwqueD0zbMKMUhK768vzLt
 JM8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzeiGGdAKwe5Q6t8xFtUPTUkvPiTKtS33G6Rt6/F/DyyMNBXBmq3xvyEjzHJAVZrq20ai1dNLeym/5x@nongnu.org
X-Gm-Message-State: AFq9FYI/YCCq2POOzYS7FeGwG8AkUzLDzSEJOE5qt/Br8DJVsSurlLRa
 XkenlbDQy6Vma6ypayLCaQYv/RybqM/TalvqwfR6wvDLxwMQxhuCqHibxIz2B1uR7wfJVSHwuwS
 20r4281EUNUECLWQzI6eln80b/ijTEdBbjVJD+KdyeNqAIXBv21nFuIDZSA==
X-Gm-Gg: AYBFou2eZ2G9FiZ7980XjcgS0WDwYhKBwKm7nJmLSrLu6s2GssCz8dqNEN7IzHwYZY0
 q5tey9kpYBW36vi7QvBncD4fEyhmLoyJRFliOcnNWku1nZdnAMacLzy9COxbpR0yO/S4uctrijY
 R91IacdvNJbUi0eEETp3pjgj4LOwkj1PnxQmGJ+WDQHABy1dg/shcD39bLaXGqH/+tW/q7WewbJ
 imCAHdhozPoSeC6DfW7t1n4M/8NoL+n6yE9A/eiBnk0uzLFXS6d4qn+QLM/Qy7mUZMAQ1DYiKGs
 V7YAiNV9FAQSIByCoRPoNEESSo2XEZsXjPFukHgKfyEwsqJ2rx4PIF5YJn8FVXUy13q/1KCW78p
 k8oelzQ7IE8270GLedkw=
X-Received: by 2002:a05:6102:6a91:b0:7a2:2a4c:606a with SMTP id
 ada2fe7eead31-7be729b71c7mr513619137.15.1790785893421; 
 Wed, 30 Sep 2026 09:31:33 -0700 (PDT)
X-Received: by 2002:a05:6102:6a91:b0:7a2:2a4c:606a with SMTP id
 ada2fe7eead31-7be729b71c7mr513610137.15.1790785892904; 
 Wed, 30 Sep 2026 09:31:32 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b068bcb8fsm229567f8f.1.2026.09.30.09.31.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 09:31:32 -0700 (PDT)
Message-ID: <9ecf7231-b4f9-4db8-aded-818fd7a79df5@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 18:31:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/dev-smartcard-reader: fix OOB read from pending
 bulk-in ring
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260729075743.333920-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260729075743.333920-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2NSBTYWx0ZWRfXz2TR04iNY0fY
 /RvGbaJhRmpBCwu9twe4SPBuKgWWoH+lYAGOdx46Ul592LndkvpgZwM6KenmPUcPv3sXT15cpFz
 rqcQ52he+7sSqPLbkU0IOE1E+2tV1X0=
X-Proofpoint-GUID: A9sjDQXMItzfH6S12KbrlUZDD3mFXsn2
X-Proofpoint-ORIG-GUID: A9sjDQXMItzfH6S12KbrlUZDD3mFXsn2
X-Authority-Analysis: v=2.4 cv=KfxHIgYD c=1 sm=1 tr=0 ts=6abd3966 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=7g8aA7A78AY7OC82r+w+4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=bnhSglwntvHQ-2qSQIsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2NSBTYWx0ZWRfX4ZTn4ADwhoHk
 tgTji9qU85wQ7PeHYU48mPiqxNzj5ghnJX+Vbwcb2eHTWyguIzfCobvcEckzWuYzVwSm2dxTIZb
 Oh9/xRz4npHPjs8KyM+62ZqD6bY8hA3AaeyCOGvdwe3/MbNTWzGKvA17FnKN26j1aMJsDjb48bM
 Pl2prgq2NSpl2EzNmKaZUoaJqZdOiux1zqRLgO+bY1KXOKRn7yqLqYU741lup/kRhcKnSNQAMZq
 W27aujodqUN8Qj6VF0co0tlFM7qymDVTM3tT/2btk7f01YVFdAnHsfQbTHX/JoavmxIr9cb9ue8
 ED6566XhB8PmhhgL0x5Luzq+niwmUjlrepvqT6uSt/n0W/sGNUjwD+H/Eh0YUwuOWb1eaAgSOwS
 0up8oxBpBNUBmTveoXhymKYQ2SqbaSaxJJyEagsL3nb2ny1GcXSWRu8g9nWWHTZZVqbKcIylQst
 NTryK7j1v1tRaTd4GJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300065
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

On 2026-07-29 9:57, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> ccid_bulk_in_get() decrements bulk_in_pending_num when a slot becomes
> active, but the slot is only truly free after ccid_bulk_in_release().  A
> guest can fill all 8 ring slots, partially read one (leaving pos
> non-zero), then send another command whose response reuses the active
> slot. The stale pos > new len makes the uint32_t subtraction in
> ccid_bulk_in_copy_to_guest() wrap, reading past data[].
> 
> Move the decrement to ccid_bulk_in_release() so the slot stays busy
> until then. Add an assert(pos <= len) before the substraction.
> 
> In practice, the device advertises bMaxCCIDBusySlots=1, so a conforming
> host never has more than one command in flight and the ring never fills.
> 
> Fixes: CVE-2026-18204
> Fixes: 367071447ec5 ("usb-ccid: add CCID bus")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4086
> Reported-by: Warisjeet Singh <sinxx198@gmail.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/usb/dev-smartcard-reader.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
> index 964c142d1066..5f8b95be46b2 100644
> --- a/hw/usb/dev-smartcard-reader.c
> +++ b/hw/usb/dev-smartcard-reader.c
> @@ -580,6 +580,7 @@ static void ccid_bulk_in_release(USBCCIDState *s)
>       assert(s->current_bulk_in != NULL);
>       s->current_bulk_in->pos = 0;
>       s->current_bulk_in = NULL;
> +    s->bulk_in_pending_num--;
>   }
>   
>   static void ccid_bulk_in_get(USBCCIDState *s)
> @@ -587,8 +588,6 @@ static void ccid_bulk_in_get(USBCCIDState *s)
>       if (s->current_bulk_in != NULL || s->bulk_in_pending_num == 0) {
>           return;
>       }
> -    assert(s->bulk_in_pending_num > 0);
> -    s->bulk_in_pending_num--;
>       s->current_bulk_in =
>           &s->bulk_in_pending[(s->bulk_in_pending_start++) % BULK_IN_PENDING_NUM];
>   }
> @@ -1078,6 +1077,7 @@ static void ccid_bulk_in_copy_to_guest(USBCCIDState *s, USBPacket *p,
>   
>       ccid_bulk_in_get(s);
>       if (s->current_bulk_in != NULL) {
> +        assert(s->current_bulk_in->pos <= s->current_bulk_in->len);
>           len = MIN(s->current_bulk_in->len - s->current_bulk_in->pos,
>                     p->iov.size);
>           if (len) {

This is the runtime path, but we need also to clear the reset (and card
removal) one:

    static void ccid_bulk_in_clear(USBCCIDState *s)
    {
   +    if (s->current_bulk_in != NULL) {
   +        s->current_bulk_in->pos = 0;
   +        s->current_bulk_in = NULL;
   +    }
        s->bulk_in_pending_start = 0;
        s->bulk_in_pending_end = 0;
        s->bulk_in_pending_num = 0;
    }

'''
Resetting or removing the card must also discard the active slot so
that its stale position and pointer cannot be reused.
'''

With that amended:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

