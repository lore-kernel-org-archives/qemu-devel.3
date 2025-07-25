Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9275BC87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 17:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufMgA-0003pE-Cj; Fri, 25 Jul 2025 13:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufMg2-0003Vg-Qp
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 13:57:52 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufMg0-00029f-20
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 13:57:50 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-74801bc6dc5so2391695b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 10:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753466259; x=1754071059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QkoZ7faUGgVx+/uaY1cFHpymKuZRj4E0OClgFoDJM/0=;
 b=tzHhy70AfiK2Nxuiq9vkJP9Z1r/5DPltgHJGipxHog7PGN2aTxyQqJuk7fLkVm9+PS
 gWAr3vFxVoTordUWmg9jMvS4bADKe9RxiwzLwdzXXN2FvYVnPUzMfxadcyer2FQW2M1k
 xNeBipqTZw3B9acqHAAL3WzYCEzi+IRODmQygCmZyNwsU45UXGh89EPlJvZYckbSV2OH
 oqHu7ZWp2ZKpn7YJHajcfmUJFhUUKl+86g5VBfCCZPvjLXwGHEa/mSvBx6b89v8f+KxR
 RvoChZEbr0/lqztWyU0EvCnPdqXjcgAe5FqwHh9WTk5RMI3Oel1QgcWvRQDECBF+GRSh
 ApkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753466259; x=1754071059;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QkoZ7faUGgVx+/uaY1cFHpymKuZRj4E0OClgFoDJM/0=;
 b=vspwpuRWEFnBjnafzlHDrbRSuttjE3QzsnCWg7A+3HDHI2yTHhqss7pRCfu69cHIiB
 /s8FZB8QBkvT8TkkGIsG3viZE6sMgezdNIXcvHhMApSLCPcGaxp/vWs7CfHKvlGJORpF
 zD9C5sNRgaq7l5QxeDpIx0mEJE8OA4xYrQq/aV2kDOHor50eyKR2AmgI9dkYNPg1p/IJ
 ClEQUk1McHCyVQyaZYHEiGl3plFpG5sfiQQDz0ZGvEFrmYbaljuNBHGSWNTDks1NS1iV
 oRqc3DNlpeXc2zVe9AhuTc274UqYe1BMmA4P6jPzF/CAWZCTlGbkALwSyZWX2A3PjBCN
 EeIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDenIS1yTS4t7m27HBlwU0BW2E1BU5yKyl0eSXF9f0U10sGS9AzyfOqBmseaFBxegWI69fl/8HM09f@nongnu.org
X-Gm-Message-State: AOJu0YzR5/HxxQBcSsezWwBNTQOv+CB4Ivnkh7r9iPmiUmWWfghwXZ+r
 IZwdjNxqCSY6P0WIqumkCENLe1O1t4v6hyuqE7xHjnEO0QEowbE6xqwQd78z14d8syk=
X-Gm-Gg: ASbGnct+6E11X6rVkfxsmNpO9AGMbtkTsdtdh9ctv+7Q5qjrwt25iSg8gsDml3OfP6l
 VD/Z04lH/bO1LMfWjZoKYsSrjzSTGcFg3sii5l5TayatjkOakvfRTO38a+MI61MAidClvB8bQ6l
 oUiyBjqo/yBD+VIF/iUZGc+cejG5kFssd9e5PK58SjE9AALS/PHUtxRZEwVY5V1KAJFIu0sVb/Y
 S6uZcgeHKCmk8ZJ8eN9VfN4xQv2Y0apJTS0ghANIeResGOuVPgwFrfYdE8ft1OVSxWawuij7Fkl
 mzR5Osujz7VHGzf9YneCGNtUyQoHmom/P0F58CQMJYvgdw0dNIybHd+l3muCQ8m1DDgsDUcD74d
 r/q9kHzQKxBD/DLO8VhBoD5hTDqZzQeJ63y8=
X-Google-Smtp-Source: AGHT+IGgr5I8y94vMBcNtcU+TDplJ5N4GpzxFgc4vpftjzx+e4wFZEcvvXSl2UfOpPsDfnUA9gtEWA==
X-Received: by 2002:a05:6a00:3a12:b0:746:25d1:b712 with SMTP id
 d2e1a72fcca58-76333fe47b9mr4619385b3a.7.1753466259079; 
 Fri, 25 Jul 2025 10:57:39 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640b2de006sm191650b3a.108.2025.07.25.10.57.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 10:57:38 -0700 (PDT)
Message-ID: <1b99fd71-d32a-459c-b85c-7185597ac537@linaro.org>
Date: Fri, 25 Jul 2025 10:57:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.1 2/3] linux-user/aarch64: Support TPIDR2_MAGIC
 signal frame record
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20250725175510.3864231-1-peter.maydell@linaro.org>
 <20250725175510.3864231-3-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250725175510.3864231-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 7/25/25 10:55 AM, Peter Maydell wrote:
> FEAT_SME adds the TPIDR2 userspace-accessible system register, which
> is used as part of the procedure calling standard's lazy saving
> scheme for the ZA registers:
>   https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst#66the-za-lazy-saving-scheme
> 
> The Linux kernel has a signal frame record for saving
> and restoring this value when calling signal handlers, but
> we forgot to implement this. The result is that code which
> tries to unwind an exception out of a signal handler will
> not work correctly.
> 
> Add support for the missing record.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 78011586b90d1 ("target/arm: Enable SME for user-only")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   linux-user/aarch64/signal.c | 42 +++++++++++++++++++++++++++++++++++--
>   1 file changed, 40 insertions(+), 2 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


