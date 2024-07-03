Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AE1C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvYd-0004On-Ir; Wed, 03 Jul 2024 04:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvYb-0004OB-8o
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:41:41 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvYZ-0003oH-H3
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:41:41 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52cf4ca8904so8366421e87.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719996098; x=1720600898; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uVgHOvwSwgx/vEGgCu9/5c7E1/8yCI+n6rBYvM8BITY=;
 b=w/70kINVNhUxKEWU1jNLjYIU1TBgGnxZuRzPUJ9Qm1HSQPGgsnNTi0EiZEiBBQBdPR
 5fjelcmr6FxbxCWTWQIbLBORDrvjlypB3j5jeLA8biydu4Te4T8VCDnp1E0EoEYFvl/1
 emoPlYND/5t8AFdTCBGeL6ynOi5a59yX5uVjwmgjJiPePHPlWh8Cd0WZnrMgv/CxeWgv
 9+ECy7Rl0ud1dhheB7h+ob4EUrms42Xv3wLQWAnbGvf+qk0wYnnRF3aNg+xPt45G4cY4
 BVPKmLC8dTaxjx1dzu+Ry6wMavOsZRHevY7yi2DWw/PJRbgy9HFpp87kwszh9F/QrtbV
 Gh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719996098; x=1720600898;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uVgHOvwSwgx/vEGgCu9/5c7E1/8yCI+n6rBYvM8BITY=;
 b=OfttB6wHV+iFQe9IQowOMMICoLR5ee/Ci2b6K3koy+wuS2pkZwP4w4Bc4cJaXXSwRR
 EgJ9006erJz4igZhtawinmjRRgoVPJa9/OelU3510O9HXHOatZyliM9k124EfWE/8IuQ
 sKM0c647EMvKt/M3V9xrsOY4Orjpwlbo98ZedfAJI1Uc/j2cwXxb/zymGQFxHmFxZDJZ
 OMre7yxgQzdbMwWDQdtiouB30sRMO7j80//nRS9ohXQwRvDCJc2llaIjhB7oJF4ix7o+
 4hS/GdSs/OVWau5w6YioGImr+bGWql1R64rCKNIPk3l+TPA4/cmiKEDX59IO5/11Z9WZ
 jmMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrLuhTdhsri1F6BGKriesEjNQOEHjlfu6Xkn2dCrXenkNe98KZPlSd5XdyuENrADl8Gdcq4KRSyBIkyDnX1TZUGlbAXW4=
X-Gm-Message-State: AOJu0Yz0K2G0E46E1/+v9VTG+S9GAd3iCszNsIbCR+K5ojy1R3g9Xr0b
 v+zdxZ9XsKECkarWZOBU5R0vpKKgM6uAdSv5sRI3dZg6JSvwJEnvSe8bxl2MJeCVaBWDpTDzfU0
 F
X-Google-Smtp-Source: AGHT+IHQftKnwJaGZm229hEmsUdZfRc250f5zA8x6k5pVyRyumrEdHg72ARiGuwXe+qNmfkl5ZQZag==
X-Received: by 2002:a05:6512:400c:b0:52c:dfe0:9b1d with SMTP id
 2adb3069b0e04-52e82702dd9mr7134285e87.45.1719996097545; 
 Wed, 03 Jul 2024 01:41:37 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3678aa3caccsm3024249f8f.35.2024.07.03.01.41.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 01:41:37 -0700 (PDT)
Message-ID: <0b995c12-7063-4bef-9d66-0d2ae0d31392@linaro.org>
Date: Wed, 3 Jul 2024 10:41:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/22] qga: remove pointless 'blockrpcs_key' variable
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-15-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240613154406.1365469-15-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

On 13/6/24 17:44, Daniel P. Berrangé wrote:
> This variable was used to support back compat for the old config
> file key name, and became redundant after the following change:
> 
>    commit a7a2d636ae4549ef0551134d4bf8e084a14431c4
>    Author: Philippe Mathieu-Daudé <philmd@linaro.org>
>    Date:   Thu May 30 08:36:43 2024 +0200
> 
>      qga: Remove deprecated 'blacklist' argument / config key
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   qga/main.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


