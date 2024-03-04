Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E070C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 16:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhAr2-0004YI-RF; Mon, 04 Mar 2024 11:07:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhAqx-0004R6-Ey
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 11:07:50 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhAqv-0006WP-NT
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 11:07:47 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d208be133bso62498531fa.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 08:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709568462; x=1710173262; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FOrrYov8+bg8EmDVgoFJki/0RKCsUNs7CCFg1Y0F+HE=;
 b=dk90o2XyFh3XOR4+o/P4w1Zw4ZNg838h7h9u8cf8BtbJmImK7VTPDeIYn6uMlJLxtt
 OSw/0el0QZg7IqazazuGBLO9/dYh07qa/xClLZ7xw0ZUUMf1Cv4dnhqh6xfdE2OGpmLI
 kBq4vdrZFrJsbBYtNI3MiJ107mCji68fK04EjAo4WSw3FltXY2/M2sbamYFPqIz35Wwx
 JQbASPF12JL48t97IdYEgmBj1bdR2z/FTPtYV4A13ByMi4IyubrQ9FX5GhNRYIpqTHwB
 svtMeYIy3B6ZgK3X8tWPKc32t23DoOBZOY/aTffeSoGzQhW+eCi6Wgwl4jBgyv3vnNRE
 QffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709568462; x=1710173262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FOrrYov8+bg8EmDVgoFJki/0RKCsUNs7CCFg1Y0F+HE=;
 b=aaAfScPwz29rBJSW+nh/8SUh4Thzz3PuOl+8k3oEryivQ9tCnb5dpEUs9eU/CHyqwH
 uTHvuqCov6TEE52myewsHPNxntVoN+BQcrUADX7fTBpmAV8PHPsIa4zS+E6QMoU++o8D
 v+GvCNfo1jIgiGiopEkQAawafEXYqW5rPjBZMyWGO00Z+TUlg+yajsG5AuEetMGlXGYb
 Y6ZfOY/3nC0mgSIoXcdHJgA2yvy4HQAHjLL360BakDNF+yTMOAcQg0Fpuua1fgTLkYre
 ezmc+SAUKTE7S1MiK9q5ruaq5Ze5otG2l2cOB8ekHAL1Ck9Ftesm8cLI+BEhf7Sk9Jn4
 x5bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK3P5fiO1SXnMATAaHcYEMXyP1D1QsFAMcDkRdzT0CeimjSlEp2osVOsnf9JdCJCFQP4HwNtnW2pH5mp87sLhO/gmCvD0=
X-Gm-Message-State: AOJu0YzZ/uDT6pKSvwNr1SKsynoKjEGUYwHedA964yOEMY94Y9Zr07q1
 wmveVJ1hP00n+Q1BLgpr6mxSHAsYghVFQrXN/BPV1TqxI1vdJmenePsvD+SBdP3BkGWSAyTknWf
 sxASET/E0eJjTrr6aRk7V2SdPD3F0DzMjTnb4KA==
X-Google-Smtp-Source: AGHT+IFBSrQROCu4DpLzuSS6/lWwtGBP6HcAI2p/O7cPLfjAAhYEJkFxZb0a5VPQhuwVA+5+RRJdtk81s9eb2RxUe/s=
X-Received: by 2002:ac2:5dc3:0:b0:513:3086:fcf1 with SMTP id
 x3-20020ac25dc3000000b005133086fcf1mr6106917lfq.18.1709568462161; Mon, 04 Mar
 2024 08:07:42 -0800 (PST)
MIME-Version: 1.0
References: <20240229204407.1699260-1-svens@stackframe.org>
 <CAFEAcA9NSNVkZdtqF=aw=eB=MpsHTFoH6Z1CQtiabn5mme092w@mail.gmail.com>
 <87frx6ugyg.fsf@t14.stackframe.org>
In-Reply-To: <87frx6ugyg.fsf@t14.stackframe.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 16:07:30 +0000
Message-ID: <CAFEAcA_PGJ30572vKC866Utdi+cgVS8QRZ8SCpxAkVzYoHA3-A@mail.gmail.com>
Subject: Re: [PATCH v2] hw/scsi/lsi53c895a: add timer to scripts processing
To: Sven Schnelle <svens@stackframe.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org, deller@gmx.de, BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 4 Mar 2024 at 15:58, Sven Schnelle <svens@stackframe.org> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Thu, 29 Feb 2024 at 20:44, Sven Schnelle <svens@stackframe.org> wrote:
> >>
> >> HP-UX 10.20 seems to make the lsi53c895a spinning on a memory location
> >> under certain circumstances. As the SCSI controller and CPU are not
> >> running at the same time this loop will never finish. After some
> >> time, the check loop interrupts with a unexpected device disconnect.
> >> This works, but is slow because the kernel resets the scsi controller.
> >> Instead of signaling UDC, start a timer and exit the loop. Until the
> >> timer fires, the CPU can process instructions which might changes the
> >> memory location.
> >>
> >> The limit of instructions is also reduced because scripts running on
> >> the SCSI processor are usually very short. This keeps the time until
> >> the loop is exit short.
> >
> > "exited"
> >
> >>
> >> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> >> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> >> ---
> >> Changes in v2:
> >> - update comment in lsi_execute_script()
> >> - reset waiting state and del timer in lsi_execute_script() to
> >>   handle the case where script processing is triggered via
> >>   register write, and not from the pending timer
> >> - delete timer in lsi_scsi_exit()
> >
> > Other than the s/host/guest/ comment fix,
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> >
> > I don't suppose anybody has a setup with the Windows drivers
> > to test this on? (commit ee4d919f30f13 suggests that at least
> > Windows XP and 2003 had this problem.)
>
> I have a Windows XP VM with lsi53c895a. I just fired it up and added
> a qemu_log() in the timer path, and seen it trigger once while copying
> a few files. It looks like Windows XP (or better the SCSI driver) also
> works with this patch.

Excellent; thanks for testing.

-- PMM

