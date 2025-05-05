Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DA4C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 10:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBscR-00023Y-B8; Mon, 05 May 2025 06:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBscN-000205-8f
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBscK-0006Bn-Cq
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746439206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=G5/ke+09yJTahp5enl2iiV9vKZfKW9VLS/xyfEIgYmY=;
 b=H/ksj4wbdfq1u5TrQulxJ27A2CfQ+vdmhCeMGsFrNstumAVmmjQNBhlEJoBpdn2TAlPVCg
 iqOjSblu4B3pIY9Eb+5sl42eNonKNXTK3KO80QWbNG3fs39I3CpO3ScNzKiWhA8QFIBN50
 BbrqAvJpqaOlo2WeJtqTYWpK0ZfWB3E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-meAmbfA3Mh2w5uCBpHDRDA-1; Mon, 05 May 2025 06:00:05 -0400
X-MC-Unique: meAmbfA3Mh2w5uCBpHDRDA-1
X-Mimecast-MFC-AGG-ID: meAmbfA3Mh2w5uCBpHDRDA_1746439204
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39126c3469fso1081968f8f.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 03:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746439203; x=1747044003;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G5/ke+09yJTahp5enl2iiV9vKZfKW9VLS/xyfEIgYmY=;
 b=DkfICyh9qcYW0OhzM+ceQ08ioS9E41nayzHxrmmATObu0SGFjeBJij3nVMnqVE8ZRY
 dLSWyVHUDY34ZCfRPV8KKwW+bVPf2PewFuqEX9YPF0jEskALxOb3MP3u629/NZrhFyJR
 T8yXu171xw5bIVIiG45OsKIlmNFlBkg/d6TyaeLLA0Hr7ZNULtMqzKtNo1ywudTw9GxA
 eGlq6R5bo2lWmaStngPVyCls55QFcuitAzjj2wosHlsZzH8C2a/bhx54CuRdt9P4uRj1
 4UeH9yNB+F3WV0+pjpnOx4lsfr4AnkDAt2+U8ooQR6Rfm+YIrwJJ5GMDQLJlCifMiXEe
 R1IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2nFAP/AIF1U+rb33W04bKJ90j0qwoQ4PO6XPcd6vKq+l8WXJKByM3xSqqbg787rawS1Qhmvk8khQa@nongnu.org
X-Gm-Message-State: AOJu0Yw7g8n9D90qX7JVcfRH0MQZ6/sSU70zxYV8IIFSQxF4BPhDx2Mg
 mUk1dzSRy+qr//UA41u7NvcskOpciXG0DFbrGCSOKq2y/ZX0TjjRt77w14eNpobYVqEsEdRkSVk
 j69StwKYTwaEJwibm0qbvKw5gdjiEztpVEOQ4KwYKTYhcO0u4UtcOqg2qrWW0
X-Gm-Gg: ASbGnctagsMvH7NyqCM/yU6gKFUzjkJ9D5NIsJgrdrwsC4mtvLL24aA689rC9iZPqRW
 YZ7b6CMFQeCbdJbVtOEzvAv2affSLhz2S0CSI0SPlWeUXlsP61ZxNJbJf46M9NskJadvBG4pNEd
 3fAlTMqZRcbn1dNkewsLV51lfbbuSHnX1lf4wxHrNponHmFwgNrU1reIzgyJOWhzH4qVdmCBUP2
 /MgVSSYcS0T1KVlP4hEZAonguyM/pizW/B8RLdybzLun1Ov1fc8mMRqwBmVkET6vrychGyB0Ydm
 4+qsJPA0i6gkISg=
X-Received: by 2002:a05:6000:c8b:b0:3a0:9fe1:c2ac with SMTP id
 ffacd0b85a97d-3a09fe1c507mr3645553f8f.22.1746439203625; 
 Mon, 05 May 2025 03:00:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhQ502VAQtvamsNTrR/Ju5O/e/wpdeDkSfmkro3HLFzs0pNblu81PevzMRRQZrBa00M7nNug==
X-Received: by 2002:a05:6000:c8b:b0:3a0:9fe1:c2ac with SMTP id
 ffacd0b85a97d-3a09fe1c507mr3645538f8f.22.1746439203246; 
 Mon, 05 May 2025 03:00:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae353esm10056393f8f.31.2025.05.05.03.00.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 03:00:02 -0700 (PDT)
Message-ID: <674de496-b0fb-486b-b74e-f4f856e6d9bc@redhat.com>
Date: Mon, 5 May 2025 12:00:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/i386/emulate: stop overloading
 decode->op[N].ptr
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: wei.liu@kernel.org
References: <20250502214841.242584-1-pbonzini@redhat.com>
 <20250502214841.242584-3-pbonzini@redhat.com>
 <5d461945-155b-40e8-bab4-502e57d94b03@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <5d461945-155b-40e8-bab4-502e57d94b03@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 5/5/25 11:43, Philippe Mathieu-Daudé wrote:
> Hi Paolo,
> 
> On 2/5/25 23:48, Paolo Bonzini wrote:
>> decode->op[N].ptr can contain either a host pointer (!) in CPUState
>> or a guest virtual address.  Pass the whole struct to read_val_ext
>> and write_val_ext, so that it can decide the contents based on the
>> operand type.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   target/i386/emulate/x86_decode.h |   9 ++-
>>   target/i386/emulate/x86_emu.h    |   8 +--
>>   target/i386/emulate/x86_decode.c |  74 +++++++++----------
>>   target/i386/emulate/x86_emu.c    | 119 ++++++++++++++++---------------
>>   4 files changed, 109 insertions(+), 101 deletions(-)
>>
>> diff --git a/target/i386/emulate/x86_decode.h b/target/i386/emulate/ 
>> x86_decode.h
>> index 87cc728598d..497cbdef9c7 100644
>> --- a/target/i386/emulate/x86_decode.h
>> +++ b/target/i386/emulate/x86_decode.h
>> @@ -266,7 +266,10 @@ typedef struct x86_decode_op {
>>       int reg;
>>       target_ulong val;
>> -    target_ulong ptr;
>> +    union {
>> +        target_ulong addr;
> 
> Prefer 'vaddr' type for "guest virtual address".
That would be a semantic change which I really want to avoid in this series.

I don't think target_long/target_ulong is a big blocker towards 
single-binary anyway.  The trick is to confine it to target/, making it 
essentially a #define.  That is, let target/* include one of two new 
headers target_long_32.h and target_long_64.h.  See 
lore.kernel.org/r/68b6c799-6407-43cc-aebc-a0ef6b8b64fa@redhat.com as well.

For the same reason I think target_long_bits() is a step in the wrong 
direction.

Paolo


