Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2EBC3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 16:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQrCD-0000NL-JY; Mon, 08 Jul 2024 12:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sQrCB-0000MZ-90
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:26:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sQrC8-0003lP-Mw
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720455987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Yp/7NQw/QhSR68AfLaacTywP2orjOaqNXi6RKnqFERI=;
 b=c8UAklnk5OLYz1sDjmWWPt6XscAPIYWMKK/VVXxcjEo6xsCITKuHvjDUbqiaCfvvxFWcV0
 DSikfrQfUgq95KdBvHE5mfU/l5cFvDUNWndjsummhV8ajwavxDRY8DgUL+dTFPrvzl3OF1
 maTELm8Eu0W77JO1QDReHNVzPixFlJE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-eg88OycDM-emRQiz5Sg2Rg-1; Mon, 08 Jul 2024 12:26:26 -0400
X-MC-Unique: eg88OycDM-emRQiz5Sg2Rg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42666ed2d5fso10649625e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 09:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720455985; x=1721060785;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yp/7NQw/QhSR68AfLaacTywP2orjOaqNXi6RKnqFERI=;
 b=SmPbxLzODI84mhjfmIygypYapcX31ZmzC29GDCyhE9GV+dTBM8kRQqcSMIvEZtA5YE
 M0NVH7qoRrot7BCxVEpwEQWxbExV0ZRxM0PrJqJJUEptHWHXzBn86Bz3f/az6+yKzJEg
 Iy0rWVu/c/n1Ko56Tw/9+MRcldv35z2Yh/WaeYVl1Ne5W5tRR3GL/AYYNJOaG0QDKQmu
 wjnQD4KFGeeODTEJxT+931pPfrN8IwxhSC9RLz361doabcncCRwgxuczzjoQ+xQsnN8N
 j0bjRimQc4lYWP5mliobZ0fMwCxnLtcm3Yx2MrRBTm30gko7yYcJC4FLY+S85QTiVHjE
 YAbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPmjBKtHtBh133MyEA45a1mh89Cp7ic7LJDvqFhbJT6xbljc7OwN+gdY7/fZGO7gjl5mQ0dhiAuSaUgjO7MUa2nzz0cxM=
X-Gm-Message-State: AOJu0Yz7AHXVLnuLusQ6vOv+1f3m3GjWP3h3our3nWCdFh8XSMXf1vF7
 ebVyOEgNeZZzIPs3xWF2wrSsU9N6LewbMAfHMUiEVw60UqZQzFwZgQyJ+hCAN5DD8q8IipxbnBa
 tBk1PeoigZ4n4E4chQUezq40XdCAEHmhoK65YpL25LFxEeAlZ7/gU
X-Received: by 2002:a05:600c:70a:b0:426:6320:226a with SMTP id
 5b1f17b1804b1-426707db6f3mr683725e9.15.1720455985169; 
 Mon, 08 Jul 2024 09:26:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGur3ryyTSiv9+2foSA2FaaUiqyE/kybgsJhLV5/knkdycG5DjQOhGuRpR9qSkMDM5bQd9SoQ==
X-Received: by 2002:a05:600c:70a:b0:426:6320:226a with SMTP id
 5b1f17b1804b1-426707db6f3mr683535e9.15.1720455984808; 
 Mon, 08 Jul 2024 09:26:24 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.101.29])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4266e861339sm18678105e9.12.2024.07.08.09.26.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 09:26:24 -0700 (PDT)
Message-ID: <8dfd1047-436d-4157-83cb-9cad399544fe@redhat.com>
Date: Mon, 8 Jul 2024 18:26:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 0/7] Add Rust support, implement ARM PL011
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/4/24 14:15, Manos Pitsidianakis wrote:
> Changes from v3->v4:
> - Add rust-specific files to .gitattributes
> - Added help text to scripts/cargo_wrapper.py arguments (thanks Stephan)
> - Split bindings separate crate
> - Add declarative macros for symbols exported to QEMU to said crate
> - Lowered MSRV to 1.77.2
> - Removed auto-download and install of bindgen-cli
> - Fixed re-compilation of Rust objects in case they are missing from
>    filesystem
> - Fixed optimized builds by adding #[used] (thanks Pierrick for the help
>    debugging this)

I think the largest issue is that I'd rather have a single cargo build 
using a virtual manifest, because my hunch is that it'd be the easiest 
path towards Kconfig integration.  But it's better to do this after 
merge, as the changes are pretty large.  It's also independent from any 
other changes targeted at removing unsafe code, so no need to hold back 
on merging.

Other comments I made that should however be addressed before merging, 
from most to least important:

- TODO comments when the code is doing potential undefined behavior

- module structure should IMO resemble the C part of the tree

- only generate bindings.rs.inc once

- a couple abstractions that I'd like to have now: a trait to store the 
CStr corresponding to the structs, and one to generate all-zero structs 
without having to type "unsafe { MaybeUninit::zeroed().assume_init() }"

- I pointed out a couple lints that are too broad and should be enabled 
per-file, even if right now it's basically all files that include them.

- add support for --cargo and CARGO environment variables (if my patch 
works without too much hassle)

- I'd like to use ctor instead of non-portable linker magic, and the 
cstr crate instead of CStr statics or c""

- please check if -Wl,--whole-archive can be replaced with link_whole:

- probably, until Rust is enabled by default we should treat 
dependencies as a moving target and not commit Cargo.lock files.  In the 
meanwhile we can discuss how to handle them.

And a few aesthetic changes on top of this.

With respect to lints, marking entire groups as "deny" is problematic. 
Before merge, I'd rather have the groups as just "warn", and add a long 
list of denied lints[1].  After merge we can also add a non-fatal CI job 
that runs clippy with nightly rust and with groups marked as "deny". 
This matches the check-python-tox job in python/.

[1] https://github.com/bonzini/rust-qemu/commit/95b25f7c5f4e

Thanks,

Paolo


