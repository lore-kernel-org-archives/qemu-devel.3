Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98911C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 09:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzBq8-0001Xu-9R; Mon, 31 Mar 2025 05:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tzBq6-0001Xa-6x
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 05:53:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tzBq4-00035W-Ea
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 05:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743414831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DhRlw/JorWCG2usrxkcJLBjOSMPNwSlHe5azF2Kxgi4=;
 b=MvKXKvp+IJNFCqxnIuNzhd81W02/CTinuNsqWevoUbbzIRj/YKX5m9clkjMiY0uuBVdbWp
 5aEBKsSwv9JPXNNY0EgSnsQFWAmWO3fWQilfWPhUsC6+vjTTbVOIlWl8/47JhJCWwhoo7p
 8/MFgK+Lt+gxUMK7nydbOEy+X0qGlis=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-zLpKeV-nO9-IQi0McevqIg-1; Mon, 31 Mar 2025 05:53:44 -0400
X-MC-Unique: zLpKeV-nO9-IQi0McevqIg-1
X-Mimecast-MFC-AGG-ID: zLpKeV-nO9-IQi0McevqIg_1743414823
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43bd0586a73so34576945e9.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 02:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743414823; x=1744019623;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DhRlw/JorWCG2usrxkcJLBjOSMPNwSlHe5azF2Kxgi4=;
 b=bW9a5QaDQ4T+FjPtW6cYbxOwa0rqcPKG78yBSTsK3/QPd8PAnE0X/dxIseDoepZrEF
 M95orljJYEgZbYFT/lKGVUDc8+0w9A3F4VNmRFcg6pnPoeHN7ta7327bSW5MTi3u5rF7
 mbXvRKXAFf7goxI/dpEKUnVQCIIaBW81QAGWMmDsM90OWvNdEztAUEq3K1PdHX7MQPPy
 QWk45M+Be+Q8IXNFdzpR9imRcaChSeGyQuoOrCsLy+OG+EdHf3K50Z21WGPXEWR4fAC/
 O//y06FQOQh92KHd6d9fVnHYLVlQizn2lILbwxnPaCRT9CA5qWH8XBzVpGL5DmCbs0At
 g8tA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+/0iNzqdKGlUhKHS54m/0VEzsCdV0ZIFUkN3ACf2C0PzphXy/yNHkyfrhrqTNQnJHDF0LJXYfAjMQ@nongnu.org
X-Gm-Message-State: AOJu0YwSvMNJKpo6T4BfoVwUJ30WMbsmFUTECjX0UAO7bDqhcy0I56zA
 6Bx402QK7xRnBKhcPbFBfaXMDNfeD4fcqkJPLviVdrKtVCrdgUXMO1/1IHMzcVIx8sM1tBGzqYf
 /+hR4tyH6UaFB0ewXNDeUcbF60xR7/KRlGWOhCw8NxpSeOJLmBXF4
X-Gm-Gg: ASbGncuBdW+XcfHVQyfiB5IMvR0ic2XTgiYC5Z3+PDP8eHATi3XVBvrX4e9mNbYqDUL
 uPgmKKnOX+sUf7ocDZGY8KJ2JLvwVAuZ+FRJ2d6oj+Iid+ubc1AnpqnX6iiJQlZ93F9qORcGGPt
 CcOQhNXH5qNqEnfGT62qNDFz+w39RVdzD5UYnLb1EG0KMJiMxEsImwVb+kPvpkCIMoKTLWSlYd9
 qBML9uYeS5zmA0uhjfNTnKUJt4YuHQjfxzRX5gGnFIe0RILnaRoLTIST2JJU0wRMYsiIklOBV43
 +st+5nxy1SS7MXPDkA==
X-Received: by 2002:a05:600c:1c9e:b0:43d:3df:42d8 with SMTP id
 5b1f17b1804b1-43db61e0723mr65346705e9.6.1743414822954; 
 Mon, 31 Mar 2025 02:53:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyrOQBArby7PU57iJ5lhHC8MqFdbyaOn4tTNKhhGnKey6J9zvX94ATopiFs5SChc4XBKOv7g==
X-Received: by 2002:a05:600c:1c9e:b0:43d:3df:42d8 with SMTP id
 5b1f17b1804b1-43db61e0723mr65346535e9.6.1743414822531; 
 Mon, 31 Mar 2025 02:53:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.105.0])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43d914f1561sm77988005e9.1.2025.03.31.02.53.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 02:53:42 -0700 (PDT)
Message-ID: <340649cf-9348-458d-97e7-aee73c02217c@redhat.com>
Date: Mon, 31 Mar 2025 11:53:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust/qemu-api: Add initial logging support based on C
 API
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org
References: <20250330205857.1615-1-shentey@gmail.com>
 <20250330205857.1615-2-shentey@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250330205857.1615-2-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 3/30/25 22:58, Bernhard Beschow wrote:
> A qemu_log_mask!() macro is provided which expects similar arguments as the C
> version. However, the formatting works as one would expect from Rust.
> 
> To maximize code reuse the macro is just a thin wrapper around qemu_log().
> Also, just the bare minimum of logging masks is provided which should suffice
> for the current use case of Rust in QEMU.

It's probably better to use an enum for this.  One possibility is also 
to change the #defines to a C enum, and see which enum translation of 
the several allowed by bindgen is best.

Also, while this is good for now, later on we probably want to 
reimplement logging at a lower level via the std::fmt::Write trait.  But 
that's just for efficiency and your macro is indeed good enough to 
define what the API would look like.  Right now I have a project for 
GSoC that will look at that, and the student can look into it later on.

This means answering the following two questions:

- the mapping the LOG_* constants into Rust

- whether to keep the "qemu" prefix for the API (personal opinion: no)

- whether it makes sense to add more macros such as log_guest_error! or 
log_unimp! for the most common LOG_* values

> +#[macro_export]
> +macro_rules! qemu_log_mask {
> +    ($mask:expr, $fmt:expr $(, $args:expr)*) => {{

Looking at https://doc.rust-lang.org/std/macro.write.html they just use 
$($arg:tt)* for what is passed to format_args! (or in your case 
format!), so we can do the same here too. The main advantage is that it 
allows giving a trailing comma to qemu_log_mask!.

Paolo

> +        if unsafe {
> +            (::qemu_api::bindings::qemu_loglevel & ($mask as std::os::raw::c_int)) != 0
> +        } {
> +            let formatted_string = format!($fmt, $($args),*);
> +            let c_string = std::ffi::CString::new(formatted_string).unwrap();
> +
> +            unsafe {
> +                ::qemu_api::bindings::qemu_log(c_string.as_ptr());
> +            }
> +        }
> +    }};
> +}


