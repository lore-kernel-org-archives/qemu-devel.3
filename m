Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765BEC0218D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 10:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdoGj-0007JL-0e; Fri, 31 Jan 2025 05:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdoGg-0007IN-TL
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 05:28:59 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdoGf-0005vH-Ay
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 05:28:58 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6ef60e500d7so7219147b3.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 02:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738319336; x=1738924136; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AIzgxMNNvVKwS7p5xzkcLVgNTp8OlmZD/2aBrwjOgQ0=;
 b=b4gLne9h9R3n0kUv+WhuCZa6bqE55FU1+SDqFdVQZdkqYihdl/p09t2swaqhze26Kp
 6+G1B/Fbb0B1RmT87xlVOGVzP+H87XGhD8wPhg8tBaATBdYOtjTDzgXakXTcH0xtBgmI
 PdNmHB7xcND4gGfoVkt8PpyuNCEojsLXTF6f7oVNgS5OOJoWdJG6Wa8sfAZYkv34k3cP
 GHoynBNmnS9jPhZuBwg8iTeRHBt0EoPDj+R4Crc8dkbP388RQJmNgZMZsaPKjMmRydXb
 K6IHoAE7NFwA3xDJNHBIxFm72rxCY4wz4kjKK0RrHy0mNKSNXNa+LD+92/a7OTxtaS+c
 aWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738319336; x=1738924136;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AIzgxMNNvVKwS7p5xzkcLVgNTp8OlmZD/2aBrwjOgQ0=;
 b=HQGMXKwTdg+aeZE3WP9Z+TrEiWscFNaUgDxl6ckfuESdyCT8OAcgoXZzyDtclcLQzD
 Kc9vttlT1XcJRuM72WxqpL59YxH7kyv0ln1xa8dM5v3QRyqRBMf45VzlMlDyAF3GrM0C
 PY65o/1xRtMEblTvlBJtZ+vCbW364B4JTisNZ0K4KWVbbHY0wAJBeza3MNv9TzIJM/QZ
 TqP1Jay6syiLoUHNPREwZ0AqPxAoXjItHUVtjz6dN3tQjs6PMM7MslMcahkX/gaSA26G
 kMtzBDdBcinYqV9TPyMQFggGfUTwKAX0Zl3Pu6FKdIQzh4DYailoqFWSSGjlqomdx3YD
 GZuw==
X-Gm-Message-State: AOJu0Yx1Mee3mOLV130Unbcr1IUcv8kI28YzMO1D/wm9/CJuVIOWFwf6
 /0GuBgZ01lkWU0p8N/yyGg7qjZycdGwuakzENagda6gggeAbgFeVmSJ5W5c0vMRF8tonXWhTKZa
 2dEFFp1pRyh/FItAPyRDSBJBiDJaSvX1thnZuMkkf8XxMi3ax
X-Gm-Gg: ASbGnctdxNgUDSPqvuaLmNM5vx4NosS97++UbRSbjUXEb+W+MZIyOOchgTGESmH0gyz
 5ni+BIhlxW6S4Cuy92Ty8culOvdKODQs/LtcwmTzqoRW2FcAeGLJyXBqm+Bncj9Fjr+29/P4c/A
 ==
X-Google-Smtp-Source: AGHT+IGHdU8WWuHojyByzYpEyq0a26j4H86bLwe0bnMYLWwYiTxHVa1frlnqouAXBX72a6+UmfhC9Kp04v7G1c4LE44=
X-Received: by 2002:a05:6902:220d:b0:e44:e084:52c0 with SMTP id
 3f1490d57ef6-e58a4b1aea9mr8413959276.23.1738319335932; Fri, 31 Jan 2025
 02:28:55 -0800 (PST)
MIME-Version: 1.0
References: <96e999333e9b49fcb60f051a29d41c83@tachyum.com>
In-Reply-To: <96e999333e9b49fcb60f051a29d41c83@tachyum.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jan 2025 10:28:44 +0000
X-Gm-Features: AWEUYZkBeTAuasbxt2jiQ3ely55vLDb5RTkC_9Gjivo4XP7QeYrUE4i_jWV3bqw
Message-ID: <CAFEAcA_kUUwupSjDTN=gtj9XrMYchGf566tH6xXmysLf6Jri+A@mail.gmail.com>
Subject: Re: x86 denormal flag handling
To: Michael Morrell <mmorrell@tachyum.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 31 Jan 2025 at 02:03, Michael Morrell <mmorrell@tachyum.com> wrote:
>
> I=E2=80=99ve been following the recent changes to better support denormal=
 handling and I don=E2=80=99t think they are doing the right thing for x86.
>
>
>
> I tried a simple program to convert a denormal float value (0x1.0p-127) t=
o a double.  With the default of DAZ being 0 in MXCSR, x86 sets DE, but QEM=
U doesn=E2=80=99t.  This is the opposite behavior of AARCH64 which sets the=
ir denormal input flag when it flushes a denormal input to 0.

Yes. None of the changes to fix denormal handling have
actually landed in git yet, so what you see at the moment
is still the behaviour QEMU has had for years, where it
doesn't either detect "this denormal input was used without
being flushed" or set the MXCSR DE flag with the correct
semantics.

I have a work in progress branch at
https://git.linaro.org/people/peter.maydell/qemu-arm.git/log/?h=3Dfeat-afp
which has the new handling and also at the end the target/i386
changes to get the DE flag right. If you build a QEMU with
those patches then it produces the right result with your
test program.

thanks
-- PMM

