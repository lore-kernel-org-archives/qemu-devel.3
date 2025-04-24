Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA44C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tF2-0000i5-SR; Thu, 24 Apr 2025 05:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u7tEq-0000Qq-AS; Thu, 24 Apr 2025 05:51:25 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u7tEn-0002zR-Vo; Thu, 24 Apr 2025 05:51:24 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-acb415dd8faso122142266b.2; 
 Thu, 24 Apr 2025 02:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1745488280; x=1746093080; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pdeNaUx0YAovtOzfXHmWEHPybZDJQR7lFOpaCZFQHY8=;
 b=EhCCZoMs9olvZhdmrN1KVi/v1G37AtAsZMQ121zIcAKXko9+nHnkArbRSasAo+mtUz
 lfNvqaeZihT2kVX1RIBE05k5JCiSWjM/Hc4WQpozBCBQNh4xFB5fHzqTujcu9isQLA1o
 v70B5JRbDHsbijrYNzNyNR+WJGHkUTjTiEEdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745488280; x=1746093080;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pdeNaUx0YAovtOzfXHmWEHPybZDJQR7lFOpaCZFQHY8=;
 b=a7i5/sTTDhEmd2LpBNpbrN+VR+9BNmzZpqehppR7t59hrUyVagDdF30FEOUdnZLOBf
 RUg3mkit/TntcYyxgnay4Ba9fo8UXmfFcJnmhhu81LTzpOpCjuaJfE+DWXk1SidCtJaW
 b573xoMVJolGeEvbf+6Ofd+aoD2rC9xaByb8R7QabOs3ITzhytJvt/Vz90PlPUcyJGJa
 6uQJnvQBYm/qGGifngImC68DXWEUo7NEiOLS10gZEv20K103TpotXYqzEHsErOQAyE8Q
 xfKU7XsnzDWbssIRO/hL6O9aeuGDtWnaS36LLiGy742d1JHi0GPAGGZtTOYgzpa5XiQY
 Clrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWaoTmHWiL+OYCrnyCQmCa9CK0gM0ScAFTIb/Ddc94ADM1csYhIj7RAEg5IA/w1I635fMP8UojpPR3@nongnu.org
X-Gm-Message-State: AOJu0Yzs3mNEkyjh+PZFLPbAVcQbAIonA6RCx1e4eZ55Munf6YKMyH+h
 lELP/pGiZ/6c1mGwiEmrmAfFJEyu7thvToZ+yCdqF82VLyA10aEb1yDNGy4X6raxIMXUtHSPvPh
 7aW2zaURwaB4zbQtyu1l4VUaEo+w=
X-Gm-Gg: ASbGncsHX4K5/yxs4CUHABPUPBHIj7ylQon6XkTMQvnIftlhoM05QyTPvJTmXV1l81R
 yX+2dGhJi2TMbNoGV0cK9sihHjQzSQcOUPi9X3Td9+W7bV0OOJ+/71/1fbc1lgmJtKKNonXcM3P
 TO0ZPqAEDC3yO0tecbbaWp
X-Google-Smtp-Source: AGHT+IGeGeI5B4njJvBnvhpWzw62TQbOREO9QrxTlivOjDfHnr6bBFeJvIxr56gwQVbSHb6mvz5Kc0KWeqasAA3qxao=
X-Received: by 2002:a17:907:9725:b0:acb:32c5:43ff with SMTP id
 a640c23a62f3a-ace56e46911mr178563366b.0.1745488279475; Thu, 24 Apr 2025
 02:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250423110630.2249904-1-dbarboza@ventanamicro.com>
 <20250423110630.2249904-2-dbarboza@ventanamicro.com>
In-Reply-To: <20250423110630.2249904-2-dbarboza@ventanamicro.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 24 Apr 2025 19:21:06 +0930
X-Gm-Features: ATxdqUHtJzJ95Jbgzlb4Xd2a-JkMSb4SegQ8o2JTaQo_y25P2qXH9w_e8vDgOhM
Message-ID: <CACPK8XfF74wHqdBBz=qPLefAD8pKT-0C8e=kfFtTeMH+teF-7A@mail.gmail.com>
Subject: Re: [PATCH 1/9] hw/riscv/virt.c: enforce s->memmap use in
 machine_init()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

On Wed, 23 Apr 2025 at 20:37, Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Throughout the code we're accessing the board memmap, most of the time,
> by accessing it statically via 'virt_memmap'. This static map is also
> assigned in the machine state in s->memmap.
>
> We're also passing it as a variable to some fdt functions, which is
> unorthodox since we can spare a function argument by accessing it
> statically or via the machine state.
>
> All the current forms are valid but not all of the are scalable. In the
> future we will version this board, and then all this code will need
> rework because it should point to the updated memmap. In this case,
> we'll want to assign the adequate versioned memmap once during init,
> in s->memmap like it is being done today, and the rest of the code
> will access the updated map via s->memmap.

I was writing a patch for a machine and came across the same
inconsistencies. Nice clean up.

Some of the device initlisation code could be refactored out to be
shared by other machines within the riscv directory. Related, parts of
the device tree creation could belong to the model, instead of to the
machine, as the properties are a property (!) of the device.

With that in mind we should consider passing the eg. fdt pointer and
the MemMap pointer instead of machine state, where practical.

> We're also enforcing the pattern of using s->memmap instead of assigning
> it to a temp variable 'memmap'. Code is copy/pasted around all the time
> and being consistent is important.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel

