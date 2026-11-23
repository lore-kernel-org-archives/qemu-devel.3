Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C000C606A327
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.a=rsa-sha256 header.s=google header.b=c74VmotX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVZ79-0007PP-O2; Mon, 23 Nov 2026 13:50:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philipp.tomsich@vrull.eu>)
 id 1xVZ77-0007Nv-I6
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 13:50:05 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philipp.tomsich@vrull.eu>)
 id 1xVZ75-0006n3-JW
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 13:50:05 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c504707acfeso50934966b.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 10:50:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795459802; cv=none;
 d=google.com; s=arc-20260327;
 b=bd3H9WFvVbMOph/KsV+GteqEpuRYZ7T4VijxsfzRX4DfWBtvO4uvwJvS65JuDxsIut
 GVomwyeEBFc8E3u1d02i8bjM+E9gumrmoJGjTEKgQ9KTFjxLSChESomQNSZWf+g2LayL
 +S2Md0SW4pqjfa5DVIB/XnU57/mIqOtTCtQ2iBxv3zYqwKHy31gpQeBt378t5uXKtONU
 BWj2ESIkgLWRgHWvfB9twAH+UFJxSnZXZIviKkK1C18N72jF0dUBGRolb0YUI2lT9cOk
 RSA/vf7OAMHcb523NdmQyUJbOSjoqJjb7OIxAERrJwSFIffGj6HNmf9pBHI2lMtnvNiH
 S+dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/W9nakkO+RzSoJ5EwvYCH459rNyhPhriAZNQIyye244=;
 fh=MvhRrqu2i8mxDRH1wr4tXkxOt0dA0cq3cs9EEHZHF+8=;
 b=SIXQeX9nOumeNB1AjQzHtnySj10uEE+g3LQGVQmY97hPPNXYS8gKyb3G+MeZg6i2tE
 t2XQk0woaS8TT2HCsX4ydxJMCzt85hC2FH0u6owcnBftaeH+T2mgtEF3OS1H3Bknb3e2
 xbohl58C0SCz5XoYztBOfNj5aPiVZ4dvrX4/lM7gRLnt1oQJqzP/PDmlFVYZ2JAEqvMM
 ZqXht0mL1YS1XBwhUCFLcQlly/bvTH7OL20A605NO3DM/P95u/L7Tqp+AHE43KIoopU8
 vqqsdJ3cQ50c+5Qvq1Crx/OzcuTw3CNHaLQGdTSXUiqtYB2N7hOCF+Yh/vhm8vEms+aF
 5Qrw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1795459802; x=1796064602; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/W9nakkO+RzSoJ5EwvYCH459rNyhPhriAZNQIyye244=;
 b=c74VmotXPTrWuCDZLnSQH8+WrWBoq0Ki+kpt6O2JF2O4UMRx2pP1IoJfkb64FNNIKG
 9WKtQWFN5MUnS0OX+8ePOa2Fnv1fO79IIr6oI+OW3OfJH7LaIfXKYtWmDYOmZqY/tvFe
 O52bsPtH9zmsv1+cGvj2MBA4fQDMNf8ZKi1hrxio+MTDYp3DH/Koh/M3Is7KxkRjQDde
 EPMqz1jKaLJmguXcZU+5o5JJ5q+3SX6yrWqTICcg8GfNDMGXQSt1knumweB3zl/qVRLh
 8QWqGz7bBGU2s0zrMrI8QfJ/6HfwU4ifxySR4r+G796QRAL+wQAFCbU/onrLxedL1wZ0
 PPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795459802; x=1796064602;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/W9nakkO+RzSoJ5EwvYCH459rNyhPhriAZNQIyye244=;
 b=vT7CcwmC32aagMbYVtFy7DVEyX/fw933rk1pgG6KImXA3ffnESWOK32AA3UZsKQvbL
 73maoRUD71Pa5SaLHEH12wX2vibysnbvYvX0D+T0Jwztd5WJum572H9pnrwSkHDEaR/f
 KXRGnjYvfEKBBNuEBHEZfz7h131uit2o4sY16JpvWd+eeMOzrT5D+oVtaLpgmJZBN8yM
 w1CrXjUiaC8wZ/XrihmaiEK1yuC/12xjWFIPVeS6pkzRrw0qTyLefo+QPS3oMrWB/MhT
 YCyQiGY8LoL1nf+RD80f9unUj6LD6pp2RbH0xoP6Z37rdbB2tgQoTNJkKgW+SQNOYft8
 IR/Q==
X-Gm-Message-State: APuU4Z/urkoGZHsTjYc+jzrQu/L2AvdCHe+0w5+94iNdJSht1QH9yvzN
 HD4hsoNoPjQGVh0UJA4hWgsVZwamQEmBh5AqiOadUJ5Ok10YPZESe09p1EmWP1tbedhcEZLoiS5
 P5rIsoGAAekZIj1mYHPn1neWudAY9MIFLfHfGRbLwYg==
X-Gm-Gg: AZFdTZfEkIw2ZbzLBxFCqltvjBqcO92VKR6P9TfRpdQhYEdUFMXtd5o7ZwnhXZove12
 Ah66Km7U4S1yLy7icysQavzvS9DpFMZycjQOgQ396zqoJgijlB9zefGU/ZXK0gUQbaM1vUqo5j8
 AVl8Rb+INWna5p6k1kpfRo5GIWqy4fOLaXKSa1ZZUUrDxFQDtPi1xKmZYuZlUnVOFlKj2jzxiqn
 gxPBEN5bWy51qW40uU3atMXZGgxm4pW/cE+40AUGHPo1vvf4uCtijc2VDmFh26x5LPBhAgr5+cm
 SwZQujbzMTGOlOCT8FPaz9AOHjr96ORf6SPBOODv35Sn4myW56Piuopq0QWfwVI5GIv9EMvYeA4
 oS6h1iXz1gX8Fd5JnLh4165h31HDkiLc4vsIBhnmOuE8yCHx/YC+7oIiL83HCffnY+B0YHwRvre
 LHtzb7XQrem5iGRjoIq97yJIN8sv13jq/JZ88=
X-Received: by 2002:a17:906:ad93:b0:c41:8e21:4d62 with SMTP id
 a640c23a62f3a-c513a4391ffmr915822166b.1.1795459801945; Mon, 23 Nov 2026
 10:50:01 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118-zl-master-v1-0-129f85e0f887@linux.alibaba.com>
 <20261118-zl-master-v1-4-129f85e0f887@linux.alibaba.com>
In-Reply-To: <20261118-zl-master-v1-4-129f85e0f887@linux.alibaba.com>
From: Philipp Tomsich <philipp.tomsich@vrull.eu>
Date: Mon, 23 Nov 2026 19:49:50 +0100
X-Gm-Features: Aa3M54rsV5G4W6qxnM4pN9rLDkfQAkZZRMsqyxbZshX7t9zn4nooyfzsrwHSw3k
Message-ID: <CAAeLtUBzvZF-Z4YfvtmvspPSYr9iaeU=Q3nH_iFEwxsrAgGjMg@mail.gmail.com>
Subject: Re: [PATCH RFC 4/8] disas/riscv: Decode Zl instruction lengths
To: TANG Tiancheng <lyndra@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philipp.tomsich@vrull.eu; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 at 10:03, TANG Tiancheng <lyndra@linux.alibaba.com> wrote:
>
> The Zl draft identifies long instructions from parcel A and determines
> their 48/64-bit length from parcel C.
>
> Read complete 48-bit and 64-bit encodings and return their decoded
> lengths. The disassembler does not yet decode instruction mnemonics for
> these encodings, so print "unknown" rather than decoding part of a long
> instruction as a 16-bit or 32-bit instruction. When opcode display is
> enabled, also print the full encoding in hexadecimal.
>
> Link: https://github.com/riscv/riscv-long-instruction/blob/65c377a665feb29a4848384ad566a9873c5fd423/src/unpriv/zl.adoc
>
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> ---
>  disas/riscv.c              | 34 ++++++++++++++++++++++++++++------
>  disas/riscv.h              |  4 ++--
>  target/riscv/insn_length.h | 17 +++++++++++++++++
>  3 files changed, 47 insertions(+), 8 deletions(-)
>
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 8c9e06b46f19efd6aa9f605ccd0bf3716fa62d44..d2a2b322374643dc51b3bc51775484da9a99e039 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -3489,17 +3489,21 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
>      return format_inst(24, &dec, op);
>  }
>
> -#define INST_FMT_2 "%04x              "
> -#define INST_FMT_4 "%08x          "
> +#define INST_FMT_2 "%04" PRIx64 "              "
> +#define INST_FMT_4 "%08" PRIx64 "          "
> +#define INST_FMT_6 "%012" PRIx64 "      "
> +#define INST_FMT_8 "%016" PRIx64 "  "
>
>  static int
>  print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_isa isa)
>  {
> +    const RISCVCPUConfig *cfg = info->target_info;
>      bfd_byte packet[2];
>      rv_inst inst = 0;
>      size_t len = 2;
>      bfd_vma n;
>      int status;
> +    bool zl = cfg && cfg->ext_zl;
>
>      /* Instructions are made of 2-byte packets in little-endian order */
>      for (n = 0; n < len; n += 2) {
> @@ -3510,7 +3514,15 @@ print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_isa isa)
>          }
>          inst |= ((rv_inst) bfd_getl16(packet)) << (8 * n);
>          if (n == 0) {
> -            len = insn_len(inst);
> +            /* Zl needs parcel C to determine a long instruction's length. */
> +            len = zl && riscv_insn_is_long(inst) ? 6 : insn_len(inst);
> +        } else if (zl && n == 4) {
> +            len = riscv_zl_insn_length(inst >> 32);
> +        }
> +        if (len == 0) {
> +            (*info->fprintf_func)(info->stream,
> +                                  "<unsupported instruction length>");
> +            return -1;

If the translator fetches through ILEN for reserved lengths, shouldn't
the shared length helper return 8 here as well?


>          }
>      }
>
> @@ -3522,14 +3534,24 @@ print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_isa isa)
>          case 4:
>              (*info->fprintf_func)(info->stream, INST_FMT_4, inst);
>              break;
> +        case 6:
> +            (*info->fprintf_func)(info->stream, INST_FMT_6, inst);
> +            break;
> +        case 8:
> +            (*info->fprintf_func)(info->stream, INST_FMT_8, inst);
> +            break;
>          default:
>              g_assert_not_reached();
>          }
>      }
>
> -    g_autoptr(GString) str =
> -        disasm_inst(isa, memaddr, inst,
> -                    (const RISCVCPUConfig *)info->target_info);
> +    /* Long instruction mnemonics are not decoded yet. */
> +    if (len > 4) {
> +        (*info->fprintf_func)(info->stream, "unknown");
> +        return len;
> +    }
> +
> +    g_autoptr(GString) str = disasm_inst(isa, memaddr, inst, cfg);
>      (*info->fprintf_func)(info->stream, "%s", str->str);
>
>      return len;
> diff --git a/disas/riscv.h b/disas/riscv.h
> index 4f1ffc4ae02fb1e5940e833ef972f80e28603a19..b49bcadab8e4fa1f32f28e1d5ed9035c5b55a359 100644
> --- a/disas/riscv.h
> +++ b/disas/riscv.h
> @@ -11,7 +11,7 @@
>
>  /* types */
>
> -typedef uint32_t rv_inst;
> +typedef uint64_t rv_inst;
>  typedef uint16_t rv_opcode;
>
>  /* enums */
> @@ -184,7 +184,7 @@ struct rv_opcode_data {
>  typedef struct {
>      const RISCVCPUConfig *cfg;
>      uint64_t  pc;
> -    uint64_t  inst;
> +    rv_inst   inst;
>      int32_t   imm;
>      int32_t   imm1;
>      uint8_t   rd;
> diff --git a/target/riscv/insn_length.h b/target/riscv/insn_length.h
> index bfb3af0e6358249daf464fed670f09d7184d307b..14bf5c7fa98a388705e023ff7d0d0840d1306c63 100644
> --- a/target/riscv/insn_length.h
> +++ b/target/riscv/insn_length.h
> @@ -9,4 +9,21 @@ static inline int insn_len(uint16_t first_word)
>      return (first_word & 3) == 3 ? 4 : 2;
>  }
>
> +static inline bool riscv_insn_is_long(uint16_t first_parcel)
> +{
> +    return (first_parcel & 0x1f) == 0x1f;
> +}
> +
> +/* Call only after fetching parcel C; zero means an undefined length. */
> +static inline unsigned riscv_zl_insn_length(uint16_t third_parcel)
> +{
> +    if ((third_parcel & 3) != 3) {
> +        return 6;
> +    }
> +    if ((third_parcel & 0x1f) != 0x1f) {
> +        return 8;
> +    }
> +    return 0;
> +}
> +
>  #endif
>
> --
> 2.43.0
>
>

