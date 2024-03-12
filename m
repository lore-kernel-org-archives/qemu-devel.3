Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9C1C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 20:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk8YI-0002g5-As; Tue, 12 Mar 2024 16:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rk8Y1-0002EN-VY
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:16:32 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rk8Xy-0001Yt-GG
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:16:29 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33e99b639e0so1575740f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 13:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710274584; x=1710879384; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HUpUDRRbHsmn/ex1trOVeZY2Hzzma5dU1ufjqVt/GPw=;
 b=U9Hu5KwujwcH5IDqOfT9oCK/vVydCIV3PaZZSs789TXSGJABCMVI+fpJaCBoRz4CCj
 bDEjn3ttLF3jWlyuPjo7+1P6IOkGTwizFvxf+wdjkFxd4BoobH3WC7dLneSPa8vtD8xb
 QgNmHWtrvyJ0C4+TkbYmdWiPLUvce/+qeMKIV4P+gSldVWiqEyJ2wdXDzmkWEsTnkqzd
 oEkGgnpWix5899Gmm4aPH353zHHys5fbMAOk9T0vudgvehiv/ptNGaNEUItSyAtkW3Id
 gGnIP+zgWsUIEaH1Z5f9OThefXmEM7kkuO3mfk2fzI+jAPpzJG+NW88wW0R31RUTRXBC
 HLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710274584; x=1710879384;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HUpUDRRbHsmn/ex1trOVeZY2Hzzma5dU1ufjqVt/GPw=;
 b=PheHyFVU9pfMICiGLU68P2Jl2IYfOXS9PoEXSTGTlOLpdltWSv0c4MzmsuKRFD9g8u
 BOinMTJyqn5MTt0ble7qtsEyVLx7ee6J11pFu96w5TBSjsW9dGJlLsK96dgL74O9zq+I
 +DiEWGLIl5eNc/7Hyl/CEV+QyUJo7gGLMV+DCG8nBPY1n49yhxitp/3zHl94R7nqSnsS
 XTuUqwSwbrD+75qN7k86680ct8AdAjPR/Qz714SPH+YKv9cTFP+J6oxw0PI1DKg3djiE
 9Q/m5Tn4J+rczRtSagcbYKnioSzd3teh1Q7hfL8X7t7p7RFGf9EA2sCUnjY7GAu+jrMq
 KGFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsHX25jSKP7Pd+WUsFNqW3GWrZFXp+/9j8ii0ITnSSfpaC5bFf1JylD5deVH4K8tarh/77mIz+D8pi9/1ZKkg1EcCQ3Ag=
X-Gm-Message-State: AOJu0YwOI1KhB+VzAWUtLlxpVDQxaC6bOCbJrL5SqgAwYJieayFuIjRx
 GVu1DcmcMqtU/NDVDdQa3+AqxgD31EM093GHmgVCkS5BmuIXMXEdMMGE38W+iKU=
X-Google-Smtp-Source: AGHT+IFzi5ePSfU3tQujQdKZNBPLAEBnefHea+lQzWeiYWBUaESLDv9ru7enD0hIchk/HLf4C6/Otw==
X-Received: by 2002:a05:6000:124d:b0:33e:9f65:3b57 with SMTP id
 j13-20020a056000124d00b0033e9f653b57mr337037wrx.38.1710274584616; 
 Tue, 12 Mar 2024 13:16:24 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.139])
 by smtp.gmail.com with ESMTPSA id
 h17-20020adf9cd1000000b0033e97f3a479sm5383074wre.19.2024.03.12.13.16.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 13:16:24 -0700 (PDT)
Message-ID: <defa2f20-b85d-4103-8d55-02147951fc54@linaro.org>
Date: Tue, 12 Mar 2024 21:16:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/physmem: Fix migration dirty bitmap coherency with
 TCG memory access
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
References: <20240219061731.232570-1-npiggin@gmail.com>
 <0fef1275-836f-496a-8a96-3e46c09cb232@redhat.com> <ZfCr_Y4Xfhfy5KXQ@x1n>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZfCr_Y4Xfhfy5KXQ@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 12/3/24 20:24, Peter Xu wrote:
> On Tue, Mar 12, 2024 at 06:38:13PM +0100, Thomas Huth wrote:
>>
>>   Hi Peter, Paolo, David,
>>
>> this patch fixes a problem with the kvm-unit-tests ... could we get it
>> included in QEMU 9.0 ?
> 
> Yes I think so.  Apologies for a long delay, I queued it for the next rc
> pull.

I was testing a v2, please consider it instead:
https://lore.kernel.org/qemu-devel/20240312201458.79532-1-philmd@linaro.org/

