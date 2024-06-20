Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2D0C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 18:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKMd6-00011K-5j; Thu, 20 Jun 2024 14:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sKMd4-00010L-JQ
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:35:26 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sKMd2-0003sC-RB
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:35:26 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4247f36f689so6132445e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 11:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718908523; x=1719513323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=HuMzMuwNykd9ozAMAPiLo7EVlgWOviQIxyx7fR9sCII=;
 b=Hc+56EjttVzKO/gp6g8nWgzqANLTBVoo6DQHig/fNQ8BLrPbbnAAWsWxEVvKHn2/1D
 lDpjbCq4cABRFxn8wsucSzYcwXGVpktWzz1MMNc1Cn/MUMPpvmdbxkKTNKxKEjcnWvuP
 YMqhDAoycP6wVZGeGQYxnjIioox0fML6GZ4LLygp7U8AiEArKB+7zReVgTvYmYQbsf9g
 TAsuCmJxFPPAL/xC54zpFRKwF3cw7A887g/ZCMHXLZdIiV6D7kIDP3DvwWKTFX7hDKs8
 Gy2NZ+VcI75pEjKqy3uJ/20H6Tcqo8LBu4tbdFmlOos0bDuubiLPHBcViLzIjgPxM5LW
 vHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718908523; x=1719513323;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HuMzMuwNykd9ozAMAPiLo7EVlgWOviQIxyx7fR9sCII=;
 b=OcLchdPEzET7pO2N9LeSMlz59KqS6lNpzXKUuzx1Wggam5PkrHV7v6JHs2KMZXx1ZH
 ZO8tR1A+ofEczERFIBYIWU1MOmH0fEk9he2vwB4sUinG8z8okFNsGShQaRWMm4aNeEP8
 CiJGoKaqciJcowDxhC62vpduTGr0ypWNwYPaa/yPDzBWKO1R4FgLDWjzdCGiYA/8e/wV
 e/5+cIkBOzwdP1OZsS+nfrXlerbaqT3kTYr7FYAYqTUXNxB6J6pPyUY3A1uZSXIs9Mtg
 W97BWSc5AAbFLZX7BiHNT9TCIlf/jMjK4gNaM9/WMvhJRxhafpQ40D1EL7eROvXiStoB
 7PNg==
X-Gm-Message-State: AOJu0YzD7hEJCBTXP4BMaZ2pJEW8qtJItjWUPguOJrVg8qNiyy3v+Cpm
 /QFdz1Er3rVwDay77zFBafu4eq+GYbXOSfPHeQgTgXKi03IBk01V/2+Xo/NBElX7jqLIQL0IM7T
 WhXg=
X-Google-Smtp-Source: AGHT+IGowjYqpOW8j0GB9VlkOHFCtxRDBfJXAYT/3NzP5XAp/3/yqXlBJbkvfAlWlzslRiPsbQwfUQ==
X-Received: by 2002:a05:600c:20c:b0:418:fe93:22d0 with SMTP id
 5b1f17b1804b1-42475173d66mr51567345e9.11.1718908523228; 
 Thu, 20 Jun 2024 11:35:23 -0700 (PDT)
Received: from meli-email.org (adsl-103.37.6.162.tellas.gr. [37.6.162.103])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d0be9fasm35579665e9.16.2024.06.20.11.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 11:35:22 -0700 (PDT)
Date: Thu, 20 Jun 2024 21:22:53 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH v3 2/5] rust: add bindgen step as a meson dependency
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <6bf311a35e6d3bfa8b3bfd10d8f896a9e655fa30.1718827153.git.manos.pitsidianakis@linaro.org>
 <8734p7dcbq.fsf@draig.linaro.org>
In-Reply-To: <8734p7dcbq.fsf@draig.linaro.org>
Message-ID: <fe6ax.yk8b6hjo7ezl@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32c.google.com
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

On Thu, 20 Jun 2024 15:32, Alex Bennée <alex.bennee@linaro.org> wrote:
>Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>
>> Add mechanism to generate rust hw targets that depend on a custom
>> bindgen target for rust bindings to C.
>>
>> This way bindings will be created before the rust crate is compiled.
>>
>> The bindings will end up in BUILDDIR/{target}-generated.rs and have the same name
>> as a target:
>>
>> ninja aarch64-softmmu-generated.rs
>>
><snip>
>> +
>> +
>> +rust_targets = {}
>> +
>> +cargo_wrapper = [
>> +  find_program(meson.global_source_root() / 'scripts/cargo_wrapper.py'),
>> +  '--config-headers', meson.project_build_root() / 'config-host.h',
>> +  '--meson-build-root', meson.project_build_root(),
>> +  '--meson-build-dir', meson.current_build_dir(),
>> +  '--meson-source-dir', meson.current_source_dir(),
>> +]
>
>I'm unclear what the difference between meson-build-root and
>meson-build-dir is?

Build-dir is the subdir of the current subdir(...) meson.build file

So if we are building under qemu/build, meson_build_root is qemu/build 
and meson_build_dir is qemu/build/rust

>
>We also end up defining crate-dir and outdir. Aren't these all
>derivable from whatever module we are building?

Crate dir is the source directory (i.e. qemu/rust/pl011) that contains 
the crate's manifest file Cargo.toml.

Outdir is where to put the final build artifact for meson to find. We 
could derive that from the build directories and package names somehow 
but I chose to be explicit instead of doing indirect logic to make the 
process less magic.

I know it's a lot so I'm open to simplifications. The only problem is 
that all of these directories, except the crate source code, are defined 
from meson and can change with any refactor we do from the meson side of 
things.

