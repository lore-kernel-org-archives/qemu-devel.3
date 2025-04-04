Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE66C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 01:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Vmj-0006rm-0T; Thu, 03 Apr 2025 21:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0Vmf-0006rH-Kx; Thu, 03 Apr 2025 21:23:49 -0400
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0Vmd-0003Jb-Ux; Thu, 03 Apr 2025 21:23:49 -0400
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-523f721bc63so2186845e0c.0; 
 Thu, 03 Apr 2025 18:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743729826; x=1744334626; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5K5pI9EGTaZiO0xDxyiaB79ANZnM1hl171ZvHp0IuCI=;
 b=TYpaNTFQFaZ84A3pxioqAxTzvmjf3ClEb83IN6KpvjBFAIP3/kwarfBT+w6zBWVufx
 //n+AZuO4+21aswVwoUJCaQ5ZORGcUoKi1QU/JFtycTxmD7FY296qK+zx8l254/GB/E4
 tC7JJ2Bl7aLP1W3Di8DbkNaJSLGUxD9S6NVyAE/g3ZBJGD2cmRIP8UXHX4/iWjjkXJUl
 bAv2qAGvCz+Cdlfg6gbxp+nOx0li6e+1Ty6e9Nu+7A3zl6BORdIaqLe9oaOXaUA9Pguc
 6n/Y1Gr4NGOXGA7FIDL+uYKYDRzg3ni/Pq/sOKMNlyc9vMz9oB3UPyZ5g7DRkoxpDvl5
 QfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743729826; x=1744334626;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5K5pI9EGTaZiO0xDxyiaB79ANZnM1hl171ZvHp0IuCI=;
 b=H2MCJS5xbSD5xeIwtadVwKKczqXYrhMFYuRIY1KsNPaFLIFjvkYFMium4edhVxDzhS
 dkRayJ8h/JqOJLjzwzveawMzkYE7xXz7wIrA8WX9PUJgbf5HbcmfNVXjS+qic4Y936Vq
 0Yss0Sj+oRNzrfQVenejnJcvpQB7UmBOxG0+ZmhlkZgVvWNZa/efuw4luaxpQwnc0mJm
 d3iEkXBlizIjdPBELzmwPVLC2UhcV+CxBQevdLJV2RpXpFuF29pMZZsQzScfScYT3FUi
 edB44Z4G7xCCKS2dkZ/1JmgoqPlC/PNk3E03/KnNiWmRHDo7FOAej9eCqd1eC0qdibyk
 grbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpAUPkgU47vXZIVB+ZOGNpd8kzcmQajGz9a2grXuN0Ga43j6yBvDLCRmi03dahzylfNSs7A40vsK2i@nongnu.org
X-Gm-Message-State: AOJu0YwHQ7ELdG1l5+ZpWf+b0oHz3L54zDwL7bacGBMJwwQ5WqCjw0gS
 AkAsl8lnR7ww91Td5fgz/AzYUgvCYfcw3fPKAX5V4hEikaEyFQlkPiVIJUsaNwR2cW8CIOyqOM0
 LesJCFT7qhOZ9ulCAE5plRv1CTalbQg==
X-Gm-Gg: ASbGncuwiOwx3DaCIy1amab2vd+NEOK66DJ2HsKfhzLLDMkYyt4eJjnwEMpt/XvX5H6
 THJRotqoy0aMg15VsKzULfDk7/hwqeDWE4YIFjktsAb3bDbBaVYLqVp6mNB7DDSBvlwb770kMPy
 MiRxqfbiZ+91jS5ciBWCpCSFsFcMrznlhNWbEjpmzxOSXdxLBOguOW9mRI
X-Google-Smtp-Source: AGHT+IEC65zw/mYfZSBl0D3u0zGARRxGyFAPdUw93yAUSaFN6Ko3ELFR/57rZv0mqYn4sd7dgiQIxWVefYxl7m5MztM=
X-Received: by 2002:a05:6102:514:b0:4c4:ebb1:4f6d with SMTP id
 ada2fe7eead31-4c845b9936amr4706523137.11.1743729826320; Thu, 03 Apr 2025
 18:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250313193011.720075-1-loic@rivosinc.com>
In-Reply-To: <20250313193011.720075-1-loic@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 11:23:20 +1000
X-Gm-Features: ATxdqUGs5AOADheXfjmg8av1xbIrwcNWQGD3UDqHGQvRE-Ieh8-ckYM55jghCyY
Message-ID: <CAKmqyKPER5Ab1N01iBDTgL490hW5eBkH4W==RGfJCzthamxUQw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] target/riscv: Smepmp fixes to match specification
To: =?UTF-8?B?TG/Dr2MgTGVmb3J0?= <loic@rivosinc.com>
Cc: qemu-devel@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
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

On Fri, Mar 14, 2025 at 5:33=E2=80=AFAM Lo=C3=AFc Lefort <loic@rivosinc.com=
> wrote:
>
> These patches fix Smepmp implementation to make it compliant with the spe=
c.
>
> First patch limits RLB to CSR changes since RLB should not affect privile=
ge
> evaluation. Patch 2 extracts some common code into a function (to be used=
 in
> patch 3). Patch 3 fixes validation of pmpcfg CSR writes in order to match=
 Smepmp
> specification. Patch 4 is a small optimization and last patch is just rem=
oving
> redundant code.
>
> ---
> Changes in v2:
> - rebased to latest riscv-to-apply.next
> - addressed Daniel comments on patch 1
>
> Link to v1:
> https://lore.kernel.org/qemu-riscv/20250225160052.39564-1-loic@rivosinc.c=
om/
>
> Lo=C3=AFc Lefort (5):
>   target/riscv: pmp: don't allow RLB to bypass rule privileges
>   target/riscv: pmp: move Smepmp operation conversion into a function
>   target/riscv: pmp: fix checks on writes to pmpcfg in Smepmp MML mode
>   target/riscv: pmp: exit csr writes early if value was not changed
>   target/riscv: pmp: remove redundant check in pmp_is_locked

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/pmp.c | 151 +++++++++++++++++++++++++--------------------
>  1 file changed, 83 insertions(+), 68 deletions(-)
>
> --
> 2.47.2
>
>

