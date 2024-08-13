Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57661C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 15:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdtkT-0006jo-Ql; Tue, 13 Aug 2024 11:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1sdtkP-0006iV-33
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:47:46 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1sdtkN-0008KV-F6
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:47:44 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4280c55e488so33220115e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 08:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723564062; x=1724168862; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NK5U+o+suECZcqeUvrfi/E8H1Z0l3hUcMPKzcmWDl2E=;
 b=uJiqhTTyT1SrOmtGr+TSXGW9NBjFFCfjdqrdPslkjN86lZFgL1XQZmiixpkIEXOsIE
 hCZxm8bHmEIW1tqE66t2dtEe00ki1RGbZHhoJRha/MS3Y4a0bf99Y5xaKFf5mIVdoPhL
 g3UMO65h2Uz1Mic1y/bxNWoC6zGT1bUSwogaAaHX7wJgleYAMVXKRqz7/ouLNHzAyfEU
 mdMZHXS7Qbjk3DRV/oyZs0b4xEseMqBSDEFw4GAHW0tGtrGHQatXff8FPrp4F1qyUbrv
 UKybLj1H4Xh+qYMqGF9iQQh6c932pph3brBIIES4jnwQB1pUjF9TAPbAG7fhc5X5w1MQ
 65Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723564062; x=1724168862;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NK5U+o+suECZcqeUvrfi/E8H1Z0l3hUcMPKzcmWDl2E=;
 b=FiV6Dw9Zi7aol/mDvmeh/2fuoHN5x3JjVtfJ3SNjRLCLzuG0TIguIceqCko4GDOa58
 36zObDC7LdzdqNIZQzRjJpMqHVe7Dxdyp9itcUX6gkaBRQTrV3eYMgHsLXatcV0ra8it
 zV6BYHoQeoA7ImCEueROa4WsfHZc1OP+zemXOapm9N5UDKJ1D/x7/zWw6ylGV2mskBbn
 fSvelQulS4kOQQ3bLZZ4QwZzcXs95nOv/Yv16bCcHQSRZyavJS8PkMANnrJTg5mYfLKP
 yoznfcDnki9LnfMS7qE2Gf0AltEhQc+TJRzsURap0xiYwDJLAz06V20Xkz75k295H0tH
 SedA==
X-Gm-Message-State: AOJu0YyNlTozOCFxQZuMmF35s7WFB/qpu+fUJ1YmwY4rywLgxzhPcsp5
 +uJ4c3ORsmMw0EwCnhxKQ32euAD6RBXxqjU/D2kvdrhVv1IDrV9nJE3lAFrVv8T+ACbughFrscv
 jKfCI7ANBzIConxcN0FH8HgULAzq5gqmZY8h8NnhcTDz0ZofBgA==
X-Google-Smtp-Source: AGHT+IFe1sH4WBf/ocbU++rBmFQG1rMIhYX0SNUNn3zqCwb6TwYrCFqAUtIT/c4jFdMc46s/OfAGMXXN6rq9MXKqTXU=
X-Received: by 2002:a05:600c:4f44:b0:424:8dbe:817d with SMTP id
 5b1f17b1804b1-429d62c4b01mr33398615e9.10.1723564061512; Tue, 13 Aug 2024
 08:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
 <20240805201719.2345596-4-tavip@google.com>
 <CAFEAcA82c_RZ6512dB1OxpAtinRctkZK7ZyjpxX16Wk7DYZDPg@mail.gmail.com>
 <CAGWr4cSiNOm1mL6ZC+Dr8bFHz9Dx2R78_we9wL=W6f3FExb-kQ@mail.gmail.com>
 <f73d3122-28f1-42dc-afaa-453cd2cfb6b7@linaro.org>
In-Reply-To: <f73d3122-28f1-42dc-afaa-453cd2cfb6b7@linaro.org>
From: Octavian Purdila <tavip@google.com>
Date: Tue, 13 Aug 2024 08:47:29 -0700
Message-ID: <CAGWr4cQ1zWtcm6uU4=eOepiNg6LhZ_rq_RHYx5MicwHHP7Apkg@mail.gmail.com>
Subject: Re: [RFC PATCH 03/23] scripts: add script to generate C header files
 from SVD XML files
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=tavip@google.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Mon, Aug 12, 2024 at 3:43=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/13/24 03:56, Octavian Purdila wrote:
> >>>    typedef struct {
> >>>      ...
> >>>      union {
> >>>        uint32_t PSELID;              /* 0x00000FF8 Peripheral Select =
and
> >>>                                       * Flexcomm module ID */
> >>>        struct {
> >>>          uint32_t PERSEL : 3;        /* [2..0] Peripheral Select */
> >>>          uint32_t LOCK : 1;          /* [3..3] Lock the peripheral se=
lect */
> >>>          uint32_t USARTPRESENT : 1;  /* [4..4] USART present indicato=
r */
> >>>          uint32_t SPIPRESENT : 1;    /* [5..5] SPI present indicator =
*/
> >>>          uint32_t I2CPRESENT : 1;    /* [6..6] I2C present indicator =
*/
> >>>          uint32_t I2SPRESENT : 1;    /* [7..7] I2S Present */
> >>>          uint32_t : 4;
> >>>          uint32_t ID : 20;           /* [31..12] Flexcomm ID */
> >>>        } PSELID_b;
> >>>      };
> >>
> >> Bitfield layout in C isn't portable, so don't generate this kind
> >> of union-of-a-integer-and-some-bitfields, please. You can
> >> generate FIELD() macro invocations (see include/hw/registerfields.h)
> >> which define shift/mask/length macros that can be used with
> >> FIELD_EX*/FIELD_DP* to do extract/deposit operations.
> >>
> >
> > I see that C bitfields are already used in a few places in qemu. Could
> > you please elaborate on the portability issue?
>
> Bitfields are fine, so long as you're only using them for storage compres=
sion and do not
> care about the underlying layout.
>
> The moment you put them into a union with an integer, clearly you are exp=
ecting the
> bitfields to be in some particular order with respect to the integer, and=
 that is the
> portability issue.
>
> In particular, big-endian hosts will generally flip the order, layout sta=
rting at the most
> signifiacnt bit and work down.  Other compilers will pad bits for alignme=
nt in ways that
> you do not expect.
>
> Just Don't Do It.
>

Thanks Richard, I appreciate the detailed explanation! I will look
into the approach Peter suggested.

>
> r~

