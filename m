Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CE4C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 23:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se0ep-0005tJ-Ab; Tue, 13 Aug 2024 19:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se0en-0005lF-HI
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 19:10:25 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se0ek-0003yT-Nq
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 19:10:25 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7163489149eso4241423a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 16:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723590610; x=1724195410; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=os4qGuQJBP//71AMztI+8f2V3cnZhIE/0i94dciv8U0=;
 b=o7u8GmvUQX7cdiIRM5VDj8AnUs0AtCQvjs47KYEyO3cztW/R9DecxXWh2gWGP7kj26
 1r7ebbWRm3o/fpC1dXzGbm/VQxL20l4Q/qZRWx5drPSortudDHz7wWIhgIziQTBIkY0p
 DxqkXKtpjjv4uOTz18/gVwnCaJ8RgWDvICvWDrCoD6zV4GnWN9TLUPfYaUj65mbSTt62
 bnvp0Mtpy7lqDWfu0aGRnr3y1MWylA+U5F07iyPcHyoYzYGFKJ8dE78X99h7Dr7rzsNI
 6utODiG+qivDgoBgyrCKG04+XUELkeWacgbZtIRby5d9zyghMkDZ2qJWJivknqSTQb9d
 bpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723590610; x=1724195410;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=os4qGuQJBP//71AMztI+8f2V3cnZhIE/0i94dciv8U0=;
 b=LlvmilOZIYo63dzqZfL7lkcBlc6FgudFKjhm/CIvwPd0lf34IXjZcQ1D7dWf3p2Lnp
 XKycsb/zBwwNPQDcejFBsXRDmUzBPsA4sN3wnMIXgDQBWWbw90NZLjRbwXkIxVSzDQNV
 pjzxhkivwc3k7wd6iJpFuiT524uGcHZ+Ggm4A6MzMQ8lhpdlHXr8iRsOsBqt7XUF5luZ
 8vMhOyUVTIVzJukiEeKnfRiud2D96cIbCY5+i1XKjbBhyK3/mJWj2N5EwXBAdGV8ICkv
 cLRfS5grodvhpRy+SVP4PjY8tRYq8+VloQdvqJIoIfsjmiTS/83cTAyRkO81USHktaiI
 GTQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ0xWgsEO+ATTkURqmPSTwD6qlzfItcPJwiIN/jD1g1bHGequSRX/hF7u2N8dDf7a7yyRa+YlKZU4tjd1tQwJ5mc1XjBM=
X-Gm-Message-State: AOJu0Yw66/6Rx1R6NtV+jzr7IDZwhESJOjMNywTh4QnI7+cHIyg5rnLg
 ZiLNyzBem7GDAc422aqHvN7ydTnWevqiAxjUox0eBSG6nUvI+9l0ItqC59SliC0=
X-Google-Smtp-Source: AGHT+IHdj/h1Dq4rWK4K8pIW6EIE8QP1UDVFGIa9xc75BJ5DOO/nLL3cfMR+C0sMhjACcLQBxLQRhA==
X-Received: by 2002:a05:6a20:c78d:b0:1c4:2469:f893 with SMTP id
 adf61e73a8af0-1c8eafa9e03mr1277469637.46.1723590609522; 
 Tue, 13 Aug 2024 16:10:09 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e58729aasm6455138b3a.14.2024.08.13.16.10.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 16:10:09 -0700 (PDT)
Message-ID: <1081a2bd-5f13-4a83-ac67-868596753334@linaro.org>
Date: Wed, 14 Aug 2024 09:10:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 06/10] hw/remote/message.c: Don't directly invoke
 DeviceClass:reset
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <20240813165250.2717650-7-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813165250.2717650-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 8/14/24 02:52, Peter Maydell wrote:
> Directly invoking theDeviceClass::reset method is a bad idea,
> because if the device is using three-phase reset then it relies on
> transitional reset machinery which is likely to disappear at some
> point.
> 
> Reset the device in the standard way, by calling device_cold_reset().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/remote/message.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

