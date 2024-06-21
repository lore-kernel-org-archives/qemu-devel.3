Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A82BC2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 09:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKaOK-0001W8-UY; Fri, 21 Jun 2024 05:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKaOI-0001Vi-0e
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 05:17:06 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKaOF-0004tI-Vg
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 05:17:05 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ec3f875e68so20813571fa.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 02:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718961422; x=1719566222; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5ITE7CHt8v0x+Q58L8M5IKcst9W8PdcpVYovIq8JCQ8=;
 b=sxeFkkeRTMZwXwn//VXGMWd8cWK0TwLAUordojO82ocNsOjHiecxJ68AWSmbO86oFS
 EYRiTDtybvH8P+VHfqVX0ThWpJlpm/tFPYtjvzXhtxjz9XJwyTKratURlxPef/LlYmKN
 /tpG0KUbcc4LTDKsHRa1WuD37ny1tNyLzongByMKu8WMFCICfiGbjIYp+MtKFVk7nC9t
 vlx6WjyuAJlhZAarrqld+MKdHvwLLFzwiHWWvbjT1EkPXtnw3YQppeXTauv3Maj6SVVj
 nTkZibv30CG8KDI2+dIhgVQs5zN5wXBkaQ3sVjS3V0oHDdBB9sOa7Y8CL9XaVMhAV27I
 nbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718961422; x=1719566222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5ITE7CHt8v0x+Q58L8M5IKcst9W8PdcpVYovIq8JCQ8=;
 b=w3m/XkS04Fg/6znrNVkKZfm3fJE1A5HlgsMXKpRh1LiqlfBYHL5iJmzABbRGA6135G
 CwvmKh/XDSRv2YtIE5YZHHklaBMgLV5LNeTHrDVMEpkudx9fzb9AdU7DUBNYdKLdzVwB
 LlI6aC1Y1r7jBsCSUMZkB0Roz+3ATv8foIEiYMuuuZ9HR/Yu1dBOdTqt9NnOkDOHIM+Z
 3afRWq8TqfFbHUNf+1suG+xFuBSN11XqkyIt0rNLLjzXYOAeBoaj/c6LRiGdq7Atdhbn
 YHMm4/R1U9n6ZLVZkcp1moo4IHUBJ11zyCn6ZPMRLDsm5NwpgSu8VLXjX7Vp+/TEQCyP
 Kp8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHfQkeTfAkhey3QaSU95ejrqZr9Hplb9MxWETXADbkmIyDrlyQnpYTNx4o0ZIHzxQ5edoLUbyKpps9aLt15Mudu5QYI5I=
X-Gm-Message-State: AOJu0Yyn8aCS5V32TSiQWxOc2nTbnFpQw2h7F6nxCtHNpz2Club8dpfg
 nl5ESIFgIfH9sinRgZ396BFvnWtpzyf3TrMpEPU5apbdYYcZVA9Mkc6VfMVIK7aWbowYnpliOWi
 IlqCskvLwnUEMBqsRbpyt+gvT33cLg97BAJSgIg==
X-Google-Smtp-Source: AGHT+IETyVID7CHXDKX/XhEAoYCgfeJAfRShNtukxPbIW1913IFZNN6SGYWyu85mfAHeqGwGjL5nYlJK+799B/ew52A=
X-Received: by 2002:a2e:7d14:0:b0:2ec:174b:75bb with SMTP id
 38308e7fff4ca-2ec3cea1b81mr44982091fa.28.1718961421746; Fri, 21 Jun 2024
 02:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <CADueUgQh-=vmoO9kqL589Xeuf_LOM_K2Rr-rBxwe8iArdNdzsA@mail.gmail.com>
 <6b1daa9c-6f37-4edb-86d4-782941f1bcca@redhat.com>
 <CAFEAcA-Yda=XXspi49Z+-7bmBP-DzL2kFMg_XfNxMviHuAX18w@mail.gmail.com>
 <CADueUgS1==4gAmNmTBLZzrnRUp9z2wxkce8+TcOeoR3w_Pg-bg@mail.gmail.com>
 <CADueUgT4xDJft6On4j+oic65UcQRv_PcNSWJg-CcdBM8My3zow@mail.gmail.com>
In-Reply-To: <CADueUgT4xDJft6On4j+oic65UcQRv_PcNSWJg-CcdBM8My3zow@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jun 2024 10:16:50 +0100
Message-ID: <CAFEAcA-TV6MKC32zd3WP5yhLABkbDrLKtP7CCZ0kB5pbV+-5Vg@mail.gmail.com>
Subject: Re: How to use designware-root-port and designware-root-host devices ?
To: Arthur Tumanyan <arthurtumanyan@gmail.com>
Cc: thuth@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 andrew.smirnov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 21 Jun 2024 at 08:07, Arthur Tumanyan <arthurtumanyan@gmail.com> wrote:
>
> Hi,
>
> I just tried to run mcimx7d-sabre machine this way:
>
> ${HOME}/cosim/usr/local/bin/qemu-system-arm -M mcimx7d-sabre -m 2G \
> -kernel ${HOME}/cosim-arm/buildroot/output/images/uImage \
>         --initrd ${HOME}/cosim-arm/buildroot/output/images/rootfs.cpio.gz \
> -nographic \
> -net nic -net user
>
> and it just prints this and do nothing: qemu-system-arm: warning: nic imx.enet.1 has no peer
>
> Based on what I see in the mcimx7d-sabre.c , it configures just very basic things, no PCIe at all (may be I'm wrong ;) )

The machine model in mcimx7d-sabre.c creates the SoC object
(TYPE_FSL_IMX7). It's the code for that in hw/arm/fsl-imx7.c
that creates all the SoC devices including the PCIe controller.
(This structure is similar to real hardware where you have a
board, which has one or two chips on it like RAM but most of
the complicated stuff is inside the one big SoC chip.)

> Is there any idea what goes wrong here ? Maybe someone has experience with running this machine ?

"No output" usually means "your guest kernel is not configured
correctly for this machine type", and/or possibly "you didn't
tell the kernel to output on the serial port".

The "no peer" warning is because this board has two ethernet devices,
and your command line explicitly wires up one but not the other.
If you drop both the "-net" options entirely it will probably go
away (you get the default user networking anyway).

thanks
-- PMM

