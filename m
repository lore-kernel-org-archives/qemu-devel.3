Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42076C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 11:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGzG3-0000rT-4h; Tue, 11 Jun 2024 07:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGzG0-0000r6-FN
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 07:01:40 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGzFw-00083H-PS
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 07:01:40 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so33525515e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 04:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718103695; x=1718708495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Av1Gro5e7HCZy4h6lpZfKxvIDJHasYtshmTAmBqWF5Y=;
 b=PmUNSQWjjeasF7sMgzKLudA1yNhtXG9ddjZXTXhbaOp4D8aj+hGOGwj9v7Xv86BTZ+
 P9AnCrP4w8IB6kr7feavMnN/PoMQ8zpdPnduOza63Qqbdzxs40duUYQJbZntu4K0g0/k
 bbRzKfKaF3gDbxnF6vg8EG2TwRM9qljVLfOv/fwihQJg41PvksCLM2mYGWXqx8E1+92n
 1twZ064rwADUXp9ZKPQjHFm8LRsvK6dLSsgwKh44zhjMX92CYGyEeRExmyovYmcY+ubu
 BdoOLFKJ5IWVPZNcmvjmFRBwVBY5hCd8tQx0zcXXdlpe466E03FUY07wCZLerwsZQA4j
 LLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718103695; x=1718708495;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Av1Gro5e7HCZy4h6lpZfKxvIDJHasYtshmTAmBqWF5Y=;
 b=m7ySgKDqLRb8xlCeHdetQ05332tl18Zlv7DK5AxiYDYZG/dxp4FXHpMWfBFIPBojUp
 I2cDcAFSFEIWMUo15FnqVw8LdLsx21KCRgeUCjw4CYEkx1JWFdepS6oeosxxFX1HMeAz
 ImVXEjYDvfR+bCS23jq8/xwKBm3Jtf2mAN0DvcKJiSUttXpa4wndBJhW7v5M+gRTKkGH
 pol6UbN0LwADgvMBYH0I/g6KJumAl/t2zuRMB7lAAktuxyTo3ZN98x7fXmN0AmC3ZYy2
 NykntgoKVJC+5Kloxw4P5MUccGv+T74gDvxgmQIkIJfBKNpoXDJp1LsobtBLoHcQ5LiS
 lpNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW860Dn2wssQd8uRY8qg5OQ7u9NGFNVlYPhiQREUshYvDAlch/IIRQvoeqTz2PDQ4XAJEqVRFlr+36GXmyNm90TIuufepQ=
X-Gm-Message-State: AOJu0YypNf2kPEjVwNvgsJZUCIJTIOHFL0B5718jWp0ZDa72GQxCaUuI
 XGZW09SPmHAK3UVgBCfr1ho9E/etImsu2L9BGabPKUh5kcEeBHUg4tGoq0jnfAc=
X-Google-Smtp-Source: AGHT+IHhsSpLtkpztt0e2/a+VIH26RUaL7ZXiCCGgDF01NwXJL153sBTDO808Yyp5o7NCH0Ks2JyZA==
X-Received: by 2002:a05:600c:4746:b0:41b:d6ca:eefa with SMTP id
 5b1f17b1804b1-4223c7870e6mr21601085e9.16.1718103694866; 
 Tue, 11 Jun 2024 04:01:34 -0700 (PDT)
Received: from meli-email.org (adsl-33.37.6.162.tellas.gr. [37.6.162.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421b905908asm73064315e9.20.2024.06.11.04.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 04:01:34 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:58:10 +0300
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
In-Reply-To: <ZmgtfgqOOKeipIDd@redhat.com>
Message-ID: <ewxal.5kz7id1gqls@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
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

On Tue, 11 Jun 2024 13:57, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>On Mon, Jun 10, 2024 at 11:29:36PM +0300, Manos Pitsidianakis wrote:
>> On Mon, 10 Jun 2024 22:37, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>> > Hello Manos,
>> > 
>> > On 6/10/24 11:22, Manos Pitsidianakis wrote:
>> > > Hello everyone,
>> > > 
>> > > This is an early draft of my work on implementing a very simple device,
>> > > in this case the ARM PL011 (which in C code resides in hw/char/pl011.c
>> > > and is used in hw/arm/virt.c).
>> > > 
>> > > The device is functional, with copied logic from the C code but with
>> > > effort not to make a direct C to Rust translation. In other words, do
>> > > not write Rust as a C developer would.
>> > > 
>> > > That goal is not complete but a best-effort case. To give a specific
>> > > example, register values are typed but interrupt bit flags are not (but
>> > > could be). I will leave such minutiae for later iterations.
>
>snip
>
>> > Maybe it could be better if build.rs file was *not* needed for new
>> > devices/folders, and could be abstracted as a detail of the python
>> > wrapper script instead of something that should be committed.
>> 
>> 
>> That'd mean you cannot work on the rust files with a LanguageServer, you
>> cannot run cargo build or cargo check or cargo clippy, etc. That's why I
>> left the alternative choice of including a manually generated bindings file
>> (generated.rs.inc)
>
>I would not expect QEMU developers to be running 'cargo <anything>'
>directly at all.
>
>QEMU's build system is 'meson' + 'ninja' with a 'configure' + 'make'
>convenience facade.
>
>Any use of 'cargo' would be an internal impl detail of meson rules
>for building rust code, and developers should still exclusively work
>with 'make' or 'ninja' to run builds & tests.

No, that's not true. If I wrote the pl011 device with this workflow I'd 
just waste time using meson. Part of the development is making sure the 
library type checks, compiles, using cargo to run style formatting, to 
check for lints, perhaps run tests. Doing this only through meson is an 
unnecessary complication.

To compile and run QEMU with a rust component, sure, you'd use meson.

