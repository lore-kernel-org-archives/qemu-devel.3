Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AC6C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 23:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb7Y4-0001Yw-DW; Mon, 05 Aug 2024 19:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sb7Y2-0001YP-FL
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 19:55:30 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sb7Xz-0004z8-BB
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 19:55:28 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7a18ba4143bso7609454a12.2
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 16:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722902126; x=1723506926; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=70EuLQ7EmPE1jJqZ90Dn3cT1i4A1gNtQ31Cp3lYt1lY=;
 b=WcYUQKIpEg89mdzoZXXJEyfQeEaQgGVI4tkt7IDiadyBQ67GDobrvYrL2AKppOctVh
 l4glviV0xgQH6sC1/0p45TzgtUwXiPXRbD+gDhiG4SVCGBrXM94h6To9xJQkBXnQ513O
 vqq+hKhxlAqt6wi1tq9H28gJuojyPt32bEpo3a7egTaw72C7GV9PSTiypFF9j5x/ND3r
 jLmGj2uax3xd63UFVnllD1iCNzhcA2UJcOqmGvtPQpOc47UhLCXYeLtrkg6FAxxGDe33
 GloiwbYtg3AAmSefD6opyda8p0erQ5mIwrbDQY3R9DdhJ9W6rTdLRgNlk2ZITZSdCnas
 lIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722902126; x=1723506926;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=70EuLQ7EmPE1jJqZ90Dn3cT1i4A1gNtQ31Cp3lYt1lY=;
 b=pEc5LAHFR6A660aJZvO2CQmVLV1E49jgNZxdWfLFXL8OZK/J1TuvRDroZAYroaL1mu
 8NUDCfof+vdXMEHCxzc5Anod3CE6JIS78tLEWU7o+qvRUQC+C435ZQvc+jnB74YYpp/b
 GkJYbJdn9rDoL1kfd58iY4SsZkMdQiRIp0mT7WQqeCw2WpYw0YvjjMGzTE9yQkHs4aax
 05W1ddDi/Cy/B9fDm35diydb8xOeMED9Qr5ERIImcnq3jBGNuG5g7hyp00RF7qHyaf/5
 +wJsH1KVYxmNEpMI8EWycnXw7AhIC9/S4/Z9QQT5Sfo8F/AfW6FAbaE7aM0AQ0vfUqUV
 ZNrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsoDcvQ6w23IlOdb9cNprfXTjEG5MLrLj9u7u25pOgjAJL3rzA2MRUpWzBxuVtdGicm2qxCwNdALoz7LwGmKFcLVr0j98=
X-Gm-Message-State: AOJu0Yy5evG4xctL4YasDFzj7keLKUj5rm2Y73F/AEG4pj2uhxGFVn+F
 8xpxkEX66Ecw0nPGsHpsHzCAbnHKcFkZeGgAWIaXhmDf1LmrzIlPimK73Qt4kMQ=
X-Google-Smtp-Source: AGHT+IF7vWjIzAWgiIpusH7AA6K/d7p9/nbJ2safAFQWvIyhOR20JPEtycGIIfbLSqn3zURPRlJE9Q==
X-Received: by 2002:a05:6a20:c21:b0:1c2:912f:ca70 with SMTP id
 adf61e73a8af0-1c69966e0b6mr10369863637.42.1722902125534; 
 Mon, 05 Aug 2024 16:55:25 -0700 (PDT)
Received: from [192.168.0.152] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ecdfe83sm5932056b3a.122.2024.08.05.16.55.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 16:55:25 -0700 (PDT)
Message-ID: <64910525-cfb3-46ab-b169-6694a2d3eb00@linaro.org>
Date: Tue, 6 Aug 2024 09:55:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] target/i386 fixes for QEMU 9.1
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240805121632.482610-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240805121632.482610-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/5/24 22:16, Paolo Bonzini wrote:
> The following changes since commit c4d242501a61093a8b80ee8f6dd071c5110a100c:
> 
>    Merge tag 'net-pull-request' ofhttps://github.com/jasowang/qemu into staging (2024-08-02 15:53:54 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to ac63755b20013ec6a3d2aef4538d37dc90bc3d10:
> 
>    target/i386: Fix VSIB decode (2024-08-05 14:14:47 +0200)
> 
> ----------------------------------------------------------------
> * target/i386: SEV: fix incorrect property name
> * target/i386: tcg: fix VSIB decode with XMM/YMM{4,12}


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

