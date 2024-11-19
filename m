Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5A6D60D15
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 03:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDEox-00020F-CZ; Mon, 18 Nov 2024 22:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDEou-0001zm-Vk; Mon, 18 Nov 2024 22:22:28 -0500
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDEot-0000JD-BK; Mon, 18 Nov 2024 22:22:28 -0500
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-5146e6531c8so1705640e0c.0; 
 Mon, 18 Nov 2024 19:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731986546; x=1732591346; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6EzN8XVDkxhSENCMp/r4kGX4NcCbrOFXoCOVAuPu5VU=;
 b=ijKODseTD+HHWdruZWsnYhGShojxBJxepZYGENYGZ9znMp8iVphkqQXiYwpO3oW/Is
 WuoGPl8s1UcJ3WcLL3H5mS7h15gfJ7IE32JBF938N2W4p3ZNlUFIiYeqwHgIzxo2F5fb
 mWeQQYruwLt/qZK/CMHe5T+5WWGaUbeV4wnHh+Atgt4gHzTxib2EVF2Os/MZfUY5l6s5
 d6WurJW6HRBozIWPgmTk7qSp+Bi7TiifhsHRioVn6JbPpQJaIEg2WE7lBaxEVBW+sLZl
 LgLnIwR9tVyDkqlxqeH5Jxt/1mFCQK//uBIVGBI+eXFnNQ+XSJYjc7HWrvXHz37tz3X5
 wMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731986546; x=1732591346;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6EzN8XVDkxhSENCMp/r4kGX4NcCbrOFXoCOVAuPu5VU=;
 b=kBbr6SSDqJLpLSecCSdCkPtazmYDlEu/BWShQJ1gro6971BvkA0Qe4P5S65BTLOW1w
 iL69mQiAJqsMsvDS7qJGtkW7USGimSUWkhzWVTw1z3U2gaWGzaNnK1JrHSmgBom+Km0N
 Vl+FW3wkFbXfoKmFH7C8qCWAsG1cNzdKZG06C3y79MmL3JgP8moZtAx+0uWwURYQyF17
 UCrqn+aOeoJzEwHRZCwwmnRwJMqJjPgUn3OctGtRLxbYnYfrWN+MGMB2r51Cuwgi5zpG
 3Q0OScq2B37GFu4ligvVzaZyMnlcJZVf8WC1Lk+irOOdszToI5QWUqjaNLcBk17LpSu1
 ZYIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7my1er5iFV3VG59olme+xq1P0e/2+fq4rHs4U7ODuc3GQMAQ7YvJX4BhIA2k0OSNGyEat6uk7XqBF@nongnu.org
X-Gm-Message-State: AOJu0Ywkh5ngVRXhmLf0HqHIClW1324Iw+sZjl88/XmgmIKknGShRjD8
 n6g8VBnFhPcb13r3bZ1miiTxNW5Mc/PQBHjcTDZj6vQIhyKdztdJEabigCZf/kcjlAE0J8dj6zV
 Qu7vEGkN5dV4dAYuQ+2xnt0Td5F8=
X-Google-Smtp-Source: AGHT+IFmWJK8MrqZ8a7bk9gUs9SWDVHQ9hEu2ih12QlvOL/d+c0s+uPka8YRUSX+dXib4VnmyJdkMwBtTOZwfO6t4QU=
X-Received: by 2002:a05:6102:3709:b0:4ad:5c9d:51e4 with SMTP id
 ada2fe7eead31-4ad62bcb0cemr11512401137.12.1731986546029; Mon, 18 Nov 2024
 19:22:26 -0800 (PST)
MIME-Version: 1.0
References: <20241112091423.2529583-1-fea.wang@sifive.com>
 <20241112091423.2529583-2-fea.wang@sifive.com>
In-Reply-To: <20241112091423.2529583-2-fea.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 Nov 2024 13:22:00 +1000
Message-ID: <CAKmqyKMUYhHUNf6SO9oc3atDiGCfVn0MasKUAYNgjyk_q=O+4Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] target/riscv: Add svukte extension capability
 variable
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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

On Tue, Nov 12, 2024 at 7:13=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wrot=
e:
>
> Refer to the draft of svukte extension from:
> https://github.com/riscv/riscv-isa-manual/pull/1564
>
> Svukte provides a means to make user-mode accesses to supervisor memory
> raise page faults in constant time, mitigating attacks that attempt to
> discover the supervisor software's address-space layout.
>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_cfg.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 59d6fc445d..d8771ca641 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -84,6 +84,7 @@ struct RISCVCPUConfig {
>      bool ext_svnapot;
>      bool ext_svpbmt;
>      bool ext_svvptc;
> +    bool ext_svukte;
>      bool ext_zdinx;
>      bool ext_zaamo;
>      bool ext_zacas;
> --
> 2.34.1
>
>

