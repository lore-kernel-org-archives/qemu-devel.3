Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9988C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 04:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrsCb-0002Vf-K0; Wed, 03 Apr 2024 00:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rrsCZ-0002VP-3V
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 00:26:19 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rrsCX-0000BH-Cx
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 00:26:18 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e6b729669bso5070823b3a.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 21:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712118375; x=1712723175; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RyXxfuKLKWQwWMCsdFmuwlvd61I3gTDKkeA2dhHjJgI=;
 b=YKs3lJ63wQ1qmRV7eQxPvqHnPkSVbOCYAy6FT56COj4rXXwoT5r/GKsslegjvcdsa3
 gsJwXm+fCiHGfpiLbRuDYPRAt+t7Z62dLP3xSwSVFJU4PG4wnCFwchf3nlpNLIpuyw2o
 obXMhMiUYtJUO2lHRozsGbQ+0K48jxRXrf0uP855ZxynAUqvDywIHTOrhEIZ+cQevZy1
 9WGGpZ5vpQMteiyG66QPXTZ1QkNW/Tp6yrsNSVK/Of8vCzBdyrYcmt7rsDa3MFdFUWh/
 kThaPD83FgMtr90MQuD2IlW0mAcq2Ko+R07I+LoYNZvr5lICptCT7ZeIP+vy/YyYls84
 px1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712118375; x=1712723175;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RyXxfuKLKWQwWMCsdFmuwlvd61I3gTDKkeA2dhHjJgI=;
 b=c+eetJJbbOmIyIu8rheXhyFHpEH2YVCb1eQD/Pm3whVl0jcrfYCZmm/BCpG8HrvnR+
 xSXdCOIIiYbCKEYVuj+m15rd+NjVk/+WvgClFW/FGKtO8cCnh3af6A5Nnzmb08GcKH4g
 ft726GOgQgBalp4vIgR2wPM80P6Dzn+Bwx5goLFXYnOYshGAEsmPYKrukUEjt3e3Spqu
 07trCTPFnVWHiOfkMTyyuTxKLNqeN7IUlgXzqbmy6KPgNDYLhQ+97Ccu2I34LBSXnc0l
 lhMx3jbkkylB+kO9EdUTjTPT437MNl5bfFBHncKciiOlWI+IgweDyKSYLnbVqRvsXjVm
 pNdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+lIo3EXDkR8pvEVNBrzlqxM8QzQFONAMqV6lTLhi7o84ZuSbMUr4QRNKj0Ey+woQkNPO5Xfe1q3x2pv13Whsa7+5V5vw=
X-Gm-Message-State: AOJu0Yxz2oH/BuJUeY5FDuT13pvnl0JQc2JqCwnbmRRixmVm5RDo/ZLs
 LcwrHGvH6/YGEiEEe6i3GAP9LVAFpVOqqCM3YT/M5q73FUFMBuYB
X-Google-Smtp-Source: AGHT+IGRTIij21KL025AmjtilKTZR7FDSCBx36pBTvkrz3ZvOGtZyb6SRqEGACx4WP2R+J3C2uMxxg==
X-Received: by 2002:a05:6a21:329b:b0:1a5:6e7a:a757 with SMTP id
 yt27-20020a056a21329b00b001a56e7aa757mr17426344pzb.4.1712118374804; 
 Tue, 02 Apr 2024 21:26:14 -0700 (PDT)
Received: from localhost (220-245-239-107.tpgi.com.au. [220.245.239.107])
 by smtp.gmail.com with ESMTPSA id
 k17-20020a170902c41100b001def175bbbfsm12052700plk.251.2024.04.02.21.26.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 21:26:14 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Apr 2024 14:26:09 +1000
Message-Id: <D0A7B4JIC83S.11ZQB4F1M3TM3@gmail.com>
Cc: "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, "Madhavan Srinivasan"
 <maddy@linux.ibm.com>
Subject: Re: [PATCH 0/2] P11 support for QEMU
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Aditya Gupta" <adityag@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240401055503.1880587-1-adityag@linux.ibm.com>
In-Reply-To: <20240401055503.1880587-1-adityag@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

On Mon Apr 1, 2024 at 3:55 PM AEST, Aditya Gupta wrote:
> This patch series adds support for Power11 pseries and powernv machine ta=
rgets
> to emulate VMs running on Power11.
>
> Most of the P11 support code has been taken from P10 code in QEMU.
> And has been tested in pseries, powernv, with and without compat mode.

Thanks for this.

I wonder if we could try to get rid of some of the code / structure
duplication for creating a new machine.

I don't want to add a bunch of CPP generator macros or squash too much
code together with lots of flags, but maybe there's something we can
do. Since this is a very small change from P10, it might be a good time
to work out some refactoring.

Even a hw/ppc/pnv_powernv10.c and hw/ppc/pnv_powernv11.c, and
target/ppc/cpu_init_power10.c and cpu_init_power11.c might be an
improvement because you could easily diff them (hopefully we could
do better than that, but just a thought).

Thanks,
Nick


>
> Git Tree for Testing: https://github.com/adi-g15-ibm/qemu/tree/p11
>
> Aditya Gupta (2):
>   ppc: pseries: add P11 cpu type
>   ppc: powernv11: add base support for P11 PowerNV

