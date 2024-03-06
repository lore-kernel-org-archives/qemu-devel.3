Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E19FC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 22:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri05s-0002Ga-N1; Wed, 06 Mar 2024 17:50:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ri05r-0002GR-4R
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 17:50:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ri05o-0001ES-1j
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 17:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709765429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6/xvQU8rXItkULsiiSVQuN/RKusV0WKlNtmQo2+vXZs=;
 b=IWseiZzjFna4/VV3Ev3xyUuBX47w0i2JJFXnIG+eVikftoZIPB6JU/6HLXXZpgQwiRm3cX
 UGK+XuMqcfoPfZoYCPLa0UJxb6xqU2AuEU95YOW8nh02GXsPQsFeetZJUF1iu91ssefmVG
 EZI169QE1LgH9+7Q1qfFcBy2rDZp/Fg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-on0QR_azOkKohbGDr-OhhA-1; Wed, 06 Mar 2024 17:50:28 -0500
X-MC-Unique: on0QR_azOkKohbGDr-OhhA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33d30a3d6f8so34413f8f.3
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 14:50:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709765427; x=1710370227;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6/xvQU8rXItkULsiiSVQuN/RKusV0WKlNtmQo2+vXZs=;
 b=TbEkxKME9fEo2Duh2bN5SV55GT6eUNPIPKxBnPfpsZPJWVZST0dFqnOKaw6uttokq+
 1SoBRGd76X0esn4fcpe3v+WrzVjz74fYcPJ19fkklv+1hYLqhJ4dOGBYfFvBpbmElpML
 doTnJrOg4q6XwTouEBmbADI2ws40I06i4c7f2/+vWacAZhCG1/Kt43yQUuvZ0nvLlk1b
 ek6K8uFYtY4YJr3/vO2vnMhurEUFbqnXweq7gb0dqSKH2/G0BB8xnW+KSONXQJ65RMFX
 C1xGslrtKYCZWtOR6GiXPC5RVUjpC2MfwR2deom6kmXVp79HczqUiIXy14fqkQs+rhzo
 thPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4k8TLBe79S+sRRcGfBRUAQrae091teTc9uT9n42OrQEBl5mQ0K3FErBKlZlrWfElDAkk+nu1q99FifFdC4cAXu0go8LQ=
X-Gm-Message-State: AOJu0YwfMPcbcMtUtd2eizE9RDysgsLcM9ukXRw5MT5iNoNaDJ6TQOsj
 TAHq9Migf3avCm2q9g1y+5tJOmh1j49p/QyBPNbK6om913W5MiddAZfo0m05MbLD4ups/5O6hlq
 S69mfj7hw83rLDe02Fak520WBY1RFe3qElHk9XPrlj9nYMFXkRRV/
X-Received: by 2002:a5d:50cf:0:b0:33d:755c:6f17 with SMTP id
 f15-20020a5d50cf000000b0033d755c6f17mr12255937wrt.67.1709765427017; 
 Wed, 06 Mar 2024 14:50:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEA7uXWB+3Z9PeOzXCeOgVR0ragsJl4ePwSQczk4y4RIdzayCU1MC2m6/dfsN0RVOTm2yTaYQ==
X-Received: by 2002:a5d:50cf:0:b0:33d:755c:6f17 with SMTP id
 f15-20020a5d50cf000000b0033d755c6f17mr12255927wrt.67.1709765426618; 
 Wed, 06 Mar 2024 14:50:26 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.googlemail.com with ESMTPSA id
 b29-20020a05600c4a9d00b00412f4afab4csm1203055wmp.1.2024.03.06.14.50.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 14:50:26 -0800 (PST)
Message-ID: <71f2c072-b25b-4980-938e-d832740cbefa@redhat.com>
Date: Wed, 6 Mar 2024 23:50:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] kvm: add support for guest physical bits
To: Xiaoyao Li <xiaoyao.li@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
References: <20240301101713.356759-1-kraxel@redhat.com>
 <20240301101713.356759-2-kraxel@redhat.com>
 <3ab64c0f-7387-4738-b78c-cf798528d5f4@intel.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <3ab64c0f-7387-4738-b78c-cf798528d5f4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/4/24 02:54, Xiaoyao Li wrote:
> On 3/1/2024 6:17 PM, Gerd Hoffmann wrote:
>> query kvm for supported guest physical address bits using
>> KVM_CAP_VM_GPA_BITS.  Expose the value to the guest via cpuid
>> (leaf 0x80000008, eax, bits 16-23).
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>   target/i386/cpu.h     | 1 +
>>   target/i386/cpu.c     | 1 +
>>   target/i386/kvm/kvm.c | 8 ++++++++
>>   3 files changed, 10 insertions(+)
>>
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index 952174bb6f52..d427218827f6 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -2026,6 +2026,7 @@ struct ArchCPU {
>>       /* Number of physical address bits supported */
>>       uint32_t phys_bits;
>> +    uint32_t guest_phys_bits;
>>       /* in order to simplify APIC support, we leave this pointer to the
>>          user */
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 2666ef380891..1a6cfc75951e 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -6570,6 +6570,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t 
>> index, uint32_t count,
>>           if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
>>               /* 64 bit processor */
>>                *eax |= (cpu_x86_virtual_addr_width(env) << 8);
>> +             *eax |= (cpu->guest_phys_bits << 16);
> 
> I think you misunderstand this field.
> 
> If you expose this field to guest, it's the information for nested 
> guest. i.e., the guest itself runs as a hypervisor will know its nested 
> guest can have guest_phys_bits for physical addr.

It's one possible interpretation of AMD's definition. However there's no 
processor that has different MAXPHYADDR with/without nested paging, so 
there's no real benefit in adopting that interpretation.

The only architectural case in which you have two conflicting values for 
the guest MAXPHYADDR is hCR4.LA57=0 (and likewise for Intel 4-level EPT) 
with MAXPHYADDR=52, so it's useful to treat GuestPhysAddrSize as a way 
to communicate this situation to the guest.

Paolo


