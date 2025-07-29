Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF217C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 03:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugaqm-00018A-Mw; Mon, 28 Jul 2025 23:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugaqN-00011d-S8; Mon, 28 Jul 2025 23:17:35 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugaqL-00053D-Jy; Mon, 28 Jul 2025 23:17:35 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-532f9127978so1575283e0c.3; 
 Mon, 28 Jul 2025 20:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753759052; x=1754363852; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FB3Fu8YTGL7d/7trDaNQWekiRfap6myklg8wriaSDSU=;
 b=jKhq14WVLMIaOutGlMzLEG/xJ4OO0V8949kIvZVyzGauxiZdva576CTAxhZAHTe8Qf
 D2b0ks/qiXhdXfICEeQCSHFBB/DKaxjdc3S7/KLb2RS534mzbfJHl1LbJuaZZZvFQQ6n
 JH6jTT4CYGjBAkn5Vl3FROJ/dFwy2raEeekKywAmK9JK/YdkPMFNPfTkUf918hs3CmuS
 PFd7uynFWabY//Lmk2PQXc0IwcsgUO/2Oc6OVE6ZgUjBOlSdTUB/BY0csgwzJD56fwUe
 fDjkeVDZz8p95xYHbMY0fniaOKiopzh2YeYXyPZ90N2qjRGHmNmM83s4uplpbSHIRfNk
 XjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753759052; x=1754363852;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FB3Fu8YTGL7d/7trDaNQWekiRfap6myklg8wriaSDSU=;
 b=u/f9eHvH4wB95caMEKH6ZVP+dJbm5yeNMqq33L+afmQz+g9gp2fRbFjKqwiSQsGyxq
 XNue/GY2CSL2yOoSZb14XEHrkVd0BX0JBRwUo8OlBKlOZc45FZQsKB8sSkhodXJ5sYJI
 mpRAK8m3OHXmdszhp0IOvc60nrWZtaOrbF0adgQ7E30A1lWZUXwhrga/jYTUjkXWNpAT
 WYZmvGhKEFfeQKkOnYppExCHIMf/emXWRu7qF4IxwCW7wH6Ri6AaBbSb59q8Cqdu4JgP
 6VlPJcUwZWLwFd5RTXqSbCSVIOVCiOtvu6WHpTJ3Hgxofx4VGe+lYjyfFdWjsCaBJTHu
 zDKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdmlbg4nkhCEtHduj8fDbu0WHvwWeQcXZVIaPkv0wjRY260RU9CmZnMuvGlT/9MfwLg4XnZo3cKnYg@nongnu.org
X-Gm-Message-State: AOJu0YwbYSm0iEYbFhPPF4JTdqZfnqWWZoppyKSQRPfHLqtbnvs3pETB
 36gFHekgRN0L+2BactRUNapvAJEBZve5etBF4yaF6R0OYi7/zXFgnDoguyAj8U8+mrbla7NEuka
 ZkoCtie3oCNI/TZVKUo7IlEA1RWu5paI=
X-Gm-Gg: ASbGncs2MqxNUdvybKdoFP+okfU24Rws1YMltnK4bu/vhtv8nk3RN1zR8WBH9kv+tp9
 LoC/KjeIOEezDJP0jKnHvgD+omzGKD5kpjqphtbgbgq6E0L4diaOVkrahzoQ3b1h32lVmwpcpVv
 UBKIAVy1a8RQb7RwmBEWD5dlaAGflSvMHHvaB56uqTepYSlcVOXFTJ8U54BU1slg3SlceEwaexv
 wIizLsRuknfwMvRDCbjY5O57x+7hdA49fEz7g==
X-Google-Smtp-Source: AGHT+IERMIuprD2r5adNt6wKouBUnyDyisrztAzBz/egZuPLxP9W3RHQcXeomfnHKtnrKhx1LweigfB6F1OHkv3Wp3c=
X-Received: by 2002:a05:6102:c12:b0:4df:8259:eab with SMTP id
 ada2fe7eead31-4fa3fd76246mr5454218137.19.1753759051632; Mon, 28 Jul 2025
 20:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250728170633.113384-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250728170633.113384-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 29 Jul 2025 13:17:04 +1000
X-Gm-Features: Ac12FXyMAKegd65vwHv87qoOQLi3ZZhK5M_Bw4h5wVX2aug-pzZ4XU2HqJCnGog
Message-ID: <CAKmqyKMxHiL8RjkZ_yF6s9A+7x6ZCBJ8xrYAbrKd1xA3m6gzrA@mail.gmail.com>
Subject: Re: [PATCH] linux-user/strace.list: add riscv_hwprobe entry
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
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

On Tue, Jul 29, 2025 at 3:07=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> We're missing a strace entry for riscv_hwprobe, and using -strace will
> report it as "Unknown syscall 258".
>
> After this patch we'll have:
>
> $ ./build/qemu-riscv64 -strace test_mutex_riscv
> 110182 riscv_hwprobe(0x7f207efdc700,1,0,0,0,0) =3D 0
> 110182 brk(NULL) =3D 0x0000000000082000
> (...)
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  linux-user/strace.list | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index fdf94ef32a..ab818352a9 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -1716,3 +1716,6 @@
>  { TARGET_NR_clock_gettime64, "clock_gettime64" , NULL, print_clock_getti=
me64,
>                             print_syscall_ret_clock_gettime64 },
>  #endif
> +#ifdef TARGET_NR_riscv_hwprobe
> +{ TARGET_NR_riscv_hwprobe, "riscv_hwprobe" , "%s(%p,%d,%d,%d,%d,%d)", NU=
LL, NULL },
> +#endif
> --
> 2.50.1
>
>

