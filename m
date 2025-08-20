Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76165CA0EFA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoeCW-0002yt-ND; Wed, 20 Aug 2025 04:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoeCA-00023m-Ki; Wed, 20 Aug 2025 04:29:22 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoeC8-0001JR-5m; Wed, 20 Aug 2025 04:29:22 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-24458242b33so58925315ad.3; 
 Wed, 20 Aug 2025 01:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755678557; x=1756283357; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IKE3b5qPXwRrUn+igVHRTK4ED5kjBFoYAc2j8PIQR/c=;
 b=EF+gWmu9YNDCFV8BkU40jbadKys0dAYIOcwKcJmhN5gYalc5qJvH6R4nQOKIGJpvp3
 +fFxVe994jOGYEe3aDaV4I5Lok7919QLo+S/UT/PM7cNEg0KJSQbmmH8jKL6kws1+kGS
 C2Tlmk6S945Q9TQJij4HL75Saau1wQA3Apl5KfCExR72IOVu38yByINbuHHuImBVfJJE
 wm0zAnDNdBCLya9SSqRCsK+imVhcZkwFQcnvokf7iNIgoms21gEhgeWsND9KPJB5VXPS
 8H6LYKW9qHYV0mIikmh8z/f05qT8jKc/m11Lt5YOsme1x9s8vWL0bo8yspi8pndO1XA6
 fSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755678557; x=1756283357;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IKE3b5qPXwRrUn+igVHRTK4ED5kjBFoYAc2j8PIQR/c=;
 b=qMqj1BkV/jbV0RMV+rd59QYT2sT7Zdd6Q4JnQGu3oKBw02uKOVbXoFmnuGOp/bEQUy
 Ne5tWPInskaeJJRLwC5z8l4LosEp6KDZdsBrSvmRRGVFhbcc1B/nOpQSqae2q6B1Vgh5
 d7pRmsJTl0zp/HHYgzk7LF1RXB67yFAHepRKqY+4alfvjXI10DKQOPPCna1bD8j63Ve7
 8QvQAwYbXlEg28Vr2BttKbiaUjmYJpcQk4htv86Zu44Tb3Lku1rI5SBFPigLQ4XVVcE6
 U0m2KGPocq/hMoGMap+AL335AnJpPLW42JJ1HUHysahb/p4937w38iHMvTPHvGgM2258
 1agw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUijisfJxIcr3QThdB1wxTBk7/W4Uh9IFLDNGK5irseR5QMv9xHNFUkDlA42O2tMV2uecan8/Z2aw==@nongnu.org,
 AJvYcCVEBlbsD1nz1qut8lT6BQdjRGOMDxruD5MIW2kfXIw8pSDVOmRcoCyO1riXVpVICV9CxtcecfNDBh55FQ==@nongnu.org,
 AJvYcCWSzlBkJjPraAwQ6yQBY1SByAFv+PkPe0NKWv4SW+wLrGDhcMP4MrLIOChQZr+W4gPDFTL8KIPMy1dYig==@nongnu.org
X-Gm-Message-State: AOJu0YxeSPYvb2kI1NjPdXTeITgx7GezLHvFAWLFhhvi2+bQ5dX3QIlu
 xrEEUCCMGsE3PbmQeHfRrRORDor6plNZXuS4CkkRDkwVdGofdjsWk9TmIn5AtShsgegzb9+7W4r
 IOrQJlLhiJBWOWexFjoe7pbXiqEqODx0=
X-Gm-Gg: ASbGncvOQdkgH2q3S35WDZ0QAUINY2V/SgnIQbbu27/14eJDX/mQDf9qOeXP5HGGWaZ
 V2lrVtdkkdUTw9cLJfrRqp6kLqFULxD2Utz0PvsvXQs+gIsy7Jr1NxeqrLZZDtrX9ksYaE/Jzcm
 lLpsv0dhn1ipJGTNVEshqMqqu0yBBoE25cCvzjmRBmluzOV8KP1cKKqGlg1JmjLVnNos12m9r6B
 0Lkty3ZTcy8Ppmz+011M32NVadRqaKkxr/13g==
X-Google-Smtp-Source: AGHT+IGuWEj8lJL3+weZ0DRpzBTvoZZDrhY+xXBh+HoNq7VfBffg3zpICxObAGljXBnnQvY6r/hRvZ9pfotGKdSMzrw=
X-Received: by 2002:a17:903:2bcb:b0:240:4d19:8797 with SMTP id
 d9443c01a7336-245ef15fe7emr24486915ad.22.1755678557022; Wed, 20 Aug 2025
 01:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
 <0eb3445353ddde2f34bac187bf8d3ecf02f106b4.1755623522.git.ktokunaga.mail@gmail.com>
 <d01829eb-48fc-40ca-b6cc-b3e8700c3c2c@linaro.org>
In-Reply-To: <d01829eb-48fc-40ca-b6cc-b3e8700c3c2c@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Wed, 20 Aug 2025 17:29:05 +0900
X-Gm-Features: Ac12FXy5B2omOjFv6K2oeSmNpQGJOO9VtBXw49XnWNuNS1LPnStY204ydALo16Y
Message-ID: <CAEDrbUbfON6TmwxCPGdJQt2ymuDrK2PB9pURnToqDn2Zeocc+w@mail.gmail.com>
Subject: Re: [PATCH 21/35] tcg/wasm: Add neg/not/ctpop instructions
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>, 
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, 
 qemu-riscv@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000bb2e24063cc7c42d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000bb2e24063cc7c42d
Content-Type: text/plain; charset="UTF-8"

Hi Richard,

> On 8/20/25 04:21, Kohei Tokunaga wrote:
> > +static void tcg_wasm_out_neg(TCGContext *s, TCGReg ret, TCGReg arg)
> > +{
> > +    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg));
> > +    tcg_wasm_out_op_not(s);
> > +    tcg_wasm_out_op_const(s, OPC_I64_CONST, 1);
> > +    tcg_wasm_out_op(s, OPC_I64_ADD);
> > +    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
> > +}
>
> This is an odd expansion.  I would have expected ret = 0 - arg.

Thank you for the suggestion. I'll change this to ret = 0 - arg.

Regards,
Kohei

--000000000000bb2e24063cc7c42d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Richard,<br><br>&gt; On 8/20/25 04:21,=
 Kohei Tokunaga wrote:<br>&gt; &gt; +static void tcg_wasm_out_neg(TCGContex=
t *s, TCGReg ret, TCGReg arg)<br>&gt; &gt; +{<br>&gt; &gt; + =C2=A0 =C2=A0t=
cg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg));<br>&gt; &gt; + =C2=A0 =
=C2=A0tcg_wasm_out_op_not(s);<br>&gt; &gt; + =C2=A0 =C2=A0tcg_wasm_out_op_c=
onst(s, OPC_I64_CONST, 1);<br>&gt; &gt; + =C2=A0 =C2=A0tcg_wasm_out_op(s, O=
PC_I64_ADD);<br>&gt; &gt; + =C2=A0 =C2=A0tcg_wasm_out_op_idx(s, OPC_GLOBAL_=
SET, REG_IDX(ret));<br>&gt; &gt; +}<br>&gt; <br>&gt; This is an odd expansi=
on.=C2=A0 I would have expected ret =3D 0 - arg.<br><br>Thank you for the s=
uggestion. I&#39;ll change this to ret =3D 0 - arg.<br><br>Regards,<br>Kohe=
i<br><br></div></div>

--000000000000bb2e24063cc7c42d--

