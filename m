Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4FCCA0EFC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 10:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjySC-0002ZY-Kr; Fri, 30 Aug 2024 06:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjySB-0002XO-7u
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 06:02:03 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjyS9-00074G-BS
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 06:02:02 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f50966c448so18015191fa.2
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 03:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725012119; x=1725616919; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=agH1A5OLMu1tGcVDGtShfo7up6OwjPkWQS6ZoDf+6Ig=;
 b=oaNbel3JEdx2SYbRxm7Kg6sVmxFJD6WT0BB+2ma+yysAVaPjDsHBB2VirSJtPrTOX2
 b3cpJruaEvXsvm4iuEqZPq3Sjho2FJgStidY1dEJwaOkJDzkNQfiejR4cDHNh0ODZyJO
 ZVj4cvmS7UQpfW2Zk5z17e06da0zzRGQPrNXCzyf5x/p+FVDKBH/R2XCTOBquxKfG9ls
 lvyphtJAoEP9jne3oou5eZcK7etgWB35BeBl5JueTHrTZOvxC7It3r6C3f2cCjkKM4gO
 VbNwGSBxbnTQVqduDkv157iy51A/AdEUabwB0vNFa/24w5yzhl5SSpwyruYCW2Y2ZkRB
 seyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725012119; x=1725616919;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=agH1A5OLMu1tGcVDGtShfo7up6OwjPkWQS6ZoDf+6Ig=;
 b=U/YolZ0fKUNUMuEzPPrQWkE9A3gwFbiLE+Kf6EMaWOiomzHcDGUQIkLc/vm8dYrRCM
 yn1Bq5Wa6OWcXM5T/eTIXhuMets5G1cWCTuXVzsJcAXRHEP3v2tyWL8358sHkAaPLSv/
 Z75SR/PP/9B/nCUp0aJIAX6imvORX1fbq8T42+UF8cB8XG2i2sPM8gbVNs835wA7qyKN
 YNbYErwZUTF1iBs1cU0cBIMxCWnk/we58iQTxCwHzhWjFp4uw68yB2QPl7+gNZfZk7M0
 lXGYCYUTbGHNcDk5ir4WgWsKDPSppeFZZTJVIRi/yrRB3nSa4Oj1OHsmdNRuJmiAEX6G
 GSGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx1lSARizX5tUwmfOOgePBxiTHQ1s6Zs4W2yfgT88hYbW18boqipTZ8jMzlA05Or2KgnEnjZd6meO3@nongnu.org
X-Gm-Message-State: AOJu0YxRPSMyIg8b8yAT7drDYBKOFVJMLLHjuCkCFL8dDsprRauHhT+U
 raRCdbyr5uUI/RP19ppzf366a3ya3gVfLCwLA06h50TVHxDFk6tKhxJk79sJltavwNzBuSsnWsk
 TPIo4gkv2gXjuD2NcsL1vO9aNukccHA9/jg3vpA==
X-Google-Smtp-Source: AGHT+IHDSPBO5uwrwl9b6t8LbrQL+2pIM07EPjHU4CeuMCic6380Stc6oTc55LoCD4IaT/yscbWPdIGt2Dp5M6+Y5mM=
X-Received: by 2002:a05:651c:1506:b0:2ef:2c62:f058 with SMTP id
 38308e7fff4ca-2f6104f32b9mr42821311fa.39.1725012118579; Fri, 30 Aug 2024
 03:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <14c38495-131f-4798-bf41-da442ede23eb@linux.ibm.com>
 <CAFEAcA8FFiiMXTcMR0WRP=Nhw3-+LYoP=X4OYrm5tnrp4L-wGQ@mail.gmail.com>
 <8050216dbbdd0762347d8e14f17d030ff8874283.camel@linux.ibm.com>
 <172467410002.31767.12365606864399178508@t14-nrb.local>
 <172483282308.162301.11735420619446380771@t14-nrb.local>
 <CAFEAcA9c1pAE7gttju5ib470ZhEMjd1=UMjLuhS+gXohnLs=Xw@mail.gmail.com>
 <172499689329.6066.495009881329074086@t14-nrb.local>
In-Reply-To: <172499689329.6066.495009881329074086@t14-nrb.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Aug 2024 11:01:47 +0100
Message-ID: <CAFEAcA8nTAPi9wr5h_V_GZkVV9f-YDV19mi9yybry0wxMyh6Eg@mail.gmail.com>
Subject: Re: [PATCH for-9.2 00/10] s390: Convert virtio-ccw, cpu to
 three-phase reset, and followup cleanup
To: Nico Boehr <nrb@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Michael Mueller <mimu@linux.ibm.com>
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

On Fri, 30 Aug 2024 at 06:48, Nico Boehr <nrb@linux.ibm.com> wrote:
>
> Quoting Peter Maydell (2024-08-29 17:53:02)
> > I repro'd *something*, but it wasn't quite this. I got:
> >
> >
> > [    4.691853] clk: Disabling unused clocks
> > [    4.695419] Freeing unused kernel image (initmem) memory: 6520K
> > [    4.695430] Write protected read-only-after-init data: 144k
> > [    4.695834] Checked W+X mappings: passed, no unexpected W+X pages found
> > [    4.695849] Run /init as init process
> > /init: error while loading shared libraries: libgcc_s.so.1: cannot
> > open shared object file: No such file or directory
> > [    4.697009] Kernel panic - not syncing: Attempted to kill init!
> > exitcode=0x00007f00
> > [    4.697030] CPU: 0 PID: 1 Comm: init Not tainted 6.8.5-301.fc40.s390x #1
> > [    4.697035] Hardware name: IBM 8561 LT1 400 (KVM/Linux)
> > [    4.697040] Call Trace:
> > [    4.697047]  [<000000007ab6ae36>] dump_stack_lvl+0x66/0x88
> > [    4.697081]  [<0000000079e17c2a>] panic+0x312/0x328
> > [    4.697096]  [<0000000079e1de84>] do_exit+0x8a4/0xae8
> > [    4.697101]  [<0000000079e1e2e0>] do_group_exit+0x40/0xb8
> > [    4.697103]  [<0000000079e1e386>] __s390x_sys_exit_group+0x2e/0x30
> > [    4.697105]  [<000000007ab9526a>] __do_syscall+0x252/0x2c0
> > [    4.697113]  [<000000007aba8840>] system_call+0x70/0x98
> >
> > Which I guess could be caused by a different corruption
> > of the initramfs ?
>
> I think that is the problem, just a different symptom. I also got this
> sometimes (in random libraries all over the place).

I ran overnight with none of the patchset applied, and it never
failed (as expected). Running with just the first virtio-ccw
patch does fall over fairly quickly. So something's up with
that patch, which is curious because that's the one I thought
was a straightforward conversion without any complications :-)

I'll investigate further today, I have the beginnings of a
theory about what might be happening...

-- PMM

