Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEE4C71150
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 00:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjSe1-0007pf-3Z; Wed, 28 Aug 2024 20:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjSdx-0007WR-IP; Wed, 28 Aug 2024 20:04:05 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjSdv-00045k-TM; Wed, 28 Aug 2024 20:04:05 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-70f5cd2fa39so90123a34.0; 
 Wed, 28 Aug 2024 17:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724889842; x=1725494642; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zCh7mkhCQfA6+fFLCkJM0UjWN96Z9BGQGEbBT1vz11E=;
 b=G/c+6Kx2uKtv7jo38att9zdVT6+h24RWTCqMBLc0DeasAtIScniNLm1EuuGrIHYiXq
 5lqJua9BGuJu7e+MXRRkp1jEKEr3uPWpazWJ/ajP5v8ADIS8u6je1Ksev2KVx27j3C7G
 HYIYCJraHD1Tgk6YVCB5aW9jdM41EraAKiiN9n0g3xpz+OX0yUxJrTYmKOKa7DADdAod
 dPeKcFcq5+9zKJwWmKLVa2b8Udahz4aDi5TFFWWCpOXF5FzSjAgO3/47+ieswh0PHGIx
 dmGSJlBTYk1bu0soSh8Le5lAmzC+2RBl1kmpWsk2Wu3ZNOlSPhzg2QTxeNzAqAVRClrp
 7GJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724889842; x=1725494642;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zCh7mkhCQfA6+fFLCkJM0UjWN96Z9BGQGEbBT1vz11E=;
 b=q0/i8INNEP0GJEYW2dREs88yKRrIlcSUogmkZ30UVtEju7M78ZljNDFsLjVxWL1I6M
 HKMuGyUyiKHvvAyFYpn1vDKoznRtAGVs88101PKIBdHhkUv7/qRCQiIKWI3gqRUBtQrN
 wlutApZnBCFUaF3h1gIlLk2y8xmvviBQHpyspWU+Tl6xYl0YwzsH++GLklYhr8EKNLF7
 P/Am5+43RRs/RAHbtN5s0SUGwC8qY1d1sp5fC6Mxw6gOJGAD69PGQHCW++gTSVQK4IaY
 py7DBn4Eo2atT3QRpmgE6TpC6BpK2siflraKhKlFOhICYzI/797oXSQsg1FgUv8/d0B7
 N4Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNF5QDJr8lYAxeExvK8EwulAFD0D4I3z7GZVqtaxN+TMwoZ3ZnZZSSz2WL7Ha8ePWUbvl2ZxvMaqBp@nongnu.org
X-Gm-Message-State: AOJu0YzlGlr0KzI/n7bHxFkqAWXxh9QeXgtwC0kyK4RusIzKy0MuSt7g
 GboO6oNCOdmgKTJoDQfFDxY+dT4aDNoLBTQLg8RlIKMJ7CPNHkyTSmdKHBBsDvAXc1BOVsWX5aI
 NriPVgBtFhz4UF6Af8S36t1AY2Ls=
X-Google-Smtp-Source: AGHT+IFTXvQf66/5WAUwF0uZ8Y7pWCeUBxsf2zYuuZRtxU6j/dbM0AfUEdchOlCMRszIgEOZEyzIVhNsRBAtA93vU8w=
X-Received: by 2002:a05:6808:bd1:b0:3dd:379:1cc5 with SMTP id
 5614622812f47-3df05e5578fmr1393012b6e.27.1724889842341; Wed, 28 Aug 2024
 17:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240828174739.714313-1-debug@rivosinc.com>
 <20240828174739.714313-18-debug@rivosinc.com>
In-Reply-To: <20240828174739.714313-18-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 29 Aug 2024 10:03:36 +1000
Message-ID: <CAKmqyKOvR__vauziOuxWNgQQDjY+q7M5WONmxWKQk8xr2mg2gw@mail.gmail.com>
Subject: Re: [PATCH v11 17/20] target/riscv: compressed encodings for sspush
 and sspopchk
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x336.google.com
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

On Thu, Aug 29, 2024 at 3:50=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> sspush/sspopchk have compressed encodings carved out of zcmops.
> compressed sspush is designated as c.mop.1 while compressed sspopchk
> is designated as c.mop.5.
>
> Note that c.sspush x1 exists while c.sspush x5 doesn't. Similarly
> c.sspopchk x5 exists while c.sspopchk x1 doesn't.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Co-developed-by: Jim Shu <jim.shu@sifive.com>
> Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn16.decode | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
> index 3953bcf82d..bf893d1c2e 100644
> --- a/target/riscv/insn16.decode
> +++ b/target/riscv/insn16.decode
> @@ -140,6 +140,10 @@ sw                110  ... ... .. ... 00 @cs_w
>  addi              000 .  .....  ..... 01 @ci
>  addi              010 .  .....  ..... 01 @c_li
>  {
> +  # c.sspush x1 carving out of zcmops
> +  sspush          011 0  00001  00000 01 &r2_s rs2=3D1 rs1=3D0
> +  # c.sspopchk x5 carving out of zcmops
> +  sspopchk        011 0  00101  00000 01 &r2 rs1=3D5 rd=3D0
>    c_mop_n         011 0 0 n:3 1 00000 01
>    illegal         011 0  -----  00000 01 # c.addi16sp and c.lui, RES nzi=
mm=3D0
>    addi            011 .  00010  ..... 01 @c_addi16sp
> --
> 2.44.0
>
>

