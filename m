Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6F5D16268
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 14:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0LmV-0007Vy-PY; Mon, 14 Oct 2024 10:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0LmS-0007VV-So
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 10:10:41 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0LmR-0008P4-9O
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 10:10:40 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2fb587d0436so4238291fa.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 07:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728915037; x=1729519837; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OE0h5yfKEXli+kTJZ4QmgTQ3TwJFX9AagE3O/U5alxw=;
 b=VAZ6lKMJbuGf/qUZtUPuS9fvVE76KuulG9l6OEd3EqNdhEdajgPAyFvq8qpxdJDR6E
 q2ak6guBr2miSx7niQkaY7zNR+445/eOlW1GVUl/krGeN/fUrbysRlav/zu4K0bRcL1w
 PWsC+DMgN7DyqQU/G445Yc3ieetaW6geC22mWPWsn1omkTCpPyvHUNhlXpPyAp9MwcaR
 uHvZc/D26I8qY8UIldw/UEqvW2layPa0yz4mYAEUI7u9bDyyGcTE+Lf02FWR77VUEUpQ
 TXnXGXnECWfCqilIxmau70YyqL5W2eyPDi7g7lX8Rt8sdIpRAgrCsqj/afYw9F6zkdd+
 My0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728915037; x=1729519837;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OE0h5yfKEXli+kTJZ4QmgTQ3TwJFX9AagE3O/U5alxw=;
 b=k98bjKI9VSCV9gXNeR3cH/iGAZajSsYiJVlpwWG3cQY3ocgT0pPtTeHhiARBUW/11y
 lxYP7yuBum1sasNdwh8tTA5UNj7bB47rKPrQtwqRvYrlJU9PlCadkeFmzV6E3XOyW4AJ
 iX8MlzoUdo2gr0wSyQQwk2nEWmlz6WKpXHj1yPpsgN7hxnd8DzrH/S+9uUgLeu6SV9E2
 zTj37/H5JVaNBCaQBT0BZWO1fw6Y2b3GZn59GwOmatvv1+xPLBh2Q3PSZNLpUIivlzYz
 wsK4+08WlclEbOTnRU2e0ACq6ws/MIGptzNZ85zq9qk4m1DcF8TgecKHznzPk+sjhM9l
 PpOQ==
X-Gm-Message-State: AOJu0YyDQuj9/DtE+EXo+/bI68d0LlMgK81RvjXn6EAcfuMmrxmpDcNv
 ziLhwY/83NSaeIbmO4RH3ZBzk//TzE3qVuXD+PiXogBgpugPlvdvfr+s0KV3qIt+sRf9cubF+BQ
 84H+0C9gmicWHk0EB3cx7qFwOoQp1KQ==
X-Google-Smtp-Source: AGHT+IH0E2QqMCeSCJDUxzEQ7GKL7klf/9r5vq3ZoTxOmIsgMOJoEyQWgJOCQoNKB5TAT1c9K5rahzqTWE5lvse1sEk=
X-Received: by 2002:a05:651c:1990:b0:2fb:4f0c:e40c with SMTP id
 38308e7fff4ca-2fb4f0ceb25mr15811811fa.34.1728915036943; Mon, 14 Oct 2024
 07:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20241010101838.331032-1-r.peniaev@gmail.com>
 <20241010101838.331032-2-r.peniaev@gmail.com>
 <CAJ+F1CJ1ymDa3+R88RL8BF+fi=MwwrEd6_0s6-eG1S=LxZn9yw@mail.gmail.com>
In-Reply-To: <CAJ+F1CJ1ymDa3+R88RL8BF+fi=MwwrEd6_0s6-eG1S=LxZn9yw@mail.gmail.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Mon, 14 Oct 2024 16:08:32 +0200
Message-ID: <CACZ9PQWOS7JG=aqJdKGd+Jjb7fPSz7FYQk8xjWa=fnSj43t9Bw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] chardev/char: rename `char-mux.c` to
 `char-mux-fe.c`
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=r.peniaev@gmail.com; helo=mail-lj1-x230.google.com
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

On Mon, Oct 14, 2024 at 3:57=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi Roman,
>
> On Thu, Oct 10, 2024 at 2:21=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.co=
m> wrote:
>>
>> In the following patches backend multiplexer will be
>> introduced and the implementation will be named as
>> follows: `char-mux-be.c`. This patch renames the
>> frontend multiplexer from `char-mux.c` to
>> `char-mux-fe.c`.
>>
>> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
>> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
>> Cc: qemu-devel@nongnu.org
>
>
> thanks, it looks like the series is missing a cover letter (and thus not =
handled by patchew)

Bummer, indeed, sent only to myself.

>
> Also it seems to fail to apply on master, and I wonder if it will conflic=
t with your other mux cleanup series.

That's because of the "chardev/char: fix qemu_chr_is_busy() check".
In the cover letter (which was never delivered) I specified that the whole
series is based on this patch :)

Let me rebase this series once we finish with the frontend detach patchset
(sent today), so I'll rebase everything from here and mark it with version =
"v4".

Thanks.

--
Roman

