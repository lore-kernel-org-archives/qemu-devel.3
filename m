Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A648AC021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 04:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmPnw-0007WY-Bf; Sun, 23 Feb 2025 23:10:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmPnu-0007Vt-AX
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 23:10:50 -0500
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmPns-0000QL-Ky
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 23:10:50 -0500
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-4be7f114996so2956013137.2
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 20:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740370246; x=1740975046; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=auvf4KVMx3qO117Ha6bPtSOZHjTaTYtORQk5sx9rNo8=;
 b=DxBwSVMrA6tynrMRamIPagROIc8oiHjkAyWM5FB4cnV2CT4KsB1MBC9PL5Yu9sMchJ
 +GVfmNC0D0lUQ8xDvAfNXCChSutl5nTYri2Y5ONTgfL7lIwJpP1wZB4jXrQHTtRU9RtT
 wUGd9db4YTZ+haDhxlJqhwcKV092BlcMcYlrEJZSWnPQvSdQbF/JCGsLb5wWvYuExsCC
 rnREpT5L36KLU+glSnER8NozanBU0urGedgbgJM5K5QgXLWc/iObycmvltPTor6XXVRr
 PzQGmi1nlLFqrFokIiUIu4ZZkXl4AUsMuwq+etocUACNSu2c/ISKrOF1kfKcTSiuGUjm
 SfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740370246; x=1740975046;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=auvf4KVMx3qO117Ha6bPtSOZHjTaTYtORQk5sx9rNo8=;
 b=n8ko60K/Dv3vmuMqnEndayLqTuu8XzX3X6CgAD93hr6lxz3mY1T0PYDafHSvvzIWYH
 VWZ63BwZhs8z3JwluCkiGs3BClFRQHKSYptEeW+Js0euygv6UrcadglRQdATNMbLGu2w
 Y45pOiSzZ7+0mLB2JRnGZFYGRb4ZJYZKrCAgU4paHT4wgsnRwPABMCGyXlNMAuqZRX39
 JwCn+YRSaDdWUhxHhpgEGoWDfwJ8i3yCowA7hKli6PKiypLoEbegMxGQj79d+0KZiUx7
 q2zB9HBhoB35Qi0eExcN7P677KAVmTb//R2hFlmoKRjCN4vpC1JyQ0tUwXlOJrfg9e/6
 Xz6w==
X-Gm-Message-State: AOJu0YwA22yBhJiFs2ijuTCw9PTNhMguI4TUzPwyDAWOn0Vx9iy5lS8Y
 yFKb8dnpS0eMdV66oQNXKNtG6DU4GEJOAaWuXOEUtsJsmxfMhlNp3wlY5kxEb1hzsgavtKYQQsm
 Lkm6E6eH3oDmMbeM09K7Y1+tpErw=
X-Gm-Gg: ASbGncs97a8+HPzxIr+mGhHJQ9f/hjZdMraXjno2HfD3+9EVSYoRX9ZJSbBsdc5bKja
 PqS/HHHSyObxjxEqEI4troZAETZ0RsJp9kEYSKRxOR3sczABuSsI0MxXAr0groABNyf6ljty286
 AmmFaoMVlaQaN67Rb4zFcIGAlPW3eGtG1AAtXH
X-Google-Smtp-Source: AGHT+IFfXDv/nbREyo6QAC+2yFRSeltnH84lcuwLyVQniPKTw11bcZ9CA+72w5d0MGs9TClJCTovzuXbPrZ1rAucLTU=
X-Received: by 2002:a05:6102:50ab:b0:4bb:d394:46d7 with SMTP id
 ada2fe7eead31-4bfc0021756mr5089987137.6.1740370246082; Sun, 23 Feb 2025
 20:10:46 -0800 (PST)
MIME-Version: 1.0
References: <20250202-riscv-sa-restorer-v1-1-6f4bf814a1dd@t-8ch.de>
In-Reply-To: <20250202-riscv-sa-restorer-v1-1-6f4bf814a1dd@t-8ch.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 14:10:19 +1000
X-Gm-Features: AWEUYZkNfY_NEx1ehGVcCPjSDLg71hRHrRGBEGboqjrjypNR4TKkzbK1QBt5sVk
Message-ID: <CAKmqyKMeK8uAdkL+DNWODMnSiBMUQh_jkwe5ryn=q1pqZmnHMA@mail.gmail.com>
Subject: Re: [PATCH] linux-user/riscv: Disable unsupported SA_RESTORER
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2c.google.com
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

Thanks!

Applied to riscv-to-apply.next

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

