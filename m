Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F34C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 00:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEISK-0006oP-MH; Mon, 03 Jun 2024 20:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEISJ-0006nk-7J; Mon, 03 Jun 2024 20:55:15 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEISH-0005EG-RP; Mon, 03 Jun 2024 20:55:14 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4e4efbc3218so2459184e0c.0; 
 Mon, 03 Jun 2024 17:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717462512; x=1718067312; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wY1ESK1H7eHfBgdMXwP1JV5QPjS5/4kwKby93iGFfrQ=;
 b=dyQLWlywNu58Gwj9cciWNX6/YLJV+mwbhJERc3k+zpaSw371Xr3IEhBW7IvUawcg0K
 9qXptH5vUOtvXTWeibzeSPT8UNrSrGsFzAHiyU07YZEBtclFkuyefTwKRX1LLGg0ACY6
 sRzkgvOcEhGxmqqud0fnok9fgzthVMHXpdks7WqcN1j9o9IFJdPRJl1SFakaHBKXgK46
 WN51Pshf2XvwrNUiJW0BDmSyW4z5mvEVXXh6t5xhXUyJg1SxtGXbE7kt4de9sKVi7r9s
 k/oQid2rkNT/p3Hq0uUQFgfnEJL+3XjFb+WnzYSfr/wuL+pjVnHE0HFxie+/+4EQ0WOd
 gfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717462512; x=1718067312;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wY1ESK1H7eHfBgdMXwP1JV5QPjS5/4kwKby93iGFfrQ=;
 b=IZ9vfyLmd7JEs9mDBaksmMxBcVuuTB46AZQpsvCBfGbeujMcEXu75uw1pfpj9AqX20
 JKNI51M4cPN5A5yep7llx3CNbIK7eIgzFrVFISww9rEqh63zMSBGCukbOi3vPvy82yt/
 QIsQyu1K4PZa7i657/++A01+P8LLsA3S0shtLjyEEajkuC0c/Kj9c7fad2lGKdsboG6p
 Av2kpMapmDxJJ5NzI5Wl7wA8lsnHOAfv9SfcVEpMictAAbY9vgeW4ygchynHz3nFVp0r
 3drymj2pLnnJy65G49eZgjvzATaR3bxIRUC2fvolOz1FNXGvAx7xCh3MBmryvQmtaZhW
 DHQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu4n2zCiPVNse6zCjaXcwBjxzjXhCKIWSStNte2Mcaxma6onBon1HDS2XkqQ8rpanQyzM6mns/6C3nMOuSv0LGwi/X6lU=
X-Gm-Message-State: AOJu0Yyid6FcYVJBMHg561RQRDPDbfv2Mmk3rklGMv3ExH/s0axd2EJA
 /uIqfSRaEm1Po8cTknY+YQJEvxK989AYz5qU7oFUXLrNlRG7P13iNCOxUiW1pNaGE/oRMth06ur
 9Vw0TQDqgexiIDRJVuvRVtu40u4o=
X-Google-Smtp-Source: AGHT+IHZ+PHOro9M7aWSW04Xfqv4do2favBlGvkNgQGV4TWv2ERdPargDNAITWNXoJnh8zgRdBfdwiPTcHqdn1p/pOk=
X-Received: by 2002:a05:6122:16a5:b0:4e4:eade:1965 with SMTP id
 71dfb90a1353d-4eb02dad2f4mr11023995e0c.3.1717462510978; Mon, 03 Jun 2024
 17:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240515080605.2675399-1-fea.wang@sifive.com>
 <20240515080605.2675399-6-fea.wang@sifive.com>
In-Reply-To: <20240515080605.2675399-6-fea.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 10:54:44 +1000
Message-ID: <CAKmqyKOZXyMtWVWvtEnGSKpj+hm==qijONyBhv37fNB=Wajjfg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 5/5] target/riscv: Reserve exception codes for
 sw-check and hw-err
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Frank Chang <frank.chang@sifive.com>, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
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

On Wed, May 15, 2024 at 6:02=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wrot=
e:
>
> Based on the priv-1.13.0, add the exception codes for Software-check and
> Hardware-error.
>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_bits.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index f888025c59..f037f727d9 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -673,6 +673,8 @@ typedef enum RISCVException {
>      RISCV_EXCP_INST_PAGE_FAULT =3D 0xc, /* since: priv-1.10.0 */
>      RISCV_EXCP_LOAD_PAGE_FAULT =3D 0xd, /* since: priv-1.10.0 */
>      RISCV_EXCP_STORE_PAGE_FAULT =3D 0xf, /* since: priv-1.10.0 */
> +    RISCV_EXCP_SW_CHECK =3D 0x12, /* since: priv-1.13.0 */
> +    RISCV_EXCP_HW_ERR =3D 0x13, /* since: priv-1.13.0 */
>      RISCV_EXCP_INST_GUEST_PAGE_FAULT =3D 0x14,
>      RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT =3D 0x15,
>      RISCV_EXCP_VIRT_INSTRUCTION_FAULT =3D 0x16,
> --
> 2.34.1
>
>

