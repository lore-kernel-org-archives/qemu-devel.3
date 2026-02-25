Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E90FCEE9A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 12:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvDeT-0007KS-Pm; Wed, 25 Feb 2026 07:06:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vvDdz-00079Z-T0
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 07:05:33 -0500
Received: from mail-dl1-x1244.google.com ([2607:f8b0:4864:20::1244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vvDdy-0003iT-7j
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 07:05:31 -0500
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-12776bebe9fso2654387c88.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 04:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772021128; x=1772625928; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZQqL6h0SS5Rw4AMYx0IylGdNWmX4QrEu4ffYa4NaVFU=;
 b=kD7HDMhGgiWaZcspGQ2l510Jp5AVLNs0BluUyPFpsARIfm14LpBP2Vo00Jj+wsR5k9
 x686iriLgWz/HJkVHnLZ8kCvxKeuRlyIEUETZtF7t07/M6OvObfbyzSNJ/g5sXzJ7QVq
 bfFRlYqGiMKihXueMiETDq5pws5Lc3C0sJhMvEFQ3oZbX5X+eZVlzZupu3hPfiqJfqAQ
 cY9KOriqVXHN/N86ovsFfJWzcMC53pOyffgA6XU8ap25FZkiE93nDPtCHRrE9StDqh0m
 jX/39fTUQ0ndA+VMrXWovlo+XXgogBkSKsz+aZ6z32bGlAXDSD/0c3DGZ7hojmFwGSDK
 niQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772021128; x=1772625928;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZQqL6h0SS5Rw4AMYx0IylGdNWmX4QrEu4ffYa4NaVFU=;
 b=fC+MROZQPinlEjSTnZSMHoRD3MvkcmsjNXq7FEqjzWuCVr6Qv4pzEJo204Pf0Bj0Ha
 24teOyTny81Xbf5Ew45nyHzD7NsA2ZfsFHmIpul7gG2Xk9OAwv0Tbfx7mCGpJfOrieJV
 aFKcdAl08sv7AznvdDAYWJBCNBgQfvGrUcWlff4DjdrcAjwXZVdgCdK+PutmtX9BxqUi
 mLY3rp4dtoRODk9g0/av+miUPuDxuM4knqkfoLD0DO+Hu1w43nfIP0ByDvcHJo+QusdY
 xymHNhvma2NNvhY3fhPRdASgDrVsQb8UooH3NrjFOQtbYg1oNB7c0H6H8sZUQgkmyjXH
 XVvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxq+6kfVkLYVD3yqu8mtpZ5gPBW2FM4P92xHaXJo1QbDepB16wOhcn3i2j2wq4hRkEyRvzMtGysZZj@nongnu.org
X-Gm-Message-State: AOJu0YxOf70nUJtmQV2vylIZ+8cSqMDJ70Gcu/dja+71jwU2RqF2cClI
 hrprL9ne6lnlE816iaF/Miglbxjd7HiAI6qzbJYUz5Fx/hojqoGK2AUE
X-Gm-Gg: ATEYQzzb1l6tJS2s5SnFG+XnDDeiI08SZiZIU53OMk79pRCZ/XMK0VRJeItcB1M7Ku1
 PbjgLR5w3SS8ycWIODu/aRInc6c5LzjQ6DqX4HFxaX3OrFcuvrno00grxH4lanadTt5EbQhSodr
 W4fizkZgq8ReGijnh/Iy1BJdDry4h9CBxzGRCbTVADSr1rKjv0j+AgcAOMmTeeZrnYQdR3tclqS
 ci7dnNELTbYq51wDXa2ho594E4x6rimzRVimJjXKaHmVW5D0x+z8sIvLS12jVgE35EkNV/3r0Up
 26ViYXIcHaCZD5W8pFosXRdC3CyYYPD5eTtVOZjaLaWByTsDaxdiwn1U/J8wr/S/9zxucxmsoQn
 yA4itzq4wGwDsZ8k3hxyJPgxqathJI6TMCr9PsFM/vqOb0EfbzcRJyUVZxVc1X1FY9shTlUp4Tu
 9QwJLwqqEehoD9DjI+dtlwwP1NMDjUc2tYhzBxYGGPg3kqm6WQZVR2Hu3kHAa3wJw6oYDf2cQpr
 O6Ay5njfgWq05x6bfdt+dlGqtNZnbg=
X-Received: by 2002:a05:7022:e12:b0:124:9acd:328d with SMTP id
 a92af1059eb24-1278699097cmr67893c88.22.1772021128131; 
 Wed, 25 Feb 2026 04:05:28 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1276afa0bedsm13372227c88.16.2026.02.25.04.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 04:05:27 -0800 (PST)
Date: Wed, 25 Feb 2026 20:05:29 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, 
 "philmd@linaro.org" <philmd@linaro.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>
Subject: Re: [PATCH v2 01/16] meson: Add BE RISCV targets
Message-ID: <aZ7jyWjDt-v3zMGP@ZEVORN-PC.localdomain>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
 <20260225102016.200654-2-djordje.todorovic@htecgroup.com>
 <d03c5416-14a2-425f-a96c-ba340cf79617@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d03c5416-14a2-425f-a96c-ba340cf79617@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1244;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1244.google.com
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

On Wed, Feb 25, 2026 at 11:39:50AM +0100, Thomas Huth wrote:
> On 25/02/2026 11.20, Djordje Todorovic wrote:
> > Add options to compile riscv64be-softmmu and riscv32be-softmmu
> > ---
> >   meson.build | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/meson.build b/meson.build
> > index 8c6c0a9a32..41ad38d184 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -55,6 +55,11 @@ supported_cpus = ['ppc64', 's390x', 'riscv64', 'x86_64',
> >   cpu = host_machine.cpu_family()
> > +# Unify riscv64be to riscv64.
> > +if cpu == 'riscv64be'
> > +  cpu = 'riscv64'
> > +endif
> > +
> >   target_dirs = config_host['TARGET_DIRS'].split()
> >   # type of binaries to build
> > @@ -281,7 +286,7 @@ elif cpu == 'ppc64'
> >   elif cpu == 'mips64'
> >     kvm_targets = ['mips-softmmu', 'mipsel-softmmu', 'mips64-softmmu', 'mips64el-softmmu']
> >   elif cpu == 'riscv64'
> > -  kvm_targets = ['riscv64-softmmu']
> > +  kvm_targets = ['riscv32-softmmu', 'riscv64-softmmu', 'riscv32be-softmmu', 'riscv64be-softmmu']
> 
> I really dislike the idea of having yet another target like mips where we
> have 4 different flavours (32/64 bits x big/little endian). That increases
> the compile- and testing time a lot. Couldn't you do it the ppc64 way? The
+1

Additionally, since upstream Linux does not yet support big-endian
RISC-V, I'd suggest focusing on the softmmu big-endian implementation
within the existing riscv32/riscv64 targets first.

Thanks,
Chao

> ppc64-softmmu target can handle both, big and little endian, no need for a
> separate binary here. And we are going the same way with microblaze now -
> the microblaze target recently got support for little endian, so we can
> finally get rid of the microblazeel target now.
> 
>  Thanks,
>   Thomas
> 
> 

