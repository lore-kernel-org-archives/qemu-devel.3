Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0318C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTdyL-0005WE-Cv; Mon, 23 Jun 2025 06:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTdyI-0005Vu-Ja
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:00:15 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTdyG-00055R-K3
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:00:14 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-70e64b430daso38192567b3.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 03:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750672810; x=1751277610; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HEfC/ltScEoMqkgpHURVtDhsvwbW0d2+5njoAB3ZVY8=;
 b=V8C+4IQmKQ8fxs4X80xlQYc1Ii/oYNbJvS82tBizJREthxRiQvihGw1z9RNxRhTnqE
 0gRkJt6FTL051mGPQkdznLc6M+A+QKdmDunfNMwsygQzA8DIV/Xlhzuzauy8QV3bwenR
 5SiREZtxbFV9pP9XAg6APUx8/AC76LdjbS1nObCX2q9QCCO/RaN2+Jvgbf1TWjXWh5zw
 9PT80G1sDTxsnMAOIo7MMz4BrC5PhPYfFz41Wlt/h3PR+Vw7BwDyl1sMk5DhcCtwU6zf
 VjkwZ1YtWDA7z58/Q3q05qteH8AlTq+JcAxVlezwPmBGlWR25eM1HPFaD2xK8P19t+A6
 D5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750672810; x=1751277610;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HEfC/ltScEoMqkgpHURVtDhsvwbW0d2+5njoAB3ZVY8=;
 b=SDQFo4ylsdb8SN7tCsYr74HFtzISUaODIMj2mFD2DHIrBfV4uG+fynXuywvoTvqBun
 iMh3TcMlCs2og31g4yiL8LUq+d/S+/RNnfwjX/RRJcup8s+hP3/PM5o5A8vc3HohVj7b
 AwcHabShkZLBL/VyODgwoVVD8BnT11QOMzt05AMDqLrmBT5UHd8+Mp5n2kH5CJFnZ2wX
 jXRQSe+uzmxsXJcL1RJ4rCHBx7yfnp2Vvpxxb0mbyngWx2tLEtb0I7QitBQn4Hdh/HEe
 s6kaqSrs5GjZKxVuAfsvZubcSyN3yLVO2/6tkG6Wil4g0TZLpXYmCikYMFNNYoQA3r/b
 x2BA==
X-Gm-Message-State: AOJu0YxRGdWh6cfGykHgPG4GS9S+/zqbR0FWeZbjjBXhUWjEBYtK/Cx7
 AUk6/hx009+4+T7GnE73DccCrIaOZbP1GkB5jWwbaNBoLLa2jI56OoQoxURihSRE3NuLcuJtIRV
 XIctzX+jLJrUPNS14yzirmUgBx17xstpFWRpZfQhR+A==
X-Gm-Gg: ASbGnct6lO6I7kNrB1a4oJ7Qk/rPm+KVwbpB+VRw9zW33ibMI4fRVxqR+DpMrQMwZnj
 toQeoyOjm1X8EmHuk1VchUa790aOYj75c8oq8AqFhOmwy6M/dVD0bHeoBaTMh8Zkx4lNsuiFUi5
 2pWpLTSWkOOj38QlV8uR0N8ZEaa8tTgpfnnsPl5vSWWcv+
X-Google-Smtp-Source: AGHT+IGd+m4iQElRZt66NaRWaCbhZQRJvMH0ppI0MjZB6YZO9xFijDUcy8OQCEQ6+HWUwcW8he2hRS9iUxNcU89L+Q4=
X-Received: by 2002:a05:690c:a0a8:10b0:712:cc11:aed with SMTP id
 00721157ae682-712cc11122emr117069707b3.2.1750672810367; Mon, 23 Jun 2025
 03:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-2-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 10:59:59 +0100
X-Gm-Features: AX0GCFsKQelgm8HD9w-1i-kR1olysqJuwxBY3fJf1Aq-Jg-962C8HggY6TntZy8
Message-ID: <CAFEAcA_nbm3f1KevuUUKhHvjGA-uXLGgqkLyMN1jWJtN4=swfA@mail.gmail.com>
Subject: Re: [PATCH v2 001/101] tcg: Add dbase argument to do_dup_store
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Sun, 22 Jun 2025 at 00:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg-op-gvec.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

