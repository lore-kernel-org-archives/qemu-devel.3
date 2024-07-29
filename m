Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC49AC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSlB-0004AK-Aj; Mon, 29 Jul 2024 11:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYSl9-00047o-Sb
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:58:03 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYSl8-00073j-0b
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:58:03 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52efbc57456so3853269e87.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722268680; x=1722873480; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zqNAnrwlZ7pIqVdvMaH8oPfNljGW4HJUTJaiICPW7yU=;
 b=ObS0ta59xxMkufi9TbbW/LbC/c2ZYr/A868I/JpVc5TZmuCCAjXUqgbFG9m7IZSpg3
 XEJ7uD9M9akoBDttHizlhllZ+qeFnSL+w7vRc2qEGMR2+AkaHUm7NL83DaakLFNPbFuM
 uMqCfXxF1q70m0N1K/CvVTy0PwTGMd/aPY2lLRePcUB5VxRXyLSE5eqKf/F26Rdai5yF
 C1eOKwWXBA3K3MWqQphnN9isoue1nJ39AjQogCmFcJJPXkA4OaXHB2ScXZeCqiN9oZeY
 qurDYvkMB/aqXBjl0THU3MyErRTfdiDnEVrE7RHWp+RLdxHnue1kMM3u4ozAHip3Yvku
 meIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722268680; x=1722873480;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zqNAnrwlZ7pIqVdvMaH8oPfNljGW4HJUTJaiICPW7yU=;
 b=EIJnAP/kZeOd+v2XlhLxU/v6gU5wLDKHoN0h/TaDDWRGt1zi6OeD63nSK0HLhIUeY6
 Hdb5eq77ps4sz2vYMoY86+tfxkD0VXVNyFZ11K1OHa/89/C8oVadvrxJ0KGDeSRyFy8f
 5DTxCp2S1fJMMDwRTJyvcVu+QliwDUS/pg8gnSAm1IImB4RMHxJLEBZE7+GLlTWQu34U
 c38FQ8AQY6Nxmmx4lt2NGHSwE8kPo23JCgxR/PBOAttS80iFDbGkboVg24BP0nepBv4k
 LJ/hJnlvZfY24DZ3WI4PQVl5ZOgYUecNgbMwFHqN6EL90R9wO2x8FucyY6mss7u638Jm
 /znQ==
X-Gm-Message-State: AOJu0Yw7D02yEpvuLhUGrL4xBCSAvr6ddWVmn6ZYMTMbgUzmts7YxJc8
 QafWQFIpmdqFU8o/AtmXdR0FDxeGeYWzgT67MLhr20AP40pI+QZpitR6RA8ZZI8JQaCrSUB+sCR
 jqIr4DGnXD7i6Mkit6SylOWUpsQV5YKWfdXkABPosrZ4m2xcv
X-Google-Smtp-Source: AGHT+IFbWsBTnqsvH2AO/WuIpcBB7jM7gmvw1fbFdNEuzbE43H6WGcYQMEKQ2bWveK4S1P+ZKeOhqvtZ0KhehCv8FN8=
X-Received: by 2002:ac2:4bd1:0:b0:52e:9b92:4999 with SMTP id
 2adb3069b0e04-5309b269ae5mr7223272e87.2.1722268679959; Mon, 29 Jul 2024
 08:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240723151042.1396610-1-peter.maydell@linaro.org>
In-Reply-To: <20240723151042.1396610-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2024 16:57:49 +0100
Message-ID: <CAFEAcA9KkA0YKp-VxOMkBi7C6G7tiJaJVJVR8YqzQxQagwppLQ@mail.gmail.com>
Subject: Re: [PATCH] target/tricore: Use unsigned types for bitops in
 helper_eq_b()
To: qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
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

On Tue, 23 Jul 2024 at 16:10, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Coverity points out that in helper_eq_b() we have an int32_t 'msk'
> and we end up shifting into its sign bit. This is OK for QEMU because
> we use -fwrapv to give this well defined semantics, but when you look
> at what this function is doing it's doing bit operations, so we
> should be using an unsigned variable anyway. This also matches the
> return type of the function.
>
> Make 'ret' and 'msk' uint32_t.
>
> Resolves: Coverity CID 1547758
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

I'll take this via my target-arm queue since I'm doing a
pullreq anyway.

thanks
-- PMM

