Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9797EC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 07:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4FLr-0000XC-Ne; Tue, 07 May 2024 03:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4FLj-0000Wl-Gi
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:34:57 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4FLh-0005uX-Fi
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:34:54 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41ba1ba5591so20898145e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 00:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715067291; x=1715672091; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oOAotrvpO0LMM8zVjtpr+DfXCL6BT1nfHqvQAWpPdZA=;
 b=fpklyt1YxwZRByuLK/pJHxnbF0fE41V6KHW3xguKa9DN+CGxOKybu8jsl7YP46HF/r
 Dl/c1mUal1H1cx1VhKlfYLiC6ap59RrG/7OBxn/d5Sni36ghtG/OT1Bc7UdplkS5MrAj
 T7a/5aHvN3bTdSlCDwr7VIJjg1uAs7aWXblhvhLF5BpSWj64mLAQN6/iP4I6MjwpXyFn
 ohpMabrGSI+4o49T3t1F3aZ/Og2agJBph7Pq6IVR1OUSlIvGc3KoCxsUuypV4+EwqPy4
 eZCqd94vqMmodYK2304KCep8A7zapQdjzw06bBTSWTdfwk3PbbhLMp2x99mUgw9FTP0W
 nnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715067291; x=1715672091;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oOAotrvpO0LMM8zVjtpr+DfXCL6BT1nfHqvQAWpPdZA=;
 b=plvqu62DIB2P3uOeMJEhSqI6S0ePTiL0FygFYZzlaJv6JQeFM5PWO3uNO9OT8WEQ4u
 AePr3h9opjnVf4G/3pw0LL6jyBM6wlMmzudQFC+M/WjSK7meaCkBDCkUtDdYb6NMNpzO
 sDSFTi8yXY8h7MHLsYbb80eOqTpl/z6t6gTIeJNcPNVPT2shQ1VTuMV7thyWVZmtEBh/
 l9zTVCXHyyRxBpgWey1a4D2Wb/j9fFaJG1ZQ7wjOxi0cuBil+yYnq6AqckYNbbaAsKE6
 9UMcc2uws9yKDLvEixG/RvBXvX7d58lEyBZR2ae03sVloXgi57A4o9aVLnoYthm1rZia
 Ur8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8xIpGAbP/+P7GuvkIA+3p830wXt9CUfRKgdRWFVFc+oHbCSbWD2PUgjd76BJVmvsUAlkyHHaVGLtLOGIMcTY7fvOJWS4=
X-Gm-Message-State: AOJu0Yzl8U6HDE9hSZe3wAXQ4M3blUo19y7U2k2viK7iKIrMQUNJZ0vA
 E9SLSi6m9ycZElf76NyOp6E3RgawulzwRO9iTBgBBm3xpNHEY0myx6MhO7T6bA8pINaWviek3Oe
 0
X-Google-Smtp-Source: AGHT+IFDHujBb+NvvAFd2mulC4CCyHhVCH+J7UHB86nov8ISQj25YPBjqQWgjTR0bmu4wTg6ionM5Q==
X-Received: by 2002:adf:a18f:0:b0:34c:b31e:18de with SMTP id
 u15-20020adfa18f000000b0034cb31e18demr8377402wru.35.1715067290933; 
 Tue, 07 May 2024 00:34:50 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.243])
 by smtp.gmail.com with ESMTPSA id
 j30-20020a5d6e5e000000b0034db5f648a8sm12347091wrz.77.2024.05.07.00.34.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 00:34:50 -0700 (PDT)
Message-ID: <4b070489-9676-4dff-8ccd-47b224f9ee62@linaro.org>
Date: Tue, 7 May 2024 09:34:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/xtensa: require libfdt
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240507071948.105022-1-pbonzini@redhat.com>
 <20240507071948.105022-4-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240507071948.105022-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 7/5/24 09:19, Paolo Bonzini wrote:
> All other boards require libfdt if it can be used (including for example
> i386/x86_64), so change the "imply" to "select" and always allow -dtb
> in qemu-system-xtensa.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/xtensa/xtfpga.c | 9 ---------
>   hw/xtensa/Kconfig  | 4 ++--
>   2 files changed, 2 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>




