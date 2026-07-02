Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5CBC43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 17:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfLCI-0005wf-Ru; Thu, 02 Jul 2026 13:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wfLCH-0005vx-F7
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:27:33 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wfLCC-0007HQ-4d
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:27:33 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso1053683f8f.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 10:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783013246; x=1783618046; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gDWLf3Imu3AeNQYGp84KvudlW5v8ha0NJcq4upYNVCc=;
 b=auuiejcNiYU8/8UQVzzWOzRyNVXZa3L6pnnB+TsRZk138gGqo9QV47pJs90X27Hwgt
 AlrGyIczlDu6JAb2cRi3I3Us56fO0bpvzKqbagyFix70w+kcMC9kCZqZsiuSZKSjxeLN
 QVR+KJykrfoeNhS4wT/MlafT2m8tAKoGwUcJ+TXVdYraV7cbHIwHjkSunY0pqIiSlSdU
 58wFOYnnZhRucRaVc0iU8aNh/wIZxIqmVoU94Yj2tcVBUAMhpzS8B+IV17DWapbVsVhi
 CHdJkA9CoiT3Nvzz0UFYo9FNb12Hca30vbYS/w2vJeW3UYa+1vzJQmE5GWq6WAc8U7M/
 DxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783013246; x=1783618046;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gDWLf3Imu3AeNQYGp84KvudlW5v8ha0NJcq4upYNVCc=;
 b=OI4COuSeY/QrZyYhHXRB+JxgOD629VjpHrMp9iolwTGj3izhQo9rgcJhHHGJ3kZToa
 w23FzN3MqidShnIR4NdFQKFUlbyodzrGpH2VyQG3+UquOs4VT1UHYxIQDSggL+xdzIY7
 tqvMuck8XBnJC+P9tN/HWLqNDzbn6uwBl6+ci1cu2pr0lfZo5FN6WCOumkFfIhoudyRD
 8u1qVQrt/j8G7n2N/PGBNsSdXTyJje8+pSbAIGK+tGPNpkyncf9ye1jlS99L89P1y2Bq
 NW7hv2OwyNzuO+FyJW8360cbGwJtBLMnIba/ulc484g8IdLly+qR1acA+A9R/yNkMSM+
 HASQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMgTs4ph2C1Y4XhmzKnj/SxDxmtRXRXwFh/4OOQWBKF9uzrD4oPQhWqFYAxntxCLOPLjg/3LiaTnBi@nongnu.org
X-Gm-Message-State: AOJu0YwbRkSYEJakb7hziX8a65Rz6JPl/V792eKVgZmzJgek3CQq95Os
 /b3tyCydZgoC4PAUw8sNoRNnC83Wubd2hHmvustVGpm7BTpOlXEw0d7v
X-Gm-Gg: AfdE7clIEd0TP5Ms0TSimW61WiQk/fYEKWdr8O9oSMagNf8AQMv4cJRIpRGG2tVoQ9Z
 MweJgeOHcSYI0ejZc2T+dC6riedBSxBijNWO9IzPUGcf4+fIridX6IT0wITQMGz2Hx+XuejJHbv
 EFG1aFCciKH6AHG2pHYZ3SNEMCOlZFyT9Rt79HAcAku2q3RssI68/gEnZKXqHaD2uk35dv1XucN
 Nubauas4/f/PSJgMBRrLD6+X7J4rwyrc7j0QIJAEApQHciexrHJnZsr+Nfr0iAYReuJaORnGg9R
 YvNDJzEfMQRIUHY8/RRVnvOupevg/Fr5zan4OcZDFhiixJcPCR/Vsh94DJNxrFvasbLGom9SMTF
 PruGHxW3xdju3FETcXV0Yzy2VSmiDce5GQz3gQ5JOI1A5aaIAEwBIkGee2bmdrfOTCLK9JPi8Bh
 /XRhLbem9NiUS0M4/6AgQ=
X-Received: by 2002:a5d:64e9:0:b0:475:f100:360d with SMTP id
 ffacd0b85a97d-4775a7cdd03mr10954419f8f.60.1783013245450; 
 Thu, 02 Jul 2026 10:27:25 -0700 (PDT)
Received: from ehlo.thunderbird.net ([185.238.219.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbc75sm11541859f8f.5.2026.07.02.10.27.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 10:27:24 -0700 (PDT)
Date: Thu, 02 Jul 2026 16:58:46 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
CC: Gaurav Sharma <gaurav.sharma_7@nxp.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Jason Wang <jasowang@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Matyas Bobek <matyas.bobek@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 1/4] hw/net/can/flexcan: Subclass TYPE_CAN_FLEXCAN
In-Reply-To: <b7ba6659-9fec-4bb4-a9ab-6c009081357f@oss.qualcomm.com>
References: <20260701224612.48342-1-shentey@gmail.com>
 <20260701224612.48342-2-shentey@gmail.com>
 <b7ba6659-9fec-4bb4-a9ab-6c009081357f@oss.qualcomm.com>
Message-ID: <8359B14D-E5CF-42E7-8CD0-8C0B34AEC31F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 2=2E Juli 2026 12:45:24 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <phil=
md@oss=2Equalcomm=2Ecom>:
>Hi Bernhard,
>
>On 2/7/26 00:46, Bernhard Beschow wrote:
>> Subclass TYPE_CAN_FLEXCAN, yielding TYPE_CAN_FLEXCAN2 and TYPE_CAN_FLEX=
CAN3=2E
>> Since TYPE_CAN_FLEXCAN is now abstract, TYPE_FSL_IMX6 needs to use
>> TYPE_CAN_FLEXCAN2=2E TYPE_CAN_FLEXCAN3 will be used in TYPE_FSL_IMX8MP=
=2E
>>=20
>> Note that Linux performs 8 byte accesses on the i=2EMX8M Plus, therefor=
e
>> =2Emax_access_size has to be adjusted=2E Otherwise this results in bus =
errors=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   include/hw/net/flexcan=2Eh |  4 ++-
>>   hw/arm/fsl-imx6=2Ec        |  2 +-
>>   hw/net/can/flexcan=2Ec     | 61 +++++++++++++++++++++++++++++++------=
---
>>   3 files changed, 51 insertions(+), 16 deletions(-)
>>=20
>> diff --git a/include/hw/net/flexcan=2Eh b/include/hw/net/flexcan=2Eh
>> index 153afc1e03=2E=2E32de7b904a 100644
>> --- a/include/hw/net/flexcan=2Eh
>> +++ b/include/hw/net/flexcan=2Eh
>> @@ -139,7 +139,9 @@ typedef struct FlexcanState {
>>   } FlexcanState;
>>     #define TYPE_CAN_FLEXCAN "flexcan"
>> -
>>   OBJECT_DECLARE_SIMPLE_TYPE(FlexcanState, CAN_FLEXCAN);
>>   +#define TYPE_CAN_FLEXCAN2 "flexcan2"
>> +#define TYPE_CAN_FLEXCAN3 "flexcan3"
>
>> diff --git a/hw/net/can/flexcan=2Ec b/hw/net/can/flexcan=2Ec
>> index 1ea459d9f6=2E=2Ed6a76c28ab 100644
>> --- a/hw/net/can/flexcan=2Ec
>> +++ b/hw/net/can/flexcan=2Ec
>> @@ -1298,7 +1298,7 @@ static const struct MemoryRegionOps flexcan_ops =
=3D {
>>       =2Eendianness =3D DEVICE_LITTLE_ENDIAN,
>>       =2Evalid =3D {
>>           =2Emin_access_size =3D 1,
>> -        =2Emax_access_size =3D 4,
>> +        =2Emax_access_size =3D 8,
>
>Isn't it better to keep 32-bit renaming as flexcan2_ops and widen to
>64-bit for Plus version in a new flexcan8_ops struct?

I agree=2E Will do in v2=2E

Best regards,
Bernhard

>
>>           =2Eunaligned =3D true,
>>           =2Eaccepts =3D flexcan_mem_accepts
>>       },
>> @@ -1324,16 +1324,26 @@ static int flexcan_connect_to_bus(FlexcanState =
*s, CanBusState *bus)
>>       return 0;
>>   }
>>   -static void flexcan_init(Object *obj)
>> +static void flexcan2_init(Object *obj)
>>   {
>>       FlexcanState *s =3D CAN_FLEXCAN(obj);
>>         memory_region_init_io(
>> -        &s->iomem, obj, &flexcan_ops, s, TYPE_CAN_FLEXCAN,
>> +        &s->iomem, obj, &flexcan_ops, s, TYPE_CAN_FLEXCAN2,
>>           offsetof(FlexcanRegs, _reserved6)
>>       );
>>   }
>>   +static void flexcan3_init(Object *obj)
>> +{
>> +    FlexcanState *s =3D CAN_FLEXCAN(obj);
>> +
>> +    memory_region_init_io(
>> +        &s->iomem, obj, &flexcan_ops, s, TYPE_CAN_FLEXCAN3,
>> +        sizeof(FlexcanRegs)
>> +    );
>> +}

