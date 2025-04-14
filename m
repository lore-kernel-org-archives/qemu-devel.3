Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A28C369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 16:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4MXw-0005KL-W3; Mon, 14 Apr 2025 12:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4MXr-0005Jf-VJ
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:20:28 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4MXm-0002Ic-RR
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:20:27 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso43553025e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 09:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744647620; x=1745252420; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6FU/p5lG64FvUSS60mxXpqI9om+F3obJIzSVaFXWLoI=;
 b=abHOZegUNF6DBrPOv/D8PaOjKy5JbszKAWPJQ9P1KdTmOYKJqZL6H1uZnF8KHVB7BF
 3qlaJpBGpHEgyw0gFRM6yHavmSoxQbJHEqkG1KnNnGHF61/YZnXvD22FF1pHT4PLBGhf
 zK4lQwgGtAgcDEp0e78loiTU2DGupiGlrpsyjQUvXbmYBE90S9J+y/DgXtKQI1IRum99
 jToZLVG2X5QFpSu5O3UmV1PfMxCo+KH3hQzDAHOxiZ9wBE/KURdV8AzkGbmIiNd/8FVr
 iNnEYOGiEvEK0b52BCT9o00P5cCrA+XizQ2OLE+fxRzhgPv+cQLQmkgSfwj1ixtbHVQY
 ZPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744647620; x=1745252420;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6FU/p5lG64FvUSS60mxXpqI9om+F3obJIzSVaFXWLoI=;
 b=s2as98f28Lc0Hu0QTyHnAM3kE2boPwq/2rTFIdefgSm4EXQG7zj/s8T6SikYBA8OWP
 jZ9pcqJ7qY6aZmGMqPFLpNduemUBzkPQ4sAs7Vr+dcepg7NGhNP96+6FX/ki+JjUZgma
 VNDNZswcSaLmMvp9PAXcLMPtQB8/7dF8oVs62pynW1gdOh1TGnbTwhB5yy2d8EsrGUUj
 0yje+kV142pULZHznzaG55kOPXxfjStfxoA0ppCvAUOAl0XHOgjKyoR/qKS+4/JUeAqu
 741dhJlsY7CRif7vFQeGlG7S8lfxaZFxSQaM3QP4b4uBlDhBrbIsXNVQMXK1tCWk1uzS
 yNoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYHYuCFTgofrh5lgPQ2LtYSPrQcYqMPAO87dH9lj4pN2+iT0IPNyE+BTI4+cteoLn6UAEtqXGs/uVn@nongnu.org
X-Gm-Message-State: AOJu0YzQbpRyCSjW1OOz94Kw+8JIWOzRj4+kOjTpuSp2PxqxTZMFD/en
 F1b3qLdjgH8rmmeLsoDIuSKtU3MLlj/pVCFO0A9Is7gmB/qFew3ZOpXucYK8H9Y=
X-Gm-Gg: ASbGncuCvrdhPukozwhE+0vhyulwqAsfQgMS/t+VzxnijGI3n95LqtC+cr4N5mSgHy4
 wTq+jsBY2OyROo+8ffrOyMdmH4pARoDpzLhoyAt9ZcoSFNPo59WqBJ0HQi4Dlqk2oYCY2ZafPLx
 PU4QZa6CKw4t1qz2/2Xz8KPNzZzSmN/wtkQWRP86kuYLzhz+B2nkkWDiSAN6K27aPu/U61MGJ4u
 DDx1DUGzBkK0Gc4LiN8xENVLOeRwbwZKSgdirT7kc7ejx9q1KsSOt29jPrhyN2x2RZgQ1i0wybf
 3NfYVBw9f3ARPu0TAHaBsYThmwg3McoOjmTfKQbWIRurLwhUE5BqF/Q+IJ4nrxohsGOSfbhE/7l
 iOPRRBgcR
X-Google-Smtp-Source: AGHT+IG0kqvK/Ay7IwWx7v4CDUglA8/weFLFvGInbf1sOOmwlbqv+kxzIVR1x9Ijp6PO6z2favpQLQ==
X-Received: by 2002:a05:6000:4202:b0:39e:db6a:4744 with SMTP id
 ffacd0b85a97d-39edb6a47a3mr571970f8f.32.1744647620167; 
 Mon, 14 Apr 2025 09:20:20 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43cd69sm11298216f8f.80.2025.04.14.09.20.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 09:20:19 -0700 (PDT)
Message-ID: <2b1665eb-2a0d-4515-8203-621e15c91d81@linaro.org>
Date: Mon, 14 Apr 2025 18:20:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/s390x: Remove the obsolete hpage_1m_allowed switch
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
References: <20250414132914.250423-1-thuth@redhat.com>
 <20250414132914.250423-3-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250414132914.250423-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 14/4/25 15:29, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The s390-ccw-virtio-3.0 machine was the last one that used the
> hpage_1m_allowed switch. Since we removed this machine type, we
> can now remove the switch and the related code, too. This allows
> us to get rid of the get_machine_class() hack and the big fat
> warning comment there.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/s390x/s390-virtio-ccw.h |  4 ----
>   hw/s390x/s390-virtio-ccw.c         | 35 ------------------------------
>   target/s390x/kvm/kvm.c             |  6 -----
>   3 files changed, 45 deletions(-)

> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 370b03a0b97..a4fe1e47150 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -746,39 +746,6 @@ static inline void machine_set_dea_key_wrap(Object *obj, bool value,
>       ms->dea_key_wrap = value;
>   }
>   
> -static S390CcwMachineClass *current_mc;

Wow, good cleanup.

> @@ -883,7 +849,6 @@ static const TypeInfo ccw_machine_info = {
>   #define DEFINE_CCW_MACHINE_IMPL(latest, ...)                                  \
>       static void MACHINE_VER_SYM(mach_init, ccw, __VA_ARGS__)(MachineState *mach) \
>       {                                                                         \
> -        current_mc = S390_CCW_MACHINE_CLASS(MACHINE_GET_CLASS(mach));         \
>           MACHINE_VER_SYM(instance_options, ccw, __VA_ARGS__)(mach);            \
>           ccw_init(mach);                                                       \
>       }                                                                         \

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


