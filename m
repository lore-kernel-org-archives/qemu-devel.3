Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C12BC02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcsed-0004y1-P8; Tue, 28 Jan 2025 15:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcseZ-0004wv-Vi
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:57:48 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcseY-0001le-Bu
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:57:47 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-216426b0865so102428745ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738097865; x=1738702665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e/j3djX5P7cTMr4TvLlyKKfeb806Lm/X7E899vHrlsk=;
 b=jbY28oZGGHzXlPMgHUn7QqWUgigdU3nZtZTIWIujOrEvgbJ4OrDjbMf0FMCdCRyNZ5
 vie40Xpaxkf6EYu4ik5FieVTfP+AVAnVuv37B5Kynaa9fZ8DFckJhRyw64xabaqXGobN
 NqObaiuu/6fatO/sNDhGXS0HMJ+yRK6HMiagj3SyxpAn5ZnTTpWMhq0wzeXjaOsKZGy2
 5jXxTwjCVTrQbD4mdZxiCOYTnT2o6jfmhtf96mgqZ8KLAHdZYiLimojzXCA37hW401Rz
 BvJeJFLhFYyrxvUlFFN/18WlbdG5+AnlKgtZniufM1wN5rWBXnNhMiCHGzFZFu8Tpxe6
 +oFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738097865; x=1738702665;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e/j3djX5P7cTMr4TvLlyKKfeb806Lm/X7E899vHrlsk=;
 b=nglZzJd0aNCLUrN56U2nuvzH2w+0V5d3mXRss54m6knHF14mu5cUKZlkcNDyZnVDkV
 reJIWmfcq6i6wmrtVpbdHvZZ/U2KW0pzj8YYuG1vhHljBNusnQ34M8QFBlvDTHwKDpk7
 jwm2F35uYCWxdT8YUtwcJasQpnGduh15Ei/BcOOLwSrPb/50VzPbP+gI5xm1yAbjYXqq
 qV9IhHRncZvnLs3m2Y5+kZjdHS6biUE5sL//IhGZKgu/QVTjpCbujfQ7XMthzXnJy/DB
 YOUbCkoUNnw/e0vzo07TTrYjnalXyqpCpaWjF/HQ9cUNtHbjVJ3/ZRcBGdq0xen8Td7x
 fx6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFgjHbV874hZuE5kuXPktQKvx9TWkE5MA6eY9eTT0UzcviK7560LCqajHFDnn8knz/TSgvBgdP5/Bj@nongnu.org
X-Gm-Message-State: AOJu0YzCQtIMxXU43ekjmhihePySc0H9OzZbrtDm624BrltE6u4+VHmY
 8WTn0KjDFJ7PDzjmEY1hdf7o7k1wPlnGFBb/uPJKnb4eDVciqkbTWWQx/pg04AI=
X-Gm-Gg: ASbGncvq5PBdzbzjb5GXGx3K0y5EWhu0FEjqZ5js6w1tPBxSFkc9+gGIN6Mkanyse2G
 1+bIz3lwfvDUk9zPSEeY6iXiH3GXmkGHHjh3dn09FMH4cx5hKbC7qJ/8AcbGGxkN41JOPebbvbz
 k9wzU8eibdT7kaM9UD6uRBA68xTbLUpF84iP9V6uPQJw8YuA6CCiFxchJLbYoVeMT3vWXSbdbCR
 4GwdfnaPFx+UV+qvPotx273NbP5uBIZzPzjUlEWPz/KLIOVzQV6wY2HvsAl7G8QlHFBaHTKOTX8
 qaCxPaa+z6BmMfyirSzZmVNWic29RdiaWA5xjPkxWN3FAoOnvXNDHeDV2g==
X-Google-Smtp-Source: AGHT+IGQmS1U5TkD55lT94xgjJt77H1Ps9AbI7rFVFqB9Sq1Vn3WnMDmHybZ62mb6aXiObb2eeAIHg==
X-Received: by 2002:a05:6a00:10d4:b0:72d:8fa2:99ac with SMTP id
 d2e1a72fcca58-72fd0c14853mr796959b3a.13.1738097864710; 
 Tue, 28 Jan 2025 12:57:44 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6b52f9sm9647208b3a.72.2025.01.28.12.57.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 12:57:44 -0800 (PST)
Message-ID: <964bc905-40e2-4394-9470-4950d1a3b887@linaro.org>
Date: Tue, 28 Jan 2025 12:57:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] accel/kvm: Assert vCPU is created when calling
 kvm_dirty_ring_reap*()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250128142152.9889-1-philmd@linaro.org>
 <20250128142152.9889-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128142152.9889-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 1/28/25 06:21, Philippe Mathieu-Daudé wrote:
> Previous commits made sure vCPUs are realized before accelerators
> (such KVM) use them. Ensure that by asserting the vCPU is created,
> no need to return.
> 
> For more context, see commit 56adee407fc ("kvm: dirty-ring: Fix race
> with vcpu creation").
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/kvm/kvm-all.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

