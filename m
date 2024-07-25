Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D06CC3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 10:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWw3e-0003Il-JV; Thu, 25 Jul 2024 06:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWw3c-0003Hi-9D
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:50:48 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWw3a-0002eG-2z
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:50:47 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fd66cddd4dso6960415ad.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 03:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721904644; x=1722509444; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8zwieWFDQbKiODMstLWSyT5p4MFJfruliiqM89dDFVk=;
 b=QRQTtG9ffw9VPtZri5IOo7vftIH3lBbcSu2fexxodnVbW1Gj44djRrA0HFbbfMnb1J
 Df+aeSZTRrcxakQ/A0QhChMTnD80+pnlKDbNRNUca+yhEQzkJSxorTlf7pZ/h2b1REes
 jxaIx3HiP6mS3iZ+c68PoZcEsZ6LY6a2w1GzClas+wrHjTTVx4FviZ4GZ7ls79JqFeCS
 8r9nUK/QAcRP36eZWG7Ds48GU8rsHDdPV2LZvQDiNbVLs6ookQcYK4Op8Az6nyUpO/Xe
 N4ojIBbllmhfMepUxr10W2reDEMMI/c4OcEk+a8M+OunOQBIAQl3xQO1Njc+P4dbydvC
 XIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721904644; x=1722509444;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8zwieWFDQbKiODMstLWSyT5p4MFJfruliiqM89dDFVk=;
 b=W79CIrJNnBSWcMuDEQt9qIMD/8KBxPrbd9mhI1/3m87Evp+VJvSz1nlIIk/NabWNrX
 l9Qcd2h4aL/6g/eYCz1zaINfZs4xrZwYju+xt54vN0mMVpA1QHAZkyrAitgfUSTCEu54
 9TkXeffFippL2TyXOoxwpZLCtOhbcm1GMsde9o7vhlW7PDpF1YW3aW5BB45UWJvCyjIK
 BAomYlrBGJzIokx9F3M2Pk141HG8w3Xjf6lDicZbmalLvIIjmxwtDvZvovlKbIZlRNnO
 kaKQoji3fP9npEFCHEz/McE1NyhMCil66HSGMDh2HDz2UZD8yWjnLVo0UM5VPoZeEifs
 YmTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw0h5YN2n4g13aT1bwWTEnO0jk1fLnTghJmOJ+KIRTr3+5blAQLOs0Z6LmBfgE1vpuO74Cm9e+4oudIihDGbfyMj3z1ts=
X-Gm-Message-State: AOJu0YxcO22oXe2zHUqv2OXP5BHsUD8Fg7TKyR9PCyG2vBjBflAX6Dz0
 goayJH9odfmJvd7Te8O5KMLGReNikGe1RfNYR3z0hSmdJn7Qc3TV8dYtUUPC5ng=
X-Google-Smtp-Source: AGHT+IEdX0tZG7WifFjAi9hqwkTKHrCAEPGlIuS3JlkrWyoo1LYJAzw2eEftKrSRuf8uFOtlAUee0Q==
X-Received: by 2002:a17:903:22c4:b0:1f7:37f:728d with SMTP id
 d9443c01a7336-1fed3870eb3mr34637785ad.10.1721904643811; 
 Thu, 25 Jul 2024 03:50:43 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7f30246sm11211075ad.212.2024.07.25.03.50.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 03:50:43 -0700 (PDT)
Message-ID: <917ff631-2b1b-4482-b8d8-511cc7f100af@linaro.org>
Date: Thu, 25 Jul 2024 20:50:34 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/23] Convert avocado tests to normal Python unittests
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20240724175248.1389201-1-thuth@redhat.com>
 <6d609ff1-c4df-4960-be5f-4b29c5911879@linaro.org>
 <877f8f8d-c798-4e8f-a323-e06d14cda44a@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <877f8f8d-c798-4e8f-a323-e06d14cda44a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/25/24 20:13, Thomas Huth wrote:
>   Hi Richard,
> 
> just for my understanding, did you try to run the tests in parallel (i.e. something like 
> "make -j$(nproc)")?

No, I ran "make check-functional" with zero parallelism.

> For me, it works fine if I use normal serial testing with "-j" (btw. Avocado v88 is doing 
> serial testing, too, so you won't lose much time during the first run here). But if 
> downloading fails for you without "-j", too, I agree, we need to tackle that problem 
> first, e.g. by implementing what Daniel suggested. That will take a little bit longer, of 
> course, so I hope you meanwhile found a work-around for the problem with the missing "imp" 
> package on your system?

Not so far.  I'm using VMs for avocado testing at present.


r~

