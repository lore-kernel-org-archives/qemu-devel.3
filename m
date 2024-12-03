Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7905AE6C5FB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 04:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIKks-0001zX-2W; Mon, 02 Dec 2024 23:43:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIKkp-0001z9-Bj; Mon, 02 Dec 2024 23:43:19 -0500
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIKkn-000420-Oc; Mon, 02 Dec 2024 23:43:19 -0500
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-4aed6fdf04fso1145481137.1; 
 Mon, 02 Dec 2024 20:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733200995; x=1733805795; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9W6ec6izysh1nMriv/UI8/a/9GuadH7p4qZ7BiAL20=;
 b=Voo50WFSUSevTNO9J8S3N0kyxi4+1NG2K66JtAFutnW22yXDjVnUiAW/4Ii3+/41Fb
 G2mvEMXMyjvZMuvYDbEk46eNr8A2Rvs3ECVLqYXZf6BD6xQYZUrtKTUP9UBHWFIeOm7n
 g5XnO9Kl5hyxHdM7Na/hz4tuH2k2G0iKYr2p/vQ4+AxH9YjmAhM4tTgZNxgt0KKbp6zg
 Pw3kkTO4VLEjdM5ObwKygvEQ+DvmhUC5ttI9VGY8jRj2XlqH4uX5r+ucDGVB3xRU8fVd
 MmJzWelYMCBHu/MGw2hnhwmEA/Yhx3+OxMrZUW1zGV0pGvwJhO0PNNIVmd0Y0IW0wkE6
 zSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733200995; x=1733805795;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L9W6ec6izysh1nMriv/UI8/a/9GuadH7p4qZ7BiAL20=;
 b=l9l2/au67hvnDwbPn8IE/oxfciN7uyDViPndeWARdrlQe4dKmGyFt86dHKFpH/jFik
 Doiqi96H6YlRtTreuQuUykHLN6hMTB16R7b8k3zhLQyYzY6KrTe3emlXTcx7xhhY8T8O
 uT8tjRgKj0ITqKD35WsNoov1JQYqaHf+ZibdZzPG9qH9a6CiHXHPx3kjSBFatIYHS35/
 4w4hMLiMsezjsDnhQkwoDgDxgLWRDaFJ8l6Xv/XTdTTuqiwyGW1Q22lmbexf1tUGxebG
 NG3KL1uCvshH5j+2Rrfs5Ml124sou5I9RPJOIYPNkPcdntNVh5/OtTHO4oMfPU0yXWia
 4W2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwOzVcBkh/AWyV3fLRlobkBWMquHhBfb+DjqfTmE28wfb2gpvn93NRVbzUCqOhQbS6jtSnQmq9j8/M@nongnu.org
X-Gm-Message-State: AOJu0YzxLL6VmdM4NjtSTMSMmZs7GsHay0E7fXPKVdpXJwXGjsxASXrS
 DW9argD7vhUNcG0dSHw/l7E3wiLnKtEV6rZv8AhYIJD8mhJXT1EbmFffFM/ZmzkU3pveMZdLWyr
 97ldwwqCNhKS48ZUfkRp5eXMx73M=
X-Gm-Gg: ASbGncuVsM3mRqZeJffuOfXh2QmArCSVEpgj60kWvqcuBIcfWcJPlEQ8FFrEnFwx24G
 QsMb3/GZzljUavAsXt7UD1C2WqJIntzzM
X-Google-Smtp-Source: AGHT+IFMbv37TB+Ag+PDYAhdkQN4OHwlQ+07V+QLivWXeqzENUnYnVeZx8NU7co3Tl6boSNvn7M/iB/MgbrFkgeCp8E=
X-Received: by 2002:a05:6102:418f:b0:4af:4f61:f68c with SMTP id
 ada2fe7eead31-4af9716d60emr2066772137.1.1733200995209; Mon, 02 Dec 2024
 20:43:15 -0800 (PST)
MIME-Version: 1.0
References: <20241128103831.3452572-1-peter.maydell@linaro.org>
In-Reply-To: <20241128103831.3452572-1-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 3 Dec 2024 13:42:48 +0900
Message-ID: <CAKmqyKPO5qiR8K9BSr_F+he9X0dY-VpscPn7woxYq8Bvhujvpw@mail.gmail.com>
Subject: Re: [PATCH for-9.2] target/riscv: Avoid bad shift in
 riscv_cpu_do_interrupt()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe34.google.com
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

On Thu, Nov 28, 2024 at 7:39=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> In riscv_cpu_do_interrupt() we use the 'cause' value we got out of
> cs->exception as a shift value.  However this value can be larger
> than 31, which means that "1 << cause" is undefined behaviour,
> because we do the shift on an 'int' type.
>
> This causes the undefined behaviour sanitizer to complain
> on one of the check-tcg tests:
>
> $ UBSAN_OPTIONS=3Dprint_stacktrace=3D1:abort_on_error=3D1:halt_on_error=
=3D1 ./build/clang/qemu-system-riscv64 -M virt -semihosting -display none -=
device loader,file=3Dbuild/clang/tests/tcg/riscv64-softmmu/issue1060
> ../../target/riscv/cpu_helper.c:1805:38: runtime error: shift exponent 63=
 is too large for 32-bit type 'int'
>     #0 0x55f2dc026703 in riscv_cpu_do_interrupt /mnt/nvmedisk/linaro/qemu=
-from-laptop/qemu/build/clang/../../target/riscv/cpu_helper.c:1805:38
>     #1 0x55f2dc3d170e in cpu_handle_exception /mnt/nvmedisk/linaro/qemu-f=
rom-laptop/qemu/build/clang/../../accel/tcg/cpu-exec.c:752:9
>
> In this case cause is RISCV_EXCP_SEMIHOST, which is 0x3f.
>
> Use 1ULL instead to ensure that the shift is in range.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 0a3ead69eab..45806f5ab0f 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1802,10 +1802,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      bool async =3D !!(cs->exception_index & RISCV_EXCP_INT_FLAG);
>      target_ulong cause =3D cs->exception_index & RISCV_EXCP_INT_MASK;
>      uint64_t deleg =3D async ? env->mideleg : env->medeleg;
> -    bool s_injected =3D env->mvip & (1 << cause) & env->mvien &&
> -        !(env->mip & (1 << cause));
> -    bool vs_injected =3D env->hvip & (1 << cause) & env->hvien &&
> -        !(env->mip & (1 << cause));
> +    bool s_injected =3D env->mvip & (1ULL << cause) & env->mvien &&
> +        !(env->mip & (1ULL << cause));
> +    bool vs_injected =3D env->hvip & (1ULL << cause) & env->hvien &&
> +        !(env->mip & (1ULL << cause));
>      target_ulong tval =3D 0;
>      target_ulong tinst =3D 0;
>      target_ulong htval =3D 0;
> --
> 2.34.1
>
>

