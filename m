Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B44D10854D2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3CgR-0001VA-UO; Thu, 19 Mar 2026 08:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3CgO-0001Uv-Fa
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:41:01 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3CgM-0003A2-A8
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:41:00 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43b5bded412so347966f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 05:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773924056; x=1774528856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FGTvOosJtXNlMeBuO8axcw/WeUOXF9VvckBSTDZrdxI=;
 b=QaqHmX/ZMKFdPdMxG+xCdM890z5rYm9sTC/q5+k1uEprUmkuCIwCRH/15oLUiUSwUV
 j+HNwdKCkGT5q17c6m8KfgyPqs5bRDZsfhBnMWJpTX3yW9tBKGuxIIg7JMhSCZBbA2+Y
 brXTm00TBwLPiegjN2DQ8Opvw25Nx2xisnqy8Sw0+Ka8VkIRgAT8bMGN7gCb4ztamdRf
 C3Px8f3D8l5jAGPw5d1Z0STkAsW/XzJMrGtv2T8uxQw0X5+wlR8rGvbt5tmTe0/9r3wQ
 NZAzHzvV4IkO3Y6scyXJ/m4CejkOvQegjHGuv8Tw7AGHF/cScpDbeExcDM73e87Kt3Tr
 Tl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773924056; x=1774528856;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FGTvOosJtXNlMeBuO8axcw/WeUOXF9VvckBSTDZrdxI=;
 b=OOiNMQNGOTORNfvr1Ij7ZLK3ZUIzIa1hPN5eLt2U4Nhg7IH6tTB35eFviiDMXwSZe3
 9F2V7g0erd7i74pqtSOne/15N6ruzwwC62ufFSzeyJ/yLHU83Ja5Ca+DdkmjiKF5dOHL
 YXx2TEH0D9UZLbTaWohg/X06PM3XuSJQ7Ahl6eziC622GN6YD7fkd6uh/ieHGgdIgBk4
 MAsm2AFJAoQ/I8p4V3XhoxvEpZFNE7pzGKCvAGWAmRvXYED7z78aQYzIVUIzKY1ctnIj
 H2imP1BJRjbo+s3btAZzEnwYL+ONRLy1vCI1NGybuslkRPSUudgPF06ZtZ2+1Qvv1sE7
 hceg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqEuqVntlN0JJshIl1yghMlMvj8sRCFy99+VcGkw2ZIUhTUI2L3IL5uGitWCWEpoOI2CisT9fJuEBq@nongnu.org
X-Gm-Message-State: AOJu0Yy2zZgBN8vEAH4QeiHJwb0zITpfqpHlDYOzOUiJ3w2ln+vi6Tfw
 zXgYCzP9s41jp/hX3xMbaQYo9UrHVfywRs/P5LptlUqqtwW7NI3JSiiZZJB+9PGEFSI=
X-Gm-Gg: ATEYQzwSZcZeWZeGVC+DhvWWvc3FG4SLnzDpxtNJVzsEggj9bH4pBcpGsppp0cRZ/E5
 cT2ORX939WPeqMV/yP4L4m8eqlhj3I4WKYrq3DIpG165/TsmfNN1bWIAknTlbxJdRSAG4+y4HaB
 nzPVxtCb2OZyyoeyWAZXv0repJMcLVEw9e0GXbr4BVPyaTVQkDoTVELhetZO1qyku/urqn7zaR0
 /SXi9sPX+jzYwFdQVhIMNKKM0+GnQMbSw4tdw9gcofr1mZXL6Jx0iCLOYcpv3wyknrwAwfHRKSU
 1iUUzz0W4VfxPvopw9WtZynALtV6Np4Jcqtg6CRXTFv52yOEwTo/ffixjhATIajO2dFhuussAeV
 Z2mFyOjuNa3Zlhe+uK5j8d7+YTJPUPY/mPh2BF7Fa5DeEFIk/phfyPhw9cRPNR8JFbBwKrXCZrj
 RZDg3aVsUAaN42TliIh0gKur+nZH5LiHmjCAfRsjxDF9VS+/InJfZhUeaqGrY27Cqt3g==
X-Received: by 2002:a05:6000:381:b0:439:c4f9:31f5 with SMTP id
 ffacd0b85a97d-43b527c4033mr13071186f8f.28.1773924055963; 
 Thu, 19 Mar 2026 05:40:55 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b518a3dedsm14927938f8f.36.2026.03.19.05.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 05:40:55 -0700 (PDT)
Message-ID: <90286161-d1f9-436e-a5e5-d05039a67246@linaro.org>
Date: Thu, 19 Mar 2026 13:40:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 v2 1/2] i386/pc_sysfw: stub out
 x86_firmware_configure
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <20260319122137.142178-1-anisinha@redhat.com>
 <20260319122137.142178-2-anisinha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260319122137.142178-2-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 19/3/26 13:21, Ani Sinha wrote:
> x86_firmware_configure requires ovmf support. Add a stub for this function call
> for cases where OVMF is not supported.
> 
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   hw/i386/pc_sysfw.c            | 31 -------------------------------
>   hw/i386/pc_sysfw_ovmf-stubs.c |  5 +++++
>   hw/i386/pc_sysfw_ovmf.c       | 33 +++++++++++++++++++++++++++++++++
>   3 files changed, 38 insertions(+), 31 deletions(-)
> 
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index d8a86756ca..0a073c4285 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c

We can now remove this include line:

  - #include "kvm/tdx.h"

> @@ -283,34 +283,3 @@ void pc_system_firmware_init(PCMachineState *pcms,
>           }
>       }
>   }
> -
> -void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
> -{
> -    int ret;
> -
> -    /*
> -     * OVMF places a GUIDed structures in the flash, so
> -     * search for them
> -     */
> -    pc_system_parse_ovmf_flash(ptr, size);
> -
> -    if (sev_enabled()) {
> -
> -        /* Copy the SEV metadata table (if it exists) */
> -        pc_system_parse_sev_metadata(ptr, size);
> -
> -        ret = sev_es_save_reset_vector(ptr, size);
> -        if (ret) {
> -            error_report("failed to locate and/or save reset vector");
> -            exit(1);
> -        }
> -
> -        sev_encrypt_flash(gpa, ptr, size, &error_fatal);
> -    } else if (is_tdx_vm()) {
> -        ret = tdx_parse_tdvf(ptr, size);
> -        if (ret) {
> -            error_report("failed to parse TDVF for TDX VM");
> -            exit(1);
> -        }
> -    }
> -}
> diff --git a/hw/i386/pc_sysfw_ovmf-stubs.c b/hw/i386/pc_sysfw_ovmf-stubs.c
> index aabe78b271..b53906a052 100644
> --- a/hw/i386/pc_sysfw_ovmf-stubs.c
> +++ b/hw/i386/pc_sysfw_ovmf-stubs.c
> @@ -24,3 +24,8 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size)
>   {
>       g_assert_not_reached();
>   }
> +
> +void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/hw/i386/pc_sysfw_ovmf.c b/hw/i386/pc_sysfw_ovmf.c
> index da947c3ca4..2f7d15c9f3 100644
> --- a/hw/i386/pc_sysfw_ovmf.c
> +++ b/hw/i386/pc_sysfw_ovmf.c
> @@ -28,6 +28,8 @@
>   #include "hw/i386/pc.h"
>   #include "exec/target_page.h"
>   #include "cpu.h"
> +#include "target/i386/sev.h"
> +#include "kvm/tdx.h"
>   
>   #define OVMF_TABLE_FOOTER_GUID "96b582de-1fb2-45f7-baea-a366c55a082d"
>   
> @@ -160,3 +162,34 @@ bool pc_system_ovmf_table_find(const char *entry, uint8_t **data,
>       }
>       return false;
>   }
> +
> +void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
> +{
> +    int ret;
> +
> +    /*
> +     * OVMF places a GUIDed structures in the flash, so
> +     * search for them
> +     */
> +    pc_system_parse_ovmf_flash(ptr, size);
> +
> +    if (sev_enabled()) {
> +
> +        /* Copy the SEV metadata table (if it exists) */
> +        pc_system_parse_sev_metadata(ptr, size);
> +
> +        ret = sev_es_save_reset_vector(ptr, size);
> +        if (ret) {
> +            error_report("failed to locate and/or save reset vector");
> +            exit(1);
> +        }
> +
> +        sev_encrypt_flash(gpa, ptr, size, &error_fatal);
> +    } else if (is_tdx_vm()) {
> +        ret = tdx_parse_tdvf(ptr, size);
> +        if (ret) {
> +            error_report("failed to parse TDVF for TDX VM");
> +            exit(1);
> +        }
> +    }
> +}


