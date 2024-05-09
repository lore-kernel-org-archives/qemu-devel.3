Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9B8C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 05:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4wmU-00067j-VF; Thu, 09 May 2024 01:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4wmR-00066K-IS; Thu, 09 May 2024 01:57:23 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4wmQ-0001NW-0L; Thu, 09 May 2024 01:57:23 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ed96772f92so3985055ad.0; 
 Wed, 08 May 2024 22:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715234240; x=1715839040; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=meMw/nsJto10956YHL1zX7FTwYO6aB+sep7NnZeX3VU=;
 b=YRAIukzC3rx60OGrvl0tZB90LMS63VEm5pxlYE7ky58rxI+vsTLXHztJmZOpdVSF8k
 C/ooDylPU9v9p6IktqCX7kL3TU3Dt2YHJVOSVm1/R06BgaIiINl9q9nh7a0IXTtPM3w3
 Pn3j8pBilMuPtAM1Xgm9NrjlSgQhHZE/OKNOtGjwODBjQ5M9tX/AKNP3g/IzZh+RmSgZ
 +69f/fgcBm8tuvsPLtdYBbhuGiH+fnVqvZnLk/ZV14YQ5FMu6a6tjbZa5HXMUKyc5a43
 phSS6Z+vfq5/w55n84+I1kVHwKsrQtp8A/wCjuC86Jw5bZsG6zjAWh/1C3nLSEugCQ63
 v5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715234240; x=1715839040;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=meMw/nsJto10956YHL1zX7FTwYO6aB+sep7NnZeX3VU=;
 b=mo4XwJ6okvBbgMhKkgWI2mbpQkuOTRDFHNfaukH43vXb+42G0lx8X0u6itPK0Ao1Hi
 bVw5zq/RGJ/I/Jl7wLzvg1X/SuJou7EuRkjZreDuRVfG0XomVzXLqz8Xozlx6cbhaBWT
 amrDW074fyvjwbFKG9odehnFc9+PQGlMF9ZkfSSgia3wTthSYA3ypPS9eUeLJnBKTd+j
 fP0z90vygIx/7pPHLkXQOITk5pmSdjCAZ9A9tZKT/4f6+qAwhaIoMayaXeUbaOWeClrR
 r//TMYpJ2h6u1P3Vp/sCC/3Pw9JEDlS/f6UQTi4ce/XSBs9uyMr5Dq6pg/kf1gFDxBFm
 oCHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5rOja+qHKNswmWgZGe6KCKzXmJay6T/t9KvgCopNJEX5JSnd68U6H6rWnF5hx88MXU6qCQyz+j7fAmevfcBplxzSN
X-Gm-Message-State: AOJu0YzsB79OP2TyEIrWJ4HTOCJULGwMfMN8lD9zmPBnRswrGqA4mpli
 YuEcNPMp10wFtRIi4u4x/Iy2wlo9IovA7R3/nje0HP1eJTTf17QaJl3cPA==
X-Google-Smtp-Source: AGHT+IFizC0efr7164IYuqKyd4UbIfdPDUHiHDMTtn6iFOPpGnCCFhTbF0yibghbHC2BNn3bACBF4Q==
X-Received: by 2002:a17:902:d902:b0:1eb:7832:8d93 with SMTP id
 d9443c01a7336-1eeb01831demr45409635ad.23.1715234240203; 
 Wed, 08 May 2024 22:57:20 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c134b1csm5408185ad.234.2024.05.08.22.57.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 22:57:19 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 May 2024 15:57:15 +1000
Message-Id: <D14VSHM1NK7T.NIK3CLN49192@gmail.com>
Subject: Re: [PATCH v2 26/28] target/ppc/mmu_common.c: Move BookE MMU
 functions together
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <d5d70791bdf598cd28ee70fd058f51c257a2b969.1714606359.git.balaton@eik.bme.hu>
 <D13EMTIRPDQJ.2LCAHIOTN0W5N@gmail.com>
 <090308e7-e3c0-8129-bdae-c2e3a41a2aa5@eik.bme.hu>
 <D149IYMCXH4Z.ZPIXWOVQVOZO@gmail.com>
 <841877bd-04d6-7608-b762-322962afad59@eik.bme.hu>
In-Reply-To: <841877bd-04d6-7608-b762-322962afad59@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu May 9, 2024 at 9:33 AM AEST, BALATON Zoltan wrote:
> On Wed, 8 May 2024, Nicholas Piggin wrote:
> > On Tue May 7, 2024 at 10:31 PM AEST, BALATON Zoltan wrote:
> >> On Tue, 7 May 2024, Nicholas Piggin wrote:
> >>> What do you think about adding mmu-book3e.c instead?
> >>
> >> I have considered that but found that some functions have to be in the
> >> same file and declared static for the compiler to inline them otherwis=
e I
> >> get worse performance. Maybe after these rearrangments it's now possib=
le
> >> to move these out but as this series got a bit long already I dod not =
go
> >> through with that and left it for a follow up but I can give it a try.
> >
> > It would be nice.
>
> OK I've done that now as this also helps with some of the unint warnings=
=20
> but I could not get rid of all work arounds completely.

Great, thank you.

> > What host machines are you using? I'm surprised inlining is causing
> > so much performance unless it is something older or in-order.
>
> Maybe it depends more on the compiler than host. I still use gcc 10 with=
=20
> default -O2 level. Some people found that -O3 and LTO may help a bit but =
I=20
> test with default QEMU settings as that may be what most use.

I was thinking just the cost of call/return should not be great.

It is definitely possible for inlining to allow compiler to make
more significant optimisations.

Since you're looking closely at performance and probably nobody
else has for a while I have no problem with it if you find it
faster, mind you.

Thanks,
Nick

