Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D86E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 17:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL4CA-00005a-4I; Tue, 10 Dec 2024 12:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tL4C1-0008Ny-Uv
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 12:38:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tL4C0-0005w5-CG
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 12:38:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733852318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EBjokO9RvuNIEF2VRfNWcKbPAsjcPOD01MJwzzn+qtA=;
 b=QUEVYQjb4dQXOQyKqMOBxN3NLoeN5ASaZw9AU9FB0UuKQPV6XwjBsapgm9U5q8VFCz0jMV
 72yKOXXnDM6zdDGtlRKh04CXwa8fsaCeQm2uAr/v840ESDUA8bE1zeVIz4A9KQ6lBxEFVu
 CsrpOnzcZ4Kmpj1hxr9oNKwcXV5Xtbw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-X7GrowxdMFmL4zrSqtHSEw-1; Tue, 10 Dec 2024 12:38:37 -0500
X-MC-Unique: X7GrowxdMFmL4zrSqtHSEw-1
X-Mimecast-MFC-AGG-ID: X7GrowxdMFmL4zrSqtHSEw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361ac607b6so3090795e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 09:38:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733852316; x=1734457116;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EBjokO9RvuNIEF2VRfNWcKbPAsjcPOD01MJwzzn+qtA=;
 b=IXpWhQjn4r45+PdDYYa1PV7zMUVPQHyV/669o7rpRxaxC9W7jbnrDUsbIIUtPpCLLk
 NJmFU/bdSfA2w0ZhjwDSkydFSINHEHfLnhk4yxNbobceGMaYYNCYZgQJ/SvQ3oj6a2iS
 BJYD6APyexk5vXtowzcyLW1COk8CSHFV0odwXzUVsH4VwKg7c2p+bM6fcCQyfBFRcBrF
 Ui/a/XyS8ivXLe96SpwV5PWqOwayhfHx5WrrK6AtweIvMcPvX8GUt2lxzwFhX8WGzBKb
 TRkRGsYwrN/Bkk/MzOvw3Sl23y2Bl3tfrkXo9EczliWkRK/xpNUE4eS7zSpJMR1RMC3F
 cjJw==
X-Gm-Message-State: AOJu0Yz7jLJOkuSTSkFIC8fWYloxlv/bPHVY2R0C3iynuN/9DPVihjL0
 OSnBYynOlutcW1gJAVnQNIUr8WwyiSLBjmV04X+EkUa83MM0MznigwV9+A0H8Yy0AEbKNlzeBMh
 YrMkMmilesT9TEdDpFVwiD7XsALcy6K+1Iz/5Gy8CtIAQbkOKY5Fp
X-Gm-Gg: ASbGnct4FwrfddkpdG1QSaeJ47p/UnwGc81carqHILkZaT0GM/j0/kN6/9WnAbsLv3k
 +59Fxi79DAftFAD68XJ8IbGRcmTk8fCz10BDC0oRyKAVZWWf5oKbDvkodq669/Ye5Xq+gZo++zF
 ql1KnquHsakqJe9OdnwWX9+BkYP+p1qhT1hkRdm7wh+GDWX8y6pIvuFM2M1pDl9gOvqq7bewvFR
 yU7tZ0onpDm4UgZKkKeRR+jIs2qP8X4UG9cWHOnHVJKM+lCITF0ek0Mrg==
X-Received: by 2002:a05:600c:3783:b0:434:f5c0:3288 with SMTP id
 5b1f17b1804b1-434f5c03c29mr76445055e9.29.1733852315976; 
 Tue, 10 Dec 2024 09:38:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEz6HxhmXQaWWV2iGAldnT6ikNtoXfXXfalQmaNGnqxhCmEBkH4fybTIHmgdrXRlSXgv94YGg==
X-Received: by 2002:a05:600c:3783:b0:434:f5c0:3288 with SMTP id
 5b1f17b1804b1-434f5c03c29mr76444875e9.29.1733852315590; 
 Tue, 10 Dec 2024 09:38:35 -0800 (PST)
Received: from [192.168.10.28] ([151.81.118.45])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-434ea285b57sm123232715e9.37.2024.12.10.09.38.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 09:38:35 -0800 (PST)
Message-ID: <ada60844-546a-42ca-a05f-7b6dc225ff53@redhat.com>
Date: Tue, 10 Dec 2024 18:38:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/26] rust: qom: move bridge for TypeInfo functions out
 of pl011
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-15-pbonzini@redhat.com> <Z1hjX+5Yyi46N+sX@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z1hjX+5Yyi46N+sX@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 12/10/24 16:50, Zhao Liu wrote:
> On Mon, Dec 09, 2024 at 01:37:05PM +0100, Paolo Bonzini wrote:
>> Date: Mon,  9 Dec 2024 13:37:05 +0100
>> From: Paolo Bonzini <pbonzini@redhat.com>
>> Subject: [PATCH 14/26] rust: qom: move bridge for TypeInfo functions out of
>>   pl011
>> X-Mailer: git-send-email 2.47.1
>>
>> Allow the ObjectImpl trait to expose Rust functions that avoid raw
>> pointers (though INSTANCE_INIT for example is still unsafe).
>> ObjectImpl::TYPE_INFO adds thunks around the functions in
>> ObjectImpl.
>>
>> While at it, document `TypeInfo`.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   rust/hw/char/pl011/src/device.rs | 40 +++++++--------------
>>   rust/qemu-api/src/definitions.rs | 61 +++++++++++++++++++++++++++++---
>>   2 files changed, 69 insertions(+), 32 deletions(-)
>>
>> diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
>> index 56403c36609..b9f8fb134b5 100644
>> --- a/rust/hw/char/pl011/src/device.rs
>> +++ b/rust/hw/char/pl011/src/device.rs
>> @@ -110,7 +110,7 @@ impl ObjectImpl for PL011State {
>>       type Class = PL011Class;
>>       const TYPE_NAME: &'static CStr = crate::TYPE_PL011;
>>       const PARENT_TYPE_NAME: Option<&'static CStr> = Some(TYPE_SYS_BUS_DEVICE);
>> -    const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = Some(pl011_init);
>> +    const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
> 
> No need to keep `unsafe` here?

Right now instance_init is called with only the parent initialized, and 
the remaining memory zeroed; its purpose is to prepare things for 
instance_post_init which can then be safe (it's also kind of wrong for 
instance_post_init to receive a &mut Self, because instance_init will 
create other pointers to the object, for example in a MemoryRegion's 
"parent" field).

The right thing to do would be to have an argument of type &mut 
MaybeUninit<Self>.  Then the caller would do something like

     let maybe_uninit = obj as *mut MaybeUninit<Self>;
     unsafe {
         Self::INSTANCE_INIT(&mut *maybe_uninit);
         maybe_uninit.assume_init_mut();
     }

Note however that INSTANCE_INIT would still be unsafe, because its 
safety promise is that it prepares things for the caller's 
assume_init_mut().

The way that this will become safe is to use the pinned_init crate from 
Linux: instance_init returns the initialization as an "impl 
PinInit<Self>", and then instance_post_init can run with a &self.  Until 
then, however, instance_init has to remain unsafe.

Paolo


