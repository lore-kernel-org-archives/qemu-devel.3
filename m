Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39623CE7AAE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 03:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smQ5v-00035H-Tz; Thu, 05 Sep 2024 23:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smQ5u-00034N-7D; Thu, 05 Sep 2024 23:57:10 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smQ5s-0001XW-A1; Thu, 05 Sep 2024 23:57:09 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-5010322c1c1so495129e0c.0; 
 Thu, 05 Sep 2024 20:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725595027; x=1726199827; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jtttHYgtGHzZnaoQEsFCw0WvYvHsV66JTYrvKOoF408=;
 b=LvFAHrxPKdftjW2f2W80ZGDzB4Nw2hP2DvrmttfUZnxnJChsOKKLdKrWcdxX2qIh8h
 tfE9FopUogIXxT4svIxd8UbXKWJEB6B09TF+POTJRYmcKrhQYoDpWw9QYhlME2ccskJL
 UewRSOo+TKDL609qbgoYZ0eqqBDNcKFcxdBFdIZHLPD/4/ofhnO/8FgcSTqYxloxPRnU
 oo3TvIqnpK0DpRkFLdx5kEBmR47NJD+l8JeRrSdvYzygxcBJwafeadZp+e9crO/soAJt
 aOWAsV8QXyGRgHmCRX/VDqrrIqK+AWEhsy19tWrXI7BLyGEE+SGhw0x3zk+81EU9Kqmf
 g34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725595027; x=1726199827;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jtttHYgtGHzZnaoQEsFCw0WvYvHsV66JTYrvKOoF408=;
 b=wpGsgiw3OVwdvjShsY6cY5dkuOShKuG2fCqObvqpKdNamFFA3iLXr3oiZPdHrxfpjA
 DshR233gGeIPWR/QFEuz3L791CHXXyiNRZMMsmGzlpIa8EhECQ2XEmOaaE90OLzFU+Lm
 /+PlVlEdmzUb7ZoEytDI16q9ApYC1cRq7pTpJi38WL6pD9AGOuPljdOG/RuYEryRpnNm
 TiFOgNwaeeZ/ZmvAkivfsxx0GxW6oHiMHtFd5FoFS66DEy7ohvrPE7GIT1iXJkb8IngS
 HpfwOXEHPEc6W/duIxfSi2pZjlbICE1kNUAu8KQ3/LmPrmEnKVuO4ndEWwgHKFiwXWUl
 x6qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCag/SQ3rgibPkAU52VDEbhDyaWUmpdYEumZ421ZzKD16OVDndUTllhl8qjbQtmWR6LIlDbwN8uWEK@nongnu.org
X-Gm-Message-State: AOJu0Yx871s5aqGmM1T11VLL5V4YsUpJl0jCzqZogkkTQDTXVPBhkTfI
 7IhoCY8NkfcIm+NLjvnoeyjkC5GNb6doGgRqVUWj0OOHOpu5iGOpuiH9M73nX6mgtUbBRHjdfGu
 b9g1Wk4ll5ORzhYTUoWC5xJd31Q0=
X-Google-Smtp-Source: AGHT+IFfEbnXgRiX7MmcN4ce4uOczwTWR8WjOsRiIOUARVu9zq1xU5/AAjAhthuKQPYTuhA2a8UEt1Re8SplgQ5O3xA=
X-Received: by 2002:a05:6122:3282:b0:4f6:aa3e:aa3e with SMTP id
 71dfb90a1353d-5021fc3f8b9mr1581755e0c.11.1725595026649; Thu, 05 Sep 2024
 20:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240819160742.27586-1-Ian.Brockbank@cirrus.com>
In-Reply-To: <20240819160742.27586-1-Ian.Brockbank@cirrus.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Sep 2024 13:56:40 +1000
Message-ID: <CAKmqyKMBsOh4kc1_PDnTocMAGKB2OBMwLLZnVByWuOW9MtMc1Q@mail.gmail.com>
Subject: Re: [PATCH 00/11 v2] RISC-V: support CLIC v0.9 specification
To: Ian Brockbank <Ian.Brockbank@cirrus.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Aug 20, 2024 at 2:08=E2=80=AFAM Ian Brockbank <Ian.Brockbank@cirrus=
.com> wrote:
>
> [Resubmission now the merge is correct]
>
> This patch set gives an implementation of "RISC-V Core-Local Interrupt
> Controller(CLIC) Version 0.9-draft-20210217". It comes from [1], where
> you can find the pdf format or the source code.

Thanks for the patches!

I left some comments on the cover letter and throughout the series.

The main points are that we need to support a release spec (draft is
ok, but it needs to be tagged as a version). On top of that we want to
try and keep the CSR changes in target/riscv. We don't want to be
including the hw/intc code all over the place. time_helper.c for
example is how the ACLINT works, where we try to keep as much of the
CPU code in target/riscv.

Also we will need extension checks for all of the relevant CLIC
extensions. Guest code should not notice any changes after this series
unless they enable the CLIC extensions.

Alistair

>
> This is based on the implementation from 2021 by Liu Zhiwei [3], who took
> over the job from Michael Clark, who gave the first implementation of
> clic-v0.7 specification [2]. I believe this implementation addresses all
> the comments in Liu Zhiwei's RFC patch thread.
>
> This implementation follows the CLIC 0.9-stable draft at 14 March 2024,
> with the following exceptions and implementation details:
>  - the CLIC control registers are memory-mapped as per earlier drafts (in
>    particular version 0.9-draft, 20 June 2023)
>  - the indirect CSR control in 0.9-stable is not implemented
>  - the vector table can be either handler addresses (as per the spec)
>    or a jump table where each entry is processed as an instruction,
>    selectable with version number v0.9-jmp
>  - each hart is assigned its own CLIC block
>  - if PRV_S and/or PRV_M are supported, they are currently assumed to fol=
low
>    the PRV_M registers; a subsequent update will address this
>  - support for PRV_S and PRV_M is selectable at CLIC instantiation
>  - PRV_S and PRV_U registers are currently separate from PRV_M; a subsequ=
ent
>    update will turn them into filtered views onto the PRV_M registers
>  - each hart is assigned its own CLIC block
>  - support for PRV_S and PRV_M is selectable at CLIC instantiation by
>    passing in a base address for the given modes; a base address of 0 is
>    treated as not supported
>  - PRV_S and PRV_U registers are mapped  onto the PRV_M controls with
>    appropriate filtering for the access mode
>  - the RISCV virt machine has been updated to allow CLIC emulation by
>    passing "machine=3Dvirt,clic=3Don" on the command line; various other
>    parameters have been added to allow finer control of the CLIC behavior
>
> The implementation (in jump-table mode) has been verified to match the
> Cirrus Logic silicon (PRV_M only), which is based upon the Pulp
> implementation [4] as of June 2023.
>
> The implementation also includes a selection of qtests designed to verify
> operation in all possible combinations of PRV_M, PRV_S and PRV_U.
>
> [1] specification website: https://github.com/riscv/riscv-fast-interrupt.
> [2] Michael Clark origin work:
> https://github.com/sifive/riscv-qemu/tree/sifive-clic.
> [3] RFC Patch submission by Liu Zhiwei:
> https://lists.gnu.org/archive/html/qemu-devel/2021-04/msg01417.html
> [4] Pulp implementation of CLIC: https://github.com/pulp-platform/clic
>
> Ian Brockbank (11):
>     target/riscv: Add CLIC CSR mintstatus
>     target/riscv: Update CSR xintthresh in CLIC mode
>     hw/intc: Add CLIC device
>     target/riscv: Update CSR xie in CLIC mode
>     target/riscv: Update CSR xip in CLIC mode
>     target/riscv: Update CSR xtvec in CLIC mode
>     target/riscv: Update CSR xnxti in CLIC mode
>     target/riscv: Update interrupt handling in CLIC mode
>     target/riscv: Update interrupt return in CLIC mode
>     hw/riscv: add CLIC into virt machine
>     tests: add riscv clic qtest case and a function in qtest
>
> This message and any attachments may contain privileged and confidential =
information that is intended solely for the person(s) to whom it is address=
ed. If you are not an intended recipient you must not: read; copy; distribu=
te; discuss; take any action in or make any reliance upon the contents of t=
his message; nor open or read any attachment. If you have received this mes=
sage in error, please notify us as soon as possible on the following teleph=
one number and destroy this message including any attachments. Thank you. C=
irrus Logic International (UK) Ltd and Cirrus Logic International Semicondu=
ctor Ltd are companies registered in Scotland, with registered numbers SC08=
9839 and SC495735 respectively. Our registered office is at 7B Nightingale =
Way, Quartermile, Edinburgh, EH3 9EG, UK. Tel: +44 (0)131 272 7000. www.cir=
rus.com
>

