Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E973D4660D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSDi-0006SN-OA; Thu, 15 Jan 2026 13:37:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgSDe-0006Pp-Sd
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:37:19 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgSDd-00024f-4s
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:37:18 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-81f4a1a3181so661737b3a.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768502235; x=1769107035; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jfz1OQlalvKRzpoOhyofzbjWnEFY6szucxGkxT6mAnM=;
 b=C6CYZDiXJjfmpiYWbs0F44UorrpwxtHRdiav2da+o2rtmkTE7Zdi3+rWHtk8hYgWEQ
 2AfwMKOg6NRiKa0ZBQJEq+Sas3z6LAx6iqQ+fjRxLoh2hlnMuJd6SSs16g3tTvf84+BA
 c5h2OsOL4KxqQKSoUshe+SJE/XU1dm7SC6SukOVohtqXSiKrhNmNjZwOOmdnT+ZpIFTm
 NHBSkYWJx+kRcPQS4E28vBQrqLCFSRPtSLZMpCY88zFpeD5J68YDiU2E2BlcJ3PvaAkE
 CEME0/K6T7uhfoS6pFP+veqxgc2UQc/cf2LUvr+uJWj7GKAY2rpRY8TgcUbgaDg0ArBt
 v+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768502235; x=1769107035;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jfz1OQlalvKRzpoOhyofzbjWnEFY6szucxGkxT6mAnM=;
 b=DvxCLKAq3wQNSobMrhq5A+kyXjfruyMTed+HIxFOn6wlLHMnI2Yew7ozfl2GgiAvzq
 3a1tXaQEsUX9jf2/XWIGwEzdekfNqoDDnxsh9E3vNRk8nv8ueYAT8Y7Lvoh/cHxnKkhD
 H4PYmNubRDJdutkVM5M3f9cqBgA6tAgaQqoQmifuHBxV5TWnlkEjCAbswClzAs410hIB
 PMmqk1fr3CGzazTrguCBuwqn8vdkz2OqEUazoYe3MmhzVXBj9imW0lGC+JXsBjrmDEEG
 LuoALcAV4F4f49obgEx10Vut2Bpiyx+GNh3SvPaEgBCwhgRdggtoiTLRE+qKOA9FU+Xb
 rNcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl6P6GuPRgkzNkmzfiRUAfQcp13FiKHKs9VSzW9jWlHHcPv9Jou06Rq45fkgPKsBCvxjE0h0OEtVZg@nongnu.org
X-Gm-Message-State: AOJu0Yymj0tF03XPUvUXrKdqCqAh73cEyqeeUQ0xe6Tv/h5Tw6sSEsUX
 Hluyojc03ypo5D46p2u435uv34NtudV4Jmmi7fqMTkwhdpZ+gcaQBaOcPNCrJwciFP4=
X-Gm-Gg: AY/fxX4PBnI31bvBzeWyvg6qVZ1F+gIbTZJQq4WiV4QGzF8NrgRIUN/6LQs2JoNqvbR
 dC8lEzvfOe5spQzecEUGGm6bxICHp6PBMeCMkRFj0SPTge5OU9VzZEPkkjA2HLZ6sJCdDqgBAYl
 Z1dny9S+xv2P6w1059+zzkDfEsilUw5TncLvuVavQ939EQ6efZXxAHNlE1gLPstHf7F9ag/ugkS
 VE2ORawYpQh5LQtEplrLJE7ph3bPHbgWi15f5HTtTPUgulQIo4KBQdRgY2qYnODf4hERIH427sO
 RDlwL6AlwpM+9+xo00P0HSDgoc7YV8U+Cqy1XAD3S3rAvYyRaQRJlPguMA2fC5xO2zhpiNTJ8To
 goQkWXXqUqYG2pEpDhL6IfEWMdiOoLGnF88tt1flrGy/cNbJywK68p6QJElnwm+2mR9ya3Pqf26
 0oba3qWkq2YgNPZfCS0Pw36V2s9guyNUDXFAhDQcStphty/EWOXgY2JzAy
X-Received: by 2002:a05:6a00:288d:b0:81d:a1b1:7321 with SMTP id
 d2e1a72fcca58-81f9f69001fmr512292b3a.13.1768502234641; 
 Thu, 15 Jan 2026 10:37:14 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa1277a15sm84471b3a.42.2026.01.15.10.37.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 10:37:14 -0800 (PST)
Message-ID: <f1861bf5-0988-46be-a903-846e0f573743@linaro.org>
Date: Thu, 15 Jan 2026 10:37:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/nvmm: Fix 'cpu' typo in nvmm_init_vcpu()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, qemu-stable@nongnu.org,
 Thomas Huth <thuth@redhat.com>
References: <20260113203924.81560-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260113203924.81560-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 1/13/26 12:39 PM, Philippe Mathieu-Daudé wrote:
> Fix typo to avoid the following build failure:
> 
>    target/i386/nvmm/nvmm-all.c: In function 'nvmm_init_vcpu':
>    target/i386/nvmm/nvmm-all.c:988:9: error: 'AccelCPUState' has no member named 'vcpu_dirty'
>      988 |     qcpu->vcpu_dirty = true;
>          |         ^~
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Thomas Huth <thuth@redhat.com>
> Fixes: 2098164a6be ("accel/nvmm: Replace @dirty field by generic CPUState::vcpu_dirty field")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Untested.
> ---
>   target/i386/nvmm/nvmm-all.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
> index b9bd9ed985a..f808828d492 100644
> --- a/target/i386/nvmm/nvmm-all.c
> +++ b/target/i386/nvmm/nvmm-all.c
> @@ -985,7 +985,7 @@ nvmm_init_vcpu(CPUState *cpu)
>           }
>       }
>   
> -    qcpu->vcpu_dirty = true;
> +    cpu->vcpu_dirty = true;
>       cpu->accel = qcpu;
>   
>       return 0;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Regards,
Pierrick

