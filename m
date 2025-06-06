Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA59C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 08:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNSZn-0000il-Iy; Fri, 06 Jun 2025 04:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uNSZl-0000i6-LB
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 04:37:21 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uNSZj-0001WT-HM
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 04:37:21 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-710fe491842so1333377b3.0
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 01:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749199037; x=1749803837; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hcLZBM33OYI/IZyWoESQLN1A0CPtEZn6tU/hzTRIX0s=;
 b=tlwYP/W5SLFrI9CbOFVXBXbsTfyCm5uTm8nEYM9pcO4GEaZCumShHn4H/kLak/q1KX
 TYKZvlLtN16wVIZCmw2i6B3feBcH4YX7p/+kvitOpX7laqrJ5D2qUoWJqQRDmCaoOOS2
 t1JDGpaLMuS6EgjrbMb3h8cTEiHBZEqtCofZryhmkhsYGiRJw/V700SsBZ+E83hxyf5W
 9lJ0KLzH4Xjn9BqPosmVUL1pe4jfOGjmuIqX25IOIs03BEP2P7fLZzQbRLGmdTqGVKIZ
 //Ewyfzkrad2Aw76U5GxiKwpkspVKq5ATVUDT6QHo3llEF7SJzhOtHmvn5J7gIRxMj6/
 w3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749199037; x=1749803837;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hcLZBM33OYI/IZyWoESQLN1A0CPtEZn6tU/hzTRIX0s=;
 b=JmKHhZkcP093bc1nEZIOgjsgvGQcqbw/PmvwU/+oc998Vn6Iue3KU3/cEo6oCgBV36
 pYj3+yKQ37AN7+pMk6FCRsXhOgtJZYd4uISVgEvr3INZJXzZt8d5GWdr1BvLxqgVsTeK
 uKmKQxE6eGC/5KRYk8NissIm4SvUkEYxN4RIVHX/7mEhJJpcAg9gKijNtSJo3zUYLykx
 gkONZRvX8IW0khIbvFwp3Uy99PLS29FP0LH4b4GnkaVQh5IewiybcR++Rhh3wIOUHa4q
 WmYzH/BwB7rxK5p3PY+LvZJeyFpxl68pZKBJZOAJXHHAVWamVU+jQsgCPXz1skg0ru5Y
 cghA==
X-Gm-Message-State: AOJu0Yz680RWUTPhNSuFevE+rfCbs5zXh4jyv+1ivI1IuCpqqeDPqvxv
 mkpd97uHn80crFU1L4nP6m7FSfyAVO90wNc5SsSXhBihvvk+NtHng1YvOWMEvUVoON1tH+iB1xj
 XWSErFzcIdfWU/OSzONtON0nrqKyPaquGhqG/EFbArA==
X-Gm-Gg: ASbGncu2p0CooBNUohcngXPZZtp4rvXaKEhkR9PV/b2Rix+brHJQogjYXh0LKbho0yF
 uH4t8wCgwJ7VasA5Jt/SuA7B54Dx4jj1+/kwPFLdb0B9zwzaymXuARzYmCL0RDidkIFiPaYOBhd
 x5fO7tzdb9w95st16akzQa6mckw3prol5GvQ==
X-Google-Smtp-Source: AGHT+IEJu/3UUrRoEz4gWSwo88m6ird7M6YhPvgB5xODzDHkvDJmkwLfeRuO1HQtWNtVZgEwvH1TrdpdDn6kR0KhXIE=
X-Received: by 2002:a05:690c:350f:b0:710:ebdb:83d3 with SMTP id
 00721157ae682-710f76bfe07mr31934077b3.8.1749199037715; Fri, 06 Jun 2025
 01:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250605193540.59874-1-philmd@linaro.org>
In-Reply-To: <20250605193540.59874-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jun 2025 09:37:06 +0100
X-Gm-Features: AX0GCFtOladZKhm4GMyvqei2H_jf7hBl4py8G7DakgjNiSU_Z8hS2K-xhhmc3TY
Message-ID: <CAFEAcA9WF75iiL8WmcTYQ2ph7NLuMTXtarPp6HouEZ_nHhg1EA@mail.gmail.com>
Subject: Re: [PATCH 0/4] system: Forbid alloca()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 5 Jun 2025 at 20:35, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Eradicate alloca() uses on system code, then enable
> -Walloca to prevent new ones to creep back in.
>
> Philippe Mathieu-Daud=C3=A9 (4):
>   hw/gpio/pca9552: Avoid using g_newa()
>   backends/tpmL Avoid using g_alloca()
>   tests/unit/test-char: Avoid using g_alloca()
>   buildsys: Prohibit alloca() use on system code
>
>  meson.build                 | 4 ++++
>  backends/tpm/tpm_emulator.c | 4 ++--
>  hw/gpio/pca9552.c           | 2 +-
>  tests/unit/test-char.c      | 3 +--
>  4 files changed, 8 insertions(+), 5 deletions(-)

There is also a use of alloca() in target/ppc/kvm.c
in kvmppc_load_htab_chunk(), so I suspect that patch 4
here will break compilation on PPC hosts with KVM enabled.

thanks
-- PMM

