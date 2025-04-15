Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095EBC369B8
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 07:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4aKI-0002gk-0G; Tue, 15 Apr 2025 03:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4aK9-0002fZ-HN
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 03:03:13 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4aK7-00016Y-B7
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 03:03:13 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so4462153f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 00:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744700588; x=1745305388; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gQIZTL9G2c/6upLFkGLhEBR0xC+hQ/0nufe0kTqCXv8=;
 b=ZC+RQcrGo1VuH3dpKVpCLQgiXVWB5dTKdw7uGCNm+7Z4bI+1uggFFyIlxQdNT4321j
 iapxwojsQlevMgRW+MUnRo1Alrdd1ZbHeYOUXSmxrkfhT/ngY7fyP2H/7vXyeQ3UNELt
 FxABc3NdCm4Xix/D5kKS5Kym+U2VkgauVaQpJooqOGsz3jjuNvcLP9FSSdjvZDApfei2
 MaGIzamwkaxU/Qd33/aBjeNLTbTIoe9iEdXKJnueT2TX4cH693uMxmsASm4VZDxFxkIl
 cuXOJNsfhEGfv3h3mIq12JSKI6Zkff3mV/sq0h8gDwhcd7a81EsEB0WnHjpD/Hxb6r8z
 pb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744700588; x=1745305388;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gQIZTL9G2c/6upLFkGLhEBR0xC+hQ/0nufe0kTqCXv8=;
 b=aJzX0ZlKeV/3mQbdcC7H9AGYG8+FEj3ENacsn3jUIhs6Sx5HFtxFsqC2KZvLD4o6D5
 PEzqm8KwPZ4juNVMB7cAf7QYCR+g8p0GZ6gjSfStuS/KvsU3v+Eer6dHCwzIwmELr3GC
 n1GeheiTkyc2IaI3KT695bIdxlBnAcKH6yz4ecvjd88zAiHBTHlGm1JIBCgAlKrsaFcE
 Hf5WV3jUTTXS/qX+ogx+c5SR5rK4l0Uf93gxNkGl3gF4VhkowAOcY2r4DeSQ8eYKCJ9o
 XNun4m3c8PUMyI9Gw30DO2ygs11283j0XXXALiq7CsUQmkCyuwrjSeqBd16PgBpNnBB5
 5Hxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj8bnUB0dWK+4Wt9dVPiPpeun/AbWpx2fG9GPLSkxGaO614Yx9soiSTUJ6GpSp+A7ttgJhhbvHWOy/@nongnu.org
X-Gm-Message-State: AOJu0YyGia5AgPSl0D3GNcyqA46pf/gUVLbCG34T7gb3nVk0VsCJG0iQ
 pql25qP7YYTDn0ymobdgR3NGzd0jEEbIiX/ZF/mQp9Fwa25dmVnchWO1DPfbv2o=
X-Gm-Gg: ASbGncvQbo3vvGDY9oeVL94jy6oUnjhcFTBNWCnAK6p2bsdmO7Yu8xmPK+9nIaIpckA
 KW92F4nfnO1Mh0KicxXeCHlPYue8UzsqOVv3tSoWFo9g2tHXw9PoKV0lWZ3qS9wOpQafHGW3x/f
 bOCeWR3xiNBnSvNHRVheKpBvlnBIcFuQiVSh2qlKJpKQccaBB/1rA+EuFhdIPNVBnH3ketBqDHk
 Jp8VFXZMQdcNS3LNDmzZzhTP9QjW7zHKVG0aaoxu4px4pa+pOmGNrhqnx2MJVeSZvhQrk2LZxiJ
 4dyhsXJoIzG2aReOG/ltaeBq5uH2lrW+jPRZQcNU8fS19phYp6Xx/E7LUh9W/b2qhQEy4DRdAz4
 or6dWU3RC
X-Google-Smtp-Source: AGHT+IFdPTJ8LHSnf9kexPXg9Yw57XSpwMyM9HqLdnmKOqq/iid4dTW/LxIaw775eBPO7mzIdnTsQQ==
X-Received: by 2002:a5d:588a:0:b0:39a:c9b3:e1d7 with SMTP id
 ffacd0b85a97d-39ea634bf9amr10517202f8f.29.1744700587920; 
 Tue, 15 Apr 2025 00:03:07 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf445315sm13165936f8f.82.2025.04.15.00.03.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 00:03:07 -0700 (PDT)
Message-ID: <5f9a4bc5-5569-437f-8e8d-f386dd51e33a@linaro.org>
Date: Tue, 15 Apr 2025 09:03:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] arm/kvm: write back modified ID regs to KVM
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 pbonzini@redhat.com
References: <20250414163849.321857-1-cohuck@redhat.com>
 <20250414163849.321857-8-cohuck@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250414163849.321857-8-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 14/4/25 18:38, Cornelia Huck wrote:
> From: Eric Auger <eric.auger@redhat.com>
> 
> We want to give a chance to override the value of host ID regs.
> In a previous patch we made sure all their values could be fetched
> through kvm_get_one_reg() calls before their modification. After
> their potential modification we need to make sure we write back
> the values through kvm_set_one_reg() calls.
> 
> Make sure the cpreg_list is modified with updated values and
> transfer those values back to kvm.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   target/arm/kvm.c        | 44 ++++++++++++++++++++++++++++++++++++++++-
>   target/arm/trace-events |  1 +
>   2 files changed, 44 insertions(+), 1 deletion(-)


>   void kvm_arm_reset_vcpu(ARMCPU *cpu)
>   {
>       int ret;
> @@ -2050,7 +2083,16 @@ int kvm_arch_init_vcpu(CPUState *cs)
>       }
>       cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
>   
> -    return kvm_arm_init_cpreg_list(cpu);
> +    ret = kvm_arm_init_cpreg_list(cpu);
> +    if (ret) {
> +        return ret;
> +    }
> +    /* overwrite writable ID regs with their updated property values */
> +    kvm_arm_writable_idregs_to_cpreg_list(cpu);
> +
> +    write_list_to_kvmstate(cpu, 3);

s/3/KVM_PUT_FULL_STATE/?

> +
> +    return 0;
>   }


