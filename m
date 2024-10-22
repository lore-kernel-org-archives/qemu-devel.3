Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AC7D2C55E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 14:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Fx4-00067B-BI; Tue, 22 Oct 2024 10:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3Fx3-000672-HI
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:33:37 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3Fx1-0007d6-Se
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:33:37 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-208cf673b8dso55657475ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 07:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729607613; x=1730212413; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WIGQI7xEr2FXNkQMfBliJv31c/EqTYaMCoXLuA/QHNk=;
 b=QoMghSh0tlfcUj6wmWqxYhKqAhrq/naxaxFFfPoBJim4CtXoLFCEv0zCv6hHY8kkTx
 CCpIJi+UxDefYQRmJVNzJjxWmsvLFZOGQIlsQMilY35EFnIHaR9lUwKTPCW6ycdq0Cdk
 Z7/2Qu6F03z1nQTRdXJ9DBeyMoVkFB/xzH6vhtexxrxMrXoXBFRC6cOOgx2WrgV5sgqQ
 3xb0leDqv1BhffCDPWB4yk9BZdcObUXbyWta8k9R0W1FVNrSW0GOKZrys39RpzrfIL1X
 hmah//RUMj+2piKlQiMjawyv3D0bm57C2zV3z24Thclkz8UcaC3U7VfCmmaXYqwN5xKZ
 G5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729607613; x=1730212413;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WIGQI7xEr2FXNkQMfBliJv31c/EqTYaMCoXLuA/QHNk=;
 b=EABQRrm5KF40Sd6p10sQAp7r9KXqz2ZGi37xUK7nVlTBlELg54Bk0PdbQx1cHy02Bh
 kZV0H1nZ/YswLrGDXkYw2ruFBsn8oHiotP71xEd5kfhjVwTOIV6k2GcYNzJl0BsGpA9B
 DunG9mFFW4/nOoidNxcxHu0GFaoPOmG+MvRR2o+02QalonbWMXvJ/FZ6gtkdyt5QkJbO
 kmQMI9uUfFf0YQMbmOHJbV4qmAkyoeLyl8D/KYg+YmnXcL7z812gbSHes/1QTyr/Gg54
 tsAY/+hyJucfJhK5saUr7rCAusCNe6GBSQuZTFJJG7aIFIzfnnJgYuJ6c8z6aWBVgFRJ
 0Gdw==
X-Gm-Message-State: AOJu0YyyNahb+v7P/XD82KKK0PvcTkG0HuKdGcranu7e5vMtqgIVPkDU
 LpYQHVMZRj6+6QNMF3I/oecKp9aiWMMYnsUZRN8N1aOb73am3SUK2LOIPLNqw26Xjs5pJY8Ck8M
 i
X-Google-Smtp-Source: AGHT+IHtViMpS1z/8NqlJOHjd1zTQlnvGYPbBCyUcsrqMeMWApHMpQ7v+S5KUhmiOy1DckdCERPEYw==
X-Received: by 2002:a17:902:ce85:b0:20c:d072:c899 with SMTP id
 d9443c01a7336-20e5a7790e6mr190557755ad.24.1729607613556; 
 Tue, 22 Oct 2024 07:33:33 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7ef08c3fsm44065015ad.73.2024.10.22.07.33.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 07:33:33 -0700 (PDT)
Message-ID: <c3411cb3-6669-459d-834f-1089e52c77d3@linaro.org>
Date: Tue, 22 Oct 2024 07:33:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Tolerate CONFIG_LSM_MMAP_MIN_ADDR
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org
References: <20241021121820.483535-1-iii@linux.ibm.com>
 <38ff2ca7-7156-4ad8-b777-dab689043ecc@linaro.org>
 <5a6ec294c6da14a2a65d3669ac4dcdc79934c452.camel@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5a6ec294c6da14a2a65d3669ac4dcdc79934c452.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 10/22/24 02:50, Ilya Leoshkevich wrote:
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2898,7 +2898,7 @@ static uintptr_t pgb_try_itree(const PGBAddrs
> *ga, uintptr_t base,
>   static uintptr_t pgb_find_itree(const PGBAddrs *ga, IntervalTreeRoot
> *root,
>                                   uintptr_t align, uintptr_t brk)
>   {
> -    uintptr_t last = mmap_min_addr;
> +    uintptr_t last = sizeof(uintptr_t) == 4 ? MiB : GiB;
>       uintptr_t base, skip;
>   
>       while (true) {
> 
> But just for my understanding, what is wrong with the current approach?
> The intention here is to fix the weird case without affecting the happy
> path.


Once the identity map fails, the magnitude of guest_base does not matter.  I've always 
been a bit uncomfortable with butting right up against mmap_min_addr.


> It also looks natural to try the fallback once the normal
> handling fails.

The normal path is supposed to have complete knowledge of the address space.  There should 
be no need to fall back to blind probing.  To me that does not seem natural at all.


r~

