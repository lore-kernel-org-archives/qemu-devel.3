Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E84F55454
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 04:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv6mM-00087p-PL; Tue, 24 Feb 2026 23:45:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vv6mK-00087A-6o
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:45:41 -0500
Received: from mail-dl1-x1242.google.com ([2607:f8b0:4864:20::1242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vv6mH-0008Nj-MP
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:45:39 -0500
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-124afd03fd1so9004642c88.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 20:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771994732; x=1772599532; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A3yJFLV1pMZQ7A7LbEe2fUs1hCMPhtC17uzqzQOOVrI=;
 b=KsXyk9Usuj6pzZQXcS3apKkg3urp3ZotHVIbFnuQ1cJb3BwJhYm7TrQbXzHZcO2uWK
 +ft46jY1FWZ9dm0AhVTuHb00+3XzSH4z3iPwqg0QkhEJDLWHfJxivShTXyNobvpREGWc
 5/5fsJtTixSdP5JTwVIqWE25W+S2CTm9gJjHSDfcZBnb8fOxhzMPksRWwwzYR4PwQ7Qt
 2r2YTz2uj8bd9hu2dPCnMT8jgRHS5BwcPHJSimC4xo25oh/pbGx7Ac2BFOC7ZUq4VLzJ
 AA0PmMC34r0N3IgzxgrMU/oqo4TJXx3Ce23MFcDWZYQQhzIXVF0+5JyfALw5qIb1Nt+l
 K9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771994732; x=1772599532;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A3yJFLV1pMZQ7A7LbEe2fUs1hCMPhtC17uzqzQOOVrI=;
 b=Qaa07uuoM8Wk5V5k/QFqKnzKrLsFXIbkZSLgQsUBZ5m4roumxBN5g4OgbiDgeVyex5
 3WdsVsmx/QNeGC86xdxA30Od7B2l+f2H8anyJMbsgznCXNHwD1yGZJaLAuk5Uo3Vhm7u
 zuWEQEv3Sb/LBUBu1ouR4r0Bfg6TBM8etfagjKI0HfyESfLmyCU7E40maHtekHORCAHy
 lUlZdtTfqmGnEkDxABVyDx+nAxBFfRlMroH94K0MYvdVXVmHYXTRmZdzL1oj1JYVbsAB
 LpI7iK5BCuC9AJ6QkRFIrrsgY4LlJqXAAY7c4uTeCxyH+iao+WMb1OAH01uTwwBTyCyO
 bXRQ==
X-Gm-Message-State: AOJu0Yx65oyTuBCiIit+sikFdfUQNWnTlKvkrSHUPw0J2Bx+NjJ4oh13
 bqa40mELdqYff3dux+gK6HyUTvAut5G+ewY6ZcY1ek8gkaZs8+Ro5s2A
X-Gm-Gg: ATEYQzwfltxcpPgMOvEyGLK2lrq6bm19dm5qhly6zudUmepvY8R6J9/LVg2QGsMEKc9
 3AnAOPcZAek03CcaKFlpd1eNdipYEhDRye5fFtzAroxSVuxyxONxyvhYGLsmm2yNMEN5/5pLzEQ
 KaV6ZiM7lSb+cbY+w3/NwPlgVQCbF81M7/LjcBFN5KI5qvG/h2JoAe1Wxlh4+p1KoTXcpIovCY2
 lvJ6CUveq3wTvvmlucsPHhgwM56KZqTb2OVwNTuRGHdzLsVlNUVuj1F8lC4j6GApUP8fw7lWkrB
 B0g1AJnETeKZURw2hCByM4zTDYNTLBkMrRzx3NgtYiWHM+Qux6j9MaaVPjmOC5SmQm+ZoR4QU1d
 jzzSOKv7f4HrFnvVyKHayV7hYi2QYz12VgTQ5M9xqhf1feB3ibFnkyz7ekwMoj7oJMp2lwfWVC8
 SAnTYaLUX7hgfWlzq4vgf4Pf8kbyoOMTBpnsgD8ycU66EMPvkNjTztZvWaGsuFgsY0ZkauC7nGp
 xJnK8vnflrexvy948C6/+LSqSwN3jI=
X-Received: by 2002:a05:7022:6983:b0:127:7893:b1e6 with SMTP id
 a92af1059eb24-12781e8fb65mr381201c88.30.1771994732081; 
 Tue, 24 Feb 2026 20:45:32 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1276af207d6sm13322801c88.5.2026.02.24.20.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 20:45:31 -0800 (PST)
Date: Wed, 25 Feb 2026 12:44:35 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2 27/50] target/riscv: Replace ldtul_p() -> ldn_p()
Message-ID: <aZ5-Iow28DgQob_B@ZEVORN-PC.localdomain>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-28-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260219191955.83815-28-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1242;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1242.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 19, 2026 at 08:19:29PM +0100, Philippe Mathieu-Daudé wrote:
> Prefer ldn_p(riscv_cpu_is_32bit) over target-specific ldtul_p().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/riscv/gdbstub.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index 1934f919c01..f89b20ea84a 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -191,14 +191,15 @@ static int riscv_gdb_set_csr(CPUState *cs, uint8_t *mem_buf, int n)
>  {
>      RISCVCPU *cpu = RISCV_CPU(cs);
>      CPURISCVState *env = &cpu->env;
> +    const unsigned regsz = riscv_cpu_is_32bit(cpu) ? 4 : 8;
>  
>      if (n < CSR_TABLE_SIZE) {
> -        target_ulong val = ldtul_p(mem_buf);
> +        target_ulong val = ldn_p(mem_buf, regsz);
>          int result;
>  
>          result = riscv_csrrw_debug(env, n, NULL, val, -1);
>          if (result == RISCV_EXCP_NONE) {
> -            return sizeof(target_ulong);
> +            return regsz;
>          }
>      }
>      return 0;
> @@ -225,11 +226,12 @@ static int riscv_gdb_get_virtual(CPUState *cs, GByteArray *buf, int n)
>  static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, int n)
>  {
>      if (n == 0) {
> -#ifndef CONFIG_USER_ONLY
>          RISCVCPU *cpu = RISCV_CPU(cs);
> +        const unsigned regsz = riscv_cpu_is_32bit(cpu) ? 4 : 8;
> +#ifndef CONFIG_USER_ONLY
>          CPURISCVState *env = &cpu->env;
>  
> -        target_ulong new_priv = ldtul_p(mem_buf) & 0x3;
> +        target_ulong new_priv = ldn_p(mem_buf, regsz) & 0x3;
>          bool new_virt = 0;
>  
>          if (new_priv == PRV_RESERVED) {
> @@ -237,7 +239,7 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, int n)
>          }
>  
>          if (new_priv != PRV_M) {
> -            new_virt = (ldtul_p(mem_buf) & BIT(2)) >> 2;
> +            new_virt = (ldn_p(mem_buf, regsz) & BIT(2)) >> 2;
>          }
>  
>          if (riscv_has_ext(env, RVH) && new_virt != env->virt_enabled) {
> @@ -246,7 +248,7 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, int n)
>  
>          riscv_cpu_set_mode(env, new_priv, new_virt);
>  #endif
> -        return sizeof(target_ulong);
> +        return regsz;
>      }
>      return 0;
>  }
> -- 
> 2.52.0
> 
> 

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao

