Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB410C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 05:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6l3X-0005hN-36; Tue, 14 May 2024 01:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6l2U-0005VC-Fw; Tue, 14 May 2024 01:49:26 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6l2S-0005O5-RX; Tue, 14 May 2024 01:49:26 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-7f919bc2e1cso2504900241.1; 
 Mon, 13 May 2024 22:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715665763; x=1716270563; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7s3ep0UyjE0IAfSue0TFWtose4HLpyqyUOecMSZuD0=;
 b=ePJ87wVs2ZDsOUAc0So0e5IzDYLMNAn6VB1kOahhSjzO4v4eg9ctB0WnPGiYUHALzM
 ENN9CNTaSmripAvNQe/SOe7AFpeopU4huxVJBSffvPycoUtI0jRS5WGNBMY+oh2oNiKf
 DoFWwZKzfAUeugPqFly5uFb0bor3xevtKr8YqY9E8eHtmQUTlm2wLdj83HtZN1Ofp82g
 TC/iodEAhwB1HI/A8dMVo2nkbTMD2oaYVXRya2PxHYWCfmo1L1vcHs9K3sBU5S6zRp4y
 DHaUx6ZkYfPsZswDoYVZm4upBuKSXNzGR2PtpFytkQx6SVdZAVYXpVK79pREvqXp07q6
 aYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715665763; x=1716270563;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J7s3ep0UyjE0IAfSue0TFWtose4HLpyqyUOecMSZuD0=;
 b=lR2nk/fVdfWpSsJ5umh/sHxReaszxni9i3/gCwN66AD1EQRo1GffIULEec9EXs+AfT
 c2hB9Nz4A3dLDfH6XOgDDHtL8mUn5V3BziB419X1Lv/8hdkrmAXvpNl7eiT6lzwcZmhb
 59kxcT7FoKvNC7ovXzWGE6YuikQG7LyGLc9KzrcgbrdmHOWMmi/jDkYqIvpZ/kKebdL4
 ZT4jnTp6CwqLN6XIodSyFTzd/6at8N9XHbwmH14d1+hZUBT6/5ivwiBNy9eIDzMqAOUb
 u0Y0Hf31EeOXTSlOczFiWb/1/Rqo/iAXC8nxYxwGWIBe7C4WxqotZyXzpq8csLymJM+U
 kIzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLztmGv2EvpFA/IDMjWv05O3YTsC/svmgKvwhXCL+ge9vfY5TwAH1XzZdJmMqfCKBC6q/CTQLWQzLNF0+mZNJ7+VAcfNpnXUf8pd7Iblft+RGFSV9O0qScqwKTBw==
X-Gm-Message-State: AOJu0YxbBprWPUXUe27JKfRWtozrIbmSgcENr/hUJSM38Qrbee4zaD40
 2Y1kZZKpoJSLqmVIJeBvZQKEZmrk5rNzkOj+MZfiK6uIgrWSKN5cLb+Rd3D+iCm5o4bAFqcIiR2
 KFe8RKUe4818+3r0xiLzqgfjgxrM=
X-Google-Smtp-Source: AGHT+IGIag3SE4QQ7IJIk5Esi49/a6hXfq/N3P56EGOM0aI7ZGdgDztrOdWK5EdKUYT1Vu+Esj0pVKQPqV7KZrcnrK0=
X-Received: by 2002:a05:6102:26c8:b0:47b:b044:4ba3 with SMTP id
 ada2fe7eead31-48077bfd8e8mr7305652137.12.1715665763401; Mon, 13 May 2024
 22:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240413105929.7030-1-alexei.filippov@syntacore.com>
In-Reply-To: <20240413105929.7030-1-alexei.filippov@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 May 2024 15:48:57 +1000
Message-ID: <CAKmqyKNYFyVEOsRyOQCjZBMO_-Wut+k2Bn_5ep_uZdFi-5O-jQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: prioritize pmp errors in
 raise_mmu_exception()
To: Alexei Filippov <alexei.filippov@syntacore.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Joseph Chan <jchan@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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

On Sat, Apr 13, 2024 at 9:00=E2=80=AFPM Alexei Filippov
<alexei.filippov@syntacore.com> wrote:
>
> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>
> raise_mmu_exception(), as is today, is prioritizing guest page faults by
> checking first if virt_enabled && !first_stage, and then considering the
> regular inst/load/store faults.
>
> There's no mention in the spec about guest page fault being a higher
> priority that PMP faults. In fact, privileged spec section 3.7.1 says:
>
> "Attempting to fetch an instruction from a PMP region that does not have
> execute permissions raises an instruction access-fault exception.
> Attempting to execute a load or load-reserved instruction which accesses
> a physical address within a PMP region without read permissions raises a
> load access-fault exception. Attempting to execute a store,
> store-conditional, or AMO instruction which accesses a physical address
> within a PMP region without write permissions raises a store
> access-fault exception."
>
> So, in fact, we're doing it wrong - PMP faults should always be thrown,
> regardless of also being a first or second stage fault.
>
> The way riscv_cpu_tlb_fill() and get_physical_address() work is
> adequate: a TRANSLATE_PMP_FAIL error is immediately reported and
> reflected in the 'pmp_violation' flag. What we need is to change
> raise_mmu_exception() to prioritize it.
>
> Reported-by: Joseph Chan <jchan@ventanamicro.com>
> Fixes: 82d53adfbb ("target/riscv/cpu_helper.c: Invalid exception on MMU t=
ranslation stage")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index bc70ab5abc..196166f8dd 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1203,28 +1203,30 @@ static void raise_mmu_exception(CPURISCVState *en=
v, target_ulong address,
>
>      switch (access_type) {
>      case MMU_INST_FETCH:
> -        if (env->virt_enabled && !first_stage) {
> +        if (pmp_violation) {
> +            cs->exception_index =3D RISCV_EXCP_INST_ACCESS_FAULT;
> +        } else if (env->virt_enabled && !first_stage) {
>              cs->exception_index =3D RISCV_EXCP_INST_GUEST_PAGE_FAULT;
>          } else {
> -            cs->exception_index =3D pmp_violation ?
> -                RISCV_EXCP_INST_ACCESS_FAULT : RISCV_EXCP_INST_PAGE_FAUL=
T;
> +            cs->exception_index =3D RISCV_EXCP_INST_PAGE_FAULT;
>          }
>          break;
>      case MMU_DATA_LOAD:
> -        if (two_stage && !first_stage) {
> +        if (pmp_violation) {
> +            cs->exception_index =3D RISCV_EXCP_LOAD_ACCESS_FAULT;
> +        } else if (two_stage && !first_stage) {
>              cs->exception_index =3D RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT;
>          } else {
> -            cs->exception_index =3D pmp_violation ?
> -                RISCV_EXCP_LOAD_ACCESS_FAULT : RISCV_EXCP_LOAD_PAGE_FAUL=
T;
> +            cs->exception_index =3D RISCV_EXCP_LOAD_PAGE_FAULT;
>          }
>          break;
>      case MMU_DATA_STORE:
> -        if (two_stage && !first_stage) {
> +        if (pmp_violation) {
> +            cs->exception_index =3D RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
> +        } else if (two_stage && !first_stage) {
>              cs->exception_index =3D RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FA=
ULT;
>          } else {
> -            cs->exception_index =3D pmp_violation ?
> -                RISCV_EXCP_STORE_AMO_ACCESS_FAULT :
> -                RISCV_EXCP_STORE_PAGE_FAULT;
> +            cs->exception_index =3D RISCV_EXCP_STORE_PAGE_FAULT;
>          }
>          break;
>      default:
> --
> 2.34.1
>
>

