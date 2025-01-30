Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C98C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 23:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdeKO-0003gR-1l; Thu, 30 Jan 2025 18:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdeKM-0003gC-5i; Thu, 30 Jan 2025 18:52:06 -0500
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdeKK-0000W5-NG; Thu, 30 Jan 2025 18:52:05 -0500
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-85c15e283bfso312271241.2; 
 Thu, 30 Jan 2025 15:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738281122; x=1738885922; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D+uHTNZEQ2GlQCOnRnErIk3RxAU1t/+zuUnd9wEHLCM=;
 b=DCG3oUx1MW6vpmOgVX7PS5l5whtjEv3CDtu9fGE4MUKfoKtktjDLzIJJtXkD+esW0I
 zSJu+xFvsqBbW1STznOAz8GhIzRja/djB9iukJv/6O7KRYW0h48eecLlA8tngOhAVksR
 mNR3531GEb8yuXFvt1hWc/O9OZyYCJzIuIkcu1RygYr2NuwsnRSDL6u4tcXcNl7+PmZ6
 ZEsz1sqrCVKVPJjap/nscB+UpFNMKPVGltzdTqcFYB2vO0xWLs6LsgjSMJRkFaJQjW+d
 Udjixrrf1WQG9cXo0xTFwHFRz/7n5sB8MI8S6031jKlcxF5MUnvS8jHr9lU8or1hQ6PY
 ZZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738281122; x=1738885922;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D+uHTNZEQ2GlQCOnRnErIk3RxAU1t/+zuUnd9wEHLCM=;
 b=bgyz7EEIauJH1EiIH9quz1Jc6nhuCoTXwyeufczy/ns0ivvtk4SflSVNeDgzKS+K7L
 CMZLU+V0Ev4Wme5J5fh8w2YPN1G8amPr0qwxr5hbTWvQukwH8z3fVoC5Ld2EBbfWXMo4
 /ydbtHRS/DnqiDiL2+kynUBfVak77iYXnGAmQ2QfgdMTMvQnTNet9WKLQj5ijArkYjyR
 LyrT8KjoAjHwOmCHnQzde6nftZaBLl8HjGSZjgKIIUPvUZ30OTJjsft+JQN3W3kbFojK
 oD+53u7w4+yokrz8oE3h6oDT5gGg8HD43Q4ere8NkVAmE8QXjO15sgheRQNFBRnr8pgX
 D2xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr2NfE7dCvHLnjw5C0h68NCSHGjC6xh90CMnFonRrBVmtA7cKKqKCogkMufXuHwjCQvJjHpqSavQzM@nongnu.org
X-Gm-Message-State: AOJu0Yx5P59RC7lcpQXEj5hi8TNBn7GjrVw/FjNK3Z7VBFLvBfbVrYMO
 5SMIWyqzAhRd5gRlLB0139dj6AzPPKYp+QsTWIJJ1eDNqvXUfS7XSMRezwZEhx8cNlpopLiOwHC
 RC/qX5oAiCpTMhu5VCw+/IRJLt8E=
X-Gm-Gg: ASbGnctaKg430eA2aDKRv4xI5/DUqeyDZWva6l2nhbg3O0U05RHxyfyvuD2XBsuSzoQ
 SlVw1MQLYFX8/piwkbSonlhxZ5s5I+WIEm4bKGcaxIZonJyij1gazpUi536zrU6cvBLsyXCdPVj
 4ile3k9iAFcHnO7bkSGtKhRDtHWCI=
X-Google-Smtp-Source: AGHT+IF5zarOnIz/k1pk6hB9oi7TRY0e9XKKfroux28HJl3xTmblPttEydaM8EHVPo7SnxnuObfKJqGftTqu/9ovkEU=
X-Received: by 2002:a05:6102:5487:b0:4af:ea3b:7b31 with SMTP id
 ada2fe7eead31-4b9a4f8f2c7mr8016129137.14.1738281121836; Thu, 30 Jan 2025
 15:52:01 -0800 (PST)
MIME-Version: 1.0
References: <20250115184316.2344583-1-dbarboza@ventanamicro.com>
 <20250115184316.2344583-2-dbarboza@ventanamicro.com>
In-Reply-To: <20250115184316.2344583-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Jan 2025 09:51:35 +1000
X-Gm-Features: AWEUYZm3fKuKKmL2joN5anej-gtWPc9mdY29k8bz7jvyT5y1Zn5DyHsIOqdtYmY
Message-ID: <CAKmqyKNzpohzfwAynwTBS=K9sLKDaaW0R_Z+3dK85cjWO_iVMQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] target/riscv: add ssu64xl
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
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

On Thu, Jan 16, 2025 at 4:45=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> ssu64xl is defined in RVA22 as:
>
> "sstatus.UXL must be capable of holding the value 2 (i.e., UXLEN=3D64 mus=
t
> be supported)."
>
> This is always true in TCG and it's mandatory for RVA23, so claim
> support for it.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c                |   1 +
>  tests/data/acpi/riscv64/virt/RHCT | Bin 390 -> 398 bytes
>  2 files changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 3d4bd157d2..b187ef2e4b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -213,6 +213,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
>      ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
> +    ISA_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
>      ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
>      ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
> diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/=
virt/RHCT
> index 695022d56c4ac16607d4c622955ad339fbbfe997..b14ec15e553200760a63aad65=
586913d31ea2edc 100644
> GIT binary patch
> delta 48
> zcmZo;?qlW(@^B96V`N}pOqj@Jz^cQ@$e^;(o|BQSxYW#~B4@H2qXkC_BLhPoBLf2f
> D`wIz-
>
> delta 41
> wcmeBUZe!*O@^B7mV`N}poG_8gfK`Q&kwIpoJtyPj07f&87)Az$G)4vn0JA^`U;qFB
>
> --
> 2.47.1
>
>

