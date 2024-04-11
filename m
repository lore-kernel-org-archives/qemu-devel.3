Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20666CD1284
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 08:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruptG-0000X4-Sj; Thu, 11 Apr 2024 04:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruptB-0000WQ-9e
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 04:34:33 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rupt5-00084y-VG
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 04:34:33 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5a50880ce2aso4702886eaf.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 01:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712824464; x=1713429264; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SUhaMkzMfFByD9NS4wEp4ssuJNAlsG5DdmK3OZ2NO2U=;
 b=w1A3bTdgmk54W3O7Bcp6X/JOAqKBpCRQx6RUb39vNQak+8XTcbL76fiPX0ZDjh4e1K
 1b/NJ6cEHiApOgkA4rG7/BUYZ9IqKo8QrroV+Xi0GDzesR9Vf9LM/Q/nIEndSyuCdR+a
 670iZ7xm2mXN7qSOgiaWkChxIaQG0oZ5Da38dlX1qpZpNnP7ErpjoANZf4Xm8cdT+qYE
 XReEnSgE7X9UYcTC7pvOV4AzZh7E9PUo7Rx6tkaDeJTgrXdDO+VOK6A4xMluKVZPZ1VB
 zGx+Y4omNEj44Sa1C7VOny8fX2Y1RMqEg7MOUlgftb9VS+PM6UKgfgsMFcP9kkeyRmzR
 sIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712824464; x=1713429264;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SUhaMkzMfFByD9NS4wEp4ssuJNAlsG5DdmK3OZ2NO2U=;
 b=YXKeqE0s/+YoiG0IR+YOciQb+4nv30zZzAfOLrllRwP7XgxkMKZk38Pp64B6gTpIlT
 kyCBymEZBqdaxr/I6yCeDzUfYQSIcWXQZPNhflHPd4Y3HuHGvRs6b3Em9U0MpDJ9y//r
 vl4joGHkZPFWXQD0XBLh+khzn6BpCtXUcaJYkgo1vQddupV8+gcZ3YKRvQjHB2mXBdUL
 Rxk9/RwpeIo6JPmP6T9MNhp+Km5N0aPb0ataqUsXH6vb9X3nlPPX14JnTP1xiMAqyXK/
 +aRKdgqkqLaJt0B99PfviY9e7aHqLIZSJdSxqMDMSQTh2OLixtF9jkhULNc7GU3k53Az
 EqPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ/oxsiV58RvwP/w8KBJn+p8j/E2JwNZZwqjDcBJQbK/oay6DjKVGLCqh+voHwXvE5C3TH+ffGv8rjVmpg8j87R4sBxac=
X-Gm-Message-State: AOJu0YyPXMnzw5RUg6TcFSj94VEWyjv8uxy+CaQI058ACE0nR4YhDIJo
 tVhCQdI/iMHnnFU1SOgd/2b9TOxi6bZqcVzzHPIKYgfhpYfBaOWDTbgNG5JH8/A=
X-Google-Smtp-Source: AGHT+IGWYN1DVqNuzqpABzVc0v3PPQl/o3hldnKUVid/or8o3qpCDwqjT09iN2AHCw3PlEQPKEwzfg==
X-Received: by 2002:a05:6358:4b03:b0:186:41a2:6470 with SMTP id
 kr3-20020a0563584b0300b0018641a26470mr6425737rwc.26.1712824464252; 
 Thu, 11 Apr 2024 01:34:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a63d654000000b005dc3fc53f19sm671376pgj.7.2024.04.11.01.34.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 01:34:23 -0700 (PDT)
Message-ID: <b7bceeb4-f5c2-4aee-bd22-1c2a46a4b41c@linaro.org>
Date: Thu, 11 Apr 2024 01:34:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 19/19] target/i386: remove duplicate prefix
 decoding
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-20-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240409164323.776660-20-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 4/9/24 09:43, Paolo Bonzini wrote:
> Now that a bulk of opcodes go through the new decoder, it is sensible
> to do some cleanup.  Go immediately through disas_insn_new and only jump
> back after parsing the prefixes.
> 
> disas_insn() now only contains the three sigsetjmp cases, and they
> are more easily managed if they are inlined into i386_tr_translate_insn.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c      | 259 +++++++------------------------
>   target/i386/tcg/decode-new.c.inc |  60 +++++--
>   2 files changed, 100 insertions(+), 219 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

