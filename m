Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F77BC4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2024 20:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvkLM-00011n-2N; Sat, 13 Apr 2024 16:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1rvkLG-00011C-B5
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 16:51:18 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1rvkLE-00053w-4I
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 16:51:17 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-dcc73148611so2184873276.3
 for <qemu-devel@nongnu.org>; Sat, 13 Apr 2024 13:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713041472; x=1713646272; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9raaTjLarnfdUxg/7rmYQp389Sww0rkzRg3mqOsN8Rc=;
 b=Fxfp6G7wJNMYRXkVOzieRrnKdtlFQ0ZR0DsV4RqDoUdtxhQpmvGO4q6sxoQQyDxx5S
 PzX9MQeYTmqdDsgS8H9LVfPMDWdNqJYKNeM8FB3oH4V32ZjGAXRok5viR7sTySfSIA21
 sADxhD2N0/Ln4+2dIUZ5v4Vc5r4sYFIRFb/wqSJeqmC8hq/jrDU+9MiJDKUq3ST42yyv
 35pSFA0uYRoHajyHe9gAuXOHyIP1pXkI/BIDljGkgxHngowRJqSbzF7vXyWRzaIeJMYC
 n3boH++BiPl7ybRhuqBJ/p0CiLIrQsYlxCcecA85uSUlK4Qg78hF93ewdqI7b8BgM18G
 zJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713041472; x=1713646272;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9raaTjLarnfdUxg/7rmYQp389Sww0rkzRg3mqOsN8Rc=;
 b=gOFgaDuDtIBX3iYIo5u5WDUBlaIn9YKB1iA8vvaIH7M5Wz7qkq9eC4pjvqyXpxpGj3
 2fMMALvDvuU4I6PtFAYwvrZLcGXt2DiXocCoZFUJu/3Z12Sd7pf8ZAqut2nEGl6HyxEd
 3tOF9d2nE1RIPB7tPSnXnVK2Tr7f3BUK+OLE0Dj/dZeDxXQESmW7X2T18pvSO78JGBZs
 pHMUkLsEUii8qumN8oE4PSsBIDdM3qaONAUlj0HiNkODJTLTwWAQ+//2PE6F+VWgjqgu
 onBm7bq/BM3HOxlM79zn6lu2+S1a4I40M29o+Wo/LmENgLTWklzbeCi5lF7NIB205Ivp
 6JEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDEgsYQkUSepWLeptiAo3wWhnCxRJCs92xdByQtUEFV84dVGXOPxGcf7thOqdXX6UMx0zMQbQfeU1hKxoCu2N8S6er+r8=
X-Gm-Message-State: AOJu0YzvlGpeJ+TBt4g9re0KsiPoIKKTsYBMPmdSID4TKbtv59zFzLgD
 xNEmniC34JoC8vcAMHj6PPZ4x+lWmHFpyYPOJBrOrHAIY0CVo8uVPz+BQ+QMUeX2Gg/lrnaRb2z
 PSdf5R12oqlrMMk6Wlfhc64hfqKE=
X-Google-Smtp-Source: AGHT+IGy75JzC3PmA07oNdses0P96MX7zn+3oYw/p6y8+RAxnGjYjn7aViCuZ8PVyMigDlCxwnogv7cFIhWBN3O3Z4I=
X-Received: by 2002:a25:ef51:0:b0:dcf:f9bd:fe05 with SMTP id
 w17-20020a25ef51000000b00dcff9bdfe05mr6171509ybm.48.1713041471720; Sat, 13
 Apr 2024 13:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAM2a4uwktAA=Uk9_GRnxusvHhfrZg+EUWjfxy95YgxGsQQntjA@mail.gmail.com>
 <dd957513-1272-40cf-bda5-4d3f717f3c71@linaro.org>
 <CAM2a4uxuY5PGrHLo72+i2p6Cj-1R37kiXOehrhRMKUn3Xaia=g@mail.gmail.com>
 <074ed71f-6dca-4a55-9163-60a9305dd27a@linaro.org>
 <CAFEAcA-fmCNgyczGZaE=otT1x=iVt_-oPwkS308CWkP3wLdhbg@mail.gmail.com>
 <CAM2a4uwMomHgYVQvRV+3UjsjTkE-BOK=zn8Rgv5y7OGjy0HfTw@mail.gmail.com>
 <CAFEAcA-CDgR2r7uNh=PQaQfVspa5tnNTwiK7Dbor7faxY25V=w@mail.gmail.com>
 <CAM2a4uxYKyVJN6GjN8c2fz21eCJxoLh4r3hzqqRMALCHKxt1Uw@mail.gmail.com>
In-Reply-To: <CAM2a4uxYKyVJN6GjN8c2fz21eCJxoLh4r3hzqqRMALCHKxt1Uw@mail.gmail.com>
From: Gautam Bhat <mindentropy@gmail.com>
Date: Sun, 14 Apr 2024 02:21:00 +0530
Message-ID: <CAM2a4uxh-sMfkbFaJ3C_WAkLqkiOh9MeoyF=VZxy8ahVfAw5dw@mail.gmail.com>
Subject: Re: Point where target instructions are read
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=mindentropy@gmail.com; helo=mail-yb1-xb2c.google.com
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

Ah I had my .tlb_fill callback set to an empty function with just
returning true. I need to put the actual code there. Let me fill this
function up and see what happens.

-Gautam.

On Thu, Apr 11, 2024 at 2:45=E2=80=AFAM Gautam Bhat <mindentropy@gmail.com>=
 wrote:
>
> On Tue, Apr 9, 2024 at 2:23=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> > That sounds like a problem with your binary. If the reset vector
> > needs to be at 0xFFFE then it needs to be there, and you
> > should arrange for it to be built correctly. It doesn't matter
> > whether it's an ELF file or a raw binary file, the data has
> > to be in the right place. (Generally when objcopy creates a raw
> > binary from an ELF file it doesn't change the address where
> > the data is, assuming you load the resulting raw binary to the
> > right starting address.)
> >
> > -- PMM
>
> It was a problem with me loading it to the right address. Went through
> the manual again and I found that the ROM address starts at 0xC000.
> Hence I was supposed to load at that address. Loading at that address
> places the reset vector interrupt in the right location. Now I get the
> right program counter value which is 0xC000 which is the code in the
> ROM.
>
> I went ahead to check if I now get the right opcode but I am still
> getting zeroes. Digging through the code when I do the following for
> translate:
>
> static void translate(DisasContext *ctx)
> {
>     uint32_t opcode;
>
>     opcode =3D cpu_lduw_code(ctx->msp430_cpu_state,
>                     ctx->base.pc_next);
>     qemu_fprintf(stderr, "Opcode: 0x%x\n", opcode);
> }
>
>
> cpu_lduw_code calls mmu_index callback. In my callback I have
>
> static int msp430_cpu_mmu_index(CPUState *cp, bool ifetch)
> {
>     return MMU_CODE_DATA_IDX;
> }
>
> Here I have just set the MMU_CODE_DATA_IDX to 1 which I know does not
> make sense. I am not sure how this index is supposed to be computed.
> Any idea on what to look at to understand it?
>
> -Gautam.

