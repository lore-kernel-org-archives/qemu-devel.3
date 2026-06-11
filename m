Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D6CCD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXdZb-0007ZY-RT; Thu, 11 Jun 2026 07:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXdZZ-0007Yo-48
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:27:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXdZW-00036l-4y
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:27:44 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B9xRkp174135
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TrEpWiD9B1fxzgTZserzElZXCb43ZSOQCELZsVbFCsA=; b=bvhZcOk1kSPYFG4e
 AstZN04WJsh+GsFH79aWVD1PR5SzJvambZtYjkQF/0F7ogQ18yrxIuRvCQz8JH8V
 AZHlKmRiaRZ+l6DqdLOoFD1oAo1bEpi+FW9lGtfZ5dNRuuqoQTBVujKvmGnfg3uO
 nj2KyNoo5zofmJTKTMgaPYB3/4ljuJKJzMvuIEziVINIwHuznMgOjKO59L6jsYXF
 Tw6FCN3RpygPpVlyyxHsc7ZC8EcPJ3/nj2eP3wdiuBK52KJCHASQ6Or+9numQCL1
 sGfbBnXbCWKWT7Nj4Iq4mNEvRnQo5ld956HTAWAUhoumv/uywCBu46AYicCZztRV
 tU2wXA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6vb337-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:27:40 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-517600719a9so126921801cf.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 04:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781177259; x=1781782059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TrEpWiD9B1fxzgTZserzElZXCb43ZSOQCELZsVbFCsA=;
 b=THyInQQ8iovP+jDBaDH0HMBXCYtUXuaMO+3LBU7an39KrKzFDXheBiXwPyAV/y3ZUE
 qj8MqFG+rIqtXExKcnQ67VXsR3AG+NPvEyHG4owddDaX3N7N7Zl1p7i2XGb8vpzI0OOj
 OvvKLVnJXVWsZZ+xd+35otGGO//56l+jyQbJe9p3hAPKzXe29OKYe/hjR0WOkGQw+fBe
 NsOnIYyQu4Oi5hNa0zSglNjcbaeFgIwAUTRiciUje/j/dsBc2JERvvxAsP7RxjvtHOUr
 nByO5LV/Y29WUHYtbHg48LYfdEAgAyvgxvhoLrAnEdDK8Sg7YIj0uC88ZA+k9TzFh8JF
 5nDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781177259; x=1781782059;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TrEpWiD9B1fxzgTZserzElZXCb43ZSOQCELZsVbFCsA=;
 b=GUrs0nNdh9tKwjf6InBOm2ay6FWLMaal2jweebz/KbLzLC3ox8YRjHhsTBGoKwtej8
 ngCxr5kVdfhZHWRVe/hXyegNiBJnrdPR1dCCQOKL5m7mUpt5xmGr2xQzchT8tGWclMSa
 ZISKN3XigSKWvGUptf7evkmVRrjPgnHeEWniBW1ckn6MhRBUZ/y8HnP8+Aq8Lt/NrpzD
 vE7nqglf/IpOCJR95+iOQx4npVDsMuAYYb0dCLHhWH0eczSREqIrwRJEYMLaFFB1j74b
 mVf/CKow1is1rZ/zEtv82ywVLa0+cmZwGs/HBVxWhKLNjzZu/YYTWOeT+SfYtFBXrQVb
 Oyrw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MogDxYHRNqRY7DKLK6PqINqU0PEe7u7WW/XPubIqpN22I604Qp4AXQwD+j9IRgl392L+Nb/4/+t2m@nongnu.org
X-Gm-Message-State: AOJu0YzUZ8idACFTDkCBjvGO5LhF2aT/C0bYn7poNZ6IL8qXga/tXaAi
 wgZdPl4CDWXUL3T/tr21G+c3vcalr8tj41JuNxHq3RZXw6VC/ITZxbZPZMdVBz/U57GHtDO3VML
 9CnKusxU+Mw6MLCZhC7O/aC36P8fzeJXLh1lgLvAHQRaZ2l1ogeoaxztAsA==
X-Gm-Gg: Acq92OHVN6yKGuwIsrPEDBl9mt058Ii9Y8gaTpiu2NuF9tNItUuzZ9ETYBo0rG+Ua2S
 JVB8mB83zxGkhOe2JoeXHj8dkEuEsvBcN5TYCtj7weIr0tQWIgBeX48n84VYzes1poq01f6I+jl
 st9EdHhn7DkorNEspmHsL0+A7Co/gxeT1w+MQ3bVZuBrKRghP92qh+jDSYY0bpFs1OvujBfleOt
 XURJAoDdFcQs7eYqkMgLzT9icFxjljLM5o1mHZ7R8QwbLvMrUqzicnsvIyb/oqrxDnknz+tWWKy
 0NjC/DCvsRVxKB+V9qeTzjC5giV/OY/u083r+7RRI/IEs4VTrrVl/z8RdAnn7Dbqk6dOa0n1Ru8
 fAf4g/Sv91VC0NmI/GkQp+Us2IyXJNitsiOaaWS/qOKizfUCyF1dpQIVLdMp3O0oLoF6gTxiLCs
 VGPBJrJIJAIo7p
X-Received: by 2002:a05:622a:1451:b0:517:917d:e3e0 with SMTP id
 d75a77b69052e-517ee23c785mr33837121cf.32.1781177258848; 
 Thu, 11 Jun 2026 04:27:38 -0700 (PDT)
X-Received: by 2002:a05:622a:1451:b0:517:917d:e3e0 with SMTP id
 d75a77b69052e-517ee23c785mr33836581cf.32.1781177258329; 
 Thu, 11 Jun 2026 04:27:38 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f368e9fsm75849454f8f.37.2026.06.11.04.27.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 04:27:37 -0700 (PDT)
Message-ID: <1734e147-e8c2-4ae6-8f4b-9e7dde89f79d@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 13:27:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/22] ui/input: add LED state tracking to
 QemuInputHandlerState
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>
References: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
 <20260610-ui-input-v2-9-f68452dd6a22@redhat.com>
 <4d35d2d9-5770-4d90-aa5c-f8f9c8884ecc@oss.qualcomm.com>
In-Reply-To: <4d35d2d9-5770-4d90-aa5c-f8f9c8884ecc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Slm2xTUd0krnZz5LQVJ-D9G7McJm96C0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExNCBTYWx0ZWRfX1wmHwzJDYgps
 ITXRIi1HPlpMYATuGivaSdjJ5hT8ORM+HdvaiBJCuUPq9wJSxYWN3kztgS56Ex0p9iQNEL8fbOB
 se1KP1HBrqFiPKRc7V7saW/YEpb0CjY=
X-Proofpoint-GUID: Slm2xTUd0krnZz5LQVJ-D9G7McJm96C0
X-Authority-Analysis: v=2.4 cv=UsRT8ewB c=1 sm=1 tr=0 ts=6a2a9bac cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=-qKw8wkO41R6kL_1C1YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExNCBTYWx0ZWRfXzMtnG8R7YQsj
 YEiGu+6xpYYKZaGjHQvwhhlwvaOfp3pHwxwwvbodznwm6FxqfCRaVykI9hfWPSl5HG82DM0Sl/q
 3wlt7KcamDeAXMls0l/qo/JCFKg8AFhhn4Jd6KRmIjufMJnE9PykUeMebaSsWluEYjJI1YJer5n
 OPPYqFlJByy6l3ZWpWTNzx8qpBWUkPNMTy1RoMeviMG5G7Z1EMkTnkAURN3zRQrLaKgtc8tyBuP
 VOlNKkL6saLkKEtLOpLvu9hOvq+jLl8PZ99PxpFBYdxHxYFrB9rlSSVWW7Dv3eBbe8NNZ2lzRkv
 H5k805YUhxoqWzs7WAT6qviCyCEquSdvDHGMHM2d9S1vgDculRFizM2Nx9bMMPOcMO/j6Rk0M4G
 pTZ/m4qmA8HmpV2GIOnBLePuD/Cee64bM1ZEB/+9VcSPhxG5glXTEsw4e5CpPRK9WDqKNn5d9VY
 Vyp1vggtC5aGKo6tMxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110114
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 10/6/26 13:43, Philippe Mathieu-DaudÃ© wrote:
> On 10/6/26 12:56, Marc-André Lureau wrote:
>> Add per-handler LED state and a NotifierList for UI backends to
>> subscribe to LED changes.
>>
>> Devices call qemu_input_handler_set_led() to store their LED state and
>> notify backends. Notify also on focus change, or list update.
>>
>> Note: I considered conflating mouse-mode & led-state changes, but those
>> are quite different events (from different source kinds etc) and we may
>> want to improve the internal implementation.
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>   include/ui/input.h |  5 +++++
>>   ui/input.c         | 49 ++++++++++++++++++++++++++++++++++++++++++++ 
>> +----
>>   2 files changed, 50 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/ui/input.h b/include/ui/input.h
>> index 6df8ae3a8a3..66e5c1f4b06 100644
>> --- a/include/ui/input.h
>> +++ b/include/ui/input.h
>> @@ -151,4 +151,9 @@ extern const guint16 
>> qemu_input_map_xorgxwin_to_linux[];
>>   extern const guint qemu_input_map_osx_to_linux_len;
>>   extern const guint16 qemu_input_map_osx_to_linux[];
>> +void qemu_input_handler_set_led(QemuInputHandlerState *s, int ledstate);
>> +void qemu_input_led_notifier_add(Notifier *n);
>> +void qemu_input_led_notifier_remove(Notifier *n);
>> +int qemu_input_get_led(QemuConsole *con);

Can @con be NULL?

Please add some trivial docstring.

>> +
>>   #endif /* INPUT_H */
>> diff --git a/ui/input.c b/ui/input.c
>> index 15affeabf44..99a1090f8c3 100644
>> --- a/ui/input.c
>> +++ b/ui/input.c
>> @@ -14,6 +14,7 @@ struct QemuInputHandlerState {
>>       int               id;
>>       int               events;
>>       QemuConsole       *con;
>> +    int               ledstate;
> 
> In "hw/misc/led.h" we use 'bool is_emitting' which is clearer IMHO.
> 
> Now looking at kbd_put_ledstate(), 'int ledstate' is actually a bitmask
> of:
> 
>      /* identical to the ps/2 keyboard bits */
>      #define QEMU_SCROLL_LOCK_LED (1 << 0)
>      #define QEMU_NUM_LOCK_LED    (1 << 1)
>      #define QEMU_CAPS_LOCK_LED   (1 << 2)
> 
> Maybe rename as 'unsigned qemu_leds_bitmask' or 'uint32_t leds_bitmask'
> or simply ledsmask? (notify_input_changed below uses uint32_t).
> 
> And:
> 
>    qemu_input_handler_set_led() -> qemu_input_handler_set_leds_mask(u32)
>    int qemu_input_get_led() -> uint32_t qemu_input_get_leds_mask(const)
> 
>>       QTAILQ_ENTRY(QemuInputHandlerState) node;
>>   };
>> @@ -38,6 +39,8 @@ static QTAILQ_HEAD(, QemuInputHandlerState) handlers =
>>       QTAILQ_HEAD_INITIALIZER(handlers);
>>   static NotifierList mouse_mode_notifiers =
>>       NOTIFIER_LIST_INITIALIZER(mouse_mode_notifiers);
>> +static NotifierList led_notifiers =
>> +    NOTIFIER_LIST_INITIALIZER(led_notifiers);
> 
> leds_notifiers (plural)
> 
> With the changes:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 


