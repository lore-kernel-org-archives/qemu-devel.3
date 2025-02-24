Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71814C021B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 07:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmSjI-0004Yr-E8; Mon, 24 Feb 2025 02:18:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmSjD-0004XT-VY
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 02:18:12 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmSjB-00027y-TE
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 02:18:11 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-472087177a5so54601101cf.2
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 23:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1740381488; x=1740986288; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+InCRXc+1IOh7POCVfRD3O7joLY9IeZahyz9Seq3/Yc=;
 b=lwoasXETD2DoNUnIi3MMhteBqtvct78sZKn68395H5/MPbwTL0zGo1uHsQxis8AKIo
 W9tHza3t/m4bahzVOGgragjmaDDN8aKCmNR+a+5+PZ0qa+GIyQbl89eTdd76r6dXOqrz
 uUNxfruW19/h9lyIdXBePmbsCg1W9W8XwUKR1hw1X+tpyKd9nmr8/rNohmMiX9d6DB80
 ZvVuAPrKXbTthmTwCAESPwf9ml2FB+wAmkJOse68uzZco9okrHU2iAIw2HRPei07p+/N
 KR0Rb79k9mu0W+TKHIkCVjwXDxVRmscBch8MgRp70I5tnteKL7zAyAdPWZQqsrc1+ysB
 rIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740381488; x=1740986288;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+InCRXc+1IOh7POCVfRD3O7joLY9IeZahyz9Seq3/Yc=;
 b=ldgPdnAb9XyuGY1v4PGLQG98pPsmFyJXlmmszVlBxtnjnz1iowu7Cc9v9rZS38kF+5
 1HPedPFEfmXONJaJOmOAXCRJIdTKZhlulhjL1BTSVvCgBiWIrft6o9TuV+w6rwJFmAW4
 d08X3qeRzmf5u6NtzjyFJSFemuqGUL54CH9VscC94e1YxBXiNbGHUYrV5SIsyfCISZtj
 ajp6yDbI8pb64GHJ0rZq3bXMOw660v3josztpAwAITRVdbY5SbEdE3lxB6yKs2fu3YYQ
 NRgDt7WQZHEFzPQU4Bvhbanf4KV8gk8w19dGi/Z5/8XE8gdnaTvBDgjz53yzAJCvv01U
 1svg==
X-Gm-Message-State: AOJu0Yyc2Pq7xHWFskC4q6FZJJy51MjEAyy2NZ1cKHGj8OjLSC1MUKXT
 LUgElBmfx8da+Fug/O3H1MMObK0/ghXXxC6RrDMbAtPEl+EKNLtyQa/1P4Va/JkBY/nC2o0oQ7P
 KuI1KuA9AlD4j7RiWemz0jEFQBnZOHkVcczpfHg==
X-Gm-Gg: ASbGnctDEIRjpVKQ1oG7XUIthjzYCkWGfo5tfcwShiKiLV+ROwiZg8ENs+Pnf1u0Z1K
 vG6/aOGouurhGLvXOUUXniInczPU3QkfJNW5K9sb62/6OQ9qKq4KogysDDdrO9eX7QcSoG0fUqY
 6zzBu0XrddIw==
X-Google-Smtp-Source: AGHT+IHQ1Owu0CoZuyOSpo8LlUmOa37QtQTYznv2Tn2M1UXCJazBOz7X2eH6NYiz9xI0AP2m/P64CQvahhgvKGpeo+4=
X-Received: by 2002:ac8:59c1:0:b0:472:6aa:d6be with SMTP id
 d75a77b69052e-472228cfc49mr122287381cf.17.1740381488359; Sun, 23 Feb 2025
 23:18:08 -0800 (PST)
MIME-Version: 1.0
References: <20250217081730.9000-1-yongxuan.wang@sifive.com>
 <Z7Ss5F3t4R2GbIcu@gezellig>
In-Reply-To: <Z7Ss5F3t4R2GbIcu@gezellig>
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Mon, 24 Feb 2025 15:17:59 +0800
X-Gm-Features: AWEUYZndvaF1Z7BcsEcn4kW96qUzqlGu7l-WxEf1ixOnfUao7yVFJqUTucbeNqI
Message-ID: <CAMWQL2gDNMD4UeUr6ti2AFUKdhLpbKeYXHUbUALufsLOW8huAQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] riscv: AIA: kernel-irqchip=off support
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com, 
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-qt1-x832.google.com
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

Hi Kashyap,

On Tue, Feb 18, 2025 at 11:53=E2=80=AFPM Kashyap Chamarthy <kchamart@redhat=
.com> wrote:
>
> On Mon, Feb 17, 2025 at 04:17:20PM +0800, Yong-Xuan Wang wrote:
> > This series introduces the user-space AIA MSI emulation when using KVM
> > acceleration.
> >
> > After this series, RISC-V QEMU virt machine with KVM acceleration has
> > 3 parameters to control the type of irqchip and its emulation method:
> > - Machine prop "aia" controls the type of irqchip
> >   - none: use PLIC and emulated in user-space
> >   - aplic: use AIA wired and emulated in user-space
> >   - aplic-imsic: use AIA MSI, emulation mode is determined by
> >     "kernel-irqchip" and "riscv-imsic"
> > - Accel prop "kernel-irqchip", effective with AIA MSI
> >   - on: in-kernel APLIC and in-kernel IMSIC
> >   - off: user-space APLIC and user-space IMSIC
> >   - split: user-space APLIC and in-kernel IMSIC
> > - Accel prop "kernel-irqchip", effective with in-kernel IMSIC
> >   - emul: use MRIF as in-kernel IMSIC
> >   - hw: use hardware guest IMSIC file as in-kernel IMSIC
> >   - auto: use the hardware guest IMSICs whenever available otherwise
> >     fallback to MRIF
>
> Hi; as someone new to the RISC-V ecosystem, most of these acronyms feel
> impenetrable :-)  I see they're all RISC-V interrupt-handling related
> terms.  I hope you don't mind my spelling them out here:
>
>   - AIA   : Advanced Interrupt Architecture
>   - MSI   : Message Signaled Interrupts
>   - PLIC  : Platform-Level Interrupt Controller
>   - APLIC : Advanced Platform Level Interrupt Controller
>   - IMSIC : Incoming Message Signaled Interrupt Controller
>   - MRIF  : Message Routed Interrupt Facility
>
> [...]
>
> --
> /kashyap
>

Sure. I would add them into the next version. Thank you!

Regards,
Yong-Xuan

