Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A075EC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 12:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH0yQ-0007Zc-3c; Tue, 11 Jun 2024 08:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sH0yO-0007Yy-2M
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 08:51:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sH0yK-0004Di-L6
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 08:51:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42249a4f9e4so5398615e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 05:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718110291; x=1718715091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mSDcG0Rlmu56I9Kvmm1xNwz7IsTOjookOp+5aLtYER8=;
 b=xZ7veyuJrg98gqB3tFKyGXKkUgwUEBvg4kLnpnEs4JtaijGVQX752xrwLJrF21vpi0
 xq7Htbh24HM0OMan+6c6r5BPvePPzv/8WEIOJD2DmkOEP0wRukIJkTYNqVegoqBXJ5hG
 LcUKFEkae2ThPVXoAtrdjFldZCIKch7slG3fWxIivbHKyoy5waQGUKEsGS6Y7XDYeJb6
 EKLLo6ThagxYQdKR2+3TBxa93/69wwiZyzHEwhnzY6H/C5rq+aGeyfhu/LsI4969k+Iq
 r3MU6ghdH3dLHvdKPFxLCnFa3CNAvaeK3AiCDqZrExztrM6Rac2qZhMhT0NAzBcV98Pa
 gQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718110291; x=1718715091;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mSDcG0Rlmu56I9Kvmm1xNwz7IsTOjookOp+5aLtYER8=;
 b=II+MS0wjv4XJPP/ENLP0UeLviIkaft+3hsDeeA8hYEbD+bk4FLtwkrB07rjlhLIArA
 C0VDYBhtEUjqmFX3oiaowvFAYgQuDsR9Drx+3m8Chr+JpjlALIZqIzcptzpgPbSbasm4
 j7vUVvpg3adnk6AbCg6x4+/e0a2d2YRTDn8HihQo4kI1+vjER8BViVQvo32WX4HkQmiE
 LMxQ9ZYnq6wCrHfs91BJRQG3SUUQdItPQBdGDyRpGkRhYTvY9MNZQbRRRs5Wkkid1+3B
 vDQjO6KON18Npdjbth9ymslMjq/A1RqvAD4DWMCsyEYypjNc6oxPJfbvX/c1UA0ivK7f
 J81Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+InpZ3XJmsSWDBkMxyZz5hO/uY2YUeeI6kwgUqvmZVVDIn+dy4Y8YlWxvFBCxantej4LuzhhyaMbzeimyHeSjH14R1uw=
X-Gm-Message-State: AOJu0YwDj1bErUNugSNPJ80nzkgWr5SZ0pba7uPDu5LQhgpY/q60/Z9o
 yemHyh8pz+5uL7WEpsvqqWW5td1xp8WNOtKKjI4T/ADZ80WRuyg0LylHzbyd5gY=
X-Google-Smtp-Source: AGHT+IGHcICEA4odGp44rlYlCwpSNNQhp0GLL300lZqS5spR33wEWj76daCHbQgErBemd3HPTjNXNQ==
X-Received: by 2002:a05:600c:19c8:b0:421:8f16:16d5 with SMTP id
 5b1f17b1804b1-4218f161b0dmr58747295e9.33.1718110290870; 
 Tue, 11 Jun 2024 05:51:30 -0700 (PDT)
Received: from meli-email.org (adsl-33.37.6.162.tellas.gr. [37.6.162.33])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f22ba68absm6066587f8f.9.2024.06.11.05.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 05:51:30 -0700 (PDT)
Date: Tue, 11 Jun 2024 15:49:17 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn =?UTF-8?B?w6kg?=e <alex.bennee@linaro.org>,
 Marc-Andr =?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud =?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
User-Agent: meli 0.8.6
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <d910708f-ed55-4eee-8f66-8703cb45081c@linaro.org>
 <evt7n.ggoypj31l14q@linaro.org> <ZmgtfgqOOKeipIDd@redhat.com>
 <ewxal.5kz7id1gqls@linaro.org>
 <e76ba00c-0b9c-42ad-93e2-13a2e6662c60@quicinc.com>
In-Reply-To: <e76ba00c-0b9c-42ad-93e2-13a2e6662c60@quicinc.com>
Message-ID: <ex2dt.gwm832c27uu@linaro.org>
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

Hello Antonio!

On Tue, 11 Jun 2024 15:45, Antonio Caggiano <quic_acaggian@quicinc.com> wrote:
>Hi there :)
>
>On 11/06/2024 12:58, Manos Pitsidianakis wrote:
>> On Tue, 11 Jun 2024 13:57, "Daniel P. Berrangé" <berrange@redhat.com> 
>> wrote:
>>> On Mon, Jun 10, 2024 at 11:29:36PM +0300, Manos Pitsidianakis wrote:
>>>> On Mon, 10 Jun 2024 22:37, Pierrick Bouvier 
>>>> <pierrick.bouvier@linaro.org> wrote:
>>>> > Hello Manos,
>>>> > > On 6/10/24 11:22, Manos Pitsidianakis wrote:
>>>> > > Hello everyone,
>>>> > > > > This is an early draft of my work on implementing a very 
>>>> simple device,
>>>> > > in this case the ARM PL011 (which in C code resides in 
>>>> hw/char/pl011.c
>>>> > > and is used in hw/arm/virt.c).
>>>> > > > > The device is functional, with copied logic from the C code 
>>>> but with
>>>> > > effort not to make a direct C to Rust translation. In other 
>>>> words, do
>>>> > > not write Rust as a C developer would.
>>>> > > > > That goal is not complete but a best-effort case. To give a 
>>>> specific
>>>> > > example, register values are typed but interrupt bit flags are 
>>>> not (but
>>>> > > could be). I will leave such minutiae for later iterations.
>>>
>>> snip
>>>
>>>> > Maybe it could be better if build.rs file was *not* needed for new
>>>> > devices/folders, and could be abstracted as a detail of the python
>>>> > wrapper script instead of something that should be committed.
>>>>
>>>>
>>>> That'd mean you cannot work on the rust files with a LanguageServer, you
>>>> cannot run cargo build or cargo check or cargo clippy, etc. That's why I
>>>> left the alternative choice of including a manually generated 
>>>> bindings file
>>>> (generated.rs.inc)
>>>
>>> I would not expect QEMU developers to be running 'cargo <anything>'
>>> directly at all.
>>>
>>> QEMU's build system is 'meson' + 'ninja' with a 'configure' + 'make'
>>> convenience facade.
>>>
>>> Any use of 'cargo' would be an internal impl detail of meson rules
>>> for building rust code, and developers should still exclusively work
>>> with 'make' or 'ninja' to run builds & tests.
>> 
>> No, that's not true. If I wrote the pl011 device with this workflow I'd 
>> just waste time using meson. Part of the development is making sure the 
>> library type checks, compiles, using cargo to run style formatting, to 
>> check for lints, perhaps run tests. Doing this only through meson is an 
>> unnecessary complication.
>> 
>
>My favorite tool for Rust development is rust-analyzer, which works very 
>well with cargo-based projects. Making it work with meson is just a 
>matter of pointing rust-analyzer to the rust-project.json file generated 
>by meson at configuration time (just like compile_commands.json).

That's only generated for meson rust targets, whereas we are currently 
compiling with a cargo wrapper script.

>
>Unfortunately, rust-analyzer also relies on cargo for doing its check. I 
>was able to override that with ninja, but it requires `meson setup` with 
>`RUSTFLAGS="--emit=metadata --error-format=json"`. That makes 
>rust-analyzer happy, but compilation output is not readable anymore 
>being json-like.
>
>I ended up working with 2 build folders, one for me, one for 
>rust-analyzer. So, yeah, it complicates a bit.
>
>> To compile and run QEMU with a rust component, sure, you'd use meson.
>> 
>
>Cheers,
>Antonio

