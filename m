Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7338C606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zmqbBoka
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVWg-0008Pz-PF; Mon, 23 Nov 2026 10:00:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVVWe-0008Ph-Hz
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:00:12 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVVWc-0000kH-Sz
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:00:12 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-67da3d03263so3378681d50.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 07:00:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795446009; cv=none;
 d=google.com; s=arc-20260327;
 b=sfr1c9ALSOzVNKiHI+Q0Y1NUHEm5Q1UoxlrqsSjSnPigpExj1nVDEIttCkVbIZBWdS
 JyY5yuAyuEwDc8cLMOG4HziJxBGkLztsGV9eZqUTCitz94jJAjt0YxH/ffDWz2FwAQD7
 1pPTcZa1YCkxYLEmyYINiTuiUmIf/bBRjaq1fzx/x6f/9b5XVXjGC3vnSsAih9uCONuC
 /GlRQ7q1NPWiMCBL1ORWKCNggX4oYtTB2kprFMva1H9Ehao0XVwiLrC1YqVk96/TVCZo
 +ECxEDuQlhH5nIvbicIHo/1ete/z9bMtqz72yj2U3vWlF/WKuFOoUlPUlY6tXcH41KY9
 aVEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+1oGA59yDH4YlH1yU0/HwmNs9ocQJIujbNzwQDzzQQk=;
 fh=DOOA5F8Ff3opce93nMoTTxHZvfhD6wLcoB+uB248OtY=;
 b=lsVL6Ni61BosTze7/g+MoVRRNnhYyoFPJduS3ZWO9hEIOt2W5t7l4cXEbQMOOG0dzB
 6XxgNU0x2LA70fg7UE2/Wcv/mytqzC/x4JP6FFJDAPW1cImF7xlLTcaqVzFQbrGpr0il
 AdGyEf5MJF7+KddgGAep5aAUWV+2dohWr7dcQPLl/B/LMf27g6dMr9aaoIzPjlqxE9si
 ve83mFE5W87w//rJsLfDlc0gbtRHpeH0XrKkHOVPBVh6EkBeKmznufHN5jQ6C+6raYdT
 r0Bfp1LwXvWkp6J3ZM5hHLii+eQx905ZCi+gjLh879ed9g6il9t5NwcIB80d9pl32NDB
 AG2A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795446009; x=1796050809; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+1oGA59yDH4YlH1yU0/HwmNs9ocQJIujbNzwQDzzQQk=;
 b=zmqbBokaLNrCLSiENIFDu71VP153gQWzUbL048VnkWL7JjTGuUz648tQ2exCcC7vSH
 kh/QsQI0LqX2G6Fsn2I6Zn3sRWXOCtTXbs7qKOF2ZwXUsbiF/5AZ42zcWNYaY5kQ+0z4
 zCrfyEXqj8LHtMuakwU4/VLQ4qmAjr1onvtjKjUisUWMptBdkiOWYH2Atvot5z7m0iSg
 BLhr13Gxgdi8D/Zl4ylyLkDfChT5thheUweqjmrc3AeC0MIrvYsqGwspTR6hIL8B5YaX
 eUucYJxSfCsfPbAx4iPynIbf1ZC7Xz+gaimeTpvmHti8BQ3zOCIBH9l4krlwXlEXye76
 iMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795446009; x=1796050809;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+1oGA59yDH4YlH1yU0/HwmNs9ocQJIujbNzwQDzzQQk=;
 b=Kk+jhOVqwImA/nE1h9duv6cN/qFl1oswJEvG04+JZufa1UF5k1r9Ktyy6jP11egWdB
 fubzxha3mY5iOmu0iHRbhTdumKWHT/hM1eKsJiXLRDJ6XErJ6YhyM2dQjrKHHeRs5g4i
 q6JzNxq/Wmnn0E64tOYr5MQndV0+DXI2UiIwj6ouOtVcWX5g1o+00ZLAfjSodSRZ45OK
 E1Y/5TGo9IX87i/ysEjKTLEWzmwRlxUMbMmlOx8QB9SkL/X8Y+/XACBvKTYosun3Y7D4
 uK8BST3R1unvZnND+dIJT3Yw6g4cDmfg7++LGPOiQ3YKQbf8LQ0ymn1ZQPioMoN3pYVE
 +rRg==
X-Forwarded-Encrypted: i=1;
 AL+hErEJyhQIzkrQ1cnQJcK4Ns5tetdz0B7ajYX/ksVBPO25idI6V/iiGv9ee85HtfTmTbHxNPfJRxMXKIEH@nongnu.org
X-Gm-Message-State: APuU4Z/EbgA9X8qOj2yOzIpcEJVZj+uS9zzpjkFMUKlQov5/U1eFvax7
 a6WB2VThi9RErl2RM3btGoM6E2AdTZBmqKmJHXZnjctOxKIurFCBJnUhYHMgLZry/N9kDKTMwfq
 faN1dhFzxft27Pp/20KgofEIygqTyaZMIQJK8ahQYxQ==
X-Gm-Gg: AZFdTZf15WpTTrJ0GbdXOVBB+UEmJcbuwN+JqSrbQM5An9goPGRbvM/Iyp3iD9x3F7e
 Nm1ul3QWv1MnTg2QdODX7t0VvmxUzqrRIzQdZXn8HGvM1X2S2m8dlGPrxztj02xD2j5FFtNIY+3
 vMABDW/H2Cfj2PDcMAI2NPapJyQ/xbnSs1EKKBbmndfRu8zTr3QQU9O1DiCpu3DeRSk5L48GrtJ
 73FQqkPSw+c6xEdAezoCxj7NSy/rxhk78AdEV5ywbr1pfurl0GznYz+bHnk976EmLrS4ewxzOBJ
 QFlfQW4UhHDLoSGwq2iPWooNdWaIMgSs9Hl+jalqmZU3HeGHAEBPParqem6RDePZvqq1iIbeTE6
 XmLwoQpImar8E4GngzWurQ2y87FC5W998ap9D0T/Y53p6ce4eHtZGtqD+9CZ1ljbLhmHTleqlGz
 1IYfn5Pc8rjW4b6/IxLrlJ
X-Received: by 2002:a05:690e:43ce:b0:679:be6b:42d5 with SMTP id
 956f58d0204a3-67df4456982mr1894966d50.98.1795446009195; Mon, 23 Nov 2026
 07:00:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAFEAcA_4+PcP8f2DF+mtjkO5iO6eU6C6R6hjfBN7dg0o_TGPiw@mail.gmail.com>
 <20261123144943.9630-1-agarwaljayesh03@gmail.com>
In-Reply-To: <20261123144943.9630-1-agarwaljayesh03@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Nov 2026 14:59:57 +0000
X-Gm-Features: Aa3M54r9rslau8NuUH0xmZP1kFcJ32ffoHz5vA_0i4JbbB5brmf7wB0u-bJ_2K8
Message-ID: <CAFEAcA92futWE7aK_ppeBan7Fgr+SsemmQ0E+sz5hFX2hfq7Uw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/bcm2838: Route system timer interrupts to GIC
To: Jayesh Agarwal <agarwaljayesh03@gmail.com>
Cc: philmd@oss.qualcomm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 s23adhik@csclub.uwaterloo.ca
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 at 14:49, Jayesh Agarwal <agarwaljayesh03@gmail.com> wrote:
>
> On Mon, 23 Nov 2026 at 11:55, Peter Maydell <peter.maydell@linaro.org> wrote:
> > Thanks; applied to target-arm.next.
>
> Thank you. The problem that you raised in the 2025 thread on Sourojeet's
> patch also affects the following devices:
> uart0, aux, mbox, sdhost, mphi, dwc2, rng200, the eMMC OR gate, DMA
> channels 0-6 and the two DMA OR gates.
>
> bcm_soc_peripherals_common_realize() and bcm2838_peripherals_realize(),
> for the Pi4 only peripherals, wire these devices to the legacy
> controller, and later in bcm2838_realize(), the GIC wiring overwrites
> that.
>
> Should I fix them the same way, one patch per device? I will send them
> in December.

Hmm, that's quite a lot of devices. We should fix them, but I
suggest you have a look at whether there's a useful way to
limit the amount of code-duplication involved (e.g. use an
array of splitter objects and a data-driven loop rather than
open-coding all the creation and wiring individually).

December is fine; as we're in freeze for the 11.2 release
this wouldn't be going into the tree until we reopen at
the end of December anyway.

thanks
-- PMM

