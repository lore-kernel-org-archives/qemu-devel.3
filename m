Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93C9C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 16:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2w0Y-0001FI-Pe; Fri, 03 May 2024 12:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2w0W-0001EY-Tf
 for qemu-devel@nongnu.org; Fri, 03 May 2024 12:43:36 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2w0V-0007t3-6k
 for qemu-devel@nongnu.org; Fri, 03 May 2024 12:43:36 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a55bf737cecso1265952366b.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 09:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714754613; x=1715359413; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3WWLttr9pnULFJtUH4DU4U1k2k3jxKRdOUSZYqWhRAc=;
 b=kVspxob70rO0YEGf4P8lDMFhmSQT5VHO2oxgT/rC6IokwTLVMEiaP1Xv5jlZ6yTm1J
 s1mKMq6okMWgS/AfyCa6Q7P66bxJk1E4/cVFzDKK4WOAqbbAyrL+/02MMZb/VT+daKTP
 HXrdlY8yR+bbygQHeuXpgUv1j8wM6nIrSJw4yjBxgRdDxJUkcI4O4dY2ygiVsho3YFpG
 RmlcttJDl/Z0ShK15Bc5HRV4gOph7ZCF9COXEDiO8dIiSIoRjy4N4nUsnPPWyli11ZXr
 E5xn4Z4DsGazBMPJea8tQLlBN1jHM9fWDfdlGjIu0DUkOH0rAX/gp0Th1yOrHXZtI5lF
 wSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714754613; x=1715359413;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3WWLttr9pnULFJtUH4DU4U1k2k3jxKRdOUSZYqWhRAc=;
 b=rYIzofCe+QDQzEonUvEqkGwzU04e2/4uda6otLwn8K0/APP/W0N1xC3jbgfVRqB9lG
 Bg4/A3qTDYcmu2HlHcYasthoTxOdS5CJ0C1uj4BWBF42ZdcFwp9xurGcG/lEEzrii0MT
 k/dpKbxJr4kUrvKwu5VVssTVewqTPpw6CfaYrzzmm4T52yf6U8/tTYDvtDhFAPOV2kP6
 cj9LoznMP3mTgQepNAMmSNEAFD71Z//UVfkc4OLBDou34pIsybVoHMdrwZ1d7gu3l4u1
 NCGZxZ/WrmQ30M/R0U0l1YUSfAj90UgzZfipgaPgmthzqExPhRJF9oHLR0fd8rFOJhma
 bu9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9Z2Wvj3KtHrk/1UoiZUJaHwrW5HnyIvhMuYlk5GK4QkJYUlURrvNkcrNLL0mjIxaZ6KrcrTPQMcGvUKgkpigaCVseazU=
X-Gm-Message-State: AOJu0YwXglBH4CZKBIXgbcXpOv8TkmXdN3yIcEXboP6BGr9nCtSdjUwK
 XgfhSq35I1NXI/iwo0CyqPvWO4yvDwKSpEmzi+an1NamrE6d4991MPd4bHYow5k0n0DlZyNIVdD
 IPqU1WpZkHuIDXdTItmJHjE5baU/BCjBVxPb0+Q==
X-Google-Smtp-Source: AGHT+IFq8FgdCjJcA5C3p5xtfEx59BdCi4zBwnsumeOAkDT3YGl83RGV0eQv9O6dptN8ON4U6WuVcpECt3Cv9kr9Ls8=
X-Received: by 2002:a50:9b53:0:b0:572:a711:3daf with SMTP id
 a19-20020a509b53000000b00572a7113dafmr1914763edj.40.1714754613517; Fri, 03
 May 2024 09:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <87y18u3hjf.fsf@draig.linaro.org>
 <20240502141628.28103-1-adiupina@astralinux.ru>
In-Reply-To: <20240502141628.28103-1-adiupina@astralinux.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2024 17:43:22 +0100
Message-ID: <CAFEAcA-jce+fdPeMM4r5148ywxZE-SO1kcub8QaL42WcbafJdA@mail.gmail.com>
Subject: Re: [PATCH v5] xlnx_dpdma: fix descriptor endianness bug
To: Alexandra Diupina <adiupina@astralinux.ru>
Cc: Alistair Francis <alistair@alistair23.me>, "Konrad,
 Frederic" <Frederic.Konrad@amd.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
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

On Thu, 2 May 2024 at 15:16, Alexandra Diupina <adiupina@astralinux.ru> wrote:
>
> Add xlnx_dpdma_read_descriptor() and
> xlnx_dpdma_write_descriptor() functions.
> xlnx_dpdma_read_descriptor() combines reading a
> descriptor from desc_addr by calling dma_memory_read()
> and swapping the desc fields from guest memory order
> to host memory order. xlnx_dpdma_write_descriptor()
> performs similar actions when writing a descriptor.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: d3c6369a96 ("introduce xlnx-dpdma")
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>

> @@ -755,8 +811,10 @@ size_t xlnx_dpdma_start_operation(XlnxDPDMAState *s, uint8_t channel,
>              /* The descriptor need to be updated when it's completed. */
>              DPRINTF("update the descriptor with the done flag set.\n");
>              xlnx_dpdma_desc_set_done(&desc);
> -            dma_memory_write(&address_space_memory, desc_addr, &desc,
> -                             sizeof(DPDMADescriptor), MEMTXATTRS_UNSPECIFIED);
> +            if (xlnx_dpdma_write_descriptor(desc_addr, &desc)) {
> +                DPRINTF("Can't write the descriptor.\n");
> +                break;
> +            }

This "break" introduces a behaviour change, so if we want it
it should not be in this patch, which is supposed to just
be fixing the endianness bug. (If we want to try to do the
right thing on write errors here we need to check the device
datasheet to see what it says about the hardware behaviour in
that situation.)

I dropped the "break" line and have queued this to target-arm.next.

thanks
-- PMM

