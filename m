Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEBFC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 12:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCHoN-0001yF-4h; Tue, 06 May 2025 08:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCHoL-0001xv-FI
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:54:13 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCHoH-0003TU-PV
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:54:13 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e733a6ff491so5312821276.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 05:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746536048; x=1747140848; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ALvgerSZUNXUKPQczYhVZ1boHHltAdoW2Wo+YUbpVLM=;
 b=P96GujffA4+bl2ci1jgm6KiDK2hh+QcuXbzSmq1V9OOamE/gjhp1SmeBiClK26cDwV
 4+seB+ZMPjUwfQ95tcQVdJnpeJYw9Qt1C1Jz8njtsf3llR+Vsfaac3VELOcX/TcAXC7b
 D0b7hd3UXcaK9/HAAJdNZ06C0L1B5oq3n5cXqSgzs0M7KIfjuHp0dWDmNLh33+A5snGy
 nF59YLFqkH7ZROw16LAdPvqFsvce9QSmNfoRz/jjtygI2aCagZgakcsze1NCQ/JgeIlj
 rzz7XqdIIUlIv2fcK+JE1d7j6zxYLoejJ3a2tclSdAtEclf4DPfS5aA3PGBpoyoi8y1A
 pglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746536048; x=1747140848;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ALvgerSZUNXUKPQczYhVZ1boHHltAdoW2Wo+YUbpVLM=;
 b=mnLVSfayKdetJpjS5wMDAn8V3zHVSB2WegNQ/30RB16R6bEFwsYD2q9HhoBjYRB+8F
 aZ/663+y2p6S0jigZoDdJE6iHPLkRq4jy/kBTfo+WeO4kPhowFZHWuzjS7KCzXfVHNQc
 8ILV5oIX8kaanucUtUaDoMYe5lYVPoeG1QR5uZRcGWsVz671PRHNk663BBzYM1UbzikU
 qF5mtB+Daxvk5z8l7ogs2/JE1NIpheO75iv5kSwHRBTBPny+sdgasvUy78M48//dzgL2
 hT1iRC3PadRZ6U7QaDiSJDV+vHJksiEAUApMtAkyODLWsWKn6jJ/QJLa4n9n5kl6ckOb
 7OYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1vhGpIrG2bJSrHMdp3QzcEe9nKraaWvj1bSHNAnp0HH2hbYwT1ij0lfV8vzIAHazericC4nK0pQqs@nongnu.org
X-Gm-Message-State: AOJu0Yx5QSBnMYt9oQO8/xwX0FH7IuVAO+cqbMuNWouYN9/C8XuOrvb1
 wWDcnF6j9NFlfr/7wRvAugGCYpR4ljb7fVddc1lgAA6R7HMtkJVrFqeaFlJK8J9SXQ0uQv/9XAZ
 5OmdV0t089nX2RSO6to2RfHoculj4gozbBncU3g==
X-Gm-Gg: ASbGncvMczpdcJxrJIPPvnNAoZxIoekJXRTfQ/i+5ifJkQhsmPX/l6FxDoOWOGh2C61
 5cWAXoQSQNOEnKRiNYuYOIwjRZMNmpLGjV2gRxgfOM1dpuMVBdmL2W/A9CCgztrLDP/9xCzy3L2
 JwZFVJcl32UQv+OdpBTgMeiTY=
X-Google-Smtp-Source: AGHT+IGivXYqaELCns2LzVprbOSUI9DXV8i3lWN/4TXqjkHCVY58UvP+t84jvGtisg6SrYFNHGqPwDlniSk2wIQi6lo=
X-Received: by 2002:a05:6902:2512:b0:e72:e170:cb78 with SMTP id
 3f1490d57ef6-e75bf479517mr4528402276.0.1746536048282; Tue, 06 May 2025
 05:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250414020629.1867106-1-timlee660101@gmail.com>
In-Reply-To: <20250414020629.1867106-1-timlee660101@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 May 2025 13:53:57 +0100
X-Gm-Features: ATxdqUHG-3n6uetnsoUu9gYr8nH7UJrcwK88I9L6a8hzvlsluzADwXWScDjKif4
Message-ID: <CAFEAcA8L4KzJZ+Ew-n+XNjHB3RmYnM1noq5nXo0=xzpMSBsrXw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: Attach PSPI module to NPCM8XX SoC
To: Tim Lee <timlee660101@gmail.com>
Cc: wuhaotsh@google.com, kfting@nuvoton.com, chli30@nuvoton.com, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Mon, 14 Apr 2025 at 03:07, Tim Lee <timlee660101@gmail.com> wrote:
>
> Nuvoton's PSPI is a general purpose SPI module which enables
> connections to SPI-based peripheral devices. Attach it to the NPCM8XX.
>
> Tested:
> NPCM8XX PSPI driver probed successfully from dmesg log.
>
> Signed-off-by: Tim Lee <timlee660101@gmail.com>

Applied to target-arm.next; thanks to everybody who reviewed this.

-- PMM

