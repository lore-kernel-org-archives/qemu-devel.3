Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33948C021B6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 03:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmPLq-00083f-89; Sun, 23 Feb 2025 22:41:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmPLi-00080M-HV
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 22:41:47 -0500
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmPLd-0005oi-Ms
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 22:41:40 -0500
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-868ddc4c6b6so1172152241.2
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 19:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740368496; x=1740973296; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EbpRjMHRkG474jh8Sl3aCO0RUgrZHSnQwx3Ii9Ludts=;
 b=hmP3ue9CYpmfsjWJfizvvXrDaipsRXtZD8hW4iZntFL5/0xq8YaY0SKLHXUfZYoCmT
 fHr6DperQDO5VC66DzFIOZUgxtMs6ytlzxfNawFA9VPKrlu2HQCTbdZU8LgQc5nwwyXE
 zzvEwGxILhCbNqoGLu0Qn4gPvRv8z5kSxD6ef0iC+7MkaCxy+wx1ZxIn7zqjGZ3qZ5N7
 VveK7BqpOAFJcgg1RD2FS6rwG+K5dEsVxfbmXmWkIKUp8nWK8Hj6tppatOgVo9pRlqG6
 sWja5/uRbiv13u/bB1i0VrVZsQZMF7jGVO1iItVKpIugJUlqif8wv8/Mvj7zR/oIQAGs
 0sqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740368496; x=1740973296;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EbpRjMHRkG474jh8Sl3aCO0RUgrZHSnQwx3Ii9Ludts=;
 b=gao3dtOF4GKmAtgiAbuO2crZ32bQgCFCFTmR++n6y//ABk8yb9KAmA4HJppLnX5UDf
 2VAqgGF2ShtzwTZ8ecHGjP1KBB/bwWJYMEOhcyFvVn50+RQ9MuFzgH14xXotVM60G+Df
 24Gjx366trbj54+SO4AFMTPvAnw19XSDpPuzqiDGYsX9ebGgH8/hneQrIdqI5OM66W4M
 5B2t+Z8DAFw7OpzFmNWTUQWoVraHxsnJpcIfYOuPseKFylmH3VTE0j0+fL5kp+dGiqHf
 3x20rC+WCLfbXUMDqmD9aFi5VRqQeTNnXa5y4Bk8Kpsj0K1ME1gC1V4G9YBaBCvJgpjU
 UBjA==
X-Gm-Message-State: AOJu0YzBKfhCG0CJVutEX8a1r+h3iFkhW5ZJQ8MU0yfBASNh6GxI48dk
 CJGrKQBalq8fdV4elGUIse4Pot9cMRlAKLG8HJrpPYsstlaLu2HT6rvKKmkzqybIAr7v6WRwtv7
 ugKjYg7aEv8wkW09sukjZ7J8sqbt4pXUd
X-Gm-Gg: ASbGncu+1hNLyCOKIjZc0C7PZFEoVIcE+RoFyDQx26dPuX/j5RDZ4U49qaPLD+0oweQ
 nDCbC0rXOJzbzbtYNPGr5Juzjwh4yCn+Jxu8V9Mcv8gob2C0q/PfRcGjF3XWNeP7r+UxR/c4JUC
 DaZM7ea4wJPcXWzYAEiWw4jPOenKctm5ET9PdQ
X-Google-Smtp-Source: AGHT+IHRa/IQXEQrzohBxUOjoZORRHuBKYay2+iBOZ+KImgX0MmYuiIgRX25MZVrVtavwMe8dyDwFx9VUTronydzZkM=
X-Received: by 2002:a05:6102:6d1:b0:4bb:edc9:f949 with SMTP id
 ada2fe7eead31-4bfc0025907mr5635359137.10.1740368496497; Sun, 23 Feb 2025
 19:41:36 -0800 (PST)
MIME-Version: 1.0
References: <20250202-riscv-sa-restorer-v1-1-6f4bf814a1dd@t-8ch.de>
In-Reply-To: <20250202-riscv-sa-restorer-v1-1-6f4bf814a1dd@t-8ch.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 13:41:10 +1000
X-Gm-Features: AWEUYZlyGVH-PjGS08IHEthSLF04ZanssOtZaBaan4IhwE_D6nj-rw6cBlojNWQ
Message-ID: <CAKmqyKMA8CGv60c=24ThN_aE3hWM2d9aQpfB1XXA9Oqcr_7zug@mail.gmail.com>
Subject: Re: [PATCH] linux-user/riscv: Disable unsupported SA_RESTORER
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Mon, Feb 3, 2025 at 8:58=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t-8ch.=
de> wrote:
>
> Linux on riscv does not support SA_RESTORER.
> Currently QEMU thinks there is a field 'sa_restorer' in the middle of
> 'struct sigaction' which does not actually exist.
> This leads to corrupted data and out-of-bounds accesses.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas@t-8ch.de>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  linux-user/riscv/target_signal.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/linux-user/riscv/target_signal.h b/linux-user/riscv/target_s=
ignal.h
> index 6c0470f0bc82c6330ce50cb662f2039cf1fab288..258945770b674c0b6b66a9465=
9d9c93fbabffdfb 100644
> --- a/linux-user/riscv/target_signal.h
> +++ b/linux-user/riscv/target_signal.h
> @@ -4,5 +4,6 @@
>  #include "../generic/signal.h"
>
>  #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 1
> +#undef TARGET_SA_RESTORER
>
>  #endif /* RISCV_TARGET_SIGNAL_H */
>
> ---
> base-commit: 6fccaa2fba391815308a746d68f7fa197bc93586
> change-id: 20250202-riscv-sa-restorer-edd3dfa7790f
>
> Best regards,
> --
> Thomas Wei=C3=9Fschuh <thomas@t-8ch.de>
>
>

