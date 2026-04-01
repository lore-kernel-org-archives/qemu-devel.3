Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CB7D2ED0A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7vpE-0004XT-Ke; Wed, 01 Apr 2026 09:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7vpC-0004Wc-FY
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:41:38 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7vpA-0008N7-U1
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:41:38 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4887fd35e60so11029005e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 06:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775050895; x=1775655695; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sWPi3XkjO+zSgmU+XnKA33L7OlSFTfxWhzYnTUl8PBw=;
 b=ZLcF1mMFpuMFnRvbBQi9yHsc4baejqahNVqXoZ05KX7mI0QbS6bakfn3y7Uj6vePqd
 90LYpAxKb45JYJcfByFnvq2NO5Gy/e0R5Rc16tlkCqXt2bqhVEq4gNtp7ODY+xyZgVLr
 7XeQfiHcAkmz4WwjBNu/ce//iai8OJgOxyIiDb8ZnRKr+nRr0YdwOwnF72WwVSbrvgT/
 Xjz1lOROUbigvtCvIQh5LcVeXr0WhEEV/C4Vx5iyngGWP+b8qXe1sEKmgfX6/KaRNPv5
 T5hXj8joQbGdBYtGbviKJ4s37ZCsYBQ66CsF3AqcsRMH5Rdf11DweMrDKiOUwWwWRq2M
 QXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775050895; x=1775655695;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sWPi3XkjO+zSgmU+XnKA33L7OlSFTfxWhzYnTUl8PBw=;
 b=qkLiBkuTDcCOESz8e7UZQ5+dP/+Jb51h14+B++az0c++EVUTiXykQGi7tj5XVRCT/e
 FWam9Fp0218XCNjFZPo/uUOCL/Way+902nNSxWUwJiRBr+ryY4E6gcHDdGOfJPzBKB0v
 BGS8zl1TY0eayN3+CeTd30WUPl+3PHYgy17pTKXxcSOdGcRdFDZTNWMCR+yPvnusB164
 Ahj2DpWPylyV7h7qBMwxUsRBwJUhtpFsqQkkVX+Xp9WI9rosnHKIQ/Z3obeaqrP21VwU
 Bs3MdkWHMm41RBOr1vTAOYSv8RN22jsVX65sMd/Nb1E0oORRiOmMZmaa7o3+86zmfPR2
 l+vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQgOjzzSNrIqhqTFr63kMObC80XzbAIqU1iOBPzLwVUJqifb3pMg78DqCT7H7QPSEBmV8kgE/1WoJG@nongnu.org
X-Gm-Message-State: AOJu0YyVYGond1cns5UHgG6nkeUsho1rjJWFTpNyDoMgdxLHL4y/vCkT
 JLSJiDIbjGmiE0102rzbT9NZ40k8vfbE9H76R9Dozo00V2/8+wU6o2UJ5iWWSNkjvCK48Cng8ui
 jATwv+aw=
X-Gm-Gg: ATEYQzwYEKs4evp6wVayjhjRt7Dpxs9CnitOBp7tfDEgJ8SNX+8yuUaEtamxyG2D8qI
 0YEakoyWk5y4JeUEj8GqhdiWYk5tYbuA0EU0uMp1ESVpzu8UlmKpD7Dr5lnSZ3Qy3x7ETWn7bJe
 7Spu88uqa1k/YMXaY79KDKjSyZQnZB61esHYKti8swUUcPUomzjz/xLM7wbKg0qzyoFVTcWm9lm
 LQpQHK4YGRq1jRgju/jKBexowfr/jHg/COaUt8hon88/TpXYuQPvKZmntoytPZRs7sE4l5b6wUZ
 zNy4bOwBWVHZF3AtahYYVXQ7gLxcVfr9p1NsB40HvP6yck35QjGylQ/dmrBflsuIhKLeXusW1sA
 c6YgfVUQeyf7t6BHH5xMdqxphKOyD2sEv72q0wSoqyzlFyiZ/0Rtjta4LvXgQALrCJiMOpgpsL5
 duyJTXNOJ5Bi8282FLJ9QDXVnAsRoFTYf+pGe0i7bGVzDNwAxp1GouFqWmWRq3ltR5SX9RZxCCD
 zpV
X-Received: by 2002:a05:600c:818f:b0:486:fbc8:8dfd with SMTP id
 5b1f17b1804b1-48883595fd2mr58516775e9.23.1775050895168; 
 Wed, 01 Apr 2026 06:41:35 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c884b8asm40512115e9.15.2026.04.01.06.41.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 06:41:34 -0700 (PDT)
Message-ID: <9422301b-1f5d-4d60-bb33-8bace0bee1ae@linaro.org>
Date: Wed, 1 Apr 2026 15:41:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/60] ui/console-vc: unify the write path
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-26-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-26-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 17/3/26 09:50, Marc-André Lureau wrote:
> VT100 escape responses (DSR) used qemu_chr_be_write() to write directly
> to the chardev backend, bypassing the output FIFO, while keyboard input
> went through the FIFO and flush path. This inconsistency could lead to
> out-of-order delivery when both paths are active.
> 
> Introduce qemu_text_console_write() that pushes data into the output
> FIFO and flushes it, and use it for both keyboard input and VT100
> responses. Remove the now-unnecessary vc_respond_str() helper. Rename
> kbd_send_chars() to qemu_text_console_flush() to better reflect its
> purpose.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console-vc.c | 29 ++++++++++++++---------------
>   1 file changed, 14 insertions(+), 15 deletions(-)


> +static void qemu_text_console_write(QemuTextConsole *s, const void *buf, size_t len)

Nitpicking, maybe take 'uint8_t *buf' (or char *?) argument for this
console method, letting the FIFO8 API deals with void *?

> +{
> +    uint32_t num_free;
> +
> +    num_free = fifo8_num_free(&s->out_fifo);
> +    fifo8_push_all(&s->out_fifo, buf, MIN(num_free, len));
> +    qemu_text_console_flush(s);
> +}


