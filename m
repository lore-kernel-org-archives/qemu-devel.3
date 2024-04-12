Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6DDC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 17:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvKxY-00086f-9G; Fri, 12 Apr 2024 13:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvKxW-00086V-Oo
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:45:06 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvKxV-0006aT-5y
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:45:06 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4180c6a1003so3776405e9.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 10:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712943903; x=1713548703; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hC4S870ULBs00RxU2IpfPlbwvPclGRZqBSlDp+e6NzM=;
 b=ooWi7ej96mRWYl9Lz/ET1HtOFqN+6NmxcbTYysbPiVq0yCUwXybsxflvH0oxVUVKn8
 MSe+85PjW7l2v/GLIxVMSRoNL+RbatYkauRX2d0yNW9y/45FEjR54j8oLjoR+4uTGHhI
 CcArIJ5VbdLiYdCdPVOSdX725PjZ8H5EaTa3JVfOxh4pwPymUDG0jZF17jLTY7gYPKWU
 mE64bZ9pw/3UBG+K4g8R3dMeq1cfu0XLUJi8uXjf+MqwkFtU2wDxYh/IYQn48WXK3D3h
 2gceFJQh4YQToIvQIjFlrl9Qiop7kdkSBZHTyPTcqdD9AxBZgJ6rSs8DIFvW28Y4CiD5
 YCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712943903; x=1713548703;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hC4S870ULBs00RxU2IpfPlbwvPclGRZqBSlDp+e6NzM=;
 b=qEWACnRipgJk3pOhwIdAnwHuXkWNbfg0PNxI95fXT5AoiNL8zmWIYro42iuyBpCzru
 1kI1/I08JV0mrh9V3B8t+P+lH6brIYFORmTsPZY/KOlzVVsYxnCN+EriwiylCVMwCLVe
 qRps9K/uLjUC43c2G2iFImasJs/xfUlz4lVvj/zFHyffKpFO2jdCKk0HCTagNtQetzhY
 gjmgIeWuamDXxftDIjrLM8ktyj92vVlc2Lsn8Et+p+IzvNcLxMCYZotR+i90ilEBx+nG
 1hRlU/DoKrl+OKj6A//u5WaWLtzuVEsbwtl1/mcg1yPjY1aoEn9rRYnh9SbbpUBAtl0M
 ZmvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZVKcytNooMXEZ1Rj9IINx0eMmY32tLwXkh3GO7l5/owLVaJbP3AaoK+j3dR5ZvTgK5clbhD4ph+w98j32h+JLYKq0dO8=
X-Gm-Message-State: AOJu0YxP/dPj6KMt9Oei+FKNa9R1WkWCKWj9AjFWM8xB9YznXnl3mrDT
 ktELhgwKxJ25AUdR5jg+u7D46N1xDkExGH/CweP0KcqKncQq4bfJ19NewAiy3Kg=
X-Google-Smtp-Source: AGHT+IHvjPJGeOT6M7gpA83M8N2dTJuWfw5nMd7kd9H1+b67MTw04aG8HZA6XycJhoRJtVA2Y/ITRQ==
X-Received: by 2002:a05:600c:3848:b0:416:920b:19ad with SMTP id
 s8-20020a05600c384800b00416920b19admr2267908wmr.17.1712943903521; 
 Fri, 12 Apr 2024 10:45:03 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 ay22-20020a05600c1e1600b0041817890fdesm479939wmb.41.2024.04.12.10.45.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 10:45:03 -0700 (PDT)
Message-ID: <6cfd2fc7-af11-4e8f-9644-6ee7bb64856f@linaro.org>
Date: Fri, 12 Apr 2024 19:45:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/27] system/qtest: Replace sprintf by
 qemu_hexdump_line
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-8-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240412073346.458116-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 12/4/24 09:33, Richard Henderson wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1.
> Using qemu_hexdump_line both fixes the deprecation warning and
> simplifies the code base.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>`
> [rth: Use qemu_hexdump_line]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   system/qtest.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


