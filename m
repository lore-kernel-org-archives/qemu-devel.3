Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51254C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzCiv-0005dd-5U; Wed, 26 Aug 2026 08:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olegendo1024@gmail.com>)
 id 1wzCis-0005dS-VQ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 08:27:18 -0400
Received: from mail-pj2-x05.google.com ([2607:f8b0:4864:39::5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <olegendo1024@gmail.com>)
 id 1wzCir-0001hv-1T
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 08:27:18 -0400
Received: by mail-pj2-x05.google.com with SMTP id
 98e67ed59e1d1-39662b5cde7so649202a91.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 05:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787747235; x=1788352035; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZTMBg5gBklmc9TiQZ3xYi9Z0DMSWwaXoKqLDAXnBI0s=;
 b=DL8KmvyeNwV1jbPYjHHhSsk70Bs9aDBxbhMna9wugqYqMF54YWjekp5pNOEbWEsKD+
 VyHZkAjoDJQxsiOps2k9KqBSTyPhWS9dHTFTq/yVIgYjgIzSGeNqlk2a3+tZ//vBwfjn
 AeWRUDMb82wmsFxmV/mUX0wRryc0WSOBEONdM9W92auLF91a1chDcVGjJH60qkr4OxSd
 IqbtV8QCMR5vEI8SF7ObYzSZjYdj2r7C1Yixvma3ghnC8VGVhE3ftJ6sVnPhwD/FMoRI
 FlySN1rDPJ8NjWUZf2TNG9mTkseQCaF1d9I1uQNJ824REta0LiAVekNunkgRJXzHs2sk
 aHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787747235; x=1788352035;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZTMBg5gBklmc9TiQZ3xYi9Z0DMSWwaXoKqLDAXnBI0s=;
 b=aRiqtdkWEtAYMemZQWAV9jtPRfHKKLGJp1YaJz3TtBEcxrwLC8oXiGJGN1uW06zebE
 uSPHya8c0M3bwe/7HmU9X1yuqjnloYuyJRJ+e1LM0+urfBVg/wXOyWxl0UaMvNMFS/iF
 tF0E5jh0BGEtj0j9kenFwGuK6eB6TsraT+kchZ+K+3VBiWDCGmYArxiztWgH9eVZZa7E
 NpZ+mdRTBhPP9lhDA7esSFdVLFc6lS0v6qDp++YKqmvr5iXiMlf3wPNpQCAM0+ltLS+4
 cZwdOIg958gKzA30JJBqLLFJgg0dZrecveUXi/UAo/HsY5iz40cc4no5WBczorzBc7/E
 ZNcw==
X-Gm-Message-State: AFuF++l7MPS5COp040UHDO7fj5Zoq2zrIEyX1B9TTcKD6RWVKjmLGIk8
 k8ZK1K1EiKE7N0t0ovGOBZnGEBoVJRrcaCSL/XECP5CZMtBImu/b1zHW
X-Gm-Gg: AR+sD13KWbuSTQ7NIeGiVX3+k5XavkIP6ebF34vS8lN5ppdPLASNObt080vB5hkhmLm
 mrEkZHNKm5zOfoXAoFHDfQDyCjM4zKmzOho335dB5l6yNvHxrCRsZYk5s0ENRhN8Z3xgOom4gmA
 n7mb4ivJZQqdxRSDnNj0EnK92H3w8+KC+yFzzrlvFz6QmasPrGOSzo2xkRAZi/j0GUcPbBxr8IP
 2Lm/wFGaJ5ISCLWxVxyWyRhunGWUXIVRlXZFjUvuDVmVMLw5WcLGB2PeFoxQE2nDsQ+IAsY1gSW
 sfLAxv81WyMTul1dT1JSYpX18x0HaGqhtCExi0MW9GV69KEfxv/+CAiJNwDkts/Znuh50xqZmS3
 v/HiAM1GPDOZprTJy3phwvhyqX/T0P/3Mj8zPO1SnESSWl1KLJ+bl5t+kSr2neExA6HmTjURqFe
 UHWTqY31NKUbKZH2A+E9Vw4AN5EObOaRocvfJW8uDOpi9igT9uy3w/tEDi48IBd3EbcZ39LdAhZ
 QbvmjbZzzcnHuhyueTx
X-Received: by 2002:a17:90a:d2cb:b0:36a:5d1f:7b6 with SMTP id
 98e67ed59e1d1-3966d36df78mr14443248a91.2.1787747235314; 
 Wed, 26 Aug 2026 05:27:15 -0700 (PDT)
Received: from localhost.localdomain ([2407:c800:3620:e800:7910:9280:8105:5a2])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645d69065sm8498464a91.13.2026.08.26.05.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 05:27:14 -0700 (PDT)
Message-ID: <1b76d526ad21616241b433a254653977e009a2e3.camel@gmail.com>
Subject: Re: [PATCH][SH] Fix mac.w / mac.l insn
From: Oleg Endo <olegendo1024@gmail.com>
To: yoshinori.sato@nifty.com
Cc: qemu-devel@nongnu.org, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>
Date: Wed, 26 Aug 2026 21:27:12 +0900
In-Reply-To: <87jypdqf6f.wl-yoshinori.sato@nifty.com>
References: <4a86e81ffa5e392efa069463cd21457374915b93.camel@gmail.com>
 <87jypdqf6f.wl-yoshinori.sato@nifty.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:39::5;
 envelope-from=olegendo1024@gmail.com; helo=mail-pj2-x05.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, 2026-08-26 at 20:44 +0900, yoshinori.sato@nifty.com wrote:
>=20
> It is true that the current behavior differs from the pseudocode in the m=
anual.
> Wouldn't it be simpler to just generate a TCG that matches the pseudocode=
?
> I'm sorry, I haven't actually tested this change yet.
>=20
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index e503a97b22..64fe2cd31d 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -801,13 +801,13 @@ static void _decode_opc(DisasContext * ctx)
>          {
>              TCGv arg0, arg1;
>              arg0 =3D tcg_temp_new();
> -            tcg_gen_qemu_ld_i32(arg0, REG(B7_4), ctx->memidx,
> -                                MO_TESL | MO_ALIGN);
> -            tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 4);
>              arg1 =3D tcg_temp_new();
>              tcg_gen_qemu_ld_i32(arg1, REG(B11_8), ctx->memidx,
>                                  MO_TESL | MO_ALIGN);
>              tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
> +            tcg_gen_qemu_ld_i32(arg0, REG(B7_4), ctx->memidx,
> +                                MO_TESL | MO_ALIGN);
> +            tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 4);
>              gen_helper_macl(tcg_env, arg0, arg1);
>          }
>          return;
> @@ -815,13 +815,13 @@ static void _decode_opc(DisasContext * ctx)
>          {
>              TCGv arg0, arg1;
>              arg0 =3D tcg_temp_new();
> -            tcg_gen_qemu_ld_i32(arg0, REG(B7_4), ctx->memidx,
> -                                MO_TESW | MO_ALIGN);
> -            tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 2);
>              arg1 =3D tcg_temp_new();
>              tcg_gen_qemu_ld_i32(arg1, REG(B11_8), ctx->memidx,
>                                  MO_TESW | MO_ALIGN);
>              tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 2);
> +            tcg_gen_qemu_ld_i32(arg0, REG(B7_4), ctx->memidx,
> +                                MO_TESW | MO_ALIGN);
> +            tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 2);
>              gen_helper_macw(tcg_env, arg0, arg1);
>          }
>          return;
>=20
>=20

Thanks, I think you're right.  I'll have another look and report back in a
few days.

Best regards,
Oleg Endo

