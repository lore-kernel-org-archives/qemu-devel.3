Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DB2CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc5xT-0007gE-C8; Tue, 23 Jun 2026 14:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc5xR-0007fw-Hu
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:34:49 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc5xQ-00053a-0p
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:34:49 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2c6dadfbaafso1389405ad.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 11:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782239686; x=1782844486; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g1ILwAaJz4cbvbkdosvyIu0xUaUg5RAwnGrmz2hZas4=;
 b=fnTPvcRaOKB6Tzv8PnAdoe4ywyTQcnRIwtkVaQ9u7K0BRJSRycGRQ4SYM8LusC0jMl
 P5IJpTQKYwWU3Kr3vINM0eoxYRy30HQJM5AQg5Vdr/E+cw1S7wmIgjjPLtjfjmCLuVbV
 4bs4CZgzMCx69mj0YnNYcVf4qNp8MiJfcqmaRPfBSINy80mehm+3Tz7stjvJy9XhmSg8
 Vdw+mAsGORngCqbP2mFy87ArgpsmZJcSXAIAO0C+Z97Yp58FNJfBXsc1FubLlc4qa5WT
 j8eUi2gigraJamnNWb/WNmuLYCFElAAD3ozS+6/l9kSMbielSrXq5KH/MWBfkXiMdk9y
 nc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782239686; x=1782844486;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g1ILwAaJz4cbvbkdosvyIu0xUaUg5RAwnGrmz2hZas4=;
 b=Ehbowz+30/AcQlfodyNrnzSLoMqrT2+O6vDi0M4ryRMkRxu4kJkxGcrGu7HfHy54y0
 hIkwVNOYyyTn0ecs9DwjUt+n7U9QVbXHLUZ2vOb+QSEtgO1oQPHBXe7TCYrpTzKyOP6r
 YvtxUb6rQCwm/ZAxz/3h2dXdU3kS/kl15z8b2RgpX/WdnzG/WflSxq4quEnjmzsusMt6
 WidrstZKGd5a43Clp+lKCCW92acH7aMat4oCrQrSC6oG0Q6obzjfJUcT4wyLUUcFme0B
 IME4wklsvGoUdNXKGn18OY9ZlcqnA/NX0J/khf4Jzw/oFtyXBaJwvA0+SSbTCLOLCYLi
 Djhw==
X-Gm-Message-State: AOJu0YzuU0RfMJeNZtG7TgOCxJErEexmQVPvOLBj0teWr/1a3skfqqSI
 SrKBfGkgMTmeCNS2MuYtXUwM0AIbTWkboY9ZYLWBWnyOS6XK6amGP8dtJMqMyi7J0nj9xvAhSVm
 GnJMw
X-Gm-Gg: AfdE7clsTRt6dDb1IMh+xtybz2W9yiQKv42CPwp51PXOWkOYBspZL8Cgy0p/x93xY/j
 e2w4pp2U+fS9iZYaL1WQ7EbWPWBZKOO47gAUhzSs9WPXBFHpJ1wvaIgWA/l0OtvV3/+aEOOVPb+
 o2eo+vb09UkBbgxMU5fK7GaUQ/at4F41PeYF5VEXE2fcBnx09HhtSxopBkCvoklEfg8rB/DuUrT
 uA/Vfuk8wB46wXFavtYPi86v3YZt9FUXezmWOZVK7E69z9StPQL50uVGML4yEfY5BgMVToWnUDW
 J2Rzqbap6h3h0xOvQyFUYvi9+4bJPu1hpbR8ibB/811sUYhpwtAJLDSJWsEG1MOZBUDLbf37vdL
 kOyfcdJUZL3i8GtsYfrvxXjhiTDi+fhaP5gYL9mR+pK79lmcfXGDmoC3gKLfFZqEHMbglxKNx2Q
 1I2MMbMRmOjY6WaWpM2uRzYrNQWnvBgAe4w34VPpz8+p8hCPxe77FFDnQIaw==
X-Received: by 2002:a17:902:ec8f:b0:2bd:907:2cf0 with SMTP id
 d9443c01a7336-2c7e16edfd6mr343945ad.32.1782239686035; 
 Tue, 23 Jun 2026 11:34:46 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7436ff3b1sm111272145ad.36.2026.06.23.11.34.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 11:34:45 -0700 (PDT)
Message-ID: <67056b03-1a3f-4963-b132-a1dd048178eb@linaro.org>
Date: Tue, 23 Jun 2026 11:34:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/40] bsd-user: Add bsd-signal.h with sigaction
 through sigreturn
To: qemu-devel@nongnu.org
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
 <20260620-misc-2026q2-v3-5-f6ce23ad8dda@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260620-misc-2026q2-v3-5-f6ce23ad8dda@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 6/20/26 21:19, Warner Losh wrote:
> Add the first set of signal-related system call shims: sigaction,
> sigprocmask, sigpending, sigsuspend, and sigreturn. Also add the
> do_sigprocmask and target_to_host_sigevent helper functions to signal.c
> and their declarations to signal-common.h.
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Kyle Evans<kevans@FreeBSD.org>
> Signed-off-by: Jessica Clarke<jrtc27@jrtc27.com>
> Signed-off-by: Mikaël Urankar<mikael.urankar@gmail.com>
> Assisted-by: Claude Opus 4.6 (1M context)
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/bsd-signal.h         | 151 ++++++++++++++++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c |   1 +
>   bsd-user/signal-common.h      |   4 ++
>   bsd-user/signal.c             |  67 +++++++++++++++++++
>   4 files changed, 223 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

