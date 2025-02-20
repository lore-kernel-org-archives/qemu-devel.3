Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728E9C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9Fo-0005gj-Ud; Thu, 20 Feb 2025 11:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9Fn-0005gV-3n
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:18:23 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9Fl-0007pG-DH
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:18:22 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6fb9dae0125so9660787b3.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068299; x=1740673099; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/+2+xp2QOTlpmadGFD3s6Z51NSxMIA7ENir8nUuuGUY=;
 b=oNEwLPVATbLbulCAOjYOmFdPuBaqvODUZmZcvOhRLKb74bkeVd+jBvsPsXDv6icHFU
 8GnuZuHDLYEMhp/t42bjnPpKCOItz2Is603CnRQkQXMiMTfD2SZfmo6MtXn8ZFdUefgp
 AufYqAx9ytLp795VCBi0XDuS/HOJxOy+NA9YPI2kVNy/0UwPpfBaxvM6Ajqq8W11M4HS
 I90QkEd3hDskVA3tSasl59F95pNHlBZ2So+bwqPHS7mePI3neFQvaZBEB/CS4/R3JROr
 8vKna0gl+6wzBE5dQM7y4JEt6cJGYWScDkj7cTzzYQd45yr3FctXQ38xzWtRaqFfcW+T
 SE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068299; x=1740673099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/+2+xp2QOTlpmadGFD3s6Z51NSxMIA7ENir8nUuuGUY=;
 b=chZTBnKB5KlNfTXgfme8uNrwv50o5DcxegIleJmFwo4l2UZnZx9bOtYSwk8nvn6o0i
 n/TDEyW+qVDBgvdGjUJlLWid0nrGSVwzTFsnylS5RyUHFIDNzDT8aq+9FBD06pkIZ0xg
 zeoH2WhNW7yGWTEmu9i8fCYO+BgEurzDrShvAHZV1ZmxNLn0HNR1I7RyvsdgTTGG1zPd
 /aZjusFphVRKvLbtop4oOYow621qLRY1EpjAx20XoapETL1eL5He6ZwyWFP6TOxvsGSp
 5/pH2FSeM1lnUdJ2F+heGgW8Jxpx0bv3SuJh6Fw02eWACO26VEBm6znaWS/E5XyazJdC
 zogQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFTk5PwOXkbGA/DUkxePwI/j5yNC2VAmRZPb+iU0gCBoaJ9N9xTFSdhL/SRzfxAbyCfuPVDl2o6f+9@nongnu.org
X-Gm-Message-State: AOJu0YzbOWykbQS/o1tLUsQUIBa1V8gUvZDhyl9s7zxvK8jVRpAejFTA
 sfMwN+N0e+MfMp4JTosQMigVus8ZzoVskE9rbCFqdcPP5LHaMtMP2vSc5zTHH5174DeZV7ppf3S
 LoZzF2S1IySN0SMXFQPZEBUp/mTl6gjnglgi3Eg==
X-Gm-Gg: ASbGncuSzcq3W6MtyglklPiYKKZ9eBnPNy0Hzthdb0+NfqYtnn3bI22I8HhAW0pU4Ks
 hVxHv3gysK7CCU5JLIYEL56KSf5UXmJo9Wh1z00ay0B12o4YLBc+JEeZkoJmvbnJ64CgRTJ5wuQ
 ==
X-Google-Smtp-Source: AGHT+IG+stU+fxpw0WCLyopFsDnfIDQNbLRe/wf9Z7wWX8LHvl3eIKED16ZYf1E9wHz6i2wcbHF57RuaM3dw/YWqBEI=
X-Received: by 2002:a05:690c:3393:b0:6f9:b189:3ccb with SMTP id
 00721157ae682-6fba5696362mr81641037b3.17.1740068299562; Thu, 20 Feb 2025
 08:18:19 -0800 (PST)
MIME-Version: 1.0
References: <20250219184609.1839281-1-wuhaotsh@google.com>
In-Reply-To: <20250219184609.1839281-1-wuhaotsh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2025 16:18:08 +0000
X-Gm-Features: AWEUYZlO8BAo_ZXOdCNXz2xj782SxtnwWNQWB9lLFGme6pjAam2bDPwRU0s77Tg
Message-ID: <CAFEAcA_3FOHVo6q_tiOEE7dHZNDw7_0emdCR5=5cEt7fdKVkTQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/17] hw/arm: Add NPCM8XX Support
To: Hao Wu <wuhaotsh@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, venture@google.com, 
 Avi.Fishman@nuvoton.com, kfting@nuvoton.com, hskinnemoen@google.com, 
 titusr@google.com, chli30@nuvoton.corp-partner.google.com, 
 pbonzini@redhat.com, jasowang@redhat.com, alistair@alistair23.me, 
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Wed, 19 Feb 2025 at 18:46, Hao Wu <wuhaotsh@google.com> wrote:
>
> Changes since v4:
>
> 1. Bump vmstate versions on NPCM CLK and GCR modules.
> 2. Remove "hw/boards.h" include in npcm8xx.h and add it in npcm8xx*.c
> 3. Use cpu_to_le32 instead of tswap32 in npcm8xx.c
>

I've applied this to target-arm.next with the fix for the
type of flash_size applied.

thanks
-- PMM

