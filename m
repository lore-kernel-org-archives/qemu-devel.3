Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AA7C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 04:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKVlv-0003rF-5s; Fri, 21 Jun 2024 00:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sKVls-0003qO-Tu; Fri, 21 Jun 2024 00:21:08 -0400
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sKVlr-0007ih-JT; Fri, 21 Jun 2024 00:21:08 -0400
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-48d9cbfe0ffso504871137.2; 
 Thu, 20 Jun 2024 21:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718943666; x=1719548466; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NI21qgnQctpoXFnxn+1MrI0WZwoSxFdwaRBCexBGSoQ=;
 b=buLbIoIURAAzRzwNnGZdz/8imhqjQ5gbYKfeSPqq2AF0br8MEDd0Xe4r2AB85M0UKf
 rBh4JOiy5FNRaZlZdKl65AbcpbJMG+EM+FBhTRf8XduAUcuEZEarj2iVmqSw9JeryvbW
 bxHujuzOgzj5tZ1HOXtdk6H3r81wv7K10gA1xS6M51tFH1om0/XGK5D1LhvVqzKHGHeg
 Xvtr90VnDEkQEL1b6c5y6l9LyLEv2zz3nBLyKKgKhlLC+b7mpil7V9X9aLcZsR9Oq4Rl
 XjKIj4JmkQvq7+csTVV9fu1LPwZOU6S2ShFS+cF4s3tQxhZMayVrWKXco+eZZvfvVK62
 cPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718943666; x=1719548466;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NI21qgnQctpoXFnxn+1MrI0WZwoSxFdwaRBCexBGSoQ=;
 b=WIZ0t1sDQtEtmQil0+LTm0k8r7OcTGUE6xsn7H2F3wVeKhvhQFzVJ1eRbmEGdrGK2N
 Qu7ST64Rd3yLlLhVbGTvgfCC8cZQd3G6HuScRst+t1y/mWcVolkit3Uwi4eGbxmdB8/c
 XKekioHglhZjX0xHOWL+5ua5ATiBKRr6gIIVeSonRLrIweOoBMQSS4MKRh7Byz2UxYzs
 G+LzhrTWdxwldPuGKsUb1C7im85iHxnt8u8GnI1c9fdgvzEynt0+IqxdkmNo7rFpSnpH
 IUN5StrAlEZbqDbFv/iKpLHYneljDvMu4cKRaHN6SzERrZ30Kq5JVARxmCSkc2TmP10O
 JkGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRxb14nNEiX6qzaUqGO2qt14ljk58FCgv3BPuSoYLkESmzHaCtcl+HGJSF9T/fZ9PIsa4rN8yCeldomcVRGw7kbtcMVM0=
X-Gm-Message-State: AOJu0YzsgWiICJixOcYmg+4jgBzn2FTH+qPUZXNNfGCAyc30YTZ45a5s
 n1EKiLVO9Z30CPA6FzIzeofS20wZxiSfDLJmUDj0Eqh/b9ZRQPqeXBYDOMSJmWerhCf62dPLnk8
 4/XmNAqZ9F3/Y9YX7wXJGJssves8=
X-Google-Smtp-Source: AGHT+IFH3jXw/Pa+QzkR+g5TWORDnQ5S1bVBKoXpYYVA5QBczC8j2xT1Ff8Y6PxZg+owCm+ELhB1wMh1VQR45qjxAKo=
X-Received: by 2002:a67:efd9:0:b0:48f:1674:f5a5 with SMTP id
 ada2fe7eead31-48f1674f6ffmr6574454137.18.1718943666106; Thu, 20 Jun 2024
 21:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240608214546.226963-1-brzakbranislav@gmail.com>
In-Reply-To: <20240608214546.226963-1-brzakbranislav@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 21 Jun 2024 14:20:39 +1000
Message-ID: <CAKmqyKNMO4iEsODXyAAhP7zPMUih+oM=+yEquSBxx3aDEj-kbg@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix froundnx.h nanbox check
To: Branislav Brzak <brzakbranislav@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe29.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

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

