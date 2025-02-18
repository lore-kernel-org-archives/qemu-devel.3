Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE2AC02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 10:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkKvC-0001sU-4V; Tue, 18 Feb 2025 05:33:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tkKv9-0001rH-Pn
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:33:43 -0500
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tkKv5-0000pV-De
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:33:42 -0500
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e4419a47887so3928113276.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 02:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739874817; x=1740479617; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ZMBmVs5XRmd0x+E9pD+oKiYoHw6RL9O2OW6WpxeJPY=;
 b=yshFPwnH3EkShN4pUPzJCHsSjBEX6YrjsKhzcGEvWAcoy3jyVTyraPtk+7Avnc+VuE
 sxC6IK7QoMPXfKSb2kuV4k2TEz21esDySriPRdvanw0QkZpwfKH0wT05mAxjJxrNWIZB
 iSb3jHhuUsOXdMcfbvFXQZqI0UN5M3eF30luq0gVBKUOQcBaxovulgqUowMWvQi3LI/U
 LDOnmx/wVLFkwpxJ884GHYv42HgyYOK6Q6FVQaOgTLyVnIp8f77TOdZmgKoQZHxRlyLu
 /xFMqzXds9y3K+wn7TJf86iLPNEStiDO/PtHiBbGrNK19IZ5/p6jt2p+BTDGHSI8WC/K
 WhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739874817; x=1740479617;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ZMBmVs5XRmd0x+E9pD+oKiYoHw6RL9O2OW6WpxeJPY=;
 b=wUkZT6PgUARs9ldU23XJQSnbzPzutbOXdTSdgKPWANb7M7j80eo4Jqbzx6+Xz4IuLs
 KirMT/mXwMpdT8yzKZ/VGHiaZKbn82kdb27UHncHk+foWQxJ26OeGTEXUe1pIRJfEbRa
 GCcDXVvxxLaNjPU3mY5oNEhlYXkc1GhAa/M2QRHMKvlZUjyeaNT/NTL1gMFZitPvOKVJ
 MVegv2fFthr2a5LhYouxmai0iyT5biRkfLdxYhdQ37II+AY1axx8gpZbnQgDgDaipwh4
 97y77h30nOiJSLP+tFgNtmBD5EfRf6TA2ZHRKmeDkG9jQF38zoJVzZNFOY4n5H0g7dGN
 7LNg==
X-Gm-Message-State: AOJu0YydssPeajBpJf+SpHJT9AUdY61EWrCfGeDIkrK0bow66ZiwrAPr
 W5sNqHL8RmqtVQq/DDpsR6h+q5TX7rYo1p0mccjdTFndYWiTj0iTkF44mHOUH2woDixj/L6tYf3
 rnbZToZWsHnPg7WqgQIJpc7bP3TcZrhWjnQYyBA==
X-Gm-Gg: ASbGncuM474a+PE/sPaS1ilwKMpH7H0EnDjwO/B+ANSKFC0AICnZAXXtH6xxvs3Ba9o
 oLtxJnm75/6+mimFqsGwD3d/eoiOTyiKW3hNlI74BPUxj+FkooBYryhQ0rYUKnCN20lHoAh5KYA
 ==
X-Google-Smtp-Source: AGHT+IFuGXw3tbMwTlciowEi93YqRruh370CWuhIeqJFBOcp2a33eL9uI8tLRUxq7kwptrfY6lK0RpN3QHAwtgzJBZ8=
X-Received: by 2002:a05:6902:2582:b0:e57:f8cd:f0a4 with SMTP id
 3f1490d57ef6-e5dc91dcaa6mr8628872276.34.1739874817456; Tue, 18 Feb 2025
 02:33:37 -0800 (PST)
MIME-Version: 1.0
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-4-shentey@gmail.com>
 <CAFEAcA8yayMSe+64VDV8TwSMi7u0_wLM+y9-TKsnaZS5seNKZA@mail.gmail.com>
 <18125593-7729-40FA-9FC1-7DC912287503@gmail.com>
In-Reply-To: <18125593-7729-40FA-9FC1-7DC912287503@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Feb 2025 10:33:26 +0000
X-Gm-Features: AWEUYZlsppH-2icB6RCfvtouUYvl1m3E3sPeDA__8q4ovSspImO-7xZxHurUO9Q
Message-ID: <CAFEAcA_4ONvJB0xSSGKo4RXVfjBxck8N3mD6G=n=DKbfK4r41g@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] hw/gpio/pca955*: Move Kconfig switches next to
 implementations
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Mon, 17 Feb 2025 at 20:21, Bernhard Beschow <shentey@gmail.com> wrote:
>
>
>
> Am 17. Februar 2025 13:35:04 UTC schrieb Peter Maydell <peter.maydell@lin=
aro.org>:
> >On Tue, 4 Feb 2025 at 09:21, Bernhard Beschow <shentey@gmail.com> wrote:
> >>
> >> While at it and since they are user-creatable, build them when
> >> CONFIG_I2C_DEVICES is set.
> >
> >The patch subject says this is just a rearrangement
> >of the Kconfig stanzas with no behaviour change, but then the
> >commit message body includes one.
> >
> >If you want to build these when CONFIG_I2C_DEVICES is set,
> >that should be its own patch that does that.
> >
> >(The move of the Kconfig bits to hw/gpio is fixing a bug
> >in 6328d8ffa6cb9d ("misc/pca955*: Move models under hw/gpio"),
> >which moved the code but forgot to move the Kconfig sections.)
>
> Okay, I'll split the patch and use above commit message.
>
> >
> >Separately, it's unclear to me how worthwhile it is to add
> >these to CONFIG_I2C_DEVICES, because they're GPIO devices,
> >which means there's not much you can do with them as a user:
> >as far as I know you can't wire the output/input GPIO lines
> >up to anything. We have the device models mainly for boards
> >which provide them, so that guest code that expects to see
> >them doesn't fall over on bootup, and because the board
> >model code does have the APIs to wire up the GPIO lines.
>
> It's basically to satisfy Linux which will clog the i2c bus if such a GPI=
O expander is configured in the DTB but missing in the emulation (it will d=
efer probing which will never make progress). Once it is its own patch we c=
an decide separately how to proceed with it, e.g. dropping.

If Linux wants to see it because it's in the dtb for the
hardware it sounds like the right answer is that we
should create it in the board code, which we can do
without adding it to CONFIG_I2C_DEVICES, because we
can make the board code's Kconfig do "select PCA9552",
like the aspeed board does already.

thanks
-- PMM

