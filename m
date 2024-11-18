Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEBBD10F40
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 02:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCr9T-0001Aj-N1; Sun, 17 Nov 2024 21:06:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tCr9R-0001A3-Pb; Sun, 17 Nov 2024 21:06:05 -0500
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tCr9Q-0006rC-An; Sun, 17 Nov 2024 21:06:05 -0500
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-856f776e3a7so337031241.3; 
 Sun, 17 Nov 2024 18:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731895562; x=1732500362; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/H7c7f2x6LA/ltppe4vQGLsW2Z/ppfjruX1A8lfT/4=;
 b=ULeNfVwXl/uWSxWzDFPR+psGR9M9lZw1p99aC+I8NQKOBZBTqh4GQ9DzlKksvEO5h0
 E7J3cGQ7ngafHrSOZl5tAn1mwpycN3zGu1gx/FaR/BtGmL3Rl3Mblf54Xzs7CoemfOd+
 RFuXE6ErvOScob7BwlzTQf8xzW8GyZqFf01sko5lvNrFR/iMJI9OOquxCAPP+nTgDyk7
 84DhjqdE4wwh9pXgIsUEBSt8ZWHR1RW8W9/AhgNEnbXkMuV03PdV0Cu9rxRPfF9swsFZ
 nrmXnD8hsBKqJSNaRjlYb+rl0dhdfqv30Zbx5HzJyOfafx7nSNWKmt1CS1aX9cO4lCht
 kgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731895562; x=1732500362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/H7c7f2x6LA/ltppe4vQGLsW2Z/ppfjruX1A8lfT/4=;
 b=MhrAt8izbzKge0o4i+ZwQYzeSAsUyx4PeTWylww/b6GG7mq/U6RoRXx4NNZkhMaocr
 G6kk4R4hjXO8WEVoY8BPFJpMc9ZONHP0qmbXAt54q39Ip1itKYBSO2FxnTO2tIPIjICl
 Gzt6NpJXFgAwGwAKTCYElSr1opb2TN4OgXbKBxK7vY+z9HYKDuY9xvDcgVCVsacMg1IU
 omX2yhvM/Mu9wVMDOrkVODl2z/mVyBSX/hd/jU97HVw3Igsh5oFhFYLkCn4OjspeRFg/
 7P8+jUd9hO6uyidxDQtTEUcClOz71/HFr6VsIOI+rs+XErq85rJW1ZYJdMQfhaJJKE8K
 X+pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlt+OwrYeOoesTypVYeXy1X4pnL9jgQw5Dbe5WBnfYl1T3XsLFcQkD/fn2zUlKZGvPMqzN44quSEWf@nongnu.org
X-Gm-Message-State: AOJu0Yw5SfrVnO36UB1eHZHRYIxtYzTdLJL+DLPPsDEzrH+lzl9AIfVK
 7i74HN4ygxDYdnj/RsDTeuQFkpqrl9Jqt+vI2+Yva6jZJsEIrqMdaihvghSgceVRdtSEM+Dtije
 poGdofpVBEirlVgjx8rQ90g8DFM0=
X-Google-Smtp-Source: AGHT+IEEIBw0BLrCVcR9v/ucalH+LAG7gY31jIPh50ydBaEfQDhPgCHaReuSEouPBw7abJ/l0AAxDeAj9xkCV4n9dtU=
X-Received: by 2002:a05:6102:c8c:b0:4a4:8287:6c34 with SMTP id
 ada2fe7eead31-4ad62d334abmr8347189137.17.1731895562550; Sun, 17 Nov 2024
 18:06:02 -0800 (PST)
MIME-Version: 1.0
References: <20241010190337.376987-1-dbarboza@ventanamicro.com>
In-Reply-To: <20241010190337.376987-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 Nov 2024 12:05:36 +1000
Message-ID: <CAKmqyKPFqwQ_H9umX17PAjZ=TmqYGPQHRFo76CkDYaF88amKzg@mail.gmail.com>
Subject: Re: [PATCH 0/8] riscv: AIA userspace irqchip_split support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
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

On Fri, Oct 11, 2024 at 5:04=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> This series adds AIA irqchip_split support, effective when using AIA
> with aia=3Daplic-imsic and -accel kvm,kernel-irqchip=3Dsplit.
>
> The main difference between what we currently have and irqchip_split()
> mode is that, when using split mode, QEMU will emulate the APLIC
> controller instead of using the in-kernel APLIC controller provided by
> KVM.
>
> After this series this is the matrix of which interrupt controllers
> we're emulating based on 'virt' machine configuration and accelerator
> properties:
>
> Accel Accel props   AIA type    APLIC-m IMSIC-m APLIC-s   IMSIC-s
> tcg      ----       aplic       emul    n/a     emul      n/a
> tcg      ----       aplic-imsic emul    emul    emul      emul
> kvm      ----       aplic       n/a     n/a     emul      n/a
> kvm      none       aplic-imsic n/a     n/a     in-kernel in-kernel
> kvm   irqchip=3Dsplit aplic-imsic n/a     n/a     emul      in-kernel
>
>
> Patches based on alistair/riscv-to-apply.next.

Thanks!

Do you mind rebasing this again?

Alistair

