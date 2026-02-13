Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53E7EF99C5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 18:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqy3Z-0002vK-Q9; Fri, 13 Feb 2026 13:38:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqy3Y-0002th-6f
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:38:20 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqy3W-0001Xm-GB
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:38:19 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-824a3509a12so773713b3a.2
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 10:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771007897; x=1771612697; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3QnAQL3WC6x//y2SSqoUk8H0sJcHMgEQi9XoPpQDMN0=;
 b=S3L9LaaBT64MQQxpPcP81AhOYBmeafUpQOeQ0TjXAcu6wt226Gdq1kZyCfYCdqpxRz
 q1EPsxocWynNOQ5WzsveltuLe/T7zjuWpBVztPZw1YnvVQNzHpYpjQGeLd1WsqUKllTg
 Fhr2Fkn8U5M9H11nDAo20T8oB4Zsin1doNR4/LnNCVHQMq2+Z1TS833i8D5jLzLez9ER
 tZyQjQTb27/h8Hm+tr5pIeGSCqA+eTRIgQvSyVmsm/yriumm23m8podY9DKwWw7nPmy+
 paB32j+IDK00s4xAVgnWpuw711U6ilXbas8BpZOF/0I+N0TBmwgFMnFpzb2+3Dv8bWxy
 ZT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771007897; x=1771612697;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3QnAQL3WC6x//y2SSqoUk8H0sJcHMgEQi9XoPpQDMN0=;
 b=nAIqQ+4z5vsM1ZkPSUxENAUOeWYY2va+NK8AmkwkdnfscSPt2W4eJ48kfsMQFSag/k
 512/W5iEvnI/gbskDHw+B8KcQ+533/6jeFzXrullYxe/fKLA1dgyw0+g60VH2BxsEz5a
 9j2C7gFZkdz/JXvTWdNVFi3pEGbcSmE8eC64r0n5Z9Hwipbdq7zK/UBmG8lswrpL/hu3
 UUHdDBQr6UaA1VsbcR2A+7qtAP20JRKL1nnyCsvP+D/LwYlTVMq8lLC39LgYj4k81FN+
 2pyYRjXLoOBzaVnoVfIQXRccO2eRP9MDnRFR8r1nFw9gATaCl3Z+v9k7kXtrYxLvYkK+
 MuJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5QjQepm/GwD/z16aPvVReY+f4I/qL5rftmEJm7uMDZA6QSdPxejQBSL3+Y8n7WGTCIQS0frbqw/U8@nongnu.org
X-Gm-Message-State: AOJu0YxRVu4RnEUgyJWfJR1sjIA5c1PXOWGoG5rpjBvPsRLxeIOfB1yx
 ESPEh0ajB25WUAXWJCds70u5wDp7Qa4gPNZn5GGKyZaU6zfMPwaZg21YoIhsVCsgCcE=
X-Gm-Gg: AZuq6aLpdd3YrHVGQIWHa7mrF+MnoaembFqiXNSLrpEG1e64h6eiVzkNkM0SvwLPqOs
 xq/wagmTRa0iJnfio3bDNYJtskZh/0ejSnOkkPxuTmr7A3eN3/0jwhnwJYjSRBoiME2QRm02mSk
 hqaMNa0bArJV2F9eQUBpjSJhVeZ3szqgf/ngMKM4C22QGxvBHFEbC+FC4Y96aZP0BjoK1V3Fdls
 hK9pjffO/2wF9fxARmRWVSbIeJk3F6qxiBKerMQNLkVPrNDF/fGUY363GTkbSZ3BysC/Hk+2sts
 Ubm5s9BSHp6cB6oLkWAigg+7JwfjSmqz5TMmhg1pSGKxEBviRUPof+Wl7IYuPXGkMJQz0i9s1qG
 fH9v+0SxBmEaCBJqqv5o109mtRw/JIDiUj4WaPH6u0O1E3JUNHM0Nif8SrZTRlicvtU+3bP2DHL
 e0fQm+ipbag3iOPwxzyc5fHKN/oVfg4S4mbg86Ybt5yjW9pAqe9wJt5S+cupFXbyhzaiWG
X-Received: by 2002:a05:6a00:ab8a:b0:823:1475:85a4 with SMTP id
 d2e1a72fcca58-824c94d75b7mr2684061b3a.24.1771007897039; 
 Fri, 13 Feb 2026 10:38:17 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a431fesm3372078b3a.20.2026.02.13.10.38.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 10:38:16 -0800 (PST)
Message-ID: <3d601482-b191-4f98-8d43-5891b6ed62a7@linaro.org>
Date: Fri, 13 Feb 2026 10:38:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] page-vary: Inline
 set_preferred_target_page_bits_common()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260213182713.44924-1-philmd@linaro.org>
 <20260213182713.44924-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260213182713.44924-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/13/26 10:27 AM, Philippe Mathieu-Daudé wrote:
> set_preferred_target_page_bits_common() is only used once
> in set_preferred_target_page_bits(): inline it there and
> remove its prototype.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/page-vary.h |  1 -
>   page-vary-common.c       | 33 +++++++++++++++------------------
>   2 files changed, 15 insertions(+), 19 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

