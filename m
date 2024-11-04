Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A681D1BDC0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 16:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7zWv-0007FL-EX; Mon, 04 Nov 2024 11:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t7zWt-0007Ew-C9
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:02:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t7zWr-00074T-Es
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:02:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730736128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qc2IAV67imz/GCu+bgSFt3ii1cTiiWNciz4wmk3XzHI=;
 b=LeSRcqObkBUSe9FDszFt937SRW/NcPrxn2wwdLxgoklkxq6oXXCmwcAd7yI+J/qSUqTCv4
 QbNVNg3erBt2cwhiYiyG/8LGA5BY+lJKqRwZOD3J3QMazwrZkY7d+OqqMfDjbmcuyhRE2g
 EkzP1IL1E6rnL64KU60oiQBmMYoxorY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-UYd0vWUfNIOyDYQiLw7Wmw-1; Mon, 04 Nov 2024 11:02:06 -0500
X-MC-Unique: UYd0vWUfNIOyDYQiLw7Wmw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d4d51b4efso1928447f8f.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 08:02:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730736125; x=1731340925;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qc2IAV67imz/GCu+bgSFt3ii1cTiiWNciz4wmk3XzHI=;
 b=PR1Le+wkXdCSdR/1398w6qFf/z2cAdoa4H+r4UR7CK2guD2QQ8WToO8nf4KzaPJ+3Q
 0T55KEGgy1vGkh3C4YSzK10hsyOLMQ8P6leItVVAaymWfosRcpxq9N3m0qWKUUSI+ipD
 YlTdE2/BSIsnZLQ7fjB3j50VW2hS9Vn/jvuRnBwH5GlQeRqH6rHRcX0rYoPJq6ngEU0M
 8Z7xu9VRXQ5+WsNseMmtQjM1LnfY4RszsGXq0aRraXTQULZHFnMcoeLWFuqkifhzWgNJ
 5NyRI+/C8uNJE0bYwiOurplz5BUg1gcTCsliWEfMT/Jh/tSdhJLgY2VGHpUa1zGBYica
 Mpvw==
X-Gm-Message-State: AOJu0Yzo608rwnd7LtxpnYOrrz2XSaTrAvQW8MVj1dFUS3JW3065hzjG
 Rbg4HnzoJjtWvQt337CSzfuVdZdbJN2k/vLjU+9z3s4IayvwaZI2tw0XKFI6yfCCQ/eD4eGkUlO
 ABmIY5dp64wBetLRVwdgikFrBfcv2xPTLScZZffCjSEoHROvehk2v
X-Received: by 2002:adf:f18c:0:b0:374:c621:3d67 with SMTP id
 ffacd0b85a97d-38061137930mr24065254f8f.24.1730736124932; 
 Mon, 04 Nov 2024 08:02:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExEacbyN3wnpiIofKjtchrXr+OrUS0Uqio1dCbmjFgvoZ+gPwagBLpU2ig0AuSfGD1X4Rf4A==
X-Received: by 2002:adf:f18c:0:b0:374:c621:3d67 with SMTP id
 ffacd0b85a97d-38061137930mr24065189f8f.24.1730736124248; 
 Mon, 04 Nov 2024 08:02:04 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-381c10d4141sm13605880f8f.28.2024.11.04.08.02.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 08:02:03 -0800 (PST)
Message-ID: <b5f4bb6a-765b-4dce-b0b9-6a2be695d8a5@redhat.com>
Date: Mon, 4 Nov 2024 17:02:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/23] rust: introduce alternative implementation of
 offset_of!
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org,
 zhao1.liu@intel.com, berrange@redhat.com
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-16-pbonzini@redhat.com>
 <SY0P300MB1026D525F3022164941671B895502@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <SY0P300MB1026D525F3022164941671B895502@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11/3/24 10:54, Junjie Mao wrote:
> 
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> From: Junjie Mao <junjie.mao@hotmail.com>
>>
>> offset_of! was stabilized in Rust 1.77.0.  Use an alternative implemenation
>> that was found on the Rust forums, and whose author agreed to license as
>> MIT for use in QEMU.
>>
>> The alternative allows only one level of field access, but apart
>> from this can be used just by replacing core::mem::offset_of! with
>> qemu_api::offset_of!.
>>
>> The actual implementation of offset_of! is done in a declarative macro,
>> but for simplicity and to avoid introducing an extra level of indentation,
>> the trigger is a procedural macro #[derive(offsets)].
>>
>> The procedural macro is perhaps a bit overengineered, but it helps
>> introducing some idioms that will be useful in the future as well.
>>
>> Signed-off-by: Junjie Mao <junjie.mao@hotmail.com>
>> Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Generally looks good to me. Thanks for integrating this!
> 
> It seems Rust does not have builtin support for unit tests expecting
> compilation failures. There is a crate (named trybuild [1]) for that
> purpose but it requires introducing a dozen of new dependencies (see
> below). Do you think it worth the effort? If so, I can take a closer
> look and cook something for initial review (probably post 9.2).
> 
>      trybuild v1.0.101
>      ├── glob v0.3.1
>      ├── serde v1.0.210
>      ├── serde_derive v1.0.210 (proc-macro)
>      │   ├── proc-macro2 v1.0.84 (*)
>      │   ├── quote v1.0.36 (*)
>      │   └── syn v2.0.66 (*)
>      ├── serde_json v1.0.132
>      │   ├── itoa v1.0.11
>      │   ├── memchr v2.7.4
>      │   ├── ryu v1.0.18
>      │   └── serde v1.0.210
>      ├── target-triple v0.1.3
>      ├── termcolor v1.4.1
>      └── toml v0.8.19
>          ├── serde v1.0.210
>          ├── serde_spanned v0.6.8
>          │   └── serde v1.0.210
>          ├── toml_datetime v0.6.8
>          │   └── serde v1.0.210
>          └── toml_edit v0.22.22
>              ├── indexmap v2.6.0
>              │   ├── equivalent v1.0.1
>              │   └── hashbrown v0.15.0
>              ├── serde v1.0.210
>              ├── serde_spanned v0.6.8 (*)
>              ├── toml_datetime v0.6.8 (*)
>              └── winnow v0.6.20
> 
> [1] https://docs.rs/trybuild/latest/trybuild/
> 
> [snip]
>> diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
>> index a4bc5d01ee8..c2ea22101e4 100644
>> --- a/rust/qemu-api-macros/src/lib.rs
>> +++ b/rust/qemu-api-macros/src/lib.rs
>> @@ -3,8 +3,34 @@
>>   // SPDX-License-Identifier: GPL-2.0-or-later
>>
>>   use proc_macro::TokenStream;
>> -use quote::quote;
>> -use syn::{parse_macro_input, DeriveInput};
>> +use proc_macro2::Span;
>> +use quote::{quote, quote_spanned};
>> +use syn::{
>> +    parse_macro_input, parse_quote, punctuated::Punctuated, token::Comma, Data, DeriveInput, Field,
>> +    Fields, Ident, Type, Visibility,
>> +};
>> +
>> +struct CompileError(String, Span);
>> +
>> +impl From<CompileError> for proc_macro2::TokenStream {
>> +    fn from(err: CompileError) -> Self {
>> +        let CompileError(msg, span) = err;
>> +        quote_spanned! { span => compile_error!(#msg); }
> 
> The documentation [2] says "there should be no space before the =>
> token" and that is by intention to tell that `span` is "evaluated in the
> context of proc macro" while those after the arm "in the generated
> code". Should we follow that convention (even though the extra white
> space does not impact building)?

I think it'd be a bit too much to add 18 crates (of which 2 for both 
native and non-native).

Assuming you can make it work at all (because it's a lot of crates, 
because there might be dependencies on Cargo, and because the toml crate 
changes MSRV very often), it would increase build time a lot.  Plus, the 
only time I worked with a crate that used trybuild, it tended to break a 
lot due to changes in compiler errors.

We're only adding macros for our own convenience, it's not like we're a 
general purpose crate, so we can live with the limitation.  But thanks 
for getting such a clear dep tree!

Paolo


