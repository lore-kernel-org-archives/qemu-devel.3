Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF98C25B79
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 05:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBSkW-00088E-AD; Mon, 27 May 2024 01:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBSkU-00087n-3Y; Mon, 27 May 2024 01:18:18 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBSkS-0000w5-0x; Mon, 27 May 2024 01:18:17 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-4e4f02f4c6fso1072466e0c.2; 
 Sun, 26 May 2024 22:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716787094; x=1717391894; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/kfgOLJdQMYCrZFrhImUjjx7xrkJipejRmC27iJn+28=;
 b=GLYSEAT0ySRTPgqkyKmMj6jeVIB4ZOkTuNvWg3hDMO1mMkZZykpZMzWoJ0ztuvHYis
 2owFXtcZKOzEiHJ3jCoDq3PwsrHe3rwMoqPb//heCx4Ek1Jj8kwUkyj6H0Y/SibVs5an
 PVyyWjBI3RhZDzlw+ySzAGqBtdf7GMqYl5do2pabsWIr5/oT8eNyDaUlSBzruOFZ5o+i
 6NCgRFwwqF/XaKUInRvsa8oVfmN7C30AW8GA1LryN+in/6o6TbTN9ZoEdARzpV2B+qe9
 iJkOLCiOTzp7jjMij356Mj8bMZSnDMWIzuBLSx67WojVJGI789s4JfXIRJb+VKsJAoEm
 1sRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716787094; x=1717391894;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/kfgOLJdQMYCrZFrhImUjjx7xrkJipejRmC27iJn+28=;
 b=n3ICrVxHfwOYufyAoK3o5Vqw8tpKmzjTx2b7QbQFwyVzi2SIbNRJ6Z9qNPsFGtkdiQ
 GJ0laNhdmTBDOQhrOjaQXb8ohwlGPloP86Q9rBWhxnPZLVsgUXyORrOuTdFOEgtMZj21
 gioP/Y4r1wGgHlws8Ltmz5AYKCs9uH+BFY6GJ7DeS66md1a2f51cZzS5tBAqFABzrH2n
 XiTYQ+ti8aqPQIvUwdcTj6DcDAWToDTymBnLV+3gVGAyHau4puvthyKJCTwc+vsEMFA4
 ZS6vGDQRGtRzYjoipyJSarWBVbd8Wh6SVEyF2sgI56p+lD3a+Gd7iI59bRtYzSsEvQx6
 qZWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ80KIqz1qneASxBPualq2Ja+AzTkAxQ1ZDIKfU7IGzDKDYi6ZjRRpVTW9C283gOJ28CAX4Ehwm7STo1xTno8miaMHHpM=
X-Gm-Message-State: AOJu0Yz0tXQbNqxF9Ppz6HTnKLuE6+2ZkHAngA7dB8x1dDzhz3RakCX/
 tiRNsplLfvC4TiezzODNnn1z8Pl7P3TzfXrr0FesV6xMCUJAZzx7Q6gdG/yfeLrV02EjLbHfZ8Q
 guOMH9oxD0zTxaR8AAEIdSYwshY8=
X-Google-Smtp-Source: AGHT+IHROZVVPsGZJEZt1ah2PWpI6pqvhpHKa1squgKR7VMNFADyQubNkBDkis8gpsYrxIS+vgTUPJYxr50OOATGAcw=
X-Received: by 2002:a05:6122:90e:b0:4d8:79c1:2a21 with SMTP id
 71dfb90a1353d-4e4f0277c22mr8889202e0c.7.1716787093063; Sun, 26 May 2024
 22:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240517203054.880861-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240517203054.880861-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 27 May 2024 15:17:46 +1000
Message-ID: <CAKmqyKPxPcUFTbERAgaB6TbyfLoM21Gfq56ks2qj7JeuQM_aRQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] riscv,
 gdbstub.c: fix reg_width in ricsv_gen_dynamic_vector_feature()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, alex.bennee@linaro.org, akihiko.odaki@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
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

On Sat, May 18, 2024 at 6:32=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> In this v2 'reg_width' was renamed to 'bitsize' to provide a bit more
> clarity about what's the value type of the variable. It is the same name
> used by riscv_gen_dynamic_csr_feature() for a variable that has the same
> purpose. The variable rename was suggested by Alex in v1.
>
> Changes from v1:
> - rename 'reg_width' to 'bitsize'
> - v1 link: https://lore.kernel.org/qemu-riscv/20240516171010.639591-1-dba=
rboza@ventanamicro.com/
>
> Daniel Henrique Barboza (1):
>   riscv, gdbstub.c: fix reg_width in ricsv_gen_dynamic_vector_feature()

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/gdbstub.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --
> 2.44.0
>
>

