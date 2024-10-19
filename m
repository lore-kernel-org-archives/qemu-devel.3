Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1575ED3E1BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2024 07:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t24I5-0007sv-U0; Sat, 19 Oct 2024 03:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arikalo@gmail.com>) id 1t24I3-0007sQ-Gz
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 03:54:23 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arikalo@gmail.com>) id 1t24I1-0007aA-Rl
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 03:54:23 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7e6cbf6cd1dso1995958a12.3
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2024 00:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729324460; x=1729929260; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kS1q0NPHTVlhsCmSHNDMWIxUEhWj6eEggPUKfcZhWMw=;
 b=E6x1G6iU6gWV/YR7wmpSTjdQRCmXaQqwNWh7zoY1uVbLIpFh8Bvbfaorr/w/qkVjMa
 aHNz7OijPLTVjPYW1xLYmQdcJzmIqwgXz6R27O42vjwgl2aq+SvjlBQAvC16ZpfdjlxO
 zJ8rDHpybpwmguvMzyYFyneiKlYAAEg/NHAd20/nE0VnkxQIxA5gz4JZF8y0QHlddpjC
 STXCTfFC5QOMJap9+OkNdnWAmZuu+ti2OKKM7xBfOntuSjX44FPw9Mx6XLqmAMmWuQCy
 g5myCwCSt3d6ruGQH5+L2UuHe2wMvDB3BxJJKLK8iTg7zSmSwGTpLc7x77PfIaARp+E9
 wZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729324460; x=1729929260;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kS1q0NPHTVlhsCmSHNDMWIxUEhWj6eEggPUKfcZhWMw=;
 b=HpNLDCvxv6dQmccZak7WDVkXTCbavNyTY/0dJuqiN0+5TlQV5U3vdmhCmHJhmxm9OZ
 emUfmlmruGzxPOqyok0IRFzPyruWyGbUUH3O5lp5DIAdHBx36wQY2AEEYqQ6/++2UqcM
 cgUaYyh1TNtxNxo9D1qW2yMhHiIqgSkZxPD1mG51d3jpSZkUpUkZazXsPL5nSR+hoKIg
 /hjHDwen3XDTHE0UxKpiH6cwUe60SkRUGcMzjKaPKrZlcK9Ew+LEDE7iE39zsbvEm6nQ
 yYMS3BbzcUTeE3k20ATm7VWr2OoJX/C9ObOyIay3ftzMe3C1o2tyHLVr1+VlC5S+0fRy
 Oq5Q==
X-Gm-Message-State: AOJu0YzkiHxkM9gw+qNou4UbNi9vFfQq2ibH0B3bOoU3aga+HPug48/4
 X0vkyrl/z7LC/Me41T/pP12Xla3EYM0Z5gylFkflYJ9fR1tUJ4wWIP6KqBpn4KMDy1zZypVYJBl
 qsC0dYvt18M66WqGXxDqpNX7Pp9A=
X-Google-Smtp-Source: AGHT+IFXhEXLoufmDqZLu3DDWKk+SU9GQndWEFgth7iNrORkS7QIFq7aM1dVlpCXaI8a/EyHYrrsvS3HxqI3/BOJnxs=
X-Received: by 2002:a05:6a21:3984:b0:1d9:18e2:e0aa with SMTP id
 adf61e73a8af0-1d92c58a822mr7629383637.44.1729324460506; Sat, 19 Oct 2024
 00:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <AM9PR09MB485141F5613A7EBFC5A4A08884402@AM9PR09MB4851.eurprd09.prod.outlook.com>
In-Reply-To: <AM9PR09MB485141F5613A7EBFC5A4A08884402@AM9PR09MB4851.eurprd09.prod.outlook.com>
From: Aleksandar Rikalo <arikalo@gmail.com>
Date: Sat, 19 Oct 2024 09:54:09 +0200
Message-ID: <CAGQJe6pTgoX7xsH2Y-7W5dtAgB0dE6QK2qYU11HAg3a-SGdpQQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] target/mips: Enable MSA ASE for mips64R2-generic
To: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "cfu@mips.com" <cfu@mips.com>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000002b87260624cfba7d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=arikalo@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000002b87260624cfba7d
Content-Type: text/plain; charset="UTF-8"

>
> Enable MSA ASE for mips64R2-generic CPU.
>
> Cherry-picked 60f6ae8d3d685ba1ea5d301222fb72b67f39264f
> from  https://github.com/MIPS/gnutools-qemu
>
> Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>
> Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
> ---
>  target/mips/cpu-defs.c.inc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

R2 CPUs usually don't support MSA, I think we should skip this.

-- Aleksandar

--0000000000002b87260624cfba7d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Enable MSA ASE for mips64R2-generic CPU.<br>
<br>
Cherry-picked 60f6ae8d3d685ba1ea5d301222fb72b67f39264f<br>
from=C2=A0 <a href=3D"https://github.com/MIPS/gnutools-qemu" rel=3D"norefer=
rer" target=3D"_blank">https://github.com/MIPS/gnutools-qemu</a><br>
<br>
Signed-off-by: Faraz Shahbazker &lt;<a href=3D"mailto:fshahbazker@wavecomp.=
com" target=3D"_blank">fshahbazker@wavecomp.com</a>&gt;<br>
Signed-off-by: Aleksandar Rakic &lt;<a href=3D"mailto:aleksandar.rakic@htec=
group.com" target=3D"_blank">aleksandar.rakic@htecgroup.com</a>&gt;<br>
---<br>
=C2=A0target/mips/cpu-defs.c.inc | 4 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br></blockquote><div><=
br></div><div>R2 CPUs usually don&#39;t support MSA, I think we should skip=
 this.<br><br>-- Aleksandar<br><br></div></div></div>

--0000000000002b87260624cfba7d--

