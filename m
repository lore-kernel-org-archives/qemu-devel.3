Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A359DD7495A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 04:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t60As-00022j-QS; Wed, 30 Oct 2024 00:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t60Al-000226-Gw; Wed, 30 Oct 2024 00:19:07 -0400
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t60Ak-00085X-54; Wed, 30 Oct 2024 00:19:07 -0400
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-84fe06fbdc6so1758398241.0; 
 Tue, 29 Oct 2024 21:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730261945; x=1730866745; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pRM2fGSuQvUbJHZ7XCUvT5yb5w2/zfFa/aVDWWWo/lA=;
 b=f4DjwzrP049SR0qrBRXZr/rwJ+UhmLesTZvlW2BnccTefDoPmoWwoyPlF+bz4u9DkY
 1uDzkF79MmBeqI5X4kv0WeJ9KKLtZTRSYyaAksyNxxt2J/8BAmWjzMkMBDdSYNYkKsxh
 HokXejTe5fv2xvmxpU/g+Bvq3oFKezqDeH1xRND/EyUoivSuy8+Pej0qzdPqCOscpTWu
 dHWrRDPOibqpd/kaad9Be1pWhSxdS9c0JOs+lBIkN5osuW61OvloJsiIC0hTK1l0iynY
 /RgGNHAnQoffQBIzVC1VzVpu86n8xrk06/LQU/GPYrHYSiAEC+VawIu9MjL7tIkBXUMj
 R00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730261945; x=1730866745;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pRM2fGSuQvUbJHZ7XCUvT5yb5w2/zfFa/aVDWWWo/lA=;
 b=I0eu/Cjw0jrQg9ohfSgHjP2BSDbBV0qun13pxvjcl8vpEGgdd7hZLg8D92ZNZFtg/9
 Vmz3qZ301wgc1LxerkD8iHRcNottiYMYh/QhjQXKGu3teZo70RunnXSss6frZO0jfNL1
 xMODsyhVu+6TOKi90vLNUlk7Ey8np9C7i9N5xyOnoC9K8hL2Ap5hsMH4geIcrN0tU11C
 vzhjt8XYEe2FBFmvUb8Yo41XAiJnAV0EA0wdl2NtSpZXwNYQYKGZN8X9o+CS77sckHmW
 VSsynVWSiVXY++oG3ImntHLTlzfP88uo+fxWof9Soai84FrkKXUYffmHRmNIlRfwcaP5
 oMkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdleXTl8nSUaFCeUHuViItfHULRzGKIbQ1kP/EM3vLu0lASMyZV9RYeYqNBqWwexa8MQ5Gjut0sEcc@nongnu.org
X-Gm-Message-State: AOJu0YwMrI0gA7z6zYldQY1IH02Qrd9LStm3NcUMMbzUCJ6W3Bmm+aPw
 gvu3eDeljZnB5GnDI4eI4fLQYIBgVoO+H4Agz6WZtzBtHJ4u+xnre4yIWKYPVKEuTpt87o4qI/e
 bWm2cnzE93ueGdM0YXJv5ZzloSvA=
X-Google-Smtp-Source: AGHT+IFmbx/fR/DZCN6Isvdf/9r/qFsHQtVoFHEk9giAeRped8UcGnVxPom5S1RIP9dhcr/eov04ncSExJxmw/vlMyk=
X-Received: by 2002:a05:6102:5125:b0:498:e935:ddb8 with SMTP id
 ada2fe7eead31-4a8cfb44d3amr14494404137.1.1730261944759; Tue, 29 Oct 2024
 21:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20241030004146.935656-1-antonb@tenstorrent.com>
 <CAKmqyKMJ0Lu7Jvh2KM7yGjq00uHnAmav9sV7cmWnzrkchQR2xQ@mail.gmail.com>
 <CAN7m+mCyx78jaMgJDHwdy8ZhxrsP-9jDhjmNrJnn_cffePqJhw@mail.gmail.com>
In-Reply-To: <CAN7m+mCyx78jaMgJDHwdy8ZhxrsP-9jDhjmNrJnn_cffePqJhw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 30 Oct 2024 14:18:38 +1000
Message-ID: <CAKmqyKMtWdS2KYq3e1MOTAn_JNAOkr64A-SruJKCdO8=zVjVcw@mail.gmail.com>
Subject: Re: [CAUTION - External Sender] Re: [PATCH] target/riscv: Fix
 vcompress with rvv_ta_all_1s
To: Anton Blanchard <antonb@tenstorrent.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
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

On Wed, Oct 30, 2024 at 2:09=E2=80=AFPM Anton Blanchard <antonb@tenstorrent=
.com> wrote:
>
> Hi Alistair,
>
> On Wed, Oct 30, 2024 at 2:39=E2=80=AFPM Alistair Francis <alistair23@gmai=
l.com> wrote:
> > > vcompress packs vl or less fields into vd, so the tail starts after t=
he
> > > last packed field.
> >
> > Is that right?
> >
> > It's different from every other vector command. Although the wording
> > in the spec is very confusing
>
> It is confusing. This thread has some clarification, and we should probab=
ly
> follow up on the suggestion to improve the ISA wording:
>
> https://github.com/riscv/riscv-v-spec/issues/796

Ah, at least it isn't just me.

It's worth pointing to that in the commit message, as the spec is not
clear about this

Alistair

>
> Thanks,
> Anton

