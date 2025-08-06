Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BC1C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 09:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujac4-0001j2-Dt; Wed, 06 Aug 2025 05:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ujaa9-0000Mc-L8
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 05:37:13 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ujaa7-0004pY-Qv
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 05:37:13 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-615460d9897so7651828a12.0
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 02:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754473030; x=1755077830; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I+UqFI1/PN506Bb7rCYGzgCe9CYkRyiz0BuTqy/BR8U=;
 b=A/DDh/k65kiQI2ZLAgJFvDQiw/XM8Z/fQcCJWXq3jlMzSMGSBa9TbricepNdzWI0lK
 DDFiOnfpYO1BSr3cqTaXfPD+fD+RKkducy9mh09Bp5b6wQCVkCal+GlbtVIqxm6iFKW/
 Y21JesG/mhCTNsP3rtI/x5DQpVmWzbt94G+vnNNlnCVJTB6MFKnl6GUqE8ZA1igfpo75
 MlGxxNQHweNaA+IV6nkwUc0y1L4kxO4TrKAK/FjjJarf8FnV58Kqrb2/CF/mKaeris5x
 fmqGNyHjyqwX/sJDhPUzqOsXd7dVr/vu91ZyF9bUJGVKskwJ9YWFR3Mf8HDOWfQq3kQ9
 so9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754473030; x=1755077830;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I+UqFI1/PN506Bb7rCYGzgCe9CYkRyiz0BuTqy/BR8U=;
 b=vQGzN99KQVhmHHx9vIyKgOfEUPTL3+UuyOI9qv2+rSGFjuPsMKwEGadRaod/b8BFpz
 lXVaf41HioMwHBeM3cuC6tScTw1guoJFi3tqkh0sCBJcLu68iG0uwFDgIsd/Wz+KdBuN
 jiS1s8718glD+xKhshpFRq82GxP4+4gv9mL2bfEKGT/k6oCOhdEp1GX1nguIOgYDetcR
 stolJFm2Z+q0/OTuaWEds1hL8zeW3cBpbN7p6/PS/SOCM5eTkQPuI0xuWGbJtjexAJKf
 HWvQ1J5YxrFQN0b9l5FW0U45SKhAzBg9dVbWyAOEWYvrDF4m9xZ0HzaHU01SPlEpli3x
 xZ+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX5kX3eUNzNCNiBfpPgGaywlvYMzBvTg3mrj8ILqhITJ7DfH5/VfIpXTRkx/aoi051kbtuOsUZiNoZ@nongnu.org
X-Gm-Message-State: AOJu0YxmbKGLUTW9cJGTwkafiPRjS8lWR/bkMh/HMIpXTNKrgrJubAM8
 zy9rriW3mTlEVGTnkyIVeBWMLMHCVEZOGmSFhC5VNjVCuqnmMBFIS4iEvNEqkKoNRF/vbuRzPgW
 c4n4VyG6ONFhv+LtytfCJ3cqD4oiKyNZ5PJpg6yee5w==
X-Gm-Gg: ASbGncs+maQD75YUm+nactygzFyKG+nelV3oA2pW6nlMJIPi2fnST3+MDwv5CV/ImHU
 WB275lyfzw1uc0VfC2UdwhyWnnZbMsBvjrHi3C54G05uLux33zmv/dVA+4of7V6988KIoVOeTEs
 aCnxVtvCqh7KQhkm5iUWx7oqD2bbf2dj/ajaqokbdRb2FwINrBfx5EGHUuoBHs9Qe8zQrIwarlc
 vBliQFD
X-Google-Smtp-Source: AGHT+IGe1KitGE2+htjyCZDB4lva09ealXKVoVL1OjoyncLf6cKJBiTcSP0XuySIEX4rfE02HtiEQHU5gWFcqt2IXEI=
X-Received: by 2002:aa7:d64b:0:b0:608:6501:6a1f with SMTP id
 4fb4d7f45d1cf-617960b2169mr1410619a12.1.1754473029795; Wed, 06 Aug 2025
 02:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250804-rust_trace-v1-0-b20cc16b0c51@linaro.org>
 <aJIrpoEhrl7aLBMg@redhat.com>
 <CAAjaMXa6ManykYJJk--vNZT7oeBW9UR2v6WixaaQ8LUCSjy9Ug@mail.gmail.com>
 <aJI0mr5HDgtE9HIc@redhat.com>
 <CAAjaMXZ0Dho+5FSyc4zkOZXZT6UvHtjgmpj6_0QZQcH_AD9=VQ@mail.gmail.com>
 <aJJFVgkt7R49ZwIF@redhat.com>
 <CAAjaMXYhWsWPoDdfoNyTGrJSRfiYJDqBkv8fC87+Zi3YCtU06Q@mail.gmail.com>
 <ad404bb4-93fb-4a27-995f-734e647c1da0@redhat.com>
In-Reply-To: <ad404bb4-93fb-4a27-995f-734e647c1da0@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 6 Aug 2025 12:36:43 +0300
X-Gm-Features: Ac12FXybkjYA4S9Z2djlMHF9OchSkOmkH-kC6z2pwZxXyt9H79SOievTjDb1oI0
Message-ID: <CAAjaMXZH75Ooyb+S-qTQfsDgj7VO0ed8fv5S_tYe=VC++ABy4w@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] rust: implement tracing
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, qemu-rust@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello Paolo,

On Wed, Aug 6, 2025 at 12:03=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 8/5/25 22:06, Manos Pitsidianakis wrote:
> >> If you're thinking this is all rather complicated, you'd be right,
> >> which is why for initial feature parity I figured the simplest is
> >> likely to just wrap the existing QEMU inline probe function, so
> >> Rust doesn't need to know about the different backends... yet...
>
> It's not too hard to add individual backends (other than dtrace---see
> below--and ust which doesn't build for me(*) and I wanted to deprecate).
>   Tanish is pretty close to being able to post initial work.

Ack, I look forward to it :) I hope my RFC provides them some
inspiration on what things (not) to do.

Thanks,

>
> > Yes, that indeed makes sense.  Generated C trace headers statically
> > linked to a standalone trace crate library for each subsystem, that
> > rust qemu crates can link to in return is the cleanest solution for
> > this approach IMHO, because doing this kind of codegen via macros
> > needs interaction with meson to generate the C sources and then run
> > bindgen all while compiling this one crate which is a single meson lib
> > target.
> >
> > It might be possible to generate the equivalent of the C code for each
> > backend just like this RFC generates only the log backend code, I'll
> > take a look out of curiosity...
> >
> >> FWIW, the original DTrace authors created a Rust crate with native
> >> rust integration of dynamic probes.
> >>
> >>    https://github.com/oxidecomputer/usdt
> >>
> >> I think that (somehow) we probably want to integrate that with QEMU
> >> and its tracetool.
>
> This unfortunately only works for macOS and Solaris.  It also has quite
> a few dependencies (~25) on other crates.  There is also a "probe" crate
> (https://github.com/cuviper/probe-rs) that is minimal and (currently)
> specific to Linux, which is what I planned to use.
>
> By the way, while I like the idea of using Rust format strings, there
> are parts of tracetool (e.g. format/log_stap.py) that need the printf
> strings, and also backends (e.g. backend/syslog.py) that call into libc
> and therefore need to use printf format strings.  So I think we're stuck.
>
> Paolo
>
> (*) that's because this tracepoint:
>
> visit_type_str(void *v, const char *name, char **obj) "v=3D%p name=3D%s o=
bj=3D%p
>
> incorrectly handles 'char **' as a string.  The breakage has been there
> since 2016, though probably it's only more recent versions of ust that
> actually fail to compile and until then the bug was latent until you
> enabled this tracepoint.  But it seems unlikely that anyone has used the
> ust backend recently.
>

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

