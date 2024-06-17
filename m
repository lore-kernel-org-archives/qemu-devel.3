Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209C1C27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 08:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ8Cp-0003WE-1v; Mon, 17 Jun 2024 04:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sJ8Cm-0003VA-OW
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 04:59:12 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sJ8Ck-0003Bx-Sn
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 04:59:12 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4217990f997so30088555e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 01:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718614747; x=1719219547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DqF0TWomreO4lMGriyxH/EyC9Tn29dZIEEAgDnu7Cis=;
 b=AICql8UWk68TAL9pa025FxHzgXpnCZAZQqgb6tt7p0qP6oKIcaPa+SsYTwOCeLXGx3
 ztztLEBVM1oIOJCXvL+WOAVaRRN6kjHNK+awy+bC/i+WlLbTxiSudCnHFv8bjbKoZvJ6
 wNMCD2+1J+GSIVQaBRdvPk6KehYsYFu6/H01M/0dSOqlCIRAeEMXRpI6SXwD7t9tM/4z
 VU0+D9JB+fTJSS39xigL03piV/tESJWd5Cho037w8fnLhJYy8TY3fzk+8Uurn83Pl02q
 BxSJnaLcuMrm5Agu+kxYd85+l6l3bVU/CQC0QTnXjrVy7ZqlKbb0gmrILX4J5aANLjoe
 3M8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718614747; x=1719219547;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DqF0TWomreO4lMGriyxH/EyC9Tn29dZIEEAgDnu7Cis=;
 b=Plqt7inhu/YE4/GEwKZyibDCXP5YklkhrLTBu7Dw9zT6Dt6nuF6U6LVO8E6Za2tvn3
 0G955fKYgNlMz/HSHG/K9urv266b4Bq+GYM+7QEnFNzN7B4Dac5uD0HHP6HhGECL2gjT
 jUiQL705+w8lxQvCEKf4d9I786Yxwa3tmGFalXLWRRwfwaMnuD7l36ouPJ0FNTvE4QBd
 HlsGNZQnjlcGSntGmvNJbzMELvD/UsU9wLvqjFsI/PlfQtxyiUrg62szavV1OFCfqMPT
 uJO/BR6Je/o5Lz6EtSvjduP4fqaJEDr+Bwl9+VO73lQ9XLiDGgP3pb5sScIywv/Uft87
 5Wuw==
X-Gm-Message-State: AOJu0YxVBlf78QW/1Do9J/XLVyq/QPvgMEHiQYjgTB3ShKRVLTwAs73g
 qnQlv7s66is+WoYqZldfUqM8taRBMzhF9wlNtSrEbhvZYWSK+feIisWt/zWCZ5wWoTHunFR+i5P
 Tt6g=
X-Google-Smtp-Source: AGHT+IHWda3VGPOEIzOrYC4OZpR9wVaR7bEF2iP4FGKrxvOj4AM1MUIaoovF5Z8n0ynanHuhVvOyag==
X-Received: by 2002:a05:600c:1f8d:b0:422:70d4:7e96 with SMTP id
 5b1f17b1804b1-4230481fac0mr73405985e9.15.1718614747048; 
 Mon, 17 Jun 2024 01:59:07 -0700 (PDT)
Received: from meli-email.org (adsl-33.109.242.225.tellas.gr. [109.242.225.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-423072c21dbsm110994045e9.4.2024.06.17.01.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 01:59:06 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:45:55 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Alex Benn=?UTF-8?B?w6k=?= e" <alex.bennee@linaro.org>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
 <CABgObfY8BS0yCw2CxgDQTBA4np9BZgGJF3N=t6eoBcdACAE=NA@mail.gmail.com>
 <ez270.x96k6aeu0rpw@linaro.org> <ZmnHoajecti472mi@redhat.com>
 <ezjl0.qx0tmsp6d6t@linaro.org>
 <CABgObfbGwKc0RYBcDPzNkE8HOSouFj4D15Oh7TuiKOC+D7raaA@mail.gmail.com>
 <ZmqcFf0xB9m4WkA3@redhat.com>
 <CABgObfb4+FSsadFTVg6Dc1zehQV2Vei2_kSRd5CfxsGBLPN6Eg@mail.gmail.com>
 <Zmq47yQV-sQ0hGMy@redhat.com>
 <CABgObfYaxBxc8GS3=YU=EwNLEihEoD4ikZ595P4m_KTZCAAaBw@mail.gmail.com>
 <f26b0.f15017t08v16@linaro.org>
 <CABgObfaYUCU0Tj-jj66n8AaxOpqXFKcQA-E6G0W6q3MjjwQkiQ@mail.gmail.com>
In-Reply-To: <CABgObfaYUCU0Tj-jj66n8AaxOpqXFKcQA-E6G0W6q3MjjwQkiQ@mail.gmail.com>
Message-ID: <f7vmg.s9przvzs9y9y@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 14 Jun 2024 20:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
>On Fri, Jun 14, 2024 at 9:04 AM Manos Pitsidianakis
><manos.pitsidianakis@linaro.org> wrote:
>>
>> On Thu, 13 Jun 2024 23:57, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> >On Thu, Jun 13, 2024 at 11:16 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
>> >> I guess there's a balance to be had somewhere on the spectrum between doing
>> >> everything against the raw C binding, vs everything against a perfectly
>> >> idiomatic Rust API wrapping the C bniding. The latter might be the ideal,
>> >> but from a pragmmatic POV I doubt we want the barrier to entry to be that
>> >> high.
>> >
>> >Yes, I agree. I guess we could make things work step by step, even
>> >committing something that only focuses on the build system like
>> >Manos's work (I'll review it).
>> >
>> >I can try to look at the basic QOM interface.
>> >
>> >Manos, can you create a page on the wiki? Something like
>> >https://wiki.qemu.org/Features/Meson.
>>
>>
>> Certainly! Just to make sure I understood correctly, you mean a wiki
>> page describing how things work and tracking the progress?
>>
>> I added https://wiki.qemu.org/Features/Meson/Rust
>
>I moved it to https://wiki.qemu.org/Features/Rust/Meson :) and wrote
>https://wiki.qemu.org/Features/Rust/QOM. I got to the point where at
>least this compiles:
>
>qdev_define_type!(c"test-device", TestDevice);
>impl ObjectImpl for TestDevice {}
>impl DeviceImpl for TestDevice {}
>
>fn main() {
>    let d = TestDevice::new();
>    d.cold_reset();
>}
>
>Of course the code makes no sense but it's a start.

Let's not rush into making interfaces without the need for them arising 
first. It's easy to wander off into bikeshedding territory; case in 
point, there has been little discussion on the code of this RFC and much 
more focus on hypotheticals.

For what it's worth, in my opinion looking at glib-rs for inspiration is 
a bad idea, because that project has to support an immutable public 
interface (glib) while we do not.

There's more to discuss about this topic which I am open to continuing 
on IRC instead!

-- Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

>
>One thing that would be very useful is to have an Error
>implementation. Looking at what Marc-André did for Error*
>(https://patchew.org/QEMU/20210907121943.3498701-1-marcandre.lureau@redhat.com/20210907121943.3498701-13-marcandre.lureau@redhat.com/),
>his precise implementation relies on his code to go back and forth
>between Rust representation, borrowed C object with Rust bindings and
>owned C object with Rust bindings. But I think we can at least have
>something like this:
>
>// qemu::Error
>pub struct Error {
>    msg: String,
>    /// Appends the print string of the error to the msg if not None
>    cause: Option<Box<dyn std::error::Error>>,
>    location: Option<(String, u32)>
>}
>
>impl std::error::Error for Error { ... }
>
>impl Error {
>  ...
>  fn into_c_error(self) -> *const bindings::Error { ... }
>}
>
>// qemu::Result<T>
>type Result<T> = Result<T, Error>;
>
>which can be implemented without too much code. This way any "bool
>f(..., Error *)" function (example: realize :)) could be implemented
>as returning qemu::Result<()>.

