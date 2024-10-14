Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439F3D18156
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 22:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0TFp-0006Ez-OY; Mon, 14 Oct 2024 18:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0TFn-0006Eb-QW
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 18:09:27 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0TFm-0007Q5-E9
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 18:09:27 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20c803787abso31605005ad.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 15:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728943763; x=1729548563; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zb7cyEiKcqQ5X5/PCi+xvEfgTJqXZGZBRJmR3ylgvJY=;
 b=FiutCx6C8UJYbalUEHwNNIFHodbY+Pcwp+egSFEN2veaF6ynoJhX1pxPEs8D/aH27X
 f9jE0yKkn+y33JBqeZef2CPFx+BE1DIwwQvBB7R+SQ0ECyG8a99gUJS4ZUtIhOWWZkG/
 f4fR4f0t/AIyQC4gtUVmM4HlLtt0l7V5B6EPELiNMPqSQbXWRP/nbN4PeobuSHp4YHgt
 N6MHnVassUxXB3KBfTipoxj1HoDo2wQaOLzZry8gxT4iizYb8sZ5lZl5fUQIPWSj+t5G
 DZ2AGqhIz7XPX9waP8WnnTPA1Op6anziPevGFvcv+32pa/5gxdt717gFX2kpg3Cr3ZOI
 uHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728943763; x=1729548563;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zb7cyEiKcqQ5X5/PCi+xvEfgTJqXZGZBRJmR3ylgvJY=;
 b=NuY/u8dzLWzUiVK1MsWcISNBQLoffoEitoAFXniagKxbJX5qIw8z4mybToXN+FlSHu
 vEuVSdjlnGBjtH3BeU+9dCEpgVCiNcz/Qn2ydnJH1E8IRkyobtnXUqvucdYhptUDQL3Y
 IcxmZ8LNHXzAa/fJEWKPg13gZUdTXkjrg4z+zmr3/jBz4erV/EmczjuODi+9e8x0S52/
 iZLpUjq2C4vZ2ighsYsXMCzMzNcPojLNFgnHmZwRX9HXUhpfh+igK17qMYQBKRvYNMK5
 aytJjYHoajvYASgL++Gu1JQVsXGQSJBaEB37wXrZ7fN64IULO5jZ9jjtKQLpwuohb6o3
 TZkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQqyqM7vuriR3+0CjpkRAgr/g+m2eSjVsjcuvU3HCdGpCth3hn/Fi8DFJAErUQmq5YlNkfcaBX283h@nongnu.org
X-Gm-Message-State: AOJu0YxHTsmNNs1qb3RII+bnipkUvgIKNiKPI8DYlXXvEUjeZhRXCC/J
 XTAU7M8YbUnskp+xYoAqdmQepW5pvxN/tOi2wnrE6Dhcq/Jqfb8M3l2ibgvl144=
X-Google-Smtp-Source: AGHT+IFRlNBn6hEnVT+VBZ73Cg9rvzNTCZAk+d07rGDa+nfZVGRS/XUA0BC7gLZ5ukNUKV/EUg1nMQ==
X-Received: by 2002:a17:902:dac8:b0:20c:e898:c88a with SMTP id
 d9443c01a7336-20ce898cb53mr68937075ad.0.1728943763367; 
 Mon, 14 Oct 2024 15:09:23 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d1805ba92sm82675ad.255.2024.10.14.15.09.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 15:09:22 -0700 (PDT)
Message-ID: <f0493b9d-f2b1-4330-9cc6-b1f7cfc77c67@linaro.org>
Date: Mon, 14 Oct 2024 19:09:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: remove singlestep_enabled from DisasContextBase
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241010083641.1785069-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241010083641.1785069-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/10/24 05:36, Paolo Bonzini wrote:
> It is used in a couple of places only, both within the same target.  Those can
> use the cflags just as well, so remove the separate field.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/exec/translator.h   | 2 --
>   accel/tcg/translator.c      | 1 -
>   target/mips/tcg/translate.c | 5 +++--
>   3 files changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


