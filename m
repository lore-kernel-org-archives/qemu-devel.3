Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346BBCE8D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 12:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGMG-0005yX-To; Thu, 19 Sep 2024 08:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGME-0005wN-SZ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 08:34:02 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGMD-00044R-7l
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 08:34:02 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c26a52cf82so479830a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 05:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726749238; x=1727354038; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/xAwov8AW+493fM5Ax8X0ja8GImF/Cy1bQEtti0B5SY=;
 b=WhKJaVGAL3Tu869MzDeiCJuW5R0C6BHG8BqMcKgxGz5KWvUVRJSntDsKUjtzuAYdRU
 C49MU2fzf9fRbR7ypD62+J7rrC2WdGCTIioEEipfNkekvwBFIoD8kyrwGaN7PaTdcGR4
 rTKoiaZORjYipfD7/7a26sl/HTmzPG86aTTDJ62axhP1H6eao0/5OF5i9JZvxS6POjOb
 jY7DI0rnAOAzbxcy5khsEk+Of0BqJSNJ8yVqbCk7O+7HFUi47IvuZmHuxC1TacGMzdMb
 VndbgDmkCmOX6qeoeZGsCoIWOxkbUGRq47f25kM/wk8b3mxjLcCehkH8fA6UbWb0+yvz
 xXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726749238; x=1727354038;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/xAwov8AW+493fM5Ax8X0ja8GImF/Cy1bQEtti0B5SY=;
 b=KvUs/E308aSH8C6ufuwdwvVrVvEeYy6mNANKHa8gQWs8GqiLBaUZ0vutiCdDe1iugG
 z9VmmzGBUfjWiuYsqgpkISxpPCw4zUYbjhGUYNNUSs9rawyrx1BErRHUVn7IKLJv6b+l
 rijkvPw8l4okJbIcUEx1i/OVj6YF3TNWzzGBU3cDSEEzT5tMrd8JnKkDAkuZPvYfbxCY
 6eg5Fr4Tx87V/c86yc0/uOe330eQsS9cuPhb9Mw1TfsMyF1eHPhqdNhj4Jl7U4Yf/eos
 8Nh5Z5A1j6BEMA5ZKsA1hWCPp0XlgyRgUXpCfgKkF2IK94aNzCjCVSFePoG9/WzTIm7p
 T5fQ==
X-Gm-Message-State: AOJu0YyFSNNYk8FnXjUuDWSJqcgUMps1a9NuF0osTMSqEFs74eTSXxYc
 JKm8XBZ6/+8am9yb2X9J5Jzc9iK49istPKNdToDGKUCsiHVND3pO3caIwjVieeEr5AeXBS+NCAC
 YUwocuzSKhHj4p1G+G1/F9qhZaxvrR2gML3eo2g==
X-Google-Smtp-Source: AGHT+IFKQ/LlomsaFJno/FNasGEA8KiUX1LVf3Kzq5dXQMPT0HX+O7y/+OhGhO8AQCxNdAsjYaf2VW5fVfHCB2HdRWM=
X-Received: by 2002:a05:6402:210d:b0:5c2:4d90:988 with SMTP id
 4fb4d7f45d1cf-5c41e2af424mr32970765a12.32.1726749238189; Thu, 19 Sep 2024
 05:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240816133318.3603114-1-peter.maydell@linaro.org>
 <7a4cc8d1-b2ab-4b06-b1cd-b39bbe8b499f@gmail.com>
In-Reply-To: <7a4cc8d1-b2ab-4b06-b1cd-b39bbe8b499f@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2024 13:33:44 +0100
Message-ID: <CAFEAcA_F5LgzbFJC3ADABjLS2oSwQyqWfdXd9VecqO56yKHNew@mail.gmail.com>
Subject: Re: [PATCH for-9.2] docs/devel: Remove nested-papr.txt
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
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

On Sat, 24 Aug 2024 at 11:13, Daniel Henrique Barboza
<danielhb413@gmail.com> wrote:
>
>
>
> On 8/16/24 10:33 AM, Peter Maydell wrote:
> > docs/devel/nested-papr.txt is entirely (apart from the initial
> > paragraph) a partial copy of the kernel documentation
> > https://docs.kernel.org/arch/powerpc/kvm-nested.html
> >
> > There's no benefit to the QEMU docs to converting this to rST,
> > so instead delete it. Anybody needing to know the API and
> > protocol for the guest to communicate with the hypervisor
> > to created nested VMs should refer to the authoratitative
> > documentation in the kernel docs.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
>
> Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

Thanks for the review; I'll take this via target-arm.next
since I'm doing a pullreq.

-- PMM

