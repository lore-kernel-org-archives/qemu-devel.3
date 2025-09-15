Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B70CA0EE8
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 03:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxzff-0004nE-09; Sun, 14 Sep 2025 23:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uxzfa-0004ma-1K
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 23:14:22 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uxzfQ-0005aI-CH
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 23:14:21 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b0787fdb137so541086266b.0
 for <qemu-devel@nongnu.org>; Sun, 14 Sep 2025 20:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757906047; x=1758510847; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BrXlCB/VsNrHT6GdNRE4NQrrtvbqaxart1X7luF5evI=;
 b=ao+nV0P98wOFKWDzIi7z+ntaTeNRn7ZJMXat5kT3r3URXrW4wtOxSB0c5Vq1HWx9L2
 u4SIUDcKw63uSvJrVEF8MfL3BzDeJ8rU2ov053iApGsJz2mvCjnIIxgnGQ88N5aFPFLS
 XRCDYXmOGnzfIsICM/oiEFBMnZ37oIw6QLXgn6pwvCJ0cSRwh2cdcAtgKIvKBNCsEbCV
 yhqK/KxJOcwbM0rGiE0wtUu4KdIDpltWWnWUetLzxaI0QF+D4xyQ/eHMvS8lBkLAf8CH
 3nPZ1fSB6xCMazxuydMWVsTrLFPFcymdPuYcoWXUkrs6G3h8EnVa3GcXbSWtkXxjf3BI
 xsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757906047; x=1758510847;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BrXlCB/VsNrHT6GdNRE4NQrrtvbqaxart1X7luF5evI=;
 b=k9idh3ABd+RGCsHnaI1o3PQhWeSKGTA0nNj0y2cKeg+olieLW5ds8YBhgrU81/wauO
 o/8kOxBNW9PJ+ue208zJMYiGg4W2gSj7WXDk11ZERmiqSGdQLeqImHKWunJ8F3n0J8xu
 CuEodRWBnkZ0+NQdKActMNvT3CU3t3Db/q0C6GWD0Hw1S2dpHGVRB/ja4/oUrcegciIi
 SZ3Ml+u8PheG/Nmb9lfqO4o3hUvwBTV/kWBjNZe9bBKGr6EzH+eBZk3jMDGY9pWb3+Pr
 1VP+p1Y4WCAswG8T0tel+ijgnpp881Our+PzgCkfCU/GpitbS727KEoQ0hlegeagv2my
 ALrQ==
X-Gm-Message-State: AOJu0Yw+UYK99VFAf8fm1wG/cgR4qvmN5ku6hPugWtFqBZYuVKrGz+N+
 mGkTYKY2khUtIGDFWG8YJtx2NVNh4Yh6bBBthHcgVIS0g8ANNQXgTpXXcSGx3j6z0WHqh9Vm55V
 PJHkY9SC86Rwxg+aecDmRDHdfYipJcS8=
X-Gm-Gg: ASbGncsXMN/rtFpp1Vt3+vyRtmjFdKQ41evrjnUsIK08oTi7Ln9fL82RtCmlwU1pUPy
 uvfHv6ONgKuCzS1QQz8jFF0CnZ44UAMB36XrV4OK1p25Dn9WxYNfJnAkrZNE85/aUr2cN2jv6JJ
 N/FmC9rqwJMnb3i0+j/lTAnCWGnYqwWAZ53ceLeBGDL1frxJAQ/jObYwdeVSOsoNMtzxN23i4L6
 sCXXDPCnX7Sqt2kx9OsxnNg27JNvemelhA7Mg==
X-Google-Smtp-Source: AGHT+IHJEq+7rFAQddpx2y0IPUpjYLn+VJHzhi0NYAN5qqOIVSfdXj3RYU5mh1jrgbMW89nBP2PbItyZCShu9ZHhMT4=
X-Received: by 2002:a17:907:2d2c:b0:b07:9c13:153e with SMTP id
 a640c23a62f3a-b07c353e3f8mr1110296366b.2.1757906046911; Sun, 14 Sep 2025
 20:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250623172119.997166-1-dbarboza@ventanamicro.com>
 <20250623172119.997166-3-dbarboza@ventanamicro.com>
In-Reply-To: <20250623172119.997166-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Sep 2025 13:13:40 +1000
X-Gm-Features: Ac12FXyaHaipI69dbsd3WfFSc5q576C_bfii7uU0MoxJJd9IpiiQghyMLBhViTQ
Message-ID: <CAKmqyKPDSWcCs-VXsfDLh6VWPQFpRhj-wmO=hd36Td+m6ngzdw@mail.gmail.com>
Subject: Re: [PATCH 2/3] target/riscv/cpu: print all FPU CSRs in
 riscv_cpu_dump_state()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jun 24, 2025 at 3:22=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> We're missing fflags and frm.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 67e4eda4f9..95d0b88937 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -593,6 +593,8 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *=
f, int flags)
>          }
>      }
>      if (flags & CPU_DUMP_FPU) {
> +        riscv_dump_csr(env, CSR_FFLAGS, f);
> +        riscv_dump_csr(env, CSR_FRM, f);
>          riscv_dump_csr(env, CSR_FCSR, f);
>
>          for (i =3D 0; i < 32; i++) {
> --
> 2.49.0
>
>

