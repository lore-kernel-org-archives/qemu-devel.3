Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B7AD18123
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 15:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Muk-0005Nq-3X; Mon, 14 Oct 2024 11:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0Muh-0005NX-Um
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:23:16 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0Muf-0000ZL-F2
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:23:14 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2fb584a8f81so6421961fa.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 08:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728919391; x=1729524191; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jEM2uZFTmdRnqruMIBrYlCea4q3pgxZeI9+zAfXhnJM=;
 b=JecI9NQ81zfpRzOm0R1syN/vXPRS8deClslXvicciqXOXAzPGNJPZhwDOgxsi4zMS/
 xdr7DpLRGDatbmbgUY3rPuG13YGkDNSPw7clB+eWU+h1pF3JA4QNaHYNVQNiiFLPzxNG
 ewoxXKX4EtFMSzlqWHWoO7Z1/VBjJzNDeUqPbtOndVPIfGoaRjlPsffOFE3TF5p5ZmG8
 /qZDNHrm8sSAj8C48Gn8szJCCxy0joUyvvZj4/pIUXtuyK5SDwwwWy65GtYv8VaLmgyo
 ql9/XGEZllhJCGcD6ZbetNOULT6x/+yvXl8y8D4rULHFIhozXj/QVv5mhtZdd0uMVHn3
 l9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728919391; x=1729524191;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jEM2uZFTmdRnqruMIBrYlCea4q3pgxZeI9+zAfXhnJM=;
 b=QyCnD5ZGF4dNhdNFuwmuQcvC2Ub3VfD1Zs3EMWsAoeNmcNCBsMp1bAy3kC+Kc+xtkx
 sT+FRGyzPCo9jq12nBmODD1/eBwPU7eAXuRSGoT1hOcOlI5TAgM50i0+ZGG2gxPkjU74
 BDOIIsqD13E9Ji2bZGdqXHym72uttI7iV6BkyORMcvQ/k7aX+oBsLljR3SM2Uh1i7LOw
 MaXfJM980ZJtq6mIzxZu4qoRhBijeJNOZUfJGbBO262G6KIoaMIqPG31sjux6iPlAcbQ
 /PB0g4dU3tbU8NcEEvRHqU2k9Tc5ZDtQnv2Eg7Qt7oZ0OD2un2BZnzhnBzzTJVROBggr
 0BVA==
X-Gm-Message-State: AOJu0YyYaANF0S7AVM1snGL6JXnP8fwE4o2htapEmcAMrcwXwvTdUp40
 I92rdSgSpFW3AK2/BhyNTXvdx/rO1h+seqhgTZazQd82gYvTJyx/MO6TAN+++27HOxtwhiToLlZ
 EyYZQjj3TrusI0epxiSOeYOALNsfvt8PK7w/2WEoDf9y6rUBV
X-Google-Smtp-Source: AGHT+IEIovIrw375SGChivPFIhGSwXhsiGiSQaV4Bt/AKEybGPdFeYwTWgQWoX6ijZda2DCP+vjbC5TV+XISaEY8irM=
X-Received: by 2002:a2e:a98a:0:b0:2fa:d31a:1b84 with SMTP id
 38308e7fff4ca-2fb3b84622fmr37840291fa.9.1728919391245; Mon, 14 Oct 2024
 08:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1728299530.git.chao.liu@yeah.net>
In-Reply-To: <cover.1728299530.git.chao.liu@yeah.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2024 16:23:00 +0100
Message-ID: <CAFEAcA8Bp7GtrTmfa5acxzxy9mTK7tSOCmtjZBJjpsPWALfmsQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Drop ignore_memory_transaction_failures for
 xilink_zynq
To: Chao Liu <chao.liu@yeah.net>
Cc: qemu-devel@nongnu.org, bin.meng@windriver.com, edgar.iglesias@gmail.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22f.google.com
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

On Mon, 7 Oct 2024 at 12:25, Chao Liu <chao.liu@yeah.net> wrote:
>
> Hi, maintainer,
>
> Following the reference from the chip manualug585-Zynq-7000-TRM manual
> B.3 (Module Summary), placeholders have been added for all unimplemented
> devices, including the AXI and AMBA bus controllers that interact with
> the FPGA.
>
> We can check against the manual by printing the address space of the
> zynq board with the following qemu command:
>     ${QEMU_PATH}/qemu-system-aarch64 \
>     -M xilinx-zynq-a9 \
>     -display none \
>     -monitor stdio -s
>     (qemu) info mtree -f
>
> The testing methodology previously discussed in earlier email exchanges
> will not be repeated here.
>
> Chao Liu (3):
>   xilink_zynq: Add various missing unimplemented devices
>   xilink-zynq-devcfg: Fix up for memory address range size not set
>     correctly
>   xilink-zynq-devcfg: Avoid disabling devcfg memory region during
>     initialization

I've left comments for patches 2 and 3. I have taken patch 1
into target-arm.next, with the ignore_memory_transaction_failures
line reinstated.

I'm all in favour of our being able to get rid of that
legacy flag setting for this board, but as I've said on
previous versions of this patchset, we need to have
confidence that it's not going to break existing guest
code, which means the patch removing it needs to come
with a description of the testing that's been done
(which should be more than "Linux still boots").

thanks
-- PMM

