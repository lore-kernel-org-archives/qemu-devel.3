Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE6DC25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 07:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8E2p-0006pO-3C; Sat, 18 May 2024 02:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1s8E2n-0006ne-Od
 for qemu-devel@nongnu.org; Sat, 18 May 2024 02:59:49 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1s8E2m-0002E2-DC
 for qemu-devel@nongnu.org; Sat, 18 May 2024 02:59:49 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-620390308e5so8806277b3.3
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 23:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716015586; x=1716620386; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kpaQVoI9YNAFGuUR2tIRTZ3TM5HhnNISO5Cgr8LOCG0=;
 b=UIqSyGmnD+CMf4uoxgS/+6DT6dxM+dT1Gy7yFOJF6S39igp4+GUlkvU+oe8mdfCeR7
 bAUhrOgZneGSnrYmMfRpBmLqkzNReA0f7x+9jMldOQEzeC/dhDzYUlglDHXcLCaju0Gk
 TKyryi6PHkltK3vK5WTiWGNKVP36BrPcXP8m3ljWV9oYdOLcTAoi8V9aaXBohWxuNI5A
 qEAQfvU/Q0SmkSPTeVMrk8Ak7Eiz1iEuidC+Dhfwh0KvLq2inAzlJsbcbsv/xJIabcbe
 ui+lswPWofKDdW+PKGjeXY9rETe47xHtlSzGKg1tQRd0tC0rL5E9h4QLCW0Xion4s6KJ
 SqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716015586; x=1716620386;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kpaQVoI9YNAFGuUR2tIRTZ3TM5HhnNISO5Cgr8LOCG0=;
 b=muZCriRJ4bP8iTGj+DgfkK9uin6F+B0VBEaWhJshyfBm7SxXrZSyY2hl9UkOD5VvHa
 yu+us5hiMptk2TG6kWij4RYdoKVhJBL45jdb++gZH3hwF0yL9of92Z/u+NQdACQ0YHXG
 0cLqd1fYmWunkXvW7cETD6+/3ZBJ/vT3vA0qTU4tv0yjDVAdd7bsaaF4ZDGhlp4L529t
 S03jDesimKGTYSCBDDYVdyk8ZX9bTy7EX/Y7spHq+Nnvrm2/3uZlRYZf6OdAKXF2Jh3V
 Gr8reXWuRL2QxMiwl0d6itjllbZoqErQf2zNasr3wG3gFRmfHkIWaFhK7cD7clvAw3TI
 l5Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSKID86MR3vHKByntX1psGKI1hAjHShv55+CTReQJWAXvf7IqFc6fgAZFptC/GTDUTOtb2odJt9vXTIDwXAAYCx5Yi9lk=
X-Gm-Message-State: AOJu0YwQlOovBV8is6Ld7r02aSjhPki6bVcStnHq9cgsQDy+TwvJyrmG
 qrj4fXLqkcSgTe6aX2gIMQjsuH71LHZcD2/4rsp0WqskoTbo+/w08uCigWnYyKcSayaZhgLL51/
 7b0+1HSlUtUvCxwtbFD0KE8TRpxQ=
X-Google-Smtp-Source: AGHT+IH8zCBp+0gbgbKZwivcFHjhETfk293rOAXAVVwqBwGelvzVOZFlujYr/dpJXU872VijnxBWTWj8VZT0N531Koo=
X-Received: by 2002:a81:a185:0:b0:61a:fc3b:fdd3 with SMTP id
 00721157ae682-622b0137bfbmr228203267b3.43.1716015586376; Fri, 17 May 2024
 23:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAM2a4uwktAA=Uk9_GRnxusvHhfrZg+EUWjfxy95YgxGsQQntjA@mail.gmail.com>
 <dd957513-1272-40cf-bda5-4d3f717f3c71@linaro.org>
 <CAM2a4uxuY5PGrHLo72+i2p6Cj-1R37kiXOehrhRMKUn3Xaia=g@mail.gmail.com>
 <074ed71f-6dca-4a55-9163-60a9305dd27a@linaro.org>
 <CAFEAcA-fmCNgyczGZaE=otT1x=iVt_-oPwkS308CWkP3wLdhbg@mail.gmail.com>
 <CAM2a4uwMomHgYVQvRV+3UjsjTkE-BOK=zn8Rgv5y7OGjy0HfTw@mail.gmail.com>
 <CAFEAcA-CDgR2r7uNh=PQaQfVspa5tnNTwiK7Dbor7faxY25V=w@mail.gmail.com>
 <CAM2a4uxYKyVJN6GjN8c2fz21eCJxoLh4r3hzqqRMALCHKxt1Uw@mail.gmail.com>
 <CAM2a4uxh-sMfkbFaJ3C_WAkLqkiOh9MeoyF=VZxy8ahVfAw5dw@mail.gmail.com>
In-Reply-To: <CAM2a4uxh-sMfkbFaJ3C_WAkLqkiOh9MeoyF=VZxy8ahVfAw5dw@mail.gmail.com>
From: Gautam Bhat <mindentropy@gmail.com>
Date: Sat, 18 May 2024 12:29:35 +0530
Message-ID: <CAM2a4uzg3d=mnZeVo=N3MdNgQgC0hDD-n5xidbD13nf1S0gE5Q@mail.gmail.com>
Subject: Re: Point where target instructions are read
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=mindentropy@gmail.com; helo=mail-yw1-x1135.google.com
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

On Sun, Apr 14, 2024 at 2:21=E2=80=AFAM Gautam Bhat <mindentropy@gmail.com>=
 wrote:
>
> Ah I had my .tlb_fill callback set to an empty function with just
> returning true. I need to put the actual code there. Let me fill this
> function up and see what happens.
>
> -Gautam.

Got it working. I can see the opcode now. Let me proceed with further
implementation of decoding opcodes etc.
Thanks for the help.

-Gautam.

