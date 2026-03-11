Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6171062884
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 12:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0IXR-00037H-8G; Wed, 11 Mar 2026 08:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0IXK-000324-PY
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 08:19:40 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0IXH-0000gq-Vy
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 08:19:38 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4852e9ca034so44227015e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 05:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773231573; x=1773836373; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O6WL7n2lZWIlopN9pyeCds9GwqGQldditjBBii5Hlyo=;
 b=dkGQ0RNeiguRcFZvqqm5lyENt7iEaX+FjkXCYTAC0D2p0dXX5OpbJRtOGelEhQCfBZ
 ZBwz2S2jfLMH4dRyaRSA6CA42jpruj3oiIpE8b3yEAc6mjvfWAzi8B2xQgJfS5mHjlqr
 +pYmuIy5ohK+DMNKdgB0FVpmSlYyhKVq9qkATbZk5GVPRFTUxb7qSB5ik2+/cj3yRE/e
 5v5Dby4saszpE3iTN06v0JiVA+nN8FTJb319Qn+G+XK6+IcrCJKGnceVDHLdilDjt3g2
 RPkGxm0jHjhy11zRW8bvcZZhka8sSHG99WO4twSuDSAP484zzUwlRdELB+E27aTjMAis
 +oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773231573; x=1773836373;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O6WL7n2lZWIlopN9pyeCds9GwqGQldditjBBii5Hlyo=;
 b=tNHjukZmUme6qKGDrAwmO5RXPM9fdzGw5329Gm0lLUcmWtd1cnEI/dfSrXu/gN93GS
 s0JCNjDpcjiwA7j6qAE27xNXsSIzz7gbam0q2kp4ZS0PnRuuJpzN0a9zwy3qGat73ZCm
 h7kP1ESWO2CGG1OpwDPTWM4VS2XtETaqvHKfj4MiCYQHDBz2abP99EBZcMa8konUKjiA
 J5iajV4788qeWxK9f+Er0U0dFJ3POxF7sib2TYnbh5u167QYVesWnCDfo/Mbw0YlabaF
 ex7DlauDCUuqr9t3+44MQZldgmbn1l/55ZhVIHIkK0ILfZ2o5AV5sewZDDTQDq8rXu+C
 KOPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8Vp0C/SO6fnbUfqcjcJ7Q2R3Eg3J4A8k2xJVr1cPWL4DYuXk3JYnSb6RRpNs99fSL9MdDD2EH83sr@nongnu.org
X-Gm-Message-State: AOJu0Yxgj44fZK6c2CvR9fwfetCXkjev2JmzKXE6weNJvfZt+cQ+jlZl
 4kunAil0Ff5bRRAzEheCkfHROzEV3kYoQCvMlz6MIlYMOhitMjJOYcAuLnoJibvG+q0=
X-Gm-Gg: ATEYQzxl3z27rr2HHksAvFS+ry9UCEHl+NB4WU0Sj4ySEPz2zkBxWGpfcrbf3jB9JJL
 pJcVeCZuFDBNBnmzPB8LGK43bytNjgDt89c3cAKH+rgze1aCNMKDO5UEnwxAdHVjABUQDjaN3dL
 G4cir6xloGw1Aiutj3IOVIZNqovsQyupnLMtwKpZQfskzSvzf3JS4x17Ib5tklpp0GT1+jDVd/N
 lQQ0FP1tjvGu2cLFQGuYWKEb499ue3gC5GPvDHXTKzas6F5OzP65U9z2TOlPCtJZnLGo8ix0QYI
 dSNXf8rXim5F0K+nWbSKYLKPbITxeR1rBRuubmXCBBy0jhf2QObpajVebrr/CwTq6cf3zg75dQq
 F/M4Xn/7htX/9lYHbZ1An3+rC6vFj3d4TBNlrhSsEZLB7qgqn/S5CTcInbna8ReCeL/IXm1thIe
 ATZX0tSvDjNDMOynB31dmQxPybxBUgabY2tPulgDu3nh4y1MDc+LL3ChZXi1Ki8+jiKw==
X-Received: by 2002:a05:600c:1d0e:b0:483:7020:864 with SMTP id
 5b1f17b1804b1-4854b109ebbmr39501345e9.25.1773231573346; 
 Wed, 11 Mar 2026 05:19:33 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854ad5416bsm40901365e9.1.2026.03.11.05.19.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 05:19:32 -0700 (PDT)
Message-ID: <10764d13-1e18-4ee8-9a6e-64eab71d1305@linaro.org>
Date: Wed, 11 Mar 2026 13:19:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] system/memory: Fix subpage endianness for
 big-endian targets
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260311115910.564481-1-djordje.todorovic@htecgroup.com>
 <20260311115910.564481-9-djordje.todorovic@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260311115910.564481-9-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/3/26 12:59, Djordje Todorovic wrote:
> The subpage memory region wrapper dispatches MMIO accesses through
> flatview_read/write, which re-enters memory_region_dispatch_read/write
> on the underlying device MR. The inner dispatch uses size_memop() which
> strips endianness bits (effectively MO_LE), causing adjust_endianness to
> apply a byte-swap for DEVICE_NATIVE_ENDIAN devices on big-endian targets.
> The outer dispatch's adjust_endianness then sees matching endianness
> (MO_BE == devend_BE) and does nothing, leaving the data incorrectly swapped.
> 
> Fix by changing subpage_ops from DEVICE_NATIVE_ENDIAN to DEVICE_LITTLE_ENDIAN.
> This matches the implicit LE semantics of size_memop() used in the inner
> dispatch, so the outer adjust_endianness correctly compensates with a
> second swap, yielding the correct net result.
> 
> For little-endian targets, DEVICE_NATIVE_ENDIAN already equals LE, so
> this change has zero behavioral impact.
> ---
>   system/physmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index 2fb0c25c93..5d917482eb 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2929,7 +2929,7 @@ static const MemoryRegionOps subpage_ops = {
>       .valid.min_access_size = 1,
>       .valid.max_access_size = 8,
>       .valid.accepts = subpage_accepts,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_LITTLE_ENDIAN,

NAck, this likely break big-endian hosts.

>   };


