Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EAAC3DA64
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 07:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saVgH-0006Tl-A4; Sun, 04 Aug 2024 03:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saVgF-0006Kb-Tw
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 03:29:27 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saVgD-0005W7-6K
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 03:29:26 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7163489149eso6802379a12.1
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 00:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722756563; x=1723361363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QXk+aCctF48qXKK0HsbaK+451sObEGqqVawFAyXim1k=;
 b=snNxOTZUrKWBLAjgkxDE1F7V+b9LTV5gWN27g0ZIVANVhqJOmETp9r0Q7eHbc/o1A/
 +Uggm9I6w0CBZNJ7NEXsgSw/EGbst0bTlIyC5YEVdcftrINElzSQ3ZXVyI5qMH0lsfSl
 JseBE4pYJSBRlX7X8kjhkWmWRhUISk4L/UVHwPxGOR014wncYf5H1WjK01SfXQok0qBa
 rWzctE1kcWTHnaHsQOhyYwDs7hhhW/J1Sjra9dFx5F1xYh4B0euDfZbuBwOsepGNDvtA
 V/19WNQoKXxocv4xWVYqvYvbwgW9z66x9nS4Ma5XTrshgInl/89Ma1OJZpZGLic6kRFH
 8dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722756563; x=1723361363;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QXk+aCctF48qXKK0HsbaK+451sObEGqqVawFAyXim1k=;
 b=Ud2e25w0SjxXk80EdxzKfZpqyNNEGWgcTnilc+nF+6hsi9kPU2g3kjGwziqWDx/psO
 mzLkMnEM2dcPZAv/Na3taTMGpECADZ6qQStcA5qrwjiZd33mI01tkx2zxblaHoXWAQHG
 OcJpvpT0KBH86eKCBx89SxWAQCJbdEZ+rT/iwiFOMyT9DPCQuOncfW5i10dnHegZTVWM
 cW+iIbVdFoIvVqfZDgZqdSbAZuf811TlUQ9eGTmFRYiranbw9FEmuegz6rp672bTuApN
 3MoXDpx6ZPCfdT4LpLE9FmZAjMo59J1XtvvHGWbM5ypOrIfaRqEviT0hhLEPMzhetWWm
 OujA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj+Kljpy+X18x3DrN3c+T3c5ocnVX4n+iCglQcN57MF5IpuemhIf36SSCZiqPFHcbFcmi+qZXbqMUH1exXtmg2QNTE90g=
X-Gm-Message-State: AOJu0YxyfjLyXmtAw47iHV48KvLK4LShvQGxp0xEI30FlzA9ISaj05Mw
 dgUQOdfEZuNJqAZFt+2s5tozCfKnIoJwHUzq3J00pjIQNmclna3np2J4Ta7Xw7/Yhi7I5t1At3g
 kgW73Lg==
X-Google-Smtp-Source: AGHT+IGF6wWcdymnBSLXcZGCpP1T9PhQ6d2MFqPUlYz45cstLL26SRfE3y0sMcFkPUYeBe7ugQejRw==
X-Received: by 2002:a05:6a20:d70a:b0:1c4:c449:41e6 with SMTP id
 adf61e73a8af0-1c6995b8042mr11301633637.31.1722756563353; 
 Sun, 04 Aug 2024 00:29:23 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec410d1sm3611103b3a.66.2024.08.04.00.29.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 00:29:22 -0700 (PDT)
Message-ID: <c2bdf6c5-0028-4168-8640-244bc1c7d243@linaro.org>
Date: Sun, 4 Aug 2024 17:29:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] bsd-user: Pass image name down the stack
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
 <20240802235617.7971-11-imp@bsdimp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802235617.7971-11-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
> Pass the image name down the stack so that we can give better error
> messages. Inspired by similar work in linux-user, and more likely to
> come.
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/elfload.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

