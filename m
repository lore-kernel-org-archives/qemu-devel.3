Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DF4C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 22:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJhe3-0004qM-FT; Tue, 18 Jun 2024 18:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhe2-0004q7-BT
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:49:42 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhe0-0001fw-Tk
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:49:42 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-6e7b121be30so4227394a12.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 15:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718750979; x=1719355779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xfrtmJNOmu/qMEl5Ff6Cf5vTGmX7TOgpeiJ8NuEIxPE=;
 b=jk++Fm4abkJYztL4N35KK3tHo2/gzOoleLRF6PHEBvNfxN9Q4uu989/faLu9n258ht
 riMOKVJy6VqBHMYWabVBCFm9E4+gL08nbHpy5qFdDvsbsxR5JKmTyckXMBbYSsjifKut
 xnNJv+KkZz06YPPV5WoNzwCam/Gx9NAyjHcSjpLVBJwuIfnlFuxjbXCGYJo+y+9h2MDx
 egXoLHy6/sb4lkjbg/o65EahiQe5ud//nhYI4nzRrOuJAZyLijHpKyS8uwHPppaORi2b
 mrbhDKAwNR1fTO2do44G4qlFindkapkJ721ibsAISTCrhxjVFk2SKWibIbpc+QUANxJy
 TfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718750979; x=1719355779;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xfrtmJNOmu/qMEl5Ff6Cf5vTGmX7TOgpeiJ8NuEIxPE=;
 b=sGzVx0Jc/T2YP88ADy0SjLqUyXEumhxRTKnRW65rnp5bWt6VbWNkzB379DvruurbYc
 UZEzWiwdoOxt/SnYdbx0Dqdi9Ee+d89aysjjAeu4xsSNh8YpspFRiMckVsBGsyWkdclT
 xqqviY0XOs7rLtNTZIt74VhNXp0UkmK/yij1sRs6iYVCjV7Ni25N/eGtdBZhCUBr7vnn
 8mfW8R69HUeFwnEXcNlt7/LChIOiIttZsWbEXLkKbop36blvSZEXSSCPOk3V1mIvUEul
 ES7zd5hvFVuLZHvlx1E95xg4FxXCWKB55mUWMajQZ3YUIEq1OLeMYp9g4Z7R3hMacs7z
 g2vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURolcSIXiqgfQoHTEAqEwVv2zyi++mnurVD9Zzuu3rtuRv/Qd/cM8rfIgPFSAJywzWJuwEQdVSOWMo9r9IgkmF4cddxwc=
X-Gm-Message-State: AOJu0Yy/aWyyYGYAGZ1I2FORZ44XyWSPwJtiY1Dj32m8S9pvY53Vv+cL
 BFmzKx4T+7UCNM8R6caWwkcfyv+dnnTiwg7jKbqEG89acN6Iqvp8wFbJpP5kYpY=
X-Google-Smtp-Source: AGHT+IHpZz6/W8jR7hvkYKYdXay1aq2hseh8OXPX5byWBZLXG28aKEkP8Zxi2U2KtwBTtvm96MQ2ug==
X-Received: by 2002:a17:903:244c:b0:1f7:eea:ebd9 with SMTP id
 d9443c01a7336-1f9aa4094acmr11079245ad.37.1718750979466; 
 Tue, 18 Jun 2024 15:49:39 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855f497a1sm102424945ad.283.2024.06.18.15.49.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 15:49:39 -0700 (PDT)
Message-ID: <001d2136-c818-401e-8422-f925ea4c98a8@linaro.org>
Date: Tue, 18 Jun 2024 15:49:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/23] Add setup_sigframe_arch function for ARM AArch64 in
 bsd-user
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-22-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617185804.25075-22-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/17/24 11:58, Ajeet Singh wrote:
> From: Warner Losh<imp@bsdimp.com>
> 
> The function utilizes the `get_mcontext` function to retrieve the machine
> context for the current CPUARMState
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> Signed-off-by: Ajeet Singh<itachis@FreeBSD.org>
> ---
>   bsd-user/aarch64/signal.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

