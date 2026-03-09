Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F74AFCA191
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 21:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzi3M-00039Z-S5; Mon, 09 Mar 2026 17:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzi3L-00039K-7y
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:22:15 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzi3J-0006VB-B5
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:22:14 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439b9b1900bso6257158f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773091331; x=1773696131; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mixz76pW27YCTImeLcaFqdC2LFwRLt6Wnpe7A5C1DqI=;
 b=W1xJ/sDQGMBxuPdrXgRjmcBs/0VBSQnfG5nPuvnE8tHQvwB01Rxl+V5tx1ld6qDW5t
 RwUvIruwe4dInaML0AkjsIgPLJfv+Qte2/ky3MkCcTIpomc7D0IbqTlzrFDQGKJ/6NOp
 pBmmAyPvUuUSFf5m5gHUMnHNzyfpnzDKIHZEoCZjAq7xzxSq3oLYFJh5RQ9IQF8D+yuB
 0kwkDJLMGmZg/dKbb0yWtIgxMFk45/FoMeMB4KPFEuvW9ndXi3RrN/Q8Ali0weWD+1le
 0yW8eCeqyXRTqfkliakN5D+UJUGArdfbS65byKpL3if8G1JBqhvdGRL3FJ1c2BO0fHuO
 w2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773091331; x=1773696131;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mixz76pW27YCTImeLcaFqdC2LFwRLt6Wnpe7A5C1DqI=;
 b=LpFSiEJgAl1Z220RaSBIHfoYVKdIaQQG5zKN4Wo3+Esa2IarUJcCRSVNq8Tqgf35Cq
 a3x3ns2WUPCjA4tApEuw+3PLtxZhVKqoMNiBztW8rjadEgu5MVoQrAOlZw/kVRva3TqK
 3A6XPPnq1JgbE0F5Y8QNNYikDvUbz0Y4tuOL9xWAikysQaEILGBVFDFjw6Rcm4k0yBwP
 xfwsxCAFv0Cnom0yKemExjw0DBH4OIrthSPFiog2rPQEfSdwahwnB3gbMet4gqSCSdwn
 HzhworrPk1D7xGL1vZkkKIPi9BMZwHlYhcu6++FuwQkGNaNmeqvS258C/s419CrLFSXY
 B/kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZmnomeOIvA1CTe+zvmEQ7pgCiRaimLfIAIsjMbNaoOqnSjUjYQ6ugcP+CU4kPwZnj+2qHXRn847pj@nongnu.org
X-Gm-Message-State: AOJu0YyCN9uxxtZIU4l0H3W+o6HcUP6qG1PRQQFZ59ujUrJM4X7X6/rc
 KE1TaLmhPq2nWHcej3830px2T5Qwv5x151ZXb9bTx/KerhSToQu7RjceBEWqMkDxQ/E=
X-Gm-Gg: ATEYQzy51n6lB/alEh2atjDzRQmZjZlW6xgPtsj1mbNvjrNm+0bCvz+6cPGEvm1hu5Z
 ZBBl6koLGDgO1ORzomdTlmD+BcdP3qR5z3Q9VI9SfqFCGZxDB8QwCNZIYhWZdgTcDkYUEKBRN6w
 0WUWtgiE4BIOGWhSwzncyCRQDoiwoHG8Em5kIZBrt7Vxu0GjuVQuHvV44UtI08S7z9PHZrpcr83
 88ADnhHxmwV8U6dl5b1VGmLaCSOUFxZz3ObmcQTi9zHPBvbxWXXyKCsgOHpWjaFIow5t+wu9P+o
 dhH8TVLT/Y3FqrrqAh16AoPul0Io83FOwAVg2g6AjdhbbTpuuRVJFNZ0s2X11k0f35khXo6RBBD
 wKJX5zWlgQdSFZdTH/uqHVRdslkj4Vls5R0Q/hyz6FZwD9gcLqAbuoCI1r/iJ774t/Np38yOiOy
 +KuZwlpk2DX7N9j0pZR+j5WjvbppB5mCqgMOBTY9lTnFCE93zzJCrAG/xLTPtAGFHskA==
X-Received: by 2002:a05:6000:2c03:b0:439:af96:29ea with SMTP id
 ffacd0b85a97d-439da895476mr21625718f8f.41.1773091331342; 
 Mon, 09 Mar 2026 14:22:11 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae483desm28601373f8f.34.2026.03.09.14.22.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 14:22:10 -0700 (PDT)
Message-ID: <f70d2300-5554-4eeb-986f-927ffdd82dad@linaro.org>
Date: Mon, 9 Mar 2026 22:22:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] tcg: Drop extract+shl expansions in
 tcg_gen_deposit_z_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, jim.macarthur@linaro.org
References: <20260303010833.1115741-1-richard.henderson@linaro.org>
 <20260303010833.1115741-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260303010833.1115741-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 3/3/26 02:08, Richard Henderson wrote:
> The extract+shl expansion is handled in tcg_gen_andi_*
> by preferring supported extract.
> 
> The shl+extract expansion is simply removed for now; it was
> only present for slightly smaller code generation on x86.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op.c | 30 ------------------------------
>   1 file changed, 30 deletions(-)

To the best of my knowledge:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


