Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1C8C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 04:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnWkl-0002BO-Cf; Fri, 22 Mar 2024 00:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnWkj-0002Aj-4j; Fri, 22 Mar 2024 00:43:37 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnWkg-0002rz-Fd; Fri, 22 Mar 2024 00:43:35 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4d853aa6f33so626635e0c.1; 
 Thu, 21 Mar 2024 21:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711082613; x=1711687413; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+tTWPMac9UPB5pCkc5seamOgZmsH/8X8ybAzInKOXRI=;
 b=hKLGfkQaxj2f444+jWuq10Fj+mLO4QJ0qfNtQ0CsmJSLiNUJcp/bv63DKL9r5YtMCO
 816RANPyjQXtiu8zQqgp2yd8LJDjPzYWZWfu+iniQ/1ODmPZtBUybkRfk2ojluRw+HXh
 jskgY0Xlv2ipa9RNuc4RlFip+NuFTimOwVvlIuYI0Gzy5UBwb+L3eeXbanlCDMAjrTZP
 Rm7oAUiUR2hDZqx+CfhbVjbk18h6IwhzJTEArT8hnmtgOUyar36ZJxcU3RfbYV4v7xfv
 KlK4vdRXUfYJIm0Jp1SMTnkzKGmvfZe6OJygwp4SASmpL9JCqCzcdUVX+TlNKFoQiKv5
 nnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711082613; x=1711687413;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+tTWPMac9UPB5pCkc5seamOgZmsH/8X8ybAzInKOXRI=;
 b=XAFLLSfS0j59mkmXc1ekC9HLvNPw6QAIKqajY6p7wi+9Tl/uTZb/GPfOHNgVmxW1Iu
 sopUjv8D8+NHNtgQWnMXnsVdM+4uyYdF7ymLf86eRz9TuHT3pdqe+4bAqL2Ha3YfgMkL
 PK1HiFfEdgAcCND859UeloONVC1CMcWbOZIjkBUKNRqNyBRXjtVa77A2C9eBT2kNm88U
 NemWLG835cOgZkcJSldf01sgz+8QgYFgYoLJKTynrpS0fEwY3p6M+7RJNBNy1XETqfJk
 sEC+1VQqB8G5LHpC1UgByk0z5vSKijYwzJi+9WZWRUhU5BPzWADN/D3okkNzr5otlQok
 R7sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsKOsqsTAg3905bE9xdl7LBiWrudLhBgSdxCgsW4IkmoeCbl6HPTz8fwe/I7tZJbrlOf5JNwTgGHfCIlPFMtB+aBAPx/I=
X-Gm-Message-State: AOJu0YwJ9k69mdReyga8AYHBEP8aIWbviM3cvh6Iahb0NCs7nkePaaL2
 ZIaxfhDnM14TJMdUrRaPWRDb+WFO1JfFO9A1uPxewF4bgq7gMLQporVJDGefUFF1Rb6hWNObEKa
 sVEFAIf5rW79rFXKs4PmQbZhmyWI=
X-Google-Smtp-Source: AGHT+IFWNbWBKwpWKDCyo5nZZJMBlr3F1YyB0aULHRgS9DNbPsYhU7FOtANnB0jtlsKWdiXQoPuGZOX9RhdI5k1Samk=
X-Received: by 2002:a05:6122:3093:b0:4d3:45a2:ae4f with SMTP id
 cd19-20020a056122309300b004d345a2ae4fmr1463438vkb.14.1711082613031; Thu, 21
 Mar 2024 21:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240320172828.23965-1-irina.ryapolova@syntacore.com>
In-Reply-To: <20240320172828.23965-1-irina.ryapolova@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 22 Mar 2024 14:43:06 +1000
Message-ID: <CAKmqyKNKuwPHRaHfdZM6HjwZXpUt7d+S6m68w8Tr2CX=-Tem3w@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix mode in riscv_tlb_fill
To: Irina Ryapolova <irina.ryapolova@syntacore.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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

On Thu, Mar 21, 2024 at 3:29=E2=80=AFAM Irina Ryapolova
<irina.ryapolova@syntacore.com> wrote:
>
> Need to convert mmu_idx to privilege mode for PMP function.
>
> Signed-off-by: Irina Ryapolova <irina.ryapolova@syntacore.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index ce7322011d..fc090d729a 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1315,7 +1315,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address=
, int size,
>      bool two_stage_lookup =3D mmuidx_2stage(mmu_idx);
>      bool two_stage_indirect_error =3D false;
>      int ret =3D TRANSLATE_FAIL;
> -    int mode =3D mmu_idx;
> +    int mode =3D mmuidx_priv(mmu_idx);
>      /* default TLB page size */
>      target_ulong tlb_size =3D TARGET_PAGE_SIZE;
>
> --
> 2.25.1
>
>

