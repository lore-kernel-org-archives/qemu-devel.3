Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5D3FF5135
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABoL-0004Yx-CZ; Tue, 07 Apr 2026 15:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wABoH-0004W4-E0
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:10:01 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wABoF-0002Yw-FT
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:10:00 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43ba1f3fa7eso5699735f8f.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775588997; x=1776193797; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QXm53oiWF1/bw7TedFswywe8K6PN0bnLDmXln32BWs4=;
 b=HV9a/0mPwrsNLwzGZ00ZgHv0jwPzFyGQ0B9hVN+eJkRRHRGezGfiZYLZPBkJd4n/GM
 JPdwqLVxWGEB15ddRrH6FJhVpoy9ihHt/pv+HVQGtJUpMYHr9GJOuE9HlyvsZagEdu/O
 UUoMsv5gg0jHmpakj0ETBD3141eEEFrqPyg6TYEgHnhBxTzWPfUyhOkdX/aabEaK+3Xi
 Qdri7ZDXRmLnRWvRjc6vamhYclylHfJD0+idmnB8e7AsexZCf3/h/xNSsAdLTxa4wa7h
 N2UwPxbixtW+IEhgjjb1xOndePORLgr2JrFZlU1HqiTLLUnLjQh+wwJHHXYThA7Tvp/3
 M6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775588997; x=1776193797;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QXm53oiWF1/bw7TedFswywe8K6PN0bnLDmXln32BWs4=;
 b=YlgLFziPEki818RsAG+TnPLZDTGmEK/8eWy/j9lJ+GATF0gFrDwJCyqvZPYCxKKzH5
 B21ljCIDo2xlvaXOEm13ntfqz8eY6EzVGrTAnZJ1bwu9MWvrL2gqFyWTV16HNf9yXzVb
 yiWhYTmkhg9oDBo3M+KM1K2ubeP9ipLtjhzMTMyVCxqKnAnYR/+WrQeU4fwGRzxuYb4s
 giyTHi+LouaPprIxUM/WsgF8Ihw3c4hNoeblFUY0suXEEb2W86aDeyTioSfLS+nptGRQ
 wjMDFqlfZSXqv1ZrIzN/5RZe+5lcML/+n/OJIz739xmuTLOdbuzQPyZujMSYTct7kJin
 W+FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVInYJU+ulqFyz91hAEMLP4bEAZBvABtXD1xJx64Q1V1UpPNVQR4XMenE5KPjsDWgobP31c9ZUiwfdB@nongnu.org
X-Gm-Message-State: AOJu0Yw5JGxCS8sj2BjA5/ahA0eLB+0sV3aeVh2xWu9SXdvBu3pDKKrN
 9jtuapkPf/eAdN+AByX8NvQM6SZxX0RYGDOhhB7BCJuxPdrJlltUHGpTlaVxltJir0A=
X-Gm-Gg: AeBDietCRqFsXqYR/6ltNLwVXSvdVRHnCDCK+vt9DCwR/plPn/8YwlTTu1U4ZGFfyJ+
 fpvufeUzG8zBGv2AXLaPPOgTUUC89jIDd4KC3gmJSzDZcQAiJwPEVMOSayfAPyFqPjzWNlk2KDa
 nQYg8SCknl0wj14+FqUhKHynOZaZDGz68wMEH1R8zY/hYzRoIoMFZ2qa34JVNBKfMAbY09wdrrW
 0otNL3KnM0Zs65h+1ekq9j5CqHWXymXcOfPvwdqUWAPJJhhX8fl93Ok3RcC06HReMayszAPWj8K
 B8zD1NimvhATk6VPmM0Lli/h8NSfp88x+P0prc0VikVgUVm9q06Nabezh19Pn3Yau8SlRhuQP70
 aHcOm8vnPmJtmp7lZUVXU5s8dV1nNt3VygWM6mDMuZs3VeOL4COwgGxoCQIQc3fHJWf1zGzZdLm
 V7u0wzHzRMza5YT+4mXPLDH+rgc4SltaAiLqZfc02Sft9WPTtC7aY8Y5wjd0l9/xhTCQ==
X-Received: by 2002:a5d:5d05:0:b0:43b:6a55:e26a with SMTP id
 ffacd0b85a97d-43d2930f793mr25023611f8f.51.1775588996937; 
 Tue, 07 Apr 2026 12:09:56 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4d289asm51251409f8f.19.2026.04.07.12.09.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 12:09:56 -0700 (PDT)
Message-ID: <276d90f2-635d-42c1-a4bd-5345720771b1@linaro.org>
Date: Tue, 7 Apr 2026 21:09:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/20] target/arm/tcg/translate-neon.c: make
 compilation unit common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
 <20260407022748.57629-7-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260407022748.57629-7-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 7/4/26 04:27, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/meson.build | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

