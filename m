Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6958CC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 11:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA6u3-0007I3-48; Thu, 23 May 2024 07:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA6u1-0007Ha-AU
 for qemu-devel@nongnu.org; Thu, 23 May 2024 07:46:33 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA6tv-0007bu-LE
 for qemu-devel@nongnu.org; Thu, 23 May 2024 07:46:32 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56e37503115so8138313a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 04:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716464786; x=1717069586; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5ni4aatgYwEB5rYv4FjYzqV5DKN2ZiC2r3ylQQbvWCs=;
 b=fsIW4OaQ7oPneiSaI9obotlr5gMvQ9Ouc60naShDTJ8JsEpLqBU8PsOQd/TpS7tFPm
 fIEP84T7MAXYpuPGoGD81Q++cR/fob96Y6GrN8Qfjp5GhZOQv6SzyWDjY2d15grtZ7wu
 G4UDryavbLRWg4KccOX6FDYxI8xNoNNCnQbWa+/N6OJ5/sPYS4XRX1010t3H6H8WFQ/x
 g4lROUc1JkQCBQWAsniK8LVc0bB8DB5EVU6Ipe8/X91uNr+uUKL0sKUo8rb/8e5FZbeZ
 IKIoKz4+AZUAKl2kqYWpxmhaztlLjJynHf3Fga7VTvufNdqHoLHRAX99xsF/xg3U/nss
 xunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716464786; x=1717069586;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5ni4aatgYwEB5rYv4FjYzqV5DKN2ZiC2r3ylQQbvWCs=;
 b=lBldQKzDTDWWf+cD6YkUBurThkQeWkRjLaKV6kq8LNRi+6lDn4RelDFHHRcUMAq+B+
 YKprrICRczU3xApfTNMQRAae2vMkwIeiEYVW4FZuDuzhPl6wuxoDYD1nOhA6XGStRg39
 vSReaavunnnpRTRZ0JUnMtnd9Ta78Cr+lixI1akm8Jt9yEfbHiQlUSWSQneEveHk0AGn
 dNaTF9zNPE8AhUYTlCKPV4S9M79LD0oKjIVuztBYCKhHaRWSPfdhQB8niVTpEGq7o/qy
 jq1B+IjQuUF+ZHigOskAjtUKTWIEKQXn/isf4Pehi+/io2hrtyTtLk21Ga/EplIxyIrD
 HpmA==
X-Gm-Message-State: AOJu0YzjcCztmgoyIeIcZ3SffouQwq3FA/3WnrsgXCHFCugT7gux62LW
 OwtpWLb9yaCydYly21yqppU4pN/VFkKFncWu97s+xU079HhneFSapnUUkzY7K3L4PSHDvh4/j2i
 Hxo2dFkYezmMoMJjLtjpyt3DqUyTGgsXl0dQ6iw==
X-Google-Smtp-Source: AGHT+IHZS0nRjJ7MKmFsMzikG9tqdfnIeDFsi5Mfxk1sm6pdknFnvBsxDuZoA9MBKj79/cciixWtJX3JAm61ilmgcwg=
X-Received: by 2002:a50:9547:0:b0:572:a198:49c5 with SMTP id
 4fb4d7f45d1cf-57832a67985mr2897593a12.16.1716464786133; Thu, 23 May 2024
 04:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-17-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 12:46:15 +0100
Message-ID: <CAFEAcA_vhP2Mp=QYXgFxBM8z06LOG9O5qxY_bcMHdynPA8M=wQ@mail.gmail.com>
Subject: Re: [PATCH 16/57] target/arm: Convert FNMUL to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 6 May 2024 at 02:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is the last instruction within disas_fp_2src,
> so remove that and its subroutines.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |   1 +
>  target/arm/tcg/translate-a64.c | 177 +++++----------------------------
>  2 files changed, 27 insertions(+), 151 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

