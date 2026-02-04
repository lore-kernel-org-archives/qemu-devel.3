Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B99EE9D40D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 16:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vng1s-0007XA-JU; Wed, 04 Feb 2026 11:47:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vng1T-0007C8-HK
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:38 -0500
Received: from mail-dl1-x1243.google.com ([2607:f8b0:4864:20::1243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vng1Q-0004cB-OJ
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:35 -0500
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-124899ee9d3so60032c88.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 08:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770223591; x=1770828391; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tSh4x5BDWbLmS0zJrqq51vM7kRh8SkpBFxAAmergJ/Y=;
 b=ShFq3nIrtsW4iLpQ0UVVh+Mlrp6ve9uToHa3rTBggsUGcamHV8h3OFVuIQwWfJYH+x
 bFVul+qcwmP7o3r2JGjRncLmoaIHhK4Y1/HueJmWRd/XIzoAda+LulXBpsI2j8/srvFm
 fBU0PTByCa/FYhkn1baIH0HJKbHGtd1Rf91cs3IApXS8HdHFwwLnoyf3Xwtbv7RxreRo
 teeRJHI71J5vU2KvB5O2cYgIzZupfdN14gbHJqWFjMvld6LHOH5kyCbgDReD8QIS4NI4
 wwpGIWn1AZ2TfypYIoempVzU7mJCIndnZOZDEDN+kediYVoabTks2+voJ3af2vGdndp6
 +QlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770223591; x=1770828391;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tSh4x5BDWbLmS0zJrqq51vM7kRh8SkpBFxAAmergJ/Y=;
 b=mz3jxnG1JL4S7A42ki3Ak8CRHIOx6X8uAkS8znIc15lBTbdasqHaYb7GH4uQkQCidD
 mWOjqTkleEnA4o1W+fy6HR+MqOt/d52piAhdOx8nIVC9pzmazCuyO70sAd3t5ZMZu+Wo
 ISFdgYjwuteWl1NFMRg6xnKztUmY+i79IHVNQvRU3lLdYJyGk/Aokh9RROELFjFRwWlA
 0GcUMM6wl76RnOg32QI2t0lBBF3fY+ibzPC4aZEx44tMik7LnkKL/F485bczPwNRogQc
 yKqUBTGGTfgDtX5eUqdEjXL76DO+2/60azM8hBVpGbvx08nyalznr/SwIjsTxGWuSrSo
 IjBA==
X-Gm-Message-State: AOJu0YxP5GaxxI7/a3p4ZsmvOxDpl6Y8nJiNw3d2md+EodDUJXOb2jvd
 6oRfRlGKTjy/hbRHRDwPWSXEMhpsCGa1m4xz3dlcV4Fo6B/odfonYhBMmPFpk9RoS+huHQ==
X-Gm-Gg: AZuq6aJDzHR0lqhXUm2uVh+cBN/ADztIcuvDm7wIanrIgkAt3eGjcMuXBlmz7rUk7XJ
 2Lm6HpwTnC6IIHJ0e0nvZhV1C2rmeSDIvVK2bYIB4EennC1n02S5ffW0fwxp/Dk1iBjG2MPdivM
 DbdbQnnIA+OTvPkQG2ZZ7GF9RoBhqviI7CEgghFITy5l2PxOLqI0kRA4V30HIbcWlmU3ExOFe/H
 xTeTj2YALl/kdED9yGAARJcEGfNe8Xu/QC6Q8T5/zpMv4xb2mFmWTe87Sz8uMBVfQrrdxd098CU
 PhQ/V5DgnMR4dTGWHZstkBjJLR3HDwISrOUrBlhotJDoPg9Zc7rX+cUSq5PP7B5KiT9GN6YxD5Z
 +B1q9fUfBmmDCLm8P5PD7CFP8dJQSoufs/8zQdvSkNG8FyerPL7c6t5Fw5DT8TVTYRc2+lcYn/G
 LzbAHXAohiwJYsIc3M6boQlOCE78Y/ZKo2ic6cZeoH+kONZGoAphRhrMMjT0cektHcDTR6/vk+r
 Z6mWe211QIicay5LZaGnfhti0xebw==
X-Received: by 2002:a05:7022:7a5:b0:11d:fd41:62c8 with SMTP id
 a92af1059eb24-126fc09f465mr23406c88.13.1770223590460; 
 Wed, 04 Feb 2026 08:46:30 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-126f503e5aasm2239377c88.14.2026.02.04.08.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 08:46:30 -0800 (PST)
Date: Thu, 5 Feb 2026 00:46:16 +0800
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
Message-ID: <aYN3ccG6_vsO1lgU@ZEVORN-PC.localdomain>
References: <20260204051756.667397-1-max.chou@sifive.com>
 <20260204051756.667397-20-max.chou@sifive.com>
 <aYN1Z3YY45q76GcD@ZEVORN-PC.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYN1Z3YY45q76GcD@ZEVORN-PC.localdomain>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1243;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1243.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Feb 05, 2026 at 12:44:02AM +0800, Chao Liu wrote:
> On Wed, Feb 04, 2026 at 01:17:55PM +0800, Max Chou wrote:
> > This patch adds support to disassemble Zvfofp4min instructions.
> > 
> > Signed-off-by: Max Chou <max.chou@sifive.com>
> > ---
> >  disas/riscv.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/disas/riscv.c b/disas/riscv.c
> > index daffe9917f..9abf86f2d7 100644
> > --- a/disas/riscv.c
> > +++ b/disas/riscv.c
> > @@ -987,6 +987,7 @@ typedef enum {
> >      rv_op_vfncvtbf16_sat_f_f_w = 956,
> >      rv_op_vfncvt_f_f_q = 957,
> >      rv_op_vfncvt_sat_f_f_q = 958,
> > +    rv_op_vfext_vf2 = 959,
> >  } rv_op;
> >  
> >  /* register names */
> > @@ -2260,6 +2261,7 @@ const rv_opcode_data rvi_opcode_data[] = {
> >      { "vfncvtbf16.sat.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
> >      { "vfncvt.f.f.q", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
> >      { "vfncvt.sat.f.f.q", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
> > +    { "vfext.vf2", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
> >  };
> >  
> >  /* CSR names */
> > @@ -3715,6 +3717,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
> >                      case 12: op = rv_op_vclz_v; break;
> >                      case 13: op = rv_op_vctz_v; break;
> >                      case 14: op = rv_op_vcpop_v; break;
> > +                    case 22: op = rv_op_vfext_vf2; break;
> checkpatch reports:
> ERROR: trailing statements should be on next line
> 
> But this should be on next line" can be ignored (Patch 9 too). The existing disas/riscv.c file
Correction: This is similar to the case in Patch 14. We can keep the current code style.

Thanks,
Chao
> consistently uses the single-line format:
>        case X: op = rv_op_xxx; break;
> 
> Maintaining consistency with the existing file style takes precedence here.
> 
> Other, LGTM.
> 
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> 
> Thanks,
> Chao
> >                      }
> >                      break;
> >                  case 20:
> > -- 
> > 2.52.0
> > 
> > 

