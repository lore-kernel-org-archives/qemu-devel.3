Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A409C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 16:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSo4-0007km-1R; Mon, 29 Jul 2024 12:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYSo3-0007hv-8h
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 12:01:03 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYSo1-0007iX-JM
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 12:01:02 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5afd7a9660eso3688924a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 09:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722268860; x=1722873660; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rj/dPlqiuVDdScDA/xjuPu6u0Gx17JqP01w+LmPTzEs=;
 b=o8MphsvrmZ9O/7yeNrSW0qa/eyEVatc3JLO18byO4bMh3nAjaRJFfX7NtbeoGVT/Tm
 3Jr3q3MHhD4l/XSjM63ImI93hTrDC/ARSTi/wPuEq3urexhCo3Th3gJu/w2ZaST5gUVk
 gyaCZWaZFz9wd8CwCJGAACP2fV1eb/fzEpbvtWRnGxeGuzHH4P8NITZaBdrjhF2810af
 dBCu98lNexMpDrg/wPUbqoXvq6yNjLSteGgiHDU/TQY5GF1Pup5fmIxmMP5AxJl7WwVY
 b/jCnN+J6hAjzUVP9w5yuRH3XD3Pw0i3VnI39IFIKACH6TVxQi+bzevEk3E4jCB/6pz9
 roWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722268860; x=1722873660;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rj/dPlqiuVDdScDA/xjuPu6u0Gx17JqP01w+LmPTzEs=;
 b=gFnx5KJmKj1+Dvah+RLGhKseiZpq0WNYuFACsDS5wAatm4R0KHRYGSb/tryygfycCa
 jUXILgvaViK0JEnObo+WZQD+y445xr8/Lerx3OygI2hg4KN5RQUWeIHiu1NJoY5Ry0tf
 0rxU389NDC3I+YLpddYkl+BjetLRrTPnl/y5QFPBdr9lPlxbNWBIzr8zl6nPs+s7LLgr
 78THbkikre1QsA1ltsTLkuNqXvt5+y1g0EnX3kBXFYDFIW7N6j0s9DOin0x4DUXqMDrd
 pIufWLu1ixNBJZo9ITy1/ArW2haUG1/HrCpM6T/suar8fMG+Y/eVrokfqCCOYqKbQ2FS
 CTKQ==
X-Gm-Message-State: AOJu0YwZiqJG0df3Q2Kvl5AWUtrkMDlzHLWI3QlpxioxQKZAfzHXpQuf
 9aFEuJ7XqPe+5v9ZIJul5MhdHJdjm/VmcNngKoRP0bO9rZ7r5IyClyG/7zjJFAOr1vXCZmvX5so
 1VluMiVFctvge4zLTiHcMimkjcOU4PzPqXmOi0WjwH+15VM7y
X-Google-Smtp-Source: AGHT+IHFoS1IPlb+eZp0sNZ84ZMaoMeha1L1UFDNxJK4K+5LC4Tyv4B4TP5YHB/ReEdJWFDwt0gl51uXFsQKiysthjI=
X-Received: by 2002:a05:6402:35d6:b0:5a2:2fa5:f146 with SMTP id
 4fb4d7f45d1cf-5b021f0dcfbmr5687064a12.28.1722268859834; Mon, 29 Jul 2024
 09:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240723172431.1757296-1-peter.maydell@linaro.org>
In-Reply-To: <20240723172431.1757296-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2024 17:00:49 +0100
Message-ID: <CAFEAcA8wYquqQ6oo9LLh+CQw8Kmq-LmuJbmZ+B3yywQrEcsMhQ@mail.gmail.com>
Subject: Re: [PATCH] target/sh4: Avoid shift into sign bit in update_itlb_use()
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 23 Jul 2024 at 18:24, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In update_itlb_use() the variables or_mask and and_mask are uint8_t,
> which means that in expressions like "and_mask << 24" the usual C
> arithmetic conversions will result in the shift being done as a
> signed int type, and so we will shift into the sign bit. For QEMU
> this isn't undefined behaviour because we use -fwrapv; but we can
> avoid it anyway by using uint32_t types for or_mask and and_mask.
>
> Resolves: Coverity CID 1547628
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

I'll take this via my target-arm queue since I'm doing a
pullreq anyway.

thanks
-- PMM

