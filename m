Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5782CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 00:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v31ig-00033H-Fm; Sun, 28 Sep 2025 20:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v31if-0002yw-02
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 20:26:21 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v31iQ-0004vm-0v
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 20:26:19 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b2e0513433bso665004066b.1
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 17:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759105557; x=1759710357; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k9T45Zs+t+Nwx2Z7WHq5wF6liS6kFse0/anz7elBNas=;
 b=ago30C+WlXMyWEuxv3HGOCz6OnnlBh612DKfLSV9cQ0LyQkKjekzPep7oDbLzY2nJJ
 0+evZp4EC6Lk0A4rOCGxOOKeqxr9GRRfqrrzn8mstCf4SAAZb02XspmqFJ+gz/CvC6Ee
 Hu1RGmVZ6cu5+jqHjoh9hScjrYqbvt8wXk8n8sk7i1prGybjAiM2qV3qZAtDORqCPz6e
 CYWZq0Ik9cKrXMVIBHNklYf6Ld7ZyfP01f1i8mCw8ObgUdIi76G81idRjADWL/EG4rF7
 9IfJmsewXgCtnD63CYB8uVnEdgkDg6h/J1m8QZBg68gJOtEES1RpX6ZGthofiLD1KxNE
 pKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759105557; x=1759710357;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k9T45Zs+t+Nwx2Z7WHq5wF6liS6kFse0/anz7elBNas=;
 b=Ne2drSVqG6ozseKSVd7S9Aurh1/v4jQMmz83QdwX0OIPsi4Vtf6TdjancMWPZxd1IX
 4tVhxtebDF10e1AMEnbXPW1beeYZ+9yHiSQT+ci7hMHwd5nXTtKhy9mA1ipQVhkFuMVq
 9t51NH9ffmBcTWE4zS4Nwm9fI+KRnmqvQkDD8JclqWjknvZuvGdNYIdKeOmX9uDSwSO4
 3KwFyQXjy/ojfoTaZRKOqI5XbdscOhbvI1r98IilZW1jZCnTAJzwgH0bmeTqMhv9nFhZ
 YNEuK8F8JOcti0tTKNYtEiiUIqAqznVv1g89JSfiX/7ZH4KWZAx2ZmZnj03+37b7yQlm
 necQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLhvw/cu0YdWt7BjzLkV9pzicWQC/Z05UnF7XP5NePN6Ce9bTMs7IN2Aa7PGOyaMCgaqBlJjoocZi0@nongnu.org
X-Gm-Message-State: AOJu0YxFj2ZTzHUb/rV/jsKzDDLhrQmQf/DSlr0/3uiFbQCaBk7A3cgA
 5+7DetEuWIVoporsi95fuY2mKheGPSBefZ5Yos217WqSRxEpk2zvfg0VXp9TlWxFdlZcwEQDA2I
 S21S073klnAlqCpJB9nBpfKWLiiBwErc=
X-Gm-Gg: ASbGncvAOGp4hCiUbU78px8qBB6SDRzEzfbvARi/zex371rg7KuhPOAz4+nUZ7qeeyE
 m72gk3P4CnioTn4IUKMgqLz+59F2jPdj9F7dhu3FNi9NRBqHD9lOmakoyivJ1AY0ZWB4l+Jkw7/
 auVVJupdRE7MSA+ye1IbD7A1WAkz2M+V/50NBcZJKzuWNi/uDgnshYvuEt03IQnoPwBsNGjszKx
 EcCejAHWXAnXHgbl5XU/yNIDiQFeQ5LkNYJ7idrpdS2MIv6
X-Google-Smtp-Source: AGHT+IHpqdfdx2RcjjRmHiV66x8RR0MA/IUJmbD0ZbWXW0s3ZY49YmO2M8v/wDEkQiPcFZHZqbhKttmrq73dxxPzIik=
X-Received: by 2002:a17:907:60d3:b0:b1d:285d:185d with SMTP id
 a640c23a62f3a-b34b1e7c3dcmr1464696166b.0.1759105556978; Sun, 28 Sep 2025
 17:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250924131803656Yqt9ZJKfevWkInaGppFdE@zte.com.cn>
In-Reply-To: <20250924131803656Yqt9ZJKfevWkInaGppFdE@zte.com.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Sep 2025 10:25:30 +1000
X-Gm-Features: AS18NWBW8v8iqMzCtbZ3YBHeVUfVUWeyoRRicjOSaUNb7FarPwhzGtaf-QwJwsA
Message-ID: <CAKmqyKNRP7W0s8SOX=8-u2harfB3O+znG59R=EkNE00_Zs4UCw@mail.gmail.com>
Subject: Re: [PATCH] qemu/osdep: align memory allocations to 2M on RISC-V
To: liu.xuemei1@zte.com.cn
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, david@redhat.com, 
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x629.google.com
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

On Wed, Sep 24, 2025 at 3:20=E2=80=AFPM <liu.xuemei1@zte.com.cn> wrote:
>
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
>
> Similar to other architectures (e.g., x86_64, aarch64), utilizing THP on =
RISC-V
> KVM requires 2MiB-aligned memory blocks.
>
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  include/qemu/osdep.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 1b38cb7e45..6de6c0c4e5 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -561,7 +561,7 @@ int madvise(char *, size_t, int);
>
>  #if defined(__linux__) && \
>      (defined(__x86_64__) || defined(__arm__) || defined(__aarch64__) \
> -     || defined(__powerpc64__))
> +     || defined(__powerpc64__) || defined(__riscv))
>     /* Use 2 MiB alignment so transparent hugepages can be used by KVM.
>        Valgrind does not support alignments larger than 1 MiB,
>        therefore we need special code which handles running on Valgrind. =
*/
> --
> 2.27.0
>

