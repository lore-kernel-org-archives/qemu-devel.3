Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C70C54746
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 00:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj6HP-0007wT-EU; Tue, 27 Aug 2024 20:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sj6HK-0007t2-BZ; Tue, 27 Aug 2024 20:11:14 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sj6HI-0006cd-U4; Tue, 27 Aug 2024 20:11:14 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4fed4a1a003so507952e0c.2; 
 Tue, 27 Aug 2024 17:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724803871; x=1725408671; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UGbWcwjCdjuUZOgrTdk6joAxU6BZNoFHrJPyvrMmCbU=;
 b=Vbk8QnEXflCw5JMkiZgjLH/lAnZCrtMjAjNtz9LEdpxsfRiBGG5Ln0Q+/zX2jJPW9q
 IKfHJ0buvzYX52ODPVMrlrQC1oj261MP6alHu69JZjLiyKVPg55o+BMKbb9PE8WTbCIt
 TQ83mtb8A160UzWEYsViO9qhr1vPLsmynN0YGctEnFqeC+g7cfABqJhZVvU9DEF693b6
 PABHlARp66ORyvGxLa5uH/1Cpfk9+rIKSWY+YBL0sTZ2a8eRLwpZza/9QuQkHOfNuNUM
 Q+smpQ/LIyUdSuEIJwlYVYZOCXRra8xPP2w0DYshcBT7SJJ5dof0A/9D2ccCbivh1Hu8
 KQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724803871; x=1725408671;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UGbWcwjCdjuUZOgrTdk6joAxU6BZNoFHrJPyvrMmCbU=;
 b=Y3wsOiFbFl5+gJTmG/E9tfkkEivENcBlo+rkieRNueW+ym57vdcCdHu30Va8Pdplby
 9qxb/20zLpa6tunF8tvN16EqpmWDsSK4fdqv5RDJLAqE/0+DqugFOXOctq9fR/rkXBph
 yWZAIMMI6vWDVLMEv3NfhIe9nb/RKdczkhup/zDUVgE/f/iroY0e8aMHMMXPxe9K0dqt
 ugSCYzE01s2xKmZGkRRaBup7T7lXiPXZuyyznNlOz/7YQt/YivGhiHJBWLpDietAahsB
 1+J/LGCaG2PRO6GH81ZgXz/9VMMc02UaY/tOpsHm6SanZc+xcT16HLaGFDQIocb5igOz
 w1Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULzwiq1vEy0iZvqPKUkYbzyJH8BHu2GOX8tR1DoU1futbDEf01PoVexxfmDJ+6yQst00o2YSyauamo@nongnu.org
X-Gm-Message-State: AOJu0YwpDa7GGUkMr0JdEgIwtUzcU5Xr3GavLNc8gIwP5FlDSw9YNQSL
 XjxkpurA5yP8sk6iJdRzJz5f5vC0DmcRGBJTU3Q340Sw+WIiO+XAaZlV8k3h0DmkB89yzcSakk1
 H7y49kjcE/QTOKPA5C2XgdqrB7ic=
X-Google-Smtp-Source: AGHT+IE7f/NXJHA/3KBKdfJQVYsnGq7w8rvajvkoLo6RG0t+ZFsm4DYTk00uMQSH2XDfV6kCKMUbVt1nTP9RerkZv7I=
X-Received: by 2002:a05:6122:3197:b0:4fc:e2bf:f5e2 with SMTP id
 71dfb90a1353d-4fd1a739ec9mr18410740e0c.7.1724803871130; Tue, 27 Aug 2024
 17:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240827231906.553327-1-debug@rivosinc.com>
 <20240827231906.553327-3-debug@rivosinc.com>
In-Reply-To: <20240827231906.553327-3-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 28 Aug 2024 10:10:44 +1000
Message-ID: <CAKmqyKO2gaVNsSCuvSjTSOjKBOEBJOQC91BK0VDRscJbM-hx7A@mail.gmail.com>
Subject: Re: [PATCH v10 02/21] linux-user/riscv: set priv for qemu-user and
 defaults for *envcfg
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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

On Wed, Aug 28, 2024 at 9:20=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> set priv to be PRV_U for qemu-user on riscv. And set default value for
> *envcfg CSR.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>

You can probably just squash this with the previous patch

> ---
>  linux-user/riscv/cpu_loop.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
> index 52c49c2e42..7a68e8717b 100644
> --- a/linux-user/riscv/cpu_loop.c
> +++ b/linux-user/riscv/cpu_loop.c
> @@ -32,6 +32,10 @@ void cpu_loop(CPURISCVState *env)
>      int trapnr;
>      target_ulong ret;
>
> +    env->priv =3D PRV_U;
> +    env->senvcfg =3D 0;
> +    env->menvcfg =3D 0;

I don't think this is the right place.

This should be handled by a CPU reset, which is still called for linux
user mode.

Alistair

> +
>      for (;;) {
>          cpu_exec_start(cs);
>          trapnr =3D cpu_exec(cs);
> --
> 2.44.0
>
>

