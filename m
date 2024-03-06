Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B30CC54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 01:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhgGu-000706-FU; Tue, 05 Mar 2024 20:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhgGc-0006rE-UB; Tue, 05 Mar 2024 20:40:24 -0500
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhgGb-0005oj-EL; Tue, 05 Mar 2024 20:40:22 -0500
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-7dad83f225cso181219241.2; 
 Tue, 05 Mar 2024 17:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709689220; x=1710294020; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jfz18h3LH3supqkqIwvmvij97PQDzrOba52pvfQEjDY=;
 b=bdusj8jJvoB1EFUf0ydoeQLF/pMl0y+K8q0bUlt0EBjhvBt6WARwEzCQKq6H77SKZ+
 uvDF7iFyp5HSkmtv3vucO7+NBr1sibjFPjkjgWPo2LY4oNndpFid/iDvTYUyKtOMQSBP
 NGIBYnQ7F3qyJX8d+UXC18q6eGPQ+hZvStrPvQJqUBYbo48fBHIm/BKGZQcgnYFXxMwa
 8AuiXiTYQXHt9ZBFDzKwiXEyPlRVhyB7XvKdcRX2Tn1aBbrGtNReTgYxiYUh4qYEfOgu
 Bix0ak4UPLvyqU0i9XYLsFpXg7CMYRrYBY8sv+++FTYcnSTVJaWzSnAYlo/hPqtwH7Ke
 DLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709689220; x=1710294020;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jfz18h3LH3supqkqIwvmvij97PQDzrOba52pvfQEjDY=;
 b=XCW194xuVog3dZxfPLLYiCCznXpXDSj3p+n9jScuVkGc71X22MkVEjSkPWu2zsBWLj
 q8iJRAx8KGsWqj8wD7ncvuioG8K5Zm/4RK7yDIO26yYucR9Rqw4lGJM2qcnJVlqP2lN3
 GLxyGKR0FRvSYl7jokhlOx5esi2htmlqVeIfSKgqtk2oJEihC9mYRlQ/FTvWfbtIMkAB
 rSJzuJOFKDmFwy3pQJkhYOO2maPRMTBqOfVaUCvDYeyZ/vflw0ANKtJ5ibnjaFuzUdqK
 4CXN5PaZG7MYQlB8LAfaPnKs/nSUUGHUS20c1/fIlBNAdEu/Wn3s6aWbC6DnQB5yjl2C
 f9sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7t7oi2djNcQn4FGKntVgtuA71y0gTc19DSX7XyvLeB1IeOaEpFOF8c5vviQQSchr6W/EgZ3DFP/+6yFHM6l/tdnWQuZo=
X-Gm-Message-State: AOJu0YxtSgnPdmadNntjhGzG4EwIYqgNvzcd41jXwaZtj6qYmJgySS47
 BsWcdTjP5o2ZnxsZPV2SxceFmGQQYowK2HyIE36UsWpcDYSO2cmh3k+rPXNbZzZdLIxQnDhuVwo
 cVmhFpeK4PMnwSff2NTsKUCDmg90=
X-Google-Smtp-Source: AGHT+IGUy5ZE5Huym3oo1bSdfQhK4P/xhmoHCFOnJubii75pWWON+PQ4tkg01SZs90+OzZHf+b1wrvUkRTdxn1OO0yg=
X-Received: by 2002:a05:6122:1d15:b0:4d3:45a2:ae53 with SMTP id
 gc21-20020a0561221d1500b004d345a2ae53mr3739496vkb.16.1709689219805; Tue, 05
 Mar 2024 17:40:19 -0800 (PST)
MIME-Version: 1.0
References: <20240221213140.365232-1-dbarboza@ventanamicro.com>
 <20240221213140.365232-10-dbarboza@ventanamicro.com>
In-Reply-To: <20240221213140.365232-10-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Mar 2024 11:39:53 +1000
Message-ID: <CAKmqyKMWRRqqNDyyCgpxe7bGC8QFuLXVn3D9m1e-1KnSF-NRyw@mail.gmail.com>
Subject: Re: [PATCH v6 9/9] target/riscv/vector_helper.c: optimize loops in
 ldst helpers
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, richard.henderson@linaro.org, max.chou@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
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

On Thu, Feb 22, 2024 at 7:33=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Change the for loops in ldst helpers to do a single increment in the
> counter, and assign it env->vstart, to avoid re-reading from vstart
> every time.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/vector_helper.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index cc7290a1bb..1ab386830a 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -208,7 +208,7 @@ vext_ldst_stride(void *vd, void *v0, target_ulong bas=
e,
>      uint32_t esz =3D 1 << log2_esz;
>      uint32_t vma =3D vext_vma(desc);
>
> -    for (i =3D env->vstart; i < env->vl; i++, env->vstart++) {
> +    for (i =3D env->vstart; i < env->vl; env->vstart =3D ++i) {
>          k =3D 0;
>          while (k < nf) {
>              if (!vm && !vext_elem_mask(v0, i)) {
> @@ -274,7 +274,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVSta=
te *env, uint32_t desc,
>      uint32_t esz =3D 1 << log2_esz;
>
>      /* load bytes from guest memory */
> -    for (i =3D env->vstart; i < evl; i++, env->vstart++) {
> +    for (i =3D env->vstart; i < evl; env->vstart =3D ++i) {
>          k =3D 0;
>          while (k < nf) {
>              target_ulong addr =3D base + ((i * nf + k) << log2_esz);
> @@ -388,7 +388,7 @@ vext_ldst_index(void *vd, void *v0, target_ulong base=
,
>      uint32_t vma =3D vext_vma(desc);
>
>      /* load bytes from guest memory */
> -    for (i =3D env->vstart; i < env->vl; i++, env->vstart++) {
> +    for (i =3D env->vstart; i < env->vl; env->vstart =3D ++i) {
>          k =3D 0;
>          while (k < nf) {
>              if (!vm && !vext_elem_mask(v0, i)) {
> --
> 2.43.2
>
>

