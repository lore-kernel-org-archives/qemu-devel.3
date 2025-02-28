Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97999C282C5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 06:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tntZQ-0006sQ-M6; Fri, 28 Feb 2025 01:10:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tntZM-0006pc-10; Fri, 28 Feb 2025 01:09:56 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tntZJ-00036b-Hi; Fri, 28 Feb 2025 01:09:55 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-86b2d91997eso1467587241.2; 
 Thu, 27 Feb 2025 22:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740722992; x=1741327792; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8tpX0QXusqm71My0oeMF45RzF/IwtbgiwlpqAZt96U=;
 b=X34UzMbJPdjt03YqwmmcUJbjxWA63gPUfRt8kcKjgAph9NQlPd6hceA6MUNDWjBzyB
 i+mzMjHbRTzWlqz7qoIuBvPcSnBeGAHxYcG9IJ2csA6wlHQ+42IivQEjKQvPJl67emY8
 Mf5kBKk20SsC1zUevP/hED8m6LkHgJi578hCaihdtF6oC+2Adv5fDWM0lj9B4BSmG1vw
 /WfArT+gZ5T0eywtQHDp0BunBpTqCganfcWPw0CVSNhVY/GQreEA486Cu0nPl9WBfrdD
 7VVyTYGkw1pQ7ymOOIX2TVxbCLwvPhyWJDOz/1b2wLKxbgghJzLinbUK8JZKPk7/mhfN
 8iMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740722992; x=1741327792;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l8tpX0QXusqm71My0oeMF45RzF/IwtbgiwlpqAZt96U=;
 b=aEF5zFSytV1cOd6a10HXu7yqHCiHzkee5snMpzsi4Xy23bzJo3Ly7ggX9hjvNMypSi
 lzsVdiYNC4JDPzinEdq3foTMaRSLnQ1iHDgoycYif/1J5NG3s9riMV5H+rV6Qz5uLAv7
 wYT9EB5+RMLf7C5Jj0HHVd6aDRo8e5pfReYT38sJByBmJI5X3EjXs9O0hfmb0N4ejOAh
 Ek9h5/oXAsG19C76t72xfPlz6vojaL+xfj7BMQEg9hbIO+yc+As0fHe3mhMpBnI3baee
 kkXNAiz41zDL6RFcAzMh7cwxMX0UIklz+GFs8CV0cN8BY8mUDQKZz5+egT4sOHbZ1Qgo
 OriA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCYyG1px433pnsK0M6n7ZcWh0oGBf7GLGZMtOTnB+mBG/kKs0zBvTsWyxT5d39lAGW4KjYIoSlcCzY@nongnu.org
X-Gm-Message-State: AOJu0YwV6puq2VBUUl67xBvyvw3ivUg1yEVXTZxGww64Dlnw4FN8bPbH
 8mj6ZSiKPcPJ5PR1mYVsaLkV6v8W3sYm+kCkMjeELcdQZxeGqPW5vGTDccWTl2RDtSUnByVOTII
 VrB09Ap8DfyTmtJhZmMrewc3G/IA=
X-Gm-Gg: ASbGncslYbKJbwtTEL85WUNo28PaxUNjnz/rQqNQ9QTRaGMWyuANGrlIxW9J5QhtXzO
 ARRmg53qwZB21h6fpZ+uT68Zgt2ZSgM0hCNyA3Coi7KRZMnMZH+mKghmc27UWLMLDw6VypQiPMM
 K9IW6WoOOykX8mFzSP9DtOxl1rLCOPi/s3VXDg
X-Google-Smtp-Source: AGHT+IGCj22TMp290nWcnl56HkASQhasEqEElWmEcHLKtHcZroQDe9rqMXofy4dx5VuSsGgSTwcHh7Qq5tsKeOoZYeo=
X-Received: by 2002:a05:6102:570b:b0:4bb:cf34:3757 with SMTP id
 ada2fe7eead31-4c044d5c786mr1933724137.17.1740722991844; Thu, 27 Feb 2025
 22:09:51 -0800 (PST)
MIME-Version: 1.0
References: <20250224025722.3999-1-yongxuan.wang@sifive.com>
In-Reply-To: <20250224025722.3999-1-yongxuan.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Feb 2025 16:09:25 +1000
X-Gm-Features: AQ5f1Jr3Y2NaTjVFkdtCMm__NVvqwWPkStxEpBm8veo0jWrCacUh4wJ2lH-L6Vk
Message-ID: <CAKmqyKP0x5uKMnLLzFSE1v-+5i7B4M-4B7BbC+B8Sdbn+5+G4A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] riscv: AIA: refinement for KVM acceleration
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com, 
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Feb 24, 2025 at 12:58=E2=80=AFPM Yong-Xuan Wang
<yongxuan.wang@sifive.com> wrote:
>
> Reorder the code to reduce the conditional checking and remove
> unnecessary resource setting when using in-kernl AIA irqchip.
>
> ---
> v2:
> - remove the code reordering of the riscv-virt machine since it can't
>   work with NUMA setting. (Daniel)
>
> Yong-Xuan Wang (3):
>   hw/intc/imsic: refine the IMSIC realize
>   hw/intc/aplic: refine the APLIC realize
>   hw/intc/aplic: refine kvm_msicfgaddr

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  hw/intc/riscv_aplic.c | 73 +++++++++++++++++++++++--------------------
>  hw/intc/riscv_imsic.c | 47 +++++++++++++++-------------
>  2 files changed, 65 insertions(+), 55 deletions(-)
>
> --
> 2.17.1
>
>

