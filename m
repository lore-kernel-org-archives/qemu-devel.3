Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84A0C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 12:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueYFI-0002XF-Lv; Wed, 23 Jul 2025 08:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ueYF7-0002DQ-Uk
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 08:06:43 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ueYF4-00076Z-AC
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 08:06:40 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a53359dea5so3172869f8f.0
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 05:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753272395; x=1753877195; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gg6ya0HeQQI/L9cjeKTN9VxyKHZdrQ2ZJqyDy8HZpvA=;
 b=e2aK5j+wyBOo8cldWqTLj2KLJ74aFvWSJVCIFaVTSW3oQiNC9GE40xjwADYtGgw/2a
 wV8IyNJoc4jcA9Ta44d7Nc3tELGIOoznmmAbDLs9ZShLziTiRZ6pAhucjH17WQnqDjXy
 3Qd5vg1mKk7aJ775XuWD+ql36hRAWYzTgbw5FPkPUaiRruZvbp2pxnwEyxk+iFTURyEe
 m4Mn2aX81bHW0xNWaNUCPfeRRWXvwX4YZ3+IBJOyx10hKtmRjs6RPb/p/K02xOh7U0xd
 umjRDVN3Cs9peCKUIaJKl9yN4V9Eu5uBbJrYPwfWbRJa9P0pdPeiWcwWbk+LaXwRVoGu
 0KbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753272395; x=1753877195;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gg6ya0HeQQI/L9cjeKTN9VxyKHZdrQ2ZJqyDy8HZpvA=;
 b=D98nYpCtT9JTtTySIDnFM5zqoNAmYPIJ+taHWM8V0WQdAA9fqgK1/OFykCoJwDIGGv
 BgVdd/OLPKFcDg5Qd5bKyV9xg4PpAJ2wRNj0+92nKCqSAl+rBzwhZ75semJ1ExJPgzPp
 qZkDk8J9rHlv2h6GXtGJMwbB2shd6IV6phGcGKHiIb4itfpU6SaADe8Xv7+s8YsPsuck
 6rynguslazJ3p1fVxnsyL9BgllmO1MeW8S5Y+HuzK5poX8shHduDNZxryaif+6vKBlgh
 9Z3/QFS7jcw1OB5Z8fzg5xLsji9ocDRKrjTWWB1a5erMVVyihsOdFRtR1s7IyvTg6p5Q
 6iqQ==
X-Gm-Message-State: AOJu0YxJuSAs9HJDaHjAR/donfr2NLMvsEMYr3nHkWIlpdcE4DaIDKRg
 9mwZvgZfrTbJOzi+YVm9zs1yULsDfAaKyMX72RncBTKs1cVrDaxQAcbrcjNH4SbciuCErvxCUqY
 Kr0hA
X-Gm-Gg: ASbGncum8ZQ74ebLRtIPRfwxkpo70HbDtfGd7uC3LKUupBm7BWMwCo6YteJyTRrZ3Hf
 kf+WQqpWrzat/v3S5BzqrZs83FbTPXskOPsmNAsYTizjTg7NhRpgkciZnV7fk4WT4VMkSZrc+Ss
 uaiiV71dyQ27NDRxUbuPJkq479zX/u2WREn2TSVROfregNNWzTrJP3CbvQ+65GvTjgl/0w/fV83
 Jlq1UnyU/M1sSC20MZiZj/BMH9DMR+gW4KN0nEHEv3YCSnC+oNuogUmDNK96cTK434ryWaJFbmj
 26GnIkBY/mRIiRZ3K2kqOcdU6x6vYu78eOpDm4unkGYi99610zpWqRywocpuSkWk2hCjeQgZBnR
 O2Aj8xgT4WW4hQDd626x4N22hCONIYv3uOsRnQWs3Is7mNEXdelRD2vb54NoRWscUdcdQ15M3xh
 LZK/fk0w==
X-Google-Smtp-Source: AGHT+IGhHgUl1L87x52BYv27y6yvFPAtg0Kql3fSIcm7iWaTMQL0dObFbtdQ92d25GEhgIkcDOo7Rg==
X-Received: by 2002:a5d:5f48:0:b0:3a4:eda1:6c39 with SMTP id
 ffacd0b85a97d-3b768e9d608mr2173600f8f.13.1753272394485; 
 Wed, 23 Jul 2025 05:06:34 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4d807sm16363035f8f.73.2025.07.23.05.06.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 05:06:33 -0700 (PDT)
Message-ID: <c149b1b3-1b28-452e-91ee-e4f8efb8f24e@linaro.org>
Date: Wed, 23 Jul 2025 14:06:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] accel/kvm: Set mem.guest_memfd_offset only when
 guest_memfd is valid
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250723070951.1134374-1-xiaoyao.li@intel.com>
 <20250723070951.1134374-4-xiaoyao.li@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250723070951.1134374-4-xiaoyao.li@intel.com>
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

On 23/7/25 09:09, Xiaoyao Li wrote:
> Current QEMU unconditionally sets the mmem.guest_memfd_offset in
> kvm_set_user_memory_region(), which leads to the trace of kvm_set_user_memory
> look as:
> 
> kvm_set_user_memory AddrSpace#0 Slot#4 flags=0x2 gpa=0xe0000 size=0x20000 ua=0x7f5840de0000 guest_memfd=-1 guest_memfd_offset=0x3e0000 ret=0
> 
> It's confusing that the guest_memfd_offset has a non-zero value while
> the guest_memfd is invalid (-1).
> 
> Change to only set guest_memfd_offset when guest_memfd is valid.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   accel/kvm/kvm-all.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 4f4c30fc84b2..2b6fbf58a127 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -367,7 +367,9 @@ static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot, boo
>       mem.userspace_addr = (unsigned long)slot->ram;
>       mem.flags = slot->flags;
>       mem.guest_memfd = slot->guest_memfd;
> -    mem.guest_memfd_offset = slot->guest_memfd_offset;
> +    if (slot->guest_memfd >= 0) {
> +        mem.guest_memfd_offset = slot->guest_memfd_offset;
> +    }

IMHO the issue is in when the KVMSlot is filled in kvm_set_phys_mem():

-- >8 --
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 890d5ea9f86..631f14b996a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1595,7 +1595,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
          mem->ram = ram;
          mem->flags = kvm_mem_flags(mr);
          mem->guest_memfd = mr->ram_block->guest_memfd;
-        mem->guest_memfd_offset = (uint8_t*)ram - mr->ram_block->host;
+        mem->guest_memfd_offset = mr->ram_block->guest_memfd
+                                ? (uint8_t*)ram - mr->ram_block->host : 0;

          kvm_slot_init_dirty_bitmap(mem);
          err = kvm_set_user_memory_region(kml, mem, true);
---

