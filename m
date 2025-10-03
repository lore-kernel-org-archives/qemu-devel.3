Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0159BCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 20:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4mbT-0004rU-IU; Fri, 03 Oct 2025 16:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4mbQ-0004pD-W8
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 16:42:09 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4mbM-0000Oe-6W
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 16:42:07 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so18203455e9.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 13:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759524121; x=1760128921; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PW5k2zL3fmegA2ZxrF2uAnfp4SXP4L2O5lee8nx3mSc=;
 b=Z4kHaZG74o47zS4K70OWKEGT05GSwH+U5yriQBt6EbGn+dhmxG0SiUsVBznYt01FnO
 68qYQ+MlWj7e+HitCvqGGsfKDYza+BW8CQqdo92frJ3dFzf8lHvEehUkRF/3f7Hg431W
 DyVsPFwgPakGfrBumgqa9OlwBcNEvvsOnj4I0OC8mCoYGjZJGfyOBS/ZCdou9EkujhV+
 VOfyMfau2dBx6bW/lkOTQ85f1WfPDW6Ydpm/a7sXeqpIxVH1EaFbgP2m0RrPOpDvpxvW
 68Xf2VqPtc0zoTFLMzvJh7/q2suGD3D46li9Zhfek/SmDBze/8VaiphmA4SdwGwsYDKv
 2UaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759524121; x=1760128921;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PW5k2zL3fmegA2ZxrF2uAnfp4SXP4L2O5lee8nx3mSc=;
 b=L+SMBCHu7HcLqFITyo+XpW6K070Tw2vFBr14xtO/i0cfK++W5OHQJNr5/KllOGhK+E
 5nULRLLkY+QMawrS0XFGTZo5j8aVrqYaFRBhowET3EHxfdvCczszFUD4eyLbT8aXkA5K
 lal5lUdCzfJxU2rWefyfVepO+Ht/IKsOEVHmJat/KcHTr8dUCEi8bwsMqD4UBlix4RsD
 EbsUdnt4EoIQ2RcV3gn8xsuv7nhi3ezY3YrcH+v6f5CHCPZi0Az0YwYN8ocK3LQvpQ4y
 mPWhedqUVvHMR0WhSKXspT2lUX6lw2KaTrjKx58I8wXlznkX6gwxqi5mGsMx72gxcmXW
 5n9g==
X-Gm-Message-State: AOJu0Yz5Kh8xsikD62CJ0TRLv2QZQhhdAzW6XX/yxZlgXjojeQk98xOM
 fp5vPCXx9qJYiColbLZOF2Mrbm6B6md8tQlNMm/NaIS6SUmENsblXWYAXkk0CLSRGYL0nGOMCTr
 RxGqID0I/TA==
X-Gm-Gg: ASbGncsQPwaWFt2MDBo77ZuxrqYlaxkHNROLoJijaSFO3YSAFtRRebTZ6CVGHWgrC5A
 aF19ohFeuVeheKN32MjtWHo8/CIxIfDN8z17UPUkGKPnRaGDnunbThX44raPT2OhVwMT+jCLvky
 CL8UnIR8fC4hTwCiqVG6cs4CqIX0D1EhrtnRgTic8q56oez/SCBbSmGXWR6YAfhw12B64ZX5T91
 Dle9xYxZ2jnlQzvlV+fOS63j60+Z/8MpwZ1JSMpfeTch8CQuMwxHvf2WmyjxNKDJgFURoFRB+sJ
 jF0jP0pp+ZnbhLwGomyblkSYf0nBot/jQ7f4dXH7H9ySwBnQvO+3nKggKKP17ZEyo0t+0qVwyMz
 r3LwCQGmWfqRjXVb3VjDbXjLrYv7Nh6T5tgGeB11MPrFmPa95SPGwarN7WlL4IovCLAIQxLj3cX
 aALtdoNCiXGmXVSQKH/XKB+UT95EB9JcGxYRVLQ4I=
X-Google-Smtp-Source: AGHT+IHHpUVAOz/kW4FY5inemqoIDxzaObgtHSvRK94Nk1VfVB9QmYTxm3ZfXZPywnWOkC76eMfSUA==
X-Received: by 2002:a05:6000:3111:b0:402:7afc:1cf5 with SMTP id
 ffacd0b85a97d-4256719e6cemr2721575f8f.35.1759524121296; 
 Fri, 03 Oct 2025 13:42:01 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a25dbcsm155655605e9.19.2025.10.03.13.42.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Oct 2025 13:42:00 -0700 (PDT)
Message-ID: <c80928c3-0a54-4cdc-858f-b2ac4670e38d@linaro.org>
Date: Fri, 3 Oct 2025 22:42:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/17] system/physmem: Remove cpu_physical_memory
 _is_io() and _rw()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org
References: <20251002084203.63899-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251002084203.63899-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 2/10/25 10:41, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (17):
>    docs/devel/loads-stores: Stop mentioning
>      cpu_physical_memory_write_rom()
>    system/memory: Factor address_space_is_io() out
>    target/i386/arch_memory_mapping: Use address_space_memory_is_io()
>    hw/s390x/sclp: Use address_space_memory_is_io() in sclp_service_call()
>    system/physmem: Remove cpu_physical_memory_is_io()
>    system/physmem: Pass address space argument to
>      cpu_flush_icache_range()
>    hw/s390x/sclp: Replace [cpu_physical_memory -> address_space]_r/w()
>    target/s390x/mmu: Replace [cpu_physical_memory -> address_space]_rw()
>    target/i386/whpx: Replace legacy cpu_physical_memory_rw() call
>    target/i386/kvm: Replace legacy cpu_physical_memory_rw() call
>    target/i386/nvmm: Inline cpu_physical_memory_rw() in nvmm_mem_callback
>    hw/xen/hvm: Inline cpu_physical_memory_rw() in rw_phys_req_item()
>    system/physmem: Un-inline cpu_physical_memory_read/write()
>    system/physmem: Avoid cpu_physical_memory_rw when is_write is constant
>    system/physmem: Remove legacy cpu_physical_memory_rw()
>    hw/virtio/vhost: Replace legacy cpu_physical_memory_*map() calls
>    hw/virtio/virtio: Replace legacy cpu_physical_memory_map() call

Series queued, thanks.

