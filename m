Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D47CE7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 00:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tT9BA-0004VE-3f; Wed, 01 Jan 2025 19:35:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tT9B7-0004TB-Ea; Wed, 01 Jan 2025 19:35:09 -0500
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tT9B6-0002o3-1A; Wed, 01 Jan 2025 19:35:09 -0500
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-4afeb79b52fso2981672137.0; 
 Wed, 01 Jan 2025 16:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735778104; x=1736382904; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8L2t/sqP27BtSnZ3pFKm1U2uTREPCH/BpdZKNxGWxkM=;
 b=AtaZ7YyFwaUDluBaYfwcNOnUoxsHYt0HrkqpqhIICgQ8DPydSwUx0KYQTYgU8HW8ob
 8vnTYgOnHNb/OJVxP1MA5qjtWkqVghsOvd4RjQdugWhZO5MUetzobCa2rIeTnVV2Nnuf
 Jsv0zGRliB5pklzO36pE9QEIVVAQLoMAKLgNGnMp1eyrFDscahW49SZvk9tiPOXeq/hk
 thkALMSIR2uVvZBgXHWfwsy8EX4eYeD1hS/FX67yS9RrSks4nvz7ds2me2gife5KAZ0P
 ANlujXmU14SnVmIEWc0t0q1SspQYDD9OKp90TkzeZAB09dWi7YQ3xA1zP9F7+LlDLxYK
 tsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735778104; x=1736382904;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8L2t/sqP27BtSnZ3pFKm1U2uTREPCH/BpdZKNxGWxkM=;
 b=UMx7fVqsQ5SH7vbXkEKRpOJILURA3pjJJENvVeMa1Z0i28d77tF92TlelURB5Nu29c
 QZJ5PVaAhTPzXuUirnZKFdPVsW4fGx6U2Bt/kmCqnLrltaYcIrNzzE9z+TOOLbhJDbpn
 Zhe1ApkDO7ECbJtu8RbswWihNuutLCnXrV+VMPprxVzVsnD3tmFdnV2njJ+Ek4dQMcuG
 QNt62sBoAOn5iip7Ow6vO0/AITMG+V4m3o4N+gKaDjFYeHq2jOUG1jFO656ziMzwA79L
 OVyU/6rq03uYiMLLJeaZepRh5h20sNmazQ228VcniIW/sWpkKRAEQGaXnz6M9UrCE75h
 ocmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV64asypUTlsXS+5/14nckqCQcGAnE3pGEJ0NrGmUepclqd85OHbFPPSqiX3lmIkdnxnirYE7KNcMOS@nongnu.org,
 AJvYcCVTXyiKvNSrUS2ze+2IrPpQuwSu6PzBs89vyIc4BTEEDtVfLP2bx6g6aZTuipPq8g1mBGqFw+JIA3EJadM=@nongnu.org,
 AJvYcCWH3WjfMfc+a19N+cPCJJOauuDYLLPVXDtPV0jQxv0BFd1KUWVfKnM8VfqIW7sQcwkKfZk1ywE6S9g2mw==@nongnu.org
X-Gm-Message-State: AOJu0Yy2hZ+RFKFzlfK00RdigauQqUCU9/3f3j/EmKoJ4W4gZIP0+aEy
 CGfLWDM1wt/tUvQCufQdpTRe3Tkb0pxHD6Kacp7HiN0Sq9aklRfFsMrzPj5cZvUMUQKRxG7FBAv
 dHFVwqCZCJfgGqt266RWv+2J+rAQ=
X-Gm-Gg: ASbGncs+yvk/sL46ybEXl1pUFB3t653h7SKRTmyRyQOmwJwUrdyREnKAX7EEpJdj9PT
 FjSFwr3pCWD3PTK2bpTT89/fc9nik8Le93FuakJomJMjOH1bzNFgDEum59iEgB3sN4RfN
X-Google-Smtp-Source: AGHT+IFOZ1KE+Wu1RGyZFrbhDOKajBWTWe9Y+KsvQkXyrEjZ3HzFxWDMyg96a93/RPhYSJUtzV/Q0SQ96Lr0DcnJzwY=
X-Received: by 2002:a05:6102:292b:b0:4b1:1b24:7241 with SMTP id
 ada2fe7eead31-4b2cc387393mr34540995137.15.1735778104580; Wed, 01 Jan 2025
 16:35:04 -0800 (PST)
MIME-Version: 1.0
References: <20241029085349.30412-1-yongxuan.wang@sifive.com>
 <fe6033cf-fee6-4172-a576-c3456cb2bd26@tls.msk.ru>
In-Reply-To: <fe6033cf-fee6-4172-a576-c3456cb2bd26@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Jan 2025 10:34:38 +1000
Message-ID: <CAKmqyKPt_kH7uKsGg2OjZy5nKyxpkWdJaR4eJhEPOHFiP4Bumg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] hw/intc/riscv_aplic: Fix APLIC in_clrip and
 clripnum write emulation
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Yong-Xuan Wang <yongxuan.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com, 
 jim.shu@sifive.com, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe29.google.com
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

On Sun, Dec 22, 2024 at 6:40=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> 29.10.2024 11:53, Yong-Xuan Wang wrote:
> > In the section "4.7 Precise effects on interrupt-pending bits"
> > of the RISC-V AIA specification defines that:
> >
> > "If the source mode is Level1 or Level0 and the interrupt domain
> > is configured in MSI delivery mode (domaincfg.DM =3D 1):
> > The pending bit is cleared whenever the rectified input value is
> > low, when the interrupt is forwarded by MSI, or by a relevant
> > write to an in_clrip register or to clripnum."
> >
> > Update the riscv_aplic_set_pending() to match the spec.
> >
> > Fixes: bf31cf06eb ("hw/intc/riscv_aplic: Fix setipnum_le write emulatio=
n for APLIC MSI-mode")
>
> Is it a qemu-stable material?

Yes, I think it should be

Alistair

>
> Thanks,
>
> /mjt
>

