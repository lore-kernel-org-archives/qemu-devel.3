Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476A1C2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 01:16:54 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMH7i-0004cn-FC; Tue, 25 Jun 2024 21:06:58 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMH7T-0004X0-Ek; Tue, 25 Jun 2024 21:06:47 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMH6t-0004ff-7J; Tue, 25 Jun 2024 21:06:31 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-df481bf6680so5798811276.3; 
 Tue, 25 Jun 2024 18:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719363873; x=1719968673; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cxGbC2rsByD1YwhBNK7IZT/41XoUO7KNGTNnsD+3aFQ=;
 b=IB5fTx9iZcobKUaD7k7SlVUBT7xc7Vq7Kpb0DBnnewqgvb/7tSXviiTpr9F7zbRvj+
 wHk0bFxCj7D33/N7VYC0imbbI0saY56jAYEzzxDcA4P8gokyfJn0QDiVR3UHcF5ZAJKQ
 Ur7wRPKOpzL2QYgBVQR4NIVuyyq3ig7W3s5jo0gw4cUT6lmOdxSY8HDjCZqB0GfvwZ2X
 eHQiaCqDAYu2JU9VN3LYjgDrSjm3BGa6rPfdgXYnLMb3BhuLcH4k9zUqyyuVcGPC32jI
 f9KOV5kl0UwKKywoKsbUo2xOvw4dJSiGtsJN2VtFCv+vB3+6Pj9QhpZxcl9bEITVeOH5
 qdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719363873; x=1719968673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cxGbC2rsByD1YwhBNK7IZT/41XoUO7KNGTNnsD+3aFQ=;
 b=U46Nn9QKmsOQChgnxXTYvxHY9DaHKlGj8H8s1bdNaiPgeSnAPwGylVLuewiPxGJvtN
 PqNx7+9yyc4IHy6483aSAemnORoSOfr5vZ3j8a8nsWEpCWUbTtJ/NRYUoCGjpcdeym5a
 4IKXumusUM0AvYr58NqGFkBytUMvmlypz72QP6Cnwovjw5R0FA5u1jZal1zC3LiWYKrm
 p89SgVr344ybdusg8jI80lTKDUfRkMvuIlyS+MW0TjU3gmGICdh8K+No3jZFRzii01hW
 HbqOnVlCfYiHsFitXtq9nu5p+MTRFrp1ihJ32lCDIBzexxD4Ykgc2LQ/d7Jo4W/xc6O1
 VLvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzR6A7On8Xehe7hJBip9c1PM1eRgKv26Hs+B6UMXrLBcyR4kL7NfEV7YVTzFFWruXNSmouuXM0iGlULU3hQOnOavwtOeM=
X-Gm-Message-State: AOJu0YwvQ4xeMfIEz2bV6nq4bV2RJ9TXIvwUKpxPgJ40YrlKBW9vX/sM
 FYzdtBfcIQZOWRgB+86V9YF5wb8qHvvvnE9L21Vny0hfAeJHkbmygvf5pGvLkwXfvYRxxpaInVE
 RlnVhoEWJEoRyAg9Bp31fKl79Ij3Vfw==
X-Google-Smtp-Source: AGHT+IFyEO4T5uU7YIHDoE7W32ODSNXeKpwfo1fMgZzhZXnxpkiqE1yAjOxyJGV1yu7F/hVVXP0XZP3EfHgfR3xebww=
X-Received: by 2002:a05:6122:20a8:b0:4e4:ed90:27e6 with SMTP id
 71dfb90a1353d-4ef6d804647mr7805098e0c.5.1719363412963; Tue, 25 Jun 2024
 17:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240624201825.1054980-1-dbarboza@ventanamicro.com>
 <20240624201825.1054980-2-dbarboza@ventanamicro.com>
In-Reply-To: <20240624201825.1054980-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Jun 2024 10:56:26 +1000
Message-ID: <CAKmqyKM03Jb8a2Bjiwfs=Dc2_KvOExQxJ3RS=ug+on-Bkpz5Ug@mail.gmail.com>
Subject: Re: [PATCH v4 01/14] exec/memtxattr: add process identifier to the
 transaction attributes
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com, 
 frank.chang@sifive.com, jason.chien@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=alistair23@gmail.com; helo=mail-yb1-xb30.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jun 25, 2024 at 6:20=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> Extend memory transaction attributes with process identifier to allow
> per-request address translation logic to use requester_id / process_id
> to identify memory mapping (e.g. enabling IOMMU w/ PASID translations).
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/exec/memattrs.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
> index 14cdd8d582..46d0725416 100644
> --- a/include/exec/memattrs.h
> +++ b/include/exec/memattrs.h
> @@ -52,6 +52,11 @@ typedef struct MemTxAttrs {
>      unsigned int memory:1;
>      /* Requester ID (for MSI for example) */
>      unsigned int requester_id:16;
> +
> +    /*
> +     * PCI PASID support: Limited to 8 bits process identifier.
> +     */
> +    unsigned int pasid:8;
>  } MemTxAttrs;
>
>  /* Bus masters which don't specify any attributes will get this,
> --
> 2.45.2
>
>

