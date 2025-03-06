Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D794DC28B23
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq4bn-0006te-Q6; Thu, 06 Mar 2025 01:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq4bm-0006tN-HD; Thu, 06 Mar 2025 01:21:26 -0500
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq4bk-00047A-R7; Thu, 06 Mar 2025 01:21:26 -0500
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-52361a772e7so1501560e0c.1; 
 Wed, 05 Mar 2025 22:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741242083; x=1741846883; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RtwhlKwnVBgOF6cp1v+m4PZ8wCf5vvQthXWMJ0XQXcE=;
 b=FcW6si8qciXFEAK0t7+cy3FOJ6fhDjnsdBVqS3TnYhuT3ApPmsoHgW6KGJvf31MGt3
 EwmsQf8pKnyQJOgIzd5bUQWrztdR9FgHsIczmoqoi7hAS4g354QkfxhyJPGJUO7y98zA
 lwP2KhDuZOxp7MNBB6hgY2w2UrMcF9WYVZ9WoAz8f9RT3PZ6ltB5SyJbMYFAQlcTUm8r
 pzvNhcJqyseSSRf8qCG++ypfys7gjwAA2YOFUR8oqhfnz1NxV1mCdUhndm2R6rOnUFgQ
 awZFsIF3RmJbS2W1jICrubCmqy6OrGfI9ligra2E8O2YB1LO7G65x4rHhmX5FFXC0VVP
 k/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741242083; x=1741846883;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RtwhlKwnVBgOF6cp1v+m4PZ8wCf5vvQthXWMJ0XQXcE=;
 b=DVOxiUuMw1clLM2ZiMOQta7etop7J681zMLJpqEqxPOzpE5LDpyBdbq1IIC/mS+ANV
 lHlsVkKIk/cJbcpAI/pQzrlUG0lS9ISZvcTRnGsURGwm35ofJvse2v9Lklln6yXbbJsH
 7WygccXZf/gncLMbjiciecaTVnYaVE2DgReyP5lnSGsNQwkPf9TOM7Nml95Xgh94IE5E
 UpFp9hHZNwfdySjuTfVYja4XIgC65+0fI0eG2PlTrXD3aMtAluiFXUpZA185rG+ypxxi
 SaA81N8thK+G311Y2grwBM1OJq79P58ZWrJm8veFFIZe2RToR8vXM/xQ0b4WUq9sLcWz
 LdUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVijd5LpcG8egBwRczvGBIE2W9rEfrZ0P9HBFpyyukomhMOVS8G9scLBfkCdY3ATtKEZvtz0GzlFZi7@nongnu.org
X-Gm-Message-State: AOJu0YwBAR95Gykb7a6yECMhmwedooVj3vMU2JmtH6JXIQfk/kktFqw2
 lGyAjvT/8TYYyVtd7pZzznVwRZe5GHO4jRUywbuzEj5iapZtRPXR3T6oRToWy3UQl8ArD/yZA9m
 JKg5BDkd9V2Rtz1vXrYs29Ns1dwQ=
X-Gm-Gg: ASbGnctljjWO/Vozawm4D4SQByEIEu5pUnaZe+mS5v/PLYhrk6cJjXvCyHQm8dlW8c2
 62Kkbp+RrX+g+qATFoi9IMP162N03JsBrAT7gj+evtbizR8bhfcatby+jVcjEbhas8GdRZsdVFj
 wxWy72ASB9eayvd8sDp+DXfkZ+Lvi53Et0ASxuudV3HbKzYPsSp2MIp/6w
X-Google-Smtp-Source: AGHT+IFhf0ajAxvVrPsuo5338jbKLWjCYpqZmU4/AwtiVwArvHOMEkUqQR1XngXA7G1/vskdSLVDm5AAYd841rtFGPk=
X-Received: by 2002:a05:6122:3d15:b0:523:792e:e9c3 with SMTP id
 71dfb90a1353d-523d4ecd2d4mr1390829e0c.0.1741242082989; Wed, 05 Mar 2025
 22:21:22 -0800 (PST)
MIME-Version: 1.0
References: <20250218025446.2452254-1-debug@rivosinc.com>
 <CAKmqyKMrod154GEdDFajnBMh0gg2zFGWxXYA0+xF=xW42SgEjg@mail.gmail.com>
 <Z8k8zi3Moy/RxCWr@debug.ba.rivosinc.com>
In-Reply-To: <Z8k8zi3Moy/RxCWr@debug.ba.rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 16:20:56 +1000
X-Gm-Features: AQ5f1JovqO5tCrdz-tqZxjWqdNg7udYTtB_6D2hmmjUT0PSAyFq7NWdxEHSKibs
Message-ID: <CAKmqyKPYCWEVyd8ygKR+j8u9cTLG2xoG053p7-EDXcd+8qWfUg@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: fix access permission checks for CSR_SSP
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 Adam Zabrocki <azabrocki@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

On Thu, Mar 6, 2025 at 4:12=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> wr=
ote:
>
> On Thu, Mar 06, 2025 at 03:20:55PM +1000, Alistair Francis wrote:
> >On Tue, Feb 18, 2025 at 12:56=E2=80=AFPM Deepak Gupta <debug@rivosinc.co=
m> wrote:
> >>
> >> Commit:8205bc1 ("target/riscv: introduce ssp and enabling controls for
> >> zicfiss") introduced CSR_SSP but it mis-interpreted the spec on access
> >> to CSR_SSP in M-mode. Gated to CSR_SSP is not gated via `xSSE`. But
> >> rather rules clearly specified in section "2.2.4. Shadow Stack Pointer=
"
> >
> >Do you mean "22.2.1. Shadow Stack Pointer (ssp) CSR access contr" in
> >the priv spec?
>
> No I meant 2.2.4 of zicfiss specification. Section 22.2.1 of priv spec
> says same.

I meant that it's now just in the priv spec, the zicfiss spec is no
longer maintained so we should just reference the priv spec

Alistair

>
> >
> >> of `zicfiss` specification. Thanks to Adam Zabrocki for bringing this
> >> to attention.
> >
> >The thanks should probably be below the line
>
> Sure
>
> >
> >>
> >> Fixes: 8205bc127a83 ("target/riscv: introduce ssp and enabling control=
s
> >> for zicfiss"
> >>
> >> Reported-by: Adam Zabrocki <azabrocki@nvidia.com>
> >> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> >
> >The actual change looks good:
> >
> >Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> >
> >Alistair
> >
> >> ---
> >>  target/riscv/csr.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> >> index afb7544f07..75c661d2a1 100644
> >> --- a/target/riscv/csr.c
> >> +++ b/target/riscv/csr.c
> >> @@ -191,6 +191,11 @@ static RISCVException cfi_ss(CPURISCVState *env, =
int csrno)
> >>          return RISCV_EXCP_ILLEGAL_INST;
> >>      }
> >>
> >> +    /* If ext implemented, M-mode always have access to SSP CSR */
> >> +    if (env->priv =3D=3D PRV_M) {
> >> +        return RISCV_EXCP_NONE;
> >> +    }
> >> +
> >>      /* if bcfi not active for current env, access to csr is illegal *=
/
> >>      if (!cpu_get_bcfien(env)) {
> >>  #if !defined(CONFIG_USER_ONLY)
> >> --
> >> 2.34.1
> >>
> >>

