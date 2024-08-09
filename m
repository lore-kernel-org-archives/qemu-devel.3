Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B654EC52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 08:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scL6b-0008Hl-3C; Fri, 09 Aug 2024 04:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1scL6T-0008CS-Sn
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:36:06 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1scL6R-0001Qh-Tn
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:36:05 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-428243f928fso17597345e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 01:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723192562; x=1723797362; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RmPnqqIvpdZM4vhUuidGITgg4c+/KkmwE6KbcUE8uOE=;
 b=oJUQFGyVm/pK3PgeJ13aNKYMmuSQoJzZ/oMYeaIX4+VzAq+l/vtKwetsz1Rc5UI518
 7PbUa8hHJa/sr2juBiY0rFPD5IXHj+gLhUcrcknboiCghVhrlRDaPw8B3LERh0RyEbkX
 hWhFa20e71XTz/cqmPnw5/82psC8OZb+FuUcWYEQLEh2TIIMTz+O7+W+58XW/GDOBNTe
 nN1vF70QqgEJtejsmEWyvQ7ZhG89JkJzI/om9j4hIXdGqVL59d4vdXq4k6dKdhTrVsKz
 e2WBR1ZtOR8hXSUl/WW/m+l7UqfEEi2Hg6fzOdOv+EE9XH7jSJzpZab2WfnXCHYni/Cq
 WvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723192562; x=1723797362;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RmPnqqIvpdZM4vhUuidGITgg4c+/KkmwE6KbcUE8uOE=;
 b=W4SEarJdwaLxODkhRwFljrE+qapHqW76/NoEneuaICvfQZe6wkgw5o4GgAoDc8G6dL
 B6xvhpGNwy5Buoj0SaDNwbA/e5+fq2HH+fu4ytN+T03kF4So0oEdfACNzAGnLqRXSrzy
 kQnHgNK9r6JRsLXYsGG5o6oq/2oMpEc/zm7ppfxhUkwWBqfJA6Efme02jJxRWg3rQVOZ
 EnDfUtzNFdP0PcIDMHj4VXPWqxJIq5o9H9uFrJ8ddTyhDdiltxybEJTFgwXF4oWBNOWc
 w/t3jq6d5ifiNV/O6Y4skl4gW4m9qxfotUAvamfwmm7FEvVSxl0Rn1SjhW+QC3JCLFVR
 RApA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo+YqKElgrynspOb9ND9x6g7Az/VoBfSR7aLUDpYR8IijfGJ01YfwwR8+lTwcOVrwj0leYR2mIXVyUtTAQP7QRocS0jyU=
X-Gm-Message-State: AOJu0YzK6BhCyCtz7GcG0s7YhftItAE/TzD5l/fCGp2RlgKwSIB5Yg2i
 gV4C2HT7lUjovMbT4trBXbwPn6XdSTylSXFvqFJ4BRbXG2sa8bTG8hZyGk9JNEw=
X-Google-Smtp-Source: AGHT+IEa3cisiuaD0zuqPELtHiYuT/1QmPpy3KQHu8b3fcyhdByakMcRk0FZJDOOY6bwpRsFOFsvvg==
X-Received: by 2002:a05:600c:a48:b0:428:fcb:962 with SMTP id
 5b1f17b1804b1-429c3a5c30fmr6542285e9.36.1723192561442; 
 Fri, 09 Aug 2024 01:36:01 -0700 (PDT)
Received: from [192.168.178.175] (41.red-95-127-42.staticip.rima-tde.net.
 [95.127.42.41]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429059714d5sm117810195e9.13.2024.08.09.01.35.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Aug 2024 01:36:01 -0700 (PDT)
Message-ID: <8913b8c7-4103-4f69-8567-afdc29f8d0d3@linaro.org>
Date: Fri, 9 Aug 2024 10:35:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kvm: replace fprintf with error_report/printf() in
 kvm_init()
To: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-trivial@nongnu.org, zhao1.liu@intel.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20240809064940.1788169-1-anisinha@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240809064940.1788169-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Hi Ani,

On 9/8/24 08:49, Ani Sinha wrote:
> error_report() is more appropriate for error situations. Replace fprintf with
> error_report. Cosmetic. No functional change.
> 
> CC: qemu-trivial@nongnu.org
> CC: zhao1.liu@intel.com

(Pointless to carry Cc line when patch is already reviewed next line)

> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   accel/kvm/kvm-all.c | 40 ++++++++++++++++++----------------------
>   1 file changed, 18 insertions(+), 22 deletions(-)
> 
> changelog:
> v2: fix a bug.
> v3: replace one instance of error_report() with error_printf(). added tags.
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 75d11a07b2..5bc9d35b61 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2427,7 +2427,7 @@ static int kvm_init(MachineState *ms)
>       QLIST_INIT(&s->kvm_parked_vcpus);
>       s->fd = qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
>       if (s->fd == -1) {
> -        fprintf(stderr, "Could not access KVM kernel module: %m\n");
> +        error_report("Could not access KVM kernel module: %m");
>           ret = -errno;
>           goto err;
>       }
> @@ -2437,13 +2437,13 @@ static int kvm_init(MachineState *ms)
>           if (ret >= 0) {
>               ret = -EINVAL;
>           }
> -        fprintf(stderr, "kvm version too old\n");
> +        error_report("kvm version too old");
>           goto err;
>       }
>   
>       if (ret > KVM_API_VERSION) {
>           ret = -EINVAL;
> -        fprintf(stderr, "kvm version not supported\n");
> +        error_report("kvm version not supported");
>           goto err;
>       }
>   
> @@ -2488,26 +2488,22 @@ static int kvm_init(MachineState *ms)
>       } while (ret == -EINTR);
>   
>       if (ret < 0) {
> -        fprintf(stderr, "ioctl(KVM_CREATE_VM) failed: %d %s\n", -ret,
> -                strerror(-ret));
> +        error_report("ioctl(KVM_CREATE_VM) failed: %d %s", -ret,
> +                    strerror(-ret));
>   
>   #ifdef TARGET_S390X
>           if (ret == -EINVAL) {
> -            fprintf(stderr,
> -                    "Host kernel setup problem detected. Please verify:\n");
> -            fprintf(stderr, "- for kernels supporting the switch_amode or"
> -                    " user_mode parameters, whether\n");
> -            fprintf(stderr,
> -                    "  user space is running in primary address space\n");
> -            fprintf(stderr,
> -                    "- for kernels supporting the vm.allocate_pgste sysctl, "
> -                    "whether it is enabled\n");
> +            error_report("Host kernel setup problem detected.

\n"

Should we use error_printf_unless_qmp() for the following?

" Please verify:");
> +            error_report("- for kernels supporting the switch_amode or"
> +                        " user_mode parameters, whether");
> +            error_report("  user space is running in primary address space");
> +            error_report("- for kernels supporting the vm.allocate_pgste "
> +                        "sysctl, whether it is enabled");
>           }
>   #elif defined(TARGET_PPC)
>           if (ret == -EINVAL) {
> -            fprintf(stderr,
> -                    "PPC KVM module is not loaded.

\n"

Ditto.

" Try modprobe kvm_%s.\n",
> -                    (type == 2) ? "pr" : "hv");
> +            error_report("PPC KVM module is not loaded. Try modprobe kvm_%s.",
> +                        (type == 2) ? "pr" : "hv");
>           }
>   #endif
>           goto err;
> @@ -2526,9 +2522,9 @@ static int kvm_init(MachineState *ms)
>                           nc->name, nc->num, soft_vcpus_limit);
>   
>               if (nc->num > hard_vcpus_limit) {
> -                fprintf(stderr, "Number of %s cpus requested (%d) exceeds "
> -                        "the maximum cpus supported by KVM (%d)\n",
> -                        nc->name, nc->num, hard_vcpus_limit);
> +                error_report("Number of %s cpus requested (%d) exceeds "
> +                             "the maximum cpus supported by KVM (%d)",
> +                             nc->name, nc->num, hard_vcpus_limit);
>                   exit(1);
>               }
>           }
> @@ -2542,8 +2538,8 @@ static int kvm_init(MachineState *ms)
>       }
>       if (missing_cap) {
>           ret = -EINVAL;
> -        fprintf(stderr, "kvm does not support %s\n%s",
> -                missing_cap->name, upgrade_note);
> +        error_printf("kvm does not support %s\n%s",
> +                     missing_cap->name, upgrade_note);

Similarly, should we print upgrade_note using error_printf_unless_qmp?

>           goto err;
>       }
>   


