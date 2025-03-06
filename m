Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229DFC282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 13:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqApz-0005OK-Oj; Thu, 06 Mar 2025 08:00:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tqApg-0005Mb-Lo
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 08:00:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tqApe-0000Xv-SA
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 08:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741266009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+t5m3blux13m5/AN+9QhSes99LHJkGcmyTKz9/ruqKk=;
 b=SLzrnKzp47jyLvLaY6dptTqEiDB3MQQh20lAha7w90qKNzYxwZEjGDicUDezYd8VMzqFVY
 +FjjVp9AeuTG5eWEGrinfvyipT7RFO7KvSMi9UCDdViFFccq6ed0H/2MQVSUyJOe7sMJ2J
 a71zrKcjDhZ2JoEjpz2GfIno0isX0YU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-Zpq4NBraPGiyOY1AZuVzJg-1; Thu, 06 Mar 2025 08:00:07 -0500
X-MC-Unique: Zpq4NBraPGiyOY1AZuVzJg-1
X-Mimecast-MFC-AGG-ID: Zpq4NBraPGiyOY1AZuVzJg_1741266006
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3912a0439afso247089f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 05:00:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741266006; x=1741870806;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+t5m3blux13m5/AN+9QhSes99LHJkGcmyTKz9/ruqKk=;
 b=RbhtnOdfBbTeRtLXhZ7iF7uc6Lm4+NPUw4K9Fhe4usJZ8f3AVH8TKfU6vYgQsw1QrD
 SP6Pb3ePytufm4UU/4ZNva0f2/wAJbRw4cnv8Jo4ydZ/r/uvtTbwWRuZX94NRt290ZHq
 51l/U5zxN3uJpB571GHVb0GrG4HfVkfbc4H0+zqwE6VdZJ6g2Dc52xk7arfSnEQGoYG4
 npVQ9KQ0faPAQS37mNr2Q6HRJz70l+7PBd9kA8Z40A+pEXB4imhVsXvWfULp/oa41foM
 Ry11Pc03/lXQ+mvwY5WV/FgibRlvIkRQzvvrKqTtilAa54/3I9kOqxHF2bVxGNi0Uh8H
 +3zA==
X-Gm-Message-State: AOJu0YwL6F2bnqyzyzU4rsbbV7dn0LPg+LJHzsxmRS7QvK8TbZiAiSoy
 zCbpaagtQx/dfVp5C9fg46UaYb368Vg6NYT9ARGzloUk1NVN14Akv87+EB4CKbNZBuSwFP0mHIg
 ZxBPofDSTJo6c1vajCKzXm8y6vtxR4teGzG88KZ5flIIgXWy7XsEW
X-Gm-Gg: ASbGncvB0SDGHLR4I81wR27PYTXuctN+3GuMlQurI3mnyb4cJePrB1jRpaQ6Lo0Qmky
 tCYcspi6EvU4VqTF/xK9S8aHsVc0FokjeejuHKBcPMCp8W3xlbyU4e354jSdIow/hdRZGTm24eG
 jRrIaZJELZpsSGdIVDNFKXQwTj7pRIQiqONNWBPERZK1q6fVPT/01pCO2enB7soN/DezolmzIcb
 4a4DYllWU0fK740uJG0GF/vmegRcZH5tEd21yD03q1hWsmj0f5/EAIY+OJXVBI2vcKnqKORPaDZ
 o1r/yzrXY3Lc5bUzUak=
X-Received: by 2002:a05:6000:1f8c:b0:391:ab2:9e71 with SMTP id
 ffacd0b85a97d-3911f74bfcamr5971384f8f.20.1741266006287; 
 Thu, 06 Mar 2025 05:00:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZmZs/cItBjdJSQHOBKnrqZTMnOiUtPxPe5+eYq9OU66g6ygaaZen3HCIUq6brA9oFwlbMyQ==
X-Received: by 2002:a05:6000:1f8c:b0:391:ab2:9e71 with SMTP id
 ffacd0b85a97d-3911f74bfcamr5971344f8f.20.1741266005847; 
 Thu, 06 Mar 2025 05:00:05 -0800 (PST)
Received: from [192.168.10.27] ([151.95.119.44])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43bd42c6203sm49463545e9.24.2025.03.06.05.00.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 05:00:05 -0800 (PST)
Message-ID: <ab9b6720-cb48-4b8f-9059-2856c78b5577@redhat.com>
Date: Thu, 6 Mar 2025 14:00:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] target/riscv: env->misa_mxl is a constant
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
References: <20250218165757.554178-1-pbonzini@redhat.com>
 <20250218165757.554178-3-pbonzini@redhat.com>
 <CAKmqyKMdUONoXD69m3RH1PeoLLtL8qT-eXweVh9WHEZM5Feufg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAKmqyKMdUONoXD69m3RH1PeoLLtL8qT-eXweVh9WHEZM5Feufg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/6/25 02:16, Alistair Francis wrote:
> On Wed, Feb 19, 2025 at 3:01 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> There is nothing that overwrites env->misa_mxl, so it is a constant.  Do
> 
> The idea is that misa_mxl can change, although that's not supported now.

At run-time, or only at configuration time (before realize)?

>> not let a corrupted migration stream change the value; changing misa_mxl
> 
> Does this actually happen? If the migration data is corrupted won't we
> have all sorts of strange issues?

Generally migration data (just like disk image formats) is treated as 
security-sensitive, overriding any other considerations.  So you have to 
assume that the corruption is intentional, and sneaky enough to cause 
trouble.

Paolo

> Alistair
> 
>> would have a snowball effect on, for example, the valid VM modes.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   target/riscv/machine.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
>> index d8445244ab2..c3d8e7c4005 100644
>> --- a/target/riscv/machine.c
>> +++ b/target/riscv/machine.c
>> @@ -375,6 +375,18 @@ static const VMStateDescription vmstate_ssp = {
>>       }
>>   };
>>
>> +static bool riscv_validate_misa_mxl(void *opaque, int version_id)
>> +{
>> +    RISCVCPU *cpu = RISCV_CPU(opaque);
>> +    CPURISCVState *env = &cpu->env;
>> +    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
>> +    uint32_t misa_mxl_saved = env->misa_mxl;
>> +
>> +    /* Preserve misa_mxl even if the migration stream corrupted it  */
>> +    env->misa_mxl = mcc->misa_mxl_max;
>> +    return misa_mxl_saved == mcc->misa_mxl_max;
>> +}
>> +
>>   const VMStateDescription vmstate_riscv_cpu = {
>>       .name = "cpu",
>>       .version_id = 10,
>> @@ -394,6 +406,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>>           VMSTATE_UINTTL(env.priv_ver, RISCVCPU),
>>           VMSTATE_UINTTL(env.vext_ver, RISCVCPU),
>>           VMSTATE_UINT32(env.misa_mxl, RISCVCPU),
>> +        VMSTATE_VALIDATE("MXL must match", riscv_validate_misa_mxl),
>>           VMSTATE_UINT32(env.misa_ext, RISCVCPU),
>>           VMSTATE_UNUSED(4),
>>           VMSTATE_UINT32(env.misa_ext_mask, RISCVCPU),
>> --
>> 2.48.1
>>
>>
> 
> 


