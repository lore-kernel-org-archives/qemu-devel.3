Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1299C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 14:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4hAO-0000tL-Ub; Tue, 15 Apr 2025 10:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u4hAM-0000sb-EY
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 10:21:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u4hAI-0005d5-UZ
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 10:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744726888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WvTr0A/m1QKMj0TbJ6UTTqift7XA+hGB+2VebJzvlv8=;
 b=LyyDjhkmxlUd1FimFGzgfx0cCvmnqSyOnYFMH8lXBl9wfqK3YlRc4aZ+8MDL4b2jN+83WY
 cqQiM0KcrZggHNyP/AMy55VJqV0IUI6FKfgpXCVZfxKuMD89TgEzpTUcDXno5mRiZYNPcM
 BPTjUM0v+lHi0C0KFpZZVTx7c35bA80=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-7SUwlrN7PvuduB5RNUiIVQ-1; Tue, 15 Apr 2025 10:21:27 -0400
X-MC-Unique: 7SUwlrN7PvuduB5RNUiIVQ-1
X-Mimecast-MFC-AGG-ID: 7SUwlrN7PvuduB5RNUiIVQ_1744726886
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cf446681cso36803485e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 07:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744726886; x=1745331686;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WvTr0A/m1QKMj0TbJ6UTTqift7XA+hGB+2VebJzvlv8=;
 b=DCvmi6qUUgF4F04yKlV5jbxTJaRJNvgRht+A3fuhV+/cmYRKJXKs9QbtBIumnRIGh4
 NnNduumAcr3iQOU2KZM8mXKhkC0vb8ggFvz4VqZW9z/CyaJIzlv5LRIIdIFEwuTf6sC9
 GA1X1seSysE0RkUeQo//WbOqnCPn8jGAEDt477CZLC3RPQVGYiKerHTNgW50ZjF2AZtc
 ZUJ5zneCr20qFfvuq8eKb9pmmLBAO+93rWwoFgSehSickbjAldSrch/6NZtsBPK5PtDw
 D07VRZgPDTCzxVTcB06mPIS8qXEDeukSm+XRQ/QjeyPyeIh7ypBDztX5XCaccOiZzf47
 7Nug==
X-Gm-Message-State: AOJu0YzOr0B0QvlzO48/9iR6fiYcxC4uV3D173OSz1zuHa5sOuL5JzX1
 zZ0LbBWANgVDTmCybjD93vSNLkxDvifHJ3oc9HDmdXxmB4pGWNZYqp+/PNzvocvVoARXEAYMunY
 mRR70K4U2uBegjeJiq2VLqOjoBHOankBVnQpMdkMo+XPxiLXPwYId
X-Gm-Gg: ASbGncuRXLSuu78VrEZaT3vit0Z3vXZuE3NrNWuz5nKiz5YredtlPvHXh8ok/HB4UAc
 i3bafnwWterD1+RXEcGlGFOzG6fRc0NNCx5B3qbvIeOy7DudD4k7GvWUqUE6Bjrk/dD5DRWekQr
 D0xx8vWbaUrc0qcPugvyGDAxUymWL8Rlmd8fddOLmwfsIq+vh8zMu6mHc16VDOGc7Ml4EE53xtj
 S2HO7i7wrJFCYvRfMm2KvwKuBg8yTBeE34q5nKhm61PfPr5W7mEm87/PN0kNr8GRE/qpg9fSQic
 0w/PMdQdaZfpy86L
X-Received: by 2002:a05:600c:a04:b0:43d:ed:acd5 with SMTP id
 5b1f17b1804b1-43f3a93d4a8mr173810395e9.10.1744726885626; 
 Tue, 15 Apr 2025 07:21:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEitehTmfX49d/T456GkGbMm7oetNHmkQu53FGgb907xJ1YbAv61jR84L5v17YjEIP8oJQ/iA==
X-Received: by 2002:a05:600c:a04:b0:43d:ed:acd5 with SMTP id
 5b1f17b1804b1-43f3a93d4a8mr173810005e9.10.1744726885102; 
 Tue, 15 Apr 2025 07:21:25 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.109.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43f23572c4esm213490225e9.26.2025.04.15.07.21.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 07:21:24 -0700 (PDT)
Message-ID: <78fdfdaf-7c94-4d79-be39-8215c033b423@redhat.com>
Date: Tue, 15 Apr 2025 16:21:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] rust/hpet: Support migration
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250414144943.1112885-1-zhao1.liu@intel.com>
 <20250414144943.1112885-9-zhao1.liu@intel.com> <Z/5KlfQgC65g6Kid@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <Z/5KlfQgC65g6Kid@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/15/25 14:01, Zhao Liu wrote:
> Hi Paolo,
> 
> Based on the this patch, I simply copied your MemoryRegionOpsBuilder
> and quickly tried out the vmstate builder over a few cups of tea.

Good idea (the tea :)).

> Although it can handle callbacks well, I found that the difficulty still
> lies in the fact that the vmstate_fields and vmstate_subsections macros
> cannot be eliminated, because any dynamic creation of arrays is not
> allowed in a static context!

Yes, this makes sense.  Array size must be known inside a const function 
and the extra terminator at the end of fields and subsections cannot be 
added by the builder itself.  c_str! has the same issue for the name, if 
I understand correctly.

> An additional difficult case is vmsd(). Passing the raw VMStateDescription
> looks not good, while passing the VMStateDescription<> wrapper requires
> bounding DeviceImpl with 'static. Ultimately, I added an extra
> StaticVMStateDescription trait to successfully compile...

Hmm I cannot fully understand it so I'll check it out later.

> In any case, it's definitely still rough, but hope it helps and
> takes a small step forward.

Yes, of course---this:

+static VMSTATE_HPET_RTC_IRQ_LEVEL: VMStateDescription<HPETState> =
+    VMStateDescriptionBuilder::<HPETState>::new()
+        .name(c_str!("hpet/rtc_irq_level"))
+        .version_id(1)
+        .minimum_version_id(1)
+        .needed(&HPETState::is_rtc_irq_level_needed)
+        .fields(vmstate_fields! {
+            vmstate_of!(HPETState, rtc_irq_level),
+        })
+        .build();
+

is readable, not foreign (it's similar to the MemoryRegionOps) and 
provides an easy way to insert FFI wrappers.

Right now it's now fully typesafe, because the VMStateField returned by 
vmstate_of! (as well as the arrays returned by vmstate_fields! and 
vmstate_subsections!) does not track that it's for an HPETState; but 
that's a small thing overall and getting the basic builder right is more 
important.

I also made a note to check which callbacks could have a Result<> as the 
return type, possibly reusing the Errno module (Result<(), ()> looks a 
bit silly); but that is also not needed for this early stage.

Just a couple notes:

> +    bindings::{VMStateDescription as RawVMStateDescription, VMStateFlags},

I would use bindings::VMStateDescription throughout, similar to how
it's done in memory.rs.

> +    pub const fn name(mut self, name_str: &CStr) -> Self {
> +        self.0.name = ::std::ffi::CStr::as_ptr(name_str);


This can use "name_str.as_ptr()" because the type of name_str is known 
(unlike in macros, such as define_property! or vmstate_validate!).

(By the way, talking about macros, I have just stumbled on the attrs 
crate, which is something to keep an eye on for when QOM/qdev bindings 
are extended along the lines of 
https://lore.kernel.org/qemu-devel/e8e55772-906b-42cb-a744-031e6ae65f16@redhat.com/T/. 
  But I don't think procedural macros are a good match for VMState).

Paolo

> (Thanks for the patch 2 comment, I'll reply later!)
> 
> Thanks,
> Zhao
> 
> ---
> diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
> index a3538af14b48..16d495508424 100644
> --- a/rust/hw/timer/hpet/src/hpet.rs
> +++ b/rust/hw/timer/hpet/src/hpet.rs
> @@ -4,7 +4,6 @@
> 
>   use std::{
>       ffi::CStr,
> -    os::raw::{c_int, c_void},
>       pin::Pin,
>       ptr::{addr_of_mut, null_mut, NonNull},
>       slice::from_ref,
> @@ -27,9 +26,8 @@
>       qom_isa,
>       sysbus::{SysBusDevice, SysBusDeviceImpl},
>       timer::{Timer, CLOCK_VIRTUAL, NANOSECONDS_PER_SECOND},
> -    vmstate::VMStateDescription,
> +    vmstate::{StaticVMStateDescription, VMStateDescription, VMStateDescriptionBuilder},
>       vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections, vmstate_validate,
> -    zeroable::Zeroable,
>   };
> 
>   use crate::fw_cfg::HPETFwConfig;
> @@ -943,104 +941,73 @@ impl ObjectImpl for HPETState {
>       ),
>   }
> 
> -unsafe extern "C" fn hpet_rtc_irq_level_needed(opaque: *mut c_void) -> bool {
> -    // SAFETY:
> -    // the pointer is convertible to a reference
> -    let state: &HPETState = unsafe { NonNull::new(opaque.cast::<HPETState>()).unwrap().as_ref() };
> -    state.is_rtc_irq_level_needed()
> -}
> -
> -unsafe extern "C" fn hpet_offset_needed(opaque: *mut c_void) -> bool {
> -    // SAFETY:
> -    // the pointer is convertible to a reference
> -    let state: &HPETState = unsafe { NonNull::new(opaque.cast::<HPETState>()).unwrap().as_ref() };
> -    state.is_offset_needed()
> -}
> -unsafe extern "C" fn hpet_pre_save(opaque: *mut c_void) -> c_int {
> -    // SAFETY:
> -    // the pointer is convertible to a reference
> -    let state: &mut HPETState =
> -        unsafe { NonNull::new(opaque.cast::<HPETState>()).unwrap().as_mut() };
> -    state.pre_save() as c_int
> -}
> -
> -unsafe extern "C" fn hpet_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
> -    // SAFETY:
> -    // the pointer is convertible to a reference
> -    let state: &mut HPETState =
> -        unsafe { NonNull::new(opaque.cast::<HPETState>()).unwrap().as_mut() };
> -    let version: u8 = version_id.try_into().unwrap();
> -    state.post_load(version) as c_int
> -}
> -
> -static VMSTATE_HPET_RTC_IRQ_LEVEL: VMStateDescription = VMStateDescription {
> -    name: c_str!("hpet/rtc_irq_level").as_ptr(),
> -    version_id: 1,
> -    minimum_version_id: 1,
> -    needed: Some(hpet_rtc_irq_level_needed),
> -    fields: vmstate_fields! {
> -        vmstate_of!(HPETState, rtc_irq_level),
> -    },
> -    ..Zeroable::ZERO
> -};
> -
> -static VMSTATE_HPET_OFFSET: VMStateDescription = VMStateDescription {
> -    name: c_str!("hpet/offset").as_ptr(),
> -    version_id: 1,
> -    minimum_version_id: 1,
> -    needed: Some(hpet_offset_needed),
> -    fields: vmstate_fields! {
> -        vmstate_of!(HPETState, hpet_offset),
> -    },
> -    ..Zeroable::ZERO
> -};
> -
> -static VMSTATE_HPET_TIMER: VMStateDescription = VMStateDescription {
> -    name: c_str!("hpet_timer").as_ptr(),
> -    version_id: 1,
> -    minimum_version_id: 1,
> -    fields: vmstate_fields! {
> -        vmstate_of!(HPETTimer, index),
> -        vmstate_of!(HPETTimer, config),
> -        vmstate_of!(HPETTimer, cmp),
> -        vmstate_of!(HPETTimer, fsb),
> -        vmstate_of!(HPETTimer, period),
> -        vmstate_of!(HPETTimer, wrap_flag),
> -        vmstate_of!(HPETTimer, qemu_timer),
> -    },
> -    ..Zeroable::ZERO
> -};
> +static VMSTATE_HPET_RTC_IRQ_LEVEL: VMStateDescription<HPETState> =
> +    VMStateDescriptionBuilder::<HPETState>::new()
> +        .name(c_str!("hpet/rtc_irq_level"))
> +        .version_id(1)
> +        .minimum_version_id(1)
> +        .needed(&HPETState::is_rtc_irq_level_needed)
> +        .fields(vmstate_fields! {
> +            vmstate_of!(HPETState, rtc_irq_level),
> +        })
> +        .build();
> +
> +static VMSTATE_HPET_OFFSET: VMStateDescription<HPETState> =
> +    VMStateDescriptionBuilder::<HPETState>::new()
> +        .name(c_str!("hpet/offset"))
> +        .version_id(1)
> +        .minimum_version_id(1)
> +        .needed(&HPETState::is_offset_needed)
> +        .fields(vmstate_fields! {
> +            vmstate_of!(HPETState, hpet_offset),
> +        })
> +        .build();
> +
> +static VMSTATE_HPET_TIMER: VMStateDescription<BqlRefCell<HPETTimer>> =
> +    VMStateDescriptionBuilder::<BqlRefCell<HPETTimer>>::new()
> +        .name(c_str!("hpet_timer"))
> +        .version_id(1)
> +        .minimum_version_id(1)
> +        .fields(vmstate_fields! {
> +            vmstate_of!(HPETTimer, index),
> +            vmstate_of!(HPETTimer, config),
> +            vmstate_of!(HPETTimer, cmp),
> +            vmstate_of!(HPETTimer, fsb),
> +            vmstate_of!(HPETTimer, period),
> +            vmstate_of!(HPETTimer, wrap_flag),
> +            vmstate_of!(HPETTimer, qemu_timer),
> +        })
> +        .build();
> 
>   const VALIDATE_TIMERS_NAME: &CStr = c_str!("num_timers must match");
> 
> -static VMSTATE_HPET: VMStateDescription = VMStateDescription {
> -    name: c_str!("hpet").as_ptr(),
> -    version_id: 2,
> -    minimum_version_id: 1,
> -    pre_save: Some(hpet_pre_save),
> -    post_load: Some(hpet_post_load),
> -    fields: vmstate_fields! {
> -        vmstate_of!(HPETState, config),
> -        vmstate_of!(HPETState, int_status),
> -        vmstate_of!(HPETState, counter),
> -        vmstate_of!(HPETState, num_timers_save).with_version_id(2),
> -        vmstate_validate!(HPETState, VALIDATE_TIMERS_NAME, HPETState::validate_num_timers),
> -        vmstate_struct!(HPETState, timers[0 .. num_timers], &VMSTATE_HPET_TIMER, BqlRefCell<HPETTimer>, HPETState::validate_num_timers).with_version_id(0),
> -    },
> -    subsections: vmstate_subsections! {
> -        VMSTATE_HPET_RTC_IRQ_LEVEL,
> -        VMSTATE_HPET_OFFSET,
> -    },
> -    ..Zeroable::ZERO
> -};
> +static VMSTATE_HPET: VMStateDescription<HPETState> =
> +    VMStateDescriptionBuilder::<HPETState>::new()
> +        .name(c_str!("hpet"))
> +        .version_id(2)
> +        .minimum_version_id(1)
> +        .pre_save(&HPETState::pre_save)
> +        .post_load(&HPETState::post_load)
> +        .fields(vmstate_fields! {
> +            vmstate_of!(HPETState, config),
> +            vmstate_of!(HPETState, int_status),
> +            vmstate_of!(HPETState, counter),
> +            vmstate_of!(HPETState, num_timers_save).with_version_id(2),
> +            vmstate_validate!(HPETState, VALIDATE_TIMERS_NAME, HPETState::validate_num_timers),
> +            vmstate_struct!(HPETState, timers[0 .. num_timers], &VMSTATE_HPET_TIMER, BqlRefCell<HPETTimer>, HPETState::validate_num_timers).with_version_id(0),
> +        })
> +        .subsections(vmstate_subsections!(
> +            VMSTATE_HPET_RTC_IRQ_LEVEL,
> +            VMSTATE_HPET_OFFSET,
> +        ))
> +        .build();
> 
>   impl DeviceImpl for HPETState {
>       fn properties() -> &'static [Property] {
>           &HPET_PROPERTIES
>       }
> 
> -    fn vmsd() -> Option<&'static VMStateDescription> {
> +    fn vmsd() -> Option<&'static dyn StaticVMStateDescription> {
>           Some(&VMSTATE_HPET)
>       }
> 
> diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
> index 18b4a9ba687d..3398167d2b4d 100644
> --- a/rust/qemu-api/src/qdev.rs
> +++ b/rust/qemu-api/src/qdev.rs
> @@ -20,7 +20,7 @@
>       irq::InterruptSource,
>       prelude::*,
>       qom::{ObjectClass, ObjectImpl, Owned},
> -    vmstate::VMStateDescription,
> +    vmstate::{StaticVMStateDescription, VMStateDescription},
>   };
> 
>   /// A safe wrapper around [`bindings::Clock`].
> @@ -121,7 +121,7 @@ fn properties() -> &'static [Property] {
>       /// A `VMStateDescription` providing the migration format for the device
>       /// Not a `const` because referencing statics in constants is unstable
>       /// until Rust 1.83.0.
> -    fn vmsd() -> Option<&'static VMStateDescription> {
> +    fn vmsd() -> Option<&'static dyn StaticVMStateDescription> {
>           None
>       }
>   }
> @@ -170,7 +170,7 @@ pub fn class_init<T: DeviceImpl>(&mut self) {
>               self.realize = Some(rust_realize_fn::<T>);
>           }
>           if let Some(vmsd) = <T as DeviceImpl>::vmsd() {
> -            self.vmsd = vmsd;
> +            self.vmsd = vmsd.get_vmsd_ptr();
>           }
>           let prop = <T as DeviceImpl>::properties();
>           if !prop.is_empty() {
> diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
> index 7d9f3a2ca6f2..35d4d12c8ed6 100644
> --- a/rust/qemu-api/src/vmstate.rs
> +++ b/rust/qemu-api/src/vmstate.rs
> @@ -25,11 +25,18 @@
>   //!   functionality that is missing from `vmstate_of!`.
> 
>   use core::{marker::PhantomData, mem, ptr::NonNull};
> -use std::os::raw::{c_int, c_void};
> +use std::{
> +    ffi::CStr,
> +    os::raw::{c_int, c_void},
> +};
> 
> -pub use crate::bindings::{VMStateDescription, VMStateField};
> +pub use crate::bindings::{MigrationPriority, VMStateField};
>   use crate::{
> -    bindings::VMStateFlags, callbacks::FnCall, prelude::*, qom::Owned, zeroable::Zeroable,
> +    bindings::{VMStateDescription as RawVMStateDescription, VMStateFlags},
> +    callbacks::FnCall,
> +    prelude::*,
> +    qom::Owned,
> +    zeroable::Zeroable,
>   };
> 
>   /// This macro is used to call a function with a generic argument bound
> @@ -489,7 +496,7 @@ macro_rules! vmstate_struct {
>               },
>               size: ::core::mem::size_of::<$type>(),
>               flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
> -            vmsd: $vmsd,
> +            vmsd: $vmsd.get_vmsd_ptr(),
>               $(field_exists: $crate::vmstate_exist_fn!($struct_name, $test_fn),)?
>               ..$crate::zeroable::Zeroable::ZERO
>            } $(.with_varray_flag_unchecked(
> @@ -586,11 +593,188 @@ macro_rules! vmstate_subsections {
>       ($($subsection:expr),*$(,)*) => {{
>           static _SUBSECTIONS: $crate::vmstate::VMStateSubsectionsWrapper = $crate::vmstate::VMStateSubsectionsWrapper(&[
>               $({
> -                static _SUBSECTION: $crate::bindings::VMStateDescription = $subsection;
> +                static _SUBSECTION: $crate::bindings::VMStateDescription = $subsection.get_vmsd();
>                   ::core::ptr::addr_of!(_SUBSECTION)
>               }),*,
>               ::core::ptr::null()
>           ]);
> -        _SUBSECTIONS.0.as_ptr()
> +        &_SUBSECTIONS
>       }}
>   }
> +
> +pub struct VMStateDescription<T>(RawVMStateDescription, PhantomData<fn(&T)>);
> +
> +// SAFETY: When a *const T is passed to the callbacks, the call itself
> +// is done in a thread-safe manner.  The invocation is okay as long as
> +// T itself is `Sync`.
> +unsafe impl<T: Sync> Sync for VMStateDescription<T> {}
> +
> +#[derive(Clone)]
> +pub struct VMStateDescriptionBuilder<T>(RawVMStateDescription, PhantomData<fn(&T)>);
> +
> +unsafe extern "C" fn vmstate_pre_load_cb<T, F: for<'a> FnCall<(&'a T,), i32>>(
> +    opaque: *mut c_void,
> +) -> c_int {
> +    // SAFETY: the opaque was passed as a reference to `T`.
> +    F::call((unsafe { &*(opaque.cast::<T>()) },)) as c_int
> +}
> +
> +unsafe extern "C" fn vmstate_post_load_cb<T, F: for<'a> FnCall<(&'a T, u8), i32>>(
> +    opaque: *mut c_void,
> +    version_id: c_int,
> +) -> c_int {
> +    // SAFETY: the opaque was passed as a reference to `T`.
> +    let owner: &T = unsafe { &*(opaque.cast::<T>()) };
> +    let version: u8 = version_id.try_into().unwrap();
> +    F::call((owner, version)) as c_int
> +}
> +
> +unsafe extern "C" fn vmstate_pre_save_cb<T, F: for<'a> FnCall<(&'a T,), i32>>(
> +    opaque: *mut c_void,
> +) -> c_int {
> +    // SAFETY: the opaque was passed as a reference to `T`.
> +    F::call((unsafe { &*(opaque.cast::<T>()) },)) as c_int
> +}
> +
> +unsafe extern "C" fn vmstate_post_save_cb<T, F: for<'a> FnCall<(&'a T,), i32>>(
> +    opaque: *mut c_void,
> +) -> c_int {
> +    // SAFETY: the opaque was passed as a reference to `T`.
> +    F::call((unsafe { &*(opaque.cast::<T>()) },)) as c_int
> +}
> +
> +unsafe extern "C" fn vmstate_needed_cb<T, F: for<'a> FnCall<(&'a T,), bool>>(
> +    opaque: *mut c_void,
> +) -> bool {
> +    // SAFETY: the opaque was passed as a reference to `T`.
> +    F::call((unsafe { &*(opaque.cast::<T>()) },))
> +}
> +
> +unsafe extern "C" fn vmstate_dev_unplug_pending_cb<T, F: for<'a> FnCall<(&'a T,), bool>>(
> +    opaque: *mut c_void,
> +) -> bool {
> +    // SAFETY: the opaque was passed as a reference to `T`.
> +    F::call((unsafe { &*(opaque.cast::<T>()) },))
> +}
> +
> +impl<T> VMStateDescriptionBuilder<T> {
> +    #[must_use]
> +    pub const fn name(mut self, name_str: &CStr) -> Self {
> +        self.0.name = ::std::ffi::CStr::as_ptr(name_str);
> +        self
> +    }
> +
> +    #[must_use]
> +    pub const fn unmigratable(mut self) -> Self {
> +        self.0.unmigratable = true;
> +        self
> +    }
> +
> +    #[must_use]
> +    pub const fn early_setup(mut self) -> Self {
> +        self.0.early_setup = true;
> +        self
> +    }
> +
> +    #[must_use]
> +    pub const fn version_id(mut self, version: u8) -> Self {
> +        self.0.version_id = version as c_int;
> +        self
> +    }
> +
> +    #[must_use]
> +    pub const fn minimum_version_id(mut self, min_version: u8) -> Self {
> +        self.0.minimum_version_id = min_version as c_int;
> +        self
> +    }
> +
> +    #[must_use]
> +    pub const fn priority(mut self, priority: MigrationPriority) -> Self {
> +        self.0.priority = priority;
> +        self
> +    }
> +
> +    #[must_use]
> +    pub const fn pre_load<F: for<'a> FnCall<(&'a T,), i32>>(mut self, _f: &F) -> Self {
> +        self.0.pre_load = Some(vmstate_pre_load_cb::<T, F>);
> +        self
> +    }
> +
> +    #[must_use]
> +    pub const fn post_load<F: for<'a> FnCall<(&'a T, u8), i32>>(mut self, _f: &F) -> Self {
> +        self.0.post_load = Some(vmstate_post_load_cb::<T, F>);
> +        self
> +    }
> +
> +    #[must_use]
> +    pub const fn pre_save<F: for<'a> FnCall<(&'a T,), i32>>(mut self, _f: &F) -> Self {
> +        self.0.pre_save = Some(vmstate_pre_save_cb::<T, F>);
> +        self
> +    }
> +
> +    #[must_use]
> +    pub const fn post_save<F: for<'a> FnCall<(&'a T,), i32>>(mut self, _f: &F) -> Self {
> +        self.0.post_save = Some(vmstate_post_save_cb::<T, F>);
> +        self
> +    }
> +
> +    #[must_use]
> +    pub const fn needed<F: for<'a> FnCall<(&'a T,), bool>>(mut self, _f: &F) -> Self {
> +        self.0.needed = Some(vmstate_needed_cb::<T, F>);
> +        self
> +    }
> +
> +    #[must_use]
> +    pub const fn unplug_pending<F: for<'a> FnCall<(&'a T,), bool>>(mut self, _f: &F) -> Self {
> +        self.0.dev_unplug_pending = Some(vmstate_dev_unplug_pending_cb::<T, F>);
> +        self
> +    }
> +
> +    #[must_use]
> +    pub const fn fields(mut self, fields: *const VMStateField) -> Self {
> +        self.0.fields = fields;
> +        self
> +    }
> +
> +    #[must_use]
> +    pub const fn subsections(mut self, subs: &'static VMStateSubsectionsWrapper) -> Self {
> +        self.0.subsections = subs.0.as_ptr();
> +        self
> +    }
> +
> +    #[must_use]
> +    pub const fn build(self) -> VMStateDescription<T> {
> +        VMStateDescription::<T>(self.0, PhantomData)
> +    }
> +
> +    #[must_use]
> +    pub const fn new() -> Self {
> +        Self(RawVMStateDescription::ZERO, PhantomData)
> +    }
> +}
> +
> +impl<T> Default for VMStateDescriptionBuilder<T> {
> +    fn default() -> Self {
> +        Self::new()
> +    }
> +}
> +
> +impl<T> VMStateDescription<T> {
> +    pub const fn get_vmsd(&self) -> RawVMStateDescription {
> +        self.0
> +    }
> +
> +    pub const fn get_vmsd_ptr(&self) -> *const RawVMStateDescription {
> +        &self.0 as *const _ as *const RawVMStateDescription
> +    }
> +}
> +
> +pub trait StaticVMStateDescription {
> +    fn get_vmsd_ptr(&'static self) -> *const RawVMStateDescription;
> +}
> +
> +impl<T> StaticVMStateDescription for VMStateDescription<T> {
> +    fn get_vmsd_ptr(&'static self) -> *const RawVMStateDescription {
> +        self.get_vmsd_ptr()
> +    }
> +}
> 
> 
> 
> 
> 


