Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7379BFD45E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 19:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvKlv-0002RF-51; Wed, 25 Feb 2026 14:42:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvKlp-0002Hm-Pj
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 14:42:06 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvKlo-0002U7-37
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 14:42:05 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2ade1806c28so26345ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 11:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772048522; x=1772653322; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CfFiKuEp3QRfnNSdj65WKiUbN7nQtTN8Xk1/EYaTfYA=;
 b=Jf8WilT8NrWc4vwfPHuGjZckC0v4b2Vke0vJmTwk7cMbbl+5Dospu8MEUWEFfPKIcr
 8EwwsrOfUcx0rh9a01eEr+3hx5Wwrih+Jv8l96Nv/rMJAaIJLUJpyiS1/QxcOa3poTlC
 36TAN0sT6IAos272zkjq5YS6b6aw0vNO0suj9EDys2k5H2wdjDRLE2X0s+XKdO5HXaaA
 eTnZxEH2SVabwb2OlNj5mHOpfhG/OnpFP98jPkBeMnVELApkGAugHv6GVSu00oAhG5cE
 XAqvCrl9fkRt6zSq5+YvZ4HvE53CnzwM+y9ytcblMAk7M3ELwNk33ZM4tEfNzRSoUT3I
 juHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772048522; x=1772653322;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CfFiKuEp3QRfnNSdj65WKiUbN7nQtTN8Xk1/EYaTfYA=;
 b=ImBiKYurXKqFngmuZDgRmcAgs8CytROmBoS5uGX+ubfj7dgS9Y/0z+LHX8s8rTC68X
 YsJmRy6zOZ7G3WoX/Y/SCT6yWFIOMDrx2RUPb2HifUpmrA4NRravCmI4cCeExGtE/wXR
 0xmdHCL0cXnwusAGSJK+w84TFzvq1CwLTNFeVibkF42UWEOMpe7wCGL2lU8MfvoT+ycz
 oJBSw4/UtMiKLGKUYmleaH7hWuLifbPSQDXZ8V60I1Qj8AbQnU8LtFG6YJtU3L0XuEru
 Zv6/fpIQYpbdIoLB5/ZE/wolWTJ8Rpqsn+WNhG+EmzrEc5BbCqya7XWFhKIfP0SJzvAh
 TFOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVea6IHRbbp/1kCo7qwxw7xbzMsp2Mn5wviqYsctcutdHM9jG9AJtoWy9gjUOQs21zyCP+jLZsai9bk@nongnu.org
X-Gm-Message-State: AOJu0YwhMXp8VTnZv9wckRXs3DzsuWOtoIH/7GjfIMVhiUyjRtKw3QAm
 Qwnbu78x1+XG6OwvZF/zqTrjGLfvoTZPLGdr7ziMYkhEGNEUz6KhJSgjwH9q8UuQ7wE=
X-Gm-Gg: ATEYQzzWqsa6eBLLYQYwNkypx7QWpdrasuJP0aa8hbqaJKYwqqGgp+hU/rLf3cnOVLt
 RbB+4Geg/c/zjYLGlNDGAvst7iq8ciRdU8684yDK6t9GqQ1yGTj7md5u/X9w3rvAlukpQL41VfU
 q3jJUOmEe2DCx/x/7iMkqRvYEyQNHZ+MYASLaLwD2Ap1uNSdNhOVP4NYU3oyz5g/XadSNuOr4/h
 KxXVbwaLHcbvpfAXUB3AyKKFAp4se4CpDWkGK7LVj6MCFJHb+F5ZxpWCfbOAfDs0WZCfLZWfft7
 SJxTPw6aPgR3XA+duWxSBvbWE4ABM+DMlJbTVEQndAfO8XTQD0vs9jwfLldgDlsQK4bxFsR98fG
 Mjxjy8hW7GzMl9jAsUVyiVvY9Ik6sglU5CAuzGnet208aOc4Mra9Xh+24yF29b/yGCNrbdi0BuP
 FX3bnP2H/xKbbp0HNU5ZJ/iEvgtTHW/cufMCVK9ETcsiVzYWQYQ8+LlViI5hSqJb+vLm88
X-Received: by 2002:a17:903:8c8:b0:2ad:9edf:7fe5 with SMTP id
 d9443c01a7336-2ad9edf8239mr83081225ad.42.1772048522443; 
 Wed, 25 Feb 2026 11:42:02 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb6b9b32sm113825ad.66.2026.02.25.11.42.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 11:42:02 -0800 (PST)
Message-ID: <90864356-6abb-4cbf-a2bb-abda2ed82c93@linaro.org>
Date: Wed, 25 Feb 2026 11:42:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] accel/xen: Build without target-specific knowledge
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20260225051303.91614-1-philmd@linaro.org>
 <20260225051303.91614-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260225051303.91614-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 2/24/26 9:13 PM, Philippe Mathieu-Daudé wrote:
> Code in accel/ aims to be target-agnostic. Enforce that
> by moving the MSHV file units to system_ss[], which is
> target-agnostic.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/xen/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

