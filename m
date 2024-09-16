Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C8CC3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 12:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqAqD-0005x3-1d; Mon, 16 Sep 2024 08:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqAq4-0005RP-6G
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 08:28:20 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqAq0-0001h9-TH
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 08:28:18 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c245c62362so4873585a12.0
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 05:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726489695; x=1727094495; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qcvCaWUH6Jo/NB4I+8VLihr50CsDOUh5pP9JpWYzQeI=;
 b=BuEd8Sjb+6N8arB7jzYAvk1/9xkoKUGHNDxVPoRp5BU705LnCXF2F/0wl8KLhXOFrG
 ZxD53Rb9+Zh/FtyWH0xFO+RWQZ5lAOwk3woniv/kL4IFqzR29JPpf4xqXgtqacJ1TqKi
 TOV/xY32jLQfk9AIc9I6KuBm4xZi/DIUv30aFhoD/tXMLmC7hfRpt+D8AYiuaTAjz6V7
 mE49VYmg+TCeeZ4vafu0qhwHkumP/BrKsrfZHN+vlhw9Mp+zzn8d478oPX6D/QfMo67o
 I4qOQcx7Zxxt81DUeqPHMQfu+DA+Z8CDbRSlJECXJahK4ZRGD/Wz/DMqr1EnaV3VSq9K
 OvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726489695; x=1727094495;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qcvCaWUH6Jo/NB4I+8VLihr50CsDOUh5pP9JpWYzQeI=;
 b=Q5CLPUnZNUnZFGeLQ6GSurkerkQexScRwLT6IuSVqe8oUKsulBVWI6wgrsREla5E3o
 ydNlwSeRm6dEixC9FWpnS+7Xp0Gbdlv9+crhBXvFbN11OH8X6x643tLT2F4GI0nUf9j+
 Qe8gepiOzjcABhVmxSzQgEnWlU/es27bGyFm2IGZt4E1IlxuWtE+sPnx8/EUrNEi5u0q
 1WYge7JpQUhJb+pBwYIPl9MMogADWhQa5FNxqw3XI5OhCKC9BgsgZ2LE1JRHbBB/RCP5
 AGX61rrK8x4ekB/BF/IwIxPlf65MT/H6EYLW9dWSDFMVbpOIpaoqUMNpc7uX+nTiN8LW
 4lYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAck9je/67dEVyJMRdq9yF1zSf1u+AeqVnWgRfhVuSKYQlNAA4OQYmrkE7Z/mha0RbOQCXTrbOM+Il@nongnu.org
X-Gm-Message-State: AOJu0YweNWNfy/ttS8JQPgloDEGFPheN2AvMpfOY7sx2XrTaJQW0TqxK
 GtShRXPHSA3GPLJMszPud+Fn7dlRbkdNL6JPXERkhrLM+NB67qtCXFSvFnhn3vPXPX5ce5usoKR
 SQGM2gg59yk3dvW2nktqy3EXUjEFpAUwqMigjug==
X-Google-Smtp-Source: AGHT+IGu8a1cl/VKJvG7J8+Q3Ih62IXyOvFLuDN9UuPNWfRAlJKGVQo8tSTr0V4N7G0/iP8Lzq7P8cmUSe6yPaCKASw=
X-Received: by 2002:a05:6402:42c5:b0:5c2:6a7a:5795 with SMTP id
 4fb4d7f45d1cf-5c413e06c05mr13877317a12.6.1726489694783; Mon, 16 Sep 2024
 05:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240909201147.3761639-1-peterx@redhat.com>
 <20240909201147.3761639-2-peterx@redhat.com>
 <441f797f-a377-45de-bfe6-042542c917d8@kaod.org> <ZuRQirmjwWGj1N2D@x1n>
 <CAGNS4TaDVs9eqb9jO5kgi9bL1t1tmc-GywiyP3xpbgFGgvbkLg@mail.gmail.com>
 <0d4c42a4-352d-4b14-905d-ef4839c68ad1@ilande.co.uk>
 <CAFEAcA80SmMbNOhUqgB8h+16RR+d_hOeoVqUCJQZJHvDUtCaYw@mail.gmail.com>
 <10b76006-4cb5-485e-aff2-87c9e511ad2b@ilande.co.uk>
In-Reply-To: <10b76006-4cb5-485e-aff2-87c9e511ad2b@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Sep 2024 13:28:03 +0100
Message-ID: <CAFEAcA-JxRJx8jXuJu4MSLgWw2Ks=3VN7jR2BGYHxxKMQFJ9wQ@mail.gmail.com>
Subject: Re: [PULL 1/9] softmmu: Support concurrent bounce buffers
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Mattias Nissler <mnissler@rivosinc.com>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Mon, 16 Sept 2024 at 13:14, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 16/09/2024 12:44, Peter Maydell wrote:
>
> > On Mon, 16 Sept 2024 at 12:29, Mark Cave-Ayland
> > <mark.cave-ayland@ilande.co.uk> wrote:
> >> I'm fairly sure that this patch would break MacOS 9 which was the reason that
> >> dma_memory_unmap() was added here in the first place: what I was finding was that
> >> without the dma_memory_unmap() the destination RAM wasn't being invalidated (or
> >> marked dirty), causing random crashes during boot.
> >
> > dma_memory_unmap() of something you never mapped is
> > definitely wrong. Whatever is going on here, leaving the unmap
> > call in after you removed the dma_memory_map() call is just
> > papering over the actual cause of the crashes.
> >
> >> Would the issue be solved by adding a corresponding dma_memory_map() beforehand at
> >> the relevant places in hw/ide/macio.c? If that's required as part of the setup for
> >> bounce buffers then I can see how not having this present could cause problems.
> >
> > The only purpose of this API is sequences of:
> >    host_ptr = dma_memory_map(...);
> >    access the host_ptr directly;
> >    dma_memory_unmap(...);
> >
> > The bounce-buffer stuff is an internal implementation detail
> > of making this API work when the DMA is going to a device.
> >
> > We need to find whatever the actual cause of the macos failure is.
> > Mattias' suggested change looks right to me.
> >
> > I do wonder if something needs the memory barrier than
> > unmap does as part of its operation, e.g. in the
> > implementation of the dma_blk_* functions.
>
> It has been a few years now, but I'm fairly sure the issue was that dma_blk_read()
> didn't mark RAM containing code as dirty/invalid, and since MacOS 9 used overlays
> then it would crash randomly trying to execute stale memory. dma_memory_unmap()
> checks to see if the direction was to RAM, and then marks the memory dirty allowing
> the new code to get picked up after a MMU fault.

dma_blk_io() does its writes into guest memory by doing
a dma_memory_map()/write-to-host-pointer/dma_memory_unmap()
sequence, though (this is done in dma_blk_cb()).

More generally there should be *no* path for doing writes to
guest memory that does not handle the dirty-memory case:
so if there is one we need to find and fix it.

thanks
-- PMM

