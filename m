Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28C3C25B5F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 16:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s410l-00057a-Qo; Mon, 06 May 2024 12:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s410j-00057N-9k
 for qemu-devel@nongnu.org; Mon, 06 May 2024 12:16:17 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s410h-0001Mj-Lf
 for qemu-devel@nongnu.org; Mon, 06 May 2024 12:16:17 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6f489e64eb3so362025b3a.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 09:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715012173; x=1715616973; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GkC3IE9UY3Bf2EVc3IKha+1gr6O5KbYyYV8cJgdlPsE=;
 b=rRUIYsr//QG3RHjMtUGk0GIve5W7r0MgfOHOMn4a3XRkwN+8yDUkXv5iC1m/Be59Ax
 sKxCHBfZSqFRLPbj5BHEmACfwZQTLi/rohobzyJUj/QwRolBLS86NXytkHWIjMNUPUUQ
 KiYRYE5OUgPeAs2PsBFez/f+983ZV3uqSPmOokXVQaepZqBo1fLaiW1G0rlyVa0+YlFx
 MWlPZazCa1W0LpMB24zg/CWm9Dr2C3CYXQ9nS14lYDPkkbjQAxsT/XEYHF8ADrYhUwju
 ymH1ePNFUkumd2onkKQlloZgjaosT3EQH7ECGTdjF2CBOeadoDEuTKsDYqwyjsuCyunl
 c6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715012173; x=1715616973;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GkC3IE9UY3Bf2EVc3IKha+1gr6O5KbYyYV8cJgdlPsE=;
 b=uCIp39s4Phbtd4AmuXC2q/b7OZL6I23BnN+65eGyJeHJTYB0Y/YHrZt5cQZnGzfKdQ
 EdbV6Ebnabj0g8IzEmix0gCS8hK5Y+WZtwJ1E/O44YLzoN/9Z1JYcYqXRwwZZTC6lzWT
 cnMmfJa0AzL/w3RvJzJHGqiahGz8HvkL+msv92o9yXIv55Xy5lsFweCfEMJWdbQ15Yuy
 5XOY1+ZVv7stgoIcl2doJsJzwip8UZBKFaHTVvjwBcRrvLhbEbqvep4zBn9pVedWTeG8
 HPCAsxhtIcAe24FMTCiWDl/R8U23ep64mFWm+NJct35eijurV9Er1KsM2MBAJgazNMZs
 Xzmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5Z6/sCdYqObOSERiF7aqsNGobnwOdx072hyiBPz7z1zlxXC16/Jjvs3ai4IqUoHIFsA0t4j3egoYWk/JTuKQK94gNZ5o=
X-Gm-Message-State: AOJu0YyQabJbL/+lUAmdIKpziG4mtJG0KRlfkcleRxdCzV/0h3W/BgTE
 uadexcmynkYetxkmzz9fbV2g4UNU8sQoV8r2rTAqkdcEibbrEGhTUqbkUITPFqg=
X-Google-Smtp-Source: AGHT+IGxO2Ey1wJTSSjERKYNBeStHYZf6qnHn4LoL2pQri+GDMnulv5ROMlaiWium/a3KanPE5tBNw==
X-Received: by 2002:a05:6a20:3ca8:b0:1aa:5ca9:c565 with SMTP id
 b40-20020a056a203ca800b001aa5ca9c565mr11572866pzj.8.1715012172885; 
 Mon, 06 May 2024 09:16:12 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a056a000d4500b006f448d3c700sm6741955pfv.142.2024.05.06.09.16.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 09:16:12 -0700 (PDT)
Message-ID: <d0f9cb6b-f733-4e57-ab11-3f0e8d732d16@linaro.org>
Date: Mon, 6 May 2024 09:16:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/25] target/i386: extend cc_* when using them to
 compute flags
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
References: <20240506080957.10005-1-pbonzini@redhat.com>
 <20240506080957.10005-8-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240506080957.10005-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 5/6/24 01:09, Paolo Bonzini wrote:
> Instead of using s->tmp0 or s->tmp4 as the result, just extend the cc_*
> registers in place.  It is harmless and, if multiple setcc instructions
> are used, the optimizer will be able to remove the redundant ones.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 44 +++++++++++++++----------------------
>   1 file changed, 18 insertions(+), 26 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

