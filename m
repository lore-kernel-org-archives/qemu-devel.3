Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFDFCD4F4C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 01:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snTPd-0005ne-0f; Sun, 08 Sep 2024 21:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=lpTo=QH=zx2c4.com=Jason@kernel.org>)
 id 1snTPa-0005mN-Nu
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 21:41:50 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=lpTo=QH=zx2c4.com=Jason@kernel.org>)
 id 1snTPZ-0006zo-0F
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 21:41:50 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BD5835C53FC
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2024 01:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0390C4CEC9
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2024 01:41:45 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
 dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com
 header.b="h5mgg8pM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1725846102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w1I5L+YOou9JS/ZZtOodgGokkVkYbrdJq7nRqvEmHKs=;
 b=h5mgg8pMaZobHBDc/cgS6JtFI/ndlif3yyIUaqJxikQQNBS87StMtNynI467NNs+kdyUk4
 503NKYSZvf3YNB0JHoWMSTcEwy9HP+v3UhPkOOwkX3ZzpA/lRS5Os5SSAWvpFJDzqfkwY0
 HJDbSMjor4CREhrcwE9oEoMHWTY+Dxg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 213b6bd1
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO) for <qemu-devel@nongnu.org>;
 Mon, 9 Sep 2024 01:41:41 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-2705d31a35cso2330243fac.0
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2024 18:41:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXetVsPa1m00s+9eqQ4mMMpDTWet2+Mr5i6T1ID0WKLTqTv1kvfWFf5kJLXoo1FmnvVlB2ylOTOaidW@nongnu.org
X-Gm-Message-State: AOJu0YymHx0+ndQktpSMAxSXR9fqsYI6ideMqtBrlguHJWMmSrJb63Zi
 FpMWuoJKpXPE5OeKRsP58lGeAwyOkGtAtONgHidkdNWEpgHBk6JsienflhmGgWu+FNcqyMyOUxH
 Frn4zNsjmP647Qfsrw9iQdQlb6x4=
X-Google-Smtp-Source: AGHT+IE4L4TdeL1QnWdW4Jm8+ZQjeQNdexoLuBd7vG01dF/uLxwZ+r+RbRwBcGdYTBk9RJ2rGpjqOb3ABnXqc0Sx9oY=
X-Received: by 2002:a05:687c:2bea:b0:261:211:9d0d with SMTP id
 586e51a60fabf-27b83029fbcmr9727051fac.40.1725846100748; Sun, 08 Sep 2024
 18:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240905153316.2038769-1-Jason@zx2c4.com>
 <73975d81-763b-fe04-5aa9-626a7767a3f0@loongson.cn>
In-Reply-To: <73975d81-763b-fe04-5aa9-626a7767a3f0@loongson.cn>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 9 Sep 2024 03:41:28 +0200
X-Gmail-Original-Message-ID: <CAHmME9q3CeJ0tPW3QbSEuvRFgQLpgFstEhif5qLGqbMi-R_Ehw@mail.gmail.com>
Message-ID: <CAHmME9q3CeJ0tPW3QbSEuvRFgQLpgFstEhif5qLGqbMi-R_Ehw@mail.gmail.com>
Subject: Re: [PATCH] hw/loongarch: virt: pass random seed to fdt
To: gaosong <gaosong@loongson.cn>
Cc: jiaxun.yang@flygoat.com, qemu-devel@nongnu.org, thomas@t-8ch.de, 
 xry111@xry111.site, maobibo@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=SRS0=lpTo=QH=zx2c4.com=Jason@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -67
X-Spam_score: -6.8
X-Spam_bar: ------
X-Spam_report: (-6.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

On Mon, Sep 9, 2024 at 3:38=E2=80=AFAM gaosong <gaosong@loongson.cn> wrote:
>
>
>
> =E5=9C=A8 2024/9/5 =E4=B8=8B=E5=8D=8811:33, Jason A. Donenfeld =E5=86=99=
=E9=81=93:
> > If the FDT contains /chosen/rng-seed, then the Linux RNG will use it to
> > initialize early. Set this using the usual guest random number
> > generation function.
> >
> > This is the same procedure that's done in b91b6b5a2c ("hw/microblaze:
> > pass random seed to fdt"), e4b4f0b71c ("hw/riscv: virt: pass random see=
d
> > to fdt"), c6fe3e6b4c ("hw/openrisc: virt: pass random seed to fdt"),
> > 67f7e426e5 ("hw/i386: pass RNG seed via setup_data entry"), c287941a4d
> > ("hw/rx: pass random seed to fdt"), 5e19cc68fb ("hw/mips: boston: pass
> > random seed to fdt"), 6b23a67916 ("hw/nios2: virt: pass random seed to =
fdt")
> > c4b075318e ("hw/ppc: pass random seed to fdt"), and 5242876f37
> > ("hw/arm/virt: dt: add rng-seed property").
> >
> > These earlier commits later were amended to rerandomize the RNG seed on
> > snapshot load, but the LoongArch code somehow already does that, despit=
e
> > not having this patch here, presumably due to some lucky copy and
> > pasting.
> >
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >   hw/loongarch/virt.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
>
> Reviewed-by: Song Gao <gaosong@loongson.cn>

Do you generally queue these up in
https://gitlab.com/gaosong/qemu/-/commits/loongarch-next/?ref_type=3Dheads
? Or is it a different branch?

