Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C87C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 19:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s04VG-0003qE-BJ; Thu, 25 Apr 2024 15:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s04VF-0003q5-8S
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 15:11:29 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s04Uz-00083O-PY
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 15:11:28 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5723edf0ae5so1397854a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 12:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714072269; x=1714677069; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bZTZhzWF+PRUqaxgybnmDs7bTMMUT/n+sUYeQrG6gXk=;
 b=f5EXVjhJbURU/q3Rwu1Ab+ouuBMOr6KDV6i2upObeIYMI6HkDwEv00ruf3YRmB1Eit
 o5cdI0tz7q6uFQcjtp9AmJuuCIZX+nghuziwAumWZUHmQOAdZ/Uew3/j4hrtIPvgZ/C2
 0PL1hOS8QSzwl5OWye/Ji9cL/FTMeBGMm9brSGohCtbn8mNsGTLyzdGe+lz91EgdHWZ2
 P2b+wAqq3ftOgbLuh2U5YZDO0x6dH0nF0YV5AajeXSEZGVbEPe2pms/2+gtJ/9Aab60c
 3etfYWAljb2Fethm/D1PVGyqtDllO55HUQBS3BeL9fA9OkV7jWESQ+4M/QSwjAcSZH/M
 FBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714072269; x=1714677069;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bZTZhzWF+PRUqaxgybnmDs7bTMMUT/n+sUYeQrG6gXk=;
 b=P3OMtDJ0VwivjSoEyduI7X/wkCKcwYc8N/XCIUruRQdlU3t+2ZsWHkw2tk853zkTyB
 i2xoeoOe8f24Hy+1WOLdmZ8nvaEvxaZ6YDH5PbNI+nJdkO3bXoxxWSp0iGdcgRiUCg1C
 qhGhYCLRfroHJq+Gbrp6gmm2CMmsF4APGy2ogg2dxkDEGwrv8ypJUv8Wfd/2MIGUQr7u
 KKbQ2hlNl45U4d397GzVLsXzV4NMesKgppjCIn0JuhVks5UmvYPhDxLrtRIOUWtGub3C
 huVQpNS/KTm2miLaDiTNomG/kZ+9he26rEt7lGEBGi+zQ9ankMuvpmW01azTwGrxDO5e
 0Z7Q==
X-Gm-Message-State: AOJu0YwjenOC9lzqQmtjWXz05AjFtCY0Yp3C8TVqQqUszDsxI86EREaU
 EmD/EDIfqpbQz2YzmVj7K5BRWIZERiO0FXHZe/o2Xv3Zj5r2M2UanDBvuXSA4V5PLFGsixnsLn6
 w74aI37ZojUOpaL4B1Im8kPOGS+jaj7NSLeWu/Q==
X-Google-Smtp-Source: AGHT+IGcs8ZWFMbpT6ImEZ0ykk87S/aqtAaMw+5ZuEySmqt2MsO8x8R3WxyaWsXfh1Px/y7NyuhTPy0ETivDgRUfaTM=
X-Received: by 2002:a50:9b01:0:b0:572:47be:be37 with SMTP id
 o1-20020a509b01000000b0057247bebe37mr353475edi.25.1714072269613; Thu, 25 Apr
 2024 12:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240419162951.23558-1-raphael.poggi@lynxleap.co.uk>
In-Reply-To: <20240419162951.23558-1-raphael.poggi@lynxleap.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Apr 2024 20:10:58 +0100
Message-ID: <CAFEAcA-w32We8F-EEMWt1=aXnDFiDK9qKfub-5Egpzn68q4Htg@mail.gmail.com>
Subject: Re: [PATCH] hw/core/clock: remove assert in clock_propagate
To: Raphael Poggi <raphael.poggi@lynxleap.co.uk>
Cc: qemu-devel@nongnu.org, luc@lmichel.fr, damien.hedde@dahe.fr, 
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Fri, 19 Apr 2024 at 17:30, Raphael Poggi
<raphael.poggi@lynxleap.co.uk> wrote:
>
> This commit allows childs clock to propagate their new frequency,
> for example, after setting a new multiplier/diviser.
>
> Signed-off-by: Raphael Poggi <raphael.poggi@lynxleap.co.uk>

Applied to target-arm.next, thanks. I rewrote the commit message
to document the conversation we had in the other email thread:

    hw/core/clock: allow clock_propagate on child clocks

    clock_propagate() has an assert that clk->source is NULL, i.e. that
    you are calling it on a clock which has no source clock.  This made
    sense in the original design where the only way for a clock's
    frequency to change if it had a source clock was when that source
    clock changed.  However, we subsequently added multiplier/divider
    support, but didn't look at what that meant for propagation.

    If a clock-management device changes the multiplier or divider value
    on a clock, it needs to propagate that change down to child clocks,
    even if the clock has a source clock set.  So the assertion is now
    incorrect.

    Remove the assertion.

-- PMM

