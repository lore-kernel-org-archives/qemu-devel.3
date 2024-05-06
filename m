Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7884C25B5F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 16:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s415x-0001Le-0I; Mon, 06 May 2024 12:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s415v-0001JN-U5
 for qemu-devel@nongnu.org; Mon, 06 May 2024 12:21:39 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s415j-0005Xk-Eo
 for qemu-devel@nongnu.org; Mon, 06 May 2024 12:21:39 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ac9b225a91so1499447a91.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715012484; x=1715617284; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vwXgYLZSBfTIakSK9EeD1y5r0EVYstED07v14e/yPW8=;
 b=aF8CLiDUGLLzeqxkPAH0OMzPkBnY+/FVAp8lGAPDAEGS0aVR12l6MZI5nxSN3n79Oh
 ma9bJpXqIcNhg//cVL45Q7P+olPXvcPsgssioY9giwFP0hUG5UofmG7kMdFAccRLkJv/
 EhxMfK9C9c6100tPwjQ4pwxQyzsW4uTy5n3im/fZzfq0eO9C0xechDW2qUMDnvDc/pTO
 X4vSog3SmSsha1mR3kfFfhoQbPGrcnPB3qpnjyOtfPAlLiWU4iz6HnyIyzZCP45cppuw
 V9MuiH7PXRDdF+IDBC43gBPUh8FO76CGUFG2Follj0iSkNDaxiCXSVwmUNulHdda9rkg
 RCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715012484; x=1715617284;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vwXgYLZSBfTIakSK9EeD1y5r0EVYstED07v14e/yPW8=;
 b=P/F0vYvRyYSAsJqBoooOonALy06dJoWunmqbnXHExP9Y5EdR+mWxDBuG4NQhydtFQZ
 sZpLUgXGXUG5pDOuOpeMMmRUfIbInJe0c4LycJ9w8MODeY3zOau3IZux/GPBPdzdPA+1
 TdKzcD4hvSTdr9PJd5o4VYUY42/aG0MZhGT7LVearjZiATlVZvx3Tcm3aRgTWY0clMPg
 hnsi8bE5uXigAwKLeVVHKRGoY0lTBmmvS1I0EDgNsgVEjH4USWJa0rx4KmSYjkKZI069
 9zCoOhHs7xUhgVSV9SORS3dgiBsdHoKrskXYz/KNKPUJ14I4OyjnSrHAwBY6xTjr7SzG
 skNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi2P4QLuethRoQ/Uggxeduznj0JcdypPpFaCrq3VdMatUXxmQjRh4xePqGjQP41LRuIQA4GP+Gx0g7dce0Aq8qgzqJRLM=
X-Gm-Message-State: AOJu0YyVDE3huhaA+LbnPOiEkX5wG2VwJmICOm4RuhIkDritZhNG0iaG
 wXxgwrdCiWAj56E9F+PAOkKcCsgeXP1X6X/MF6FKrd0fi+VVFgre7NdWt4zF2LYPSUhAxSVzLjJ
 z
X-Google-Smtp-Source: AGHT+IH3B9/yjCJ3Ik74SK+dRkaYQZXPebvvubYeYIiQ2ZqKzPqWZQh7usdPOOIGpJ5PHxMQ3TlbUA==
X-Received: by 2002:a17:90b:918:b0:2b2:a6ba:818 with SMTP id
 bo24-20020a17090b091800b002b2a6ba0818mr8248154pjb.31.1715012484336; 
 Mon, 06 May 2024 09:21:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 sn7-20020a17090b2e8700b002a610ef880bsm10427209pjb.6.2024.05.06.09.21.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 09:21:23 -0700 (PDT)
Message-ID: <db1c8c7c-190a-46d9-8f7d-2ef4d1c7131d@linaro.org>
Date: Mon, 6 May 2024 09:21:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/25] target/i386: cleanup *gen_eob*
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
References: <20240506080957.10005-1-pbonzini@redhat.com>
 <20240506080957.10005-11-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240506080957.10005-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 5/6/24 01:09, Paolo Bonzini wrote:
> Create a new wrapper for syscall/sysret, and do not go through multiple
> layers of wrappers.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 25 ++++++++++++-------------
>   1 file changed, 12 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

