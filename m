Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BEFC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 21:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmKvY-0007Bh-Bh; Mon, 18 Mar 2024 17:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmKvU-0007Ao-G9
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:53:49 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmKvT-0007Qw-4l
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:53:48 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e032fc60a0so8585135ad.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 14:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710798824; x=1711403624; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0J0b3IdvIfK/4G2vKtuFbY6rYDZPYOgKETKbw4b9mbY=;
 b=vBiaei0iPI1rTLAzwsiQmY8C8r5NOEYXhbb3rEKk4OaTQLM3FcqGQpYIJeSvAMqqEF
 XgNu5LPTIYawPfBSeitMpcGHUVVnb1nhuRCp8EHzmot1ItJ1DxEUfZ8sNUkx3x0EjaME
 rHTapv5chsQLYMYJWE05XK9vZAr4y9uLWvmG7WfRMTlGP8MgRjn+Hnfjn4QpHRi8yyQC
 lj8ALn1FMEP/WlQqLWjQwXGJZAeW51c1ezKInCR4LKv2K9+4UDt0ds7TnTVToJoDSMXE
 IslY/11ddsaq71XDP2tyRPe1/Mh7LazD2V4ZYoFf5wU26ZxEkXucLfKmgFYWWLmrRNbt
 05Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710798824; x=1711403624;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0J0b3IdvIfK/4G2vKtuFbY6rYDZPYOgKETKbw4b9mbY=;
 b=ai/p2KQUR48Ib4hZhK/zP54dgHUkcr6HZWuGGQC8bkHUHXw+or42NHz/D9g01kXQPj
 zF8cUJcQJdmYxxFoMt4/ULFMjHww1nzsZsN7x2raBVemyq/br15Rv8i9I2DstZ/z0fol
 kNqoopBcTRZsSi2e+El9f870DB3N1C+oYadraOWViDCJzFK3wMSKCmDCTxX1bL1SW13s
 UNJ2SWf/bRVo23McLRPhPjdVr0eZAFCYcxO6aZ6Y26CKQoBrhfjErW/3TEfqRgmVAkD7
 eUACAyrlo0tOVzakV2+FS0YlsiDN5a0SKywMUaBspZs2+NIx8U+56HHwpM0ZC8dIgD8y
 pX9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU14y83efg9CFTm6iBX+gy/sm/7Vl5MNhujhZF1eT66yYw7JICyrTJ8AAy+6/VM24XhNT+ov1+gzEPEWUy3fW5K8tNSPvI=
X-Gm-Message-State: AOJu0Yw9LwQykLGPAFd9TDAGfOfaFhqwe32Uje3lODAahSiRkPq/un7x
 wajaA18tzUKIDnTz2jcudZ0aqNc6zLx32kuTdSWqWJU7dThXPTexS9KlAZUxXsI=
X-Google-Smtp-Source: AGHT+IHC4b2VZz9rCV7cUPgRuUv7fowp/XdGj7u4rWTi5FfVN5j9eDA/dGyS4rtRSFGzM492tHsbBA==
X-Received: by 2002:a17:902:fa44:b0:1e0:30ca:62c with SMTP id
 lb4-20020a170902fa4400b001e030ca062cmr1089054plb.1.1710798824299; 
 Mon, 18 Mar 2024 14:53:44 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 v2-20020a170903238200b001dc3c4e7a12sm9857342plh.14.2024.03.18.14.53.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 14:53:43 -0700 (PDT)
Message-ID: <7481d134-af52-4c27-8029-c59e56ad6bde@linaro.org>
Date: Mon, 18 Mar 2024 11:53:40 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] tests/tcg/s390x: Test TEST AND SET
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20240318202722.20675-1-iii@linux.ibm.com>
 <20240318202722.20675-2-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240318202722.20675-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 3/18/24 10:27, Ilya Leoshkevich wrote:
> Add a small test to prevent regressions.
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   tests/tcg/s390x/Makefile.target |  1 +
>   tests/tcg/s390x/ts.c            | 35 +++++++++++++++++++++++++++++++++
>   2 files changed, 36 insertions(+)
>   create mode 100644 tests/tcg/s390x/ts.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

