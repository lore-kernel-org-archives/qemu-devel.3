Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3A4C5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 18:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuwFw-00058W-QN; Fri, 14 Aug 2026 14:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuwFu-00057t-JW
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 14:03:46 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuwFs-0004sO-3X
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 14:03:46 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-ca7c1176317so1106321a12.1
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 11:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786730622; x=1787335422; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wkV2uOkAVJu8OzkVwqrTMK1WhRmunmPVh9+h+z5X2Cc=;
 b=JyeBBdno1uZ1hxE0WN4E7vnpygFWD2ZbGzwsykt+F814SstZ8++W8mVnAv/8qOQC+T
 ilTwrv+voJyfQ0w/99gYv0L5xdg5gme7a3G3cpdFLaahRFRA07J7gY4nHAvuFC+zW76d
 vGE3gDkA0dyqWiMpkwYFe3cGp436kRvI8537JAfMFgqQT1LLB7oBEJfIhspGWSvAMimg
 +2BcLVuVXmcvsp+uhlHwJPfYyUPcYEpYq2BS1OX33pVdfrEca7fLn5ekxgN699xZJgv7
 KGKEA4iE0pHu/s6VDVWD5LaFv/QDKzoVGQC09PMvO9Swn2NflbIvbWqmYWkV73xKJg52
 5zQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786730622; x=1787335422;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wkV2uOkAVJu8OzkVwqrTMK1WhRmunmPVh9+h+z5X2Cc=;
 b=Z4zxXqCX8q10i0ZQsHynhuJEXeELfCTnChd8T6huPa3YUTY1TOQrDi2Df63fB4otfH
 ZLLhOxz3zKqeGUBzKv23Yqy8N0JBFaczKUjE1LluS/demJ97NjYaWfK7Npc9kmfyWnKW
 xoRFxcT+o7vmVbBMxAWjdvbfVhBQvm5Rzsj4WBP08c3ULC+I6/mvlBoc4yO0sDV6JYEj
 SfvV1RGvdHGz8S1GL1NZAO6oMqiS94/6+OgL+Zb995f2SFeQqBM4lC0JWAb3b61oirzn
 hYigNgf+CYqjhe9b0xWQXdCt2xxo4lQ3XSi2xCahHP4RUMQsbicV4Zbg7D4V51zBkGjb
 TsJw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqsQC5QJeGbdMl6kpnWcuSkKopg4V5mz3BB4Br2eNn0G2tnivHOjwj+N+dti7f2alVBkJO6fNLeoQNP@nongnu.org
X-Gm-Message-State: AOJu0YyiPP3c+Az8ka+xEEB8++RkapV2fxi8xil38FjXGapahFsoYw9g
 HhWu0TMGWXpPygP/SSFj6JuLDwk9t/MgiozQb87MBPOeAl18R/9xL7JzABWetpn5bfc=
X-Gm-Gg: AR+sD13h8G9jIHKZaKB1g3+d7lWS5iUE6I7TxEQd7j4QLdDC2lzECEU26f4OAi18DAr
 W4ijC84QLfIMuGVXqbTrLPLXgsmcSLGfoPDjpMJpvnPvLQDTGssAokwiksjy7scGfKDNovzEoDh
 4sdWhVLAyuwtr8g1+CcjUhG/R+yPSQ4PZgX4sOENk+PZ1W0ldLcv0Eth1rFL4TEeihvc4ufvpKe
 VxYxxgva8ghi8gp9Rpa7LU4UVaSGR6yrBV5z9yp5rhgO9zXzEbpOtuzzZhIm0shZZZnPBuHudEJ
 mGvWkb56IZWZQH4gInC9ZB/0VhDiSOlkrvYB8mT7XHwaHvpsFdfNz2ek7r73tUgS0iMhBaVG+I+
 ihlSCfHnA4Iiq3nSMNw/PkOdNT9pt0zli0vvqMrKr1xDg330P2wjob77ECAgB2/zoM5bBdR6Ek+
 Q0F5T0v7Krnp6HFMxuszdgwouxV66w7FzFMLhfEOmyGyyUXPBOs9FSQ6Vy7UYCZzWpdWCwebL+J
 oVfUwEj/bAiwt1I+sxTlVlMN2mD
X-Received: by 2002:a17:90b:3c02:b0:38d:dfd1:7a8 with SMTP id
 98e67ed59e1d1-3933b6e9788mr9504859a91.2.1786730621866; 
 Fri, 14 Aug 2026 11:03:41 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-394ea9723casm3458753a91.2.2026.08.14.11.03.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2026 11:03:41 -0700 (PDT)
Message-ID: <4d87a37d-d227-4bc0-86a9-c0db2a5e4cf3@linaro.org>
Date: Fri, 14 Aug 2026 11:03:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v3 0/7] IDE patches
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>, philmd@oss.qualcomm.com
References: <20260813191613.2323728-1-den@openvz.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260813191613.2323728-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 8/13/26 12:16, Denis V. Lunev wrote:
> The following changes since commit 539bc315538afe036a4b99088659aa82e3b489f2:
> 
>    Merge tag 'pull-loongarch-20260813' ofhttps://github.com/bibo-mao/qemu into staging (2026-08-13 07:16:25 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/dlunev/qemu tags/pull-ide-2026-08-13
> 
> for you to fetch changes up to be1ee6a8f6e3b7192d57e900497b81a048f8d193:
> 
>    tests/qtest/ahci: regression test for ATAPI read vs. drain (2026-08-13 20:59:49 +0200)
> 
> ----------------------------------------------------------------
> IDE patches
> 
> - fix a main-loop deadlock when an ATAPI PIO read spanning several
>    sectors is in flight while a drain starts: the nested sector fetch
>    was issued synchronously from inside the completion of the first
>    read and queued behind the drain, which then never finished
> - read the whole ATAPI elementary transfer in one asynchronous
>    request instead, removing cd_read_sector_sync()
> - extend the IDE/AHCI qtest coverage of ATAPI CD reads: parametrized
>    read helper, multi-sector DMA, raw 2352-byte READ CD on both
>    delivery paths, and a regression test for the deadlock above
> 
> Changes since v2:
> - resend: the v2 tag was never pushed, so the tree advertised in that
>    pull request could not be fetched
> - rebased onto current master, no code changes
> 
> Changes since v1:
> - MAINTAINERS patch dropped
> - spare blank line no longer added and removed within the series
> 
> NOTE: 'hw/ide: Don't divide by zero if guest specifies 0 sectors requires'
> is not ready for me, skipped from this submission.
> 
> Signed-off-by: Denis V. Lunev<den@openvz.org>
> CC: Richard Henderson<richard.henderson@linaro.org>
> CC: Stefan Hajnoczi<stefanha@redhat.com>
> CC: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.2 as appropriate.

r~

