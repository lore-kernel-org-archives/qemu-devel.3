Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31812C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 09:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkgL2-0004DK-Qo; Wed, 19 Feb 2025 04:25:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkgL1-0004D5-GT
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 04:25:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkgKz-0002Ac-3a
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 04:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739957147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JIESi15w2u9GIAliNDOQyn4L9bqMJFtByzaIzzdzNBU=;
 b=Ix0/m1KK1W201UlmhjNgFQYRCCB9q5sAvyXGYTbL023g3O9VJZravM4YCpzHuYcgU/aqS9
 Btkd0jB0mVA6pjmacxQcadKZM2LdPVZ3QDcg91XHlnW3r39oj+OHmlBikxIf41jKJdnQpa
 Md2ZZ5iiU1ikHiNZk4WcCmbt70dGXvE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-bJDD6eIKNVqq2TIhY8qCOw-1; Wed, 19 Feb 2025 04:25:44 -0500
X-MC-Unique: bJDD6eIKNVqq2TIhY8qCOw-1
X-Mimecast-MFC-AGG-ID: bJDD6eIKNVqq2TIhY8qCOw_1739957143
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-438e4e9a53fso46166675e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 01:25:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739957142; x=1740561942;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JIESi15w2u9GIAliNDOQyn4L9bqMJFtByzaIzzdzNBU=;
 b=j8J9qotuoCNpSHvmxr3ATvwMa9pDaNN/8DVjIPA0gkM+yBaKAnIXEeFHHhwE2toNMN
 7lg5fJ47W0eCdDUULmAPilEoBpM/ybQRgyngCi1XgYouxQQa4BBDHRz5fcKxj4jGX0Ic
 GFj/L/Lr3KLyMGJJ7Issgc1QjNcOieYL+XDtYOBzoo9phtAZ2izfFgs1EGaw0oAReB35
 UXtf8f4lCnMXLq01Gkcm5sEMmL4N3Oecmjo2p0TJ1KeLLVskbEzMr6FWRMAm3s2ibUAQ
 pkhCATSIwl961Io//B/biRkEmMqcuAstIJk0zAO+C7r6zW/8cKZDF5UNi3VOwMj3+P2e
 86+Q==
X-Gm-Message-State: AOJu0YwXgxdcPgbAN0NqmglCcWhL59QtlBDYWTgF1PJIepWjSeMMj6jR
 2OTZJq/R2P5IJEgzjTOdQLn7ty2v5r2mWX03smPar4T9fOju8W9XAmMOeANDpVmOPA9GGNuNLFs
 0wERrmKytxB3+DTCeaIWeIOa4f5pqJY9P2Ow0vohZPorb8+5neOtv1QXaNjQPGzM=
X-Gm-Gg: ASbGncvRQx8+9GpgkFGj5E3LXh7jlGrtzHFHRfSk2OTECMXcH8LP8eEqFXJ33i+mtrG
 2Oc1YCptsPUmgbGtPwpCMYbXR3c3Kth1O2cijVEL8Q/Ckg3Ul4X+y9q2YlMB2JpWiK39WzoPam7
 HOiGsM2c2FdFf7UEWJ5F4ckmS8h9iN8ebIR/1J8goO+nRXeuY7CIbZNIvfR6ZsVCERknGeGVMid
 n/wBUalqZKvGJA9FIkZbd7I2gurjFa9Ruz6Ab53O5QrTGgeMM9db9ZDKQUzLr4TwgvFzEFCBSov
 WOc25q+3ofI=
X-Received: by 2002:a05:600c:1547:b0:439:94ef:3780 with SMTP id
 5b1f17b1804b1-43994ef3997mr59231465e9.30.1739957142520; 
 Wed, 19 Feb 2025 01:25:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGga4mC2VvA/JMgmoXpiMklBIIcMVw/UIC4qobLoVdIRl07zGT5lTM6pmXqw8FxxaIvUVP/hg==
X-Received: by 2002:a05:600c:1547:b0:439:94ef:3780 with SMTP id
 5b1f17b1804b1-43994ef3997mr59231205e9.30.1739957142057; 
 Wed, 19 Feb 2025 01:25:42 -0800 (PST)
Received: from [192.168.10.81] ([176.206.122.109])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4395a04f23asm205481495e9.7.2025.02.19.01.25.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2025 01:25:41 -0800 (PST)
Message-ID: <a4bbbcc3-5edd-4438-b5b3-738463bea840@redhat.com>
Date: Wed, 19 Feb 2025 10:25:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/timer/hpet: Detect invalid access to TN registers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250218073702.3299300-1-zhao1.liu@intel.com>
 <53739259-69a5-4d7e-9178-f09e1d6ede89@redhat.com>
 <cf10367d-90da-48d4-8440-7afb8b083883@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <cf10367d-90da-48d4-8440-7afb8b083883@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/18/25 10:07, Philippe Mathieu-Daudé wrote:
> On 18/2/25 09:53, Paolo Bonzini wrote:
>> On 2/18/25 08:37, Zhao Liu wrote:
>>> "addr & 0x18" ignores invalid address, so that the trace in default
>>> branch (trace_hpet_ram_{read|write}_invalid()) doesn't work.
>>>
>>> Mask addr by "0x1f & ~4", in which 0x1f means to get the complete TN
>>> registers access and ~4 means to keep any invalid address offset.
>>
>> I think this is less readable.
>>
>> The reason to use !4 in the Rust code is because the initial AND is done
>> in a separate function, timer_and_addr().
> 
> Having a quick look at the model without looking at the specs:
> 
> include/hw/timer/hpet.h:20:#define HPET_LEN                0x400
> 
> hw/timer/hpet.c:439:static uint64_t hpet_ram_read(...,
> hw/timer/hpet.c-441-{
> hw/timer/hpet.c-448-    /*address range of all TN regs*/
> hw/timer/hpet.c-449-    if (addr >= 0x100 && addr <= 0x3ff) {
> hw/timer/hpet.c-450-        uint8_t timer_id = (addr - 0x100) / 0x20;
>                              ...
> hw/timer/hpet.c-469-    } else {
> hw/timer/hpet.c-470-        switch (addr & ~4) {
>                                   ...
> hw/timer/hpet.c-488-        }
> hw/timer/hpet.c-489-    }
> hw/timer/hpet.c-490-    return 0;
> hw/timer/hpet.c-491-}
> 
> hw/timer/hpet.c:699:    memory_region_init_io(&s->iomem, obj,
>                                                &hpet_ram_ops, s,
>                                                "hpet", HPET_LEN);
> 
> I suppose we want to register multiple timers of I/O size 0x20 at 0x100,
> and the I/O size of 0x20 at 0x000 is a generic control region.
> 
> Maybe split hpet_ram_ops in 2 (hpet_cfg_ops and hpet_tmr_ops), mapping
> the first one once at 0x000 and the other 24 times at 0x100-0x3ff?

You would have to come up with a way to get the index though.  It seems 
to be adding churn for no particular reason.

I'd rather look into how to make decoding code *easy* without making 
everything MemoryRegions.  As I explained yesterday, while I'm not yet 
sure that Rust is going to stay in QEMU, I'd like to have as many 
examples as possible to help tilting the balance one way or the other. 
And indeed in the Rust version of HPET, timer_and_addr() could be 
extended to something like this:

// Start with the same "enum for registers" pattern that PL011 uses:
#[derive(qemu_api_macros::TryInto)]
#[repr(u64)]
enum TimerRegister {
     CFG = 0,
     CMP = 8,
     ROUTE = 16,
}

#[derive(qemu_api_macros::TryInto)]
#[repr(u64)]
enum GlobalRegister {
     CAP = 0,
     CFG = 0x10,
     INT_STATUS = 0x20,
     COUNTER = 0xF0,
}

// Go one step further and define types for all possible outcomes:
#[derive(Copy)]
enum HPETRegister {
     Timer(&BqlRefCell<HPETTimer>, TimerRegister),
     Global(GlobalRegister),
     Unknown(hwaddr),
}

struct HPETAddrDecode {
     u32 shift,
     u32 len,
     HPETRegister reg,
}

fn decode(&self, addr: hwaddr, size: u32) -> HPETAddrDecode {
     let shift = ((addr & 4) * 8) as u32;
     let len = std::cmp::min(size * 8, 64 - shift);

     addr &= !4;
     let reg = if (0x100..=0x3ff).contains(&addr) {
         let timer_id: usize = ((addr - 0x100) / 0x20) as usize;
         TimerRegister::try_from(addr)
             .map(|reg| HPETRegister::Timer(&self.timers[timer_id], reg))
     } else {
         GlobalRegister::try_from(addr)
             .map(HPETRegister::Global)
     }

     // reg is now a Result<HPETRegister, hwaddr>
     // convert the Err case into HPETRegister as well
     let reg = reg.unwrap_or_else(HPETRegister::Unknown);
     HPETAddrDecode { shift, len, reg }
}

(untested).  The read and write functions then can do something like

     let val = match decoded.reg {
         Timer(timer, reg) => timer.borrow_mut().read(decoded),
         Global(GlobalRegister::CAP) => self.capability.get(),
         Global(GlobalRegister::CFG) => self.config.get(),
         ...
     }
     val >> decoded.shift

and for write:

     match decoded.reg {
         Timer(timer, reg) => timer.borrow_mut().write(decoded, value),
         Global(GlobalRegister::CAP) => {}, // read-only
         Global(GlobalRegister::CFG) => self.set_cfg_reg(decoded, value),
         ...
     }


The above could be a scheme that new devices could copy.  Overall I 
think it would be shorter code than what is there in rust/hw/timer/hpet 
(which is IMO already better than C, mind!).

The honest question for people with less experience is whether this is 
readable at all; whether seeing it helps you learn the language or 
discourages you.

Paolo

> No clue what is between 0x020-0x0ff.
> 
> My 2 cents looking at QDev modelling to avoid these address
> manipulations.
> 
> Regards,
> 
> Phil.
> 
> 


