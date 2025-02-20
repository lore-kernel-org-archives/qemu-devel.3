Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE158C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 12:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl5uR-0002xC-TH; Thu, 20 Feb 2025 07:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilias.apalodimas@linaro.org>)
 id 1tl5uM-0002wO-8B
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 07:44:03 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilias.apalodimas@linaro.org>)
 id 1tl5uJ-0001N5-0A
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 07:44:01 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6ef7c9e9592so7032687b3.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 04:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740055437; x=1740660237; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3N+6yuA28M7s6c57t8EizrNFZ6i9s62eFI+syvkNaN4=;
 b=C+HBi1gR0xW8ZUOwrCpbJq7tiExLMTOPPJP8fEcy0ZwInQWrEkThtmFbKNJG4p8L5O
 5fTaRkVj2CEh/lkXxYUlOy+1g2WoYdX0Ou70hK2eIJ2L6yttv1bxrJ8BjhNDbcvALvhJ
 byeI0bzGd9nT0wluRetNxrKBIp/vSf8XLQnYAgoo/EeqcjJW4n0r0uOGmrKZZYseDo8t
 HtgTTRn2qnebxqxwdawFXBFGhMw6dXhonPv/4RCRNIA9RgEfy0kJzfi8rWmc1d1k7pEo
 TQSCjGKepFgiXcMQUA7CJutfgM6PwnCgyJqexfOPevNBr33iII/xG5ivjX0qi8qjXmiK
 y7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740055437; x=1740660237;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3N+6yuA28M7s6c57t8EizrNFZ6i9s62eFI+syvkNaN4=;
 b=JrUi+Mf3rLjAoonsfFR3SFYhsRfgk0OThQMMqaumpyJ2dvO8D+IEMfqvTzZ4y12dIg
 zgnu85E85GyPlB4cAH048NZ6BUvYdW9o5eMNCUinPDmkoidCG460uU5Xur2j23ThMtsi
 H/rs80vCRGlxCYppEQXs0D5YMkYQhPQx+CTrth3vtG919efRliaQVPJy/ZA+RcWrbJO1
 Dxss0xkUVDyxykuSvrZINfv9XeKPvhXGg2QunCcS0TV1TEGKNeOTny/lyF9k7NL8+jf1
 UcMJv7JhCpSdH970clRs79NCVXFcLSP5ATGNKPb3Zf0hGPxSqcujA/vOOCgfC9HlSrNl
 fW4A==
X-Gm-Message-State: AOJu0Yw0yKhnDuySjlY+FguIakFh8gJpV6ukEp6ia1YocAm/lIGa6RQa
 17dJp29CpBaMl2yz1RkCj6Pd/WW4Kgp4Ja0i224CXLUkGrq0uY7VATWo9gbObHmtsFh/kXrLehu
 JpIM7tNTlLVlmRb4e/JEm0S/J7eOMnztYwdGssw==
X-Gm-Gg: ASbGncsoGjThn9NsqIZuMpZzgBDXXtbW2G2zsOAwUeIaU5RpdBQHrYvYVKCFktBBmY7
 MvegvZGErW+3mLtJ6M8XnvyE4zzRLxnpdhqvbPzgk+J5uSHT1md+X3BkOSGwHHJVCeoeVHXrQLw
 ==
X-Google-Smtp-Source: AGHT+IE4yrTh93yA3GfpjNR7vtR86AbATGH9gqH1e2MDgoyFfR02K3EtSQDxNRgIY5Yb2x6ZMhVbfJF7GQeq633968I=
X-Received: by 2002:a05:690c:7305:b0:6fb:a376:3848 with SMTP id
 00721157ae682-6fba37640ddmr81976137b3.34.1740055437223; Thu, 20 Feb 2025
 04:43:57 -0800 (PST)
MIME-Version: 1.0
References: <20250211092324.965440-1-kraxel@redhat.com>
 <CAMj1kXE289FkzV=GZSUARF7TFUyRuxYVX-090ic06Erb_RLGrg@mail.gmail.com>
 <cc41f19c-5778-4376-a1a1-762a92c8584c@amazon.com>
 <CAMj1kXFaoZCnXpAsq+i5nzpCOjcrsN4QA2r6Z=F6UUwcUe_qJA@mail.gmail.com>
In-Reply-To: <CAMj1kXFaoZCnXpAsq+i5nzpCOjcrsN4QA2r6Z=F6UUwcUe_qJA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 20 Feb 2025 14:43:21 +0200
X-Gm-Features: AWEUYZnTlr-A1I-DiZeEgvoZs27SOWRVjgKDye9_lKOfKPY-Xyn4Y7NDn08Whsg
Message-ID: <CAC_iWj+eGFOTBUAgStAcN+UMH6fjbivgKAcm-i8qaGap1GPAOQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] hw/uefi: add uefi variable service
To: Ard Biesheuvel <ardb@kernel.org>, Alexander Graf <graf@amazon.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=ilias.apalodimas@linaro.org; helo=mail-yw1-x1132.google.com
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

Hi Alex, Ard, Gerd,

Thanks for roping me in,

On Thu, 13 Feb 2025 at 12:13, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 13 Feb 2025 at 11:11, Alexander Graf <graf@amazon.com> wrote:
> >
> >
> > On 13.02.25 10:41, Ard Biesheuvel wrote:
> > > On Tue, 11 Feb 2025 at 10:23, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >> This patch adds a virtual device to qemu which the uefi firmware can use
> > >> to store variables.  This moves the UEFI variable management from
> > >> privileged guest code (managing vars in pflash) to the host.  Main
> > >> advantage is that the need to have privilege separation in the guest
> > >> goes away.
> > >>
> > >> On x86 privileged guest code runs in SMM.  It's supported by kvm, but
> > >> not liked much by various stakeholders in cloud space due to the
> > >> complexity SMM emulation brings.
> > >>
> > >> On arm privileged guest code runs in el3 (aka secure world).  This is
> > >> not supported by kvm, which is unlikely to change anytime soon given
> > >> that even el2 support (nested virt) is being worked on for years and is
> > >> not yet in mainline.
> > >>
> > > The secure counterpart of this would never execute at EL3 on ARM, but
> > > at secure EL1 (or potentially at secure EL2 on more recent CPUs). But
> > > the general point that this is difficult to virtualize stands; I've
> > > contemplated doing something similar to SMM emulation using non-secure
> > > EL1 in a separate VM to provide an execution context that could those
> > > the secure EL1 payload (using standalone MM) but I never found the
> > > time to work on this.
> >
> >
> > Sounds very similar to what Ilias built a few years ago?
> >
> > https://lore.kernel.org/all/20200511085205.GD73895@apalos.home/T/
> >
> > Which reminds me: How similar is the protocol in this patch set to the
> > one implemented in U-Boot? No need to reinvent the wheel over and over
> > again.
> >
>
> Identical afaik

I don't know what I can do to help here but I'll explain what we have
in case we can figure something out .
The idea is very close indeed and in fact it works on QEMU with some
hacks for arm(7/8). [0]. Since QEMU doesn't have an RPMB emulation I
am providing one in software in U-Boot. That's obviously useless in
real use usecases, since the memory backend disappears when we leave
the firmware, but still useful for testing.

I also have a blog explaining the arm specific bits here [1].

The TL;DR is that we set up everything StMM needs inside OP-TEE and
execute it in S-EL1. For storage, we have a 'special' StMM driver that
sends requests to OP-TEE and uses its RPMB support to write sensitive
data on the device.

[0] https://git.linaro.org/people/ilias.apalodimas/efi_optee_variables.git/
[1] https://old.linaro.org/blog/protected-uefi-variables-with-u-boot/

Let me know if you need anything else

Cheers
/Ilias

