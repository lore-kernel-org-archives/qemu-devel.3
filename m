Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A5BC54E49
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 17:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhCUN-0003dY-U5; Mon, 04 Mar 2024 12:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhCUL-0003cy-EQ
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:52:33 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhCUG-0004de-IY
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:52:33 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56647babfe6so7107812a12.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 09:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709574746; x=1710179546; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bax5uh4Z9qOYjTKVzAmhNgL0C/kZVnLC9Le3TJ8HX7M=;
 b=jDkTALVBzjxjmFj4pH6zQqF//YDt7n+bESKUwCXebziq4vHvCFbbDDpVxyDz4FAc8J
 f1rgx0FuFGLlKzcAeuElzTBOvroKTFqAVJUUfq/eLCv0pYqZYUaugKAahw+2RURkCT+R
 kbgbnmK8bv+DAC1bY704ljDi6ch2qxQINwDVU1JzkrBDfkxIgiE9vfs72LdMeJ3hgyQf
 mQMkLXYl/ljEoyrn6fcF3ei0WYA/U/QO7Lynumg/r9bNAQS0yXrNj+IKotHwS5oL6EX7
 n42TcL8vp8eXVH+TzYVsp5p3tlI4xlCbl4G1gj2pt/lZB4Owi/TrpFlfJKruVKrFWHSY
 s0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709574746; x=1710179546;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bax5uh4Z9qOYjTKVzAmhNgL0C/kZVnLC9Le3TJ8HX7M=;
 b=Rmgy3aWToeBB5iDuoU0QBrreTHHRBh6u+m/CyumD9yN0uDUhSZxxC2PsPHvQF39VqP
 vCVH0+qx3D5khGUrIJQ2mVxLmMHTmZmlnT/kOY5g+F/Oa2+wJ+uMWmVYghtCsBVY8qD8
 5VbzHZTo2acaYJpJM8QR8/Bcva23XM2Hf0zbtd3BIhl5xqfbb1NrLRkREidFasVwrZve
 97aD+o+/xMTIll41y7clRaoWEAg3OM252/LpsqKmmgojLLE6COtqMTYbEC2bKWWKhfUY
 fcfGJph6MtrwTo5MCu4+05G5SeVHhoZzp4eRWzhnc+OkWwQfToMuh2iv+fGlfYwy1RBp
 Jl+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMxy9Nos3CsViZjk0Zx9OpX5iZS/Qz3+c31MJJvvK9QOJ+S4o3aGJVSpb1p64k3i+QXa46VNsXTxF6QuL7GT5U3C20RAo=
X-Gm-Message-State: AOJu0Yy2BrqaE0nHw7QUjsZHHa4wUIo0HiUfNb3rvDPT5hMnPVJ5LaVK
 1M+ure0U9QEK2ls9g8TJ8mVpQcCA1zWCoJwmS+u1cQ6f4yRduZQRAgYGVMZQsx4nN5D7h7zVMZW
 8MV5laquHkpStQcRBrpQ8o31Av40GtzmHRZkpzQ==
X-Google-Smtp-Source: AGHT+IGiP0KqDoz+kBhp6tDASi67ln7EFCYob2+MpzmMd1/zZKA+otSIftphsIgHtKmKWShpomeqZ1aP14pCun4OJJg=
X-Received: by 2002:a50:c88b:0:b0:566:f60:1b0 with SMTP id
 d11-20020a50c88b000000b005660f6001b0mr7286313edh.11.1709574746551; 
 Mon, 04 Mar 2024 09:52:26 -0800 (PST)
MIME-Version: 1.0
References: <20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com>
 <20240303-elf2dmp-v1-3-bea6649fe3e6@daynix.com>
In-Reply-To: <20240303-elf2dmp-v1-3-bea6649fe3e6@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 17:52:15 +0000
Message-ID: <CAFEAcA9Nr=rgzFP+L3UhL2AtEGBO0Mf=9iYKWJM=mRPFSwTBig@mail.gmail.com>
Subject: Re: [PATCH 3/7] contrib/elf2dmp: Ensure segment fits in file
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sun, 3 Mar 2024 at 10:53, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> This makes elf2dmp more robust against corrupted inputs.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  contrib/elf2dmp/addrspace.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c
> index 980a7aa5f8fb..d546a400dfda 100644
> --- a/contrib/elf2dmp/addrspace.c
> +++ b/contrib/elf2dmp/addrspace.c
> @@ -88,11 +88,12 @@ int pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
>      ps->block = g_new(struct pa_block, ps->block_nr);
>
>      for (i = 0; i < phdr_nr; i++) {
> -        if (phdr[i].p_type == PT_LOAD) {
> +        if (phdr[i].p_type == PT_LOAD && phdr[i].p_offset < qemu_elf->size) {
>              ps->block[block_i] = (struct pa_block) {
>                  .addr = (uint8_t *)qemu_elf->map + phdr[i].p_offset,
>                  .paddr = phdr[i].p_paddr,
> -                .size = phdr[i].p_filesz,
> +                .size = MIN(phdr[i].p_filesz,
> +                            qemu_elf->size - phdr[i].p_offset),

Shouldn't "p_filesz is smaller than the actual amount of data in the
file" be a failure condition? In include/hw/elf_ops.h we treat it
that way:

            mem_size = ph->p_memsz; /* Size of the ROM */
            file_size = ph->p_filesz; /* Size of the allocated data */
            data_offset = ph->p_offset; /* Offset where the data is located */

            if (file_size > 0) {
                if (g_mapped_file_get_length(mapped_file) <
                    file_size + data_offset) {
                    goto fail;
                }
                [etc]

Like that code, we could then only check if p_offset + p_filesz is off
the end of the file, rather than checking p_offset separately.

>              };
>              pa_block_align(&ps->block[block_i]);
>              block_i = ps->block[block_i].size ? (block_i + 1) : block_i;

thanks
-- PMM

