Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41272C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 11:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riBTW-0004Ww-Gd; Thu, 07 Mar 2024 05:59:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riBTT-0004WR-Oj
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:59:43 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riBTN-0000pv-Ej
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:59:43 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5654f700705so872623a12.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709809175; x=1710413975; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LSceiuVjh2dkgwAC/tZzPl1Za9geIcR1BUd2AgRb62Q=;
 b=oE5g82+QUq7g3ZHu8QlO981e7Nk2gk8cqgxAiQGBB2CwqcsJnYJx6ItKCs2UFT9IJw
 vprmeHtCRESfLmj7V0SP7JNroQtUsJZKesM4JUxnB6rU1dx7uztE+PTSzHgfXXf7bR8l
 RBYlnIehY0gtnxXYxgFUbyp5GuuRIr9iDYHcOcgep47XMBc1Dh0liM2dCYpfEJ1Ak360
 oz+Kw4dBHeW707SKH2QjIPfIvm3HGMYKM9CFvBWVtxUECb98ruIpABm2i/ZCxlO0Trl/
 be8WMsnjlJAkLJfaMgPjshIjXuAt0q0zy3E3ITZ9aUg7Y+1C6vE7nS+3thkzbJNoybIl
 M+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709809175; x=1710413975;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LSceiuVjh2dkgwAC/tZzPl1Za9geIcR1BUd2AgRb62Q=;
 b=XfHzGJwsNW9+aToWYSW3V6PnxJg5i+3y+EnmU6qPPiBVL7qlXbdZWRz83hMErSXQeX
 vQs0gGU5wm9c55jP4mcjs2zy8ZdD9iG0K5Zn5IQCcWTEyLMtvIdQpZi1FE1KpYJbWqG0
 xy7B/OrfwD+awKRGruLwRWy4H2s7txd/RY6ILKUFPk5rN0nGXUBGOTs71LAOfwwi9QO+
 CAN+SQACxpTK7IUof26decD/Foouwki7BTrNa46IfNw/x4m6a/QLSeH3oK81zc/gam6l
 F22icSjhxH24aEmiuyVIqnq4pN6aQvwL0kQ3dc6RLvL0eXc6BmilNFhwfKWXsFrwkulX
 +ZPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkxCqhLTEublkthtAy9e9+2Y8z6HvWRasWPLCRoJ0vwuiYMrAuLKY5CtkPIlbQxKtNKkC79Jhzee0Fv5Id0CGIrZYBviI=
X-Gm-Message-State: AOJu0YzrzD5EYuxBJFemGCRJJM5UE+kmhNZcNQbzG/dOqyGl2/uI0ljU
 YlWm4/MzCcAUNDkfb8AwP13LjuZ3qwFy68T952gMyPKQBYPQEZEnYTvFRSS5tlVFFD2C0RsCARO
 cg7ci53yYZuiU1t5KtMjLALpupsoyBSTZvFbXtw==
X-Google-Smtp-Source: AGHT+IEnsDL4pUXLKgTtJsrZWyUBoXAA0e+qPAOv1gN18OgxKZUJJRM/6vDpLFLZWOM8tiMk/owqgYRf23zPys1JJzg=
X-Received: by 2002:a50:cc8e:0:b0:566:1794:7b2 with SMTP id
 q14-20020a50cc8e000000b00566179407b2mr14628153edi.13.1709809175299; Thu, 07
 Mar 2024 02:59:35 -0800 (PST)
MIME-Version: 1.0
References: <CAKstcpWLhcNswkippmDyQQz2bPKSN+w9F0jZzcZRGpuNWvW55g@mail.gmail.com>
 <CAFEAcA-eDU_As==Yzd5+xhAPKGzfUp2DH_Kj1owL3jvm8s+qWg@mail.gmail.com>
 <CAKstcpVT-swdej7ghk6Sc3Ngwb-ZSrVDUw1=4Rxq5EHOgfjPvQ@mail.gmail.com>
In-Reply-To: <CAKstcpVT-swdej7ghk6Sc3Ngwb-ZSrVDUw1=4Rxq5EHOgfjPvQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2024 10:59:23 +0000
Message-ID: <CAFEAcA837tobTz-5M-1AQxJcRgaY_qLmWvOO4LG4O0dZr8BkrA@mail.gmail.com>
Subject: Re: QEMU Compatibility for Cortex-A55 AArch32 Firmware
To: yb liu <liuyb845@gmail.com>
Cc: qemu-discuss@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Thu, 7 Mar 2024 at 01:03, yb liu <liuyb845@gmail.com> wrote:
>
> Thanks a lot for you respond me soon!
> The exact instruction is mrc, and the exception happended in early boot process. I have no idea to how to debug this error because it happended in code_gen_prologue.

That's a system register access. If you can tell us
the entire instruction (in particular with all the
opn/crn/crm/etc arguments) we can look at what register
it is.

thanks
-- PMM

