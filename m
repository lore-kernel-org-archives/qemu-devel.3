Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A1610AB800
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5pbQ-0002oT-Ms; Thu, 26 Mar 2026 14:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5pbK-0002nr-Pj
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 14:38:39 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5pbH-0000HM-9N
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 14:38:36 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c70c112cb61so886084a12.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 11:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774550312; x=1775155112; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/xNa4xOwI42AiNOpB5CJwKgXKd49nGe4Jn/3hRA4u28=;
 b=sbkWXxlMRqYBEpbV3X7rNbRPnzf/i0nr+k76zkhXs6HQGtVFW7Uflnr6S2Iiez5N87
 NwqaDD4KAOMZk1ZplQZdMVLtYbPx4Fo4MaPbAVx3Fda1cUQsAkqJfh1wBoBa7MlPx9x7
 lycwIJMqE2Uev9+8pk/Rm3p8CVRzNZ2EbpHsh47X/x38E/Hll3b9MElZb5Dy0mxIIJHh
 PWJtvRmNiy7Iw+7p38sjnfywLDRnrDleX1cdUG2IckRiWVYiOycrtnBZ35+WymxXlMVh
 czW59i7hmbI3NcQdFRFraBURLKu9CYmSNdu0NdxDdQkA128RGhp41lZLcb/AwLvfb1Co
 5xzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774550312; x=1775155112;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/xNa4xOwI42AiNOpB5CJwKgXKd49nGe4Jn/3hRA4u28=;
 b=TB8s6ZCRtSH2s/C6KX0DiYUB70R7K8ME3uKIJpbdHR921NtZgnuK14vsna+Hflpe+g
 JFWyoZwbg1JpIKUyxBmTauNcTH736ucpCQbP8UjeLfey4X3X4kipUXa8QJPCtEy2y3IB
 6Yb85P0qviU8UE/m9oE3JAnZ2rA4+/y761uSDKFE3hH+iJu2RdLASQIySmn7kI3MfOZj
 Z2o24wnzvyQlUDc1eKQNAwJMcTLnOh6vRHhvV3MIXRt38tt+4blFHOi1MvfR7fTqRMJ5
 Fn3Q7UEDoubCsqW7eignujcAf6vBUZKpr58q+TrVHXhLUezBPvJsC4/EQgXL9X5u6lza
 FtWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcE1RRVMoGPKQliJd++JFJtnVLhHA+I/bkjInyUJIhGM73pdyVdfNHYhVXsCEWjXV4VSQyVqKKePCH@nongnu.org
X-Gm-Message-State: AOJu0YxjAPZtYGPY7KQj30KCwCxBMv8td0dzR2aLn6PDtehSTidb2I+S
 VIsRuntxZJktY3RnBQRGediiJfmk2+6WFJKKzekpQD0nqWRtx9907eVppi537qItOKhlt+f9E5v
 34LICFdukgw==
X-Gm-Gg: ATEYQzyfkYkBj9+fBU9WjTlcvir+22ApYwPBS/R0hcpBHBitpxFJ1w8/ut2L4pqb7Np
 0/7ZUEMbQ/pEQGmA+sXTsTfgiuzEUMLqpiwpLIFmH+oE3Xgk0omcXpVe17gmGtGR5TeH3+Yohkr
 rw5TKgpSL/TK6gcbJNsK8sf1AWqPBwy9BjcIUmUFl1nhofuBV/M6Zrdo7zUcMzBoRDbyzLdfEiQ
 QCBwguExT/DkoPam2Je5lz81iXutGjzQUD8OTI0Yzi527pal1zOUwPpA/G/QAC+xhGbswgGvK5B
 uq2U/PqT3R6+6MecZRebJljigPHHOW2GFS8PF7iNO6XjOOxbHjMpl0CWw1gNpB6EzkLCuMkQjQT
 ToeXlqceNWysYoPC0n52NLZjWqiWvrjBqvNzw2VTVpd8IQiSE609jYDthBGih5XVN0dSF3lan9r
 GYg/SD6uxn6y4W2vbA+eKvwcrx9pmommQvshF1CQqcfEYLHPocXl9LQuV5IGxOSE8ZhTyF
X-Received: by 2002:a17:902:d581:b0:2b0:b325:748a with SMTP id
 d9443c01a7336-2b0b3257b59mr87413635ad.22.1774550312443; 
 Thu, 26 Mar 2026 11:38:32 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc87e786sm39098065ad.51.2026.03.26.11.38.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 11:38:31 -0700 (PDT)
Message-ID: <37ee653d-0c1b-41ba-9312-bee856050ae5@linaro.org>
Date: Thu, 26 Mar 2026 11:38:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] whpx: i386: trace unsupported MSR accesses
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>
References: <20260326183628.79281-1-mohamed@unpredictable.fr>
 <20260326183628.79281-4-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260326183628.79281-4-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

On 3/26/26 11:36 AM, Mohamed Mediouni wrote:
> Not actionable information for users, so stop
> having it displayed unconditionally.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   meson.build                   | 1 +
>   target/i386/whpx/trace-events | 1 +
>   target/i386/whpx/trace.h      | 2 ++
>   target/i386/whpx/whpx-all.c   | 5 +++--
>   4 files changed, 7 insertions(+), 2 deletions(-)
>   create mode 100644 target/i386/whpx/trace-events
>   create mode 100644 target/i386/whpx/trace.h
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

