Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D34C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 14:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJCxr-0007Ob-Ps; Mon, 17 Jun 2024 10:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sJCxr-0007NL-3h
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:04:07 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sJCxo-0008Bo-S6
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:04:06 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-356c4e926a3so4142290f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 07:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718633043; x=1719237843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=upwh+9aX960hm0pe0J+pkloZdzlqSBfkZTlA0IWgaRY=;
 b=XZ70hq79ANYkqct5XatUekItKd07h5HgGWxyRwlGAmNduWJgnZPavI3oima6tdtvrg
 mMJt9RCQsnpP8Wbzluvu82ghfmfw8akZLYsYIH8Y4QnmFCLMvmWoVY6q14373hG5pyXe
 rHsq5AXORvCtV49F6mIljeA8FfikrBOfVnGAUJry8zDoKIGaeeWUwcSRiySFpfJaqDc2
 D9uZoIfUNBmwez2Ju7W+1B9mNQ1rwvGHxtZ0NnMfBXC7By1RD/F5RblTZ0AF9pepo1Q+
 XILWrKITLiB+/5tIqW0hbuPy7LluD46HkfHcVTpkK1SYlZz3J6n8LKufjxz81M5cyD3x
 vqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718633043; x=1719237843;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=upwh+9aX960hm0pe0J+pkloZdzlqSBfkZTlA0IWgaRY=;
 b=Brkg2KCQr32TyZ2zlbXiCamn+3DJLT/t4yXAU2Vlf5txDCB115vTKigAVclSERGL5u
 YZXzYD/WLgb8bnldSQtE6sRTOmzAlpMGXhY+PGLgF5IiEOBUH8BlkNIIugpDQ2j7P8sT
 f/+YsK1kpBZDaVsvtv+GUfNNhCKqKGmqqhNg9/Z45nSO016GS7AOoDCQc3GioL/NbkWw
 6ZWDZMkYBdrF5UokVdwbF9s+lEqNXx7OY946p6TfUBiK0nLJYbK8k8o4MnPzJ4Rp9+mt
 3GuFoniepFJ0HlO7tEv9o9cyy1GfipSp5hDKkhlUSLzcCpgfoeuHxSgyDGc7TTM+YXoU
 Bfvg==
X-Gm-Message-State: AOJu0YyJ7e0zmKBaDz5iQIFmbY1echVbXVROkikd0/nxLgHO246nE8TY
 7A+JeIyvTA+F/JAW1E3qLlSfLQO/YFE3QVL9l+Mnc3WP5iEkZ7Lpvi/+4ZHaThQ=
X-Google-Smtp-Source: AGHT+IFfEtks9aXyz4s+Su2vNp4YhtyRRRhAYYuMLRfROsY3Lka7iChIblqJKMNiNHlz6VfQNewU5g==
X-Received: by 2002:adf:cd8c:0:b0:360:791c:aff0 with SMTP id
 ffacd0b85a97d-3607a72039cmr7195011f8f.8.1718633043001; 
 Mon, 17 Jun 2024 07:04:03 -0700 (PDT)
Received: from meli-email.org (adsl-33.37.6.162.tellas.gr. [37.6.162.33])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750ad082sm11811656f8f.59.2024.06.17.07.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 07:04:02 -0700 (PDT)
Date: Mon, 17 Jun 2024 16:54:11 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6kg?=e <alex.bennee@linaro.org>,
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
 <f7vmg.s9przvzs9y9y@linaro.org>
 <CABgObfayPDfcrFJ5ckFFms_raD25ARFEvLNhP1qLmda_rjrLfg@mail.gmail.com>
In-Reply-To: <CABgObfayPDfcrFJ5ckFFms_raD25ARFEvLNhP1qLmda_rjrLfg@mail.gmail.com>
Message-ID: <f89qp.6kmlv39qhntz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42c.google.com
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

On Mon, 17 Jun 2024 14:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
>Il lun 17 giu 2024, 10:59 Manos Pitsidianakis <
>manos.pitsidianakis@linaro.org> ha scritto:
>
>> >qdev_define_type!(c"test-device", TestDevice);
>> >impl ObjectImpl for TestDevice {}
>> >impl DeviceImpl for TestDevice {}
>> >
>> >fn main() {
>> >    let d = TestDevice::new();
>> >    d.cold_reset();
>> >}
>> >
>> >Of course the code makes no sense but it's a start.
>>
>> Let's not rush into making interfaces without the need for them arising
>> first. It's easy to wander off into bikeshedding territory; case in
>> point, there has been little discussion on the code of this RFC and much
>> more focus on hypotheticals.
>>
>
>I see your point but I think it's important to understand the road ahead of
>us.
>
>Knowing that we can build and maintain a usable (does not have to be
>perfect) interface to QOM is important, and in fact it's already useful for
>the pl011 device's chardev. It's also important to play with more advanced
>usage of the language to ascertain what features of the language will be
>useful; for example, my current implementation uses generic associated
>types which are not available on Debian Bookworm—it should be easy to
>remove them but if I am wrong that's also a data point, and an important
>one.
>
>Don't get me wrong: *for this first device* only, it makes a lot of sense
>to have a very C-ish implementation. It lets us sort out the build system
>integration, tackle idiomatic bindings one piece at a time, and is easier
>to review than Marc-André's approach of building the whole QAPI bindings.
>But at the same time, I don't consider a C-ish device better just because
>it's written in Rust: as things stand your code has all the disadvantages
>of C and all the disadvantages of Rust. What makes it (extremely) valuable
>is that your code can lead us along the path towards reaping the advantages
>of Rust.

I respectfully disagree and recommend taking another look at the code.

The device actually performs all logic in non-unsafe methods and is 
typed instead of operating on raw integers as fields/state. The C stuff 
is the FFI boundary calls which you cannot avoid; they are the same 
things you'd wrap under these bindings we're talking about.

QEMU calls the device's FFI callbacks with its pointer and arguments, 
the pointer gets dereferenced to the actual Rust type which qemu 
guarantees is valid, then the Rust struct's methods are called to handle 
each functionality. There is nothing actually unsafe here, assuming 
QEMU's invariants and code are correct.

>
>I think we're actually in a great position. We have a PoC from Marc-André,
>plus the experience of glib-rs (see below), that shows us that our goal of
>idiomatic bindings is doable; and a complementary PoC from you that will
>guide us and let us reach it in little steps. The first 90% of the work is
>done, now we only have to do the second 90%... :) but then we can open the
>floodgates for Rust code in QEMU.
>
>For what it's worth, in my opinion looking at glib-rs for inspiration is
>> a bad idea, because that project has to support an immutable public
>> interface (glib) while we do not.
>>
>
>glib-rs includes support for GObject, which was itself an inspiration for
>QOM (with differences, granted).
>
>There are a lot of libraries that we can take inspiration from: in addition
>to glib-rs, zbus has an interesting approach to
>serialization/deserialization for example that could inform future work on
>QAPI. It's not a coincidence that these libraries integrate with more
>traditional C code, because we are doing the same. Rust-vmm crates will
>also become an interesting topic sooner or later.
>
>There's more to discuss about this topic which I am open to continuing
>> on IRC instead!
>>
>
>Absolutely, I will try to post code soonish and also review the build
>system integration.
>
>Thanks,
>
>Paolo
>
>
>> -- Manos Pitsidianakis
>> Emulation and Virtualization Engineer at Linaro Ltd
>>
>> >
>> >One thing that would be very useful is to have an Error
>> >implementation. Looking at what Marc-André did for Error*
>> >(
>> https://patchew.org/QEMU/20210907121943.3498701-1-marcandre.lureau@redhat.com/20210907121943.3498701-13-marcandre.lureau@redhat.com/
>> ),
>> >his precise implementation relies on his code to go back and forth
>> >between Rust representation, borrowed C object with Rust bindings and
>> >owned C object with Rust bindings. But I think we can at least have
>> >something like this:
>> >
>> >// qemu::Error
>> >pub struct Error {
>> >    msg: String,
>> >    /// Appends the print string of the error to the msg if not None
>> >    cause: Option<Box<dyn std::error::Error>>,
>> >    location: Option<(String, u32)>
>> >}
>> >
>> >impl std::error::Error for Error { ... }
>> >
>> >impl Error {
>> >  ...
>> >  fn into_c_error(self) -> *const bindings::Error { ... }
>> >}
>> >
>> >// qemu::Result<T>
>> >type Result<T> = Result<T, Error>;
>> >
>> >which can be implemented without too much code. This way any "bool
>> >f(..., Error *)" function (example: realize :)) could be implemented
>> >as returning qemu::Result<()>.
>>
>>

