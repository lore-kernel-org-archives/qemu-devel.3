Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA29FCF6BE2
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 03:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdKSF-0004dA-3a; Tue, 06 Jan 2026 22:43:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdKS0-0004Ma-Tc
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 22:43:13 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdKRz-0006nb-Gl
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 22:43:12 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-29f0f875bc5so17893245ad.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 19:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767757390; x=1768362190; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qYXVL0YA9xXgthTXWMXPz4zjzXgjdgAszuSvzxvZcyw=;
 b=MRFAkjm00QWtxYxWhuM70ltpAZFalwUyFNV5fbn1u3Y5t3OiHOscxg53cBlORx62sD
 Y9aQXFJd2nrtzUwZwxMjSBDRlVkfS5pQrynS/f4eibrDeHn4VSm6GNcvbMVRDurV4SjP
 SZCNhny9eCuOpLMud9D4p1tFLGmQaggPbxG/Zvxj9EAhoh2kynn5jEcG7ob2XCzdupo6
 cwdvgE5RZg2ipOie7BLSplP9mas9pOUW3HHvY/qkzVIVtlCa5ZjDfhvsxezC8oOgdXmO
 xxkYkSxjagOpTWZPyrnYQ7l7xpXtrjeaXQOfPG8M/FxzRuu2AQMNIbXNjWcKl6/BDyGu
 K4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767757390; x=1768362190;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qYXVL0YA9xXgthTXWMXPz4zjzXgjdgAszuSvzxvZcyw=;
 b=JQpOckwl2aAn7lY0Yb+qIG9blUZ+7cwz69VGeeq09KZWfWDIriuEMXuOc2TRKAG7xi
 z6SE8K6w3ak6V/yzydFhzkAiixHVJqzWrfsryzjrwxhcDNEkyiFunqgKEnjTbmKX3IY7
 SrnZqWFQhMoY8xFfz6tTHxi+I1FdIJYhA/38wX8EiibnN+G4JvNRyX5clPMcWo1YKIWP
 OruiLAvWVUZnJ1t3BjZk7kApVfbk61F0bnItwUs/V+JqAdOyMX+eZK7EVyVo+QrTkmdh
 pkoCP4NlKfpIHnjFNKkQpxDa8pCw6bVfXaWvIPOIkESUtUHfH3FDjFBJycP0HEaeUkvE
 F4cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhFJ6R3EmMKx44MfkTb+ndiDOJpNpYal7akYwFGKdQQ8eKyrgaOP0U/WjuPTdnVIbrfBEut/ANSwO1@nongnu.org
X-Gm-Message-State: AOJu0YzAZ7/Wz9l3C8dgO5VOfDDLpT8D86HVWqpznaeUadEpOjWVmuDJ
 qjSDiTQ45Q4qrIHcwL76hA3KBOR8t3SQ47iUbBlKZ4Ol71Zx0f7J3lFH8zlcn7kYu6I=
X-Gm-Gg: AY/fxX4YUic0/RKDkvAyGLkrsTlEm05iLJnAZst5OHPF/cG9g7dddjPEOvCbiBNMxk9
 Uet3DVkl72EPs7ks6SP5ldOTj/VV4DexE/6nSYCv5P+J2H6EabI5/qGLCbUR3rM+Zgc4wkYQauE
 MMXiq1xvrr8svoMNsA068F3T7FD/7EoR8yqWxLmAlofq7NiaETWitMqtmnPSxEaDkCviIJQq03/
 eZvZRTqvj6CjbBnHT4bgZ5Kv2qZSieOPA2djSXafpXV4yMZsKzv7RiA8aZJOczhqxGYjMuq8QZ3
 fwljGlVn054tmSZ7yj+c+rq0OxFYnL2RxdPuZN5d8niUqY4zoLn71GROscko0q/qFo4h+959cUs
 cNTqyn1Gae+9pflJX1yyw4Cf/JNM7KjciTxkztteVq79CpGfONgdZTcMWIwptxRJGC3wMApiQJM
 Jcpnlxwm3IPHYjm3shi3oNZYJhYxN3tdL0KN6a12EiVSSccA2H7uEkJQJZ736rqr7c7P0=
X-Google-Smtp-Source: AGHT+IGEzNJrf/DEPjKe1ZLIaxzj/x9lSGUJpqF3kXGqXc/f3B6lnBP8dlIuUJpvip1KCBRXGaxhQg==
X-Received: by 2002:a17:902:f68c:b0:267:a95d:7164 with SMTP id
 d9443c01a7336-2a3ee51fbefmr8998615ad.60.1767757389888; 
 Tue, 06 Jan 2026 19:43:09 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c48c75sm35494245ad.35.2026.01.06.19.43.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jan 2026 19:43:09 -0800 (PST)
Message-ID: <a98780e4-9658-420a-968f-152e3cadae54@linaro.org>
Date: Tue, 6 Jan 2026 19:43:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] hw/microblaze: Build files once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260106235333.22752-1-philmd@linaro.org>
 <20260106235333.22752-7-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260106235333.22752-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 1/6/26 3:53 PM, Philippe Mathieu-Daudé wrote:
> Previous commit removed the last target-specific use in
> hw model units, we can now build them once.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/microblaze/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

