Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E106CD6E57
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 21:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTo22-0003G8-OG; Sun, 31 May 2026 17:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTo21-0003Fu-BL
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:49:17 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTo1z-00010y-UL
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:49:17 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4909e3fa4b2so22828635e9.0
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 14:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780264154; x=1780868954; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pPvOdoOlEQ8oyYt4dbkgLgXTY9x4fZj0s20Y4qnD0b4=;
 b=Q83ReM5/4zwSfs60Gz8EgDW+xbuadg5Ey2jBKzS+F8fcn/UrCF4GDkjabqWu+wNIns
 BlArVXInRGzEeHN75CgeTsPpjfkY2cMwqYgx1JxRrik0QNOJxh4c6UrFvUduM8QKs0NT
 Q6QDNZC2tqtV5UOrH57TxvcPYBvIfU5giN8ikfSNR3fKW6hb8UkAYd3vPBhNDkBdZ6d8
 8455ItVEdz19m6rCPICPeszu0QvmAh2AGNAvUFG8wIXK2/VtcugsBiZLP7RIblKg0ZOS
 EKBuKfkhrDQ5L6y8URZL79rpRKa6J1TIyCPy6izQIuOLP0oNyF9dc885lpmoIcYAacwx
 yLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780264154; x=1780868954;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pPvOdoOlEQ8oyYt4dbkgLgXTY9x4fZj0s20Y4qnD0b4=;
 b=LWkvIcFMEkTP5fRX0GRL5oHU+ZCxWcNanDdzdRf6Oj/JPaOvwRLZywlUIwDoOhw7za
 9D74neRvNXOGpRxICxgNLW/QwdgaokXjlsQ8w2yT6pVm7DnRLzwcludbtwq9j3Ig3LGm
 gwYkNHOCTwjt66lvYUq0FOalHS3sa7RR785AJKFYfZGo/R8mSv/EyVGapfF/gA8o5wIu
 pXMVf79pOgTgjb5p0tOKnLyfpo/Yc+YWx9gzgdkKeoAVbcKDdJ2C70bZuDz+NDWGCwfM
 PtNgKxNYsmxFlCt5OLnC/ga+i0AZzDov/z7HH+T6GzWZacvu1MFA3YsDJZrCk3qNFfgR
 xODw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/LTsuMI+Ny5xD9mCaMQXkP1JLClfIj4ydaGIZNnMBsZGLXyl4tCIBsFp4nAlOt8/2S7Mm1eYuJx3Jz@nongnu.org
X-Gm-Message-State: AOJu0YxtCBo3fCHn2nP/8frPAnlk8BTaJlPlvaijOBiq6LyM8KRn5mJh
 a4Kw6rTzRYYfYARQFqtqe6RY6oGi+imUR+cpOpJnihR1+gWQuHnlb/ivw7yrslAsLas=
X-Gm-Gg: Acq92OGXnmQzAzm2pZkE2D9g/BFhPJk9EX0l6iVTKG0WBzSn90TqDgIX5d2SKFZ77kK
 /lCmug+4K495QsGU1ufcZ6NVxc2rmPNWVVPfysL10N1kl7w5+JasbxooP9f/T2pdNpnQHspekJA
 GlscCTxK8pJu4YpbKVmO2774v52lBF1AtIQnXrNv1IXrOP8QdOeuQMOpM5yzXNX+WNbiGVh8d6D
 Nuan2dr/Shfd2as0M09tMNlZQHS/fXQBndOAvjzWQo8T4v9L/GoR75t7iMAhXGGh8LlBzl1cPMN
 DV7mGRIAy9lBmz+VyUbZK0i6kXE3Tzzyx25bZf8z23uLTBEytVszlD6LIgZ4h0UXZw1h4vXQi1Y
 LbTFde5NyQ2U13YNS9vkHr9ZxA8l4SDmS4QVM+DkI4RwA8ONhls6Ed51i0Rze60pb2AF8Lf4riY
 G3NHGgyx6IKxf2d7mGF036U1cbQ7xqaMjvzbvUFRyNqWW75FWXn/Ns+ZeaamXCefaqiizFYiiJC
 QZ0
X-Received: by 2002:a05:600c:8b53:b0:490:5380:f2cb with SMTP id
 5b1f17b1804b1-490a28d390emr152999545e9.0.1780264153928; 
 Sun, 31 May 2026 14:49:13 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3563cb9sm21290398f8f.29.2026.05.31.14.49.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:49:12 -0700 (PDT)
Message-ID: <48b7bed8-b79f-4a7f-bed7-0630770e06b3@linaro.org>
Date: Sun, 31 May 2026 23:49:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] linux-user: Use PGBRange for commpage
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, deller@gmx.de
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260530211248.375318-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 30/5/26 23:12, Richard Henderson wrote:
> This simplifies check for no commpage to a NULL pointer
> check, rather than reserved values for LO_COMMPAGE and
> HI_COMMPAGE.
> 
> Unify {LO,HI}_COMMPAGE into a single COMMPAGE define.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/arm/target_elf.h  |  2 +-
>   linux-user/hppa/target_elf.h |  2 +-
>   linux-user/arm/elfload.c     |  2 +-
>   linux-user/elfload.c         | 64 ++++++++++++++----------------------
>   linux-user/hppa/elfload.c    |  4 +--
>   5 files changed, 30 insertions(+), 44 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

