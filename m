Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61254C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 11:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGzsv-0004Ty-R2; Tue, 11 Jun 2024 07:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGzst-0004Sn-EQ
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 07:41:51 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGzso-0007cT-KX
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 07:41:51 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4210aa00c94so46822235e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 04:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718106103; x=1718710903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=oUuskHTs0HEYkF7RkD+pPZbSexrfbPpOgamc621TLvc=;
 b=neB9F4FgcAmpcykuye4+H+lI/XJYv0UlAMIOAMFBNDI8sl9O05ZFVz/HH6mmVI3ucL
 l08yLxgy7GfVLEZyQEZdwoYiB/XZr500d5sRjK2TPD30ca+pPukjqheoFY7Eeo8UJxSK
 6ff6Dwa5bXGxQgX0QxWTR0Lu2MCetXVDevolop3qWH4oO/Z7wxMshr4TlBAgiCNdLVq4
 kodrDIfm0/MmBQrOP4C7zL+9ePA1L7/Ze5KPkoBOOckg2L9K/xHrSq/4cXFOth/CRh8Q
 zy5Dlg4t1Yk0JbXiN0cDW1FgTs4yd66LEzRDFQwdJk+6jrhd5rXoSZDhqNSciAw2PXNW
 DhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718106103; x=1718710903;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oUuskHTs0HEYkF7RkD+pPZbSexrfbPpOgamc621TLvc=;
 b=od5oDYiR/Jjc2Nic5cQhT1uwoFPfTXVHh88iIkdkSog0bC2vboj2njvtvW/HnvprFC
 1yndd6NqG1G4n7BOG3suu22p6Yj75v0j97TGKg/BG2EwkRmZeXPQT0xWP4FB3z0QV7kQ
 mF6ACC6FTBh7MR0kTOHwW8e8xkZZgHEzREKheugPnw2I6E0f3u722C7ZDtGdMjbWyiRQ
 NQG0mTV/10fmelkjt6auIffdDBhPlfvMIPOXxqZ6Z5szwpUS8PoUWZ7neKiQPuHo8VAP
 qISn6UEoLsXd8Yhjiq4x1nHf6JEDCiRoJvwEoWSK1De0YbO0hAZlBg2RrxzkLOtahZ13
 SZVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfNWZJolj6VybRH14UVx5YOeGeJ7oK24gAY2cH9CEIAgnKUEpCkq9bFoaOuJX+FtK5rFNDlz9a94P8roB69kHm+JAQxcg=
X-Gm-Message-State: AOJu0YzcHMmoqMhL5wd53wo/8Kz7r71i6gd3V1T3XQV1ZSU+L3jCjtEy
 118enSyoSXoLWLnj0RJ/NpHl6wTEkXPSxkuE69GBpDURnOPGAwWLinXRRQ2ctVs=
X-Google-Smtp-Source: AGHT+IFt3gGdgCBnj4kLdFVzpmcquWWbWKDzmul6Vqp8UAa5JpRwnQ7KShQd0S7IA+7C0vgxZgI5Gw==
X-Received: by 2002:a05:600c:3ba0:b0:421:78c3:9d11 with SMTP id
 5b1f17b1804b1-42178c39f55mr72018095e9.1.1718106103310; 
 Tue, 11 Jun 2024 04:41:43 -0700 (PDT)
Received: from meli-email.org (adsl-105.37.6.1.tellas.gr. [37.6.1.105])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42182ed2b23sm82501755e9.18.2024.06.11.04.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 04:41:42 -0700 (PDT)
Date: Tue, 11 Jun 2024 14:32:01 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6kg?=e <alex.bennee@linaro.org>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
User-Agent: meli 0.8.6
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <d910708f-ed55-4eee-8f66-8703cb45081c@linaro.org>
 <evt7n.ggoypj31l14q@linaro.org> <ZmgtfgqOOKeipIDd@redhat.com>
 <ewxal.5kz7id1gqls@linaro.org> <Zmgwcwcs-HbHpVf-@redhat.com>
In-Reply-To: <Zmgwcwcs-HbHpVf-@redhat.com>
Message-ID: <ewz5h.aaa68btq768p@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
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

On Tue, 11 Jun 2024 14:09, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>On Tue, Jun 11, 2024 at 01:58:10PM +0300, Manos Pitsidianakis wrote:
>> On Tue, 11 Jun 2024 13:57, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>> > On Mon, Jun 10, 2024 at 11:29:36PM +0300, Manos Pitsidianakis wrote:
>> > > On Mon, 10 Jun 2024 22:37, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>> > > > Hello Manos,
>> > > > > On 6/10/24 11:22, Manos Pitsidianakis wrote:
>> > > > > Hello everyone,
>> > > > > > > This is an early draft of my work on implementing a very
>> > > simple device,
>> > > > > in this case the ARM PL011 (which in C code resides in hw/char/pl011.c
>> > > > > and is used in hw/arm/virt.c).
>> > > > > > > The device is functional, with copied logic from the C code
>> > > but with
>> > > > > effort not to make a direct C to Rust translation. In other words, do
>> > > > > not write Rust as a C developer would.
>> > > > > > > That goal is not complete but a best-effort case. To give a
>> > > specific
>> > > > > example, register values are typed but interrupt bit flags are not (but
>> > > > > could be). I will leave such minutiae for later iterations.
>> > 
>> > snip
>> > 
>> > > > Maybe it could be better if build.rs file was *not* needed for new
>> > > > devices/folders, and could be abstracted as a detail of the python
>> > > > wrapper script instead of something that should be committed.
>> > > 
>> > > 
>> > > That'd mean you cannot work on the rust files with a LanguageServer, you
>> > > cannot run cargo build or cargo check or cargo clippy, etc. That's why I
>> > > left the alternative choice of including a manually generated bindings file
>> > > (generated.rs.inc)
>> > 
>> > I would not expect QEMU developers to be running 'cargo <anything>'
>> > directly at all.
>> > 
>> > QEMU's build system is 'meson' + 'ninja' with a 'configure' + 'make'
>> > convenience facade.
>> > 
>> > Any use of 'cargo' would be an internal impl detail of meson rules
>> > for building rust code, and developers should still exclusively work
>> > with 'make' or 'ninja' to run builds & tests.
>> 
>> No, that's not true. If I wrote the pl011 device with this workflow I'd just
>> waste time using meson. Part of the development is making sure the library
>> type checks, compiles, using cargo to run style formatting, to check for
>> lints, perhaps run tests. Doing this only through meson is an unnecessary
>> complication.
>
>I don't see why it should waste time, when we ultimately end up calling
>the same underlying tools. We need to have a consistent experiance for
>developers working on QEMU, not have to use different tools for different
>parts of QEMU depending on whether a piece of code happens to be rust
>or C.

This is a technicality but for the spirit of conversation and curiosity 
I will reply with my view: we end up calling meson and ninja, yes, but 
they wrap cargo under the hood. Cargo has its own tooling and workflows. 
At the end of compilation it spits out a dynamic or static library. That 
happens independently of QEMU.

If you start writing a new project, you don't go linking it to QEMU 
right away (you can, but there's no need to yet). You make an idiomatic 
Rust crate with rust tooling. FFI calls can exist and you are still able 
to compile/check your crate. This is the typical rust workflow, and it's 
ubiquitous, so I think we should not deprive anyone of it.

The only thing we cannot check with cargo alone is if the crate uses the 
QEMU apis correctly (logic errors, not compilation errors)

Until/if we can build with just meson and rustc (a hypothetical scenario 
at the moment) cargo becomes part of our development and build tools.

I understand your argument and it's not irrational at all. I offer this 
perspective as a Rust developer and not a QEMU developer. As a QEMU 
developer I shouldn't need to care about cargo unless I'm touching part 
of that code; the build system details (the cargo wrapper) can be 
abstracted away for everyone else.

