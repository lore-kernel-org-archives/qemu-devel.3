Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC46CC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 09:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTeds-00067v-ME; Tue, 16 Jul 2024 05:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sTedr-00061G-1b
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:38:39 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sTedo-0007H2-H0
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:38:37 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52ea7bdde68so5707684e87.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 02:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721122714; x=1721727514; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WpFEopssxRMq/XY7VP7h1cKQm2UsYSwLtfUQNc39NM8=;
 b=iJnvX+3rZylpwpCB3OsZ7QFoAIzIUZ9T0EoGog2rzxfSx3NBNdWPcDRY8X8dKbtF89
 M4aZ+16lPlq7tIZyrkvp9mZsxF1QweotoubQHtU4gN7B2R4Q4KTI8FwNJ78rYWcLkwIu
 xG+Ng9tjWHPnGM2zbhFYWW6apR/oyBz+VmMR7+QK0OOB/b48LxbewJSaZ2sTOZq+Raqj
 3z3ysiqA+MRRwf6RmTLnZhRalDl6WOwb77bemJpuAPhHI7djdXUEjgUR18IFzHTyTzNZ
 zUAqIe9XF4fOiq4P77xiul5jAMAaI07fTYRYWW6KljCIZhZ6RCyvXj8H4MTBdeQkLlaQ
 wQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721122714; x=1721727514;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WpFEopssxRMq/XY7VP7h1cKQm2UsYSwLtfUQNc39NM8=;
 b=viYX6FmUNSuRucJCJvq2eRN+U2DcPc0QcPOQQ0me75/Hs2C6VPzUY5rrFK6tx8Z75c
 zoqU/GtswjSBnQQbV6Aa5IBjr0vGn4lDIN999Oxbnnwmak0cyMC9Uf1ujh9jU1kHi6Kx
 LKGgjgfvoZqHsWyPoodIgh8tMuBNxFXS1qxalgXOj0net+9fiY7Y6zuoim12thNGnBr6
 f1LbQP7v20cXGxzepjsfd8oUIHVqpxU/aobyb2DxbA21Qg5nHib1g4NW3J2FUc7v3Uyj
 1uBcZzHp2J2deXx28lbMzZqjeFjLgphLCIXKrmMOXPCEp62NgFuFuJESd1/f3fysaFXY
 VoBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQRyUESlDYcuJgJ5YzE3pUQBKlGc8mXfwJkhPHEtZLlQIXkTENejCblDAdS5y8el5Tdi4pBtcPLkR1LV2SEud06O9Usb0=
X-Gm-Message-State: AOJu0Yz2Fg+50eXR5Q3pSTX2fp8v0xz71nu4MfxL+ZXKiqAszekzdab2
 YqVH2kayD4fEZ3ZwNrkKoBzdkuciPTw4U4wDqxAVZ8PLAi133Q7N8GgGKZ3v8T50PGWRy5Se8Ev
 ZYZUWqWg+2T4OCFB0u5+1yJKcd+pNsP5xE/4AfA==
X-Google-Smtp-Source: AGHT+IFqJyW5OerElBsx4iiHI316ewP1w1c+mP4RFDTmwEBuuXHDAYcbcNxafJafDOTi/kKb/b5RZzl0R18zaV4wcWo=
X-Received: by 2002:a05:6512:31d2:b0:52e:97b3:42a1 with SMTP id
 2adb3069b0e04-52edef1ebdbmr1027270e87.24.1721122714506; Tue, 16 Jul 2024
 02:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240715213943.1210355-1-gustavo.romero@linaro.org>
 <20240716084836.185488-1-pbonzini@redhat.com>
In-Reply-To: <20240716084836.185488-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jul 2024 10:38:23 +0100
Message-ID: <CAFEAcA-h_NmUsEgfbGkvBGR_KzaNGGn=2FKAsf61-P+_4poinA@mail.gmail.com>
Subject: Re: [PATCH] disas: Fix build against Capstone v6
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

On Tue, 16 Jul 2024 at 09:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Queued, thanks.

Could you add

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2438

to the commit message?

thanks
-- PMM

