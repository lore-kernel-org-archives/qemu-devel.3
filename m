Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC838C3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 13:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTLll-0005Gl-24; Mon, 15 Jul 2024 09:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTLlk-0005Cw-0L
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 09:29:32 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTLli-0005c4-Dp
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 09:29:31 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52e98087e32so5082870e87.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 06:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721050168; x=1721654968; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VYdBiRSD/5H9k8D2fzYf0xrna7aODaKZ7tqf/vdfkoU=;
 b=Xpmtu4hE9YsIhBcW6uJbtJZa6Lij2gKebpxNK8d1SxDkX7R3jS2iRBhNOG+aTJgGc/
 f9aYEWw4EcPtMgQCIqCSTE8XTkwpGE2T5PAmgUP62jovjYypNSVPYTtHg6WP78zqB6YC
 sKEpNEiRz0erlD22xlsPS50UM/aJPZUzHTYy6RA873sYcCGEKbWqZnZ8I8ta6vk5SVop
 +ybfIZSoyk3AJ47AuwXQVv5MPa70Xunl6OVIssr9voNF20/JzIkGzRJpadTYq47D0GiM
 ap5hrWorR9u5gEhr6Vp+w2zj9nsVF8M0VylO8QJZYvwB3pL8rRsk/RyIO/L34qAQBNRx
 io/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050168; x=1721654968;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VYdBiRSD/5H9k8D2fzYf0xrna7aODaKZ7tqf/vdfkoU=;
 b=nPHPJ/vYRl682UUGKwkfFgluUBUle8NhIpU+5r7oyWMObMNoloqqGqE2zZOZdEUJHV
 LdrJNkQYrCLyGSe0jKJ6QARBRb5tCPwuOMlffBMD2/hDleP5reN8p01wnfkoGcDAG02v
 s+hpRJ9YZPiS/E2gfIHkytvtcuYVXw65ETnPdusqi4E36avbsuh3BQRx6kjVFGJp+pGG
 2eP4jtyP7j0LGjZ+azGShgmDp7Y9nlUFccp7ldcZ1g8DTrNfeF1XjIEhMSePAUVHnjGD
 ZB+brRtayOHl2ZSf8pObESpQpaBlOAz8p4Lvrhus0mcOyRKMdXcFpIqULYoXRufKdzcl
 zXrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5Fo/RgoVaKvLJ70WivsMOx+HqKnB7r5cFyqbw4j79lv1IoYFu5GNGFOpy+ldqKlBTuucoElKcdK8R/MjCEsSnTFNCZz4=
X-Gm-Message-State: AOJu0YzR1Zz1hb2ZHNFYjzOQYBoaYH88psrQBDGheKpHu4ODNSG0A2jB
 O3cfAUhlWkXyplqTvcJ3NJ89GQJ2maXWhV5WfOHBTO1ni7kSyHs31Ul0KS4xGZosXsOb/lMWT6a
 26+M=
X-Google-Smtp-Source: AGHT+IGtKWGXbsydIHXpD6rqYvUezM22iyJ1PWM4M1X9VeRbwSMGzEj9fGKII/oaVGkw95vWJkFaZw==
X-Received: by 2002:a19:6458:0:b0:52c:d84b:eee6 with SMTP id
 2adb3069b0e04-52eb999a689mr10297991e87.38.1721050168246; 
 Mon, 15 Jul 2024 06:29:28 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.134.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2d7047sm123371465e9.41.2024.07.15.06.29.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 06:29:27 -0700 (PDT)
Message-ID: <183b06e9-ed95-41bd-a36e-6d166fc62867@linaro.org>
Date: Mon, 15 Jul 2024 15:29:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vl: fix "type is NULL" in -vga help
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20240715114420.2062870-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240715114420.2062870-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

On 15/7/24 13:44, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Don't pass NULL to module_object_class_by_name(), when the interface is
> unavailable.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   system/vl.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued.

