Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43583C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 11:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ7fR-0003uB-0r; Wed, 31 Jul 2024 07:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZ7fA-0003pn-Dp
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:38:37 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZ7f7-0002Gl-BZ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:38:35 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5af326eddb2so1500965a12.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 04:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722425911; x=1723030711; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oK9aom/3jHdVS7ezZ8ZFE4bSdGSaDuLYvsraI038mHc=;
 b=K4IHAwSNVllve9YZvr85I7Y8n7vlzs25uV7jG4a6a3y1PyeAASOdhfZXPnd+DcLCfS
 xiGXh71fRlfGIYJIrzUs5tZtTwNtBc37fDxtU9V6a9W0Q0ELaIjWo82I7YJhRvY9pHyR
 jeOLKMJLSOQ0AwMsweEnZhfHseuE3S8B7IlfFRvMF1ipFKJHJsfjs3SG/2dGeAEXKOJE
 ZtmCrYQ72xmswKh0HlBg5BKPhq67VlNFGGvIuY7Sbx7veC9O6AFIlSxTKSVrnEbT8aPo
 cg33MdzRNrKrKYbg9rolQCpywK5yo3gHDxB1TdsN7DiMQGRqSL+NKQ2p8agMhrneMHOB
 yuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722425911; x=1723030711;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oK9aom/3jHdVS7ezZ8ZFE4bSdGSaDuLYvsraI038mHc=;
 b=ZQ/1pcUONJDISxzMq3G5qds6sG/XXVe40vsQk82cpOwNIwUqr1nS4kPKMix7uZqYCi
 eDHs0ZCiUrLnZ6qFcJfFvNJ+KuPyowBezapUi8/rSFWvGlytY0+rkRG6eQ4uDcZBS7IH
 2bomb28T23AmlGB4DLiTZ7EVzO88CW3l2halfjAa7SF+BPTffejtwkWQU+ijFGvvN+R/
 SkNjcCc5pT3Y+zeeREUK46zUl0M77iKZ9u6wkCEwCo7ACP+CRqlLihuYjfFVFQf9NAEA
 ihV9LbXS7ZdVslUAJ4qWlXfiB6+IIjAC11JyJYEOS9sjzRahE65vUaev3mejKpep5i5r
 WPHw==
X-Gm-Message-State: AOJu0YwiEdAkZ/ivF+Bb6aFUJ99erq8SuBkUh4V+psHryzTOCSgb5bwz
 8hfk7lFFaDtnzQyC8HV0Vf7vawbnXKeX0YwhyQBlwCp2KH2B8ZPcQB66yCFI7NW4rOosQDLYELA
 HwOB996s/NL/FTNIIGkLByJDq26mvy5Hb+SmPIXKjtYlcL87l
X-Google-Smtp-Source: AGHT+IH1ipf9xIs7/esfyJh+sWaz1jpk9H3soDgxyJGfz2eZeDdI08ZL6+4al2uk0AZ7i6r5UjPR130ABlr73RikdvM=
X-Received: by 2002:a50:d657:0:b0:58c:10fd:5082 with SMTP id
 4fb4d7f45d1cf-5b46bf6f88emr5013371a12.10.1722425910581; Wed, 31 Jul 2024
 04:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240730073123.72992-1-marco@palumbi.it>
In-Reply-To: <20240730073123.72992-1-marco@palumbi.it>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 Jul 2024 12:38:18 +0100
Message-ID: <CAFEAcA_7QDUuQ-zs53Xp2zcO83rDzj0Smga49GZ8J9gg26VBdw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/mps2-tz.c: fix RX/TX interrupts order
To: marco@palumbi.it
Cc: qemu-devel@nongnu.org, Marco Palumbi <Marco.Palumbi@tii.ae>,
 qemu-arm@nongnu.org, qemu-stable@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 30 Jul 2024 at 08:32, <marco@palumbi.it> wrote:
>
> From: Marco Palumbi <Marco.Palumbi@tii.ae>
>
> The order of the RX and TX interrupts are swapped.
> This commit fixes the order as per the following documents:
>  * https://developer.arm.com/documentation/dai0505/latest/
>  * https://developer.arm.com/documentation/dai0521/latest/
>  * https://developer.arm.com/documentation/dai0524/latest/
>  * https://developer.arm.com/documentation/dai0547/latest/
>
> Signed-off-by: Marco Palumbi <Marco.Palumbi@tii.ae>

Thanks for this patch, I've applied it to my target-arm.next
queue.

I checked the other boards that use the cmsdk UART, and they
all get the tx/rx interrupt order right, so this is the
only place that needed fixing. I suspect that the guest
images I tested didn't care about the separate tx/rx
interrupts and only used the combined irq.

thanks
-- PMM

