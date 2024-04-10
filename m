Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604A7CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 21:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rufIW-000253-MC; Wed, 10 Apr 2024 17:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1rufIV-00024i-5b
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 17:15:59 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1rufIT-0002mN-Ou
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 17:15:58 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dc6d8bd618eso6803430276.3
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 14:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712783755; x=1713388555; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9x/Eq/q4we2KNpJafPERlqtH75igc6oXobs/r/LYkfU=;
 b=aaPS41XcPbJ6c7lHAPL8rWq0sgl0bjjq1cq3oij5R4wlf7zu+a9k89ztWUCQBcFjeJ
 NMf5l5yAeI1b9+PPLxgabpLY20DXAqWSUgj3Fw4ToubyUEUhXScv0am4g36dKbPjcfnJ
 u9WlJhhrihdDnYOE0N3878vyxvgfTRAfEVvJBkvfQI1gh29QtApplVX7oJPP5yjf32TI
 wuf3vSldBjcNyR2my/1AWWNmdqapfLmaE45VeGFuIkJhVWsMTo7K4ZtDksjj2iTPoQRg
 2GK+CATPDCC+peNgkI/eCJgdb4Tm3cdDz7DZcVxCFdAV6ym9TNmuvF7pVVCPLHor+IRm
 irPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712783755; x=1713388555;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9x/Eq/q4we2KNpJafPERlqtH75igc6oXobs/r/LYkfU=;
 b=iOlL5SN6Mf8G9xzOlMBSxGPzDp/n75ba0acY7o7uKM4T1sq9Xo24f7SLCSiZt4gB3H
 zamcfGDuOn8hHhH4tnK5DoSsierCrJgxsX2QbPmZR6cOZRxHPVw789LctVSsEGAEIkeY
 iIW6IjCPUp9kwGTwuC24x6kyy06GFBXG7MzTmfMJBnZ2iOiF62vil+C9TXdXyEs02O7r
 gjgdhWB3y26DWdn4zvdTYj6l3KkXru0OY3tX3vR0eco3ywcJktm/dQCzVBA34sW7CYLI
 6WFj6iYqZqgjRhV3royRq63RBvjoROnSO6XR8W7OE6/D6QHZJHSwwFkT7DytHtobmo9d
 F+LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbnmOLDlYENiCdHqFoRQF4I5trIyHDMa0ZnWlfD49X8x63sj6729vcTwwu2YC3qU+ChwWpozBTEXONARRjtnoiIOo5OLg=
X-Gm-Message-State: AOJu0Yz06Jhi5ZcPhCQXOTjne/1fPRHkWXvgb5iWztcs8/PjdL1zc6r3
 Jacy5U/rHczFYE+r9cF0YIir0tWmWJ7xnucpYn3Psi5I1IEOWLIZtteAil0B+fpAPfFNneVKNTs
 nMkczfNBZii2I35B8Flt8dkQbdHg=
X-Google-Smtp-Source: AGHT+IFNmcWej0sKpKN2YIrt4rPr8mn38jsD0GgcvMyGwt33LlwfR8hd8/Vk2ztGIOP7lf0uE7b6QUOG/bhocYR99sY=
X-Received: by 2002:a5b:b45:0:b0:d80:68d1:b826 with SMTP id
 b5-20020a5b0b45000000b00d8068d1b826mr4164377ybr.6.1712783755129; Wed, 10 Apr
 2024 14:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAM2a4uwktAA=Uk9_GRnxusvHhfrZg+EUWjfxy95YgxGsQQntjA@mail.gmail.com>
 <dd957513-1272-40cf-bda5-4d3f717f3c71@linaro.org>
 <CAM2a4uxuY5PGrHLo72+i2p6Cj-1R37kiXOehrhRMKUn3Xaia=g@mail.gmail.com>
 <074ed71f-6dca-4a55-9163-60a9305dd27a@linaro.org>
 <CAFEAcA-fmCNgyczGZaE=otT1x=iVt_-oPwkS308CWkP3wLdhbg@mail.gmail.com>
 <CAM2a4uwMomHgYVQvRV+3UjsjTkE-BOK=zn8Rgv5y7OGjy0HfTw@mail.gmail.com>
 <CAFEAcA-CDgR2r7uNh=PQaQfVspa5tnNTwiK7Dbor7faxY25V=w@mail.gmail.com>
In-Reply-To: <CAFEAcA-CDgR2r7uNh=PQaQfVspa5tnNTwiK7Dbor7faxY25V=w@mail.gmail.com>
From: Gautam Bhat <mindentropy@gmail.com>
Date: Thu, 11 Apr 2024 02:45:43 +0530
Message-ID: <CAM2a4uxYKyVJN6GjN8c2fz21eCJxoLh4r3hzqqRMALCHKxt1Uw@mail.gmail.com>
Subject: Re: Point where target instructions are read
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=mindentropy@gmail.com; helo=mail-yb1-xb2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Apr 9, 2024 at 2:23=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:

> That sounds like a problem with your binary. If the reset vector
> needs to be at 0xFFFE then it needs to be there, and you
> should arrange for it to be built correctly. It doesn't matter
> whether it's an ELF file or a raw binary file, the data has
> to be in the right place. (Generally when objcopy creates a raw
> binary from an ELF file it doesn't change the address where
> the data is, assuming you load the resulting raw binary to the
> right starting address.)
>
> -- PMM

It was a problem with me loading it to the right address. Went through
the manual again and I found that the ROM address starts at 0xC000.
Hence I was supposed to load at that address. Loading at that address
places the reset vector interrupt in the right location. Now I get the
right program counter value which is 0xC000 which is the code in the
ROM.

I went ahead to check if I now get the right opcode but I am still
getting zeroes. Digging through the code when I do the following for
translate:

static void translate(DisasContext *ctx)
{
    uint32_t opcode;

    opcode =3D cpu_lduw_code(ctx->msp430_cpu_state,
                    ctx->base.pc_next);
    qemu_fprintf(stderr, "Opcode: 0x%x\n", opcode);
}


cpu_lduw_code calls mmu_index callback. In my callback I have

static int msp430_cpu_mmu_index(CPUState *cp, bool ifetch)
{
    return MMU_CODE_DATA_IDX;
}

Here I have just set the MMU_CODE_DATA_IDX to 1 which I know does not
make sense. I am not sure how this index is supposed to be computed.
Any idea on what to look at to understand it?

-Gautam.

