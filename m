Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13529C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 18:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tubT4-0002Sv-5j; Tue, 18 Mar 2025 14:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tubSk-0002Iy-Lz
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 14:14:54 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tubSi-0000Ve-UR
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 14:14:50 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso24390445e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 11:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742321687; x=1742926487; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BHwyXtD9sEyyGr5c+FuZRLUFIfG7HhOrVMbvojfaBjE=;
 b=FXH3uJ+M72fQdIoIaB3JHBbAvZ5NxpWlF1vCRNrPy4xbaxqIBpTOeK3PLvMXd2C0he
 j8jVO4fIeFDErpa5u56GHHdyq/fez91FtHYEBBz1QvrrwqdkuUAob/G7ulg/zwgzkSTL
 mCXIl0tMnAWMg/JkPOKrFgAOOkBxzKbjXiy+7KlyMzK499CBwvVYxwD41+ewRwd6X9Zb
 h9xr1JHufD1NFwPGZ3Dg2rWyF9VwkGLQzxvRb+4iaUEoMOBYIOYZJNrvtOw09rUK2G6Z
 fHWxVc08NYPo1BIR7sro5bs//zYHZycDW2v6GBQq8zuBQ3wEgRmKbjkdyw3MrL1syzMA
 oyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742321687; x=1742926487;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BHwyXtD9sEyyGr5c+FuZRLUFIfG7HhOrVMbvojfaBjE=;
 b=ELjpbnIEU3uNiJep/6U8pnt9BT8t6OpppyHzH4mIY9BPQuxptZgig8u8JVpzHCJvPg
 7VOPtoarTRXUFpi5NLfB6mDR6s15NkOPGFYJtovTR6WP4q+gCMZqtVVuNUdh/DKkUhET
 9+p92FGKah0RG2og5S6pzPPqhVkoSIjPp+m4xuoqwDCF2BmGeHCvQtVZKZjcFiHHmS5H
 /RtZ1AMIj97VaeABnfTxD25BzvbELgdHg4Nr7Vr46vZDpa7wbo2tYQWHy/K4VxoaO2sm
 OWepjSfjQWnKgy+CKLLDnP1gHqIQjVaNszkLI1AxyBFXvL25ELA7/ZQDhxC+brSveqTj
 dkBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYBwAUEnI1plhNEBYx0mGsmTKodTWDu0PNDpB7mzVJQsmIBXCFDrsM1/ZU3gHtxIIgbToz86glJmsr@nongnu.org
X-Gm-Message-State: AOJu0YyBy3oMLyZPocKERuKHlaKCbAbOo2VuyrhQ++duVxrdv7y6gii1
 8pv2zGyu4o+R0SUYbF94ZQJFjKExVsER4jMzbx/5P61VmTewEHvjhX7pYQf6XBw=
X-Gm-Gg: ASbGncuzQq0wUkoxIIUgBKsHStEQBdktar58YwhEsUHZTSw1tqXXgirNSe8X0psfVEI
 iDUMeD9Vi9vzbQ9ZYOjEH1n4JFS+F0lWhXw2u5kLp/XIOxuIRnlfuBD8MLJkZyz/XYL9btTeLoU
 FISqYSNpKMmPa9gpZo6tl37k/34EaXH90A9dy19Op/PZLouSS6UlxnujiAz/zTpztsctiudsoQN
 vobwZUKhJn9vvFulC0i41/+mlxfAZRaWnw4txHyC59EURbOIvqHD/fsxGJsQGudOFzq80yy5QAG
 Wt+3G5t3Xg+mmn54az268txI78t5EzXBvg+yAZ0LyZ60bZDgp9gHDBiyGI8ga2X8ItpJ5zChL7w
 SFYmw9Tmrqck/n12RRjNK+FA=
X-Google-Smtp-Source: AGHT+IGjFHimgPwrXJB69701bffChbLD/HEoki8yIc2rRZawW/+t712tZ7qp7WVYQIXal7RK/toejg==
X-Received: by 2002:a05:6000:1f8a:b0:391:2a79:a110 with SMTP id
 ffacd0b85a97d-3996bb57561mr3621625f8f.29.1742321687133; 
 Tue, 18 Mar 2025 11:14:47 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c8975d65sm19100205f8f.56.2025.03.18.11.14.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 11:14:46 -0700 (PDT)
Message-ID: <fa3c4676-f78c-42af-b572-559640c0e4f7@linaro.org>
Date: Tue, 18 Mar 2025 19:14:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] target/arm/cpu: always define kvm related registers
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-8-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250318045125.759259-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 18/3/25 05:51, Pierrick Bouvier wrote:
> This does not hurt, even if they are not used.

I'm not convinced by the rationale.

> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/cpu.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 23c2293f7d1..96f7801a239 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -971,7 +971,6 @@ struct ArchCPU {
>        */
>       uint32_t kvm_target;
>   
> -#ifdef CONFIG_KVM
>       /* KVM init features for this CPU */
>       uint32_t kvm_init_features[7];
>   
> @@ -984,7 +983,6 @@ struct ArchCPU {
>   
>       /* KVM steal time */
>       OnOffAuto kvm_steal_time;
> -#endif /* CONFIG_KVM */

Maybe we need an opaque ArchAccelCpuState structure...

>   
>       /* Uniprocessor system with MP extensions */
>       bool mp_is_up;


