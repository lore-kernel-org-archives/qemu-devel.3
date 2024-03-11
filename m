Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A31C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 08:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjb1Y-0003WK-98; Mon, 11 Mar 2024 04:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjb1W-0003W3-BP
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:28:42 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjb1Q-0000Fz-Tq
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:28:41 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-513a81b717cso760104e87.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 01:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710145715; x=1710750515; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kvo1sjEmvcnkJBb64dekgahp1yIbA/J8h4vl+AZ/xmg=;
 b=j908vjmS35kJ2ZgUgXcwbyLKbIwRsgnPoHtd+YquzrfHBDzieVqEsmzg3eq5XrbyCs
 12ZQrx72vCPdP5pI7pp50+RGKWMDIAYeAPsiIEpfUeoj44eZR/yr3Th0MR3sUE0gMiL/
 oBawPqqKCxII9MP+tIbkJcBEaTsdokfdkS+5tmnFrAtGoLvwQ8GkbknfUvjliaLcREz6
 S4d0figEAC1xocE0OH+XkuubYZRAHhuxj4L5cWLWhNyJaDJVgl5JVLsgtgmzoNSQjecp
 N4OSs1gfRqoOXSM3yt9XPwgNxwwCYpdya8eyfXT7EPN47ujKXCkSNs8RuttEt8SV4iVa
 Zhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710145715; x=1710750515;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kvo1sjEmvcnkJBb64dekgahp1yIbA/J8h4vl+AZ/xmg=;
 b=ftPkuUJgKlWaMns8HB8VeCwydbkHgXp/+DE0e5HMFwqQKID7NY02UvdnBesd/BHwe9
 1Zv/RsBAkt+Li4fDZWsyQtx1D4VjW/XrgBEHuQ1Fay0Dhq4wG6RrSRkMCishZKg1Lt6L
 Q2dZ73CFGr/scvWOaq7+8cGq7/4LtRiCK3eEtBlorP/088w0/figuM5hFbtB5d/0mmpS
 ci+pmDSEkNPTiKxpdzHcd4VE6wRvc8rcjmfBM9vVxsIdYAI1EwRIziiQW8Af2wLKMDe6
 J8jcK6tyXHtog8e5cja1lCTbUxN0gC5BaqpnGteaM9OiMHL9UpCjbOJ8oHS247xy2h8K
 RgHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDWFnoXpVEPEGGBdnl/zQtCtFU/4KYw0nHmWsqK8TmD5uSkH6Tv18gGKdKMT+2QEHvDMFqQSCUorHurvTLrQUa2MkWbfc=
X-Gm-Message-State: AOJu0YwXcla2aPn+WhB+ChNnXLvumsbuAZBPugEQFnDH/pPiGqzYo9Lb
 nWVp5fZ4+y12zcODw7/TuCMj0y4T+bAsXvDPkY/Ik55KRUZnOcPyvF7J9cKZ2ximFmjT0LBMLK7
 k
X-Google-Smtp-Source: AGHT+IGdLG5XgowrX72xaw/ggMZNYqYFTthNbRUKhBQUF74NpBWa6lvUEMprEER9ylfNib+I/A2zKg==
X-Received: by 2002:a05:6512:118e:b0:513:23be:e924 with SMTP id
 g14-20020a056512118e00b0051323bee924mr4559558lfr.59.1710145714605; 
 Mon, 11 Mar 2024 01:28:34 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.228])
 by smtp.gmail.com with ESMTPSA id
 az19-20020adfe193000000b0033e9d9f891csm457925wrb.58.2024.03.11.01.28.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 01:28:34 -0700 (PDT)
Message-ID: <eadc337e-7575-4756-ab8d-9c951cdde644@linaro.org>
Date: Mon, 11 Mar 2024 09:28:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sun4u: remap ebus BAR0 to use unassigned_io_ops instead
 of alias to PCI IO space
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20240311064345.2531197-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240311064345.2531197-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

On 11/3/24 07:43, Mark Cave-Ayland wrote:
> During kernel startup OpenBSD accesses addresses mapped by BAR0 of the ebus device
> but at offsets where no IO devices exist. Before commit 4aa07e8649 ("hw/sparc64/ebus:
> Access memory regions via pci_address_space_io()") BAR0 was mapped to legacy IO
> space which allows accesses to unmapped devices to succeed, but afterwards these
> accesses to unmapped PCI IO space cause a memory fault which prevents OpenBSD from
> booting.
> 
> Since no devices are mapped at the addresses accessed by OpenBSD, change ebus BAR0
> from a PCI IO space alias to an IO memory region using unassigned_io_ops which allows
> these accesses to succeed and so allows OpenBSD to boot once again.
> 
> Fixes: 4aa07e8649 ("hw/sparc64/ebus: Access memory regions via pci_address_space_io()")
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
> 
> [MCA: I'd like to merge this for 9.0 since I've been carrying various local workarounds
> to allow OpenBSD to boot on SPARC64 for some time.]

Sure.

>   hw/sparc64/sun4u.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)


