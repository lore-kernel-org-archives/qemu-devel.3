Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F032DCFD37A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 10:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNpre-0000Ys-IE; Tue, 25 Nov 2025 05:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNprb-0000XA-UO
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:01:36 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNprY-0001Pz-KE
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:01:35 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-63fc8c337f2so5050422d50.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 02:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764064891; x=1764669691; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HF4PpXuuOQeqXii22oKDVv34al+inM2TG4gP95QmZwM=;
 b=wXtwT5XuJsQixdZO0xQ9+KTVJjvMv4oR8CiNR1jqZk36Z/80HsDsEgzj1NwDVVkoRq
 2Z4CG5MOcWZuCGS7lu105bf8QCutfqTtMPxpMDve3wKbiOeeSwsGc3v4yb4viMOy2vwL
 arL3oBcKE1XIVUYm0b9lUhLQXroqeS2g3vI9ukffj9hey+KPT8JSsb4fmDcv9X/8RVZb
 Xal2Y4CVZAtnzGGdBpyxDmQhIcNjbCyMdw4nvjwwbFLn/K8WCedfsxnHyT3a7nE+sDQM
 Qgyr5+a+MzmSgvXv9MfEl8PvLwbVz6B65mmHn33UQopYMMOo4JKffZpXAozB6vh+1CSV
 ZdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764064891; x=1764669691;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HF4PpXuuOQeqXii22oKDVv34al+inM2TG4gP95QmZwM=;
 b=LWC+WV5VAFezleJePXDYkKPs+C48D5HyJHCajBXIbMQdMrzJJ1KH5YFWKl/s1XCVrE
 vVpMm6QaxxEfpHpmJzifeGWWa2EQdbWKeWyvyeCpXbSciHOq92UiU8gPKx0L0BgvWR5h
 Sww+gSwFPA/ZoUGQAwJ7BqstB2vEPWXQ/ZFV47gK1loc9HG5154ZssDz+GXudd20p3Sf
 4SkntRFmQ3+8OJ0ifzl5d6Ko6pJYfywoipmDGJIvuQV64tla/0D+wstwvxslCZ4UNB5i
 lFr8Y9jIRUudjf9Pe4+RUpSIuUwd7lyS9lrXKWvYk8Fm07rISNm11WrIHxQCAddqHj2T
 yc5g==
X-Gm-Message-State: AOJu0YyEBvYsW0OXWUEZpdCUSaF/gX/bd7jZFjr/ohdQYvwyJe7r+gR8
 67iwMqlxL8w0OeLz/sN3UKBEqOvXMYgsJuW9OMHs4nhmaHOkO2FVvMWf+psCncT10TrXAR6NVne
 gsynjQyj2mTbIC4bmeuSy32L06BE4tLLkzo1Ct1le8Q==
X-Gm-Gg: ASbGncvBm8E3H4VLZebGDRSgPs8bfMQDt6X5/4pgxTfGCtZ0vz+w3499laAESuRxnkK
 /5BS1sQu5Kcj9rtPKF6e+7Hjsl1o6xppeJWkeJsdLWcQN5NqLBUM/j/L/mIOsWE2rSQ0qkk5E0p
 t6BcQUIQcsXUvsva2FfivHfJssjV+8WZLYb4Py3EsKnQKFI6PEO2gFMZIuo8lPky+3RsSsRE8MR
 KERc7zae5XwK46ektFQQu04rieiG+P+G+Z43emzh9qOcH0cT57nRTywDOH1GakXQhVsCvNz
X-Google-Smtp-Source: AGHT+IFwl+w79ZRJM0W8MVC2hyPfMsVHTffSPeSKi1OMxBMMqcJGXA4UOE3cvXypLFd9lM8kKloLMjUBeeJY9A1fK1Q=
X-Received: by 2002:a05:690c:6d90:b0:787:d456:2e62 with SMTP id
 00721157ae682-78ab6efba2emr37114487b3.33.1764064891143; Tue, 25 Nov 2025
 02:01:31 -0800 (PST)
MIME-Version: 1.0
References: <20251008191936.3069950-1-navidem@google.com>
 <CAFEAcA_kaB5OeRw53Z1u_K4+oB_a6Mi4q-aaNeuOLXpTp-+0jw@mail.gmail.com>
 <CAGXevki+HpoXt=LhopwAQGyn4fnYJHer+GpLFr=mu5NsCXVrUA@mail.gmail.com>
In-Reply-To: <CAGXevki+HpoXt=LhopwAQGyn4fnYJHer+GpLFr=mu5NsCXVrUA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Nov 2025 10:01:19 +0000
X-Gm-Features: AWmQ_bkcPjjCmKKkiijf2I973JQOOEHgANyc0vWXjV9G5OYG09hRKkvVWmCewik
Message-ID: <CAFEAcA-hyn0B-yWE1=g4+NN9=NBjWvk-P8qrAk9L4vpAZpUYvQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] libqos: pci: Avoid fatal assert on zero-sized BARs in
 fuzz builds
To: Navid Emamdoost <navidem@google.com>
Cc: qemu-devel@nongnu.org, Zubin Mithra <zsm@google.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Tue, 25 Nov 2025 at 02:31, Navid Emamdoost <navidem@google.com> wrote:
>
> On Thu, Nov 13, 2025 at 6:03=E2=80=AFAM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> > I think if we added the size to the QPCIBar struct then we
> > could assert in the accessors like qpci_io_readb() and
> > friends that the offset provided was in range. That would
> > catch both the unlikely "we implemented the BAR with no
> > size" case and the rather more likely "we got the size too
> > small" case (and also the "bug in the test and it got the
> > offset too big" case), and would mean that we don't lose
> > anything by not asserting that we have a non-zero-size BAR here.

> That's a much more elegant approach. Thank you for the suggestion!
> I've done an initial investigation into the impact of adding a size
> field to QPCIBar and checking it in the accessors. As you anticipated,
> making the API safer immediately and correctly flushed out a few
> latent issues in the existing qtest suite.
> Before I prepare and send the full v2 patch series, I wanted to run my
> plan for fixing the test failures by you:
>
> - Issue with qpci_legacy_iomap: Several tests (like ide-test and
> tco-test) fail because they use qpci_legacy_iomap, which has no way to
> provide a BAR size. My plan is to change its signature to
> qpci_legacy_iomap(dev, addr, size) and then update the handful of
> failing call sites to provide the correct, explicit I/O region size.
> This seems like the cleanest way to make them compatible and safer.
>
> - Issue with nvme-test: The qos-test fails during the
> nvmetest_oob_cmb_test because the test logic was performing an illegal
> out-of-bounds access on the entire PCI BAR. My plan is to rewrite this
> specific test to correctly read the CMB registers and perform a valid
> out-of-bounds check within the BAR's limits, which is what the test
> was originally intended to do.
>
> Does this plan for handling the test failures seem correct to you? If
> yes, I will go ahead and prepare the v2 series with the above fixes.

Yes, that all sounds OK.

thanks
-- PMM

