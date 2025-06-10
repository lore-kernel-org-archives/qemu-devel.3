Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7536AC61DB2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 08:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOung-0000f7-Vk; Tue, 10 Jun 2025 04:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOunc-0000en-Li
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 04:57:40 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOunZ-00055J-PI
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 04:57:39 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so65175235e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 01:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749545855; x=1750150655; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n2/4rJPLmPoGx43lpSeMUj+Pt2of81iG1MGjwH5xBLk=;
 b=BVAlgCa696jHxUzXekGo4V+44lYKIK8zvIXc1AZTz67Ox84gjEZfq5Hr0cQXnhiENi
 9mK1kNqekQmDlp/4ToV40PhdRSuFAYJhAGw0s7jJfrseSPhG96p0IMDSVEVe6+QTMs26
 N/4HiBHl96031rYXXEMosd7vFgl6ubaiYdqVuahKYj5G6i1OMsl1Hf0wfdK/UeFzl1+L
 UTuOk5lQdEtNcKu97d+CXxwALAslHGdpNkt267FXsyZeVdIAEJtdq+6Vi17mnHKDoBLN
 30JPGHWY+/s3OQwz5qtEeFIWwHV0fDQqMMn4i9bIlZE9xJ8bq9jUa8j+W1x+/u3Se6Z0
 JMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749545855; x=1750150655;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n2/4rJPLmPoGx43lpSeMUj+Pt2of81iG1MGjwH5xBLk=;
 b=Q8grSafcqnzyhDoIvcUEDArxKcS9pGfvLj3B5VIOKHx8MJpgD43KxxYvrG1hVNq5Ji
 xPq4VL43J2bsXZLt5LmWzF07/+KussX0dbrIPLE+6JrCt46XWg7X+PnStE1GjRtFf2iL
 2adGjYviwghWgV7o1UGCVjF6UrDuvwXgBbQYhJC/yiC8HKMHaWVbEGJ2UtHxAjeQmanA
 2oJtExjW+fu3XPvG7NMtBxgCv5uUpFRBVy6S6k3coLRvlnSbZsQicGTGkDu1MGyRUpJS
 tQnPBtF3HGcXzaCkUKNhBYOL1c2A4as0M4aJ4aJWwpSyg2b+iYRG6lQTbb68jVNLcPbp
 6TBQ==
X-Gm-Message-State: AOJu0YyZ8EPVy7GhH8/Sd11c87L1qXgdI0Ol4FAn6S1zY42ZcvBiEOCL
 2Ho90ISGfVcqLPZNydjx69klYPV5BkjxL6Ctr1Zu7OqmSpuHkpIrFC2opW2fwnhpo00=
X-Gm-Gg: ASbGnctWpXknP6snb4AsfSbIy/aefmoYnD4P2xBqaUJ2+EOrCvwbdGiD39Zt5j6SK/h
 111/nBGbcYPYlA7y1fO1j/yq3x3HS3yc5jhMDhLs8YtEopRwQaUYMwQrb8oM5bLOzb0E2+i8caq
 fAG+dEP+CAaBRf28P4Ky2IBq5L24uSzDFVs36jHRDA96dGjW59qDJ1nEnbZRwH45QHmCyKOZqzN
 WosOpp42/ZTBdChavKpgBFiAChgN6Pd6T/6YtWsLWzq6KB3JSNC7k1/F8Wg+6i+LCWwbRbCm0D3
 r2V5q1ZBkxngLSInzgOAL71wm2CWnH3sefBeQdyzriA2XUOzZfXtd3gbwAh24Xt3DhlZ1DAb+Ak
 hFkbcXt8gpgj9NdDBo6aFMehhE4wJ/Avi0SftP+JZzjvYpg==
X-Google-Smtp-Source: AGHT+IE6MyBzhrIWeKZzEbDuvdVYaIsUfZPgCqtNndiDEdo9rXZm0tYshLGdmkxxQTsjdA5RZuBxDA==
X-Received: by 2002:a05:600c:1f85:b0:43c:fc04:6d35 with SMTP id
 5b1f17b1804b1-4531ddec0afmr19220535e9.4.1749545855197; 
 Tue, 10 Jun 2025 01:57:35 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452730c747dsm133844075e9.31.2025.06.10.01.57.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 01:57:33 -0700 (PDT)
Message-ID: <2e925251-067c-42a7-9c86-58bb069519fb@linaro.org>
Date: Tue, 10 Jun 2025 10:57:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/core/cpu: Move CacheType to general cpu.h
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: qemu-devel@nongnu.org
References: <20250605132722.3597593-1-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250605132722.3597593-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 5/6/25 15:27, Zhao Liu wrote:
> I386 has already defined cache types in target/i386/cpu.h.
> 
> Move CacheType to hw/core/cpu.h, so that ARM and other architectures
> could use it.
> 
> Cc: Alireza Sanaee <alireza.sanaee@huawei.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> This is for Ali's ARM cache topology support:
> https://lore.kernel.org/qemu-devel/aEFnFI+wglkmLD5G@intel.com/
> 
> (Ali, if maintainer doesn't pick this, you can include this into your
>   series freely.)
> ---
>   include/hw/core/cpu.h | 6 ++++++
>   target/i386/cpu.h     | 6 ------
>   2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued, thanks!

