Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A22C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 17:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reePJ-0007wY-Ia; Mon, 26 Feb 2024 12:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reePI-0007uL-D6
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:04:48 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reePG-00013k-S8
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:04:48 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56454c695e6so5840443a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 09:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708967085; x=1709571885; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vSG+pKk5FeeBqSPRfdmh3uvO1oWBBpW37v8fT8JZ9Co=;
 b=j/7Pti106orHWAnh70l1sZLfNPsvqo+B3JXwc830ua6Qxq6IR2zdiSVF/3F1BD3lSp
 ZKeWY8KQ4rSwiQXl/DCdCdsVoLx38d4F2ui34xCtodbfrE1Wc943m+ZkQjmXChqgFKro
 12r0FyQ/B9FEYKbWhrMsWxKmYH9lytjze99E4V9WIzfuA7HruayZU5kkPSN3JzXuSzh/
 uCNSm/y8wgoUozvzSwmUos7NRonM+nfkHuYSmXSp2JzmIRqPu7gcp6SYeZjZ1j4YNpCN
 9nnuEowNdMe8R35U8eOFR0amSde3kHNgaYbmf9zeKAYmeXlHjvQ0/RB12HDTRUbEEKYQ
 kHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708967085; x=1709571885;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vSG+pKk5FeeBqSPRfdmh3uvO1oWBBpW37v8fT8JZ9Co=;
 b=qEYhWZDk6CI8Ho2UuOQ9edNdNkOADTSWdVrt+Gq6dGpJuvMCVnphtAS2g5+9JPVSxU
 wfYucTbXTich5tyje/AaDntXs7m2InXYcgR1pSx+8kYr+SOERr1YKbTHuoKONGom5fBa
 AxgCe2UGDPzGp0+JjG0Tsr0GbbDma23DS8gnZWnGTfWcZ0ON7DANfyuYNAELMdBn/nwh
 57xdMGmVujnJH8CXpQ8KEqKZFCzUbQaiIFchXc1Vqfut+aYdvRn2H89LvKy84ETZhQ8r
 bKGFACwphVBZOYweUANK1j9bjHhlSBglRs6I35HCpo1fEDSx1Xc9U0b+wjepEEUXCHEM
 wenw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdAPKmoWT6wRlkMShFLBszFNIaNqug51h5uYPQ0EeOZyjos0KU8mgSHA3N8zJ3vFNxE1b4dXgdvtq/4MamCup1jC3k0MQ=
X-Gm-Message-State: AOJu0Yy7YFXBaVNRA0hcfygLmpD0whfQVouf/J0bqmvNqlrWddSpO2TN
 l8X9WLqpGVkVRS0GTDYRjIA3BNZsIx6AsN+kI+jFXcsscGp2cxhGmeupklJmQ5nrdjBhm7+L1ji
 hNtZDZnZMnMIAAAz/bw7kUDnWxDiuR1qVq6PRWw==
X-Google-Smtp-Source: AGHT+IEFqalz5fw1/BZ3C/MBD32OXcxTMBZlQlLLJc4wipg89e5/oa+4GLHIuCdohcj8ODIYwxJfIIX0JmaQ5dXjT2I=
X-Received: by 2002:a05:6402:194e:b0:561:f2b1:a68 with SMTP id
 f14-20020a056402194e00b00561f2b10a68mr6449539edz.20.1708967085039; Mon, 26
 Feb 2024 09:04:45 -0800 (PST)
MIME-Version: 1.0
References: <20240224-cocoa-v12-0-e89f70bdda71@daynix.com>
 <20240224-cocoa-v12-7-e89f70bdda71@daynix.com>
In-Reply-To: <20240224-cocoa-v12-7-e89f70bdda71@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 17:04:33 +0000
Message-ID: <CAFEAcA8c+EOUae4PZGLsjCzieM6jcZJa_zo-iU0H3zEWJUWZPw@mail.gmail.com>
Subject: Re: [PATCH v12 07/10] ui/cocoa: Remove normalWindow
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Sat, 24 Feb 2024 at 12:44, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> QemuCocoaView used to have fullScreenWindow but now it's gone, so we
> do no longer have to call the window specifically "normalWindow".
> Instead, refer to it with [-QemuCocoaView window].
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  ui/cocoa.m | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

