Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF09C48BF8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 00:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcE77-0005L3-VU; Mon, 19 Feb 2024 19:36:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rcE75-0005KY-IC; Mon, 19 Feb 2024 19:35:59 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rcE72-0003G2-V7; Mon, 19 Feb 2024 19:35:59 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d51ba18e1bso49919115ad.0; 
 Mon, 19 Feb 2024 16:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708389355; x=1708994155; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o2hztUQncJTOuSKyJKDJZqOvT7q5diaQVZZC11llcuU=;
 b=J+4G28w6zjvEuXOoqxnHi0/b2vpcBBdE0Y2uwWreYPpWkvyqZK2KsoCEOTyq8ST2OB
 ZWqn9D+2faBxtKb4HxZlXu0Asv56T7d/eqb5hWTPTDTmlfY8OSWf/bfBA5u31/awcUbc
 NTxXslcv17oHCoocA7WwGKz+SG3xsh11d6pYneUGn3i+cxOZ4w1Aa/cIAa6BHmnrX0if
 /P3qnmu3yKAJHM++5D06UNJf4S52HpNzW7t+9nxJVmpa6IK4XuBRL7prvF1CvXXFGNaB
 gOuZ9VtQuAbmj05iJDQYDrIfxEua8SmMK/PFBSx0mPbwhV5fKf/Rde3xlgg8wyvRcmdP
 GAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708389355; x=1708994155;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=o2hztUQncJTOuSKyJKDJZqOvT7q5diaQVZZC11llcuU=;
 b=JVs4OBUKmEI6hntQ9j4Q5Yc22LdrLfWQ2YYDEWAD0nwwyAoNeuj0JcU4U8/MFR4j3D
 qXilzzsCEy2TL3B9mi3DTaPap8NDgfaUqY+RovVzizrZJX49XsEJ2ubxzlkQm2cjswUR
 NjOqFg5Q4dbeV3QWZB/yragq1nB1nkM9kHKjTeiW9zjKxfI4W3XVbZa9C3aXydHWWGkR
 gNxnQC/LvKq6f+deEP9E9B0DFOUy+Z0M0SCi7AS8m43GN/h9uW8gI6vT7xDUF0r8tvGn
 a7y0KtBW2q7xk8YU18ew9v4f1JqpW0qq0Pk9HfX8AxfshaGWDPh2pPQbfFmwNisqaMcX
 1CXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+M342mgbacjSJNSjfj40uOH5bbZSfEXCgsbFJK2dy/xhHy5TYhAyGAMneP3sz+0zb01ngNZP11nvRQmlUpGC8TNaA0uA=
X-Gm-Message-State: AOJu0YyM9WrWCgQxPVh2EYzSXkJbpUCAO1tP3nnkCAhQZJDmCxjXxNiE
 T9otwsIvYFeKiw1FqFXNUAiO4gYT06L5d7kXk/8NURq58UJyfHgutl9TpUSD
X-Google-Smtp-Source: AGHT+IETj3TvuB8u0MNGWUulBjzksaxujHEFI5X3q78cA8NJaw5vx/+ohSQh409a3n1hvLsHLNmHzQ==
X-Received: by 2002:a17:903:2341:b0:1dc:6db:e268 with SMTP id
 c1-20020a170903234100b001dc06dbe268mr3003898plh.31.1708389354865; 
 Mon, 19 Feb 2024 16:35:54 -0800 (PST)
Received: from localhost (123-243-155-241.static.tpgi.com.au.
 [123.243.155.241]) by smtp.gmail.com with ESMTPSA id
 x9-20020a170902b40900b001d94c709738sm4950074plr.217.2024.02.19.16.35.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 16:35:54 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Feb 2024 10:35:50 +1000
Message-Id: <CZ9HHCWQR3MT.1U5CJ7CBIR1EH@wheely>
To: "Peter Maydell" <peter.maydell@linaro.org>
Cc: <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>, "Glenn Miles"
 <milesg@linux.vnet.ibm.com>
Subject: Re: [PATCH] target/ppc: BHRB avoid using host pointer in translated
 code
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20240215171512.800892-1-npiggin@gmail.com>
 <CAFEAcA_m=xZEh0gS8ttfPiuRGWJrow7A303GiLG44W4LQZ10xw@mail.gmail.com>
In-Reply-To: <CAFEAcA_m=xZEh0gS8ttfPiuRGWJrow7A303GiLG44W4LQZ10xw@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri Feb 16, 2024 at 3:50 AM AEST, Peter Maydell wrote:
> On Thu, 15 Feb 2024 at 17:16, Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > Calculate the BHRB base from arithmetic on the tcg_env target ptr.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> > Hi Glenn,
> >
> > I think I have to squash this into the BHRB series. 32-bit host
> > compile shows up a size mismatch warning... I think it's not quite
> > right to be using host pointer directly in target code. The change
> > of offset and mask to 32-bit is needed due to to seemingly missing
> > tl->ptr conversion helpers, but 32-bit is okay for those anyway.
>
> There's nothing inherently wrong with it (depending on what the
> pointer is pointing to!), but you need to use the right type.

Ah okay, thanks for the correction.

> target_ulong and the _tl suffix are for the type which
> depends on the size of the target's 'long'. The TCG type which is
> "size of a host pointer" is TCG_TYPE_PTR, and you want the _ptr
> suffix functions and to pass it around with TCGv_ptr.

In that case, original approach may be better with small fixes
for 32-bit host.

Thanks,
Nick

