Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B1ECCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 15:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBaXc-0005A5-Es; Wed, 22 Oct 2025 11:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaXX-00059f-Te
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:14:16 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaXV-0001o5-TA
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:14:15 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42701b29a7eso710410f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 08:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761146050; x=1761750850; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pZXsBTvqT+mTy9u5hKRQLXtczC/UMiSzERNg+wW8V7s=;
 b=afnQtwtt1u8DN8+PesQNWdzeVCmb1phoEA2MRLiLUcy+6zulpFkj5GkbQJS26oFpXY
 DS0aIFRNLITOYfXMeXF5LGqVh6+PLQaCfD+KSwXbkc2Nf+xdFrMcTfrDWZOJ51WslDdF
 uaXq6Qvb/q6/5szTNP3tqThgYcEnNt95wnCJlEGms2iSPkt4vpOif821R6qNqlUoJFAb
 KElMYt3f1dsSaIpllDSV6PlpThJecrP/CtsCzSOXkHscBObio8J1SmeXQ1VFNLPtBFKY
 M6nCiUcZPnentJ6MA9t5alF/8GRpYLKKyR/CfcbP/R+ffptLuH2Qy0bi9Sz2BW0Xtfyo
 c/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761146050; x=1761750850;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pZXsBTvqT+mTy9u5hKRQLXtczC/UMiSzERNg+wW8V7s=;
 b=LersCKPZpG0BtUKA8nIma0dpQ9nvU+wR7XAARvQv7Fvc/bsLvG4R0SnEL3hDrCHoz4
 DTTP+wX2RQeRLtPNhO9lGIEEHyzdKdzZPP5rUZeeWjmonLj/2NzT1uv5tssBW7Yk4S6g
 xELEMqsADtGUldwr9dwmXezPOfJ5It8P4q+/W/h+6i5PTt5j6BDRwtzXLbfCJa2onB7j
 kBYI+csPVph8lI33lLTrSWzVjAIKl3DHkXuuxRgVjzlXW4K5IjfjxiNBaHHX3xstehDN
 g+zcZHwVUqmB5/YL+C6Knwxk4Cfz5iNv9bRGHE21MNnklCbhcaVYcA0ertvZyNJ6dFyP
 owig==
X-Gm-Message-State: AOJu0YycRrWCLMkJLeCfNAhwBcuKE3TLVKc22Un3Dvf/7S5kdTKf0neg
 4is1g0+I1MJ/GivTpVrXDL3CB4EChZj7HplqMcNMJ0Zg1vgD3SMyuLVb8jCT+EbkFkHm4TDEnyE
 k9Y7M43o=
X-Gm-Gg: ASbGncu+5SmgwzoHgXU8Y0UQPbrBH43qVr6c0tSuz4soWA3OIYYtVCkmg+wo9KLNfYB
 22jVWyfJ5oMqW/FCsFjib3LGbXn1M8BR1UpgR728sukzzsPNTSxWZLvs2eehTs2YOV2p3szZeVD
 XKMFuGzqX+Q0m/jKCoUerA+apztcUkwXDOBTNnjwzHxxH+C6WhzEbefEAIy9mBAAOy29kUGkbhp
 OPc2Gtl5T4KtliLP16IWR53LJNXaVclNmGkOX+6OzyRWRlc3VYHbKW86Y3S7wFVq9/qiIykTc7B
 TtUOTxXOjFuaBbTbnRc9dr/jzjDOPLiWpmy1vefKn9EkfFDX0dsXWdZ2ArW2AdD+lcJ+s71MaeN
 cKwmLeaSPk+PF1cQC8auXjE4gR5x3c2W24lv6qVsBUjgJ9yo9Np3yJ9hEsbatrZeYl8Oo3jA1+m
 tjn5AXOHC9v1R/s8Os9gMmTYc5IgZBj4NQSLQQfbkVr3uJ5T2kTuWfQA==
X-Google-Smtp-Source: AGHT+IENz5Re14iNj4wRS2LlTa0/PA8a0JYkQKzM5p/Hfb2I6nsaINhW/1UQ2+ica26IjY4yGfo4dg==
X-Received: by 2002:a05:6000:438a:b0:428:3bf5:b3a3 with SMTP id
 ffacd0b85a97d-42856a2c80fmr1303277f8f.1.1761146050423; 
 Wed, 22 Oct 2025 08:14:10 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a0f19sm25710132f8f.9.2025.10.22.08.14.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 08:14:09 -0700 (PDT)
Message-ID: <d29d2888-0a95-464b-a5f9-e8433be2b895@linaro.org>
Date: Wed, 22 Oct 2025 17:14:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] chardev/char: Preserve %errno in qemu_chr_write()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org
References: <20251022150743.78183-1-philmd@linaro.org>
 <20251022150743.78183-8-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251022150743.78183-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 22/10/25 17:07, Philippe Mathieu-Daudé wrote:
> qemu_chr_write() dispatches to ChardevClass::chr_write(),
> and is expected to propagate the backend error, not some
> unrelated one produce by "best effort" logfile or replay.
> Preserve and return the relevant %errno.
> 
> Cc: qemu-stable@nongnu.org

Suggested-by: Peter Maydell <peter.maydell@linaro.org>

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   chardev/char.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/chardev/char.c b/chardev/char.c
> index 5c8130b2435..2af402d9855 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -113,6 +113,7 @@ static int qemu_chr_write_buffer(Chardev *s,
>                                    int *offset, bool write_all)
>   {
>       ChardevClass *cc = CHARDEV_GET_CLASS(s);
> +    int saved_errno;
>       int res = 0;
>       *offset = 0;
>   
> @@ -138,6 +139,7 @@ static int qemu_chr_write_buffer(Chardev *s,
>               break;
>           }
>       }
> +    saved_errno = errno;
>       if (*offset > 0) {
>           /*
>            * If some data was written by backend, we should
> @@ -154,6 +156,7 @@ static int qemu_chr_write_buffer(Chardev *s,
>            */
>           qemu_chr_write_log(s, buf, len);
>       }
> +    errno = saved_errno;
>       qemu_mutex_unlock(&s->chr_write_lock);
>   
>       return res;
> @@ -186,7 +189,9 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all)
>       res = qemu_chr_write_buffer(s, buf, len, &offset, write_all);
>   
>       if (qemu_chr_replay(s) && replay_mode == REPLAY_MODE_RECORD) {
> +        int saved_errno = errno;
>           replay_char_write_event_save(res, offset);
> +        errno = saved_errno;
>       }
>   
>       if (res < 0 && offset == 0) {


