Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13574FC6172
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 20:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spCkS-00009D-54; Fri, 13 Sep 2024 16:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1spCkP-0008Rz-O8
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 16:18:29 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1spCkN-0008Hx-5K
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 16:18:28 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42cbaf9bfdbso11932555e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726258705; x=1726863505; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ebwehp/lSk+jZbk9mDPo3sArzN4mbMf7wZKcMwas+7o=;
 b=B3M1GOzJltEWqvx88dfj/l5BB5wE62bJlx03Gr20YzddjTYd/fGnIDBaemQsjSPOWl
 AYvIWe0Do5ZWjyepWdXClJzQ/ENwRj6eRKTr1mUIc0Plvg1kqn8DC3PvEYI3j71YyP5G
 a0Qzi8Xl7btdxQPYvoS2EvpYwCf/KdkGI9yfRRy3k92zrug1TZqooI8VoF7Q65ja7fZ2
 lGEli1gpkcoFxgslesJPTGTU/ZdNi91GmM/efPTSzutu5gNHn6xBkkCJ11mHfvs3QSJf
 9oOOaEm1VcyYO/+kpRTwEwHQAEqCWT2ZyBMDaw1qnbhyMsA0ygZv3z/rKieDy5TshjNd
 SSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726258705; x=1726863505;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ebwehp/lSk+jZbk9mDPo3sArzN4mbMf7wZKcMwas+7o=;
 b=IQgAeyGvm7EvYdVKmALFhoRuF/G+hfWhk3cpvmGG4OKtIa1PuwLwvFFQwbBUkU2tpn
 FGuuiizUKudbU/p8Dz6KbuLYEuXxbbtKqK2MjURUoHJH+MmGvbQN+AE/yf5T3oqzwDPW
 +SUIqRCJipzG1H+k5Z81l3HiwO12PMheAME39/vQmJRx+/aCi/TF70E/936tvs08PfQL
 POZXlqg+QJpLxVyQ09JPxsOL6UnrgtPIZnKufKsMLwWvxqWyB5Reu3qsouvjbogfCA16
 BEajm1bkaStRedamcYtys8xWwIf+ch9EG4uYB+MGZwGbBHLkBCZd16eTNi+T+/xD0Z/R
 Bfig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB88BXeVGLgXituHlr1SlAr8LnMOLYLFOE6PzZ8NWYUqhhKIA9wsCTIDMN+YIUSb5jXM6mDUONZJfb@nongnu.org
X-Gm-Message-State: AOJu0YxW4d6KEGz8vOE49vZY6IcCes7Codz+OO4VRKThoAKfFHnUsq04
 wqliIsi5EWkUUwXVgUOIsvXDpVhT5OPghyAlR3CbdIIk+9dTdt1X0XOw9sOiI88=
X-Google-Smtp-Source: AGHT+IEAdF03eWkplNLpmcAEB/+YRE3Q/KCADlwi+Lk1X5vqFfAWigVFqQqSZhjd/RpZJ8K15baARg==
X-Received: by 2002:a05:600c:1d05:b0:42c:c08e:c315 with SMTP id
 5b1f17b1804b1-42d90827159mr37101215e9.16.1726258705348; 
 Fri, 13 Sep 2024 13:18:25 -0700 (PDT)
Received: from [192.168.69.100] (uni14-h01-176-184-39-243.dsl.sta.abo.bbox.fr.
 [176.184.39.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b054d2dsm36902755e9.3.2024.09.13.13.18.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2024 13:18:24 -0700 (PDT)
Message-ID: <e486fa6d-76c5-48ed-b75c-f7683f026b6b@linaro.org>
Date: Fri, 13 Sep 2024 22:18:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/17] plugins: add option to dump write argument to
 syscall plugin
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 devel@lists.libvirt.org, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-s390x@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Rowan Hart <rowanbhart@gmail.com>
References: <20240913172655.173873-1-alex.bennee@linaro.org>
 <20240913172655.173873-18-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240913172655.173873-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 13/9/24 19:26, Alex Bennée wrote:
> From: Rowan Hart <rowanbhart@gmail.com>
> 
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Message-Id: <20240827215329.248434-3-rowanbhart@gmail.com>
> [AJB: tweak fmt string for vaddr]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> vAJB
>    - tweak fmt string for PRIu64
> ---
>   docs/about/emulation.rst    |  14 ++++-
>   tests/tcg/plugins/syscall.c | 117 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 130 insertions(+), 1 deletion(-)


> diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
> index 72e1a5bf90..647f478090 100644
> --- a/tests/tcg/plugins/syscall.c
> +++ b/tests/tcg/plugins/syscall.c
> @@ -22,8 +22,57 @@ typedef struct {
>       int64_t errors;
>   } SyscallStats;
>   
> +struct SyscallInfo {
> +    const char *name;
> +    int64_t write_sysno;
> +};
> +

static

> +const struct SyscallInfo arch_syscall_info[] = {
> +    { "aarch64", 64 },
> +    { "aarch64_be", 64 },
> +    { "alpha", 4 },
> +    { "arm", 4 },
> +    { "armeb", 4 },
> +    { "avr", -1 },
> +    { "cris", -1 },
> +    { "hexagon", 64 },
> +    { "hppa", -1 },


