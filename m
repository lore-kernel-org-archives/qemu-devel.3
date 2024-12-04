Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AA9E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 03:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIgTY-00014t-V9; Tue, 03 Dec 2024 22:54:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIgTW-00014M-Sd; Tue, 03 Dec 2024 22:54:54 -0500
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIgTV-0000rf-67; Tue, 03 Dec 2024 22:54:54 -0500
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-85b0a934a17so240798241.1; 
 Tue, 03 Dec 2024 19:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733284492; x=1733889292; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z+jcOg/49a40iyYN/WeXhkyR7+c+rgJMsVhXaUYeFeg=;
 b=kS6h95yOky/QwBw4JrvlQ3CPYeMDMVs8Ze4M3K3fBdKBv4MWFespC+StIyS9yyyKBH
 vELlanlPNE7Xc5ac6uPXtM0UVDWoeKoiSWl689E/uVY8rBKjhFoI1j1aQ7VyKGwpahWy
 hM9QbpMg0KUEw5TgIEX1Rm9FYMwoZXds6gvP+AIdk096ouXuX5Dn37drASwXtQ4aBLQ3
 sm1jV3oHrleUniemHBVTQLJ6u3jkxkDoPs9wS6wCOVnWrbVCZYNWNpXc7yZnzuVS8Nq6
 q5TbosKFmQPUODZGKucmHW/7x419v283qBHTK7P7hqCJIY8HKmD4ajA5XFeMydWvSuN9
 g6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733284492; x=1733889292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z+jcOg/49a40iyYN/WeXhkyR7+c+rgJMsVhXaUYeFeg=;
 b=uYdLOd15t8XTs6AZ8fxSQltQwJQ7cP/d+mEptNY2XCWqpJWXjiypckqZ6hWWhDpEM6
 XkJegygELKtmzBCqEilAjobe16U8YkI9A8w7U2UOsAprdCzLzvCVe2mRijE+d949qDVc
 sqrFVvc+rKZXd4lTB8UF+NES/PiixjP/jEUbSXU+NR5gBxtn1i0nMXv6wKFjPXVUsifH
 /RyjTLdqQGmmT/f8ud/rOZSCu8EqY1/z9rvjWQFNZAiTIEu5BBNoQJ1Su2CasvfudT/V
 ES/IS3hCIbYpGBCQsALWl4yc+CvB0HEEptPRt/vJ4mKgCEW7/Z0jNzDCWLfTBBHGKjPF
 t7EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf95waT+ViIZCC0AiBNO8ZBwXAQHh+TP/STCSDSwzRB4Pn17niSyOlNMLh1xjOIddfkcCRUj5lHf1h@nongnu.org
X-Gm-Message-State: AOJu0YzDn4GwC7lm8zGc+XOAbV8G/0hFhSzPfh7BYFMyu1p0r1jFp2jZ
 yp3nZFE0bC3JMIQAsiqkm6rzqeH6xZutKa6iJJvcxuLWIrHkN0EEmmcNDWGnmOXssVHU5efM4PN
 2032Y7ip91/ugyEmxW6jsTlTedbc=
X-Gm-Gg: ASbGncuN8ho09kVJR8We0ryiSFyhVhLvYpJnuuBkh8X1UfvodFCFRe7f/dkYadKLHy9
 kMwEuxDwC/5iV0cMtQRAYzLAUOzqqQY8Q
X-Google-Smtp-Source: AGHT+IEElRPQiFAKuPhh6M2KbI/DgAp4pCyjSywQRTV5X5HW0e8IynlkUuRFRtu2dFGQswTU/lfNr87V+mN2m+qunkg=
X-Received: by 2002:a05:6122:511b:20b0:515:25f5:46f6 with SMTP id
 71dfb90a1353d-5156a8e0c74mr21665130e0c.4.1733284491794; Tue, 03 Dec 2024
 19:54:51 -0800 (PST)
MIME-Version: 1.0
References: <20241113171755.978109-1-dbarboza@ventanamicro.com>
 <20241113171755.978109-9-dbarboza@ventanamicro.com>
In-Reply-To: <20241113171755.978109-9-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Dec 2024 12:54:24 +0900
Message-ID: <CAKmqyKOXizYgEoOpONHyQffUMWH2XdC4P_7=-cKHBCSn=qrEfQ@mail.gmail.com>
Subject: Re: [PATCH for-10.0 8/9] target/riscv: add shgatpa
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
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

On Thu, Nov 14, 2024 at 2:20=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> shgatpa is defined in RVA22 as:
>
> "For each supported virtual memory scheme SvNN supported in satp, the
> corresponding hgatp SvNNx4 mode must be supported. The hgatp mode Bare
> must also be supported."
>
> Claim support for shgatpa since this is always true for TCG.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 068b019564..fff7010647 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -184,6 +184,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>      ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12)=
,
> +    ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(shvsatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
> --
> 2.47.0
>
>

