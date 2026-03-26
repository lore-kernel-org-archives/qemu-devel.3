Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F83E109E54B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 06:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5dsj-0005cX-Jp; Thu, 26 Mar 2026 02:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w5dsh-0005c4-Dd
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 02:07:47 -0400
Received: from mail-dl1-x1242.google.com ([2607:f8b0:4864:20::1242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w5dsf-00035J-LV
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 02:07:47 -0400
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-12732165d1eso935537c88.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 23:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774505264; x=1775110064; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=u6kTyR2kv0n3qJ+AKHIx1k+o7niZD2e3hhZ11ewIj4A=;
 b=A3NOH1Qpqb9UoyMK0uUqFqcqJVqqI6cRJhRGa7s5Zq1bunRJclDzcpygZtWCFEr6X/
 9nUA3zTFN1zC5a+LHcH4T+cnhPeHZlZaqZc2X75NDlj1ND0vtS5Nz5+uSPWZpz9BUDeZ
 KNCGjHNLAF8VbgGdR1M9cDCpemA5IMMRGhPH0XZqLaW1lJnrTLaM0dDJfD6a2OK8H9Xn
 4um7TT39Jn0UTNhCfLe+zYjfSvYTMqm1Hz3CzPflg+DP74/wnP2pbJVrXqzlayb/8E/i
 MfWCZb4Z3x6yLxYLbmzkVq+A9Iv754UOURby9FsXTjEElEfmv6aJ9Zj7Ix2M8TPkiXAe
 i9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774505264; x=1775110064;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u6kTyR2kv0n3qJ+AKHIx1k+o7niZD2e3hhZ11ewIj4A=;
 b=fkaQS59cS6YDNZWBCQ5+EOuKPlpkcGQxK8bhD1ffuX3W4G2HuODhEA/T4p2owwmkEj
 xqs2TpffbsnC8pUYq1v9ch9T2yOuouhTHC6+hV5tB8Cgc3w5WzBNkCwRcXQ13YkHAZhs
 l68MiGJpc0uEgw66k0utQck8lbVO0DK5rOi12kCDBq9NkbfnaOAJb9yMLmX5Wtuh5AjH
 N0dSQvjYJQ8A6zY9JxboknBR6ouHyaXRRp0rDXnh3JxBHY0lBc5VNokc9loPyS0nJlXK
 lGVD5TjXV8SP7aMAOIsGVMBS+LV+DY/G7CLw9sx1m7uE7O6ErsY2C2vXzMmzWgLZtjL6
 av+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV6heWAqivYNI5xvtiIFLFfdMir+XY+ROxaDkKQb2SP1/MselQa+IMh6qh0rOQk0r123ubCbS8AXXI@nongnu.org
X-Gm-Message-State: AOJu0YyLUakKTx+COv6Zvtazy5gEqi4ca9w0JPGUtsuVrv9umtY0uJt7
 M0NVOhsaezhci5yC1gA395t5PArnG6RSBKXyZGzOKEtdt2/yUgyQLVsd
X-Gm-Gg: ATEYQzzSyui55I1iF76BlxvtyUQIM3dtgiL89BUAThxH0Wz0upU1vYC5RdF73hvhHTW
 402polpJrrQCSYm6rZhPjGT+79kEKGGFFtkeag92rCZksyHO8vD0m4Ri9gtnq1Qlx7x1VkQS07J
 iD0g6qNAWI1Qvn3G/zq/f7CeBJIR5PjrhuATcZou3zIEB80nH+CgBhaINMwClZ6737d1v3KD3jf
 N0feoG2FXXAoh0xLddjUGoxYYOZIbz6sbN+x78jBFGmQuyeTlW+NkTp/kpGJgcxkqXOHxjxIClA
 yOq6NRclQYaohOcMlZyWfyP/WziCR6A6cnkfP88sYZLc+hE3nwovlKn6cGglLXhUTuAcJosLhme
 InkPTMycVzgcENQZoIUAi3jtd+ve5aJsnsDB1r3nQHqcv4F0u8azFNmF8YPuacBNuEhNzo4L37A
 CqfS2+i5g2bXUfEidio01QsIOQHZ0+VkXprEdGsUYrXBnpx3+/0yyDBzjXImSv6fX4e5U+LMPex
 H9epgKFcgcRcyc49SdlZfptLXU2i+Y=
X-Received: by 2002:a05:7022:620:b0:128:d39a:b141 with SMTP id
 a92af1059eb24-12a96e71260mr2850119c88.17.1774505263546; 
 Wed, 25 Mar 2026 23:07:43 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12aa762430bsm3020127c88.10.2026.03.25.23.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 23:07:43 -0700 (PDT)
Date: Thu, 26 Mar 2026 14:07:18 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v5 0/9] Add Zvfbfa extension support
Message-ID: <acTIq7M94646OAA_@ZEVORN-PC.localdomain>
References: <20260306071105.3328365-1-max.chou@sifive.com>
 <CAKmqyKP7VKi21xfMAiKi9nmAGaaNdrtH9u=6ktCbWBk7kiRoJA@mail.gmail.com>
 <abKfuTO7zg5d67E8@sifive.com>
 <CAKmqyKOcCKAb2w2t2qYgOevswst75FjzKfihrYP9+odRAsCQmw@mail.gmail.com>
 <abe80eiIC4gXUHxk@sifive.com>
 <CAKmqyKP-42diNbiAwr_qykVTAYgR=Ok2S4dgLwPN5oGuLTQGRg@mail.gmail.com>
 <acSqxQQxnO0HdB8M@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acSqxQQxnO0HdB8M@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1242;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1242.google.com
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

On Thu, Mar 26, 2026 at 11:42:58AM +0800, Max Chou wrote:
> On 2026-03-19 13:45, Alistair Francis wrote:
> > Yes, that's how things previously worked. Basically I think we just
> > need a tag (that won't be changed) in an official RISC-V repo that we
> > can point to. That way it's easy to say "this is the exact version we
> > used to write the QEMU implementation". Then if there is a version 0.2
> > we can easily see what has changed and update to match.
> > 
> 
> Hi Alistair,
> 
> The official riscv-isa-manual repository has added a new tag for the
> frozen Zvfbfa v0.9, as shown below:
> 
> https://github.com/riscv/riscv-isa-manual/releases/tag/zvfbfa-0.9
> 
> The current v5 implementation fully complies with this frozen
> specification.
> 
> Since the Zvfbfa is frozen, should I prepare a v6 that removes the “x-“
> prefix from the zvfbfa property and updates the specification reference
> ?
I think we need a v6 series, usually it's fine to implementation
after spec tag is release.

That said, we should defer to Alistair's thoughts on this.

Additionally, my new debug spec series can be sent upstream later
(base on the zvfbfa tb ext_flag patch), once zvfbfa ia all ready
and pulled.

Thanks,
Chao
> 
> Thanks,
> rnax
> 
> > With the seemingly infinite number of draft extensions we need
> > something to manage the version and compatibility, and that seems like
> > the best bet.
> > 
> > Posting the draft PDF spec somewhere immutable would also work. We
> > just need to be able to point to something that won't change and
> > represents some sort of "release". So a git commit doesn't seem like
> > enough, we need a "release" that everyone can converge on.
> > 
> > Alistair

