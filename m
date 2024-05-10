Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42528C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 09:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5MSh-0007Hj-5n; Fri, 10 May 2024 05:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5MSf-00079v-N2
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:22:41 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5MSb-0001kO-QM
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:22:41 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41b79451128so14088345e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 02:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715332956; x=1715937756; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pkRH8HotxI87BVId5J4rHn2LLaY9WkeC22bHlK1UmqU=;
 b=NpmmNBspPzbwk9UQLlZI96Gkqon7XzAhm18GW0ETtdkLLwZ9tbsmtp80Kcp5wJqyCw
 HWOBuCzW9nsjvRSl/kujh8CjwuYm5NSLXh9du/onvHjX5fsJcNbPdgpdpZSny/++rAEF
 jKHw3tRbRkhQSTyDrc/1tYmSqQWDEpwcv5HLenzdrg4FrdwIuCcZSKhXgELJIGv8w3MO
 M83Ym7Ly1nXHsws6FelLRzkj8dCRScRpoGPtsVdTuEBUS4J0EWCajHCcTqcKGar+Z6/D
 ruTLD4heQgRRVy+JbgNEcc6NK9LZHAxb5t8tEF106eh6/2xIafLPo884dENjb8dKwOtY
 5seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715332956; x=1715937756;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pkRH8HotxI87BVId5J4rHn2LLaY9WkeC22bHlK1UmqU=;
 b=ovPN1FnKq7haBrchjDneGr/bgqzBvTOtnhl58oqRq96JvJqBd1qpiFShgFy+mAH1sz
 50t3hgdRYGFeDygfbJSCc+k83t5Yj01kzGrccRGDIKGFdWzS7fxDWd2p+RGYPPHGvTdd
 MyO7AT9YCmxK7ZIwhe+ckEUbFWA3ebKGAy8W8n3oRnAXA41YhPLp7wPT/phPhX7mj+Up
 b4mfWMc27fKnn9OEjCwdETSqYH6XQxvIBb3x2p5P1ZEzu+d1neOh53VdWh9uF3Qnj8bi
 9UAb4Y2tr6MaC+3zVrP2oPWBHrhj5rdwf5j7M/X5Ile6DvlqvvTEh2fkDcqIMQLCPELy
 eH6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCURuWvOoUU/nBeADHKvYxSPw/ZG6VP0k65QvL8VXdXlDOsIOjlXfTGPdmEUQrR1RnTL2o9NajLW3PfBuFcPJg2hgw0l2ps=
X-Gm-Message-State: AOJu0YyQEMCU4DpD7OLBCp0ba4lyB/+I9iAuEPKSEUimJDhlukWRp+by
 aCwcg4OlNCN4eNhiHCScAuoQeagb2eJDmFuraNOGhihcnmh/t4NS8T9EkHzmvX0=
X-Google-Smtp-Source: AGHT+IH2hw1D4RWUQ6ePi+5kAOs08fJgsKwFJ9xK/q+kcTTcrZ496LHxMIXI+hGBkg4tz+riwAYonw==
X-Received: by 2002:a05:600c:1389:b0:41f:f053:edb4 with SMTP id
 5b1f17b1804b1-41ff053ef30mr11812725e9.23.1715332956047; 
 Fri, 10 May 2024 02:22:36 -0700 (PDT)
Received: from [192.168.51.227] (56.red-79-159-217.dynamicip.rima-tde.net.
 [79.159.217.56]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502baacfffsm4019355f8f.75.2024.05.10.02.22.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 02:22:35 -0700 (PDT)
Message-ID: <743f8c67-3289-458b-9536-61bc308dfb03@linaro.org>
Date: Fri, 10 May 2024 11:22:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: rdpkru/wrpkru are no-prefix instructions
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240509152530.141898-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240509152530.141898-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/9/24 17:25, Paolo Bonzini wrote:
> Reject 0x66/0xf3/0xf2 in front of them.
> 
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

