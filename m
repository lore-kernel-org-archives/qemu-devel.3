Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85CAC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 18:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rop9k-0001pG-51; Mon, 25 Mar 2024 14:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rop9g-0001nU-6Y
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 14:34:44 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rop9e-00089y-Mc
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 14:34:43 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5d4a1e66750so2150933a12.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 11:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711391680; x=1711996480; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jTKxGkZbMwhkx1k6xGkYzOkQAgCMZ/4P8jOwMsdb4As=;
 b=HBO++SmAYxbGv6Z5ZxOeA5jzmtfySDYuCoNunKyVRyM6D4IlvVZBK7r8R/zb7AOqC9
 zoLPs38AcwDnZ7c4SSuDzfX2reV2RVTe3pRilgi3o23SSMMdLa8aDHcjOYwNXNd++Otm
 0ZmWerfi9oRBzhOZdiP2P816KHuRHNFa2Jg9iQb/tgihNqBud0huJZf2+W9ve4VFQE/9
 mUGSX6Ah8iWJi/EoYeaqkpYdqRZYddHwphCJj0HrXR3OK34kzDDG5/xYrS9UEMNzfByd
 VaKVqWpWewRDkyD5qmWKSBf6u0FgTAkXMW/I9hOQjHEHxopvliP7SkRdJK++pVAZHq6r
 yhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711391680; x=1711996480;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jTKxGkZbMwhkx1k6xGkYzOkQAgCMZ/4P8jOwMsdb4As=;
 b=aEt+QQAKRutq1KsKBoPpFcssg21gnl2Q+zV1+47a/r40qE4/0p0w/ATjih5C7QMevF
 0o0ki/r5pQMHvWGdmkeQ9d4nVzheuqgUgnXDXzxQpLo/e8+WMH80vjmGG36d49SdV47S
 mlR1Iz2r68W17fBAEGXPCXwm6QCIJdt9MKjaqYJnG/X5lsJBIAQ3np4TDdXXqEddCJfG
 KErIQO2GDGujuO0n/WItvz3kmsMb8nfvA6MhW2tllx8kmnSCwTqltYsvYEj2N6hEvvNo
 iUNfjmi3yuUK0BQq1paUYReu7EhWCsr04XtfP+H/c5jB1X+bt56ee88n8Ff16X9mVNJw
 a8Mg==
X-Gm-Message-State: AOJu0YxJkGdbCR7riHxA4hSHtAllpdK/OAD01UDYdOhV1w9J0NEKnWcv
 hGwFtgTIolt0Py7JwiBhe78kOMCrFhBCKZmsUZxPeXzhacAhTaB8CIGDlFvCN2Q=
X-Google-Smtp-Source: AGHT+IHDtjcizMYPiOH5a/q9XlS/2T1J8e+PqFAhSW3u+z2V9N/28ZTnpctUOUFbYiykjNMwx7rjFQ==
X-Received: by 2002:a17:90a:638d:b0:29d:dba2:2ef8 with SMTP id
 f13-20020a17090a638d00b0029ddba22ef8mr5993853pjj.26.1711391680594; 
 Mon, 25 Mar 2024 11:34:40 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 oh11-20020a17090b3a4b00b002a01802565bsm6797461pjb.57.2024.03.25.11.34.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 11:34:40 -0700 (PDT)
Message-ID: <807790cb-ba7e-43c0-b22e-c7daa95404cf@linaro.org>
Date: Mon, 25 Mar 2024 08:34:37 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] linux-user: Fix shmat(NULL) for h != g
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240325153313.526888-1-iii@linux.ibm.com>
 <20240325153313.526888-4-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240325153313.526888-4-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 3/25/24 05:07, Ilya Leoshkevich wrote:
> In the h != g && shmaddr == NULL && !reserved_va case, target_shmat()
> incorrectly mmap()s the initial anonymous range with
> MAP_FIXED_NOREPLACE, even though the earlier mmap_find_vma() has
> already reserved the respective address range.
> 
> Fix by using MAP_FIXED when "mapped", which is set after
> mmap_find_vma(), is true.
> 
> Fixes: 78bc8ed9a8f0 ("linux-user: Rewrite target_shmat")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   linux-user/mmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

