Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7119ED637DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 00:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVfQf-0003AD-R4; Tue, 16 Dec 2025 19:30:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfQf-00039s-1D
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:30:09 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfQc-0006Zz-8I
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:30:08 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7b7828bf7bcso5599889b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 16:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765931402; x=1766536202; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TOoWY9UUb5oOeCejZSpBjjrQIhB6lbjq3s8+a4Ts3gE=;
 b=jjhgTf4L7MbM5D8j6dyF2flAZcgWI6mgR5p0QkhtbK1/4emElFdyp0zBUAbmZENgkS
 TateqwxwzWYP63QUU6+gRp++hsdD2JyHPOCifa6RimpClvEiHovZTFA1mSvvT7DuVdgQ
 lWFCx3MPzUs8YKVaNbuEwnkzUXTer2S/6mmKHou8HX7s23ujrDpe0RojHhvsHgDyA/JQ
 5INdcct716uLYIpq3kh9BWbXJOgaZsuPJiViTqgUq2vPDR4cQamBBgMiItxnTHXtBOOW
 UVN2Gw0sIUBjwFEYOuLoa0tx23Q71Yf5+PL5aFBhFiLmAKJqe1du4d9zQs+1qS17uCb4
 GLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765931402; x=1766536202;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TOoWY9UUb5oOeCejZSpBjjrQIhB6lbjq3s8+a4Ts3gE=;
 b=HJVu2UtLP7lobVBXGon4N6uLHxaZ25sAp7YqJAoHwIccEThLnw0AmkdvfU6GXbGShx
 S2igp7Aq89uTYBPTvkc/6vvlMLp4SZqOdFOPhTnn+CC1AXiZ0DR9iFZGddlvYUXCTJlL
 HZWybQ3fte1lKJuAX8GpnAknmkC2MYNDYLhpDvSYHj7awG+ZKQuRVutLZKDP96DU8kmB
 nv7I9RNe9QWl6l4LUN4Dx3IIPrjQSm2W3VlxcP1adRCczXIIBE0mpR4HwIvfZLOLvpw8
 +3W9U75/+CBE6Ty0sLA29d6zDlqoNEmHBY89ar1yYddo1WljM0IjPhISrhN09X9ES1yw
 tN6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHSLc5QD6u0creDL7aDrBWTsCKaV7wpcMUNTliBxQ8vImff6VY12gzn2LzWpQP9E+zdtr8TJ8L5iNH@nongnu.org
X-Gm-Message-State: AOJu0YxxYZYuWyYsDt2pReGIqra1cMFdubQm2gu0WLl69A0ycAvFOsOw
 0Xu9X2/34k74qIkhSZFVH+bYhCKatS36zuPMhIiHsy8/ORSSv1HqWEOW8SqkURK6l7cLuYZUGqp
 xju2JC9tjvA==
X-Gm-Gg: AY/fxX5sq9pBUQnhEUUKL8T5xX3ayx2InNvALLhNVXwxzT1WiMkbMSw1G5xMfrgASgc
 1H8dKS40Ji9RKnsAAAMZVDmBUsHm1ZCMTBBtivMUuLU6KmD0jkgtUySz/j+DLBiZ4lbHc1J+xfY
 iU2jsaT7T+mX6PvMdaiAx9vIlkITOZU4TvyKIFTiBtvgzGOj1wOvpZzGMGrXNeiX2/+reXlH8wL
 ubfeGKeUkFHECs2iSAMxpAQyy/n+Qg86oY0shcJBtXpLgsgLWdA/v7+iJ4lXBAhbWG+IZjgNCPB
 NqkMsEiqFoaBoUrBkLAcAGrxgLnzq9M4yI2iR+TNM2IO7ZQVRDoLp4m4NZf+3S9GbdmPs5SOkO4
 nFR9mCKQLwm4MqAJN/p3b3byjHvgfVccuBNjvUTKcz4ZJ3WTaUaDEyJvLCKXfY4GtPM0rQmKIIk
 YbdsRqvwSnUXjOssZU3wxdX6Md5BHAzyt7ZaaD2205nHEWe+JopQBxsRqojeX17OLczQ==
X-Google-Smtp-Source: AGHT+IHa2MvXMU+pJlxoj0A1ODEEuKMQXxlrMdw+y+eNqwOUdRoiWbOcAn/O5leg3tFBaTaL0yI7zQ==
X-Received: by 2002:a05:6a20:2589:b0:366:14af:9bbe with SMTP id
 adf61e73a8af0-369b07ae6b4mr15830962637.72.1765931401922; 
 Tue, 16 Dec 2025 16:30:01 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c0c2c18b49bsm16258793a12.29.2025.12.16.16.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 16:30:01 -0800 (PST)
Message-ID: <8bfe001d-d233-4833-bdf8-d12899ce7608@linaro.org>
Date: Tue, 16 Dec 2025 16:30:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] target-info: Add target_riscv64()
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
 <20251217-hw-riscv-cpu-int-v1-6-d24a4048d3aa@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251217-hw-riscv-cpu-int-v1-6-d24a4048d3aa@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 12/16/25 3:51 PM, Anton Johansson wrote:
> Adds a helper function to tell if the binary is targeting riscv64 or
> not.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/qemu/target-info.h | 7 +++++++
>   target-info.c              | 5 +++++
>   2 files changed, 12 insertions(+)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


