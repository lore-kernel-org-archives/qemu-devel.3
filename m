Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9AAC47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 00:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUcSI-0000et-2L; Mon, 29 Jan 2024 19:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rUcSE-0000ec-S2; Mon, 29 Jan 2024 19:58:22 -0500
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rUcSC-0005IE-04; Mon, 29 Jan 2024 19:58:22 -0500
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-46b3ff62223so1418301137.0; 
 Mon, 29 Jan 2024 16:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706576298; x=1707181098; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5hVOmhY2rLM/i3U07ETeuRQwcvVKn2ifGXwh9SlRTNI=;
 b=DVP8NppQJe9pmCjTtSWjrL9D4bO5UfPrJRexhWRbvV3xYHoZIgsAu5CN9C/2ED6Aqt
 t7f5Sh+ckq8Z0iE9C2VW8Nc3aAugzSA8Oaobuq5uGKJD8gQTLW4DfvRoT3CddOAZIrOt
 xm4IsQw3h0zbWTgpc3zqYag4C1wLCxGILrurSAmYKQZFa7gMMTyTaOhlqwn9r39D08th
 Bq8ngRNCXuMTKN1oOs9wec9/Ien8j/15HIus2tfU1QZp8LX6SjJxtb31YyXIC3CT7l6s
 wGhXlr08P7TmtNaFMcciMQDOWJxjN6HrEKuXKGlTNPgB6MFdlSRlo4wfrkadnO0eFctj
 Nw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706576298; x=1707181098;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5hVOmhY2rLM/i3U07ETeuRQwcvVKn2ifGXwh9SlRTNI=;
 b=nS2Gd6LsulAEmjn7GQx2Qedv024GIYB26sUxYy5j0/LVHJi3+pl57SMzrkOsn3P/Yz
 XCVygDAOVZxLm2LU87p0r6jhCSDDPn53dL3TtJ7Qq410lWNnTPKUXVOywlwcsAniiVRf
 YtIZVMaIROelhaOCrfQzKNzryPxceyvVOcgLkJtDzRaHCxbEsDgmyKG02HcWvFpZb8JG
 DSQ2SAMKcIbly3lMCKtxCq4phltL9dVtpODBwj33tgODktYbHPv57FqYpcp4KaP8JPOl
 J3aYvLJOdEBN2Y19plNPhogUT6MotUbb1M8WTiJr55i0tT8qND2cy7duG1BunlJBgiBx
 acyQ==
X-Gm-Message-State: AOJu0Yy1olQ244dzpo8TDeVfzW+9CoDwwIr/zpyZy0hKVtskA3s3GKw/
 i47KgvcnkgdPZ8v9ffDiLy4n0o9jvXahphf+essBepH3Rrgwpkm04dg7ha60jYBf4D4iNCQUdtl
 t1qoigSbHy8s7DCQNWKLr2K3jLv0x+wU7TmA=
X-Google-Smtp-Source: AGHT+IGiEXCceuCI+tG1X7/FiuApO4jmIpKj+1XWNDCwGq+RLkGafWZWo8QS+DpJKGgidY7FfqbKozi+chX2iqj+aPE=
X-Received: by 2002:a67:f65a:0:b0:46c:9cac:4147 with SMTP id
 u26-20020a67f65a000000b0046c9cac4147mr46597vso.17.1706576298676; Mon, 29 Jan
 2024 16:58:18 -0800 (PST)
MIME-Version: 1.0
References: <20240125195319.329181-1-dbarboza@ventanamicro.com>
 <20240125195319.329181-2-dbarboza@ventanamicro.com>
In-Reply-To: <20240125195319.329181-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Jan 2024 10:57:52 +1000
Message-ID: <CAKmqyKPTu7qWiCy2ruxb-vupeyCBh0W2bo5nGmUOOBRg2BsQGQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] target/riscv/tcg: set 'mmu' with 'satp' in
 cpu_set_profile()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe30.google.com
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

On Fri, Jan 26, 2024 at 5:54=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Recent changes in options handling removed the 'mmu' default the bare
> CPUs had, meaning that we must enable 'mmu' by hand when using the
> rva22s64 profile CPU.
>
> Given that this profile is setting a satp mode, it already implies that
> we need a 'mmu'. Enable the 'mmu' in this case.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index da437975b4..88f92d1c7d 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1107,6 +1107,7 @@ static void cpu_set_profile(Object *obj, Visitor *v=
, const char *name,
>
>  #ifndef CONFIG_USER_ONLY
>      if (profile->satp_mode !=3D RISCV_PROFILE_ATTR_UNUSED) {
> +        object_property_set_bool(obj, "mmu", true, NULL);
>          const char *satp_prop =3D satp_mode_str(profile->satp_mode,
>                                                riscv_cpu_is_32bit(cpu));
>          object_property_set_bool(obj, satp_prop, profile->enabled, NULL)=
;
> --
> 2.43.0
>
>

