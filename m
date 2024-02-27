Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7A5C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 06:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reqsr-0000fT-3K; Tue, 27 Feb 2024 01:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1reqsp-0000f2-Dp; Tue, 27 Feb 2024 01:24:07 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1reqsn-0004TS-TW; Tue, 27 Feb 2024 01:24:07 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-21433afcc53so2123216fac.3; 
 Mon, 26 Feb 2024 22:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709015044; x=1709619844; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OPBVEGsM3IsH6oybEfBrUU6SIUXoLIPExiAMXF9Mnoc=;
 b=G0MNjTTkWFPT3I4AgXRhdftl+QNpV8rCmofH6e3bn00I+VOC2cWFRQgiqOruKc4FRm
 5mNOETi6QIIF25VPv10Hs0I9skkEmnMhc7idBXZGfOcVdryBK9xjTT58pU+5igKMA736
 crixBeM8qWg2Lj9RocIgv26847gfYGCXseQc/6/mdkkJCzFIVCtdwS7YuIcYbxNyDVpr
 Rs2eP2QUuisxN8Z4YJGPpLBZnoEVRB1zDDIbf5lunOIkKDZrzkUffHFcoEpNm9aY6ryt
 Qsy8klWbzeZ2VMgdBYf7+oFSIWp9A4NboBGi30YeAuTIQKbqw5fRkDaaKgZ684jSYbv6
 Mm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709015044; x=1709619844;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OPBVEGsM3IsH6oybEfBrUU6SIUXoLIPExiAMXF9Mnoc=;
 b=WuBsAu9QGynwGk3bNNXz72ZPHcnieOp4hPlzorNRdiJIxToi0811ztz/YisDDh3fuw
 B9fa5imvlEpX6nc5TrnJA7px7peXej+4gKAR9ufIU/eIMLWXEQwUbbWsXm6dQJ4Dt3gC
 6ptgUKk5EBAjUN+SjXIYz/ht3/lMTG4kOKpYwLO/Rnq90zGqYmMJTsf3waoUApugp1Cd
 YCY+2mFwbSgmBbFKlDu2y6mZtx2c8wkMS2efLnHNcUwZnXszIUedjarLhIIltgzhSQMR
 xoRo3W8Hbfmgrc6Mlzm8sDhh9iYm7KD4bjNu5+2aWmrPDoX0zmJ9W+OlAi0X1M36oLtA
 3G9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuDRZdHs+ywK7nkNT+tBKyvuA6RQ3ghczE4K/TpkV5GA28nTdkBw8gSrN3rbBXxEPRMeuc9gBNo0ZSUyTQa3/DTF2NtF4ygctDdqsnrYmje//4w2+wzKpIU0s=
X-Gm-Message-State: AOJu0YwK68HmSXGvDBOuVT9zylDXij19a/Dboo4rhopl3aRxv19iW4hh
 9yyPMyNMwHW9Cqx+yz2m451IMgay69T9P1gAfW2QZVL5o7++QmNe
X-Google-Smtp-Source: AGHT+IFc0XFsQkR3mBvs8JS4yvyYEIvnCUkNZmdplurnRJFxqUm5pPN5A5YjxHijYS7oV8aRIU299g==
X-Received: by 2002:a05:6871:d10b:b0:220:23bd:daf5 with SMTP id
 pi11-20020a056871d10b00b0022023bddaf5mr3443331oac.13.1709015043874; 
 Mon, 26 Feb 2024 22:24:03 -0800 (PST)
Received: from localhost (110-175-163-154.tpgi.com.au. [110.175.163.154])
 by smtp.gmail.com with ESMTPSA id
 w16-20020aa79a10000000b006e4362d0d8csm5072501pfj.36.2024.02.26.22.24.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 22:24:03 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Feb 2024 16:23:59 +1000
Message-Id: <CZFN9QFWXWJS.3QUUL2OSEITNM@wheely>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>, <clg@kaod.org>
Subject: Re: [PATCH v6 3/9] target/ppc: Fix gen_sc to use correct nip
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <cover.1708601065.git.balaton@eik.bme.hu>
 <9bb0926a0e9f3b5c703fe0b4b6d21edd8eb79bdd.1708601065.git.balaton@eik.bme.hu>
In-Reply-To: <9bb0926a0e9f3b5c703fe0b4b6d21edd8eb79bdd.1708601065.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu Feb 22, 2024 at 9:33 PM AEST, BALATON Zoltan wrote:
> Most exceptions are raised with nip pointing to the faulting
> instruction but the sc instruction generating a syscall exception
> leaves nip pointing to next instruction. Fix gen_sc to not use
> gen_exception_err() which sets nip back but correctly set nip to
> pc_next so we don't have to patch this in the exception handlers.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Mixed feelings about this one still but I suppose I will add it
now you have the tracing corrected. Although one more thing:

> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 049f636927..6a43eda3b9 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4535,15 +4535,17 @@ static void gen_hrfid(DisasContext *ctx)
>  #endif
>  static void gen_sc(DisasContext *ctx)
>  {
> -    uint32_t lev;
> -
>      /*
>       * LEV is a 7-bit field, but the top 6 bits are treated as a reserve=
d
>       * field (i.e., ignored). ISA v3.1 changes that to 5 bits, but that =
is
>       * for Ultravisor which TCG does not support, so just ignore the top=
 6.
>       */
> -    lev =3D (ctx->opcode >> 5) & 0x1;
> -    gen_exception_err(ctx, POWERPC_SYSCALL, lev);
> +    uint32_t lev =3D (ctx->opcode >> 5) & 0x1;
> +
> +    gen_update_nip(ctx, ctx->base.pc_next);
> +    gen_helper_raise_exception_err(tcg_env, tcg_constant_i32(POWERPC_SYS=
CALL),
> +                                   tcg_constant_i32(lev));
> +    ctx->base.is_jmp =3D DISAS_NORETURN;
>  }
> =20
>  #if defined(TARGET_PPC64)

Can you share this code with gen_exception_err, by making
gen_exception_err_nip that takes the nip?

Thanks,
Nick

