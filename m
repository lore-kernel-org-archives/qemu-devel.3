Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B88C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 10:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWvUs-0001HT-Qz; Thu, 25 Jul 2024 06:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sWvUr-0001Be-D3
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:14:53 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sWvUp-0007qX-CX
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:14:53 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52f008aa351so878301e87.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 03:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721902489; x=1722507289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4JTpE/CHLjoamQZwUeX9uxDRoS3ZPI7VpKNBBjyC7Ak=;
 b=D6cTwjMAQv3yeG3KMMxx1kPq7LlN5Yl9yqXk4d7Nk4Yxzm4BAhkpOUx5ppN1s/qaPK
 9aUmO9czrKm5pqiaHZ6/4pcHs4F0Thpb9ev4iV+TsOyPCjVZT9lOgKVkjQz1Dt9FvInN
 5kt8gwUkpusykRUfckkSg4CMODbg4tqpAujZTvcIuLd7YjC6i4y+CEgRPEJTCIWvJvNt
 9QWkHcaHcG1oXpZEzOO3FdCYH6j3+PYmuv1ZOKAxGG4BKbOhVSBIBjWp695E52qtgH/d
 n4mLdlX3ehLowkiDwUDmYg9y7iaoMYZTT44r3BPzb5XJRbTFwoOMOVuUyqkGyKEvfFhT
 VPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721902489; x=1722507289;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4JTpE/CHLjoamQZwUeX9uxDRoS3ZPI7VpKNBBjyC7Ak=;
 b=BDnurl3qJgZddXdIZKrsDEhvtBubwY0q9ESXI7Za+UcWk4+diAFs5MqtDuZN9Y6ls8
 oCQ/iGJ4d3Qv1Llgaapjy1bzJr5hkNImqY2UXiyGUiPag09oqJvplLzmCBc3xZDc46r9
 oSUCZnOJbAIWqeppUn/OUHPeb2WOuyS0yca97FHG9lYL1uTz1qyVGriV09w6zSVWjYsZ
 i1YNtpp/NkA6WZx63eDjcwpoc8jtvRQwO94+21eMUGk3ob1R1GB1xxvOx9gdncc6ImB1
 t0b5TppgtcQ2v3+dQ13wTvoUP5mc1oXKwsN4fkcyQCDORC7A/14otBQBl8Mq1EWK+Xgu
 Ml6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpHPfdHneCTsH2ZCnOP3GKaAsHq+rlXmo4cbsbWySWS4kg0HaE63aUia7rbM7jCX1XNoBj6lQrd38SmdW2NwinbvXPA/Y=
X-Gm-Message-State: AOJu0YwjAsV8fn+QiFatSkKyh5BqPyckq2H6nIZfK8Ti7Rszds8/lfWx
 Z/wgVP8roD1jhCeSOP7oKyuXk94eVuW+rdR3U2+p2FqjmpKauJbqhT2JxS/2sM8=
X-Google-Smtp-Source: AGHT+IG4E4DiAJg4V4Tnjza3UFmSEWHNrb0ME+UOaLmZvObxERMzER01ZeVN+PslqbhbJXC3N+m7Vw==
X-Received: by 2002:ac2:51cc:0:b0:52e:9d60:7b4c with SMTP id
 2adb3069b0e04-52fd60a1de9mr1173642e87.61.1721902488753; 
 Thu, 25 Jul 2024 03:14:48 -0700 (PDT)
Received: from meli-email.org (adsl-231.37.6.1.tellas.gr. [37.6.1.231])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab233aasm56922466b.8.2024.07.25.03.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 03:14:48 -0700 (PDT)
Date: Thu, 25 Jul 2024 13:02:25 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qeemu-devel@nongnu.org, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6kg?=e <alex.bennee@linaro.org>,
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
 <h4gxy.dr366knvycy@linaro.org>
 <CABgObfZOqBogWQtzfghjKMsW-J_sp-iL5dt7mmYnvE5eQb9G5w@mail.gmail.com>
 <h61ku.ipxyjqsxu75@linaro.org>
 <CABgObfa-dxDD_oVGu8PrQffVhvP=MFifUUTinC-brzTnqdkK0A@mail.gmail.com>
In-Reply-To: <CABgObfa-dxDD_oVGu8PrQffVhvP=MFifUUTinC-brzTnqdkK0A@mail.gmail.com>
Message-ID: <h6cgm.o8scn84hx1ry@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x133.google.com
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

On Thu, 25 Jul 2024 12:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
>Il gio 25 lug 2024, 08:19 Manos Pitsidianakis <
>manos.pitsidianakis@linaro.org> ha scritto:
>
>> >(before the call to qemu_chr_fe_accept_input):
>> >// TODO: this causes a callback that creates another "&mut self".
>> >// This is forbidden by Rust aliasing rules and has to be fixed
>> >// using interior mutability.
>>
>> You mean that we can have a call stack that looks something like...
>>
>> <qemu code>
>> |_ pl011_read
>>   |_ PL011State::read()
>>      |_ qemu_chr_fe_accept_input()
>>       |_ pl011_read
>>         |_ PL011State::read()
>>
>> If I understand correctly, this does not create another "&mut self",
>> because a mutable reference of self is passed to
>> qemu_chr_fe_accept_input(), and only exists until it returns.
>>
>
>Unfortunately that's a *mut, not a &mut. A &mut must be unique, so the cast
>in pl011_read() is undefined behavior.

Actually it's:

  unsafe { qemu_chr_fe_accept_input(&mut self.char_backend) };

And you can ensure there's no disjoint borrowing by making a wrapper 
function that mutably borrows self, e.g.

fn accept_input(&mut self) {
  unsafe { qemu_chr_fe_accept_input(&mut self.char_backend) };
}

This is not undefined behavior, since the cast in pl011_read creates a 
mutable reference that does not outlive the same call to pl011_read.


>
>In any case, I agree that these subtleties must be examined thoroughly
>> in general. In this case though PL011State has only Copy fields and no
>> side effects when dropped. This means that adding interior mutability
>> e.g. with Cell would have exactly the same behavior.
>>
>
>If you add interior mutability you can operate on a &self; and then
>creating the &mut (via either Cell or RefCell) from the callback is legal.
>
>But your bringing it up makes me wonder whether we can detect any bad
>> behaviors with miri... It does not play well with FFI boundaries but
>> it's possible to mock them in some cases. I will look into the two TODOs
>> you mention and also if it's possible to verify the correct behavior
>> whenever possible!
>>
>
>The most robust way is to write proper bindings to QEMU APIs that enforce
>use of shared references. That will take time; but we'll get there, for now
>it's important just to point out the problem.

Please demonstrate a scenario where said problem shows up, otherwise 
it's just hand-waving on a undefined (pun intended ;) ) hypothetical.

>
>
>> >> >❌ a trait to generate all-zero structs without having to type "unsafe {
>> >> >MaybeUninit::zeroed().assume_init() }"
>> >>
>> >> Traits cannot have const fns at the moment (traits cannot have
>> >> type-level effects like const or async but it's WIP to get them into
>> >> rustc), so this cannot be used for statics and consts.
>> >
>> >Ah, I see. Anyhow, I've been looking at the Linux kernel's pinned-init
>> >crate (https://rust-for-linux.com/pinned-init) and it provides a
>> >Zeroable macro including #[derive] support. So that has gone lower in
>> >my priority.
>> >
>> >> >❌ I'd like to use ctor instead of non-portable linker magic,
>> >>
>> >> The linker sections are pretty much standard and in fact ctor uses the
>> >> same linker attributes. Would writing our own constructor macro be a
>> >> solution for you? My reasoning is that 1) we support our own specific
>> >> platforms and it's better for portability to reflect that in our source
>> >> tree and 2) it avoids the external dependency, linker sections do not
>> >> change so any ctor update would be in the API or adding more platform
>> >> support,  not fixes in what we target.
>> >
>> >I'd still like to give someone else the burden. :) Writing our own
>> >constructor macro would be more work for little gain.
>>
>> Well, it's just that I personally don't view adding __attribute__
>> manually in only two places is a burden but I've no strong preference
>> over it.
>>
>> I'm looking at the ctor dependencies and they are a few:
>>
>> https://github.com/mmastrac/rust-ctor/blob/cc3ab9160ed9dc3bdf20d735352b519abc2913e9/Cargo.lock
>>
>> Do you perhaps agree with adding a FIXME comment to replace the linker
>> attributes with ctor when we get the cargo dependency story in meson
>> sorted out?
>>
>
>Yes, that's fine.

Thanks! We also have to keep in mind we would like Debian to be able to 
package this, so we should be very conservative on what dependencies we 
use.

>
>Paolo
>
>Manos
>>
>>

