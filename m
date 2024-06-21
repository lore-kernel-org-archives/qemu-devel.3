Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4D5C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 04:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKW8q-0008Hn-FB; Fri, 21 Jun 2024 00:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sKW8o-0008Gn-BR; Fri, 21 Jun 2024 00:44:50 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sKW8m-0004Sg-RA; Fri, 21 Jun 2024 00:44:50 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4ecf43f5537so816296e0c.0; 
 Thu, 20 Jun 2024 21:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718945087; x=1719549887; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9BrKFQN9H1kCp7zbO26rrNOaXRngZ7xgb3rHkXZxnXQ=;
 b=LLwI9iVDEBlxBYOnuQL2mLapjWxujhuL2ZNxpAzfD+xnVa9Yiv69Z5nSzOLF7PI+/J
 xMoTifzPkgIOLITjtfj7rPmHRKsE9rmq81wNjiHCKMUNu7bgBi0NPkshWOoPXLrWtNHe
 vKUNVcZRl85y27lmTfA8wrgrVFHAmFPw/GThVoMv03flvpLZBgA+Ply4Dvr6I6frP0g7
 uh5PQZnPA4nXC+EYQbzn2M3SFYAg/wSia2QET6eh8tWwcJSjFFCws1Sn+7YFKeHaSx3f
 5R12Y12SS5mYG14kY7xxXfQEbaVzDA9LKOYG5Ape/JVAF4+1STRdav8QWix2LvFWBAu5
 R3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718945087; x=1719549887;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9BrKFQN9H1kCp7zbO26rrNOaXRngZ7xgb3rHkXZxnXQ=;
 b=N0tKbC9SJoiY1o8ERdoGl6u7jm2J74S02eQT2muXZApu3u+s9AKLtjVyYd4H+kdQDH
 kmMuP29nlkZD/s1/TT3QLFbPRt//eXFk4jQfeDsid4oXOQSg9j2d2AhPXmSGP08uFeCE
 wZDiFON2PUlTV7FnUPXBH2LRt0QLKhyLPT1kbg1NjJik/k5fgFZRz9hxk/Sm0X74qOdH
 IaGimDh9NMEtAWQiZ5wUMYh045DWXXrAR1IQS/l2Q6O9W2vGoQtukBZgTGDxfIBvX9kS
 f6/DudutL4zVVCESIoK/lHSOdQHcGhFMPkyOFFSRwNNc9FP8M+M/XUTBDaFo83xBaCW1
 BVYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4CPvgH8akl434VphHxfEAboUcsyhfdtL8Nc9OY5cpKZIUFGlYgh2R94gA8qFHS+XjCK6zQ87qE5jS3ZydSADnpTGeqM4=
X-Gm-Message-State: AOJu0YyLRmziK6gJ1tyReUg/whH+ivnywTS4iQse8lFC4tvJ4xZV7+Pu
 cD9bgdVP9jPqGPHJRCb+yo7owHqalJxRjPV8ew+Sd7NWgTkeSHWlO95qeo685lFWvlMtaWCjZcy
 KG18PONyeAO4x5KugoRDq5jTJuWE=
X-Google-Smtp-Source: AGHT+IENyw1nBP2+nB3WAlKUuOOF90xSHrt1drFX9tmbUFkpsXuFzRUwAW770g7qfsHpWYQiAkjH9eDETChhiGndNfo=
X-Received: by 2002:a05:6122:926:b0:4eb:ddd:4b95 with SMTP id
 71dfb90a1353d-4ef1a8b00c7mr9266124e0c.0.1718945086721; Thu, 20 Jun 2024
 21:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240608214546.226963-1-brzakbranislav@gmail.com>
In-Reply-To: <20240608214546.226963-1-brzakbranislav@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 21 Jun 2024 14:44:20 +1000
Message-ID: <CAKmqyKNtz5=FyQekarUO7b307NMzjy8mNJ7siGtD_ik4ME142Q@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix froundnx.h nanbox check
To: Branislav Brzak <brzakbranislav@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com
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

On Sun, Jun 9, 2024 at 3:32=E2=80=AFPM Branislav Brzak <brzakbranislav@gmai=
l.com> wrote:
>
> helper_froundnx_h function mistakenly uses single percision nanbox
> check instead of the half percision one. This patch fixes the issue.
>
> Signed-off-by: Branislav Brzak <brzakbranislav@gmail.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/fpu_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
> index 871a70a316..91b1a56d10 100644
> --- a/target/riscv/fpu_helper.c
> +++ b/target/riscv/fpu_helper.c
> @@ -676,7 +676,7 @@ uint64_t helper_fround_h(CPURISCVState *env, uint64_t=
 rs1)
>
>  uint64_t helper_froundnx_h(CPURISCVState *env, uint64_t rs1)
>  {
> -    float16 frs1 =3D check_nanbox_s(env, rs1);
> +    float16 frs1 =3D check_nanbox_h(env, rs1);
>      frs1 =3D float16_round_to_int(frs1, &env->fp_status);
>      return nanbox_h(env, frs1);
>  }
> --
> 2.34.1
>
>

