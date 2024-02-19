Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0BEC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 11:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc2An-0006Xg-O4; Mon, 19 Feb 2024 06:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rc2Ak-0006Ww-70
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 06:50:58 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rc2Ai-00044E-Dy
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 06:50:57 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-563d32ee33aso4076654a12.2
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 03:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708343453; x=1708948253; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wRqMCBzf+R3oPVWN5HPILjOg+0s4Zpcn1+zkzkrhkXQ=;
 b=BvMM8l0wmHQ8FzFq5zY/vdOYQVxV0Iw55ayAjkeeEtM3zpAaCQ/qT3758HP3u+WFeD
 ZhMzhDCUaPntsyci1wx2ZS0MEMpeYtY4MXbqzScJKcdvT5DwlhwtA/cgxdp+fkOA7neJ
 gtkABXa/2Eu+GtAfhUSyfMNEsSpY1e5Nw8AWYXmo61uN+p+YSAPJgc1kchubahVVdhLM
 FwDofI2bUWyOL4Npuj0RMNL4Ar3P2+gdz1ADl/Ake0sGTAQd3xh4TVfVliaB8yFwSSUD
 lAm7LWqehI9kTKt7mVgMzavj0R56tnB9ut9VLhDlHUycts9GyNEbyitfnusgB0VTqYIu
 YO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708343453; x=1708948253;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wRqMCBzf+R3oPVWN5HPILjOg+0s4Zpcn1+zkzkrhkXQ=;
 b=lfvl1h11GAtvgI5kSq9r4atHKUJM890TX91P/EDklfWCebvOLDsGM20J4UY1/T3gbs
 /KHtA8Qygfrf2l9CkDSThaNzGFY884+gKg56ILSC30jTU+yNy6s0sdxEgmRTVfdifNjP
 oGg6CniCJT0TBzLp5O+F2VhMLUcUjHSsCVFqfMWQHReLc2vei6FLgIeuFzK0acmTcO9B
 dLUUJSU0QBasEDVcGvPvvW4sKs8GktkeobM2gdnkYyK4Ec5rtPTOiaqN22xRUSEzGbK1
 AEKv0rOuRDB9o0I8n+S4E3Tpi6RwpYOadN8yGgq+KrENSpnbSnVrolIqQGXDtxNwAUWA
 sB5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC2OlMxJl3OBYwuf0/SNvbyFpLWOMh0sYoaUiSNLNKVfUinIzky34hEwfvIJACTj6CsLOy0o8ExZlHRf+mV0T3lscxEfw=
X-Gm-Message-State: AOJu0Yz29qYq7VzRAokiIuXGZkvED4xbOjK/PuJH29hayuYLBjfGKi+Y
 3ZIrLgTk+Sh8ci3XclN6y58OHGpiiYlp2yqgndYlfaEURI4c5utTam0UDfWK6DkT+TQib8NkAmc
 IBhKLPQcvwGQW3G2sEPLkmSFI8l+aeohjW1kT7LtCAZcURys+
X-Google-Smtp-Source: AGHT+IEhN/N8srsegjmd62Nb46r+QdlqWsvsBnavJVQa6/fsW9epm6qk4NmB8JLwpKb908Muh40YJqXPthpU+2PGZLI=
X-Received: by 2002:aa7:d64d:0:b0:564:42e1:fa93 with SMTP id
 v13-20020aa7d64d000000b0056442e1fa93mr2860424edr.25.1708343453519; Mon, 19
 Feb 2024 03:50:53 -0800 (PST)
MIME-Version: 1.0
References: <87y1hspiyh.fsf@linaro.org>
 <alpine.DEB.2.22.394.2308301745530.6458@ubuntu-linux-20-04-desktop>
 <CAFEAcA8Ziov9vA9dW+4vzFE=KkSUqfMNNMZOtvQhqCXyjRytzQ@mail.gmail.com>
 <87cyz3pmgz.fsf@linaro.org>
 <CAFEAcA-m8G1kfTw52kOGPEvQwWPph0NWc0URVY1aQ2WwVeB_OQ@mail.gmail.com>
 <799b1754-7529-0538-1b5a-d94a362eb74d@amd.com>
In-Reply-To: <799b1754-7529-0538-1b5a-d94a362eb74d@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Feb 2024 11:50:41 +0000
Message-ID: <CAFEAcA8UwpWzD=Z1syjWPcpRev0OLSMnfyqqYg=9UEQk05s4yQ@mail.gmail.com>
Subject: Re: QEMU features useful for Xen development?
To: Ayan Kumar Halder <ayankuma@amd.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Xen-devel <xen-devel@lists.xenproject.org>, 
 Stewart Hildebrand <stewart.hildebrand@amd.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 Sergiy Kibrik <Sergiy_Kibrik@epam.com>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 Vikram Garhwal <vikram.garhwal@amd.com>, 
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Thu, 31 Aug 2023 at 11:32, Ayan Kumar Halder <ayankuma@amd.com> wrote:
> On 31/08/2023 11:03, Peter Maydell wrote:
> > On Thu, 31 Aug 2023 at 10:53, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> >> Peter Maydell <peter.maydell@linaro.org> writes:
> >>> On Thu, 31 Aug 2023 at 01:57, Stefano Stabellini <sstabellini@kernel.=
org> wrote:
> >>>> As Xen is gaining R52 and R82 support, it would be great to be able =
to
> >>>> use QEMU for development and testing there as well, but I don't thin=
k
> >>>> QEMU can emulate EL2 properly for the Cortex-R architecture. We woul=
d
> >>>> need EL2 support in the GIC/timer for R52/R82 as well.

> >>> (What sort of board model would Xen want to use it with?)

> >> We already model a bunch of the mps2/mps3 images so I'm assuming addin=
g
> >> the mps3-an536 would be a fairly simple step to do (mps2tz.c is mostly
> >> tweaking config values). The question is would it be a useful target f=
or
> >> Xen?

> Yes, it will be helpful if Qemu can model this board. We have a
> downstream port of Xen on R52 (upstreaming is in progress).
>
> So, we can test the Qemu model with Xen.

Hi, all. I just wanted to provide an update on this. We've now
completed the mps3-an536 board model, and you can find it if
you check out the head-of-git QEMU. The new board will be in the
9.0 QEMU release, but if you have a chance to give it a spin now
we'll be able to fix any bugs or problems with it before the release.

The documentation for the board is here:
https://www.qemu.org/docs/master/system/arm/mps2.html
and it lists the limitations/missing features. (If any of those
are important let me know and we can look at scheduling the work
to fill them in.)

I'd also like to draw your attention to the note about the UART
ordering on the AN536; unfortunately the hardware setup is a bit
awkward here, so if you have an "I don't see any output" problem
make sure your guest is sending to the same UART you're asking
QEMU to show you the output from :-)

thanks
-- PMM

