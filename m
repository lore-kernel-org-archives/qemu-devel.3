Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29456C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 10:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCGzG-00025u-Un; Wed, 29 May 2024 06:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vilhelmgyda@gmail.com>)
 id 1sCGzF-0001pm-7S; Wed, 29 May 2024 06:56:53 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vilhelmgyda@gmail.com>)
 id 1sCGzD-0003Ue-7K; Wed, 29 May 2024 06:56:52 -0400
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7e2188592c2so88384639f.0; 
 Wed, 29 May 2024 03:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716980209; x=1717585009; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pQHi1PWThwn93/8aqyNGE+J8DVO5qnNISfkfl9kvFfk=;
 b=JDzenT0Q+xrlefn0knkKhA00iKQoY00ENxNfem4fxN5yQEd1AZlBqmI67TCuxVDg79
 xX77nlEaJcbsIAUQQIEX3qTUx1aWeg8iFtsR1Dyud91AVyHq+SNUBw3VSB0v5NY9kZjv
 ARt0Tisqne3NOijX/9AIRmyBzZY3nNX7lMPzBSKUnIHKb+iHs+m2pSgOkixMkc2FhNev
 yzrM61DFZAber6mK2NMKR3dp9kQR8D8kBtbtD/2CA5aphgbkVyCCzh7gDQKaObBSm8db
 kOt3U0FzIeGMX8apW4j1zK+KptfWH0dbkBDcLjA2YkgOldSGWhwpNeLDvg0lx3YU1dqE
 PEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716980209; x=1717585009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pQHi1PWThwn93/8aqyNGE+J8DVO5qnNISfkfl9kvFfk=;
 b=JsEaghoAMZHO+APi4A5LTfp//q4WVxyKMYAjh4iLi6tikddIfsjHIx6gzk4GdixAX0
 5SrMgTfsOov7UkmWwgOFWMzltkNpTO9XfKtxbfiVf9mnF0E4JJkBXLCMJ76t50fllePo
 fVcZVxfdGCOgSDh2DIg/X1Bod2sTTCl+3Dy+PRMX5cxK/Tp2j/tq5mDmVxJKrUr+j2ma
 GykhAidxisHs62zMB43BNCgWuv5Yg+lPGdFxTxADvBGqxkZXxOOSM2F7F6vSihtzr1qq
 5qeo0fTsUEHxA0UArM0AQBlKqPi52eru6F1DD90kLu6vXrTkUjvoEUpaQGduYwej8RU3
 e23A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSwT/ZXzNPEcHwUyVtb9IjWOboKqRYh6EHLMyfbWd8iDXSU5A7v6KFSbhrpATP0oaThBkDGhYJ8MZ6WJnzlPqyPTy1aTHq5w==
X-Gm-Message-State: AOJu0Yw/nbNCVxmVj4Im+nXeeOqWz3mObrKUiIRuehnZKc+nlMWFWF0L
 rmR2qRemsoRJzGwbM4g3ZCWesm4fBcUnXC1SNjcPfQEj/2hwq2IbWIxNarvSIAp2fU5oAYzZf5u
 XKmajDnqs7eAswRTr0XqTu79CsSE=
X-Google-Smtp-Source: AGHT+IGbVc3gmIo1BfkjHlYlr13Ba1jPY5gnhpnceh+BrY2g+0aTk8gUfdzuX+uC1nNM1+Cw0irAwhZ4ZlZTq8m+b1M=
X-Received: by 2002:a5e:9807:0:b0:7e1:7b55:ad28 with SMTP id
 ca18e2360f4ac-7e8c480b57amr1648807639f.3.1716980209319; Wed, 29 May 2024
 03:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240528102339.106257-1-vilhelmgyda@gmail.com>
 <e8t34.08zb3hciwfl@linaro.org>
In-Reply-To: <e8t34.08zb3hciwfl@linaro.org>
From: Vilhelm Gyda <vilhelmgyda@gmail.com>
Date: Wed, 29 May 2024 16:26:38 +0530
Message-ID: <CADe4k3Ke0Lc2roLkupO78KoTkJY46LG6jJdBAoCKsLcA98g3Uw@mail.gmail.com>
Subject: Re: [PATCH] Issue #2294 | Machine microvm doesn't run under Xen accel
 for x86_64
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, philmd@linaro.org, 
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d33;
 envelope-from=vilhelmgyda@gmail.com; helo=mail-io1-xd33.google.com
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

On Wed, May 29, 2024 at 3:58=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> What about TCG? Will it be available if we only build with tcg?

I will try doing this, and report back, and will make the suggested
changes, and re-submit.


On Wed, May 29, 2024 at 3:58=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> On Tue, 28 May 2024 13:23, Will Gyda <vilhelmgyda@gmail.com> wrote:
> >Issue #2294: Machine microvm doesn't run under Xen accel for qemu-system=
-x86_64.
> >Solution: microvm is now not build if only Xen is available.
> >
> >Signed-off-by: Will Gyda <vilhelmgyda@gmail.com>
> >
>
>
> I suggest rewording the commit title to something like
>
> "i386: remove microvm from default build"
>
> And adding a commit message that explains that the microvm does not work
> on Xen, hence if only Xen is available it should not be built.
>
> Also, you can add a
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2294
>
> line before your Signed-off-by. See
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html
>
> But, seeing the issue itself, it's about the microvm being stuck under
> Xen. So the commit that resolves this would either make it non-stuck or
> make it impossible to start the vm to begin with.
>
>
> >---
> > configs/devices/i386-softmmu/default.mak | 2 +-
> > hw/i386/Kconfig                          | 2 ++
> > 2 files changed, 3 insertions(+), 1 deletion(-)
> >
> >diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devices/=
i386-softmmu/default.mak
> >index 598c6646df..6a73aee7dd 100644
> >--- a/configs/devices/i386-softmmu/default.mak
> >+++ b/configs/devices/i386-softmmu/default.mak
> >@@ -29,4 +29,4 @@
> > CONFIG_ISAPC=3Dy
> > CONFIG_I440FX=3Dy
> > CONFIG_Q35=3Dy
> >-CONFIG_MICROVM=3Dy
> >+#CONFIG_MICROVM=3Dn
>
> Better remove this altogether since it's not a default anymore.
>
> >diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> >index a6ee052f9a..f8ec8ebd7a 100644
> >--- a/hw/i386/Kconfig
> >+++ b/hw/i386/Kconfig
> >@@ -108,6 +108,8 @@ config Q35
> >
> > config MICROVM
> >     bool
> >+    default y
> >+    depends on KVM || WHPX || NVMM || HVF
>
> What about TCG? Will it be available if we only build with tcg?
>
> >     select SERIAL_ISA # for serial_hds_isa_init()
> >     select ISA_BUS
> >     select APIC
> >--
> >2.25.1
> >
> >

