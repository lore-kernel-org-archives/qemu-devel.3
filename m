Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C37E7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 02:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIfG2-0008QJ-54; Tue, 03 Dec 2024 21:36:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIfFw-0008Pv-Be; Tue, 03 Dec 2024 21:36:49 -0500
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIfFu-0003JE-GG; Tue, 03 Dec 2024 21:36:47 -0500
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-515c82e7251so255331e0c.1; 
 Tue, 03 Dec 2024 18:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733279805; x=1733884605; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AKx0SLWopW0nKGHvQOmuwqGYgel2gvvmvPOMk+zF/rA=;
 b=JksjW5Pq2UoEcNoMZjfO9YPuKSC6/atMh3MZcahxpf9f331kIJqj+TwonlYCctABnJ
 G5/NtnmI3fDllZ+ZOYEGXi4NL3DIUWPyl4jEOWHoKDME34FLqTGFmFRH0HdnzC7wAkmM
 9kZ+Hgb5OVsrpC7mcaQ8+rKVWS+634H5hegibwWHnSEY0aC/IzATwu0CQSqFmgMYasp3
 3QMmhZLc++P8bpsGhXc/qDbhRFQZn3eMvtrKosRyvR50MA2FShF5WgEvdEUuMrJAEKf8
 YSnWqR4eYlrsvw2hmVZJ7bFiCD8OluUnLfX29DIzSxSR2bAYWGaH5vV2KkFwfmb738/z
 FG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733279805; x=1733884605;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AKx0SLWopW0nKGHvQOmuwqGYgel2gvvmvPOMk+zF/rA=;
 b=ZL68HiUcj0jN++E0562wPb6hNx9H/Ule4sRZrjoRsjuYpdW1mJa5uMCJ2SqpkUcw2I
 PMun3mnVX1UCA0n9dA233vJW8KwkN+iOzzJQleiU0IL+610oWiEpHANc7zB5RDmRj7Wh
 LlDhMcogAZbxKh/fmplxloTLcU+imKbvQqZ/dXCNbQewhU9+2S7KsqG882XXMRENEwH0
 4j2tIIosjyw/04SngV/Sizqxro27Nyb/QzDGjcSbfEBq/686VWfPb6Nipq4SNvcwIsyG
 +9X1ORni4UIWPk718dRrs0li0w/L2jIq4c5W6ngsJZY0xyCV8mJHY2ohsAC33txoamAp
 kepA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUac3VqFpsCIn+wNebMewCSKJtH1YXNd9ROn5R9ZsFBiux6YWfqzMZ3kX07m99c5hPCVRUyY+C0qpFf@nongnu.org
X-Gm-Message-State: AOJu0Yz9dpM90zQhrZnHjS8zGIAF3ZY/wUjvu6TOmJEH/G+ogKij0gAl
 pINkFkfFu+6s8ive8xqr+V6Va+F/6iuBHmZ8vHvcYqqthO4hkVsoWOkb3jc5stt1H30POVyUICm
 dPALQs1VsHj7MVdGuIiXbiQ92ar4=
X-Gm-Gg: ASbGnctiItO1v9/xt5qIINdxzipq4sr0o5FTZaQhRbBgDVU6lHoLQGgt01cUfVSwhbi
 UhlMpWOkKMvPTkJNZ+5YUXgBH/RSmxj4g
X-Google-Smtp-Source: AGHT+IGu/hcl5CpQSJGAkc7hd5TIJZwvQt/4AeQPndBj8EyBhDQV7yhH2SxVW+uA3qLso5Cg5Glqh2We6MvwT5JCVh8=
X-Received: by 2002:a05:6122:20a6:b0:515:3bb5:5736 with SMTP id
 71dfb90a1353d-515bf58461fmr6332554e0c.11.1733279804744; Tue, 03 Dec 2024
 18:36:44 -0800 (PST)
MIME-Version: 1.0
References: <20241203034932.25185-1-fea.wang@sifive.com>
In-Reply-To: <20241203034932.25185-1-fea.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Dec 2024 11:36:18 +0900
Message-ID: <CAKmqyKMu7fPLnWMia-=Un1hU041WrPOCe9BpGbM8mq7azCk8tA@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Introduce svukte ISA extension
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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

On Tue, Dec 3, 2024 at 12:39=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wrot=
e:
>
> The Svukte ISA extension has been approved for fast-track development.
> https://lf-riscv.atlassian.net/browse/RVS-2977
> And there are Linux patches for the Svukte that are under review.
> https://lore.kernel.org/kvm/20240920-dev-maxh-svukte-rebase-v1-0-7864a88a=
62bd@sifive.com/T/#mf70fcb22cd2987ad268c0efee9b8583197d3cb4f
>
> Svukte provides a means to make user-mode accesses to supervisor memory
> raise page faults in constant time, mitigating attacks that attempt to
> discover the supervisor software's address-space layout.
>
> Refer to the draft of svukte extension from:
> https://github.com/riscv/riscv-isa-manual/pull/1564
>
> base-commit: 2209cae121e5da3cfbdb9dd4b06d52d0ef66ea69
>
> [v5]
> * Update the warning log and the commit message
>
> [v4]
> * Add a svukte extension check in RV32.
> * Refine the code.
>
> [v3]
> * Fix some typos
> * Refine code by separating a function into two dedicated functions.
> * Follow the riscv,isa order
>
> [v2]
> * Refactor the code
>
> [v1]
> * Add svukte extension
>
> Fea.Wang (6):
>   target/riscv: Add svukte extension capability variable
>   target/riscv: Support senvcfg[UKTE] bit when svukte extension is
>     enabled
>   target/riscv: Support hstatus[HUKTE] bit when svukte extension is
>     enabled
>   target/riscv: Check memory access to meet svukte rule
>   target/riscv: Expose svukte ISA extension
>   target/riscv: Check svukte is not enabled in RV32

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.c         |  2 ++
>  target/riscv/cpu_bits.h    |  2 ++
>  target/riscv/cpu_cfg.h     |  1 +
>  target/riscv/cpu_helper.c  | 55 ++++++++++++++++++++++++++++++++++++++
>  target/riscv/csr.c         |  7 +++++
>  target/riscv/tcg/tcg-cpu.c |  5 ++++
>  6 files changed, 72 insertions(+)
>
> --
> 2.34.1
>
>

