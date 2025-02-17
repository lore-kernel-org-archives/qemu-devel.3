Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E299C021AA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 13:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0xE-0007jF-Ap; Mon, 17 Feb 2025 08:14:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tk0xB-0007dv-MR
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:14:29 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tk0x9-0006B1-Rm
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:14:29 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aaec61d0f65so901809766b.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 05:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739798066; x=1740402866; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4zL5WLM+XGGKQbx+Kuz56TgLIbD4ufsTEuFj/QwjWEM=;
 b=jyaxn8/BPkeif1DfN7vyaSEdS8CrUbPwOXyzZfyfPmTuYWnQycVpnXN65WM8mXr4+I
 q5/v0u40QmNp1yzt541KBpPrdosFaXsv7PozCh/iWMBZGs+f9K7eATyN/Oc5+E4NuTaR
 VT3zficITxg+T0vpGAfiPS2kn87B1+++MHuKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739798066; x=1740402866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4zL5WLM+XGGKQbx+Kuz56TgLIbD4ufsTEuFj/QwjWEM=;
 b=pAP7s8FFadkyXUoTbtQMwLLQK8oDpoUeCuwzJvtpoaTn4QvQVzi5Cgh5AkK8OatIXD
 DWlWjGOz2Av10kdH7sOl3nyD6lHpCMRfwrN+DDzxQMWsVfaZsN21KEYqH8zNTXOFXHKd
 QBuBLhkY68kaoqEMnIV0RpxYMQjqEQoiG65iovYhcMWEaVUaEjlYuvBcr5wnDL2ab2oE
 mFImPVzrSiVfbMoSlUJGruZ4MP5hjgYpy7rMJSCSbHPpC+RgGbV8O//MmNjC8Pzc2LlO
 8iyxmSrxk96gLS+MxRkugH8OMmIszQ9C/YSp6BUF3Ueb3irWlR7ZaoiivzmOWGGwIbrx
 niRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE2UhOV+lv7/AQAt6g2K/lMtW+lhHfZxY+Et41lAVp24BmUQ4r6VH7oyMHbV7nKinuG/Gf0Aizs4Yf@nongnu.org
X-Gm-Message-State: AOJu0YxV3MpGolzy5kL59SDcTDjgSqNqh8q9nJiQIY7Hjrc1A27nIFEh
 vM/zGDKac5FuQWfM3Jq3HxpRX2B6fwRd6mSkfk+vqFv5RR/+4WiKLAkJreaWoBj+DXPygW80X3n
 N+YkL0ux9OBbV5mcIG0nRbK3qFNSk8FGVBWgv
X-Gm-Gg: ASbGncsDQTNiLeFruJ7vW9TCtT1mgtehLS1RTz7yFOf/IxFk8SZjFH/lpqCZGmy9Gz3
 q2l8+PlSlTZJaFDTLSK6jh02pnluj5oxiKjPWV1+Qg58aOnMQZPIbjQ04VvSenqdYZIKPzDRaDw
 ==
X-Google-Smtp-Source: AGHT+IF/1iySFLb/kDUQfPf8UNpTdOkk2BDD7dsLGOxxYAC6p1ZDdCRdBybZifO/RAfR1VF2Hil7XBIQDR0v21votOM=
X-Received: by 2002:a17:907:86a1:b0:ab7:cc43:c51e with SMTP id
 a640c23a62f3a-abb70cbbcf2mr866851866b.13.1739798064479; Mon, 17 Feb 2025
 05:14:24 -0800 (PST)
MIME-Version: 1.0
References: <20250216204421.3560012-1-sjg@chromium.org>
 <20250216215738.GF1233568@bill-the-cat>
In-Reply-To: <20250216215738.GF1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 17 Feb 2025 06:14:12 -0700
X-Gm-Features: AWEUYZmUIzyYmihCb9G0hTZMkSSZaMXJeifIx5Ci_JOZ4oG1tkt8BoAi4q1MRs4
Message-ID: <CAFLszTjtgMT6Pd9_MG8t4irU-jyoHTd40MwX5m1iqj4rjVED3Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/28] x86: Improve operation under QEMU
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, Love Kumar <love.kumar@amd.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Philip Oberfichtner <pro@denx.de>, 
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=sjg@chromium.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Tom,

On Sun, 16 Feb 2025 at 14:57, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Feb 16, 2025 at 01:43:45PM -0700, Simon Glass wrote:
>
> > U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but it
> > is not perfect.
> >
> > With both builds, executing the VESA ROM causes an intermittent hang, at
> > least on some AMD CPUs.
> >
> > With qemu-x86_64 kvm cannot be used since the move to long mode (64-bit)
> > is done in a way that works on real hardware but not with QEMU. This
> > means that performance is 4-5x slower than it could be, at least on my
> > CPU.
> >
> > We can work around the first problem by using Bochs, which is anyway a
> > better choice than VESA for QEMU. The second can be addressed by using
> > the same descriptor across the jump to long mode.
> >
> > With an MTRR fix this allows booting into Ubuntu on qemu-x86_64
>
> This seems needlessly not against mainline.

I just tried it and yes there is a very small delta. I can resend it
rebased to -next if you like. I'd really like to get some OS-booting
tests into CI.

Regards,
Simon

