Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF0BC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 06:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXEhj-0001Zv-6n; Fri, 26 Jul 2024 02:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sXEhR-0001Ys-TZ
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 02:45:13 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sXEhF-00043O-V6
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 02:44:59 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2f0dfdc9e16so963091fa.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 23:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1721976296; x=1722581096; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2FTRk3J33glerxDuUPx2ABL0Y+rYtERj8Qc+LO6yr3A=;
 b=O7n0KnT26p6TcL0krG0ximc7QUkNGMF2HERizdKT10N7uL1pUnEKrs2teIIqVxx9WF
 R6lyOBEL1+4Jolcru/Qrf0s6QXVWWMouFoo0WyLHMsoMi3s7N9mknlrDgtdHHO8aoBiO
 pKTp8s1OK5hyQ9YHP6KajxS5U4SbDOzBRaqRWhdS/swm7I33myQajjGAUJtRTBm5gH7N
 3i4WcSb2z1iMGtO1AKDRhD80AuLVLh/rkADVnbatPjxK36s86I3Ri3MExEcZ3LmVODE3
 fvmpK1D+CBGqzOL1Pq6YJ64QL5d5sIzKrIAizU2OO9TFXEtZ5xcf5YJ6fCCOxuZOUDBD
 ZtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721976296; x=1722581096;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2FTRk3J33glerxDuUPx2ABL0Y+rYtERj8Qc+LO6yr3A=;
 b=YqbrbiZE5YHStkbh5FR0h5OEZtPdcrGJOSuY5Lmm1e9StBWU6/L9nvBSwJPzB18Zin
 nH+T7074Soywhwuns/s9onV4oWXpAQFq3tsiVR+MdPi8SvfG7y3t4BXGaAeehfor/lqW
 s1e6CamV/3lmAwZY3KtBDS/Cf+CdnpBCBRiMLysjUCw9JxSLORJku7UhwZXpD2/RCdsW
 5GIOgJUur2Cbd8QVEqC8f8dZNKmU0ePk0aw511GjAdfWKM0UXKJl2JayzPgB6kCk3Naa
 hr0VO0chYTdBm+V5erdTJehRb7xLcpIOYc65Sr23Fhvasw5ir9Tvopv5Un3PflklFm2T
 TY9Q==
X-Gm-Message-State: AOJu0YwkrZTQj1ZiaVKDQnBu56WsXe6GipWwCKlmVzeaBI0OJAjokQrc
 OQJC4oLEnID8pBjPSGBZ0JXjyVkJgX2sXFKKc05DlyZLucYBysgEN6ceU4dpJMIUuoKveDeL4bM
 YBCwPT610DaGUHogJpJKDzmEUzWly5A4zYulFBg==
X-Google-Smtp-Source: AGHT+IFYh8LVqnjSlTRzm+s7qbBNEzo+hGVgHklCziCdG+YtjdztyjIPgVE9XM94YuRcWMk906MOf3ZVcqccHYx8gOg=
X-Received: by 2002:a05:651c:b1e:b0:2ef:2c27:6680 with SMTP id
 38308e7fff4ca-2f039c79ea1mr41597631fa.12.1721976295489; Thu, 25 Jul 2024
 23:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240726043246.10999-1-jim.shu@sifive.com>
 <ca0090bb-9784-4355-b5a2-0783dd160c3e@linaro.org>
In-Reply-To: <ca0090bb-9784-4355-b5a2-0783dd160c3e@linaro.org>
From: Jim Shu <jim.shu@sifive.com>
Date: Fri, 26 Jul 2024 14:44:44 +0800
Message-ID: <CALw707q9LwaiLZo2gQ5VvGWPfGmGR_N_JYhqupX5VXSPhPnUkQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Let gen-vdso tool to use internal ELF header
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=jim.shu@sifive.com; helo=mail-lj1-x22b.google.com
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

Hi Richard,

Thanks for your feedback.
I think it is reasonable. I will drop this patchset.


Regards,
Jim Shu

On Fri, Jul 26, 2024 at 1:28=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/26/24 14:32, Jim Shu wrote:
> > Let gen-vdso tool to use QEMU's internal ELF header. It could avoid
> > compatibility issue of glibc version in the environment. QEMU RISC-V
> > zicfiss/lp extension patchset will add "EM_RISCV" symbol to it. This
> > symbol is not supported in the legacy glibc.
>
> I see EM_RISCV added added (by myself, amusingly, as part of a bulk merge=
) in 2016,
> included in glibc 2.24.
>
>  From repology, vs our oldest supported OS,
>
> centos stream 8:   2.28
> debian 11:         2.31
> fedora 39:         2.37
> opensuse leap 15:  2.28
> ubuntu 20.04:      2.31
>
> So unless there's some *other* symbol you require, all supported OS will =
have EM_RISCV.
>
>
> r~

