Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D525BC25B77
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 13:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7au5-0000Oi-0H; Thu, 16 May 2024 09:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s7au2-0000OO-Qk
 for qemu-devel@nongnu.org; Thu, 16 May 2024 09:12:10 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s7au0-0001Jh-Av
 for qemu-devel@nongnu.org; Thu, 16 May 2024 09:12:10 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-572ba002a6bso3316393a12.1
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 06:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715865126; x=1716469926; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fJdS7teRTdfiqjpoZ6A9NzZEmDrDTIJyNl0erzMNBqk=;
 b=oku0TUI/sADDnz4GaDskJJfv5iUNobS2dznROL+L3SF3FXlLELRjuzohNQJMNeIYc8
 0a7RylhkcbQQnBsSVQ8B2IxR97UAnRmBGnaHYYVRZXs8bxjc4faKZL4bMhkTvEHgsdNk
 HgS2oObhTlv78U8adfFav+WsAlGPc6MmcGhYgUrC4VGLCBARH/OjWCUvR5ufMsPJaS79
 wgUzID6azy7uBzqvl3uWkNAxa6L4zdA2z1W3StiTSyL829X/bjdgdwPaZbVhh2y1Jd4b
 VqYl/chnExGDlWov0G2I9Wyy5kr0mEQLmvdRSOfDiml3Q1jmtQtEluxiccpw9P20+TD3
 kjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715865126; x=1716469926;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fJdS7teRTdfiqjpoZ6A9NzZEmDrDTIJyNl0erzMNBqk=;
 b=nSBjtrBUSavZyZ6I1wBACoa9S58zEEvEV0+7VUy2uo10A/soOAD+ooSlNPL53L/+aT
 KZr6CmM4qZdSSK8volut65zgCWmhWRyiwlRHZUCkyVcWBKlp6vnsFKdEIEeHPfKeszLL
 0/tuhkgxV6/sf6Wgtx/icDN5v/xXePq/mp4zb3/SsJeWOFmcR+EImtSRBJducBSChfKF
 On/dl7gE/fT/PHPhgKDkFAZt4/KLfGXRFxmBRPBREMimBnYn5ilXexpbFPoak0pOhPnD
 nCi7V8uAjLfNynBCk/dH/HIs+W8wGM7bpfc02QhfVj4Ep3gdLcJb82RojOt5JL2KfYaH
 AFCQ==
X-Gm-Message-State: AOJu0YzMsUjMMQf0B4V0pbsnLEp0/pHssf8kchMsnZrZwyVU6hzRr5f4
 MqzaDfl1tSuHdLlHsQOoMksAD7iyU14tIkrHl1yS6cjZeWQ0NIzlUHE4DswMh0O/frko/jfRXGB
 wi6f3al0OK3rIkgNRNy5a5/t9DlTQkKcMaPICcQ==
X-Google-Smtp-Source: AGHT+IF5ucZcIlgvn211TKqP+rzyxCxic2t8rMMh4EOPBNWaCezUQFp/WP5L3lkS4kd+1PUt9rwZA10Moxo6GOYfdOM=
X-Received: by 2002:a50:c30b:0:b0:574:eb80:3305 with SMTP id
 4fb4d7f45d1cf-574eb80345fmr5021885a12.11.1715865126107; Thu, 16 May 2024
 06:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240516120344.531521-1-kraxel@redhat.com>
 <20240516120344.531521-3-kraxel@redhat.com>
In-Reply-To: <20240516120344.531521-3-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 May 2024 14:11:52 +0100
Message-ID: <CAFEAcA8MenWrKkKUHY7Sair5iEqNz3VKqP=C7+cc1EW+jOdbnQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] MAINTAINERS: drop usb maintainership
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Thu, 16 May 2024 at 13:04, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Remove myself from usb entries.
> Flip status to "Orphan" for entries which have nobody else listed.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7f52e2912fc3..d81376f84746 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS

Thanks for your time and efforts in looking after these
components in the past.

> @@ -2140,8 +2140,7 @@ F: tests/qtest/fuzz-sdcard-test.c
>  F: tests/qtest/sdhci-test.c
>
>  USB
> -M: Gerd Hoffmann <kraxel@redhat.com>
> -S: Odd Fixes
> +S: Orphan
>  F: hw/usb/*
>  F: stubs/usb-dev-stub.c
>  F: tests/qtest/usb-*-test.c

Does RedHat have any corporate interest in finding somebody
else to look after the USB components in future ?

thanks
-- PMM

