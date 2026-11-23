Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA648606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.a=rsa-sha256 header.s=google header.b=A6uSgjvl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVZ6W-0006zS-CU; Mon, 23 Nov 2026 13:49:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philipp.tomsich@vrull.eu>)
 id 1xVZ6U-0006yp-75
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 13:49:26 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philipp.tomsich@vrull.eu>)
 id 1xVZ6S-0005VW-KC
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 13:49:25 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c50686daf9cso69198266b.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 10:49:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795459763; cv=none;
 d=google.com; s=arc-20260327;
 b=FDsc/mKJ9omIKc7131DV9v2xksQGUM3WXOiKPhvuWIJoC0U23vpeAwJVg/IR5q5CQQ
 mrsdCDRChTG8aaNrgCz7bVKggvAr8T9IjbD5v2txUq/u5L2vbeahZByiAYCUEgQCtAR9
 WJ7qjiSOuHm1/8ScnQyJ+Bw2Zc4JMv/vlyCcOh8GZ7P9cjX/yac/nKkPGosdUe2oFoRn
 RsevE/wEzmfkv2mVgTkQujmdCdhRmDHQFs6KKJ0bW6Kt6FGhykWWD1lSGaOw5gfLhbs3
 2mY9ZsEUYbUQ6nmk0aHhNny/OAIvO0Ut4847lU3UF4q7yVi6jEGuwFVutMdZa8Texn0p
 nGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tJm/yeW80cQWpl+rJ31NlK8xX8dbaBfxOxkZ+dUOvEQ=;
 fh=MvhRrqu2i8mxDRH1wr4tXkxOt0dA0cq3cs9EEHZHF+8=;
 b=Mo74Yg5OmvuO2Vs9KhCIPKy4MRlaNy/C2x6lV+JGmyU8a/j1kAX3Qmz3riLjPuSNzv
 JgVLQaK43a7CJsThzsL0QZ0TefB9+aBdxARZprb5SxVnn24WRGHFsyHp1ZZrO2sj2jPO
 DRNisSBaCchiIP701tzuOhqfAb6sa0vb4+HBXgkCQgg+k3zayg6wo3bcbUPM73UgrGjI
 PzUCtTohosmndnNC4k4grNQj31grq7CdiKaCDZvU1/MbhHGDbgyRaordhG1JmrwbGtrg
 JnNyElrVVyZb5CnbZIFWcUcUsT6NhFwq+goizBXgOgBJfw3Z88wic8pxlMqyOZRGpOal
 h5JA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1795459763; x=1796064563; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tJm/yeW80cQWpl+rJ31NlK8xX8dbaBfxOxkZ+dUOvEQ=;
 b=A6uSgjvlRykubiS/57ysMEzrAKKDzvh1NBTmsksFqaq7+QqzUFeLDYlaC6C6xtFou5
 ae4lcqWeleBfj3PYUSmVfaOF7NQjQlOOVIZV17RYLhPzeLsOpIgATjmep1qE/FpxkVXg
 gfEhJBXVmrJ22KgIfRHdSLmT7esexr6m5o/WEI7BXW648xP1n+CUCb5ARbju7remZGPJ
 e4zoPZwkpic9TKCtryt7o7qAtQgui30QlmqgDiRgcd9d43dEHMXcX7Yyp1W9m9Ki458S
 wmUU1Edoy8QIUydcZiqd5UVYo8Nb3M86EqKDeLgk26kOAMOt3KjTAEtTgrnTKJ8fK8R7
 Qa3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795459763; x=1796064563;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tJm/yeW80cQWpl+rJ31NlK8xX8dbaBfxOxkZ+dUOvEQ=;
 b=GFmwnp0ofJRDHhrLDzSysmDx9tk4z9piIKLhzzRtChKOKJ5x/kntyE0EmPeXez+h4a
 J9Fp7J/pdm4lIEsBKv3wKR9alhjS9PYB3l/sKyWRMoORNHVuFSNa/9j7bGw3qO5impI6
 CaPdVKW6+WTLdOyr07/abKcTv98xwpzkf/E02W1JrQO/MwcAcI64YsmT5Q1fcdQOddiu
 nINNESMB9+agE6D4q5JZcHwRg24cbVpAGy5P2t4OAS9bn1hO9aaxsumV0TLpgoF7II54
 UamD95JXfYqIk+n1IuEasoLowVy20mNKSQ9Zjix86cDyokCRBiFoFOQatKREvfVc+TtY
 SSWA==
X-Gm-Message-State: APuU4Z9Q8DIJmVmnyqo8M8lVGk28lLKsFw12cC8Pd8pvjYqJv1L4rYP3
 7EtVdbnmTPt1NCnBtDqfG8X77YwWRi6q2y7HMyMrzFcfhHs+CeTahYvmPgqJEf0tpKd6XLQs1UB
 ZXX+hRMX3uo4/PO3PbThCiSuUrA3x2j44JhM4HZ9bkg==
X-Gm-Gg: AZFdTZcSOQdrBAFcb9tZPQOOmIwUmxKqiO6cTs5GSL43T3P7djCNmpS5hsvq4niBps6
 ALb7FanJ7Sr6+MzR1QW+TVP2bpHq4vX7Ebc2weNZBqLFHvMc5VM2AhFxMHj96oucV4f/L+GjE07
 X9BrNg4IH1Hs6lkxwontnkuK8+otPuTh4IHRaaA4U9MAjaeFtUs4hIh6k0jlBVqlcRAIpTGDVJj
 uvUmYPwuKNFybwpQos03pDEmYWLPiteJs4ILijL/IL4rxPI/OkJGoMkHk9iSRVovHw66gzBszEC
 xoNFQIN72KomDqZqWxEvaaNw7eLBgD4nbiOdD9wvaoW4wiYUNUEtUfd9vUpOy9hBD+EDzrmVEWn
 Jsk8P6jasTQPoAvwMF+BX6+EObrLA7lh/t9Ek1Wqbr3pPTvHi0vHzkeql7bVveVA9NZIaNpt8rQ
 6P5eQEyLHAc+Ylzw==
X-Received: by 2002:a17:907:932:b0:c51:8bf:9f22 with SMTP id
 a640c23a62f3a-c513a5c0549mr910894866b.2.1795459762996; Mon, 23 Nov 2026
 10:49:22 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118-zl-master-v1-0-129f85e0f887@linux.alibaba.com>
 <20261118-zl-master-v1-1-129f85e0f887@linux.alibaba.com>
In-Reply-To: <20261118-zl-master-v1-1-129f85e0f887@linux.alibaba.com>
From: Philipp Tomsich <philipp.tomsich@vrull.eu>
Date: Mon, 23 Nov 2026 19:49:11 +0100
X-Gm-Features: Aa3M54o-INz7dwpmjkFdIBYUDVeUs62n-0LCc8hpPoHaR8NShcyJR7cjP2Anhnk
Message-ID: <CAAeLtUDm7zA3Y_c2QoBKL+oNGhbzm-B5Xg9jy+oyqPbjVuM6JA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/8] disas/riscv: Reject incomplete instruction reads
To: TANG Tiancheng <lyndra@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philipp.tomsich@vrull.eu; helo=mail-ej1-x630.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 at 10:03, TANG Tiancheng <lyndra@linux.alibaba.com> wrote:
>
> If a later parcel read fails, print_insn_riscv() decodes the available
> bits with the missing bits left as zero. A truncated instruction can
> therefore be displayed as a complete, unrelated instruction.
>
> Report every failed required read at its actual address and return -1.
> If the first 2-byte read fails, return -1 instead of the error code from
> read_memory_func(). The disassembly loops would otherwise treat the
> positive error code as an instruction length.
>
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>

Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>


> ---
>  disas/riscv.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/disas/riscv.c b/disas/riscv.c
> index ca0d6e90b37321e8c2b7ec07f3ae51f0797585cc..eb4851b4cd4b14a43cc6592bd5011c6df53ec219 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -3510,12 +3510,8 @@ print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_isa isa)
>      for (n = 0; n < len; n += 2) {
>          status = (*info->read_memory_func)(memaddr + n, packet, 2, info);
>          if (status != 0) {
> -            /* Don't fail just because we fell off the end.  */
> -            if (n > 0) {
> -                break;
> -            }
> -            (*info->memory_error_func)(status, memaddr, info);
> -            return status;
> +            (*info->memory_error_func)(status, memaddr + n, info);
> +            return -1;
>          }
>          inst |= ((rv_inst) bfd_getl16(packet)) << (8 * n);
>          if (n == 0) {
>
> --
> 2.43.0
>
>

