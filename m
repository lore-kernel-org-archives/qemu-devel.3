Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EA4C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 08:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkIxA-0003gx-6R; Tue, 18 Feb 2025 03:27:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkIx8-0003gU-BH
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 03:27:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkIx6-0001e6-30
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 03:27:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739867254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=C9A9VM2nKVcNQaWvg6tShnVj0Oi0r2QUvZm7e0lM25k=;
 b=QEj/dvDjPJeQuQELiPF6wqRdMwb59oGxN2HpW1VKbaUgEATmjLaINt0jQ09kCYRN4k2d4T
 LAFV5rGnh9g3VIat+F1LQEqzf81T8utQekt0fRJqavlk1sPTnSdk4UoEl+GnMX5b/vfzKC
 ETYQ8QEBW7G5/XZFuEy4dXOEc/Q65Ks=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-qaWtQBKkPfuhUwFm0i_5UA-1; Tue, 18 Feb 2025 03:27:32 -0500
X-MC-Unique: qaWtQBKkPfuhUwFm0i_5UA-1
X-Mimecast-MFC-AGG-ID: qaWtQBKkPfuhUwFm0i_5UA_1739867252
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43988b9ecfbso7766135e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 00:27:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739867251; x=1740472051;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C9A9VM2nKVcNQaWvg6tShnVj0Oi0r2QUvZm7e0lM25k=;
 b=VO5/j6ptxbZqLFHWjMuVnNFLtFPEizJNtK2ym/8gzj4Mu9vGkg7RnwTpByWjVeANVw
 5SeaoX58/PVAub7AWwOte5BUOi8RISHy79Cj3aYIMWGDHHNUJuVgn7FVeajAlURck83C
 0qSZ615XdSkKo4taSrEWqFuqNBB1H1DClp7YJNrvbfAdH23+GF82eA/m+pZ65b6UNqfZ
 j3UeXOqjr0wltX9FY7RLQaYD0hRMOL3zsu7zYheHsW92aagO60NEPns+mESIGYQ9uHOU
 fpRBQtMLZR4mK+yoDvMLRBmwyfeEe3qJbp6JzQWnZuCimYuccINQmWQjM1PnVH1i3nRz
 G9Mw==
X-Gm-Message-State: AOJu0YzIF99br92muvLaI7Gzo6QNYSPOLhDbTMJ6x3Qn9ecglDnrAT+R
 zKol2SKj9sW7qUb2al2/wKa+gFSDLbqaUQvbfvjAHSkWNn814gXP8+kYZjyrXZ+GDutZBdIdMgc
 SxH1gTmV5MHmpHMDEkrAimzMXSJm13Wm0aHy0gFa5ZbMzxlmT2tgz8TerslBKePY=
X-Gm-Gg: ASbGncuJBGXBYKmvhzWc5AICFTZJ4mMvlPbAZ3IdPF6wIfpe0bWaeKdhW9/eqb+umrc
 XX5F6C/5wmZJOh2otOvgfKA2rwAXG1Mq3bTMCNL9q8MdEQOPjj7yKAyiPbCK9pTzH7tF5l1jkVb
 4LbC7fqgqGCQ/RiHUI5zJ13lF26sbCfBiVBwNImOYEaCAKyFe9JWjPYLP3G1b/IDBsn2CPhPM9p
 QIw3ILP/oOq7Eaa9k9ozroAGdCarUbh3jWNQWLPqK62WPwKnp69SfrRO4XgRAzDpmJXnoOrnrdc
 g/7zbuDPz8Y=
X-Received: by 2002:a05:600c:1989:b0:439:873a:111b with SMTP id
 5b1f17b1804b1-439873a1363mr52528795e9.12.1739867251143; 
 Tue, 18 Feb 2025 00:27:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHW1LeebxGYOiw4YcD3dADAjcScuWOuXn8pVnKJUJpjAIyW6x9szvTITWopMsykUCwiL36aYg==
X-Received: by 2002:a05:600c:1989:b0:439:873a:111b with SMTP id
 5b1f17b1804b1-439873a1363mr52528545e9.12.1739867250724; 
 Tue, 18 Feb 2025 00:27:30 -0800 (PST)
Received: from [192.168.10.81] ([176.206.122.109])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43986b475ffsm44274095e9.17.2025.02.18.00.27.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 00:27:30 -0800 (PST)
Message-ID: <15e68aa7-0242-4ccf-ae7f-aea26f2c7b68@redhat.com>
Date: Tue, 18 Feb 2025 09:27:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/22] target/riscv: declarative CPU definitions
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com
References: <20250206182711.2420505-1-pbonzini@redhat.com>
 <CAKmqyKNhc3WAkSee0TOsziKO8HJReg0qrxD04WXp3j90O=O9cQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAKmqyKNhc3WAkSee0TOsziKO8HJReg0qrxD04WXp3j90O=O9cQ@mail.gmail.com>
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

On 2/18/25 01:25, Alistair Francis wrote:
> On Fri, Feb 7, 2025 at 4:28 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> Hi Alastair,
>>
>> the subject is a slightly underhanded description, in that what I really
>> wanted to achieve was removing RISC-V's use of .instance_post_init; that's
>> because RISC-V operate with an opposite conception of .instance_post_init
>> compared to everyone else: RISC-V wants to register properties there,
>> whereas x86 and hw/pci-bridge/pcie_root_port.c want to set them.
>> While it's possible to move RISC-V's code to instance_init, the others
>> have to run after global properties have been set by device_post_init().
>>
>> However, I think the result is an improvement anyway, in that it makes
>> CPU definitions entirely declarative.  Previously, multiple instance_init
>> functions each override the properties that were set by the superclass,
>> and the code used a mix of subclassing and direct invocation of other
>> functions.  Now, instead, after .class_init all the settings for each
>> model are available in a RISCVCPUDef struct, and the result is copied
>> into the RISCVCPU at .instance_init time.  This is done with a single
>> function that starts from the parent's RISCVCPUDef and applies the delta
>> stored in the CPU's class_data.
> 
> That is nice!
> 
> I don't love the ifdef-ery around `#include "cpu_cfg_fields.h.inc"`
> but overall the patches look fine.

No problem, if you're okay with the final "target/riscv: move SATP modes 
out of CPUConfig" I can move it earlier in the series and get rid of the 
#ifdefs in cpu_cfg_fields.h.inc.  It's only needed because satp_modes 
are not merged by the class_init function (they're not even initialized 
in fact).

>> Do you think this is a good approach?
> 
> Seems fine to me :)

Ok, then I'll repost as soon as the patches for read-only class_data are 
ready.

Paolo


