Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EA3CE7AA8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 02:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smP1s-0000Fp-8Z; Thu, 05 Sep 2024 22:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smP1q-0000Ew-Pn; Thu, 05 Sep 2024 22:48:54 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smP1o-00028L-W0; Thu, 05 Sep 2024 22:48:54 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-501204753c4so668963e0c.0; 
 Thu, 05 Sep 2024 19:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725590931; x=1726195731; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qOpwlhpvXEBD98tTikoysVl9mR0TnrKp4Ktf0QQh3f0=;
 b=cJJCWDAaW/cyh7j2tKv0ygBwWh3H9L1heuR76wGQY8Ch+j4JSl37oWv8J3V1tnyaEr
 QcIgwV88x/RsIvQEdDtTu5UNVDV3xZJomXhJjN04yoB9sWTWBKujiDhdFD6GRMGnkFVx
 coajpsGrulKx7UhS1yw08ot+E5aN9hBxgoi+3Zgmd3WsidME8tYOixXgDBdMAVLhc7v8
 fSHFAEgY5nxC6TJmE2/mc23jWni4lQI5RFZ+sU2urxAp1XAhl3kvazwIt6/n55NWEhXk
 AfIRBunxb/T4VfzHrNXcj9BqWSF+4SnIhiHpCuFEn6XR8ScBRG/u6p9wheOmUNtuHx9S
 k3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725590931; x=1726195731;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qOpwlhpvXEBD98tTikoysVl9mR0TnrKp4Ktf0QQh3f0=;
 b=whPxasO4+29f4nbF3AUz7foQQGRsMS+T3t0nvyEnzCePLwLye2IRG8OWJ/Drfh4Sut
 hpa1j4r0YDUYdpJ537atPN/NN/2pGLiEf4l73BQ20cGbQB4c968nNnFajmboYQxsQE/e
 kyTjS1cfyDhdPfDkAFvjorZJPp5HIpdhGFnOk15iONPUAhnq1ye/DyBGLchuePA9sH72
 OLbHeGcsRYQp1aypjQb8L30UWaS5P1mzP/wCnXYQUNA1Hp0IMlqw4sI6PyO5yehcMoU4
 38Y3UfEw/nqb+wtdC9zcUfikO2GQfjJWYiXvySmkrKtVM/dUXvxM11iT8keCggY6p1IM
 gerQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN4V1/e9HI2ZJlWaJeewNmjii0Ira8/9DUdVsS9eksN8WyfHA1ujY2iHYPpuqnqjHcCVh6tuebkNhS@nongnu.org
X-Gm-Message-State: AOJu0YwZ2NwL9R4d0X0r7bBu/23YjC4Ik3yuGNUKJ7AC3MGVThve8Ah1
 9NPCuYJv2gHDxn7yHCHZhZLN56j+cMNerQovc3haAZyOG0gX5/Ft9RRKeeEJUxl6j+Q/NEJ9/KX
 zS7EjRD+W/GzKfLr/ObG0JYUEPfI=
X-Google-Smtp-Source: AGHT+IGCQuQLcQ+gt/wvQf3GW1ZzQkOCkA18p8JRYT+ibDT5p5iHqCUdeTg6jgO7w+lSjNofp4apEmtA6ytD2ZD0ZaQ=
X-Received: by 2002:a05:6122:46a8:b0:4fc:eda5:6369 with SMTP id
 71dfb90a1353d-5019d45570cmr1394405e0c.3.1725590931397; Thu, 05 Sep 2024
 19:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240819160742.27586-1-Ian.Brockbank@cirrus.com>
In-Reply-To: <20240819160742.27586-1-Ian.Brockbank@cirrus.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Sep 2024 12:48:25 +1000
Message-ID: <CAKmqyKO1eS4dp0dVzY5wg5Z_KtjwRUWEZAxGeZj90+2rbAJ0Ag@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
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

Can you please point to the *exact* spec that is used (see below)

>
> This is based on the implementation from 2021 by Liu Zhiwei [3], who took
> over the job from Michael Clark, who gave the first implementation of
> clic-v0.7 specification [2]. I believe this implementation addresses all
> the comments in Liu Zhiwei's RFC patch thread.
>
> This implementation follows the CLIC 0.9-stable draft at 14 March 2024,
> with the following exceptions and implementation details:

I don't follow, the 0.9 spec was released in June

https://github.com/riscv/riscv-fast-interrupt/releases/tag/v0.9

>  - the CLIC control registers are memory-mapped as per earlier drafts (in
>    particular version 0.9-draft, 20 June 2023)

So it's different to the 0.9 spec?

>  - the indirect CSR control in 0.9-stable is not implemented
>  - the vector table can be either handler addresses (as per the spec)
>    or a jump table where each entry is processed as an instruction,
>    selectable with version number v0.9-jmp

We only want to support what is in the spec

Alistair

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

