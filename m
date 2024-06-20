Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348ACC2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 18:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKMJ7-0002rd-Cg; Thu, 20 Jun 2024 14:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKMJ5-0002qz-Qr
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:14:47 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKMJ3-0000Au-Sb
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:14:47 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-70b2421471aso926552a12.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 11:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718907284; x=1719512084; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yqROtSVhIzjnYywXs1S8xM4fOa8po0hRYNlz2qc1m2A=;
 b=Cqt9vQEdiXsFnoSSePQ86iN0ZdT2EU2o70lnTA7znD/Inp58AcMZKPwoFXYSDw9woi
 oCFibvjG2asRfqZ5LBI/UH7JLmKskra0r+jItgzZtLev/0Hc5sITvMRi0juPMJpWncKF
 RvII5ihQZRZfLBeVLkrtEFkrWGjJvj8ldiO8JgpkwjaF62GJj84v4o+FRgHIiBQgLPf9
 O+LhnV7PnjNCoGGpOvxM0dIAuXy3EMPWhOKS4EdTUXD/70f0dAZTdrviFvWcKgyWW+Ve
 3RAB2XTlop6EBIXMSWj5BqbUrhY6DHopumRWK0eSpir/mvpAlEtKSe1bLyjbXtxbKFkW
 1aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718907284; x=1719512084;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yqROtSVhIzjnYywXs1S8xM4fOa8po0hRYNlz2qc1m2A=;
 b=Ekxv9YDX2HmPbEVh59pN4m49HIou9Zl9QJYaFu2IQn5PlaNu72NuhzDD2w16+2Rd1e
 s3X3NVl3zBd9c2Vu29C140JJYZmm0vpwfAdtJE8FMlzIdkXcGOjGT6GwzhFfu45iDbq2
 f1EYfPFPztnFjy58cs5Yc3e3NuSJnNWbKpb1ztX51gDuNY0N9b3XFe4IjHR5Abiasmv9
 R45blCxaLCAUql73TaNbgMdgTI/p4u1ZGFsySRUVYO47e4qkGHSRlEhRYv3xxKPv+Yay
 SO6thQr++klg0DdI0llErWZY53c9dxBcU3C1XekahHz8ZtCX3bxiUaSQ939hV5p+tyWe
 MvRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmq0YedsFAjiBJZj6snBdU3kr4F6rwroXLL2tI15DRwJtmHpbwrx6LF947n8QrYGGBNfeM17nlHF0suZ7bJcB0zDKPuK4=
X-Gm-Message-State: AOJu0YwWVhRFRmwzH/qyReG9JkXOH/+NasiM2Vp34IpRfxFRREBuSL7t
 dpMCeNJI0pQfGWc7ytNCBIgrqxnufcKGr1Dc0q/zlZCC9p8SwhjJUyMOOsJ9W9g=
X-Google-Smtp-Source: AGHT+IEf3Ao4q9GAQrIG7F89aYs7cGbhoeepBqv45u6MXmMD+m/Whm64G0oipe1KML6EmrG/IOVZPw==
X-Received: by 2002:a17:90a:ce15:b0:2c4:aa69:c4bc with SMTP id
 98e67ed59e1d1-2c7b5af8252mr5835141a91.19.1718907284405; 
 Thu, 20 Jun 2024 11:14:44 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c7e55d52f9sm2029212a91.23.2024.06.20.11.14.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 11:14:44 -0700 (PDT)
Message-ID: <92be5dcf-c793-4c29-9a55-910b59c4c2c0@linaro.org>
Date: Thu, 20 Jun 2024 11:14:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] exec: use char* for pointer arithmetic
To: Paolo Bonzini <pbonzini@redhat.com>, Roman Kiryanov <rkir@google.com>,
 qemu-devel@nongnu.org
Cc: jansene@google.com, mett@google.com, jpcottin@google.com
References: <20240618224604.879275-1-rkir@google.com>
 <4b3d0472-8b06-403a-9ab8-553aa858fb7f@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <4b3d0472-8b06-403a-9ab8-553aa858fb7f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 6/20/24 11:06, Paolo Bonzini wrote:
> On 6/19/24 00:46, Roman Kiryanov wrote:
>> void* pointer arithmetic is not in the
>> C standard. This change allows using
>> the QEMU headers with a C++ compiler.
>>
>> Google-Bug-Id: 331190993
>> Change-Id: I5a064853429f627c17a9213910811dea4ced6174
>> Signed-off-by: Roman Kiryanov <rkir@google.com>
> 
> Would it work instead to declare MemoryRegionCache's ptr field as char*?

I prefer to use char* only where there are strings.  For unstructured data such as 
MemoryRegionCache, void* is more appropriate.


r~

