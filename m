Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C68C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 09:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uirJX-000124-Uy; Mon, 04 Aug 2025 05:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1uirJ2-0000tZ-1N
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 05:16:38 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1uirIy-0001Kn-9s
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 05:16:30 -0400
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7e6696eb4bfso309651485a.2
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 02:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grsecurity.net; s=grsec; t=1754298986; x=1754903786; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=NSPtN0kwWtvNDBd+lpKApr9yaknC2JKVLS9pzdP+iSI=;
 b=K9BoWykn12WgcC/50uoXKKmVW4jKDtJA/MuzQepxpLPgeYBAr4jkLrA4xbx9v/d9AH
 dlgA+y8LNuaIp/FozAFMLC7XbjKrYN+B9DgZm/eJVpZB2rnJjxG+9kgq+DVusAU3THy8
 ZDR43YrkfhDQJPViKAkR4OPvNU/FowyUP5Adgrt8Ibx7bNBrXzBOSawIok9fsp8Llg0p
 KJMEiDLdNgkfOrWl0sO6Rl7MasUWrjr1/Aawv4NXIWwLUDvypAiR2O/rHrAo/71H/x2I
 W3e+CANOb1LXSOo0NHUJzA1PpWxz5LMOdxzuwHcwPYXMHiCl8WXetYQAU40oJcNSqV5h
 DHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754298986; x=1754903786;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NSPtN0kwWtvNDBd+lpKApr9yaknC2JKVLS9pzdP+iSI=;
 b=QbsMWFeEO6uJB8UQV4XcMy5g/7pqm8X/di6FRcjxAxCHNTue6AdVevFPQV26oUm51p
 btcWWUpt0NGli1886oMSQeMm/e2NenFw1pFPhJQ2qd+OMroL5pRCO7m6c7IM2NfkNP0T
 oMBjUmn6HHtLX7ECP6uVZ9i2rH1jjlvYZfcxfLydXcXcHpZAukFX5DESe8o07/8dN31F
 mE79bhdCCTORtI3L+Gf7aQ3tM9I1Dg54QLMT/LO7KG5rC8cW0hklS/n+x3YTfBMyy/7N
 nlVWT10vBGA6mdVjpURMbBekKNmQvSJzc6B29cBxIhyY5p2WkvkAX6D31xLUEK8G412D
 qWrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7rQRK+q38TpQr/Cj/pmoOY7E+LUq2KGLa8DrCpFEDaZmLkGfI7XZ8OfGWUyB9A1VmeJadX3RebcBF@nongnu.org
X-Gm-Message-State: AOJu0YxccnnHAEHifgThBSN2aAY9gBn6fgEdc7anmt92IxwEh9RTN1Lr
 io3wVxv9WQEuWmsOvS6qp6DCctrBOFLM9MoWLGMmrpv6daT6qh0mu79FZAmQqVWUD2k=
X-Gm-Gg: ASbGncsXcas8rz7e+JBH3O3ytjMOQv/bylq2NuxDZUI5195i5OiFlt7qnf2DMFM9l5W
 QOOkeBhNRa31lL51Q/qItig+hVHDrr6KWwO2PHOJQS1XM6ncUfwI7RJ6HPUkf96H+J4UegelCj9
 TklBscy4uvw4lFR4irt6XvWr5ElnCe8QvQUSKqB4LMkuLDc/2kLdZC2jxZgpsH63UH1tn7JgCOC
 TUIebXkYwM7VY4GuPUL99FKAuLqoF1r+BwLI+CTiRDGBGv88QrOH6ZldJzkCFw45xdsjBz5RtCG
 5Qg7/XD0T6SmxXuEvegk+bWiRuEVRGQ4iwnHrCJBqLCaspFVXEbwPdu/cMwaT1dSBHyqQkziCmB
 cNOHTRc0ubg0r47w5elHPYmAugEBYNltryCWaGzzNGbMwtozP9QBwwQ7l5vWiZovEPgUOGHDl+L
 SqKB/iDeMKQ+TW2XX1ArlaOYq1JNWEkUToOxclO544Jj5Nb+jLJG2uCLU=
X-Google-Smtp-Source: AGHT+IGTopjFjRqcg4szc6xtYjmVRr/+qF9GoJYZct1NGmlBsIGmn39Z+j/4xEoL90Wd9djgyiYXsQ==
X-Received: by 2002:a05:620a:471f:b0:7e8:48d:85f0 with SMTP id
 af79cd13be357-7e8048d8bf7mr172974485a.4.1754298986305; 
 Mon, 04 Aug 2025 02:16:26 -0700 (PDT)
Received: from ?IPV6:2003:fa:af22:cf00:2208:a86d:dff:5ae9?
 (p200300faaf22cf002208a86d0dff5ae9.dip0.t-ipconnect.de.
 [2003:fa:af22:cf00:2208:a86d:dff:5ae9])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e7f9d4ea94sm142643385a.89.2025.08.04.02.16.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 02:16:26 -0700 (PDT)
Message-ID: <1bc67fb2-088d-4d6d-838c-d826aa8eb03c@grsecurity.net>
Date: Mon, 4 Aug 2025 11:16:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] i386/kvm: Provide knob to disable hypercall patching
 quirk
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Oliver Upton <oliver.upton@linux.dev>,
 Sean Christopherson <seanjc@google.com>
References: <20250801131226.2729893-1-minipli@grsecurity.net>
 <6bcf6108-2d0c-44ae-a9f7-2f53ca23af7a@intel.com>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <6bcf6108-2d0c-44ae-a9f7-2f53ca23af7a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=mathias.krause@opensrcsec.com; helo=mail-qk1-x72d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 04.08.25 05:32, Xiaoyao Li wrote:
> On 8/1/2025 9:12 PM, Mathias Krause wrote:
>> [...]
>>
>> For regular operating systems, however, the patching wouldn't be needed,
>> nor work at all. If it would, these systrems would be vulnerable to
>> memory corruption attacks, freely overwriting kernel code as they
>> please.
> 
> For non-coco VMs, the systems are surely vulnerable to memory corruption
> attacks that the host VMM is free to modify the guest memory. It's
> irrelevant to whether hypercall patching is needed or works.

Sure, a VMM could mess with the guest's memory as it pleases. However, I
meant possible attacks from *within* the guest, as in allowing code
modifications to happen by having W+X mappings, allowing possibly
malicious modifications of such.

>> [...]
>> ---
>> Xiaoyao, I left out your Tested-by and Reviewed-by as I changed the code
>> (slightly) and it didn't felt right to pick these up. However, as only
>> the default value changed, the functionality would be the same if you
>> tested both cases explicitly (-accel kvm,hypercall-patching={on,off}).
> 
> No problem, I just re-tested it.
> 
> Tested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Thanks!

>> [...]
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index ab23f14d2178..98af1a91e6e6 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -236,6 +236,7 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
>>       "                dirty-ring-size=n (KVM dirty ring GFN count,
>> default 0)\n"
>>       "                eager-split-size=n (KVM Eager Page Split chunk
>> size, default 0, disabled. ARM only)\n"
>>       "                notify-vmexit=run|internal-error|
>> disable,notify-window=n (enable notify VM exit and set notify window,
>> x86 only)\n"
>> +    "                hypercall-patching=on|off (disable KVM's VMCALL/
>> VMMCALL hypercall patching quirk, x86 only)\n"
> 
> I would like to say "(configure KVM's VMCALL/VMCALL hypercall patching
> quirk, x86 only)" instead of "disable"

That would be technically correct. However, as this quirk is enabled by
default in KVM and QEMU, the only sensible configuration toggle is to
disable it. That's why I stated it this way. But I can rephrase it, if
you prefer it this way.

>> [...]
>> @@ -6611,6 +6650,12 @@ static void
>> kvm_arch_set_xen_evtchn_max_pirq(Object *obj, Visitor *v,
>>     void kvm_arch_accel_class_init(ObjectClass *oc)
>>   {
>> +    object_class_property_add_bool(oc, "hypercall-patching",
>> +                                   kvm_arch_get_hypercall_patching,
>> +                                   kvm_arch_set_hypercall_patching);
>> +    object_class_property_set_description(oc, "hypercall-patching",
>> +                                          "Disable hypercall patching
>> quirk");
> 
> Ditto, Could we use "Configure hypercall patching quirk"? It's not only
> to disable it.

Or just "Hypercall patching quirk", as the bool value already reflects
its state.

Thanks,
Mathias

