Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A3CE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 11:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV7gD-0002L4-Av; Tue, 07 Jan 2025 06:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tV7gB-0002Kh-GS
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 06:23:23 -0500
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tV7g9-0001bW-KY
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 06:23:23 -0500
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e549be93d5eso5911321276.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 03:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736248999; x=1736853799; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mLsgCTGEhFWCxmTNanRZzPuOWeJjl3xtDwICBweEYyU=;
 b=pHTLOPJmDRaBWK4o2PxO1g4cl+LFqxSPg/GL4UZ1KFIxrsf4iXENf1nL+A+cczOBUj
 wt7bDlGWWHUy9LvbgltVtf07wa+wXWIlFUJRgPP3r1aDywCFOv7mzRJwusDmLnWyt/mw
 THeA6mwAe9GgRKwAnP44/zS22Ub7SV0UTtumW8h7Qx5LyNws2PXHt/FCjuFM45FbE0eu
 2tAihwOmnlGROsywbgzbLRs3ZywBbk0f+U+IoYaigTrZPZBl75gfFWgHlXM9KE0KgNL3
 AVK4vrUTUWPBSKauQG7vh4BgolFyCxsqa77+Aasdk8clwrZ5gnujhwtPilLz7EY7mQnQ
 qzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736248999; x=1736853799;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mLsgCTGEhFWCxmTNanRZzPuOWeJjl3xtDwICBweEYyU=;
 b=ktpsnHX2aIbWEOZhZV6bOMfjrSQhLcwD+CMjHRnmpyQTwwikSZeuL+s5ywwqycadQI
 nYndQLR4R9Ef8AUF4Xh24/t9pjxFnbnnUoAirKKJ+YxakBD8PEe/ULpmumK1zMjkC76r
 tWGb1PC4NZrmOkFnFRANCTMwMnPkGAyXBJW7zluxvFY3sJKDFScF5wkUNMlxkIVbmO3y
 17Kbf/r1XmYObTbqK+ANPvxUpPD9SAVOi6Rbwe/5N9OXsozP0swaGTwW9yuOcSv4i+HB
 nOENSliLDeTPFBHB5lyLIlFX2W3bGj2VyjGiAW6KI8cqAW7iyWTfYysgMw7SPUNJLbB4
 zHeQ==
X-Gm-Message-State: AOJu0YxylCsRfiTQ56C2SFmXfIXPsnkl6P4fWMBz0K1bKEUWZF7kII49
 mdnvlw7+8pCprgI8PAb31HXUmy3Q0mGMIK2L1nNWYyK4Os21orR9Jyr9XrAgu8mjR7HspXROvlQ
 atR3ac+4FtfwRN9DOVK5esIMhQcQdpZxnnP5S0A==
X-Gm-Gg: ASbGncu7DOySP54hjc0N5J+9bzdXspU6Z59164BYz/2lYkJIj+orAVvcWswp2uhjW9L
 z+KpW/tUV8eeco+M+7cxIuAUafL3czeP189eUb+E=
X-Google-Smtp-Source: AGHT+IF9o2L8ksEreGgoXD7zZihJbvOXQd38ByXfC6AZLbwCWztBOQrOFWByvURLQR7LyPg/TRjN7uxM8QZ9aE7WlRY=
X-Received: by 2002:a25:1e8a:0:b0:e54:da61:acb1 with SMTP id
 3f1490d57ef6-e54da61af91mr712026276.3.1736248999498; Tue, 07 Jan 2025
 03:23:19 -0800 (PST)
MIME-Version: 1.0
References: <20250107111308.21886-1-pbonzini@redhat.com>
In-Reply-To: <20250107111308.21886-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jan 2025 11:23:08 +0000
Message-ID: <CAFEAcA-5n_GUNnvExPJbu1mn+7ZQQ-GamAQS3kjJvRETZ-rXWg@mail.gmail.com>
Subject: Re: [PATCH] qom: remove unused field
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Tue, 7 Jan 2025 at 11:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The "concrete_class" field of InterfaceClass is only ever written, and as far
> as I can tell is not particularly useful when debugging either; remove it.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

I think the reason to have the field would be if we supported
"given a pointer to an interface class, get the concrete
class"; e.g. supposing i have a ResettableClass *rc it would
be nice to be able to do
  DeviceClass *dc = DEVICE_CLASS(rc);
(asserting if your rc isn't actually one provided by a
DeviceClass, obviously). This doesn't currently work because
we don't have the code to actually do this, but apparently
GObject's object model does support this. See this thread from
a few years back:

https://lore.kernel.org/qemu-devel/CAFEAcA8Q3XZrdLJhJ4Uj1CX6J04ON9f91p=NuJXxA+cnEfdz6Q@mail.gmail.com/

But we've lived without this forever (and the thing I wanted
it for back then I ended up not needing), so it seems fine to
remove the field now; easy enough to put it back in future
if somebody does decide to implement cast-to-concrete-class.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

