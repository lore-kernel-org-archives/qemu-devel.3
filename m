Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BA7E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 23:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVf1s-00067D-9T; Wed, 08 Jan 2025 18:00:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVf1r-000673-LZ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:59:59 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVf1p-0005Ml-Td
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:59:59 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ee51f8c47dso449359a91.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 14:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736377196; x=1736981996; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cQjoxCUBO+brTplAr3dg/SqbyST4xY9NjFAKmJkICCU=;
 b=BIHb6Wh4zCn+ZpMLvLDWzzNmHsCVmHGtYNGsTue78w1mfrSWB5VPVB8usgH9e2Qd5g
 CXkxuN6LwGfiSzXuDKnvgx2qcTdDHRiu0NRGZMuHeZNrD+3BOlhp9QDgM66yuJpk0DQH
 13XHt24CR2QtkQbot7Uk12j6z9m8rUrczpG/wMCAkQ8dWFeF/5zuBOwXRvvWx7IcWjBt
 mNtgWKpx7L72bxta5/nGAhYawVu9sPcSNPI1RVUQDpbIAgecjJ++HEjMFJt8KJ94JKm1
 0iVwJIrCSTyZWyR43KXAarh/eaOdL5x/90iPV+eVXTFxo2TPFhr7gkj944o9L1JAlkMH
 +8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736377196; x=1736981996;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cQjoxCUBO+brTplAr3dg/SqbyST4xY9NjFAKmJkICCU=;
 b=NdHIniLfaOXV3bV1xqUdxaRvPibLxCBShrUUqIwOf4LCgtemS9HrbXQ6Px1k2Q0Fte
 q6zTbnO87n5dTJCBhpuPzO9+vEXFdaCZhzI/b7NIldrfe0XM1A2ksSv7i4NFIgsH1cC+
 2sGsL1c3BorATbKkQyKYO40ECf1x+BoV0m2qWDPZk/TUlQW5yxqY5mgemIdOcJx9KMBc
 Yu6ZL8IzP2EMcUDe70gX8YfYqjt1g1YRbds/m0XJbWXbqSJ/iFRyDvYZQJvxUkhykWj4
 A5BfX+s4hgXOokyWb9RXB5HDvkMBKOKJEG14CfKet0UqgJDNlgS9PJxXakQ4MOqEKEji
 R/1A==
X-Gm-Message-State: AOJu0YxhiMY0JAn4pm/fwH+WXPp9KkegFcILpyxfJ+Df6pO2rZlbrmMg
 6CFrmqAVKsSHVJAtGkFohr+wHnoh4xaZrGgMtzEChoyHTeG4LzCSXyB8yZwMCp7plZuyvRniAAU
 o
X-Gm-Gg: ASbGnctaWqq4qzvTtVgeMh9Yb4m08wN71c8VrsULTQU9QkQ3+BwdsX4KYTIVW1JJAIZ
 +NiDZZl9aRtpzAmmWYhbRzveH8/uq0UpUCScsn6hios9zGFrTfhEximYhlQmrlR0vVWH7L2VOvz
 7/ap9sGHwoDTV5w4eFZYmEp6YsCV3QiH5JEG1YAN3PFGB/r9JLZx2N2U135onClZjxvyHW3sfEk
 sjrcKJ0SynRa7+JIHTZCIZj2ct9Z98Dwei53pln4/ze4DX97Cl7fxUa0nsucIrxLHKq1yhDOjhz
 tuvjU0fEjUoiPiT+8mM9exl9x9DDXCA=
X-Google-Smtp-Source: AGHT+IEg9Ckq20Zu3YN/ufV1BYs5YUUkuuYfQdWrHLMARW22Ki+6j05XhLyuOlV44flHGfpueJ5qKg==
X-Received: by 2002:a17:90b:270d:b0:2ea:3f34:f194 with SMTP id
 98e67ed59e1d1-2f548eae587mr7062514a91.10.1736377196258; 
 Wed, 08 Jan 2025 14:59:56 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f54a26ad59sm2147415a91.2.2025.01.08.14.59.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 14:59:55 -0800 (PST)
Message-ID: <f36ec87d-d384-4671-a80e-27d4ad4fe7b3@linaro.org>
Date: Wed, 8 Jan 2025 14:59:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Add missing /proc/cpuinfo fields for sparc
To: qemu-devel@nongnu.org
References: <Z37rL5jVYpOk6ufc@p100>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <Z37rL5jVYpOk6ufc@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 1/8/25 13:16, Helge Deller wrote:
> Add some missing fields which may be parsed by userspace
> applications.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/linux-user/sparc/target_proc.h b/linux-user/sparc/target_proc.h
> index 3bb3134a47..172d089fed 100644
> --- a/linux-user/sparc/target_proc.h
> +++ b/linux-user/sparc/target_proc.h
> @@ -8,7 +8,23 @@
>   
>   static int open_cpuinfo(CPUArchState *cpu_env, int fd)
>   {
> +    int i, num_cpus;
> +
> +    num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
> +
> +    dprintf(fd, "cpu\t\t: TI UltraSparc II QEMU (BlackBird)\n");

Obviously won't match with non-default cpu.

r~

> +    dprintf(fd, "fpu\t\t: UltraSparc II integrated FPU\n");
> +    dprintf(fd, "promlib\t\t: Version 3 Revision 17\n");
> +    dprintf(fd, "prom\t\t: 3.17.0\n");

Do we really want to pretend with any of these?



r~

