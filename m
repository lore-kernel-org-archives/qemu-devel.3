Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4E3C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 16:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raI4K-00046F-7s; Wed, 14 Feb 2024 11:25:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1raI4I-00045o-8G
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 11:25:06 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1raI4F-0007vL-Jd
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 11:25:05 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33cf7812777so30906f8f.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 08:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1707927901; x=1708532701; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rToF817F7NDDxN1KhGiBtiJ0q0y95UyU0vCN5Fe0eiM=;
 b=U1rR/oK2rxzBrG6HZOgZM3HpGhXi7K+0Rh42O1DG6QPbl3V77V4/GIRFLs0DLXJHaz
 TJqA89WIQpJG+fjGts65kgtc2UdP0W2p8rykunGXsguNENTyDkkTElAnFkNPh7StWWTZ
 2zed5hrV5BS7OmSHoN9DUTZcgTumjPhXyiMXeNY87ckXthEkWhjbud5BaGmuwLqdHS1/
 bwLUw8fKZ9007vwdhF5qVnD6sbdvW7W8xUkmnAK0LMl7WS8VVdWiOxyuXKknpr4Syb8X
 /pqORLR5DdWoFguZo5prxskHsrV16+hIHnCPXzlIIZZQkqWpH6ZOnjBjyvuYJ5ePSGm+
 FjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707927901; x=1708532701;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rToF817F7NDDxN1KhGiBtiJ0q0y95UyU0vCN5Fe0eiM=;
 b=swt3u6B+CQrtvpCgbmlMJo/rZxyo+ymiDOvuM+/Ys/bfLrTwVzRq/6r3OEUe8swGCD
 MR/i9GI0k7aRI1Yvm+eeR78suliTAA7MU4QfnF6nSVwNiDS0TpWnkKQFjCbcJ8lJKecT
 2iTWYp758xik+4cYxcNse/1Ke4eMcaEV0ik9nTG9NoRpjRJny/ezAErhz3YL6nuMc2EM
 R1Tl2mE9LNSlxX9Bp4XTIyOmwV3trw9k6hOkNmI80vnIpk9pFtIsIKcs3eA9UkjViEUO
 arJvc+CLhzbfZo9YqjwZsjbKaBm+Fu6u25zlUS/GbODgQIE4kBAOKv8SyMEjXxo8HKje
 gwGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsqGW6KKjGzGIgRuwcjLcxh97TfMWSmNZe54lXLMSp8wnaBJmPchWz5ybx3KxfS+2PvHn/S62dbCquXYCwLczNXjbP0N0=
X-Gm-Message-State: AOJu0YxG+z5im0ht95csRsBVWa6IyhDNCzjgaiXeWPjxH1QcOH5qM52N
 hvGDS9e+G+IP+Oxar2UlBWmWOz+KHAt7eBK8HuUe6LQvjkIo8GcGwhlhU7M2jO8=
X-Google-Smtp-Source: AGHT+IFOrkcinTNzEWLXLqDK32DBhiiPaE4f7j5GkLI47TGeUqC3f2mR7UhzK4HWMTkKxNspSNNWqg==
X-Received: by 2002:a5d:4043:0:b0:33b:87fb:7106 with SMTP id
 w3-20020a5d4043000000b0033b87fb7106mr2192826wrp.55.1707927900828; 
 Wed, 14 Feb 2024 08:25:00 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWEfM8r3KZ1rheMrZO8gB13iIvkd/fEHp3hxRZweOWSzmP8g6TQYIFL6rzxjvPnGV7kL4XSHgp/w4Savyuei3n12+aThTrm17aXMb+F1rwf5Qs7N2G+iIysoZSYy2nwRbub/qruaiQloPIh51F6cTM+XRnrJHcRiFzHtpcsj2Exfn9zPDN2NXwV/MmDL6ESnfbP60Y+11rSJdGCh1Da84OhJAZZnfPGnnx6Jgvy/2M7M8ZTCCgYor93I9wJp6A+K4NTnSyn4xmmjBNCSdvPnIDpurAnw5GX6FyL9A==
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 bv14-20020a0560001f0e00b0033b784c2775sm11012386wrb.43.2024.02.14.08.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 08:25:00 -0800 (PST)
Date: Wed, 14 Feb 2024 17:24:59 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Christoph =?utf-8?Q?M=C3=BCllner?= <christoph.muellner@vrull.eu>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/2] RISC-V: Add Ztso extension
Message-ID: <20240214-3d00860c6586b83fb7c5755d@orel>
References: <20240207122256.902627-1-christoph.muellner@vrull.eu>
 <3da767e4-26f8-4c92-a241-4111c2befdc2@ventanamicro.com>
 <CAEg0e7jXdfViUSaRc2+6WNtTY37_NhbsuxjPMw4YhQ24-HD3tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEg0e7jXdfViUSaRc2+6WNtTY37_NhbsuxjPMw4YhQ24-HD3tg@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 14, 2024 at 02:38:34PM +0100, Christoph Müllner wrote:
> On Wed, Feb 14, 2024 at 2:35 PM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
> >
> >
> >
> > On 2/7/24 09:22, Christoph Müllner wrote:
> > > The first patch of this series picks up an earlier v2 Ztso patch from Palmer,
> > > which can be found here:
> > >    https://patchwork.kernel.org/project/qemu-devel/patch/20220917072635.11616-1-palmer@rivosinc.com/
> > > This patch did not apply cleanly but the necessary changes were trivial.
> > > There was a request to extend the commit message, which is part of the
> > > posted patch of this series.  As this patch was reviewed a year ago,
> > > I believe it could be merged.
> > >
> > > The second patch simply exposes Ztso via hwprobe.
> >
> > It's also worth mentioning that the second patch relies on:
> >
> > "[PATCH 0/2] linux-user/riscv: Sync hwprobe keys with kernel"
> >
> > To be applied beforehand.
> 
> Indeed! Therefore, the end of the cover letter contains the following paragraph:
> """
> This series is based on today's riscv-to-apply.next with my other series
> that adds the new hwprobe keys
> (https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg01293.html).
> """

I think a line like

Based-on: 20240207115926.887816-1-christoph.muellner@vrull.eu

in the cover letter would allow the automated tools to green-light this
series too.

Thanks,
drew


> 
> To ease reviewing and testing for others, I've also created a remote
> branch on GitHub.
> 
> Thanks for reviewing!
> 
> >
> >
> >
> > Thanks,
> >
> > Daniel
> >
> >
> > >
> > > Relevant in this context might be also, that Richard's patch to improve
> > > TCG's memory barrier selection depending on host and guest memory ordering
> > > landed in June 2023:
> > >    https://lore.kernel.org/all/a313b36b-dcc1-f812-ccbd-afed1cbd523b@linaro.org/T/
> > >
> > > The first patch was already sent as part of an RFC series for Ssdtso:
> > >    https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg02962.html
> > > Since I don't want to keep this patch until the ratification of Ssdtso,
> > > I would like to get this merged independent of Ssdtso.
> > >
> > > This series is based on today's riscv-to-apply.next with my other series
> > > that adds the new hwprobe keys
> > > (https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg01293.html).
> > >
> > > This series can also be found here:
> > >    https://github.com/cmuellner/qemu/tree/ztso
> > >
> > > Christoph Müllner (1):
> > >    linux-user/riscv: Add Ztso extension to hwprobe
> > >
> > > Palmer Dabbelt (1):
> > >    RISC-V: Add support for Ztso
> > >
> > >   linux-user/syscall.c                    |  3 +++
> > >   target/riscv/cpu.c                      |  2 ++
> > >   target/riscv/cpu_cfg.h                  |  1 +
> > >   target/riscv/insn_trans/trans_rva.c.inc | 11 ++++++++---
> > >   target/riscv/insn_trans/trans_rvi.c.inc | 16 ++++++++++++++--
> > >   target/riscv/insn_trans/trans_rvv.c.inc | 20 ++++++++++++++++++++
> > >   target/riscv/translate.c                |  3 +++
> > >   7 files changed, 51 insertions(+), 5 deletions(-)
> > >

