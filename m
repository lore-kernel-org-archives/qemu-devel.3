Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7FAC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 09:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWYjf-0006rz-5U; Wed, 24 Jul 2024 05:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sWYjV-0006Sf-P8
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:56:30 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sWYjS-0005g2-Ea
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:56:29 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4266ed6c691so44146095e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 02:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721814984; x=1722419784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=R0uaSLeh8Ndx6W8ExR39bJlyc1ekS1xMvJDU+9hvJUk=;
 b=p0T7MVWqXBVsqw/ydSvYbBSXLjpKa0wqT7I0oFruVkW8wvNnJnkpDcT7tjxL/xZf/g
 6BWHH2HN98tnnfksEVPbBBDUVSuGVaszr/9bvL9ZkSwH0jxq4lTt0b6VFxiQ8kilNKUH
 wj1fEUvwM0NT0S3uaslyuH6lUJD/mJTBbIOgzuM9DE3nSLg3UR0aj6gi8A/BQZJBjfSg
 KRkPWbPEN7E1XHJjRBLDKKiGGDEMb3j0mf99zvRAeaC4pd4GbHstFa945PMxMKlIASFI
 hoDHn9qWkjj3+IBccigmNj8VQHYkbcdpwpwolqsJ2eZa5AvhyzHYNt9iqO7pWYxGlDi/
 DFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721814984; x=1722419784;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R0uaSLeh8Ndx6W8ExR39bJlyc1ekS1xMvJDU+9hvJUk=;
 b=k+eTiZ1x+Pn4Ad9k5owEuBcGKwqGCWeuOvyYal12nhOaZ03IIYKg85AbEpyn2O1Ss5
 21bRCEPX/0I2FPmEewCt1YRryMMcpQndFlUd/eViZZ9LV89buUOT0JV4PWELYeXW5dgx
 6i4InjxAi5Zr2LjvGOSgikUp8cPf8koAw2fujdjg/bjYavJFCKXZTHD4x0thNJcGZDWk
 +TYwzTt5ouhguAJAWWKDaT+kE1t0M6c3PeZ4fBxwY0io0owhf4WDRURGTviO+lZunY+6
 cG4SYJUeigN2bE6uUlnROjCNKCNL+uWgwJ3QFemGdpYY8VffuLeaD9L9WyVY7XO81yIg
 deaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnf/9JOzj+P6FCXV1qHpnCXNYZ7Nte9A3Un8SSowlLSqimyFTy7jeWr92f65qNKP1vd59zgjAe8le68hRQtkyqnKaBL4I=
X-Gm-Message-State: AOJu0Yw4s5CQvOXbpgJvaqY8Yzr1VKWJtC4fn/NC5uVngMWg5gxePCf0
 u9+NaQfNhZ45QgGKJce/4dCnPIQTaJrDT6o1LGfA1XccYdAT4WLvG9rDtTtpu3U=
X-Google-Smtp-Source: AGHT+IEdJTvhPLmOsHoKxgDOX4FseW61WaUhPfLm7gf+Uj7MwSgK8reWZpqzxOsOf1/d2c2wtCOOIw==
X-Received: by 2002:a05:600c:190d:b0:426:5dd0:a1fc with SMTP id
 5b1f17b1804b1-427f95b7144mr10066005e9.34.1721814984197; 
 Wed, 24 Jul 2024 02:56:24 -0700 (PDT)
Received: from meli-email.org (adsl-255.109.242.224.tellas.gr.
 [109.242.224.255]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f93e605esm22320135e9.34.2024.07.24.02.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 02:56:23 -0700 (PDT)
Date: Wed, 24 Jul 2024 12:14:17 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH v5 0/8] Add Rust support, implement ARM PL011
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
 <bc27a983-f0b7-4803-96f7-060a4a331348@redhat.com>
In-Reply-To: <bc27a983-f0b7-4803-96f7-060a4a331348@redhat.com>
Message-ID: <h4gxy.dr366knvycy@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hello Paolo, thank you for the thorough response,

On Tue, 23 Jul 2024 18:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
>On 7/22/24 13:43, Manos Pitsidianakis wrote:
>> Changes from v4->v5:
>> - Added CI patch from Alex Benee
>> - Removed all cargo use, use meson rust support
>> - Added Kconfig logic
>
>The following requests from the v4 review have also been evaluated (good!):
>
>✅ module structure should resemble the C part of the tree

To expand on this, I tried really hard to make the rust code live along 
the c files, but given that the bindings depend on various headers that 
are only gathered in the common source set in meson by the time all the 
subdirs are evaluated, it results in the Rust device being dependendant 
on a meson target (bindings_rs) that cannot be declared yet.

It's kind of a code smell, ideally we should not use bindgen for QEMU 
internal headers but update bindings along with the C headers (with 
extra tests to ensure definitions and layout match). Not for this 
patchset, but something to keep in mind.

>
>✅ only generate bindings.rs.inc once
>
>✅ a couple lints are too broad and should be enabled per-file. (though 
>there are still some issues with duplication of lints, I consider this 
>mostly done)
>
>✅ please check if -Wl,--whole-archive can be replaced with link_whole 
>(as discussed on IRC, unfortunately it cannot)
>
>
>The hot point here is how to handle dependencies.  I appreciate that you 
>found a way to avoid repeated building of dependent crates, and to 
>integrate with Kconfig, but at the same time this is a huge change which 
>in my opinion is premature.
>
>For example if we can (sooner or later) use the automatic Cargo 
>subprojects, we do not need any vendoring and we can use cargo in the 
>meanwhile (we can drop --cargo and CARGO at any point, just like we 
>dropped --meson and --sphinx-build in QEMU 8.1).
>
>On the other hand, committing to using meson's "raw" (meson.build-level) 
>rust support and vendoring everything is premature in my opinion is very 
>different for people who are already comfortable with Cargo, so it makes 
>it harder to add new dependencies.  In fact, because the huge patch 8 
>did not reach the mailing list, it's really hard to understand what's 
>going on, what had to be done by hand and what is done automatically by 
>meson.

I agree. I personally prefer using meson wraps and fetch the 
dependencies via network to be honest. While also providing Cargo.toml 
and Cargo.lock manifests for developers.

>
>In my opinion we should start with cargo workspaces as the 
>known-imperfect (but good enough) solution, so that it could be evolved 
>later.  It is important that any change that deviates from common Rust 
>conventions is documented, and v4 provided a nice basis to build upon, 
>with documentation coming as things settle.  This is why I explicitly 
>didn't include Kconfig in the TODO list in my review of v4.

After working with the latest meson releases, it seems we will soon have 
a good enough way of handling all this with meson. It makes me sceptical 
of adding cargo wrappers and using a build system out of meson when we 
might be able to drop all that soonish. We might as well bite the bullet 
now to avoid working on something we know we will remove. It's not that 
of a clear-cut decision, so I'd like feedback on this. What do you 
think?

>
>>   .../vendor/arbitrary-int/.cargo-checksum.json |    1 +
>
>In any case, vendoring should not be done inside hw/char/pl011.
>
>Also, of the code changes (as opposed to the build system changes) that 
>I had asked for in the review of v4, almost none of them have been 
>applied.  I'm copying them here for future reference:

Thanks, this helps a lot.

>
>❌ TODO comments when the code is doing potential undefined behavior

Do you mean like Rust's safety comments?

https://std-dev-guide.rust-lang.org/policy/safety-comments.html

These can be required by lints which is really helpful. At this point 
the UART library has safety comments (which needs to be reviewed for 
validity). I plan on adding some at the macros in qemu-api as well.

>
>❌ a trait to store the CStr corresponding to the structs

I don't know yet if that is helpful in our usecase, because the strings 
must be visible from C, thus be (rust, not c) statics, unmangled and 
marked as #[used] for the linker. It makes sense from the Rust POV but 
must also be FFI-accessible.

>
>❌ a trait to generate all-zero structs without having to type "unsafe { 
>MaybeUninit::zeroed().assume_init() }"

Traits cannot have const fns at the moment (traits cannot have 
type-level effects like const or async but it's WIP to get them into 
rustc), so this cannot be used for statics and consts.

>
>❌ I'd like to use ctor instead of non-portable linker magic,

The linker sections are pretty much standard and in fact ctor uses the 
same linker attributes. Would writing our own constructor macro be a
solution for you? My reasoning is that 1) we support our own specific 
platforms and it's better for portability to reflect that in our source 
tree and 2) it avoids the external dependency, linker sections do not 
change so any ctor update would be in the API or adding more platform 
support,  not fixes in what we target.

>and the cstr crate instead of CStr statics or c""

Oh yes, the c"" literals must be replaced. The cstr! macro is the same, 
semantically, can you explain what you mean by "CStr statics"?

>
>If you have a tree that I can look at, to understand more of patch 8, 
>please send a pointer.  However, honestly I am not comfortable with the 
>build system integration as done in this patch.

Ah forgot to mention it in the cover letter, everything is under the 
rust-pl011-rfc-v5 tag here: 

https://gitlab.com/epilys/rust-for-qemu/-/tree/rust-pl011-rfc-v5?ref_type=tags

>
>My suggestion is to do one of the following, or both:
>
>- start from this version; try using Cargo subproject support in 1.5.0 
>and see if it works, so that vendoring can be dropped.  We can require 
>Meson 1.5.0 to work on Rust support.  In this case it's okay not to do 
>any further code changes (the four that were marked ❌ above).

This is my preference as stated above, if everyone also agrees.
>
>- go back to the build system integration of v4, and do *only* the 
>changes that were requested during review (in this case, all of them 
>except link_whole, with you checked it does not work).
>
>If you try using Cargo subproject support, please provide the running 
>time for configure and make, for both "v4" and "v5+subproject".  When I 
>tried it, the processing of the subprojects was very slow.

Hmmm thanks for mentioning that, I did not notice any slow times 
locally. Will check.

Thanks!
Manos

