Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95494CA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 13:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umBjP-00008z-Br; Wed, 13 Aug 2025 09:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naresh.kamboju@linaro.org>)
 id 1umBjN-00008g-GY
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 09:41:29 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <naresh.kamboju@linaro.org>)
 id 1umBjF-0008B7-Rr
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 09:41:28 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b3226307787so5376460a12.1
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 06:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755092477; x=1755697277; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BuoYHGYkCh033zSzlMciRVTnS9J8QMWvk5NZ+OdGx/A=;
 b=OaMqg3sHXqvPzjyUAreZu6q8Mk+v9dZnDELwGvj6v0BgdK2aXhwPWiN1Gfy8M2eGsJ
 MiMP+KG8Aw/HHAjE6zhPBY3dRB3yQ0XK1VyPOTVmqczH1KqVRPDjJVukP0WC7Txf3Y5H
 8/QDb5wAsZiyawX/P4mtE/9Mq1GCXoJyCNxsBxjwry3rqagzlVRWIfYdZRiyFsQatThg
 QfvSESXdUckrfRGX+crE3L7ikx1hXI2d1ZRAhRmN0p1OSCKYADBiNZM6dgn538rCsSVE
 07mvicCL5oo/9+n5j5N2wDvJIS0Q30WMm5mj/cdvXtJ6L5ZjwWnj9NbvdqRYnsFc9zXf
 e6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755092477; x=1755697277;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BuoYHGYkCh033zSzlMciRVTnS9J8QMWvk5NZ+OdGx/A=;
 b=pFErXk9Bc/6qrQFV9PEqkUHg1VIWgpqKWtmNWi+GsUEVlzdpgnJvNjLsWwyMrL3VT/
 hma2450WgEHmDC8vj1H81oAHnedqRYsJn3UjPBdsvTrJ99wgioY7jmqxktjl1eyiBoUH
 RH/bxJ7p9v07XIiiC65xWMQ+bcZh3M9gcYgQSNJc7u4JOnOLqoXNV7/pIZXi+4KVYxtI
 BkDShgMD/ilr4etsGG9Dx6rctXiObJoZMYaGNWRXm4FGRQE9BtILoicBXH2/Wa/f2b0t
 +sjZWUwKD1ITekOs5dkzz8OgONFrrlZQbmNpXCgIXvzOX3E/kSfPjdyog6AyFr8FMKzu
 DOWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0Eub98f6yxWvqTbxYfKJcHqVCH7JdgAvMPgd0fx4mWe/D3f0a+nQ4kG0olnDBicsBoKou0KiDzFjr@nongnu.org
X-Gm-Message-State: AOJu0YwKW6JwuuxwdBWO985w5d8ZxgJeL8oz9HaHMZCN4LbPBkvWzv9e
 9UB5hnB2M+YFQJvAU/lWkrYgOAMJa7Uldl/t6FWMi+L8N1GEUeI/rqbFja8nlgJMUo+kMt01+jR
 ISNYS3AsEjvGNLViL7cnXOq+bhV+yQbk0+UvtwpSiSQ==
X-Gm-Gg: ASbGncuLNxiiFt+rwxxblwgHAao7kmsdtXW22H05vKMzmUWM1jvJPb6F1WenDjq6vsR
 76EngyBnuhrZrA+ZfSLW5yDr5OR+Ft+ktY6QmCUWnpMflJpPpx3En0b9f19+J3FH7QXWeDr6XAU
 kjUMci3xyKfml3SYyB+qtqlacFE0wEA1+TlMVqvI43tA1FFD1Ral3+NkU2LZyyPc8aqQuHE1Ji7
 58RqDbPumDUhIrpnmrS69+G+g0YP+zyQ38j5G8Q
X-Google-Smtp-Source: AGHT+IHJ5NorMBOk/mMmvjq4NxC90d+IjwHZjpyxn70pQloc6AgGTp1y/wa+zMeluJYPNCBvRdh21gvKSjV030UR2Pk=
X-Received: by 2002:a17:902:f785:b0:23f:e51b:2189 with SMTP id
 d9443c01a7336-2430d0f9a4bmr54705775ad.17.1755092476818; Wed, 13 Aug 2025
 06:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <bf9ccc7d-036d-46eb-85a1-b46317e2d556@sirena.org.uk>
In-Reply-To: <bf9ccc7d-036d-46eb-85a1-b46317e2d556@sirena.org.uk>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 13 Aug 2025 19:11:05 +0530
X-Gm-Features: Ac12FXxKeYVh06szquTrecWrS7rqGYyi8ckXtXfcapehmWdAEuqul8ZUWvjf2tw
Message-ID: <CA+G9fYtjAWpeFfb3DesEY8y6aOefkLOVBE=zxsROWLzP_V_iDg@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>, 
 stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
 shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
 pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
 conor@kernel.org, hargar@microsoft.com, achill@achill.org, 
 qemu-devel@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
 Anders Roxell <anders.roxell@linaro.org>,
 Ben Copeland <benjamin.copeland@linaro.org>, 
 LTP List <ltp@lists.linux.it>, chrubis <chrubis@suse.cz>,
 Petr Vorel <pvorel@suse.cz>, 
 Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, 
 Zhang Yi <yi.zhang@huaweicloud.com>, Joseph Qi <jiangqi903@gmail.com>,
 Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=naresh.kamboju@linaro.org; helo=mail-pg1-x52e.google.com
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

On Wed, 13 Aug 2025 at 18:21, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Aug 13, 2025 at 05:46:26PM +0530, Naresh Kamboju wrote:
> > On Tue, 12 Aug 2025 at 23:57, Greg Kroah-Hartman
>
> > The following list of LTP syscalls failure noticed on qemu-arm64 with
> > stable-rc 6.16.1-rc1 with CONFIG_ARM64_64K_PAGES=y build configuration.
> >
> > Most failures report ENOSPC (28) or mkswap errors, which may be related
> > to disk space handling in the 64K page configuration on qemu-arm64.
> >
> > The issue is reproducible on multiple runs.
> >
> > * qemu-arm64, ltp-syscalls - 64K page size test failures list,
> >
> >   - fallocate04
> >   - fallocate05
> >   - fdatasync03
> >   - fsync01
> >   - fsync04
> >   - ioctl_fiemap01
> >   - swapoff01
> >   - swapoff02
> >   - swapon01
> >   - swapon02
> >   - swapon03
> >   - sync01
> >   - sync_file_range02
> >   - syncfs01

These test failures are not seen on Linus tree v6.16 or v6.15.

>
> I'm also seeing epoll_ctl04 failing on Raspberry Pi 4, there's a bisect
> still running but I suspect given the error message:

Right !
LTP syscalls epoll_ctl04 test is failing on Linux mainline as well
with this error on LKFT CI system on several platforms.

>
> epoll_ctl04.c:59: TFAIL: epoll_ctl(..., EPOLL_CTL_ADD, ...) with number of nesting is 5 expected EINVAL: ELOOP (40)
>
> that it might be:
>
> # bad: [b47ce23d38c737a2f84af2b18c5e6b6e09e4932d] eventpoll: Fix semi-unbounded recursion
>
> which already got tested, or something adjacent.

A patch has been proposed to update the LTP test case to align with
recent changes in the Linux kernel code.

[LTP] [PATCH] syscalls/epoll_ctl04: add ELOOP to expected errnos

-https://lore.kernel.org/ltp/39ee7abdee12e22074b40d46775d69d37725b932.1754386027.git.jstancek@redhat.com/

- Naresh

