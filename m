Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B906C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 00:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEHvd-0005Pb-Jq; Mon, 03 Jun 2024 20:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEHvc-0005Na-1i; Mon, 03 Jun 2024 20:21:28 -0400
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEHvY-0007Af-QI; Mon, 03 Jun 2024 20:21:27 -0400
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-48bf6ab0838so36908137.1; 
 Mon, 03 Jun 2024 17:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717460483; x=1718065283; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWaIlcKaZCeNCXTohAw9RJ/RUwG112CVVVSPBMxrlXs=;
 b=cmRavhFrwegpWTuy3AVjzOwnVnxPrb6sfFRXOCpUg1SjCiunqAadj8wzSM1Io2f7U8
 UEcT8Iqzp/GPj9XuYX2SuGxgsgyWlfIeJSchmGllYXIIjTTR3DTtHFOI6qLMFzq2j7xE
 RlMRJIJA+V5ZNh5UsmO6rG1cW990W+L3Gt7yw8v+q++ILmoXcjjt1faYj2EAGx6dB/GE
 PDx3ezpjCTXRAqBsvWYp13SunMZNA3Oi+hues1P9EbkIqTogRsv7GHmwQplThcuOeOMx
 yhlOWKSmMqQdylp4ry1A8G5hcLoMxn1Myeol8t8tZGfSoU778XAWU7OIU5TO8PzfUMFS
 n37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717460483; x=1718065283;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AWaIlcKaZCeNCXTohAw9RJ/RUwG112CVVVSPBMxrlXs=;
 b=fUyXkpqPvGl25R2ik1foBUH5/qACxVHn2ylGfsw79EeMUfes4L7lZtNZUyXtbQRkuY
 eSOJvFKz/dBaD4B1S0DmPpH4ShWePFgPCmfbO+AY47kBPvbFrigbkv5mj+uPGCNtlcuR
 xpOlCoNk1HzKy/eEPgQeZdxFg61bD/vBHY8JjhCZiF27ev59izPrFMOnhXl3SHmgMiJN
 dukiCiBPQ7/fbwspoIHNlfGPvekSyFPSwdRn+VQ2KrR/WG7d5u8uuMx0vkYQdUZw46Nx
 ej+VU8dhh2z1LII9DkosMzJQhEEYJp7EQYw1J5kSAP/m4f7uydlcSx93itTc5f/Rc4MF
 9BAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX+VhbCPdlo85DBc1B/+1oZ3hfppj4dORIQT1QfBkMLP87RKRbvZhDQv5N1WnBL26wiwJJCYNCa2OmHFyIM0xGhAsX378=
X-Gm-Message-State: AOJu0YwQ8fknOouxee8Ib9PmsaKgaqP3G5/oVzlFDfeqas44HohjVpLB
 Og9iBw/wvqidA2PA6g2XPb7qw5ykolzmrHRpHQBLRP5QM13rkNh+dZ+HGEVk8FCmRtH4qZw21VS
 HaknokcPNWU1bllpT50gDV+LieNQ=
X-Google-Smtp-Source: AGHT+IGNR7MlsqegceTdgumsBVAVSy9Owu9sozt9BkqvVsSPMYtOoR6f4MRHrCuskBXVr9SbtqjSPjWLYnVudWbHFac=
X-Received: by 2002:a05:6102:c3:b0:48b:bc7f:75f1 with SMTP id
 ada2fe7eead31-48bc2124578mr10304441137.9.1717460482723; Mon, 03 Jun 2024
 17:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240419110514.69697-1-philmd@linaro.org>
 <fcbe4473-b460-4eae-ab33-e6e1ed723878@linaro.org>
In-Reply-To: <fcbe4473-b460-4eae-ab33-e6e1ed723878@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 10:20:56 +1000
Message-ID: <CAKmqyKMefPOn3Wq8DJpH-85zO7+7DhLtEGymRvstQj4TjPGewA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Use get_address() to get address with
 Zicbom extensions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bin.meng@windriver.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <cmuellner@linux.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@rivosinc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Zhiwei Jiang <jiangzw@tecorigin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2e;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2e.google.com
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

On Wed, May 29, 2024 at 2:56=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> ping?

I originally missed this patch somehow and it has then been fixed
separately as part of
https://patchew.org/QEMU/20240514023910.301766-1-alistair.francis@wdc.com/

Alistair

>
> On 19/4/24 13:05, Philippe Mathieu-Daud=C3=A9 wrote:
> > We need to use get_address() to get an address from cpu_gpr[],
> > since $zero is "special" (NULL).
> >
> > Fixes: e05da09b7c ("target/riscv: implement Zicbom extension")
> > Reported-by: Zhiwei Jiang (=E5=A7=9C=E6=99=BA=E4=BC=9F) <jiangzw@tecori=
gin.com>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >   target/riscv/insn_trans/trans_rvzicbo.c.inc | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/target/riscv/insn_trans/trans_rvzicbo.c.inc b/target/riscv=
/insn_trans/trans_rvzicbo.c.inc
> > index d5d7095903..6f6b29598d 100644
> > --- a/target/riscv/insn_trans/trans_rvzicbo.c.inc
> > +++ b/target/riscv/insn_trans/trans_rvzicbo.c.inc
> > @@ -31,27 +31,27 @@
> >   static bool trans_cbo_clean(DisasContext *ctx, arg_cbo_clean *a)
> >   {
> >       REQUIRE_ZICBOM(ctx);
> > -    gen_helper_cbo_clean_flush(tcg_env, cpu_gpr[a->rs1]);
> > +    gen_helper_cbo_clean_flush(tcg_env, get_address(ctx, a->rs1, 0));
> >       return true;
> >   }
> >
> >   static bool trans_cbo_flush(DisasContext *ctx, arg_cbo_flush *a)
> >   {
> >       REQUIRE_ZICBOM(ctx);
> > -    gen_helper_cbo_clean_flush(tcg_env, cpu_gpr[a->rs1]);
> > +    gen_helper_cbo_clean_flush(tcg_env, get_address(ctx, a->rs1, 0));
> >       return true;
> >   }
> >
> >   static bool trans_cbo_inval(DisasContext *ctx, arg_cbo_inval *a)
> >   {
> >       REQUIRE_ZICBOM(ctx);
> > -    gen_helper_cbo_inval(tcg_env, cpu_gpr[a->rs1]);
> > +    gen_helper_cbo_inval(tcg_env, get_address(ctx, a->rs1, 0));
> >       return true;
> >   }
> >
> >   static bool trans_cbo_zero(DisasContext *ctx, arg_cbo_zero *a)
> >   {
> >       REQUIRE_ZICBOZ(ctx);
> > -    gen_helper_cbo_zero(tcg_env, cpu_gpr[a->rs1]);
> > +    gen_helper_cbo_zero(tcg_env, get_address(ctx, a->rs1, 0));
> >       return true;
> >   }
>
>

