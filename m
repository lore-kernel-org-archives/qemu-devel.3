Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2AF3C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 10:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWY32-0008W3-1d; Tue, 01 Jul 2025 06:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWY30-0008Vl-77
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 06:17:06 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWY2x-0004oi-Kj
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 06:17:05 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-710f39f5cb9so52771517b3.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 03:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751365020; x=1751969820; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/EZGFydrDXJBrz0DVvdE/jHAvcnNcUyTdefYv3idd5Q=;
 b=ACLpmVy0OV5QuSWuC1kBBom+Fz/4qFN2Cyp2E+eUz4+t+5crVIpcM3j+86RiEJ1mHy
 25nvh9CKTu2MDqr4+dhgJONqWSxSCfitXmc52DbxuI8ujjMKuZSRrBTA75gq3RBKPigM
 X7I3oeMzWd6XXnWfsIc68dYuQyCZjE4hiZhgCGjCaCsj0MniwXvWkVkiL1X3l08n8Pa0
 3F+uIy3lbUaipVSlMZ+VMQKVt7yFMM/u5GTr5rQDhM3T6HJGQh09tTvJzs/9xv7YPFuI
 6BY0Ft9vrtyXUyoaMhLYKY3/HH+QRxPrclQatBWWS96zygf/45mp5HrkitJKHli21rtz
 BeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751365020; x=1751969820;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/EZGFydrDXJBrz0DVvdE/jHAvcnNcUyTdefYv3idd5Q=;
 b=ZUMBk/r8jjSNIpKNDo8hrKL0fFPN1cvtcm9DANs33jVgFw8syGRSkyZhvP0FwuJtE4
 s9cUbx2frmeFPVWebLlU1YFL/4xt5kkk6fWx8VG2UWVDVVXOmCH4iYHxKax6AruH/Ofx
 bYE2kdAZWEHSar+lXJdeq3z22RZCrPf/reOjq5e117Z/Y5qHbmW7unj/VsRoDLtUmoQP
 qlvUq4QDVjTPvyYSCDX5NZbPY55kbqbkutqZ2ou+Lq+T7fRlVYUdoyUoPQ3elteBvzk2
 Kgaq1wnjraKh+KWMBVMwcUcdGbVshMNrzJEvNSJ93PhwXzkM2wqU9sKrk/8FyVWV+SL4
 e5nQ==
X-Gm-Message-State: AOJu0YyHYGhJXAU8yQ1C5hTZPz9Qeseo+kqZiuIrtTsm9xVFmTGooXD3
 NwsLo8JRAZbdL+gubzvix1ZFEA+62j34KC86ffl6ElnmyR80+SB6SjTxt3Hpk9UoFSS6xBxfCv0
 1ZX/Pz9T/Og37FSO/q8ASYNM4bvJFFuVReXBolZtTtQ==
X-Gm-Gg: ASbGncuv+sE7nSpdN27ljAXO4ru6oAzp9dcpB9LXjKNXP6wg/Sl0Z7vj6/itSToELso
 eqI6ag97VRaLBOpnJfVlt1rQ8xzlrhN3dOoXD2PcJer816+e3+J44V4jaY28I0fGaCh7XGQ8NaI
 oPSNOiwnsQFd6ILXULkzJGB1gmsm/3NDwvWMnPknbiz1YO
X-Google-Smtp-Source: AGHT+IHaev1eooza1tvFqNELJSxTEWCpDaYkpuMurhT9txvR+eF996nXRUAaSLtmrPa7B4Hk+87ADuca53LAipHLb58=
X-Received: by 2002:a05:690c:4901:b0:710:ebdb:83d3 with SMTP id
 00721157ae682-7151713eb30mr235674297b3.8.1751365020417; Tue, 01 Jul 2025
 03:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250623121845.7214-1-philmd@linaro.org>
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Jul 2025 11:16:49 +0100
X-Gm-Features: Ac12FXyxBi2YNUaZLCDi3EC5J8pKLHPxbd-OCNyqfbGXsAeITXA5VEa44a42DSs
Message-ID: <CAFEAcA_hD_8XjMU+xdXM6ez-O8xmQtSddFLUA1j4JhstmJTFFQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/26] arm: Fixes and preparatory cleanups for
 split-accel
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>, 
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Mon, 23 Jun 2025 at 13:18, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Only the last patch is missing review (#26)
>
> Since v2:
> - Addressed thuth review comments
>
> Since v1:
> - Addressed rth's review comments
>
> Omnibus series of ARM-related patches (noticed during the
> "split accel" PoC work).
>
> - Usual prototypes cleanups
> - Check TCG for EL2/EL3 features (and not !KVM or !HVF)
> - Improve HVF debugging
> - Correct HVF 'dtb_compatible' value for Linux
> - Fix HVF GTimer frequency (My M1 hardware has 24 MHz)
>   (this implies accel/ rework w.r.t. QDev vCPU REALIZE)
> - Expand functional tests w.r.t. HVF
>
> Regards,
>
> Phil.

Hi; I've applied these to target-arm.next:

> Philippe Mathieu-Daud=C3=A9 (26):
>   target/arm: Remove arm_handle_psci_call() stub
>   target/arm: Reduce arm_cpu_post_init() declaration scope
>   target/arm: Unify gen_exception_internal()
>   target/arm/hvf: Directly re-lock BQL after hv_vcpu_run()
>   target/arm/hvf: Trace hv_vcpu_run() failures
>   accel/hvf: Trace VM memory mapping
>   target/arm/hvf: Log $pc in hvf_unknown_hvc() trace event
>   target/arm: Correct KVM & HVF dtb_compatible value
>   target/arm/hvf: Pass @target_el argument to hvf_raise_exception()
>   target/arm: Restrict system register properties to system binary
>   hw/arm/virt: Only require TCG || QTest to use TrustZone
>   hw/arm/virt: Only require TCG || QTest to use virtualization extension
>   hw/arm/virt: Rename cpu_post_init() -> post_cpus_gic_realized()
>   hw/arm/sbsa-ref: Tidy up use of RAMLIMIT_GB definition
>   tests/functional: Set sbsa-ref machine type in each test function
>   tests/functional: Restrict nested Aarch64 Xen test to TCG
>   tests/functional: Require TCG to run Aarch64 imx8mp-evk test
>   tests/functional: Add hvf_available() helper
>   tests/functional: Expand Aarch64 SMMU tests to run on HVF accelerator

Where I haven't picked up a patch it doesn't mean I'm
rejecting it, just that I don't have time to think through
the more complicated ones this week, and I wanted to at least
take the easy patches to reduce the size of your patchset.

-- PMM

