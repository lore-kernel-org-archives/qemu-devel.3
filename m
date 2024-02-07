Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C97C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 06:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXazb-000683-Jx; Wed, 07 Feb 2024 01:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXazX-00066W-5D
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 01:01:03 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXazO-0004cG-F4
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 01:01:00 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a385259f0a5so135541766b.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 22:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707285652; x=1707890452; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2PdZRQZrV1iRL9uj91XqvnzzUKZBCaWjr7/54DWT5QY=;
 b=Df1+lGvcuzBsVr40q4vTlP5vthdRTDWRxU0nfjBTwLOO+JO+fN0/z2JkPiXxQE+FyA
 4poGF+bRaSUwuoU3knbJh0TzDiDSOX/VW6iSa1p3Ox2mYyEErnDnViNyBikG1hRZhsnR
 tJuryLj8gHXd/1+oERGx6m03nZBWcf67PHp6JdtlOoMMMjc7ZHr/Qt5/wxJa7agbs7UV
 4eF2CQ5cELEaxyeiL9csgokPbZAHphMWerPAS7d7A3Z7YjYprU26A0hFdOrosbuntopU
 2u9/hUB0znvrsSPfr+vZYy/aWcDgrUM6SJC8G8EWtY2Vl+NEtX/8sf9S0RQGhq2lxtgL
 qC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707285652; x=1707890452;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2PdZRQZrV1iRL9uj91XqvnzzUKZBCaWjr7/54DWT5QY=;
 b=Cgx4BGTIIV0yLBx5PJspdoiVUUy10ZZ00Bb/IaCzmitXs3Bh6b22RK8s9yhAw7xxDA
 aa68x4AECd1yeHpr6XVIi7Zj7W0C8ekv+8FQRZAzu0IN3lpDKp2MEyRntMIz6o3c1AhQ
 34udTJl7h2PppHTJo7gy/BEulNSmzkoY6eyfjYkQWuoKVhDEsxmE6/RKdmhJHVzSAErO
 ZncnDHnCebGzGqWW7bCzsZAp0zkQvH+XDwobhJYx3UVqocifH7LCetRDBp4Pnl3L++RJ
 MccO9DCNP2y3NDdaqDCHButXd0ya9M9eb0a5DCcuIey5LkAIanpplyHkbuGx+Gnya68S
 eb7g==
X-Gm-Message-State: AOJu0YwIxKXuiF6KVp3659JxCrv+p3ZhQaGQ16nJcObroxHXVOlwlpGn
 JfJK2GhRPegu3nzje4UF0h+VYs68qAH9XFBuk62nIlFgNwxKwCqG1lV2TpiUaRc=
X-Google-Smtp-Source: AGHT+IF2tNFW9eK8UTv5s68PzvbbyYPXn0kRif1NVpn9SLDDNEMMuqZ4QrDB6vIzVqGz3Yb2aRoZMA==
X-Received: by 2002:a17:906:507:b0:a38:5a98:3a8a with SMTP id
 j7-20020a170906050700b00a385a983a8amr1814285eja.30.1707285652606; 
 Tue, 06 Feb 2024 22:00:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU2ZlchI3VIK6aCNFEb0aXAydCir687lTS4bJ/uXEBHx591UX6knxUTbYCFo5LIv/CCSDQ+9PJ7GCVEZ7rT0PY3vfSEIOWq7K5SwkzLczioUnndgiIxUT1WekvJlOyJwklpJY0rdsHJiZuLmVXmDwbETyZKbQR6FZEo3j5awRR4MwhmdgL0YDk4fP635wVwlhNJe4LnYog/LqysJR+q3fCw6b5Fs/vcFI2jRIe7bWkxEs+dYF3bpmZ8w1TLXd/9A3vXoc+Ng84ciS+AwG4C9E8Y/63W4ErUVc3Krb2YCnInyCO6dyaO/uRuAr9Zgv6FLxkk6GlqdEyZGTbk82u57bk6RPUNzOBF1Nc27h1C0owA2whojL/RZEGof7Ww0ssQ/S3XTWC74N6d41F25kCyH1f+lEJ3zSIk0oty70mV3oPky5m8yzQigMyFudvxFD/lYYiGZ9ixxC5C3snZ+Smm/A0hkpBwbk0BtMpfWBFeLZe+N9r7w0IqtLa0Z0rQrLbqSwfWxvrJE90RPY79K13FfLXqO/M=
Received: from [192.168.69.100] ([176.176.170.22])
 by smtp.gmail.com with ESMTPSA id
 i17-20020a170906265100b00a38576aefabsm353945ejc.161.2024.02.06.22.00.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 22:00:52 -0800 (PST)
Message-ID: <7ebf479e-271f-42a8-8df0-f124dc481dca@linaro.org>
Date: Wed, 7 Feb 2024 07:00:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/21] i386: Split topology types of CPUID[0x1F] from
 the definitions of CPUID[0xB]
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Babu Moger <babu.moger@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Yongwei Ma
 <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20240131101350.109512-1-zhao1.liu@linux.intel.com>
 <20240131101350.109512-11-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240131101350.109512-11-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 31/1/24 11:13, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> CPUID[0xB] defines SMT, Core and Invalid types, and this leaf is shared
> by Intel and AMD CPUs.
> 
> But for extended topology levels, Intel CPU (in CPUID[0x1F]) and AMD CPU
> (in CPUID[0x80000026]) have the different definitions with different
> enumeration values.
> 
> Though CPUID[0x80000026] hasn't been implemented in QEMU, to avoid
> possible misunderstanding, split topology types of CPUID[0x1F] from the
> definitions of CPUID[0xB] and introduce CPUID[0x1F]-specific topology
> types.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Tested-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> Changes since v3:
>   * New commit to prepare to refactor CPUID[0x1F] encoding.
> ---
>   target/i386/cpu.c | 14 +++++++-------
>   target/i386/cpu.h | 13 +++++++++----
>   2 files changed, 16 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


