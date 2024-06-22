Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E0FC27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 02:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKqQU-0000cN-1d; Fri, 21 Jun 2024 22:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKqQS-0000cA-BN
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 22:24:24 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKqQQ-0003ta-CH
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 22:24:24 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-25caf76158cso1492359fac.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 19:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719023060; x=1719627860; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/oyyvSCE1SdZ74OlGNfCTv+7lZzt2IxKwPJwRB/ylms=;
 b=xfi5dualRgqkIJHLa/sj96oFXyE6VwDwJG+31V4Tl0nzixdNN5ZZCmMwdwXE+mfcbb
 euf4SRhyFEdgzS/FdLYq2sJM919Z9m0aTSMlg7KbvmTlA19sEnOd85UmpJD2oua2zSOd
 P+ACg581tZa9VivdNzNAfre3GzVpmxteQCxC4f4JrHlij9yWPLubj2KMwIUIU8uEjJTi
 fWKGrU1Sz2E950bdrHUC/MEWcJFp1V4nahIjF4YNzxMX7VXHAgW3YUo/ysT5IQTy2xA6
 rK0HXri12Soq5UmelIpdeFLCB7WWX5ngVdHL5Dul8jlua1IXlB6znYUfpFw59jpGURAc
 siLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719023060; x=1719627860;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/oyyvSCE1SdZ74OlGNfCTv+7lZzt2IxKwPJwRB/ylms=;
 b=eUKzc2iYNXJ3PEcKQtSqRfmunMOpqu1tIjnl0aqqdCZHS+D6PabLXEu4pVzZ26e9Cd
 ovl6sU+iU/53MHdc0MHKw+Vf/uLuxXL1HH2DYrDFyai0haZYFF+JxOg50Znmf6go0ANl
 OKHNT53p7LX/WNdXCxLWO3jEyT9X/ya28xgdxwHYpLuiuz1GYC1/UjrQa0BxmLl3zfeP
 /gBDbzaqB8dQsEMWpz17YF6iY5lMUZEsr6KAqBvROz6Vu11An0TqL0TG03DuLbli2rPo
 lROHAPypJowsTf5afnkx0mtKM8YlyDdC+AWNPMp3JG5OCdUmn2DwJ8tjLaS8YpVzapZx
 WA+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3SCzxd5JAPYTs4+iAegEGty5JZ7ANcTRjuoJpqgwGZv0fVpkuJlRPkPImpHTv/ZA/IlxBCdtI9QtOaO0n4GEoKXrLWks=
X-Gm-Message-State: AOJu0YzTzJ9KenE97sd3zSc8UsqvEhXUfb6ltpi+ERHYzUT0PgcYIlqa
 jqicWGKAP+90oVziEjDo6j41hvo8JQEGoMibSnHL2zpsYWti88SJdYln3yPNCAQ=
X-Google-Smtp-Source: AGHT+IFv85qTbkIEmdnO/HyxUl3qhBR56NuxdiF7wLy7mS4SHKUn+7C1Yr008r6A4YFxomiC/By1xw==
X-Received: by 2002:a05:6871:81f:b0:254:7f9f:3f21 with SMTP id
 586e51a60fabf-25c94abe807mr11447553fac.27.1719023060225; 
 Fri, 21 Jun 2024 19:24:20 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7065124e354sm2095474b3a.119.2024.06.21.19.24.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jun 2024 19:24:19 -0700 (PDT)
Message-ID: <8c166ceb-c506-4492-8d4b-fc3cc9c691e6@linaro.org>
Date: Fri, 21 Jun 2024 19:24:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/28] Migration patches for 2024-06-21
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
References: <20240621175434.31180-1-farosas@suse.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240621175434.31180-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

On 6/21/24 10:54, Fabiano Rosas wrote:
> The following changes since commit 02d9c38236cf8c9826e5c5be61780c4444cb4ae0:
> 
>    Merge tag 'pull-tcg-20240619' ofhttps://gitlab.com/rth7680/qemu  into staging (2024-06-19 14:00:39 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/farosas/qemu.git  tags/migration-20240621-pull-request
> 
> for you to fetch changes up to 04b09de16d78cf2d163ca65d7c6d161bf2baceb6:
> 
>    migration: Remove unused VMSTATE_ARRAY_TEST() macro (2024-06-21 14:37:58 -0300)
> 
> ----------------------------------------------------------------
> Migration pull request
> 
> - Fabiano's fix for fdset + file migration truncating the migration
>    file
> 
> - Fabiano's fdset + direct-io support for mapped-ram
> 
> - Peter's various cleanups (multifd sync, thread names, migration
>    states, tests)
> 
> - Peter's new migration state postcopy-recover-setup
> 
> - Philippe's unused vmstate macro cleanup

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


