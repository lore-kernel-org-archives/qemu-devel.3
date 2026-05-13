Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2ABCD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 14:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNB0y-0003zN-8h; Wed, 13 May 2026 10:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wNB0s-0003yM-Gj
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:56:44 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wNB0m-00088m-6R
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:56:40 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-365cae89bf5so3043370a91.3
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 07:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778684194; x=1779288994; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FD7xsXNN8u1cKDfuadp/1KjIkrHVEWECYihdPG7KX+8=;
 b=bmlW0cUhQjpNcOCRrjFpGwXhezbobSr41ZRdvvJMbWIUnGK/ew5u5KJDz0ePKon7P9
 VQZXo36LUpKxoGfZNQ/HVrHc92VCXm+OiKm1/tuqwULnznp8Apgw5YWVH5POX5ZEtSw/
 Br5gEWaofJZ36w4SXNTBTRs+b1CSsnUiMurDVzhqzoGD3mFbiXF1IwbZh+NLZaCffv1X
 0AK2flNY4LVst4C56cjcu4D5uHtOZ1jKS9JeImzd0GU1yV4b1QvPJTRqrLE3dVvXa46Z
 0v6nhXbAzKpUmrQRowZ43oTqclhD01aS6QDlXQzvHI2a2adSGMw2N2iUqjJ1zY6ihIw0
 NVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778684194; x=1779288994;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FD7xsXNN8u1cKDfuadp/1KjIkrHVEWECYihdPG7KX+8=;
 b=tTZ8Qhk+cChTSm0T3vNtsxWe9sRDkU4X7Vt9RgCFpYKyS3LUd0ybnudFMxUnxfKmny
 h1BkAPB+xMXCYYjzPlNyKOV/gJkW6slknUzJO8mEUdWultLqn0GHd3ilv6JwyfrE96qY
 2GATY2jPkWIUUSi55PkgM3+s5bDX80nADv9qP79DX//Upb7J4xsRs3xqrUOa7GqyxaqQ
 SSKCgEJAEozr54mreZiK/VtGHsZ8tbQFeVP7PAKEyqdZy4DeBHsrN74EdFNsvMs2RO/j
 0gHx4e+WQKQsyt+tmwdwMtfKnf/RFZ4Qx9CYgmzOn0hJ5Xb1AxkunCu31v2t16xj3ngt
 ZG5w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+/46CprGLXMu71KT4cX+pXmosO1nb0DpLuHPPpPoHIm0KdhI8Jv0m5vvjyI1b1EisZ4PboZerjkwZE@nongnu.org
X-Gm-Message-State: AOJu0YybTvRTNEgzQSJmN+fW7b1q4U6EalZttc9VfIc4Z5m7JGlCE/FN
 pNKtgjwHdvzaOqKoT1Dqwhtxhxw6H/6TteIsb75azgsSMj2ib8u8C7KJ
X-Gm-Gg: Acq92OFmcj6tDrimS6/da5pUgttiewn1LyeugOdzzh7TAcTJFZKPos9hBjMLUDRAjtU
 6hwdwH+JmgEQhd6llbVda8ehX4yl7Mo6ftdXOPepyK0ejzFUq8+gy0zXg2iKT07j680NUosNDEl
 X9uCf/g9WJhLlh6T9m05KwrCgmdtdc/GBODGfguCAwM3d+b0Z162gJlHGE+XRJvQytAMuIoIBpf
 EMi950ZjX/ZUdB/dA6D3+wP92eoAjMFRXQgMg3gtpGJjce968ZbA8isyAJCIhXDqwxAfS9T/4XN
 EdNXNRmwzvl9REGcYN1SuTZls49bYk0mSpkjhiBAFDyhs3PiS5AG3Fw5RkiKHxjRaSkFMmFmSl5
 dmHoYeL5SQNmR/Qzv2rE3DomvFSm/82Q1MSSGjKFFn+WyWj6riBWCiKbr5JnhGFSSQJafbM9vAl
 DIlaA/Q7wfZU/Jfb1iyxJbJoBHoZa5NHojWw==
X-Received: by 2002:a17:90a:f950:b0:366:1c9e:99b7 with SMTP id
 98e67ed59e1d1-368f3e3bc59mr4021376a91.25.1778684193949; 
 Wed, 13 May 2026 07:56:33 -0700 (PDT)
Received: from google.com ([118.150.148.19]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-368acbdea2asm3262304a91.1.2026.05.13.07.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 07:56:33 -0700 (PDT)
Date: Wed, 13 May 2026 22:56:29 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, christoph.muellner@vrull.eu,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: Re: [PATCH RFC 0/5] hw/riscv: Add support for Milk-V Duo board
Message-ID: <agSQZXyIqQiF8jgk@google.com>
References: <20260512094614.3464388-1-visitorckw@gmail.com>
 <CAKmqyKMbF=BxeaDRiRPhJjSmwJFnUFLHiV5jTqZc3u2J3KKwbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKMbF=BxeaDRiRPhJjSmwJFnUFLHiV5jTqZc3u2J3KKwbw@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=visitorckw@gmail.com; helo=mail-pj1-x102e.google.com
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

Hi Alistair,

On Wed, May 13, 2026 at 12:27:37PM +1000, Alistair Francis wrote:
> On Tue, May 12, 2026 at 7:47 PM Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> >
> > Add initial support for the Milk-V Duo board.
> >
> > This is something I've been playing around with in my local branch, and
> > I've reached a point where the implementation is enough to boot OpenSBI
> > and reach a Linux shell using an SD card image.
> 
> Great job!
> 
> >
> > I am sending this as an RFC to get early feedback to understand the gap
> > between this minimal implementation and what is required for a upstream
> > merge. I plan to continue implementing missing blocks (like gpio and
> > clk/rst) in future.
> 
> Overall this looks good and is going in the right direction. Being
> able to boot Linux is a great start and a good achievement.
> 
> This could be submitted now, there is no requirement to add extra
> functionality to upstream it. It would be great if you could add some
> unit tests as well, so then we can test this as part of the QEMU CI.
> 
Thanks for the prompt response and the review!
I'll try to add some tests and send out as v2.

Regards,
Kuan-Wei


