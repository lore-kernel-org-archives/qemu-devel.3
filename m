Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9F2C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 15:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wewRL-00006Q-EX; Wed, 01 Jul 2026 11:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wewRG-0008WN-4s
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 11:01:23 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wewRD-0003cH-De
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 11:01:20 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493c2c0b9a8so4381255e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 08:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782918076; x=1783522876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6wlGUow5Clkw3N1NX2jCzgdjkfHEhMdIreodGH/aeEY=;
 b=LHZbfNUy8fRZ3AR2n/zTKHCJpG20RYS96gLF87zMEKUw7WRbvubNV4I1+bBocgK7m1
 M4F9xvBL3L1hxd+jjpufNnFiv/L1oP9UyJwjv1dAoVVgq7QjoqvOulyG3OUcZD3/LKZi
 eQMLLPyqQk9tsYJBVPTXPZlxdBCl9pPkdUoUI/Hp7Z1nMBirWdDQigeqYGvY7kJlOq9u
 Z2fEc7WtB69DgO4vA7w231jr/hCnt7ScgAqpW0+Iga0YIovQIzc7h34ftN5xXoYOwE7B
 0qtyVsCP0RQxbA+Jk3PEcs8pnvucxVAz49j2wveAYAVCIrsky14lT/G6x11vRcnzbvSx
 MdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782918076; x=1783522876;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6wlGUow5Clkw3N1NX2jCzgdjkfHEhMdIreodGH/aeEY=;
 b=K9S42FthR1KCNTNB7MBaPfwKjpAh2HLVdhhL9k2o8emGKcnhUB0bkHA56rVmF4dhrA
 ifPmOjsZwcIDOPPmWezazuhUDqc3DPaPdvkyvCgiC+Lulak8wfuvlbWJOqh3sGM0LTSJ
 6WJA6rxH3UevEmuhxB7RbxuulequxEcx+6oIkcKler0Abi8Po+eHmupM5Fkj3REXOeQK
 ocSk5olEggDEr3yREk3LbvDSZOQ6PLeGEMB5z/5MCY8NscxS80oIMDvoqxwInWSF+5PB
 +WusYnti2GsYtUSKKWv/hZP1nCShUGN3Y0ob1myw6jOV7bOWqpcQGXuK20QlEU4WJGoU
 hoFQ==
X-Gm-Message-State: AOJu0YzRdp7cCqNkToos02Mq+BRMfjkoNGNtYpHEb246Ke/CfWwS0Orc
 9cyqXyx+QPbwU7g3N41WW39RvfU5BUeZHv+thAMgcGns5HtHnAh7fKveXRFru2DEB4U=
X-Gm-Gg: AfdE7cm2Mmrou4I4xwSjElJ8XrXSUpathiqVE/IQrfaYY8J6CCotbKdnoBSTUoWo/C2
 Vf7Qr1ONFzqcb3NGnzuLVlmIXECMlrnXAQP32Yi6d6kYv0a56GFDbIWfLAeGiFN8PeJEHOmd3sw
 49QKKaiAzwbxcN9O69jq6QOElW2eJQly/eSjbPvKiyowa/aGKTflueAkqMkjoVL05FE4nQHmK2M
 0N6oXil/oSDE+x/NXYI2bMXRfEpJtRdKnUeVqmm2IOMrOkds6oxi5JeD3OJFDWtu9DcPu7H4F0x
 ZMpBFab26VzPY4CtxZMbQ6sH9vz6ECu84OHptQ3/GtcmGirwrcNewHlM5CGSM5nwkA+lHSU8xvX
 wm8xgR78rzsL8Jy5zh8LQEORE9pTeGjaRlrH2/RUSF5KY4Xhhgx76vA2M2ZqFmDOVgKkSaVoJYi
 G1pNJ3N4zsDDit
X-Received: by 2002:a05:600c:c046:b0:493:a8eb:5145 with SMTP id
 5b1f17b1804b1-493c3cd4ac7mr11618175e9.4.1782918076251; 
 Wed, 01 Jul 2026 08:01:16 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c0e92687sm46634795e9.0.2026.07.01.08.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 08:01:15 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 398875F889;
 Wed, 01 Jul 2026 16:01:14 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: TANG Tiancheng <lyndra@linux.alibaba.com>
Cc: qemu-devel@nongnu.org,  Christoph Muellner
 <christoph.muellner@vrull.eu>,  LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,  Alistair Francis
 <Alistair.Francis@wdc.com>,  Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  qemu-riscv@nongnu.org
Subject: Re: [PATCH v3 2/5] disas/riscv: Fix 6-bit immediate extraction
In-Reply-To: <20260701-b4-disas-xthead-fix-riscv-next-v3-2-fc4f5f1b6c15@linux.alibaba.com>
 (TANG Tiancheng's message of "Wed, 01 Jul 2026 22:32:10 +0800")
References: <20260701-b4-disas-xthead-fix-riscv-next-v3-0-fc4f5f1b6c15@linux.alibaba.com>
 <20260701-b4-disas-xthead-fix-riscv-next-v3-2-fc4f5f1b6c15@linux.alibaba.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Wed, 01 Jul 2026 16:01:14 +0100
Message-ID: <87wlveu539.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

TANG Tiancheng <lyndra@linux.alibaba.com> writes:

> rv_codec_r2_imm6 is used for XThead instructions whose 6-bit
> immediate field is encoded in bits 25:20. The old expression
> left-shifted by 38 and then right-shifted by 60, so it kept only
> bits 25:22.
>
> Shift right by 58 instead, keeping the existing extraction style while
> retaining the full bits 25:20 field. This fixes the immediate printed
> for th.srri and th.tst.
>
> Fixes: 318df7238b9f ("disas/riscv: Add support for XThead* instructions")
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>  disas/riscv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 7f1b26277378c225c963d8f435cc7a2fc6e4a0b8..400a57083f90be18ccd124157=
97bce0df974784b 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -4546,7 +4546,7 @@ static uint32_t operand_zcmp_rlist(rv_inst inst)
>=20=20
>  static uint32_t operand_imm6(rv_inst inst)
>  {
> -    return (inst << 38) >> 60;
> +    return (inst << 38) >> 58;

We do have extract32/64 helpers to avoid these manual bit-fiddling.

>  }
>=20=20
>  static uint32_t operand_imm2(rv_inst inst)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

