Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26724F55452
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 04:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv6nQ-0000jb-Hz; Tue, 24 Feb 2026 23:46:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vv6nJ-0000jA-U8
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:46:42 -0500
Received: from mail-dl1-x1244.google.com ([2607:f8b0:4864:20::1244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vv6nI-00004x-Ad
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:46:41 -0500
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-124a635476fso5947740c88.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 20:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771994799; x=1772599599; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vVGwXbKj2pTzXr05Aoq+1QeXKYJ/6G8XT2HUq7/dGb0=;
 b=Tod2a2FI6/P7pKNDvTZQnJv6p7x4HAjkZNcBKGb8HQ4k1+UPCtUUQ+GQMky+5HOKtg
 Rv1NADjmuGQ+9qIlPjHF1Asm9yDLYgZ19zJajAbHLt0xlGdzayhflH4O4+nLXnTN4g8I
 TxL7XpHmILxeHyuc7EGQ1m3OumC+OqXjHnHgHOcwCP3RQadshxEnObUEUyyfNNZfVl6d
 I5mecCN9c/JVNYHPH0jRMWIboS/qjyEa/jyMMhdBpmTsqjBou8/qBo5e6cxdaWZh+Dp+
 SEd8DX7GBfmCt1jBJ5kHVppFjM3DD3D8N0EcKExNuQk/5FFwEe+qlbCDabeR12Rz82fl
 Eh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771994799; x=1772599599;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vVGwXbKj2pTzXr05Aoq+1QeXKYJ/6G8XT2HUq7/dGb0=;
 b=uhZMsulOOaAz5PkVxEEUrjfRtJZ7kmfbehhO8MWP0jpqVuAbScn832I31kqst+5aHS
 edQV/ro7y3pqdvHw85RKefaTs+dCE7KjCWGXgb2I9NWZHUQTA0kcRRuTFw8JJwPrMej3
 +OxwEDwFXZZorGliRkzyxyH/SaDFeAdO81fvYUVWKU5PTGctLZxQVKmWIBQYWjrkkH/5
 SzbcKxLlTLDLHva70LUn/2lVdgKldpjBQnK5fH8wKGHua6GmbtzdKLd7q3XZmKmLeA7T
 nUmv5NvBpV6kTJUbobhbvu8WaZUdsoPHCVMTNe52WtAmEDWymXzaEXifecVogO8QXKn9
 ZKvA==
X-Gm-Message-State: AOJu0YxKlZ2rBCxfSu/fN1UlYE9OOCzlInp8Fh+sDcLZSLDiUD95wG96
 BtVEWSwIAuOF0D/lEAqhmYuRZkW0+8BMsTBADcxBkFeWaik6Rkm7ELwz
X-Gm-Gg: ATEYQzyvFHAFc3QKimeEp/SB3wgOVreQUDl8a2IbZx5cTamdcB38UVVFxUMI02VBpPf
 y3GcqzjetJ3VT9+gF7qLPgj2M4FgoFtXWbaqJzy1TqKDjPj0y2MmiQfBjKwGqaCM64PpFuNjojh
 gOS98uYXBI0xBpWIuX1P3bBVUI+o9ugPPErFTiK/bAtX5n0R0iJ0/ZlHZfouowjVZqmG6mEK8hT
 /KkfH2VkPOR57Aq++M6UKDRsB925Rf2gwDTUcpDLjGJIz8w56zDhl5zqBY/mfVctFxLfjVIWcUB
 RnPLvRBnhdtp4rjnXOTN8OTjZCY00yvbnT6pnRZjTIZxeJvNtrCLwyqNbU3ccnkbOT8UMnkJoJT
 m2i5Vz7J55P1pyfQ2sOQ2cpP/5zpkx0jtHkRobF29Exty2+o8P/VXTpzjBKWTgb1JfmDVNeA/wg
 rlMrMlDgG/QLnvtzkJL9VwISDryy9JpUZauLSIgGYuSFCZk++YQ6QZ353pqQ6p/AKggdmSyS4VE
 0qPf67KG9hrXNp2FUFISynatb6+Njo=
X-Received: by 2002:a05:7022:160a:b0:127:366f:8bb7 with SMTP id
 a92af1059eb24-1276ad11b26mr6067082c88.25.1771994798835; 
 Tue, 24 Feb 2026 20:46:38 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1276af2edd7sm13234004c88.8.2026.02.24.20.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 20:46:38 -0800 (PST)
Date: Wed, 25 Feb 2026 12:45:41 +0800
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
Subject: Re: [PATCH v2 28/50] target/riscv: Remove unnecessary target_ulong
 type uses
Message-ID: <aZ5-aDM57y03C8tz@ZEVORN-PC.localdomain>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-29-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260219191955.83815-29-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1244;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1244.google.com
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

On Thu, Feb 19, 2026 at 08:19:30PM +0100, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/riscv/gdbstub.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index f89b20ea84a..a053009ccd3 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -52,7 +52,7 @@ int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>      RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
>      RISCVCPU *cpu = RISCV_CPU(cs);
>      CPURISCVState *env = &cpu->env;
> -    target_ulong tmp;
> +    uint64_t tmp;
>  
>      if (n < 32) {
>          tmp = env->gpr[n];
> @@ -80,7 +80,7 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>      RISCVCPU *cpu = RISCV_CPU(cs);
>      CPURISCVState *env = &cpu->env;
>      int length = 0;
> -    target_ulong tmp;
> +    uint64_t tmp;
>  
>      switch (mcc->def->misa_mxl_max) {
>      case MXL_RV32:
> @@ -194,7 +194,7 @@ static int riscv_gdb_set_csr(CPUState *cs, uint8_t *mem_buf, int n)
>      const unsigned regsz = riscv_cpu_is_32bit(cpu) ? 4 : 8;
>  
>      if (n < CSR_TABLE_SIZE) {
> -        target_ulong val = ldn_p(mem_buf, regsz);
> +        uint64_t val = ldn_p(mem_buf, regsz);
>          int result;
>  
>          result = riscv_csrrw_debug(env, n, NULL, val, -1);
> @@ -215,7 +215,7 @@ static int riscv_gdb_get_virtual(CPUState *cs, GByteArray *buf, int n)
>          CPURISCVState *env = &cpu->env;
>  
>          /* Per RiscV debug spec v1.0.0 rc4 */
> -        target_ulong vbit = (env->virt_enabled) ? BIT(2) : 0;
> +        uint32_t vbit = (env->virt_enabled) ? BIT(2) : 0;
>  
>          return gdb_get_regl(buf, env->priv | vbit);
>  #endif
> -- 
> 2.52.0
> 
> 

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao

