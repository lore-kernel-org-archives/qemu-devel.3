Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F0EC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 10:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCzO7-00009b-4D; Fri, 31 May 2024 06:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sCzO5-00008b-06
 for qemu-devel@nongnu.org; Fri, 31 May 2024 06:21:29 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sCzO1-0001DG-T7
 for qemu-devel@nongnu.org; Fri, 31 May 2024 06:21:28 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42120fc8cbfso8664115e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 03:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717150881; x=1717755681; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IxO6KV7r5MXxmmG+r3E6VhRYcjH+8JvBNIwyUucl50k=;
 b=MQ/AzLzhfXI3zSHxi2PrXH0RNuy7LGdLWcrem6EYxlWlhNv6ftU/BM40hRXhPhW9SC
 cHRrKzXmyq9J+23Rws2G34CLsLDTccDMF2EN9WxClmbHA/TAzAj3N6EGSs2nCA5VfVvl
 i2EWaGFr6CYYHvJgnlunR5PS36A/NW0PULy6yoKqwThgBnqxn63F5wer1SxkImerZkvg
 aEPHCk9IfwIt7uYJjRAJa78Z3+4uQdbxpj1vPISUm9c6n4DtTJ79MFBh7BQ5t4SWiWof
 +FI7wcMWh38DXzAwS1PT6TZY0h014xWr64BvL8uh6fG7YMjU7DBqZBBY2LAQ5aX8kvdh
 ZM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717150881; x=1717755681;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IxO6KV7r5MXxmmG+r3E6VhRYcjH+8JvBNIwyUucl50k=;
 b=NoXyDtrxl0nkiiynhyH4vwqJG5JMXW4XKLji4UD3E90mR+f85osScFBEic6AHedBNe
 tcQGGH4qL9n+YPFnKn7Bw4odgDNSYbuh8arVaJH+eEImK9sJOizn0Larmzyxz6q/vfQS
 g19wTZBcTDJdJ2h6zn0G79cxVgerNiORTqAgiJ+iOiDckZLWUhIork2wgvk1vOb+h4/p
 XSsR3uCW+B0D6t7/cTaCxRwZwO2YLCiEJeL/I+lsvsTbrxr2NCuXN6ooR+PannNycbuZ
 lcBkyFC/lCCF/jMjRBWp1xq6J7fOvSjg9/9p6idXyF4j1S+ee5g1SLQH8RVxWTt8tYIU
 GnHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFjtp+tjfDx/ni1EDA5ybj7NP8TBr3AhaMWil63vmqamJaQysScacH27LZNXUvYf0i+RqT8LAf4gMTDQy6f6Xw6iEvx9Q=
X-Gm-Message-State: AOJu0YyLD2mpoqAgwt+ZXFOpNWcpmyWN8n989+zui/SgLz/tpmmbTNCH
 Jz0iFMNn4TvxtVikXMchCYGLUTwF3FmmtEOCqSYhcY2KXc5O/4GKbJ7ED3SLfRI=
X-Google-Smtp-Source: AGHT+IHgYRDNItq6v49jk9WhHco8JCJWgQ97tzzEEiy7S0JnY6bjJjevSapiHxk6wfNkH91+2QgVOA==
X-Received: by 2002:adf:f742:0:b0:35d:cf2b:9106 with SMTP id
 ffacd0b85a97d-35e0f274187mr999329f8f.26.1717150880747; 
 Fri, 31 May 2024 03:21:20 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04da182sm1516118f8f.54.2024.05.31.03.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 03:21:20 -0700 (PDT)
Date: Fri, 31 May 2024 11:21:35 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Itaru Kitayama <itaru.kitayama@linux.dev>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: Unexpected error in rme_configure_one() at
 ../target/arm/kvm-rme.c:159
Message-ID: <20240531102135.GA40178@myrica>
References: <0C6F517A-5686-4BCE-8D08-1CED02CB470E@linux.dev>
 <4e7aa598-1a5d-47e1-aaa3-78af05947eeb@linaro.org>
 <CB05CAA2-9301-45F6-8AE3-A2E27A160CDF@linux.dev>
 <CAFEAcA-gye9B1yJNKyT0fcZzR7TukNvaQyc7QkKQ_1FUGfAaYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-gye9B1yJNKyT0fcZzR7TukNvaQyc7QkKQ_1FUGfAaYw@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Itaru,

On Fri, May 31, 2024 at 10:57:13AM +0100, Peter Maydell wrote:
> On Fri, 31 May 2024 at 05:20, Itaru Kitayama <itaru.kitayama@linux.dev> wrote:
> >
> >
> >
> > > On May 30, 2024, at 22:30, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> > >
> > > Cc'ing more developers
> > >
> > > On 30/5/24 06:30, Itaru Kitayama wrote:
> > >> Hi,
> > >> When I see a Realm VM creation fails with:
> > >> Unexpected error in rme_configure_one() at ../target/arm/kvm-rme.c:159:
> > >> qemu-system-aarch64: RME: failed to configure SVE: Invalid argument
> > >> test.sh: line 8:  2502 Aborted                 qemu-system-aarch64 -M 'virt,acpi=off,gic-version=3' -cpu host -enable-kvm -smp 2 -m 512M -overcommit 'mem-lock=on' -M 'confidential-guest-support=rme0' -object 'rme-guest,id=rme0,measurement-algo=sha512,num-pmu-counters=6,sve-vector-length=256' -kernel Image -initrd rootfs.cpio -append 'earycon console=ttyAMA0 rdinit=/sbin/init' -nographic -net none
> > >> do I need to suspect first the VMM, QEMU, or the Image? The kernel is built with LLVM, does it matter?
> > >> Thanks,
> > >> Itaru.
> > >
> >
> > I’m testing Jean’s repo at:
> >
> > https://git.codelinaro.org/linaro/dcap/qemu/-/tree/cca/v2?ref_type=heads

Thanks again for testing, you can report issues by replying directly to
my posting, so I can get to them quicker. If you want I can Cc you on the
next one. The latest is:

[PATCH v2 00/22] arm: Run CCA VMs with KVM
https://lore.kernel.org/qemu-devel/20240419155709.318866-2-jean-philippe@linaro.org/

That does sound like the KVM host doesn't support SVE, but the QEMU VMM
version is also too old: in the latest series 'sve-vector-length' was
removed and we use the existing -cpu parameters to configure SVE. Please
make sure that the QEMU branch is cca/v2 to match the Linux KVM branch,
because the older QEMU patches doesn't work with the newest KVM patches.
You'll need to update the command-line as well, because paramaters have
changed for cca/v2.

This may be the case of older build directories that aren't properly
synchronized. They can be removed manually but the quicker way is usually
to remove all source and build directories and start anew.

Thanks,
Jean


> 
> OK, we should cc Jean-Philippe then.
> 
> I'm wondering if this is as simple as "RME via KVM doesn't support SVE yet",
> perhaps.
> 
> thanks
> -- PMM

