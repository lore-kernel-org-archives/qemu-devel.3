Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C4EC71130
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 01:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYxGn-00032a-LL; Mon, 07 Jul 2025 21:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uYxFP-000251-Re; Mon, 07 Jul 2025 21:35:51 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uYxFO-0001aV-5u; Mon, 07 Jul 2025 21:35:51 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-531b4da8189so1494291e0c.1; 
 Mon, 07 Jul 2025 18:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751938548; x=1752543348; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YHbh9PqjaVzAH+AnNv1cTfbOt1hM9cdJ34jcQCsY4ys=;
 b=FGumW/XvgZuHvxKRMjU329vL9hwcc96hz7rWwuopwSTiqe8jRptjSclAgCV2vHbi2P
 HbycL8eeLPrDMQ0ATx0MvRnZiJzfRZ52TT7vZBDu3+YpMVn4Y+GWD7oLSr+4mvfDza42
 bLDnJXfS0loyBvT2ybHdT8SC/4PA9kTFp/qOwOTRVUvXEbsPGfM88LMGH7Y3r/u7hPHA
 Ej5iIDNOXtM7lltUjbvC+KGSkq69R0gGhkcLFXYL94efNm9ikmpIr305fpyszMP5xjW5
 VrpFWVPYRMGJHHKje+h4z6nkKrjVjOgNIqRz58v/8qvZRvfCEzUfY60ABc4mgEGEf1yt
 QuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751938548; x=1752543348;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YHbh9PqjaVzAH+AnNv1cTfbOt1hM9cdJ34jcQCsY4ys=;
 b=eaHgNhf4qOyrsE9Q24iXNaUQT+ACyRA92z5uJbinr3S84/3N8Zl4X0qT1ieJOUgcWU
 WbMP93DHGafIMyMcdEbZEhQlhl6ykNcCU4oTkjM3IQcHnnV1xpsMzz7PKJx275FyCIWU
 MHDft1vs1L8DsNU0kAFZZeHDAtNYWjHzIbdVCblFPB0zDCNVXDuITbofZKuMOujYvtIv
 cy+bjC/HxQcFkr2R5yptJrIXiQT+9i0w5VvYcrBMg4J3uF9gEHk8UpM4QuKpxOm+R9Z1
 Xt9DsQxxOzRhRm/KXdhgMFk5ScTg/Mjpp6BEjLrC7OpJcz+N1dmqjc6qcSGQ36ZwTh92
 yqgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULVNQ70rveFwp4AQZ0cvpKR0NLiHauajbFbTO/a78q1cApbk11u2JHoV59YLcxKlsHC62Owqz8vF49@nongnu.org
X-Gm-Message-State: AOJu0YwBOZBTlNRXQ3Ml6hK34OhGPwu43SgURnjN2Re8//gtEw8xZCoz
 ADR/Od7zfU/bbi2KHvxxU60qqnaUdOthpqUd+eR0uyHrOkDPbjeVA10/qKol0UTCWfLONbtXwNF
 ayt/kbPnS97USYhHPsk3ot5KMnuQ4DO0=
X-Gm-Gg: ASbGncvpwPbe9PtcZLZ28RvAly8GesL+DQAf7Hi2lpBgFfTfM2oQNaE/8CL+aEgrNKp
 T7xgGuQ1MGrNL1oP/aeyYdw+p9RYTXfWuomnm3iFJtckKGLm7wKI/tCzktkJA69PIx+Ytea+wjF
 DC6UlnpAHtvzzjSuXHiXgu+i8cqU+0I3Mw2qK/HyxhdWVDGdHY4dyNcsIi8joak1Scp6tey4/yI
 w==
X-Google-Smtp-Source: AGHT+IFBJNVGzfqQu5H1EtqRPOxLKGCh4nk2PyuJwAG6eMOlcXsvlveGVMvVgqSkHKD2PeKlGAxugr6QjnHvi7UCqLs=
X-Received: by 2002:a05:6122:a0e:b0:530:7ab8:49ab with SMTP id
 71dfb90a1353d-5347dee2b2dmr9070424e0c.0.1751938548342; Mon, 07 Jul 2025
 18:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250706065554.42953-1-vacantron@gmail.com>
In-Reply-To: <20250706065554.42953-1-vacantron@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 8 Jul 2025 11:35:22 +1000
X-Gm-Features: Ac12FXwAvX9wUWAVS0sQ4UvQqZYNg4w06KIgKDbdkvUoprFwcVkjs6JQo9u0gWQ
Message-ID: <CAKmqyKPKm=w1e8TuCWEk0tJedP6eM5GOJHZHOHMTjCwFSjORYQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix pmp range wraparound on zero
To: Vac Chen <vacantron@gmail.com>
Cc: qemu-devel@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

On Sun, Jul 6, 2025 at 11:04=E2=80=AFPM Vac Chen <vacantron@gmail.com> wrot=
e:
>
> pmp_is_in_range() prefers to match addresses within the interval
> [start, end]. To archieve this, pmpaddrX is decremented during the end
> address update.
>
> In TOR mode, a rule is ignored if its start address is greater than or
> equal to its end address.
>
> However, if pmpaddrX is set to 0, this decrement operation causes the
> calulated end address to wrap around to UINT_MAX. In this scenario, the
> address guard for this PMP entry would become ineffective.
>
> This patch addresses the issue by moving the guard check earlier,
> preventing the problematic wraparound when pmpaddrX is zero.
>
> Signed-off-by: Vac Chen <vacantron@gmail.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/pmp.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 3540327c9a..72f1372a49 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -211,11 +211,12 @@ void pmp_update_rule_addr(CPURISCVState *env, uint3=
2_t pmp_index)
>          break;
>
>      case PMP_AMATCH_TOR:
> -        sa =3D prev_addr << 2; /* shift up from [xx:0] to [xx+2:2] */
> -        ea =3D (this_addr << 2) - 1u;
> -        if (sa > ea) {
> +        if (prev_addr >=3D this_addr) {
>              sa =3D ea =3D 0u;
> +            break;
>          }
> +        sa =3D prev_addr << 2; /* shift up from [xx:0] to [xx+2:2] */
> +        ea =3D (this_addr << 2) - 1u;
>          break;
>
>      case PMP_AMATCH_NA4:
> --
> 2.50.0
>
>

