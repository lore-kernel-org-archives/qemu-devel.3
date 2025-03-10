Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04D6C28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 23:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trmH6-0007Zn-ST; Mon, 10 Mar 2025 19:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1trmH4-0007Z4-OM
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 19:11:06 -0400
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1trmH2-0006Vf-Vi
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 19:11:06 -0400
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-523ffbe0dbcso2021214e0c.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 16:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741648257; x=1742253057; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WYwWucOsTx3nF2AZhXgoS68O3t5GWvroI7hfbrzqlzM=;
 b=ecYv8smFyEhSzHF+MXbbn8RvU3Yrn5aULtSiditqw421Lxzsdj+sy13vdam84XEbbp
 JapIbpHbupVbOGDcLgc5P/I1SNYFJKnFMbYidr0fQq/Tp+X5oAsRhVKkpOJO3DTaSM7A
 79t3kQh8se6FmMXAIgr7dGIA/ve/iJERSvdsQslMAsL2ip1S9udlEFvppNqd0cw32fcV
 lX0EKArzJR9CwpPsr6Ire+lhawvFyW0jyQM6ol1y+sq5FqSdt7kLFziUcWKDLkDJB+nt
 iYPjM1ijvRWyz5tHaCChvq5ffV07r6YWuJLDkGhfMVTdPbIfdPe+kFYLIvtE+SmHeAqx
 8Afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741648257; x=1742253057;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WYwWucOsTx3nF2AZhXgoS68O3t5GWvroI7hfbrzqlzM=;
 b=T7qziVHTJUGkElPLNz1KgsTfJn+s4JmZOTxeqSIFUNVWV2zXyvRtiaQAzQhN4luaWb
 k2MboabPUvcxQFG8/hSOsmZHNFgwOdCMQr779t8mFhhRnkhpiL7qXu8xllM6e1bLZe2L
 YnQrTFk2Xjnl5bO2z7UbWc5Du8R8CoZEq3gavg07X06+fs+qu1jYAq2/y0wfgdh7ibOx
 fb69RmAZ540TOoxacQnk/dwLV8Y4AwyB0cH8CyNKQKAqwb3vMuCd4e55+brBomnkxd/E
 7ty3Y+DHDT4UzoKqxh/JDwQkT4ChDUbWmOVAFohbbSbbAeVmSRX3sk1Xlhm1UYOJhn3w
 GOqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlh+MLt8xAEfq19CadbqHLJBUtA5KKXY/gOyyTebACeakmnSBN5bnPFbk82sNtJLArBz9kEx5WBjMj@nongnu.org
X-Gm-Message-State: AOJu0YwitiMbRoFZGX8+X4wMuVvT2v9TCyuU7IyR0ACYE+kOIb277q1h
 9/jun3HLGWzyLdVYn/KOd/ld6uAKxr6KUyZuwvW532uTeaF69CzBzFv8rwtwy/nDElGwFSRSU9k
 1a0ncXuwg4nbYtP4ywBYOCj0T39A=
X-Gm-Gg: ASbGnctCeXT4WSTVC7AfDzYopxsAWxJo5QabNbgjPz+Cx3/4SQS4XLbafnAHdKMtKPa
 +Zz5D8lhI3V8eS3IN3SDYiLhFy/lXifp2tmc/PXE7i12nGuJXYlUah7+ntjpIHK8SFeJkpfNZVZ
 nHCAGOxOjEqVLYba3r66rCMvwwUjKFRkdTUQO5SOGBrzY+rKqUbdwcira2
X-Google-Smtp-Source: AGHT+IHFLn1E0fZJdlQONY/yIaYofNJ6kOe52b51fWafEOs8F/TYeMcBCys7+63PBuFzlvY+tMqTFUUF6PCBB/puBDs=
X-Received: by 2002:a05:6102:c14:b0:4bb:e80b:473d with SMTP id
 ada2fe7eead31-4c34d23a3ccmr1210616137.6.1741648257314; Mon, 10 Mar 2025
 16:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <mvmo6yglouz.fsf@suse.de>
In-Reply-To: <mvmo6yglouz.fsf@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 11 Mar 2025 09:10:31 +1000
X-Gm-Features: AQ5f1Jo4-Cz3AQTOeRm8z_9pGFup2mzkBXPaT-uJhrp_x-PLWsGOLtUbKeXMsYE
Message-ID: <CAKmqyKOdZn__jJH4Pzsqm5Rv2my1Kq3Gn8fefRb4+wKLko=pWA@mail.gmail.com>
Subject: Re: [PATCH] linux-user: fix handling of cpu mask in riscv_hwprobe
 syscall
To: Andreas Schwab <schwab@suse.de>
Cc: Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@rivosinc.com>, 
 Robbin Ehn <rehn@rivosinc.com>, Alistair Francis <alistair.francis@wdc.com>,
 qemu-devel@nongnu.org
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

On Wed, Mar 5, 2025 at 2:54=E2=80=AFAM Andreas Schwab <schwab@suse.de> wrot=
e:
>
> The third argument of the riscv_hwprobe syscall contains the size of the
> cpu mask in bytes, not bits.
>
> Signed-off-by: Andreas Schwab <schwab@suse.de>

Richard sent a v2 that I have applied:

https://patchew.org/QEMU/20250308225902.1208237-3-richard.henderson@linaro.=
org/

Alistair

> ---
>  linux-user/syscall.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index a22a5df8cc..4cc1a31d0d 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -9120,16 +9120,16 @@ static void risc_hwprobe_fill_pairs(CPURISCVState=
 *env,
>
>  static int cpu_set_valid(abi_long arg3, abi_long arg4)
>  {
> -    int ret, i, tmp;
> +    int ret, i;
>      size_t host_mask_size, target_mask_size;
>      unsigned long *host_mask;
>
>      /*
>       * cpu_set_t represent CPU masks as bit masks of type unsigned long =
*.
> -     * arg3 contains the cpu count.
> +     * arg3 contains the size of the cpu mask.
>       */
> -    tmp =3D (8 * sizeof(abi_ulong));
> -    target_mask_size =3D ((arg3 + tmp - 1) / tmp) * sizeof(abi_ulong);
> +    target_mask_size =3D (arg3 + (sizeof(abi_ulong) - 1)) &
> +                       ~(sizeof(abi_ulong) - 1);
>      host_mask_size =3D (target_mask_size + (sizeof(*host_mask) - 1)) &
>                       ~(sizeof(*host_mask) - 1);
>
> --
> 2.48.1
>
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D=
7
> "And now for something completely different."
>

