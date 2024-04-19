Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E09C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 18:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxsrW-0001B7-RN; Fri, 19 Apr 2024 14:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxsrU-00016u-2Q
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 14:21:25 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxsrS-0005Zv-7d
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 14:21:23 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2da08b06e0dso27997481fa.2
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713550878; x=1714155678; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=msuRc3wT3zWdh9DnVbFEZvZWCLNg4p0fNJLQnwnpS3Q=;
 b=aIuL4JhITdKtrEMyOfYhTbJ0TE7gvOBFNhc+BmYabDiHxEZscprUuu3ErYPjiXlhtx
 /OEAWKMkgOol6zY3dcX8O8Q7WN2+FzJSQAg1N+i6KreNF3DR+c3kK2XpcW+FC8YT9tP2
 h8+vtpy/hHXx+c+6WqP8kmnfGMFPcFUcHLZQX3jTrfTcYyv9ey7/x2Jj/a6zc3YKQaKN
 0CDxbA27/0lg1F7nHGn8DbmqcEPOFr2jZgLDYc8O1I+VXNiq2mntPDLzrCy0n9Iq0r6h
 ey/ZWATuYrOuKpirnNQTGQOTiQdpx9MB2qJr/qaf+Iue54ywf09OQVyRZ4cswVOn2hT2
 ohbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713550878; x=1714155678;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=msuRc3wT3zWdh9DnVbFEZvZWCLNg4p0fNJLQnwnpS3Q=;
 b=iMlezdNS2AHqofNi57cCSW403XOkmnWT1uWl+oZM4lMaAzGsJzalKyWkURjGE1muyi
 e39odej2jbNOGTvusVTMzpuIV4HUdb+an6gGlerxf143/g+c8n9fLVIXHrSP2Fl8/8/u
 y+zE9JunwaoqhKovULnmV+alAF+0/RJaNsdqaB56Tfoss/dlYvG/fbUWSPJULKeOdN6N
 3K0wgAXOUaJvvhsWhQGKxVjDo47tWkTE5+F5Zf1baoTNPG9MZR/bG74JLc1qwlZi530t
 5oO9JEjpcJ3fITETnMB/267oK6sm+bDdstRvA7J5AfwZoAEhOM0+KusQ9ar+7U6Jqcbq
 vk6Q==
X-Gm-Message-State: AOJu0YySDbn4sPhgHcx1zm/NjjRtCmuWaLY0g+mbwjDruQJOkuNZMGVl
 1OX7K0hMD+quewgoBFmi46RgDpXDRAwkkz91+cLawKWQQ151y8rlzRaC5ZiBe94sZbgg5CczrwN
 NgQy4BwJd0BdLQ2yBjF5NIjPpZXUlGt7WXtf7Gg==
X-Google-Smtp-Source: AGHT+IEQ5TjlPgBFMN8SmUtxQ4+uXbJ4cZXCjWjMdghQNj/7sOm3GiPIZjp2PfL13zBLFj6IggMF23pqwksX2WGo8nk=
X-Received: by 2002:a2e:9b41:0:b0:2da:bbb5:2839 with SMTP id
 o1-20020a2e9b41000000b002dabbb52839mr1725847ljj.11.1713550878493; Fri, 19 Apr
 2024 11:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240419084812.504779-1-thuth@redhat.com>
 <20240419084812.504779-4-thuth@redhat.com>
In-Reply-To: <20240419084812.504779-4-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Apr 2024 19:21:07 +0100
Message-ID: <CAFEAcA9c=wEn4sS+Aeasnkp36Wx6F19QXc2xOtzryUWKkMXZWw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] docs/system/target-sparc: Improve the Sparc
 documentation
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
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

On Fri, 19 Apr 2024 at 09:49, Thomas Huth <thuth@redhat.com> wrote:
>
> Add some words about how to enable or disable boolean features,
> and remove the note about a Linux kernel being available on the
> QEMU website (they have been removed long ago already), and the
> note about NetBSD and OpenBSD still having issues (they should
> work fine nowadays).
>
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2141
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/system/target-sparc.rst | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/docs/system/target-sparc.rst b/docs/system/target-sparc.rst
> index 9ec8c90c14..54bd8b6ead 100644
> --- a/docs/system/target-sparc.rst
> +++ b/docs/system/target-sparc.rst
> @@ -27,6 +27,11 @@ architecture machines:
>  The emulation is somewhat complete. SMP up to 16 CPUs is supported, but
>  Linux limits the number of usable CPUs to 4.
>
> +The list of available CPUs can be viewed by starting QEMU with ``-cpu help``.
> +Optional boolean features can be added with a "+" in front of the feature name,
> +or disabled with a "-" in front of the name, for example
> +``-cpu TI-SuperSparc-II,+float128``.
> +
>  QEMU emulates the following sun4m peripherals:
>
>  -  IOMMU
> @@ -55,8 +60,5 @@ OpenBIOS is a free (GPL v2) portable firmware implementation. The goal
>  is to implement a 100% IEEE 1275-1994 (referred to as Open Firmware)
>  compliant firmware.
>
> -A sample Linux 2.6 series kernel and ram disk image are available on the
> -QEMU web site. There are still issues with NetBSD and OpenBSD, but most
> -kernel versions work. Please note that currently older Solaris kernels
> -don't work probably due to interface issues between OpenBIOS and
> -Solaris.
> +Please note that currently older Solaris kernels don't work probably due
> +to interface issues between OpenBIOS and Solaris.

If we're touching this text anyway I guess we could clean up the
grammar: "don't work; this is probably due to".

thanks
-- PMM

