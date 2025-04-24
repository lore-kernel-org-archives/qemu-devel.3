Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92516C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kWI-0005uE-St; Wed, 23 Apr 2025 20:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7kWG-0005tk-5U
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:32:48 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7kWE-0002av-EM
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:32:47 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-5290be1aedcso1696959e0c.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745454765; x=1746059565; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=esKsHrnQer7iO411ZPCTiG7zyug/pqlbD5JnZ+Zkem0=;
 b=Fprw9XDkuhqxj7gv+9YXr7pE6axeduP8VCNuT19W2cfJi06rXuLpyqSUbGxIMj5hEP
 BsSf2riLcPEaE0dEWmIGISAu8taDshY8W8xzETaba33TguVui9NR5Q8uiCRxSL8qqijU
 WtM12XnJeLsApJcHMaFJONWyzOStk+pBpvdAlzuYd3tVGNfRxFAi61o6vDLzMFjnBj6k
 ks2IuK8+0ysWTcA6mdPKxYGStBo3sL4eDjnPOGhG+duKGvDjtPpUHNnk5DXXbmMI9RcR
 dLReVw59DALNJkRjTSv1LhL99Zji1pmBjKkgZx893fzLnDSIYJ6i2WnxlgJZPDAKjV/y
 hc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745454765; x=1746059565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=esKsHrnQer7iO411ZPCTiG7zyug/pqlbD5JnZ+Zkem0=;
 b=U7oN1WDD3pd/13OlKfTcg1X4uKiDe298CKmFwoNs2NhCI1UIIHaDWgd1mfkHW6wHbL
 sllVCW/nVHXwq3gvgZiImEiUESc+sJCNic3EvHMuYxkq/WANk/+1mZtRLIaLzkT88+lj
 dUbQ0NKmaogy7tse7SayflgTNj1m5P/dgh0pcAyjNI/lf/UHWmqF6M2HDYfBhVAM0fgQ
 0K5CF+Z9xcV73GyHwnKUOp0T37K8j2JmiUWLGM6TvK57FjzEKVPZU8hOqDZUyHCbhlE7
 dIxIO5/c1tu2BtvzEczwF1PPbE09HaGE6R8XwWjel9Fb2F/pPtUrctQiAb0DuDZNhAOm
 WxKQ==
X-Gm-Message-State: AOJu0YwuT+30yJf6h+SecqoCQW1cQiQm02PjqUTDM3k8fRb91t0VbL8T
 2eRRReGuCoDuKKfTl5Mx2as00FbVKLZSFkfFqQSzS3n5unMzQ4syybDKyD94zhDXdAPA8exk1Ox
 r9sCoxx/Mr7npDaHyU8B4JfxYy6QEDQ==
X-Gm-Gg: ASbGncsX70/AC3zDU2qSf/3/PfEfhbmUZp7dzwXMD9exmxOzN/sGXKOr+zUmPq7EU+E
 nPc/q9C4UBLlnzWHZjOoJkuUetdkJFxnXvwF/SDUCxqgX000VWMWihyfF+EPfxTOd4cSsZ3zAgC
 Wvf7stzQ4nG+PDo5ZV0SNwv0Pixg4r0aMJR2zNkt1AiwazG6ORZvCH
X-Google-Smtp-Source: AGHT+IEC8lnORAarIkT9tRJ2CJSYAVwwOs+QijVOBYA6tDgotfYOVT/7Hj00vdSFJOKSt6x9xPMPHC0kmH64by57ods=
X-Received: by 2002:a05:6122:238d:b0:527:b804:ff78 with SMTP id
 71dfb90a1353d-52a79cecf47mr295581e0c.1.1745454765078; Wed, 23 Apr 2025
 17:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250406070254.274797-1-pbonzini@redhat.com>
 <20250406070254.274797-22-pbonzini@redhat.com>
In-Reply-To: <20250406070254.274797-22-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 10:32:19 +1000
X-Gm-Features: ATxdqUEveegogw2_RTBb6sToYM8_ZB2YSAoMrqr5PMY4Nj8_Rk8-AjefdGrCFkU
Message-ID: <CAKmqyKOeT5Jxc8Z9whpC8Vcm7NFijtSE9HWTJueJGjo9N=J30g@mail.gmail.com>
Subject: Re: [PATCH 21/27] target/riscv: th: make CSR insertion test a bit
 more intuitive
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2e.google.com
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

On Sun, Apr 6, 2025 at 5:03=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> In preparation for generalizing the custom CSR functionality,
> make the test return bool instead of int.  Make the insertion_test
> optional, too.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/th_csr.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
> index 6c970d4e813..969a9fe3c80 100644
> --- a/target/riscv/th_csr.c
> +++ b/target/riscv/th_csr.c
> @@ -29,7 +29,7 @@
>
>  typedef struct {
>      int csrno;
> -    int (*insertion_test)(RISCVCPU *cpu);
> +    bool (*insertion_test)(RISCVCPU *cpu);
>      riscv_csr_operations csr_ops;
>  } riscv_csr;
>
> @@ -42,13 +42,9 @@ static RISCVException smode(CPURISCVState *env, int cs=
rno)
>      return RISCV_EXCP_ILLEGAL_INST;
>  }
>
> -static int test_thead_mvendorid(RISCVCPU *cpu)
> +static bool test_thead_mvendorid(RISCVCPU *cpu)
>  {
> -    if (cpu->cfg.mvendorid !=3D THEAD_VENDOR_ID) {
> -        return -1;
> -    }
> -
> -    return 0;
> +    return cpu->cfg.mvendorid =3D=3D THEAD_VENDOR_ID;
>  }
>
>  static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
> @@ -66,13 +62,12 @@ static riscv_csr th_csr_list[] =3D {
>          .csr_ops =3D { "th.sxstatus", smode, read_th_sxstatus }
>      }
>  };
> -
>  void th_register_custom_csrs(RISCVCPU *cpu)
>  {
>      for (size_t i =3D 0; i < ARRAY_SIZE(th_csr_list); i++) {
>          int csrno =3D th_csr_list[i].csrno;
>          riscv_csr_operations *csr_ops =3D &th_csr_list[i].csr_ops;
> -        if (!th_csr_list[i].insertion_test(cpu)) {
> +        if (!th_csr_list[i].insertion_test || th_csr_list[i].insertion_t=
est(cpu)) {
>              riscv_set_csr_ops(csrno, csr_ops);
>          }
>      }
> --
> 2.49.0
>

