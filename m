Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D21DEE20A6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 15:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voO6k-0007DL-UB; Fri, 06 Feb 2026 10:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1voO6j-0007D5-Ik
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 10:50:57 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1voO6h-0002Ef-Uw
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 10:50:57 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9EA5D600AD;
 Fri,  6 Feb 2026 15:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF08C116C6;
 Fri,  6 Feb 2026 15:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770393046;
 bh=XZw+gjAbNvwomlD1psgmALFMa0fH+mKYBRf3r58LLCU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=DMK9LgZ324Eh31UR8Kef8sHXhY4kwZbd6YioUieEDic4BXuHyt0l4oI0frRRp9SBs
 vqvoN7+OunAkftdmM9W8hJLljrCw/7b/6hf3GoFFaElEE3N679POLvV5JC0KG+zibl
 /RaihGDYqm0vX4jCWTPZmnQrygbYS8XBBwqBOWSpjjZDI3biDDbTIbzFdpp0YO3G60
 p7/yXqWi3WJzuwBbfHnXLnr5wzYt2DikP21lCjzKxeLhTN8nopli98m8NNLX4iqx96
 um53eIFz/MjzcxC6F//X7FhOn4H3sxafkLq4IkY+x0ldy2M7rAu32SVY/kHhWB2WX2
 F2dMrHWyepIvA==
Received: from localhost ([::1]) by mail.kernel.org with esmtp (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1voO6V-00000000lRQ-2PwJ; Fri, 06 Feb 2026 16:50:43 +0100
Date: Fri, 6 Feb 2026 16:50:42 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: John Snow <jsnow@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH 0/1] Sync kernel-doc with newest upstrem changes
Message-ID: <20260206165042.25c941fb@localhost>
In-Reply-To: <CAFEAcA_xbo6J9LTG6w7T0AU1UCjHvYWfC=UKOpfev4X-fGbbXg@mail.gmail.com>
References: <cover.1769701431.git.mchehab+huawei@kernel.org>
 <CAFEAcA_xbo6J9LTG6w7T0AU1UCjHvYWfC=UKOpfev4X-fGbbXg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 6 Feb 2026 15:04:27 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 29 Jan 2026 at 16:04, Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > Hi Peter,
> >
> > This changeset does a new sync on the top of the Linux Kernel
> > kernel-doc changes. It is in sync with latest -next, plus
> > two series I submitted today to linux-doc:
> >
> > - https://lore.kernel.org/linux-doc/cover.1769673038.git.mchehab+huawei@kernel.org/T/#t
> > - https://lore.kernel.org/linux-doc/cover.1769701598.git.mchehab+huawei@kernel.org/T/#t
> >
> > After linux-doc picks my changes and this patch being applied
> > on QEMU, all differences between QEMU and the Linux Kernel
> > version will be only at scripts/kernel-doc.py.
> >
> > With that, syncing from Linux kernel should be as simple as:
> >
> >         cp <linux_dir>/docs/tools/lib/python/kdoc/*.py scripts/lib/kdoc/
> >
> > and eventually add any new *.py file that it is there, if any.  
> 
> This sounds great -- keeping the sync as simple as possible
> is definitely what we want.
> 
> If you could ping me and/or respin the series once the changes
> have landed in the kernel mainline, I'll pick them up for QEMU.

Sure! I will respin it once it reaches mainline (which should
be just cp the latest version).

-- 
Thanks,
Mauro

