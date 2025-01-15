Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15B0C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 08:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXzAL-00087I-RY; Wed, 15 Jan 2025 03:54:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXzAK-00086t-A1
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 03:54:20 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXzAI-0000Ql-JC
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 03:54:20 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so4758510f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 00:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736931257; x=1737536057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wSns4H0ctUcCJXV+8Oz4VZuQfwYax8WUM0t6+z4hBvk=;
 b=T6/cKwNb19zGO2j/huBhHCD/sJ3KdzP25lCZgMv696ynb6vwEQXNuSaZ3hkAgd1LXo
 KZyjhlIbdIB3m9AmK8w93ymOWoa3cMKxyXTvz1Tnj1geCtCcQe+NvAs4PuouNSIh601z
 +KIK2ERlAoT+bIhbT/KBQ31WsLk3FvjwF7cQ5aC3WFFTBz9pL8sTK8NSkDFlhT2TE/HQ
 XT9r28ix93+Cm+jl+wlix2Zm/UMeddLlEmEKt/LfQxy7KU/ehHIlCZUpP+jPxcmJQ4qB
 dTYNErZp1TmJGIjNkPGMOJpqI8VnCyIAEpIoelC56JhCm2193ZLpvn6Bo9rnKmaKvGo/
 p0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736931257; x=1737536057;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wSns4H0ctUcCJXV+8Oz4VZuQfwYax8WUM0t6+z4hBvk=;
 b=MTB/zrQRh0qGmhUBC8FUbVm7NKXU0On8pPkpzLWDbGcVo5GqUOiiWU1E3D+g9ElAGD
 a3LFLfsvlMcBGVLUaiv23TtNk84aq2xk8ulyNoldPSRzP29T512OJinB8X1wOfvEFpoN
 6kxzOUXAENd9QSIH3vE0ffPRtw4jckCocLXtfg4kuXI4rH0EGEr4zP760ccAN08RDrJU
 U+f34LkXp7Bv1b81qut7EaIeCg7eoNBHI6q+xOqUMs5LMlhQ3J/jdeZYlzHTRsUTa1iY
 4hMjlpDxJE3Dl6z/N0RhtjjoMGUbUUzWhRhKrzrB6nupifL3t2Ij8MtGnX4yKAM5+4tP
 2iZQ==
X-Gm-Message-State: AOJu0Yy21d1umGQoALatTxGEojFmCF/vFv/WAzTqh9miXke6HY3KgzEU
 EptvbIokymXa6t3O+DX6vLzytomTOlUisttyM6E13hpOC9LnKNiqMbpA/tBaRis=
X-Gm-Gg: ASbGncvqnrTpND7wZ+i/aHqSZeFuiqXLFKuvhAHuiYoE07tGf3v7CTSjCC6jHHx/BRt
 +B5v2kncKSg9doGUEGV/jwltlHp2m0CUmZmc96/AEuAin5K3uKUV4rN+I0B1Zg9I7OZs0CLebhd
 agpD7+NG9GyLBBZawb/McNmF+Ma1sJpi0HuvBtZQLfLAq/LHjwpJpp1TZaFqTW4xjp+AIR9WRth
 y8Hy8YXRthREbVQeOYZ58B/L6SoCEqx2G5wQRlKam7A3+itfogGX5zqYaj4LkRtos+W96+F3pL8
 kqkyQ7P03XAsrEKs3F6TS/4G
X-Google-Smtp-Source: AGHT+IEVCgKIybENrrQAU41oY6mzOErQWyLVlFjvhyfj2wqmewbkN8pkDq8/7iS5s00LpIA15IAEfw==
X-Received: by 2002:a05:6000:186b:b0:388:da2a:12fa with SMTP id
 ffacd0b85a97d-38a8733badamr22382372f8f.52.1736931256904; 
 Wed, 15 Jan 2025 00:54:16 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499932sm15726495e9.7.2025.01.15.00.54.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 00:54:16 -0800 (PST)
Message-ID: <f7c096ab-6db4-40ca-ad13-789c78fe99e5@linaro.org>
Date: Wed, 15 Jan 2025 09:54:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] hw/s390x/css: Remove the obsolete
 "css_migration_enabled" variable
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250115073819.15452-1-thuth@redhat.com>
 <20250115073819.15452-3-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250115073819.15452-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 15/1/25 08:38, Thomas Huth wrote:
> Now that the s390-ccw-virtio-2.9 machine type has been removed, we
> don't need the "css_migration_enabled" variable anymore and can remove
> the related code.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/s390x/css.h |  6 ------
>   hw/s390x/css.c         | 31 +------------------------------
>   2 files changed, 1 insertion(+), 36 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


