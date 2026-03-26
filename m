Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC7B109E534
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 00:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5YKS-00075e-LQ; Wed, 25 Mar 2026 20:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5YKJ-0006xb-1y
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 20:11:56 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5YKH-0005Ck-IP
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 20:11:54 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-82c20f1e890so250751b3a.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 17:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774483912; x=1775088712; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CStk6RIqEf9cuCJTnhljyJGba+6roR/XDKDGq7SLGWQ=;
 b=fvEsC1iifLWnyHheqaHt+/hJTmAiWF1o5DDNCTQ+DAR+V7ZxK8UBXEGlRSXkCHP0hH
 zuEHoOv8G2XyfVoXYah4aEQJydslYRK2PuAPUOw62AaH6CDlCAZyvf7/HgWYZyXUBK7+
 5RxbNREloKADCBtpVe1Ysd4QQ00ri9Dg0VT1orgodfT8wOqgZsmnYRj+F08oIG/D7wzz
 kVIF3vX8AyTFIypGeHx2U2mzP+TKJNFpNQn3uhSUijGyTODi5Jyr2g18UEvdQBJVNnuA
 yUcjnkYFHlqAgV2RBCRAB2J9a1diTl3ZOVEDml60uciTEfAa6avM3MQZS2ERREApYWrz
 i2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774483912; x=1775088712;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CStk6RIqEf9cuCJTnhljyJGba+6roR/XDKDGq7SLGWQ=;
 b=FGOR3Uk/GIzQkStiZQ5X1+uCrJq4sk3zhEJ5vtIHCJg38U/U+lYwuYXirqOoKUs1iX
 tLSb7hw4LeRWQYraU5X8h0S2AwAm49IkZamFYbGc5jqJyP29Hf5T0BFB/ZduRUlHzOvp
 b6dUNnl1/6LY5pHjye1No2pKZLpDgG30GFcCmxBhcBOZG5U5i/B6R5DaeEFJLTnNol+F
 J5/IPj8smCQLbwd3mHMHej9JEo2BlVuOCP7WoAMQh8ZfHhZjjiAWANgejjfbl027EaWW
 TKEzvCnyPZ+G1XSgALu8MHsZmY+2Ui0fHt25OzQ9IWCirE8Bqo5AIsy5ypHojQq0h32J
 rhiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2VrD7Wkyg5zFmx6jnIsK7ZrGxw3Xl42BPBO/V8Gg8/dMqsB1ID8vdVe2z+e3bCHtbkrzvF4qbAcx8@nongnu.org
X-Gm-Message-State: AOJu0YzTALpHrx1hLsKQxaHWE9ZbE6Tf+KS8hUWkr8YgcORLJ9aWRKjC
 eApkxDXJghSt/8zsOQptSmtIMWTtpXyvmFOjfNPoNU1MTmobrhc2VAethcHZYVyS0O2xD0n3mAh
 TButZQSw=
X-Gm-Gg: ATEYQzx2r9sv0GUuVHW/WfpqWUAyE/zmZ3bItDG8i2v0MNo5FQh9/9MDjhXmF3oy73v
 ppLtEZOSBLagnMVCN2S9zWuLsrSRFWvEwL7bSIZxN6aHPyO5YoFrOs0E5+LWadammZMpdyjzV2B
 7Q+CRvjSOwHAMVjdU6HOEUCP8Sm3bycxGrUo8VDjc1oZBCMDUuQHWqg6vu6lt7wcPEigMm7LluA
 KQ7SkYUgt0Dxj8QKBcc8mSJjDqPS4aruavbxbd4DLxW7eTbzWTNZvtn314bhoOARnoAPMDFNsoA
 gz9VYc1eFFcUqg/A7tX4sHtS1CNZdaocBsK5MnRxr1P3lI6rBAmrE/JBC72OLr1mdphSYh2+sGZ
 pXfFtR1iEweKsqiQ+7bW2u1kQyjVYyxpqcgp44nLddd2aQpih/FZeIWa5WZ1GXB/7155CNoGGVg
 n7H6aqj5C72hc+fTAsGiAZY39Y5hW2jZzWC2dTg+uFtg==
X-Received: by 2002:a05:6a00:4fc7:b0:82a:7aa3:a2db with SMTP id
 d2e1a72fcca58-82c6dfa885fmr5854626b3a.35.1774483911952; 
 Wed, 25 Mar 2026 17:11:51 -0700 (PDT)
Received: from [172.16.11.156] ([103.100.225.140])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7d3f959esm840738b3a.56.2026.03.25.17.11.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 17:11:51 -0700 (PDT)
Message-ID: <979d9029-c49b-4bdd-823c-ca356d63a1c3@linaro.org>
Date: Thu, 26 Mar 2026 10:11:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] hw/alpha/dp264: Validate kernel and initrd sizes
To: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org
References: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
 <20260310-qomify-alpha-v1-3-4375b00a85ff@yodel.dev>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260310-qomify-alpha-v1-3-4375b00a85ff@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/11/26 08:31, Yodel Eldar wrote:
> @@ -192,7 +192,15 @@ static void clipper_init(MachineState *machine)
>               }
>   
>               /* Put the initrd image as high in memory as possible.  */
> -            initrd_base = (ram_size - initrd_size) & TARGET_PAGE_MASK;
> +            if (usub64_overflow(ram_size, initrd_size, &initrd_base)) {
> +                error_report("initial ram disk exceeds allotted ram size");
> +                exit(1);
> +            }
> +            initrd_base &= TARGET_PAGE_MASK;
> +            if (initrd_base <= kernel_high) {
> +                warn_report("initial ram disk overlaps with kernel");
> +            }

Why is the first an error and the second a warning?


r~

