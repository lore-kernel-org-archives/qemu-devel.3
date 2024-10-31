Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E7FE68948
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 02:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Kpx-0006t5-Mr; Wed, 30 Oct 2024 22:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6Kpu-0006sY-TO; Wed, 30 Oct 2024 22:22:58 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6Kpt-0003KI-5d; Wed, 30 Oct 2024 22:22:58 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-50fc0345155so258738e0c.1; 
 Wed, 30 Oct 2024 19:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730341375; x=1730946175; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EDCzwfgDwHpNibIaBWrjom4G4d6q/o29xtSZ96U7Cyo=;
 b=Hb0hOPRUe6xEx6fQF1BP29sL+iW5j2BtyrhBnBCB3MclWXu0W1JXKfD03oQBJbVMM6
 2dfGkTV7501MKZTgw9A3lylyLgG40JZ+kI5eR9vccsKrfQE7pyvNzGMRUtsJo4JH8j+o
 aL/l9wPZKrqhflotV8hCRj/pocUbzxzfiTBe5QmLFZ1gfpG2Y997j2kIrq1QU6Qvm9E7
 UnVfEgfbdHEWYBtTf8Y1+f9LzQTjyPT7RxRN+o/rqGKIm8DQXIySngfp4dz/Kp9/TqEr
 xt3QaP7P7HdHD5RjN1uChXP/DHN+V55mLf5cdf+RyzagPzgrCdHpr1QrYBDbhVG4JF8g
 uRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730341375; x=1730946175;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EDCzwfgDwHpNibIaBWrjom4G4d6q/o29xtSZ96U7Cyo=;
 b=AVY8g6A10ZkgNv8ZJHjmcsrunceZr9/hOZ+YjO3s0zCQmc1bcfXaY7IaPpjx4U3pJq
 PAr1rw+gTsO7RkwHTfwLwJoYLJEZx1fXXD7ekuQcpAD0yr6hZxlECB4cAS9h4Jc8tMjY
 Xz6cehbtzB+egbRu1Lp1I95UJ9SkDFTWxNb1fM3Dhmgk7eT/iXgAlTj856uoEaDidVNR
 LuEl5ie1yaaAht4Zk18NTqg8vUdJbd1FzkbZedStxt//Afle/4guC8Uu8R7s7gKceYuM
 YsxRpWw0kezbNyY+ofxXOC6cMgmTagfF7qiBB7c+p1OLpSdZfo8LXW3tXdy/2P9N5glH
 xVjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF6H8RajAzxCki/N8FeEE76UpRPpPRrSG0/yZnU7B5acBkPDhzJgS9iV4emihyWrXLi9xMkmpUsZ25@nongnu.org
X-Gm-Message-State: AOJu0YxihFNGmdBDCpEudPgiZcpmP4p1MwlzTDcKzNTD144fS6aFtJog
 Lyls0LWwCvWwmmQBqh27EBX9SY0LUL2++CP4/hITRIm8rlUNlU9N5KJRZCf11/eRvCFkvw0aQjL
 suGUAAUjxqRoK4G0cUSpntSj0VoU=
X-Google-Smtp-Source: AGHT+IE7oFQ0O9Y6Yzq1oWKQGfM2cTUJOwJmBTsvEYGi6j4df34UDobm8YaIvlLFtbrEExBL6/evjEwZ5ftU75iZU0Q=
X-Received: by 2002:a05:6122:1061:b0:50d:530b:6c0d with SMTP id
 71dfb90a1353d-5106f9b9f75mr353886e0c.1.1730341375481; Wed, 30 Oct 2024
 19:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20241030043538.939712-1-antonb@tenstorrent.com>
In-Reply-To: <20241030043538.939712-1-antonb@tenstorrent.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 31 Oct 2024 12:22:00 +1000
Message-ID: <CAKmqyKOo=-7ZcU82RFcVo3Ers84pOi275-_jmVcsLoiYXbWLNg@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Fix vcompress with rvv_ta_all_1s
To: Anton Blanchard <antonb@tenstorrent.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Wed, Oct 30, 2024 at 2:37=E2=80=AFPM Anton Blanchard <antonb@tenstorrent=
.com> wrote:
>
> vcompress packs vl or less fields into vd, so the tail starts after the
> last packed field. This could be more clearly expressed in the ISA,
> but for now this thread helps to explain it:
>
> https://github.com/riscv/riscv-v-spec/issues/796
>
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/vector_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 072bd444b1..ccb32e6122 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -5132,7 +5132,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, vo=
id *vs2,               \
>      }                                                                   =
  \
>      env->vstart =3D 0;                                                  =
    \
>      /* set tail elements to 1s */                                       =
  \
> -    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);            =
  \
> +    vext_set_elems_1s(vd, vta, num * esz, total_elems * esz);           =
  \
>  }
>
>  /* Compress into vd elements of vs2 where vs1 is enabled */
> --
> 2.34.1
>
>

