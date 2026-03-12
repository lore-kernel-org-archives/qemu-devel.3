Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B4D1067058
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 16:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0iXL-0004mh-6M; Thu, 12 Mar 2026 12:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangyanglan718@gmail.com>)
 id 1w0hGK-0004fR-52
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 10:43:44 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yangyanglan718@gmail.com>)
 id 1w0hGI-0003jQ-FL
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 10:43:43 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8297e0b27e5so703037b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 07:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773326620; x=1773931420; darn=nongnu.org;
 h=mime-version:content-transfer-encoding:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PyhlH70Pt/m//3mtfy1fn5FS7OzamIj+geiOelnVVYw=;
 b=aTSWbgRuBwpAIdTieiqWeqam9DvVBCIOPoFy0DzfcXz7CMFJTkyxkwDIjkXrzrK1WC
 ORrgK5uktM4J+6nvN5t7XUy2K3EjcGtxEZcwmuOaqNH7oJ1V+Wxf2g1wYIA1tVpWf4eq
 8pDUXew3+bqpUIAOTp8JJR2eVI0Vmak4gPXyIQPMRkx1e3Z8nspSpe1GUsaKureiuAHl
 0dUDkd2gqfSoSA5gD2Cv4InECw+aq77CwTLu3WSJWg3PLZbjIX/1LV+zG+J8Pyje8A8H
 3FNbUZs19OHGrgPxDVM0AMOsindy7sAI8BK/pMfhreC/JoDf3Yj6GuOpr51coS7NsQsT
 5Teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773326620; x=1773931420;
 h=mime-version:content-transfer-encoding:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PyhlH70Pt/m//3mtfy1fn5FS7OzamIj+geiOelnVVYw=;
 b=UywXQaEm4Wzy1YkGlTUhHSNS7XVqrzVplGN9h1Yz1+fAV9vtt3o1mptXUa1WIc7TCw
 eA7B7C1TZPvCqWxtyvc/0AUiyelDlaNX5V70GFSVtD235Ve6/ow1s1LHryU4GHnCLt6d
 ltTBrxV3J9cgOuOf0U2f82PyMDhzv28evioUprO8k4fpkm2FiGUBlgLLkdIYSORwuRY6
 Yt9FInEatBrvsMzJrcTevZZcKiobpEro1Z7mvBOTX/GI0A42UVOB6fpTd4N8CE9Q3kof
 Gv19kvv3nFWmqMC0Uu5ViNmEbjXaGZMsKBsWeZ+NNJXY0SF0DPbdyRxKwYFHq7OgG+wT
 /RfA==
X-Gm-Message-State: AOJu0YyUlE//xk9HHW8k9yaG/++jbHgrF/Q7pUtYmslstRr7SgXcN3Nk
 bTwe5fseFk5mz0Rt7yYyRXl6SC1VdjuyqTBSDY8olrB4W/01I7IADZOX
X-Gm-Gg: ATEYQzy6FQ0018CVmcHem4HnAMLC7pZxI9V1CN2XFrz60baRjJfwatN3HIN7fRWx+c+
 FvG9AQdhQGjedyU5p9GxwPiAxQ1Y9hiHGvpXWMRFDnE9Dgj9COXHGDdRua0+6vvA2Rba2JH1FKR
 ib9U+PghpcROFn85+n+wbCnYeGJCr+7LXZ5pSDlCLXr2VEzelnuzYo74kpUHQCzxbkQtXgjDeIo
 uEF7k7+J5zn8UI4xTTYeG00m4/I5f9lSAR/JdFjj5ZZguP+E9WKPAVjoFBzWajTaFO8+vWGL+3s
 UZ74DYGbfwiaL8PFcNeh6GXN0uCeem72+Enw7s5Upa/OAs2vWjHQnmH2wLoBwh+L+0qn20ztODA
 7lEHqCjke6UgjNfmdhPtOzljrofSLukKWG/GfNJ5MbAd5X/y5VT2y9iAr88U7WSbwWekxCtQpPz
 IBrYVG2mrAYqO44Ed+c+uvvAfq+Ly5fg==
X-Received: by 2002:a05:6a00:91d9:b0:824:1b66:6ae2 with SMTP id
 d2e1a72fcca58-829f707337amr5003074b3a.10.1773326620523; 
 Thu, 12 Mar 2026 07:43:40 -0700 (PDT)
Received: from [192.168.10.24] ([141.164.55.238])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a0734039asm3919307b3a.41.2026.03.12.07.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 07:43:40 -0700 (PDT)
From: Yucai Liu <yangyanglan718@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 0/3] i.MX6UL LCDIF: add model, build symbol,
 and SoC wiring
In-Reply-To: <CAFEAcA-L0t9rGZuJ2CWPitkBP4qBA9wvFf+xo4KN10EiWHjf=g@mail.gmail.com>
References: <CAFEAcA-L0t9rGZuJ2CWPitkBP4qBA9wvFf+xo4KN10EiWHjf=g@mail.gmail.com>
Date: Thu, 12 Mar 2026 22:43:37 +0800
Message-ID: <177332661726.1222891.10412128537422308719@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=yangyanglan718@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Mar 2026 12:05:10 -0400
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

Hi Peter,

Thanks for the heads-up.

The problem with v2 was the SMTP path I used: I sent it via smtp.qq.com,
and that path rewrote the cover letter Message-ID while the patch mails
still kept the original ID in In-Reply-To. That broke the patchset
threading and patchew parsing.

I have now switched my git send-email setup away from smtp.qq.com and will
use Gmail SMTP for future revisions or resends, so the next version should
preserve the thread metadata correctly.

No problem on the review timing given the 11.0 softfreeze. Thanks for
keeping the series on your queue.

Thanks,
Yucai

