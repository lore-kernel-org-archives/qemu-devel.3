Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BB6D2C114
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 14:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Kog-00050p-8S; Tue, 05 Nov 2024 09:45:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8KoW-00050g-8s
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 09:45:48 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8KoU-0007bD-LL
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 09:45:48 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4316cce103dso65556975e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 06:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730817944; x=1731422744; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W9+zn0+XH2HvGM0xnnw6O5PqR05Y0CvqX4wE7j4ylc8=;
 b=dFJ+8wcfbK1nyZ2MQtqXNsD9StNjgVXkB2zChDi7TxvyX+VqxKx2Jeqlkavs0RTXLN
 ngzqAloft9UcIBemVCl0bd4RBQbHSzpiAfF3xL8yQ/yltfjSVUg/H+vqdqZomFzOTGsw
 13XNBDvf3dordevnDiWpTnuf6PcShUbPLXoUxDECHKEtVGzKHTz/ySs1Ra2Oh2jP4is5
 QBjGYfVUU/hy29XloOkWHpvbBpg2mlRlxrU99C+8ibI2MiW4B7Kb+k2Acbs7BzzL6+iz
 DLh6wIrGV8sskSYIFgZCcdh6sAFlFj2WrfNC+5GjschmA7phRFL6Mig4lhzgcEUduWBW
 uv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730817944; x=1731422744;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W9+zn0+XH2HvGM0xnnw6O5PqR05Y0CvqX4wE7j4ylc8=;
 b=DbO1rAkAwCegKp2MwAgNQGcr+Ck7ggmRiwTY+NEzVsrQNJ7WqGbl66OCQtF95i2Zjw
 TSAKoBsEuusu99XszceH/QVHdEWjKdTJiLLLhOtQWfq8jvSJJo0TD3Yvhv3tsj7Cy+sN
 4Gr2juvkmZ+kvbQC41hPyPThxNDwSiiU94xoukWs1Sa/2gmc/rQoGrDpdF8ITZvAk2eQ
 njeHfEpCZQHxjBtAJZeZSE8CbUn1s3QRgmAPwrBRzm9hNqUXbf7d8vo/qOtu0oaRWEil
 jEfb7klF6ldtLgxtyIsG/pdFuPWdJBUb6s2nWy5ElVPPSRJg057Kmaw7RCO0z8KEn7e6
 0w4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6k49TMwkHngeFDS/qJZ2RrvG7BOBlom6H5nDhOankOCqbgSkxVYLTg9vft1IkBqEtxz+KqU6ADTDb@nongnu.org
X-Gm-Message-State: AOJu0YxnGX0niSmR0ZO746w+qxnm+fZcpqPfH9TlS5qzGjX38rfx2jow
 H21M6NOAwCcprPzOgRJpHyp/JoTEUW5putqxJcdwPAyL8s8JqYqDqU5gHpFG7uY=
X-Google-Smtp-Source: AGHT+IEy7oq8KLhWci1W3xz+y5fTW58CICW9bhnvou1Gts2SU3oOBFTMLKjd2AjK+fVrbQgu4TaLTw==
X-Received: by 2002:a05:600c:1f88:b0:431:59b2:f0c4 with SMTP id
 5b1f17b1804b1-4328324ace3mr170822295e9.8.1730817943854; 
 Tue, 05 Nov 2024 06:45:43 -0800 (PST)
Received: from [192.168.21.227] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5ac37csm191726315e9.10.2024.11.05.06.45.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 06:45:43 -0800 (PST)
Message-ID: <299dcf20-b10f-40c9-bffb-19939ad8fd56@linaro.org>
Date: Tue, 5 Nov 2024 14:45:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] user: Introduce host_interrupt_signal
To: Ilya Leoshkevich <iii@linux.ibm.com>, Warner Losh <imp@bsdimp.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241024200031.80327-1-iii@linux.ibm.com>
 <20241024200031.80327-5-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241024200031.80327-5-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

On 10/24/24 20:59, Ilya Leoshkevich wrote:
> Attaching to the gdbstub of a running process requires stopping its
> threads. For threads that run on a CPU, cpu_exit() is enough, but the
> only way to grab attention of a thread that is stuck in a long-running
> syscall is to interrupt it with a signal.
> 
> Reserve a host realtime signal for this, just like it's already done
> for TARGET_SIGABRT on Linux. This may reduce the number of available
> guest realtime signals by one, but this is acceptable, since there are
> quite a lot of them, and it's unlikely that there are apps that need
> them all.
> 
> Set signal_pending for the safe_sycall machinery to prevent invoking
> the syscall. This is a lie, since we don't queue a guest signal, but
> process_pending_signals() can handle the absence of pending signals.
> The syscall returns with QEMU_ERESTARTSYS errno, which arranges for
> the automatic restart. This is important, because it helps avoiding
> disturbing poorly written guests.
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   bsd-user/signal.c     | 12 ++++++++++++
>   include/user/signal.h |  2 ++
>   linux-user/signal.c   | 11 +++++++++++
>   3 files changed, 25 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

