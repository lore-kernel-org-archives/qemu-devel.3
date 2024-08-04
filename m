Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AA2C3DA7F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 07:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saVMJ-0002Mf-TD; Sun, 04 Aug 2024 03:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saVMI-0002HI-GJ
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 03:08:50 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saVMG-00009u-VZ
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 03:08:50 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7ae3d7222d4so5736959a12.3
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 00:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722755327; x=1723360127; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U2sg0dqgEPlR41KrMaUbMHNXvHprXODEYnEIYICokyc=;
 b=ApSoUZF1V4UXUl1ZZQU0wORkneT33hfNKRInVwSog7sNsFLoZvYlanqbblOaEnDlyD
 2pUUZtk3eQElw0WyeGyYkdriV4vHe3wV4ot1FzLLqpXj2+uZJMe31VwtxcY8moQBI6jA
 gZZVlANklDjPgquoCrb1FzoK9cIhXwJDkS59N2OLOH7R3i+6dVoIuO9dh+Hj7DGVbZNP
 t1e5yKduyxKoK0xLikvg2fG2/p/bWMpO3/3M9hOZdkY8dT6pbVzMI9kDpRUEzEfGfx/g
 f1mvf03pbF8+u8w/nXgHnluuSrDwJwN5zdcUAik4oP+EjjDIwf7kRyYkwGWhH3gkX1Na
 2kXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722755327; x=1723360127;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U2sg0dqgEPlR41KrMaUbMHNXvHprXODEYnEIYICokyc=;
 b=nff7sWdP4aD32zU5bnGJ/SjhtKEo5Trntkrh7PWj5F6Q2G0JD/YBTK7xb2AnBn1K96
 h3BP3LQynVCuBiY0wL1URLS9WWnLXc1XQcXDL4HJouE01Idu1s/8VEzJrjECR7DVXqIz
 5ucXvVKGls3I29zZXuw49a3fi+ocWxBp5IYmzykqG7jb4PXv/YbFMrqa2ydrnLkhlawA
 8moWb2dijLeXLYp0hfWNuxP/jN84m/Yh7gfHJCA6Vf60dqchEt+XgqZss87L7qrySGGx
 BJY4SQ2imfRPd/QD3AnqfBlXAr32lq9EkAwLUGjHhqXtezaxh3igBAVKAKHEzyVrwSgp
 zJyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVv/HiDyWqYJUWrIZIquaH1hwZxSUF0Lg2JzN23e9Bc/3jN6aQbu5h6RnCMfDO3sQoS+HtT+XnrwPIQo9pVTqBZkuNXg4=
X-Gm-Message-State: AOJu0YyWe81IHlynhqU29LHId8iFjkDcQcieoPKoP6VCF30lyt85F0Uw
 Kq1gm0mdZsYj/9/5sSUkL8SHLXD3S+eBipP965tSicKm19RUdDfBckBknX3+/Xs=
X-Google-Smtp-Source: AGHT+IGQNxOxgMFCn0T0NyXZjT4oTQ914maM1orLPj0PrDQgNGFPPsvfvQGoRQ8X1GrKWiJtf8CIHA==
X-Received: by 2002:a17:90a:c241:b0:2c9:7219:1db0 with SMTP id
 98e67ed59e1d1-2cff93d410cmr10037852a91.3.1722755327198; 
 Sun, 04 Aug 2024 00:08:47 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cffb36f12fsm4525735a91.43.2024.08.04.00.08.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 00:08:46 -0700 (PDT)
Message-ID: <47462fd1-ac72-4386-88be-fa9dc1d69c0c@linaro.org>
Date: Sun, 4 Aug 2024 17:08:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] bsd-user: Make init_task_state global
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
 <20240802235617.7971-3-imp@bsdimp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802235617.7971-3-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 8/3/24 09:56, Warner Losh wrote:
> Restore init_task_state to its global status. It's needed for threading
> support outside of main.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/main.c | 2 +-
>   bsd-user/qemu.h | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

