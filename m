Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088F0C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 02:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1GZR-0007RK-Kh; Sun, 28 Apr 2024 22:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1GZP-0007MN-F7; Sun, 28 Apr 2024 22:16:43 -0400
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1GZN-0000xu-UG; Sun, 28 Apr 2024 22:16:43 -0400
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-47a21e0cde6so1398949137.0; 
 Sun, 28 Apr 2024 19:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714357000; x=1714961800; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B05RovfS5kcR6LTGuA1spePZflrwdiaQiwJsgN2PNcE=;
 b=Ba762QjZcqCF2030zH0L2fKfMF91wL//4/6e2JNNZBzEBJB8AoXRCOgo7/XuGVfyew
 MV1CMDbMJy6T+Id8bqnyYQUrCLWc6QpQRhbSo7CTjVSx0fHWRauJ1iGPCsvPC+DYsxKP
 ak5N5tJbFyttZ7RwemTO7nwOgDyga5QE093GpK2n3SDyUZggvBQauvT7QJ9Vv0pBYQrw
 mkuWtyrrptZ+DQx6a0VehKvke7rFdhVKseMW9XFaVhA2Zo6rEB8OP7PZfUZ6JI/wgrXQ
 DuhYYXRUcHxGdEgm2u6OZMJgfXZNrYvJtmh1O4d+iUgegwphnsCvuWLLXkcqCvMcalj+
 tgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714357000; x=1714961800;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B05RovfS5kcR6LTGuA1spePZflrwdiaQiwJsgN2PNcE=;
 b=j2RAMoghVLP+LFipqniCKqdqGDRJ1sZ9ffq9F+o9sG5i2XLMQd5e09xWw346vxRfYg
 5Du9iPLvXVDd+aBNNoxKpEcJ+xA4NHS93X3Eq68aEImb42KAtaUA3yCgD1K5UC3vxa6l
 3Uz9oFsiABw4vokeYoPkWdgzwwCL6vhuK4UOeomrCDwJM9QpEpKqxoy0C0VC8nm0TRHE
 ohQ6FXEgSn+1mIMXkYliVptiVLKlbKGX0iUx0pjtEBCIR54CNy4gMPuXam3XQSXJFzQx
 4/z1lLHWse1YyIFywZchdrQklbg9aK5xN81rhXKsBWwQYKd2ObRMoLrsLnB1cku0zNBp
 dzlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7VR3RVDu2np25vTPEHGpXvnbzeWy06hXBwQCkd1coDonUnuovR6dPdJbBzVDZXNoIXf5OQXW3LV9HNTzO2NUcXHwOyLQ=
X-Gm-Message-State: AOJu0YwTxanDWU2mj4LvdTfjtkh5qfkYg3Ewqb5qOndtgDOOKZinuMuJ
 y1Yoeqq8w3kwrBu0FtWTmOrTLtVLFrkQR3h/ploXqtDHjVfaMNpNDhDmtTe169veoeb0vPVbaa3
 RM33b1ne0C2RiJCz4OSnk9IU7eso=
X-Google-Smtp-Source: AGHT+IGHGioQuxcQ6Pwd28X7u375A5xGSwmr3AouOtieZNty+lWVTlmjcJWN4UPg45Dvk2osGHf7AtSRAFg6Bce5vcM=
X-Received: by 2002:a67:ebcb:0:b0:47b:9ca3:e03d with SMTP id
 y11-20020a67ebcb000000b0047b9ca3e03dmr10341317vso.11.1714357000541; Sun, 28
 Apr 2024 19:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240424202425.534338-1-dbarboza@ventanamicro.com>
 <20240424202425.534338-3-dbarboza@ventanamicro.com>
In-Reply-To: <20240424202425.534338-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 12:16:14 +1000
Message-ID: <CAKmqyKP97hZCbrR6KPpGOBkZ-+KuJ2V7QRqQ1Pp2q8C_irgJBw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] checkpatch.pl: forbid strerrorname_np()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, thuth@redhat.com, alex.bennee@linaro.org, 
 philmd@linaro.org, mjt@tls.msk.ru, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe30.google.com
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

On Thu, Apr 25, 2024 at 6:26=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Commit d424db2354 removed an instance of strerrorname_np() because it
> was breaking building with musl libc. A recent RISC-V patch ended up
> re-introducing it again by accident.
>
> Put this function in the baddies list in checkpatch.pl to avoid this
> situation again. This is what it will look like next time:
>
>  $ ./scripts/checkpatch.pl 0001-temp-test.patch
>  ERROR: use strerror() instead of strerrorname_np()
>  #22: FILE: target/riscv/kvm/kvm-cpu.c:1058:
>  +                         strerrorname_np(errno));
>
>  total: 1 errors, 0 warnings, 10 lines checked
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  scripts/checkpatch.pl | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7026895074..f7ffa74858 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3078,6 +3078,9 @@ sub process {
>                 if ($line =3D~ /\b(g_)?assert\(0\)/) {
>                         ERROR("use g_assert_not_reached() instead of asse=
rt(0)\n" . $herecurr);
>                 }
> +               if ($line =3D~ /\bstrerrorname_np\(/) {
> +                       ERROR("use strerror() instead of strerrorname_np(=
)\n" . $herecurr);
> +               }
>                 my $non_exit_glib_asserts =3D qr{g_assert_cmpstr|
>                                                 g_assert_cmpint|
>                                                 g_assert_cmpuint|
> --
> 2.44.0
>
>

