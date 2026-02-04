Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A6CE9D40F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 16:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnfzE-0005Mx-Sl; Wed, 04 Feb 2026 11:44:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnfz9-0005JB-75
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:44:12 -0500
Received: from mail-dl1-x1242.google.com ([2607:f8b0:4864:20::1242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnfz7-0003E0-EC
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:44:10 -0500
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-1233bb90317so868949c88.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 08:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770223448; x=1770828248; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eysfJqTLZud+iBPAEDNeiaLRHLCXHhBIbn0GZlGU8P0=;
 b=NQKl2mBBqec/+P4baKN3m86ytEIv9cq5vRDBC143w1pbNV3fApjl2TGkRIY8Pl/60+
 cFVxQRaLSXeMjHdGYos4VwJUE/y+kerdt4wmKScx4kKfsozcmVJ99GSntl+OIGpSKpVX
 j6He1ul2Tn3gJULTDaxZxhrJmC/zK6BYdZAXlzfcY1v0bOnH4Ydw5Qt2Kq8Ndmu+Z65e
 CK6ZPuQLac0Girq1KA2oaaCTZdCfj3fm3ODLmBp33SyP5Kbm4vNTgO4lPKVS/tHeuT06
 B42zMijTvgSiNj/N8D2KXiqbVqaUaVzekr5uGGh/GHE1JYYcbCNU6oeNxo0JNlFO2z/A
 UT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770223448; x=1770828248;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eysfJqTLZud+iBPAEDNeiaLRHLCXHhBIbn0GZlGU8P0=;
 b=lRjlATGjubVHKbpvmNYFMv0D6fwp6x0vphhtBlcko5BldafyHUjrU5HWBnmd9USZO8
 0GhcnzONydbIXaxfSD+AqBuMwWQYYEJqZdIZFkjVNVjmLG7SpzirlyvVDZCo/OS6P2xl
 o9KwS6EXfubCnieQVOq/GLD2J3Xvc39QtdyJTBVT3iI5fpIa2o4jqHxIuyWDwd5qlAvO
 I9igemtiBGAic7nkpytgxKa9Fib1c4jADBrAVss5yHKSJGH2WRPoqBID0AM3hUAP3D1K
 7PU7+dHlsO9dvtmB0ueqz8cxmUY5oD4vJ6fSFtzUSXySxgVyle9BBjiAYpwcG6O8C8GD
 j1lg==
X-Gm-Message-State: AOJu0YyTFUcx6SdRfdR4kKYDklXGFS422Rc++gvmxWsK+GeEWyGVgsou
 C6M6bbwPlpFBF0uutc8x+4NTSTEpdIXwC6S3lxPVa3VTWrHCFmOmpux7
X-Gm-Gg: AZuq6aLrjrfnnc6wstWhvpfbDQUukYzQU1PCQOA/pwUXoEEo05Oe//wGdozuoDHyrsE
 EVr5eQkXsP55xeXxr4w071M/5t6qnbqJDsZ9zujtIlN9e6P4sTfQzU5q80Br75MVeI9Yqmu0tq0
 1mfWWDaS65ETrJ2yPxHAywVs9fTuLHus7EaQRX230zPClsdFcnSBqCmWnn3cZ+1qkTUiIRlyvsH
 FQD16uZUVfVD0A48BgPNwMsFoaVlGCqbkI9Ke3+nYxjXx5H1Adgjym0dXbMCpJYUJa79HpghHQ1
 g7tNWkQxxl6zwSy9QGAIrBW/b+thK/xOYbk6+0kC44Wl8tK9kI2OIUF1jGO4+/0WlZARzjvboWs
 /hiVY7o9unMrlWxH6jsT5/meV0FIXHrqh0E2ZiiKyFdcEe3gykqpKwij1YnatP7CkCIkC2hZTro
 355NMm/LjrgseK0n2V/uD52ctDuzmwUx7AOL3EUQJrWbC1eNY4B9OG3VOT3W4mK1JG0vLAO6MDM
 mFlvWQM7Op7dcyyLnBzpevNJ3dRVQ==
X-Received: by 2002:a05:7022:920:b0:123:3301:a718 with SMTP id
 a92af1059eb24-126fc07b912mr22756c88.1.1770223447801; 
 Wed, 04 Feb 2026 08:44:07 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b832fc5045sm1698261eec.28.2026.02.04.08.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 08:44:07 -0800 (PST)
Date: Thu, 5 Feb 2026 00:43:53 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3 19/19] disas/riscv: Add support of Zvfofp4min extension
Message-ID: <aYN1Z3YY45q76GcD@ZEVORN-PC.localdomain>
References: <20260204051756.667397-1-max.chou@sifive.com>
 <20260204051756.667397-20-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204051756.667397-20-max.chou@sifive.com>
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

On Wed, Feb 04, 2026 at 01:17:55PM +0800, Max Chou wrote:
> This patch adds support to disassemble Zvfofp4min instructions.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  disas/riscv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/disas/riscv.c b/disas/riscv.c
> index daffe9917f..9abf86f2d7 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -987,6 +987,7 @@ typedef enum {
>      rv_op_vfncvtbf16_sat_f_f_w = 956,
>      rv_op_vfncvt_f_f_q = 957,
>      rv_op_vfncvt_sat_f_f_q = 958,
> +    rv_op_vfext_vf2 = 959,
>  } rv_op;
>  
>  /* register names */
> @@ -2260,6 +2261,7 @@ const rv_opcode_data rvi_opcode_data[] = {
>      { "vfncvtbf16.sat.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
>      { "vfncvt.f.f.q", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
>      { "vfncvt.sat.f.f.q", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
> +    { "vfext.vf2", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
>  };
>  
>  /* CSR names */
> @@ -3715,6 +3717,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                      case 12: op = rv_op_vclz_v; break;
>                      case 13: op = rv_op_vctz_v; break;
>                      case 14: op = rv_op_vcpop_v; break;
> +                    case 22: op = rv_op_vfext_vf2; break;
checkpatch reports:
ERROR: trailing statements should be on next line

But this should be on next line" can be ignored (Patch 9 too). The existing disas/riscv.c file
consistently uses the single-line format:
       case X: op = rv_op_xxx; break;

Maintaining consistency with the existing file style takes precedence here.

Other, LGTM.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
>                      }
>                      break;
>                  case 20:
> -- 
> 2.52.0
> 
> 

