Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D72C52D7D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 04:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seo8Y-0001IO-05; Fri, 16 Aug 2024 00:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seo8R-000180-MB
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 00:00:19 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seo8L-0002BG-7l
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 00:00:15 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5d5c7f23f22so973799eaf.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 21:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723780812; x=1724385612; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7+ZA5vGNOOy8TJG1+rpg8FtIIfKSMtJmIRfiubzlflk=;
 b=IL1Ug2FmY9f5uJH4lZm3ho7VZ+H1WzVs4ewGJNaFtf/aU79F1lFyOT8Ljv8bQYPoOm
 Fh7Qqg5qvdpOYdSxS/3bWfpRRWgFfYJGgCRqjp7LLQldwKoBCBx26CS0WPFiOqR0Vz0M
 Yz+YzYS1OaQERzQvD50O11umbxBzwq+LTAxMozy37FKj7zCocxbFAfVp4tJXVEYI9j/B
 fJAHZQ6VoI6paxN5jkRTMqZEZ6pBuR3pJ5VwdJtH8A68sxCu9w3oel1bdif98pGSH+qB
 uEhVZClzdK2VH1+heafwQ6gNLFF6AtoucIH0mPk+U+qGk93+NpgSqlsVYeNT+PL5hNEN
 mWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723780812; x=1724385612;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7+ZA5vGNOOy8TJG1+rpg8FtIIfKSMtJmIRfiubzlflk=;
 b=lWI6nUzi677b3k6lI8kKwObMPgwmo/YCHdLzrERsP/vB12Qg/N5f2TITGUHci/4Mb3
 UeCxza+SEFnT7af7lHa+Z6i8oPBKuwGJ0sWKf3EM9JxUOLF5s+4pL65FOe44Aj97KW3X
 fRXkpF3dVS8UqxsSKV14t3xhNtr/VZ2wJWvq2KMuyq5Wd3LZbQmOwlAVRhsU5vXvZSdD
 7I+TMjzlXAbGGmLnl6KCR9jZp8IBsrKGenY1pV40fVqFluHxYY7YFXbrzu7pBZXd3ipk
 6Tqj291LdlMLbbiligBOQaeC5mxRG0mDuSlLHHMPi37U9CtnDYue276E5+FV/2BTJyup
 vBgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7uTFQSSqaRqop+QQCacgJETivlXDJAsnQb3Ob381t7IO81qKea9enJaPbMBCmXC+2WUWBa4/cNFHrfodS33VJafyd6us=
X-Gm-Message-State: AOJu0YwEGPL9keZjHOWFIinou+10OJSu90tlCWHv2SeIULQYed/KucDM
 mG7NQD2xtezA4QCfeq5HPTC8liPKMfSEzXULnbxBP/r8Zat7TXs3veWP473s7Eg=
X-Google-Smtp-Source: AGHT+IFTt5lZ1yOGKrVpMHjZyyJzZqgZLUXhFuqrUJVMeKd51JAtCK09x2lbn7KbX3MpLbTro8EOlw==
X-Received: by 2002:a05:6358:70c9:b0:1ac:f323:ea18 with SMTP id
 e5c5f4694b2df-1b3931a5674mr254846455d.8.1723780811779; 
 Thu, 15 Aug 2024 21:00:11 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:d09c:46ba:97a2:4a99?
 (2403-580a-f89b-0-d09c-46ba-97a2-4a99.ip6.aussiebb.net.
 [2403:580a:f89b:0:d09c:46ba:97a2:4a99])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127addf5f5sm1757188b3a.6.2024.08.15.21.00.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 21:00:11 -0700 (PDT)
Message-ID: <f81c5f95-36a2-4086-bea9-2149802f3799@linaro.org>
Date: Fri, 16 Aug 2024 14:00:03 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/16] disas/riscv: enabled `lpad` disassembly
To: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com
References: <20240816010711.3055425-1-debug@rivosinc.com>
 <20240816010711.3055425-8-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240816010711.3055425-8-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

On 8/16/24 11:07, Deepak Gupta wrote:
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Co-developed-by: Jim Shu <jim.shu@sifive.com>
> Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

typo in subject: s/enabled/enable/


r~

