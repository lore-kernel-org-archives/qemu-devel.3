Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBC9CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 23:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v30cX-0006p4-F8; Sun, 28 Sep 2025 19:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v30cQ-0006of-LJ
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 19:15:50 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v30cG-0001Wt-DP
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 19:15:50 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-63163a6556bso8990722a12.1
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 16:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759101327; x=1759706127; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CcgCF11bfU++EiuxZ0IOjTlhcReYjdNxkSoJDibSwG8=;
 b=iJPQ7TrAcphXKDGO8ZtqdLdE00LAlT7c4yr3aFRBzMDSJVFesSCjrNv1Jfq8WhMaDX
 nZ25tmZsw9eC0eTe7Fur1Koz1PKQ86AC7PfY8fKAaQ03gQFGVMr5f1hmXU22BgnjF9p3
 iM3P+Fs1i72Y4750MZnXFDC6287KL2iaAZRP40VSngNfDSZZlUcfG/aPfWc3ygHho0dG
 5A26nGoPcWV21Jg9Vl4cmNNLq00p6zHhYupPHqa/Mox9oijxE6CJkoGnnrLdSm6PE62I
 8cPJgv4zhgUB02RBgPTkElTMpYq5JoPVBCMnEFT0MA2DrqID+x+FmN29Lbza9a3SYHnv
 1LUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759101327; x=1759706127;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CcgCF11bfU++EiuxZ0IOjTlhcReYjdNxkSoJDibSwG8=;
 b=V9gVt+p5Uf+qGzYHsKuypVpVd5sihEHTcLdHoxpwjrpoyndL2SGVMLRTo0YHHN9mdX
 h1ydmk+Ji7EkHbbh2esQGw232BFyw6Ceb4ioOA03cIu8MdxFWu7qFrolh7AonF6v0O1+
 sjFLl51ddTUxKJS332LjF92LXR8OW9gYZnJKFOlKJUSnDtM+VNciTPcgozAva5n2JVl5
 GSUR0p6QwcmenxXaodv0D+VHliLFJ06Hz2aVVRy5ZpnoJ/fE3Cz5/5b0MvPfidmMANkm
 y/j/lTu1Q0IShm/jWcjxJH3VpHR/wBHLS8Ec867bjEt7Y+NWSzCAjGUMKs0Scn+Ei8sx
 DU0g==
X-Gm-Message-State: AOJu0YxP0pvGxGBT7xCygJaoH2W5At6T9cFdcAM0u6Mgj/SvzFe81ife
 Jz6gjiLVjwmjiWMlcywusyrDHzqT7FE6FXkyRT1yIG05ykf3gtUs9YqVplwFwb8deH8ZjfMH4Zh
 9iVk6npJYA96nU7tFrqkU2sDzmHv+tLByPQ==
X-Gm-Gg: ASbGncvk5fQ6w+1U44/P67JxNuTouoROvKMIhVii25Moz6AdSQQC82NxUnJjQHgX722
 oFCcnBwofb8aLV4MUojxNdpaoQmuStdSiu96tmOYT6jgSVb/sRE+ici1YhQ9Yv5cNw8VQH/Xdz4
 aGQHNgYDTnMLtnEQwG/qGH5DcQXyYuqhytxr3sTvLzfsKymkXy/CkRqyMdhT2BVWJ/EbXlcVtMt
 hfdyCN9uf4i7SmleIdNo7+WzKI5CCqnbdSLvZi/yyzWBchz
X-Google-Smtp-Source: AGHT+IHI9k9dCEYmTxoPYW5hVdshQGEgvEGK7hk0PzycYrtBgukvYgVj73lTufG72NMfRr5SGCm85lNrYSgrAnQN2UA=
X-Received: by 2002:a05:6402:24c9:b0:62f:444d:c29a with SMTP id
 4fb4d7f45d1cf-6349f9d2632mr11989237a12.6.1759101327093; Sun, 28 Sep 2025
 16:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250924072124.6493-1-anjo@rev.ng>
 <20250924072124.6493-3-anjo@rev.ng>
 <63d16a48-f5ad-4357-a33b-09a157d33826@linaro.org>
In-Reply-To: <63d16a48-f5ad-4357-a33b-09a157d33826@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Sep 2025 09:15:00 +1000
X-Gm-Features: AS18NWAwpRntLdkE5hiYQiG9rRYDKFHU3L0J2sXiKPOMUKKzXQthwEiVy8_QAr8
Message-ID: <CAKmqyKP6oeF5Xy868A3D=4yZR5_=gFbSt9J2wzPB7Gr1RmO2dQ@mail.gmail.com>
Subject: Re: [RFC PATCH 02/34] target/riscv: Fix size of trivial CPUArchState
 fields
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, "anjo@rev.ng" <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Sep 25, 2025 at 7:37=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 9/24/25 00:20, Anton Johansson via wrote:
> > +++ b/target/riscv/machine.c
> > @@ -84,13 +84,13 @@ static const VMStateDescription vmstate_hyper =3D {
> >       .minimum_version_id =3D 4,
> >       .needed =3D hyper_needed,
> >       .fields =3D (const VMStateField[]) {
> > -        VMSTATE_UINTTL(env.hstatus, RISCVCPU),
> > -        VMSTATE_UINTTL(env.hedeleg, RISCVCPU),
> > +        VMSTATE_UINT64(env.hstatus, RISCVCPU),
> > +        VMSTATE_UINT64(env.hedeleg, RISCVCPU),
>
> You can't change these sizes without bumping the version id.
>
> I don't know if riscv really cares about migration stability yet.
> If it does, then you have to jump through more hoops.

Not really, I think a version bump would be enough

Alistair

>
>
> r~
>

