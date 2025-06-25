Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD807C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURPq-0006ey-Hy; Wed, 25 Jun 2025 10:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURPo-0006bi-0T
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:47:57 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURPj-0005Bi-55
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:47:55 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-235ea292956so71867145ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750862869; x=1751467669; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s/Y5ZyONO53NOKJ7YmRGDdnawblMtvBKampI+nQDoeI=;
 b=W6cXIke06g62CJ/hKReNWCS7zCQ0cmsNV4NScvje3MEl65eqYJbSvcTflKoZYS8Oo0
 ljxOQQeme1iZPE0dOBZvTpuM37ehw8rAOBF3mZss5DvxtH7te2DuGAbN+OK79t4iH6Dr
 AUOnt+NoJkJnVddYH+KXS6ANXeeLbgmoJbbMj9jeArWdjrszXBbEcuP3ZMy0gpx9FxGZ
 94JYswt0ovvbgjc8gNHz34iPSTkrmSbPkrdKywVbyww+YLSsj3JGoLEzszImsDOeF/CN
 r7RSVeKm2sB7RFkDhVrVTnuR9cEfVIrSRqs6I+A6JrQK+mov3jdw5/PcDU4Tof7978bA
 k9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750862869; x=1751467669;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s/Y5ZyONO53NOKJ7YmRGDdnawblMtvBKampI+nQDoeI=;
 b=gg7f5+fm0XHksYT/butzLz9aD+t12lMPu6nV88TtjVQ6O5tCOQoLdo5tib8cMJwBSU
 WaSAn8Rir8WwHP24ZZIFfkNnBxu47V6XK3Vf0EGxiURlVF5x0ldVf2By61UYEG4Ew9bU
 2PPMefHFYBjDLc+th9M/EH0g6G67r65y8Ke0U0cWqFdPGRNqr4HPzS6wbArav24nyNBe
 gr1yLDsGsDfn2KHms731P+m9GMGdWQJjX0Wc7Z/fnKkKOqhzbnl6xzdfLbNRYpFqE6e+
 z8RfU8eJubUJJV74lLzU/Szd9zHUhCLdxUCyZuuQMG9G4xV4/19rfSUpHU4FAGJywV5U
 v0pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxUbh9YR++GZaCKd6+QNiYL/77gBeF4DjUxrECE1qbbSfO6WdoH3ZcPBofoVlWQgM8UpgmgGZyrAoj@nongnu.org
X-Gm-Message-State: AOJu0YxbQG7tBnhAyG8Yb1e/t9VR97VHKQpkAPcL2zdsbH68YHJdcMUj
 pci4Yye7HvhGi8vT9IjpiTGqpNoyFC59eoLI6nmCHGVb+Cgcabtwt5vsmXR2SJlTYJ8=
X-Gm-Gg: ASbGnctaXcyKsMUf//66zf5Bm3YoW0McJ3/LfZPHE4dHsEZgClPxCpD2ofIspuS1yKi
 nwcVebmZGVCEbBrU8bUp34Gjpa9wLcmGVCzkjOUfYiY+imR9zapIqbqTOLq1PV6DoetjxcEX05r
 pfXGlQPHsH3RpoMQUzY/4ZGtWBepuWb2ySMO25c5Toyl9x3ZQFu6IaLyAupxCkq13aUKJ7ZrUNT
 96tIJsFKeg4Ces1ED6ny00nGFBZlHfUCyf9BkQAcKdpebixyVE5ERgbBgTTYddUQSIKAcqtklxa
 0fuOoVpOGJVYOAQ5LY+a819dgov30nK4JX+MWQaR7n6RK2oJnUcMT5Y1awKRvJHNKukBHOg9a0M
 =
X-Google-Smtp-Source: AGHT+IGFSO7QnVgHAhp+qSj725S+V0lWIZblNgeOje4ht3cmumfbrotsbXQZI0Vs7ZD2NEWS5ruiWw==
X-Received: by 2002:a17:903:187:b0:234:d679:72f7 with SMTP id
 d9443c01a7336-23823fead84mr63988585ad.23.1750862869145; 
 Wed, 25 Jun 2025 07:47:49 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d860a3besm141135865ad.109.2025.06.25.07.47.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:47:48 -0700 (PDT)
Message-ID: <7c890889-fac5-4366-8057-0474e7ef6477@linaro.org>
Date: Wed, 25 Jun 2025 07:47:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/27] tcg/optimize: Build and use z_bits and o_bits in
 fold_nand
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-8-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 6/3/25 1:08 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


