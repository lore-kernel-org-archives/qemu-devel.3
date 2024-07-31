Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEC1C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 07:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ3xz-0002ck-N3; Wed, 31 Jul 2024 03:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sZ3xx-0002cG-NU
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 03:41:45 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sZ3xv-0000YU-MG
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 03:41:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-428243f928fso17839665e9.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 00:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1722411702; x=1723016502; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kCBFodUKjthkv8HXKvlItOYmw3rQt0z2W0+ShzVOcK0=;
 b=ViBd8FtayyuHgGtecdo8gUFL7nKZyFhQfRQkaKc4x+RXfnkiixVIBC5zoHbfjpzn0A
 xbDwcmE3VnMHWVSLvQ9TqVuswzeiZSP9GFcwUDprY/sZCi57Y8plBi+ywZb+ZA8Wnx/G
 dfdLi7wgdNY4OApvKmK3on1VLGAytUls9bm7qZ/Hem1zBPOZEeDc46tG6IN5t7NeGl/B
 uSpJSmAiGzANlo8gv6RpOqAfd+66PNWuJpbSgfpJaMtjOLmWtm5WGGqAybbkzFESa0oH
 0UpXTyCAgS9g1b24hm8lKCMq+Cpqv3wPmyt+LvzaD2VAmzYPnOq7zd4UMlPtRmM9w1b0
 cPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722411702; x=1723016502;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kCBFodUKjthkv8HXKvlItOYmw3rQt0z2W0+ShzVOcK0=;
 b=ZwzWSgxZlrOIu+qA2CWgcaYUAbY7bmSavM0Ai4gHn73VHDhDuVasC2MCUUp4W94N6Q
 I97OixlRwwxot4r6Tr7fxgSVGr0U73Zk/nYzk3gDOFiQ2Zc3lfDLy44pcNK6WWM7Xn9Z
 JVrl3gxz1BN98PeCbde39rnMzLvD/yMkDuf1Sqa4r6WIvbWm2z7L70/vIm1YsHdF/ygq
 c5RLIknsuACPumLPdbEB6YgZXX2OJuu+d4bFPO4yguCcySldmGHFF0Kq3M0OaRRlOOxD
 /tZRVop9eZslmied7GMdrBemoPjdxN6WeWeXV9vZvL5NwHPbeXcePda+tUzmWNiY2hsW
 OHrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVD5kSzfD5nHZhiRBqMeOx6qKtd8/4poyQU+/7VLMREUTKf8UP/yHFH6wqzQtBVpzocRdtIaQ8Ow78BY5XBwGHg0kEPko=
X-Gm-Message-State: AOJu0YyGmiZB+oZvUbUEaH/kUF4wC78Z4dTjw/SZHRejVL3K6mtbVSYv
 iiCmesEsJfYnxihw59XqVpwwC9xJKD8Bw/EikuRne+5eOus8CJs51cZQWzgImek=
X-Google-Smtp-Source: AGHT+IGe2RwjIF46PUm0A2D+8YH8pqyVxXaLwJ4Zo6cFO2l/lWqPQth2+tf0aobWzTyB4ne1iLufnA==
X-Received: by 2002:a05:6000:ad2:b0:368:6f64:307c with SMTP id
 ffacd0b85a97d-36b5d045914mr10524827f8f.15.1722411701249; 
 Wed, 31 Jul 2024 00:41:41 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36800f07sm16416877f8f.63.2024.07.31.00.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 00:41:40 -0700 (PDT)
Date: Wed, 31 Jul 2024 09:41:39 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org, 
 berrange@redhat.com, eduardo@habkost.net
Subject: Re: [PATCH v2 2/2] qom/object, accel-system: add support to Accel
 globals
Message-ID: <20240731-b34061e3e3d7ce4c3d76f481@orel>
References: <20240703204149.1957136-1-dbarboza@ventanamicro.com>
 <20240703204149.1957136-3-dbarboza@ventanamicro.com>
 <87bk2ekr8p.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bk2ekr8p.fsf@pond.sub.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x332.google.com
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

On Wed, Jul 31, 2024 at 08:30:46AM GMT, Markus Armbruster wrote:
> I apologize for the delay.
> 
> Daniel Henrique Barboza <dbarboza@ventanamicro.com> writes:
> 
> > We're not honouring KVM options that are provided by any -accel option
> > aside from the first. In this example:
> >
> > qemu-system-riscv64 -accel kvm,riscv-aia=emul (...) \
> >     -accel kvm,riscv-aia=hwaccel
> >
> > 'riscv-aia' will be set to 'emul', ignoring the last occurrence of the
> > option that set 'riscv-aia' to 'hwaccel'.
> 
> The way you phrase this, it sounds like a bug.  But as far as I know,
> -accel is meant to have fallback semantics: we use the first one that
> works.

The fact that some (most?) parameters have override semantics and some
have fallback semantics makes our complicated command line even more
complicated, especially since there's no way to know which is which.
IMHO, always having override semantics and then providing new parameters,
e.g. -accel-fallback (or a property, -accel fallback=on,...), would go a
long way to bringing some order to the universe.

> 
> Perhaps:
> 
>   -accel has fallback semantics, i.e. we try accelerators in order until
>   we find one that works.  Any remainder is ignored.
> 
>   Because of that, you can't override properties like this:
> 
>       qemu-system-riscv64 -accel kvm,riscv-aia=emul (...) \
>           -accel kvm,riscv-aia=hwaccel
> 
>   When KVM is available, 'riscv-aia' will be set to 'emul', and the
>   second -accel is ignored.  When KVM is not available, neither option
>   works, and the command fails.
> 
> Why would you want to override accelerator properties?

Testing. Many properties are only available to allow the user to force
non defaults. The example above isn't exactly what triggered this. The
real use is, '-accel kvm' is the default used by libvirt and when
riscv-aia=hwaccel is possible, it will default to hwaccel. In order to
test riscv-aia emulation support using libvirt (which doesn't yet allow
selecting anything riscv specific), I attempted to use the qemu
commandline element to override -accel with kvm,riscv-aia=emul.

Thanks,
drew

