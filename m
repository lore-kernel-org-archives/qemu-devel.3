Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4624C00A94
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 17:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvL02-00011E-I1; Fri, 12 Apr 2024 13:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvL01-00010n-IJ
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:47:41 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvKzz-00073e-S5
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:47:41 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-415515178ceso8672475e9.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 10:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712944058; x=1713548858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v10/BDWRLufUZVE4zCSV0ET9rPm2jODNhq82x8XkdNo=;
 b=UR3G1Stb1uRw1ikjcVKIrxZW67UmJa9QZrGz2EAuLPWQWr2OPOwFuxK66qHD0Ps5Ya
 wZ85zETKDViJflQRiLSfzKLuD7giBfyW2lfK5b5dl9lEezbT87VAQX8B+alTEh5Zk+gz
 YmS+q83tKU0jf2yReqIFTjX5kQ/0qmWul88qeQmtC0wXMM1alYqQPn36r5J/uZ/cdW7j
 cNHs9I7A3s6M1d9Cy7y3OMwm3v92uu4bwt3ZxRepAbSdnPxGJzV/cV8EduKBc8A1Nk7W
 6w6z5qtzd94bKeGYPqP2uJW4rgyJ0poEwEMgVn8TniSQtrXjqaBSV6oZPzIClsCncpRX
 tVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712944058; x=1713548858;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v10/BDWRLufUZVE4zCSV0ET9rPm2jODNhq82x8XkdNo=;
 b=PhSCr6aPmvN2bwqWGWhsfn6N0QYOZpzrVMXZHx+jyKQzf1HKy/JHMPhpu6jgVhHKgU
 Kb/HO7nPsOtxa6fhhLXWmP/nx4xLsars88OyjH3SbXSO12MkYb0lz9BSVufVz2st1COo
 /zvAZ4aGWZZmQ6z9oUsujkp5i+MEz/Q8yzyI96Fzlcdj9xz+Tu1tt8oJ7yr05PZqXJF+
 BSjrkiBBKIQO+LUH4NqxyqLgZ6dGrtKKN4EfqK2fGAuNBtXgxAREhE/kIDqYA4kl9kVw
 M/to/c/A4i0vLYFvHUv2ak0XyeApLe30Sp0+y2CbKV7Bgs3DGhJ4YFYVp/UP4u+ANE5S
 Mn4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA/+ocdEb6ZPsNXT6jdRX6RTSuAcXPFphuHu4qdhi05w+ahW9047z3amxirv+tCglrQvrPp7XqY9G5oHhGDzOIZ5UmBo4=
X-Gm-Message-State: AOJu0YxzHkfNqSJChD/BVomJurTzBofd0kezQQyGEZ9rSb6pbA8mmMSk
 QyJ1XzgvMAvmByXbI2a05BjCesOnGZMjJVZeyAIVR5RLtu+sd+XepQKfgep7oI4=
X-Google-Smtp-Source: AGHT+IHj3kueKLB+0+Zro8ZBrzG6KU18F1FM1yEvgKY/So3FUOE431c0rFg0iZlpAw70QUakUYSU/w==
X-Received: by 2002:a05:600c:1c05:b0:415:f755:5a1f with SMTP id
 j5-20020a05600c1c0500b00415f7555a1fmr3148526wms.29.1712944057790; 
 Fri, 12 Apr 2024 10:47:37 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 h9-20020a05600c314900b004161bffa48csm6342621wmo.40.2024.04.12.10.47.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 10:47:37 -0700 (PDT)
Message-ID: <e135e85c-31aa-4538-959f-f89f01764340@linaro.org>
Date: Fri, 12 Apr 2024 19:47:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/27] backends/tpm: Use qemu_hexdump_line to avoid
 sprintf
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.ibm.com>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-12-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240412073346.458116-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 12/4/24 09:33, Richard Henderson wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1.
> Using qemu_hexdump_line both fixes the deprecation warning and
> simplifies the code base.
> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> [rth: Keep the linebreaks every 16 bytes]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   backends/tpm/tpm_util.c | 24 ++++++++++--------------
>   1 file changed, 10 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


