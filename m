Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4522C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 09:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM2Sq-0003Hd-7X; Tue, 25 Jun 2024 05:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM2So-0003H5-2p
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 05:27:46 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM2Sm-00085b-HS
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 05:27:45 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57cbc66a0a6so5380448a12.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 02:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719307663; x=1719912463; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11yKpAkwjjlkIOswhP8beb0HSen/gY7lt5CnedQKt24=;
 b=O3dz2+gshx886oLmmLL5a1+izNvHsgkrCIIKCKZOgymcRwjb1Zj5qruxredka8THt/
 LSrrClQkdphc0C/NyKMPSaztzsGSOrgZTSqlbzD2Amq9yOQRauSdILROExVS7Ffp0gjR
 A1ortKNQrIlxhmz7bfw2GKgZo5zDSMOyUhIzlGDVsjnmPzZC2SWcDnEWtq8uwOykF8bd
 5refuNw793dhLMXq7Aa5WZxrOVJdYpzgQ3OqOVlgCSqU3dC6XsKAqxGqphaHjB+XDuCt
 d9fZL4V1plqN+bc9XDGvcQEkm1Vj0U/EsG/7CzmGc3hk168UDFqd4XMThR/b/6wpOJ/o
 4LLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719307663; x=1719912463;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=11yKpAkwjjlkIOswhP8beb0HSen/gY7lt5CnedQKt24=;
 b=d8WpaqIiNZTFj+AejAQRULXexPHYiQNPNhdzk9oRax4M55vdpWmgPF8WPXCYax2ItY
 fhgJj52JqNfp4bNld01oVXNKc4WYdDPpMWwwJBySwDWUVHc7yYf7dnLlFeYDtAB0Gw0Y
 c3lrTkNCVwMQQZ1hD2xlbD7/Sd+gshii7ZbzP6LDEbTm/7Vbli5CHG1/iCawxGibq9V/
 AN68G4hQskwdueyrvp5A6B2hftTffNDMOTSvX2wtSyBQAuF4nEUtY47f/Eu804K0CzRd
 myhsbwOOd2L/7z3hylsi1JPk4VycuxDnCMoZLc07ilyeCCGKWzAX01FmrFTpbhwbe8MA
 23Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHzFbbBDJrjFF0wYNM8L1fA7e8sBbxJN0XvpvmrGPVYyFKNO+tF/uP5DtaBcBbgmYOKKQRCNWo4tadXZxeiPlOs5cGX0E=
X-Gm-Message-State: AOJu0YwxiUlaHTD046yXVGt2HClTgN3MsqUaG+1Z0AMeyz2RpttdMaZQ
 4iUUdjPMjkjnZzXzuUewIpP0CemC1g42Lj00VG1dpZmyw33B6O7vX7resyXVqt6VeU7JQmNb9Md
 VWrO47jdVfk3xrcw+YC926UvHXiZR+e6xyX/sHA==
X-Google-Smtp-Source: AGHT+IEKT7J5SK1iGRPoe3i3zxJB7m/7oCIl+3ZWQTYZ8eb9kvC7uKlRZBusM9Nkh3Hr3Ee8+iwxlaKJfzuIJ9HNBQo=
X-Received: by 2002:a05:6402:1ca9:b0:582:7394:a83d with SMTP id
 4fb4d7f45d1cf-58273b32d6emr355949a12.12.1719307662610; Tue, 25 Jun 2024
 02:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240624205647.112034-1-flwu@google.com>
 <8e54bd41-9a7e-4b1e-ad99-33de1615374c@linaro.org>
 <CAOGAQeq0b3_g80k5xa-6f+XPkv6C=nfMLkJt=X3-6FD_d3sJUA@mail.gmail.com>
 <CABgObfZ6U0pEcvr-J5H3sYjTU0-kOr4NOLjBRh0Vg-vfutRCqQ@mail.gmail.com>
 <0b5ff0ab-9b58-4463-8aeb-d464b3b085dd@linaro.org>
In-Reply-To: <0b5ff0ab-9b58-4463-8aeb-d464b3b085dd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jun 2024 10:27:31 +0100
Message-ID: <CAFEAcA-5RPETso7Z56SUhgDkSekLDWu8hPXmKEo_dhh1kPYpfg@mail.gmail.com>
Subject: Re: [PATCH 1/1] include/qemu: Provide a C++ compatible version of
 typeof_strip_qual
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Roman Kiryanov <rkir@google.com>,
 Felix Wu <flwu@google.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Tue, 25 Jun 2024 at 07:19, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 25/6/24 08:05, Paolo Bonzini wrote:
> >
> >
> > Il mar 25 giu 2024, 04:32 Roman Kiryanov <rkir@google.com
> > <mailto:rkir@google.com>> ha scritto:
> >
> >     Hi Philippe, thank you for looking.
> >
> >     On Mon, Jun 24, 2024 at 7:27=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> >     <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
> >      > In particular this patch seems contained well enough
> >      > to be carried in forks were C++ _is_ used.
> >
> >     Will you agree to take #ifdef __cplusplus  and #error to the QEMU s=
ide
> >     in atomic.h and
> >     we will keep atomic.hpp on our side? The error message looks better
> >     when atomic.hpp
> >     is somewhere near.
> >
> >
> > I think we should also move typeof_strip_qual elsewhere; I will take a
> > look. I think there are a couple headers that already have #ifdef
> > __cplusplus, but I need to check (no source code around right now).
>
> $ git grep -l __cplusplus
> ebpf/rss.bpf.skeleton.h
> include/hw/xtensa/xtensa-isa.h
> include/qemu/compiler.h
> include/qemu/osdep.h
> include/standard-headers/drm/drm_fourcc.h
> include/sysemu/os-posix.h
> include/sysemu/os-win32.h
> linux-headers/linux/stddef.h
> qga/vss-win32/requester.h

We should delete all of those, they're dead code for us now.
We dropped some of the extern-C-block handling in
commit d76aa73fad1f6 but that didn't get all of them.

thanks
-- PMM

