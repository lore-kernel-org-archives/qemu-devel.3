Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394E9C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 00:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1b1z-00007t-US; Mon, 29 Apr 2024 20:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1b1x-00007G-FZ
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 20:07:33 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1b1s-0004Kz-B3
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 20:07:31 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1eab16dcfd8so43871805ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 17:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714435645; x=1715040445; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XUDriNETMncADa0SBoq7q089QiuFOsHX3zk9yKFnu+0=;
 b=Peo1XnbnVaKPW3Xsm6a61zoCLw8BWcLqzzOqGSWj4rT5ZaUesDmrXQriO2QPFAe05q
 3cSOLcj9t918I+h5gON4mKhdHAtnS59QdBlJvuvOsMAZCqnuJA0EkARM4DruLlCxuH/P
 4VpOUJsw5aoxSNXl8wxFesGU0eUxM3UHuANa1WBC5grGkXWc6+AlPFYNL/FRNtB+svgj
 5ouJgMRlhcmxxgJS1X3IgoBSYhSoCHk5M+K6zo+tkFGzkg454yqH1F33xOUx7Z08QVQx
 +6d5vL7jBcB3lFuYxCBI89cXBoANnrWu5WZhFcvCBQHCbyXzQj9KL6YUBLYYkiCpHV8o
 Yzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714435645; x=1715040445;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XUDriNETMncADa0SBoq7q089QiuFOsHX3zk9yKFnu+0=;
 b=Jxuab4jbi9NC4VtmADOR93uZqpJuTrj/rXVb1E0szpC/b20sUWnfQ+4b/XGv6Y2s7U
 Lx923NPsI6dDCgV+a/UomBOkwOJ12fmQc796WVqpAUQRLGemN9gMV/2Czm8loIwYtjTW
 l4y3EGbGysTRkk2vGB3BP5vpMSr6ZbunQxMxDw4KQKBfbp9CJ7bcovwrBCm/KRY6luki
 EoJYMm8/HqKvzDVqwP17sXgX0Z8ax3c8O7VWcZm6MFgeWaMNESNaxqwMZMcB23+M96Fv
 e5z7wwdctCOcnVg3FfbFTZ0oXQ552hkQPVZ6ykLsGBeqhRyzIKaHlQLbbML8w1Em1t61
 kv7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfWPPlrz93p5cScXhymwbSc2FhBbI4ZgLCo/osgdZjC5UsnV4cQHnxz4g9ZGDThXMVT1v8PBDhbimZf5BNkopj4u7NwVo=
X-Gm-Message-State: AOJu0YxkSdK1J95MaTuOVj5/uFg8+UsMlII3BHuCsRQuwgxSnOQlVqMr
 BAn9qGsWbkeucb0q5eH+ju2B4Tjq/Lmqp2xBhI8psivC5bgUqep5QCzy6UCz3YY=
X-Google-Smtp-Source: AGHT+IGs+k/S8g8vDhj8bnY5Bpl1+SAQh4jRigtFBMlSuy/4PAvhuKIN7V8iXmqvoYjz9edfaaDS+w==
X-Received: by 2002:a17:902:f64c:b0:1e4:c07b:a8e0 with SMTP id
 m12-20020a170902f64c00b001e4c07ba8e0mr11409925plg.66.1714435645046; 
 Mon, 29 Apr 2024 17:07:25 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 q5-20020a17090311c500b001d8f81ecea1sm21041206plh.172.2024.04.29.17.07.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 17:07:24 -0700 (PDT)
Message-ID: <4abc948c-99c9-4617-a6ee-839c51e81f14@linaro.org>
Date: Mon, 29 Apr 2024 17:07:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] net/slirp: Use newer slirp_*_hostxfwd API
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
Cc: stefanha@redhat.com, jan.kiszka@siemens.com,
 thomas.weissschuh@linutronix.de
References: <20240429001042.2171151-1-samuel.thibault@ens-lyon.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240429001042.2171151-1-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 4/28/24 17:10, Samuel Thibault wrote:
> The following changes since commit 03555199b63aa1fbce24d16287e141c33f572a24:
> 
>    net/slirp: Use newer slirp_*_hostxfwd API (2024-04-29 02:04:58 +0200)
> 
> are available in the Git repository at:
> 
>    https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
> 
> for you to fetch changes up to 03555199b63aa1fbce24d16287e141c33f572a24:
> 
>    net/slirp: Use newer slirp_*_hostxfwd API (2024-04-29 02:04:58 +0200)
> 
> ----------------------------------------------------------------
> slirp: Use newer slirp_*_hostxfwd API
> 
> Nicholas Ngai (1):
>    net/slirp: Use newer slirp_*_hostxfwd API
> 
> ----------------------------------------------------------------
> 

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


