Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A122C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 10:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7u6O-0006hp-Jy; Thu, 24 Apr 2025 06:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7u6L-0006gb-R3; Thu, 24 Apr 2025 06:46:41 -0400
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7u6K-0000Ss-9b; Thu, 24 Apr 2025 06:46:41 -0400
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-5259327a937so379613e0c.0; 
 Thu, 24 Apr 2025 03:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745491598; x=1746096398; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gldqhwn3bY2EToG0EOitYqvu7nz9n7/zxEWI+oKUUR0=;
 b=PXJJvaKXwyASQQtOKdYVRFtnIih2f0R3mPTtYInd9B/QssiWPIQaQEWOE6tUqUb4ia
 Am+yUachzvBGiL9lwEKZREwrw+bsFoDZvoikr2rdnv37145pw8rAb161wFqznCwZcwNr
 SRbN+K/u4ncuj2C1QvlEChN+RxCkWaqdEqzUFi4pXU0ybPQLktEuSJfImMOKJCDCv6G4
 fABV397ptu6f8eA3/TTQEWMSyi6IBo7bwapSMey8lp38CfdxgxEKQ8YeWCRkk4qzF9Ya
 JDrmwjnOFN6LAHyITFz/qLtUwSSadU+PWmYNamlGV39CCSVTzvt6yyoLPmPLKe/RK6QK
 D8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745491598; x=1746096398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gldqhwn3bY2EToG0EOitYqvu7nz9n7/zxEWI+oKUUR0=;
 b=fpHD3fDIC+5oGIWWfY4nrvUTcINd+0JJG4MQ3L8l0AuWbe3hZCz7OiATcaN2Ting+N
 6r3itbiDofz9omI1WWTKAMtFYDRm/5e/TC3CJKNJTidCPd76cuTp0J26xUlzXc/VSNNB
 zWC88HIinu+ZVXknUsPEbhp+f+GHNzJgdqGqdMc6u9VDA7Sjv9Et1lGwwVroN90YPVhZ
 WeDXEo7k774rgTObraar8a3QEIK3YCyrdVV9WTHDvOKV8YnkCZ1saEDg1mNx7wkrnJGs
 YuTE300HRzlBxcFbEGbGX1XjGTZunCnVgjgpmRfuRhGHjkCwm5bGh9qPUodbYxT3NHf1
 Da+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZWJWHDlpat4U50iyGEprmi+vw2eB2UTeqVonZKKVZ1AEEBtwP/vVn6IN54nMpz4eqRcCnIjcDzgPO@nongnu.org
X-Gm-Message-State: AOJu0YwSR8v5dotBPsMC8SV37BfPADACKV7gu1jQOpS7fSXoxkFwa8ST
 W3qVcoSUscVjPRb3pBG45JqXVJ5DlniSjV7kh3cOxnX1hd0GGXp1iXF3b15obK/8VBanPZsL+7t
 b1um77wRveJ0bcOg3ThmrKRVLnrCbmQ==
X-Gm-Gg: ASbGncuhF2yUdyfFIdpijFdqc6ldkCXVlzOx3ciFfBLfdZa9Z0WkKq5CCaiMOYvc0o1
 xizxNyHyHlriz7zLh1OEAQmOMh/Qd/zkofq+fa6F6+zsHZFkNnBYTLZElzc/kou8Lh06SCZpgK0
 H7yN1ZIkdaQm9f13sE+1xyDvAbv+PqdyYcbzxgb5BLVCCusTD/H5Vs
X-Google-Smtp-Source: AGHT+IGm4vvSRPGyC9cT40Io+kT2Cj0SK/DeZFBcoN+1XPUBTZPFsMVSIz0I9dWyVsPnslLSC5DOfzyKxfQ5U3ZtJzE=
X-Received: by 2002:a05:6102:32d6:b0:4bb:e5bf:9c7d with SMTP id
 ada2fe7eead31-4d38eef371cmr1394107137.17.1745491598355; Thu, 24 Apr 2025
 03:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250414213006.3509058-1-antonb@tenstorrent.com>
In-Reply-To: <20250414213006.3509058-1-antonb@tenstorrent.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 20:46:11 +1000
X-Gm-Features: ATxdqUGexc-e8l4RG7Ysm8-aRz0gco60SWEVCcAx7Wk89Ezjvm7u21FnuNOIfUE
Message-ID: <CAKmqyKN=5AHRkf_20pBWv+F_Jv4Fbj6qrHHsovO5x=PJDteu3A@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix vslidedown with rvv_ta_all_1s
To: Anton Blanchard <antonb@tenstorrent.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
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

On Tue, Apr 15, 2025 at 7:31=E2=80=AFAM Anton Blanchard <antonb@tenstorrent=
.com> wrote:
>
> vslidedown always zeroes elements past vl, where it should use the
> tail policy.
>
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/vector_helper.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 67b3bafebb..1012d38c8a 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -5113,9 +5113,11 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong=
 s1, void *vs2,         \
>      }                                                                   =
  \
>                                                                          =
  \
>      for (i =3D i_max; i < vl; ++i) {                                    =
    \
> -        if (vm || vext_elem_mask(v0, i)) {                              =
  \
> -            *((ETYPE *)vd + H(i)) =3D 0;                                =
    \
> +        if (!vm && !vext_elem_mask(v0, i)) {                            =
  \
> +            vext_set_elems_1s(vd, vma, i * esz, (i + 1) * esz);         =
  \
> +            continue;                                                   =
  \
>          }                                                               =
  \
> +        *((ETYPE *)vd + H(i)) =3D 0;                                    =
    \
>      }                                                                   =
  \
>                                                                          =
  \
>      env->vstart =3D 0;                                                  =
    \
> --
> 2.34.1
>
>

