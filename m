Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AE2C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 09:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOCwJ-0007uP-CV; Mon, 01 Jul 2024 05:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOCrd-0004xV-BZ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:58:23 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOCra-0006j8-DS
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:58:20 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57d20d89748so2989727a12.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 01:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719824296; x=1720429096; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kXXH3LOqJxGPAXdIJxcNmav/alDjOGq1U7fctTEu8io=;
 b=Fxl7SlJC2Vsru/qVVW0PtNRr3DV6NIflB1E9ZZ93IoE46MqMh+shCJ1+YEo0wdlcxX
 p7yuDgwEnIVZE9VuAKj/MhE17TGRNybD/EbaDFbMcbyCZ7GD5xScCgHp1ePMDF5GXrXF
 yPLAwX2hLX+NtEvBbrl3EnUAA8NxoWsarNIAg90OkS/BsnBK1i84lw8BFXCG02PR/R1r
 qebAlpayKfqEugb+OQUlSkbxYNeIu987eWbdGc4k45oEfznZ3jfdqYULRgmUDC4fIdZc
 eU4Y4R7hEzmExYI+inQ8/M2ObWmgSc4jzb/dQeSHL8LL6DTcp9NB3vl01tKRiG/cICFk
 FtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719824296; x=1720429096;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kXXH3LOqJxGPAXdIJxcNmav/alDjOGq1U7fctTEu8io=;
 b=sxlyhYG1W/3Oj9Xd0bWk8GT63aVi92MQXawgLiOeODWdqQG4RVkjFlKS1YykTjeZWu
 0pDY+ipWX2bNY+wxbzxtTi1wc5s0drtssyAU19MZ1PwaHBGyN57oYxR4lL74sTKm8jlW
 2E8e8Fz+xq6kfOkkMuuOmpFScBxFp0o8p6noERyKMMXD+Yyk4dKHMVJpg6ahvyTT+HTs
 KkB+Pk9yixLrf5lh4e1WhCkUWrMdi4kqZOexI0yc/RUkCtIvezkgIYnVuDT5U3yLAlEV
 vreQv/sY1NzHgRKY7XSEg3J0GibXRkiphhlbrdvV6lRihMLB8W9eTJ//MexjZnGtQJ4b
 FMSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWi369Jqr0tpy37mRbNtssYtOpOPAVA0Nomo5wXde7xdORE887rnJgoDnPDNOs0gdOnUHec3+eJdHDcLie6BLBg5uYB1c=
X-Gm-Message-State: AOJu0YysD6tomzp9q4GHI3AX/sJXATTcxoM/OynO1lFG5SSxsQRSh8nw
 F9nerRAtzLNQZNUapwn+PGJT1Jkqkpw8CnfRqoDl1LXWl2glXs7F2jLZqqNKXsavy6lQTXAtLNN
 QtC4j67zs7u4PmQ/sI69Izf7XiCh/4+8dHm6Kvg==
X-Google-Smtp-Source: AGHT+IGLyyJzA5YKsF0kiK3YiDtBQO7yVJhfNvDWooPKTxZJtfhQmpK3tNoi/52BJOb8DEm3ddiRgcdOay1l/SW3hGQ=
X-Received: by 2002:a05:6402:1751:b0:57c:749f:f5ef with SMTP id
 4fb4d7f45d1cf-587a0bfc733mr2734717a12.34.1719824296410; Mon, 01 Jul 2024
 01:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240620-b4-new-firmware-v3-0-29a3a2f1be1e@linaro.org>
 <20240620-b4-new-firmware-v3-1-29a3a2f1be1e@linaro.org>
 <CAMj1kXGb9xVQ5E3oK_QX+3hKkMfCoA9jF5jkEeG6Eq9+zbHPHA@mail.gmail.com>
 <ca463afe-486f-4590-acb5-a61265cbbd37@linaro.org>
In-Reply-To: <ca463afe-486f-4590-acb5-a61265cbbd37@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2024 09:58:04 +0100
Message-ID: <CAFEAcA_RUK53BZ7oiFgnt0HgcghACTc+XXC1h2340GAR8xHUEw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] tests/avocado: update firmware for sbsa-ref
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 Ard Biesheuvel <ardb+tianocore@kernel.org>, Rebecca Cran <rebecca@bsdio.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Mon, 1 Jul 2024 at 07:49, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> W dniu 30.06.2024 o 16:37, Ard Biesheuvel pisze:
> > On Thu, 20 Jun 2024 at 12:20, Marcin Juszkiewicz
> > <marcin.juszkiewicz@linaro.org> wrote:
> >>
> >> Update firmware to have graphics card memory fix from EDK2 commit
> >> c1d1910be6e04a8b1a73090cf2881fb698947a6e:
> >>
> >>      OvmfPkg/QemuVideoDxe: add feature PCD to remap framebuffer W/C
> >>
> >>      Some platforms (such as SBSA-QEMU on recent builds of the emulator) only
> >>      tolerate misaligned accesses to normal memory, and raise alignment
> >>      faults on such accesses to device memory, which is the default for PCIe
> >>      MMIO BARs.
> >>
> >>      When emulating a PCIe graphics controller, the framebuffer is typically
> >>      exposed via a MMIO BAR, while the disposition of the region is closer to
> >>      memory (no side effects on reads or writes, except for the changing
> >>      picture on the screen; direct random access to any pixel in the image).
> >>
> >>      In order to permit the use of such controllers on platforms that only
> >>      tolerate these types of accesses for normal memory, it is necessary to
> >>      remap the memory. Use the DXE services to set the desired capabilities
> >>      and attributes.
> >>
> >>      Hide this behavior under a feature PCD so only platforms that really
> >>      need it can enable it. (OVMF on x86 has no need for this)
> >>
> >> With this fix enabled we can boot sbsa-ref with more than one cpu core.
> >>
> >
> > This requires an explanation: what does the number of CPU cores have
> > to do with the memory attributes used for the framebuffer?
>
> I have no idea. Older firmware was hanging on several systems but was
> passing in QEMU tests. After closer looking I noticed that Avocado tests
> run with "-smp 1" and pass.
>
> Checked failing system with "-smp 1" and it worked. In meantime you have
> fixed problem in EDK2.
>
> So yes, updating firmware may look like hiding a bug. Which I do not
> know how to track (I can build and test QEMU, but going into its
> internals is something I never done).

My assumption was that random chance meant that TF-A when
only dealing with one CPU meant that its memory layout etc
was such that it didn't do the unaligned access. I don't think
this is likely to be a QEMU side question.

-- PMM

