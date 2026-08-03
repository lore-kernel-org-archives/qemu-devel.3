Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36BAC55179
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqtil-0003wl-BR; Mon, 03 Aug 2026 10:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wqtiQ-0003v4-8Z
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 10:32:33 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wqtiM-0005Y9-5Z
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 10:32:28 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7eb787dec99so2229458a34.0
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 07:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785767544; x=1786372344; darn=nongnu.org;
 h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
 :from:content-transfer-encoding:content-type:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wdw0egJj7I8+YCztoAsEwUJowbOM3dsxMPfUTD09360=;
 b=k5nmeI5nYSriXx7SgdLKHJpv5RmDAx6iMz1M7BGU/AATLAPfDunHGxyu4QCqiyt7Cw
 nBta/tARI2MhB2Ary+irskTh2XV63F+gI46OgC0bjP3SNf3gTGqTut6PaCaBt2KyeWHn
 rKG3WjBa2zib37+2e8t5n3bY6uNFoOjZGDtrcLz2sitVBkc3XA7bqQPwQY+3W67Sdk1v
 gOZLwUYkvWnE5YtIR0bcCDOLXlrrs4UZc8xHjXv9OlLx76l2dyN1hJ5fLoqfdYmPjLJm
 z+/60O9CFRgocmZeDsQjrKQGlQGyXBoNeNPpL3Wf4K01EeisnlFHhAmRHCelmlYnx/Fz
 aP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785767544; x=1786372344;
 h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
 :from:content-transfer-encoding:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wdw0egJj7I8+YCztoAsEwUJowbOM3dsxMPfUTD09360=;
 b=HjZJEC8eDUXW9NnLdB6qXH0pangJYvv05U8lV/xcsA2AvQcWlPmSTAJAEmR/p/cpFN
 oz/Q+P54Skt9JJwqGQjlfvlNzkyYvdDPBqf04ilax7tU+OhWnBB8an+T4aYWnHpUjtYm
 ENSUNZvBf7NglkIlLUQP6hp/Izp9l/BJjc8+eWHldoYYzIGdNrym65PIvHLslg96HpPt
 gmIbWNoN42IO35bDQZn223zswFDqaOqPMi24+xLV16SqATJULHkPw5gS9rbE8Btp7A2E
 IMw0OqqWPvt7HNPC+KEUu26f4BloN7Sr29P/XefzTRJm/rOo8Hv1L+9LIqG+3pW4KEen
 2kFg==
X-Gm-Message-State: AOJu0YwFALOFfwtBgYdS8maz6MatfXH2qQxpln0rD39odxBtux9bdOaV
 +CeAK+VKW0kp0WOpKZju+pLBEN5H7lh2Gudd0ymJD7O3UwyC1ANjxtQx
X-Gm-Gg: AR+sD10WsCC/gQlyiY1/2GBTW3hdQ774tIvEgQ2Lo90fRlx2sSFrukQOCsnYe+QSWNe
 ARZrgtkUY3tkaeRSIq/Bg72C8jzwifLE2JzZL8k7F5g4pRfEJOdhCJnUgKd8kNI5sXpOEE/ZYas
 y1plUUIW7yFEr/Jdw+isKOTSIQrOhOW0Sm7YjVT1EnKIQWrWOFyYJ2fGXNUcjCwnOdogokqq3Q3
 QX13m3OyVoCWDla7V5ZEngzNBNusOah7VcChm5O5ypQTBEvijom89hIBo2qBPVQiKn2CfoJbHWZ
 JAtHjNveqCZg6jq1gO4hu9qJTbTS32h2P9CG0rcDK+dZsQdSUSSDJ129TYhzabuydJpZ1TvqwDr
 bPwjBHfovaGAEahudNrqKtZNyiI21jjVoyKk+GLWA3hsQE7B2GPpmC4F6jhsX47ngmNe5G3JAc6
 gsTZtKJfcgeHwVTyzkA377j+x/fYc2wBQMuOItbkIXLeKkJrGS8BV/rfN9JW9pdHmE9brsitjT5
 UaEkg==
X-Received: by 2002:a05:6808:190d:b0:495:d7ec:b6be with SMTP id
 5614622812f47-4af5e3870f1mr16347885b6e.18.1785767543747; 
 Mon, 03 Aug 2026 07:32:23 -0700 (PDT)
Received: from smtpclient.apple ([16.9.2.1]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4af58f7238bsm6350835b6e.18.2026.08.03.07.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 07:32:23 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Simon Xu <simonxhy0404@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 4/4] hw/arm/mps2-tz.c: add new mps3-an555 board
Date: Mon, 3 Aug 2026 09:32:06 -0500
Message-Id: <11D7F3C6-3898-444D-BC3C-476C6F6A9ECD@gmail.com>
References: <CAFEAcA8_VTfU-7xvR=Nii8nC_SEPvv0VtZEVQD6zdg=bJFnHTA@mail.gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Owen Giles <owen.giles@hpe.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Robert Elliott <elliott@hpe.com>
In-Reply-To: <CAFEAcA8_VTfU-7xvR=Nii8nC_SEPvv0VtZEVQD6zdg=bJFnHTA@mail.gmail.com>
To: Maydell Peter <peter.maydell@linaro.org>
X-Mailer: iPhone Mail (23F84)
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=simonxhy0404@gmail.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

> Why did you need to update this? The AN555 appnote documents that
> interrupts go from 0 to 127; 0..31 are the ones in the SSE, and 32..127
> are the "external" ones. NUMIRQ for this code is the number of external
> interrupts, so 127 - 31 == 96. Like the AN547, the highest interrupt
> is 127, from UART5. So I think that 96 should be the right value for
> AN555 also.

I got the number 100 from the an555 TRM, page 17:
https://support.arm.com/documentation/107642/latest
The last configuration "CPU0EXPNUMIRQ" specified 100 so I thought
was what "MPS2TZ_NUMIRQ_MAX" referred to. But I do see in table 7-2
that the IRQs stop at 127 like you mentioned. I'll revert it back to 96.

Best regards,
Simon Xu

