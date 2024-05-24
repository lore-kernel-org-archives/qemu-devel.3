Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93194C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 14:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAWNN-00006n-MP; Fri, 24 May 2024 10:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAWNM-00006J-BI
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:58:32 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAWNI-0000fn-7v
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:58:31 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f44b5b9de6so7075075ad.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 07:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716562706; x=1717167506; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5GlhhwzLk1HRCRRwKOX6NXO8gPtMVdMTGElOIRtEKl8=;
 b=n8dTZglfheRMDBsna1U+VYDXP+t+uMeSH9nx4FsoB06rJeVuYcGlOgxvnsuE/4+PVZ
 PzWp3F1nNcyJIrUXVqXjxCbnlo4+3gJ90JKPrvdA2DQYOCxYLyQSF0CWwgK+uz9gRhYu
 P6EhpAdEX9AoriTSkdnMde8DclKa0kgsIYHT4FFJklLMO9bBNpNP1VYRDu/mEsiCmr2S
 gbcvkV/byJNV+XpjSksdmA8tOyuYsE/buVaH7p/jN8MgixaQPDRi9g50uAOhPiKh/FbP
 0xDGRTmKCnnZ7RFU/Xo0eg3KxpdNozqp/dDbpnkhKjs4yW1OknjRppYKi+r20QLt5aaT
 JIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716562706; x=1717167506;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5GlhhwzLk1HRCRRwKOX6NXO8gPtMVdMTGElOIRtEKl8=;
 b=jRzhURMiH7MWfnZkwSg7fi2IFZqzXPAZ/yRhvdWii1QAtEzWtYZBbM2Rg34gEv9lb9
 z1Od0+Xp6mNoFsN9LAJ/aqTIQuTwIsz9HNjs+IJ0Aq8dCI052JDlKQBvCOKm3X80Ckvo
 6lG7c8Z42H+dHLMSXMTjTYJVPwjAkS8R4+/I9ht5nDAzqEFdM+1gx0XoqJ0todnlgH13
 9oOCiaU+UWJOxIo3ptbem5IsokCLQNq7NagkX+ZWs7RTlTjzhkJVWpAxHH0cZTMTRz8E
 ltkX9pZkbTvZk2qXci/ZuLOGBn+OfQJRj0uk3zyc/RU0Lv686WA5dqRsXrS6R26kBw6P
 414w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdNcF7YVAgAuvkToKYM51IbZCVOZE8ak1HZ0fbHZRtmmIAV2H8fxUmoBKceI2059FkK21KPRCqrtgvIepPKazByz/DA1Y=
X-Gm-Message-State: AOJu0YyjW/V7KECgwfjJ2i6+0jfWIHbW/VenaS4HGyfyca4CB4MiU4sn
 p/iUepVV9UU6CsUlBN2YT+GlvR04zyRe7wFCH0KBcW/aQRogIftTuQa6ZABFKx4=
X-Google-Smtp-Source: AGHT+IFRzzbkWEpa6TFdjAHIUoIrcbzsHXbufgnAlZo5pATkeLkD2WF56d9g0Wl6Wg1/xQODyxZSQw==
X-Received: by 2002:a17:902:e80c:b0:1f3:1036:a262 with SMTP id
 d9443c01a7336-1f4486bd0e6mr31164005ad.12.1716562706299; 
 Fri, 24 May 2024 07:58:26 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c7b0b9fsm14906685ad.89.2024.05.24.07.58.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 07:58:25 -0700 (PDT)
Message-ID: <7dded85d-adbe-4a46-aa5f-4f833baf0417@linaro.org>
Date: Fri, 24 May 2024 07:58:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/16] target/i386: clean up repeated string operations
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240524081019.1141359-1-pbonzini@redhat.com>
 <20240524081019.1141359-14-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240524081019.1141359-14-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 5/24/24 01:10, Paolo Bonzini wrote:
> Do not bother generating inline wrappers for gen_repz and gen_repz2;
> use s->prefix to separate REPZ from REPNZ in the case of SCAS and
> CMPS.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 22 ++++------------------
>   target/i386/tcg/emit.c.inc  | 22 +++++++++-------------
>   2 files changed, 13 insertions(+), 31 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

