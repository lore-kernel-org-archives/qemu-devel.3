Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724BDC54E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 17:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhusj-0004gf-5r; Wed, 06 Mar 2024 12:16:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhusd-0004eQ-S6
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:16:35 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhusc-00007Y-7j
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:16:35 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5131c0691feso9279770e87.1
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 09:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709745392; x=1710350192; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MTstlGT/a18Frjz+rGLei+v7kWgyirApdQCesjszieE=;
 b=c4K//9h3X10zlTwcYhfwQ7ZoClvj9zhmdQ2SJl49Ch4SuuN1dJZyAwVeF92lkfJKwN
 0f7mO1etj61cf2UbFQLlsuSNxSkop3Fcmq77/B1xP2D7XgmnaaVfaiu/MWFPH46W3im7
 2B1r04D5lG+geNmpzUwcN6BCF3vLNOpsI7Z+JrYMHaH6UaCcDVs9XzMtsbocoJI3NgYw
 28Bn1RgUpC8MZKEkY1F9ChONfdtfv0jcqAAV/UBc0EuYF1hTZvKG4bENc1kbWJZxCQjb
 vW2vVHlfYclZZEgNG21WMa9VGRHhCA6fyRZagStLh4xUmPB/meGiv5m7jXxdTpr7Q+3o
 QC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709745392; x=1710350192;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MTstlGT/a18Frjz+rGLei+v7kWgyirApdQCesjszieE=;
 b=oUo7nI97woGmjHFCbFX6fLTRp5Cig6eG4yjru7sH3JFV6d+oQwfC+4RTpO8DifCW+b
 ltRa0gmnsgBgrBKfai0cE+hT7wS1w12xhbAV0Pw6Fl7OpVM1t0lu5qPIaDbFCE0VSkzj
 dFWqUd0uHfqwXWw232GSk+SMavAELmtqs/zVuSO2GcVUGqUsJaa/gKu8MGk9EF8P0uhZ
 CVGzl5a2EiEXFGqzC8pleLcblUr7BIk0PARR0On3YCkn9lBukZFTW2ex1pe7H4B90L7o
 XMWyVUM8hFdClc+2PvL6Z/dCY3nz5aDMtCHqVfj1Uh59W1ke73VxA7Y7bsuHf/yFh/Zk
 zeWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNwiLvjZE7dNviGEY7GRW8zUTfbWXdIZ2N4N5X/9y1xxGFk3wX8TCDdNv2npxUTNGrWTS47KfUdp8xxjh1CMmnsv9de0g=
X-Gm-Message-State: AOJu0YxeH7fcePXOnA3w3ON0V+q3gu8O4+8T1qxtLXo4hwJWiVpIudBT
 GqwMOCWK2gSoZby80NDbYnR9yf3xc7rI9WMm7rvRmYQ+G12kwJt9+TvZ21mpIIc=
X-Google-Smtp-Source: AGHT+IEEEm27HQQ1yt59I8k1pXk5Kp9RWbi0wEjybB+XpiWEN9134OAxfJLk1YHC0bnesbA0/Cv8CA==
X-Received: by 2002:a05:6512:1152:b0:513:5203:e255 with SMTP id
 m18-20020a056512115200b005135203e255mr4652979lfg.7.1709745392070; 
 Wed, 06 Mar 2024 09:16:32 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-100.dsl.sta.abo.bbox.fr.
 [176.184.43.100]) by smtp.gmail.com with ESMTPSA id
 m26-20020a17090607da00b00a441ff174a3sm7372337ejc.90.2024.03.06.09.16.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 09:16:31 -0800 (PST)
Message-ID: <6de50dbc-9525-4e25-ba70-55aea0d3f044@linaro.org>
Date: Wed, 6 Mar 2024 18:16:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-9.0 v2 13/19] hw/xen: Remove use of 'target_ulong'
 in handle_ioreq()
Content-Language: en-US
To: David Woodhouse <dwmw@amazon.co.uk>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 Anthony Perard <anthony.perard@citrix.com>, kvm@vger.kernel.org,
 Thomas Huth <thuth@redhat.com>, Anton Johansson <anjo@rev.ng>
References: <20231114143816.71079-1-philmd@linaro.org>
 <20231114143816.71079-14-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231114143816.71079-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

Cc'ing Anton.

On 14/11/23 15:38, Philippe Mathieu-Daudé wrote:
> Per commit f17068c1c7 ("xen-hvm: reorganize xen-hvm and move common
> function to xen-hvm-common"), handle_ioreq() is expected to be
> target-agnostic. However it uses 'target_ulong', which is a target
> specific definition.
> 
> Per xen/include/public/hvm/ioreq.h header:
> 
>    struct ioreq {
>      uint64_t addr;          /* physical address */
>      uint64_t data;          /* data (or paddr of data) */
>      uint32_t count;         /* for rep prefixes */
>      uint32_t size;          /* size in bytes */
>      uint32_t vp_eport;      /* evtchn for notifications to/from device model */
>      uint16_t _pad0;
>      uint8_t state:4;
>      uint8_t data_is_ptr:1;  /* if 1, data above is the guest paddr
>                               * of the real data to use. */
>      uint8_t dir:1;          /* 1=read, 0=write */
>      uint8_t df:1;
>      uint8_t _pad1:1;
>      uint8_t type;           /* I/O type */
>    };
>    typedef struct ioreq ioreq_t;
> 
> If 'data' is not a pointer, it is a u64.
> 
> - In PIO / VMWARE_PORT modes, only 32-bit are used.
> 
> - In MMIO COPY mode, memory is accessed by chunks of 64-bit
> 
> - In PCI_CONFIG mode, access is u8 or u16 or u32.
> 
> - None of TIMEOFFSET / INVALIDATE use 'req'.
> 
> - Fallback is only used in x86 for VMWARE_PORT.
> 
> Masking the upper bits of 'data' to keep 'req->size' low bits
> is irrelevant of the target word size. Remove the word size
> check and always extract the relevant bits.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/xen/xen-hvm-common.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
> index bb3cfb200c..fb81bd8fbc 100644
> --- a/hw/xen/xen-hvm-common.c
> +++ b/hw/xen/xen-hvm-common.c
> @@ -1,5 +1,6 @@
>   #include "qemu/osdep.h"
>   #include "qemu/units.h"
> +#include "qemu/bitops.h"
>   #include "qapi/error.h"
>   #include "trace.h"
>   
> @@ -426,9 +427,8 @@ static void handle_ioreq(XenIOState *state, ioreq_t *req)
>       trace_handle_ioreq(req, req->type, req->dir, req->df, req->data_is_ptr,
>                          req->addr, req->data, req->count, req->size);
>   
> -    if (!req->data_is_ptr && (req->dir == IOREQ_WRITE) &&
> -            (req->size < sizeof (target_ulong))) {
> -        req->data &= ((target_ulong) 1 << (8 * req->size)) - 1;
> +    if (!req->data_is_ptr && (req->dir == IOREQ_WRITE)) {
> +        req->data = extract64(req->data, 0, BITS_PER_BYTE * req->size);
>       }
>   
>       if (req->dir == IOREQ_WRITE)


