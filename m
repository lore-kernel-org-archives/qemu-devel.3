Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DE2C0218C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 17:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taeX0-0000mf-1Z; Wed, 22 Jan 2025 12:28:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1taeWy-0000m6-96
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 12:28:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1taeWo-0003gO-Dh
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 12:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737566913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=INZM1f1/nzdZchas4RooMRok0z3xAteaBOVK50milpQ=;
 b=FAovOStV2ZkP2YWePj2PEpi1UViSC5fKVn1FTd9DhZgU7y7OdqNRyJeyLp+wKWKNFAK78x
 KDK02m8UNNgkxDvbRnMlggNfYhxrHkZXi6jxsF2Vfyn23a6wLabfSn9S/jktaw3zf52+5H
 aUgyiA/f2Vww7PYowssfSAKSeVt/rBc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-6oqWvj1gMpSnhpkNw-z_JA-1; Wed, 22 Jan 2025 12:28:31 -0500
X-MC-Unique: 6oqWvj1gMpSnhpkNw-z_JA-1
X-Mimecast-MFC-AGG-ID: 6oqWvj1gMpSnhpkNw-z_JA
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5d9f21e17cfso36248a12.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 09:28:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737566910; x=1738171710;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=INZM1f1/nzdZchas4RooMRok0z3xAteaBOVK50milpQ=;
 b=haKd2phImRXCjNy5+xB3QXxuaJUIKdfFwTDwj5OnH43rp8XYtQJ5Rvw6a9VUngW92O
 I6uEASnMYU+CZ6ERHL8GCw2uAaYxI5hSYsWZgXO7QUEelsrRDaDSxa+VVifYxXAGDJjt
 jAsMcRDxBtYdKBF0caATfUSHBU6Av9E9phU/CqbRXuyzQBkSlEQOtOVqnyHgmESySWpz
 d4hbRKAo7gG0Rvy5ARQHaZ7io6FbEnT+k4dikCYkGWks/49lc1h3n9ZFGE6i7RzaVwCu
 N5kvi29sizn6Ylv19dNImRD6uclmFWKgNlespD2U6+rhT0EeIzPAPk5wTKXoLnYAgG9N
 x8mg==
X-Gm-Message-State: AOJu0YwSudVap+vkidOfHdAK0Ee5MoTfJ1T9TA5fo0Mq5F46fDFxq+1A
 lyUflxwMHamgN4TtlDh3wTIHw/v0nDbE2melBgtpF86QNmmNc5rmqGGqdnO1y5JZQ1To9T523PB
 8UVApoVk1NrXlEtNYZTRMFhyRDS5DPgUIwCsqYu1oe1rk837ItjaTmC37bVMf5cs=
X-Gm-Gg: ASbGnctdcWz0qFUtcfKmRLn9vDIMGyb+F+KW2hExfJVUF6gLd7g/FuSmVnJImTuwvXi
 hkyU26gY9ln4jd5WjIobaJaLCzc6bdChGKU6Q++RV1DGmmC6+6Ey6mjEq43LnuoSRfRCbsNPCTP
 b71G6Coedyu4OsQNKlxulqg1ObOlgoymY2eBLv6lDIa5375bkb6liF2N2JIPNTi7ASbIqwr9tPL
 3sWZpsyY1wLTZSieRGWSMcEDRukdXKiaUw7gYnXslH4+zySuJDquJokdaA89N2QYJgf9WkGWWI=
X-Received: by 2002:a05:6402:42d6:b0:5d9:f9b8:e7e5 with SMTP id
 4fb4d7f45d1cf-5db7d300368mr22894400a12.15.1737566909475; 
 Wed, 22 Jan 2025 09:28:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHm17iHgsEOMiNm8qTq3y6IjMGjRta+JkCdmC6XfzKLAEXaKPTJfmKwocUDiVbQH/5jcyT9nw==
X-Received: by 2002:a05:6402:42d6:b0:5d9:f9b8:e7e5 with SMTP id
 4fb4d7f45d1cf-5db7d300368mr22894288a12.15.1737566907626; 
 Wed, 22 Jan 2025 09:28:27 -0800 (PST)
Received: from [192.168.10.47] ([176.206.124.70])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-5db73670ddesm8999744a12.21.2025.01.22.09.28.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 09:28:27 -0800 (PST)
Message-ID: <6b30a54a-c196-48d5-9003-ad9cb69a830a@redhat.com>
Date: Wed, 22 Jan 2025 18:28:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] rust: vmstate: implement VMState for scalar types
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250117090046.1045010-1-pbonzini@redhat.com>
 <20250117090046.1045010-6-pbonzini@redhat.com> <Z5DlngFjERVqmxca@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z5DlngFjERVqmxca@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/22/25 13:33, Zhao Liu wrote:
> On Fri, Jan 17, 2025 at 10:00:41AM +0100, Paolo Bonzini wrote:
>> Date: Fri, 17 Jan 2025 10:00:41 +0100
>> From: Paolo Bonzini <pbonzini@redhat.com>
>> Subject: [PATCH 05/10] rust: vmstate: implement VMState for scalar types
>> X-Mailer: git-send-email 2.47.1
>>
>> Scalar types are those that have their own VMStateInfo.  This poses
>> a problem in that references to VMStateInfo can only be included in
>> associated consts starting with Rust 1.83.0, when the const_refs_static
>> was stabilized.  Removing the requirement is done by placing a limited
>> list of VMStateInfos in an enum, and going from enum to &VMStateInfo
>> only when building the VMStateField.
>>
>> The same thing cannot be done with VMS_STRUCT because the set of
>> VMStateDescriptions extends to structs defined by the devices.
>> Therefore, structs and cells cannot yet use vmstate_of!.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   rust/qemu-api/src/vmstate.rs | 128 ++++++++++++++++++++++++++++++++++-
>>   1 file changed, 126 insertions(+), 2 deletions(-)
> 
> 
>>   /// Internal utility function to retrieve a type's `VMStateField`;
>>   /// used by [`vmstate_of!`](crate::vmstate_of).
>>   pub const fn vmstate_base<T: VMState>(_: PhantomData<T>) -> VMStateField {
>> @@ -99,6 +178,15 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateField
>>   /// Return the `VMStateField` for a field of a struct.  The field must be
>>   /// visible in the current scope.
>>   ///
>> +/// Only a limited set of types is supported out of the box:
>> +/// * scalar types (integer and `bool`)
>> +/// * the C struct `QEMUTimer`
>> +/// * a transparent wrapper for any of the above (`Cell`, `UnsafeCell`,
>> +///   [`BqlCell`](crate::cell::BqlCell), [`BqlRefCell`](crate::cell::BqlRefCell)
>> +/// * a raw pointer to any of the above
>> +/// * a `NonNull` pointer to any of the above, possibly wrapped with `Option`
> 
> I just found your rust-next has already updated and removed `Option` :-)
> 
>> +/// * an array of any of the above
>> +///
>>   /// In order to support other types, the trait `VMState` must be implemented
>>   /// for them.
>>   #[macro_export]
>> @@ -109,8 +197,14 @@ macro_rules! vmstate_of {
>>                   .as_bytes()
>>                   .as_ptr() as *const ::std::os::raw::c_char,
>>               offset: $crate::offset_of!($struct_name, $field_name),
>> -            // Compute most of the VMStateField from the type of the field.
> 
> Rebase mistake? This comment seems no need to be deleted.

It's moved below because there's now more than one call_func_with_field 
call.  I can make it so that the phrasing and placement remains the same 
throughout the series.

Paolo

>>               $(.num_offset: $crate::offset_of!($struct_name, $num),)?
>> +            // The calls to `call_func_with_field!` are the magic that
>> +            // computes most of the VMStateField from the type of the field.
>> +            info: $crate::info_enum_to_ref!($crate::call_func_with_field!(
>> +                $crate::vmstate::vmstate_scalar_type,
>> +                $struct_name,
>> +                $field_name
>> +            )),
>>
> 
> Only a nit above,
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 
> 
> 


