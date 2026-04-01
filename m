Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF1AD35165
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 16:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7yDK-00007A-Pu; Wed, 01 Apr 2026 12:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanyaagarwal25699@gmail.com>)
 id 1w7yDH-000070-IG
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 12:14:39 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanyaagarwal25699@gmail.com>)
 id 1w7yDF-0007tc-Vh
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 12:14:39 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b982b0889d8so868878266b.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 09:14:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775060076; cv=none;
 d=google.com; s=arc-20240605;
 b=LGnRIMlUbX/lEVm0kI54N3krGSGKZo4ZXc4JCk51XqjRHGqXCbp1zDs7sj0sN6dtEW
 T7i/Ri31ns0KTNOVFsvXt+jyUN8KFvIkKCaFWuR7yHqrPgHA2BflURDRRn7NwtnAvwqm
 DFwE3b57CXfuF5lt8oYe4kQPHWREBoaCaQHD3M3nEHYWBKOo7K9qPvjzZ3lP/nXGLwy2
 Hkd9IlKm1B1gj/tCcgY/jW1HboZdrinkpWVWgzNbH0pFtp3JlMM/geMK2wunYA6RT1wr
 futu8dl/jqFkeTKXkwns5LjAy8wrCyxFZoQWgXBs6hXu0pDgMXFWP6OtPv6J5THxhPNm
 UiMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PYwgvqAUFoUi49bQx5VbRgVI0jPJeT5sjDn1FtTkbIU=;
 fh=0si1Hh4nlDNfLQccW5Z8sgNNcMWIxZMhHH3eigpXvy0=;
 b=feloR4twD2M6F6Go6U5d5DW8M+CK+NnKceabNG5ej4pcpgs8xSYyC7JJ0GmYMRZHwf
 zxg4Bf4F8p7/QHPi6ws/4pcKW031ytGpiC7NCBw+W/eO2+JBuQ5AwSg9c/U62VaGZbaI
 azhrUXNeCyjSrxkv/fRyEhv2NfMYo0gWiudYoL1vXmfY7SyTFRFcVw1L3hqSM7Mp9xfY
 /GJZ6Ie2i3lJ0o0hdqf9S6EOIarPc+4QtxrsS69d/2gju19l3p3T+ZtMtQHACR1UTyDB
 Zepon+XQBwjs8FW40XKtWioOpkYpMBGj6tUY5Db9dnti2RUjZ+oCDrQmNeQY8gjVPVi+
 6Emw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775060076; x=1775664876; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYwgvqAUFoUi49bQx5VbRgVI0jPJeT5sjDn1FtTkbIU=;
 b=nbpHke9+ewwtryqoD2FEMThPve3qAru9F29YMHfte5HQL4LHPAMW9XkN7ttreoDbS5
 qj4ukImAbuIAl/kCwL05HQfDCYAnW+0igIO86sd2yDD5TKIYmxSWLfXwETC1YoIv9vI1
 8NynMoJhKm6lEzYc5MAtEqAwmlr+jyd4bvpJ6VwG2ibv0wtF6OygDmLOAo1evMA4ZFpr
 XiJMIEZcz7K6XPmC7Wqk9q4md38/5FGyVFXDGpJaACh1swFx7vk6sI8drY61p5dOAzjr
 zsbIPBkbsrp5FIhs0b5c1hReABQDv77R+0Kaz9oRFhee+6hBGr9TMLVETejPeo3gsuNF
 ibOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775060076; x=1775664876;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PYwgvqAUFoUi49bQx5VbRgVI0jPJeT5sjDn1FtTkbIU=;
 b=SkadG/hunLyYAvP7c0ZA7e30kxmmKDiOjfxOc6xnTI6XcQMIaRv/V3LBfFYaH8PBf3
 qbVJUV+AYrSUxmTTc/Nqaq3t+xyR3Hv97/XhWbDeErXccWZ+1W9XMMjoSJvMw20yZvtB
 WtFzNQ69xTX/dtZyGKICll6ZDYiK10sRYcHM3rrtRWuBmS4rFd1vubTVzJ7QyKt75d9+
 pK9FPFAPDZGgf6HnTB/xFc6HGrqqz0CiWO30JfO1mih9WA6ySxF8RtPQkIF/hkx+BrFA
 2eggq1WAbza0+BXahJkBIrou4DOaGb3zcLoUXhdprYpjNOJ27MrdBdvSkVMxC1jLR3ht
 5jSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU2RZIxXD/4d1krY7daLvOJVfhDs2t4MA6qb/QXXQrpzptF5RHOrcJBf+t9v7qd0ESavP08hY8K5hC@nongnu.org
X-Gm-Message-State: AOJu0YxgXW5KFzo8KszW+3ZId4cDTW8Ah3ifwUjXc7fE2ZSvxWLymeIZ
 p9ncC01Atvmssv6pjLImtnsahdjAA820ov0Pt2p7ExqTewaOAMxWCIQlDFsxre2EguSB/U7SIJN
 D9H/iFJ9pf/hChanIp5DdA0PSR5fVfqw=
X-Gm-Gg: ATEYQzz0jYQntvuq4RwWOZQLtU8RC0GW72CKtNLMMvBwjfe5GKqF4DoMTuz0UiB+ZJA
 +u58Ld8hyWP7taKWV4GAEm1JrDum2znNkyuoYkxO+K10gdkd6VzwR8axTxIN6UKjEE+3+BMgZLu
 KIQTQqwLioKcSw9S4LjcEEkOUMleBWldItd8SNRzagepcdLDQmyIFi5mRWEY7rVor5QWt46WXO+
 xb6TPHT7i0Y6s+oZBCpxQqzlhA81maIYVPTfogFNb9r8FmgXsl4OQD53dKJkrfedfMqgxd3Cee8
 tdYUcHruomoT1BaUqsfgiNrYoqYbkTaxGxodXhwxHkUL3bksw2ZAfxnXH2nBUdTCxFpWg6XMac+
 /r9pi3cHVh6I0x2Tue5vjmf/krx8=
X-Received: by 2002:a17:907:870a:b0:b98:3bb8:c0e5 with SMTP id
 a640c23a62f3a-b9c1393b538mr197142266b.23.1775060075590; Wed, 01 Apr 2026
 09:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260328170913.3673-1-tanyaagarwal25699@gmail.com>
 <6c998d7d-e185-47d7-8687-556e9efa7983@linaro.org>
In-Reply-To: <6c998d7d-e185-47d7-8687-556e9efa7983@linaro.org>
From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
Date: Wed, 1 Apr 2026 21:44:23 +0530
X-Gm-Features: AQROBzDrRN3H0keBkwaFXRzXD7GPHrEYy7FkU76G2_GP6OpfB-i5PuHgEVp6m5Y
Message-ID: <CAPdGtUxGLgvbQyHQXaoeCVhBZq195YTtmekJqTvGj=MbCf8pAw@mail.gmail.com>
Subject: Re: [PATCH] target: convert TABS indentation to spaces for consistency
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 thuth@redhat.com
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, zhao1.liu@intel.com, 
 edgar.iglesias@gmail.com, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com, 
 qemu-devel@nongnu.org, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=tanyaagarwal25699@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 1, 2026 at 3:21=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> On 28/3/26 18:09, Tanya Agarwal wrote:
> > From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> >
> > To follow consistent coding style, convert TABS indentation to spaces
> > for consistency.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/372
> >
> > Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> > ---
> >   target/alpha/cpu.h      |   6 +-
> >   target/i386/cpu.h       |  40 ++---
> >   target/i386/svm.h       | 308 ++++++++++++++++++-------------------
> >   target/microblaze/cpu.h |  12 +-
> >   target/sparc/asi.h      | 328 ++++++++++++++++++++-------------------=
-
> >   5 files changed, 347 insertions(+), 347 deletions(-)
>
> Queued via hw-misc tree, thanks!


Thank you Thomas and Philippe!

