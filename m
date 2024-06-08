Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A85C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 18:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG0Tr-00040U-LA; Sat, 08 Jun 2024 14:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG0Tp-000403-Jz
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 14:07:54 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG0To-0001qz-8z
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 14:07:53 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5b9a35a0901so1190606eaf.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 11:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717870070; x=1718474870; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lZTTtBbPRHkrUSPWfuH2IQLC/nDdd4D/iZ7VT8aRsGc=;
 b=HpFURPZIIkRWc9DCoVD3NcWSmOonpgp+0k4z1JGPlYD4OkJg6B9wKnJM3Mo6k4ZDPK
 r6ghXaXIdMKDmYRviHHoz+FhAZT8wvdshejc1efDBKmcAxNzgS8gP/hIkO+/dUp/m3v7
 aVNvm/yoOrwWh5Rxb5CF+19jOLzVyUBc+r12NFPVEtUAvDg4q3mTAd0h56hS6I1cq2I7
 M1A1Xn04PWKe6YltflYkKoBSuZQ7TVaXIkjK5jmiEA4vWHE8YlqvpxR2OtBxxN3c1YEs
 Hnn0v3tlscnSg9AxUhv3R3iKtQu0T3ixsdSBzturiGRM0ioicHvoPmRMvsaxyKAGqXJj
 lcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717870070; x=1718474870;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lZTTtBbPRHkrUSPWfuH2IQLC/nDdd4D/iZ7VT8aRsGc=;
 b=L4gNOEWv6qTH7r+qZ6+Beo5HaNh8zE6u2MFRuzvlg/gHdMAQ25tSBEF7zBrIv2U6g7
 7LXcVUbHifs8Y1YFDlqY8PwbTB3TAdxWDXz6CVCd3L3YAWuzawpBV0h8D26VbmhzQhMt
 1/ho/pc1x2MUb7N9SqUDQ5/locm+jKu4qvrj9Am41h2Cu2RfI68/OjEh9jg9aF546ae0
 oNbOgT8pV6LCpeJZ9CnkdJMz0ej6d3+d0XnW1bbfI4iqVEPWuxw1u+bt//dWgk45Or1V
 3Y9sNR1ROoMgs+72dTPbpGphQhyT/jOylRVe1cV4RG81isEnBHwvNJkh6qIeuGela6ox
 cIhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr3lXF9JOJ24Srpz4vxNC5BAF3SPUop3OxI72Qv3pI52mRNncnnAthzQl7oMKeC7SxxeWdIBdl3xKnWceRwN4zo5e2ASg=
X-Gm-Message-State: AOJu0Yz08vdcSPDI4oyKKNVK15rBROar/mFZ/DbP6Wo3tHq176YfuIU6
 wIn2TmN3ns+cJbugoYhwaoXU5WDuwOKkaPNpWsAK5cOUyps7/FtGxo6kWYVtGks=
X-Google-Smtp-Source: AGHT+IEOejqBmT0lxwPwWeKiw3ypm0O6hO+RSAO1UDjCdXuabuDgV/PJZYHme5UrqLeQ8HUYBtGbOg==
X-Received: by 2002:a05:6358:60c8:b0:19f:436b:f6b0 with SMTP id
 e5c5f4694b2df-19f436bf81emr179034455d.4.1717870069881; 
 Sat, 08 Jun 2024 11:07:49 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6de264ae03csm4239544a12.68.2024.06.08.11.07.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 11:07:49 -0700 (PDT)
Message-ID: <f21097fd-27d3-4bd4-9ce7-4ad8bd71c410@linaro.org>
Date: Sat, 8 Jun 2024 11:07:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/25] target/i386: put BLS* input in T1, use generic flag
 writeback
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-4-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608084113.2770363-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/8/24 01:40, Paolo Bonzini wrote:
> This makes for easier cpu_cc_* setup, and not using set_cc_op()
> should come in handy if QEMU ever implements APX.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc |  4 ++--
>   target/i386/tcg/emit.c.inc       | 24 +++++++++---------------
>   2 files changed, 11 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

