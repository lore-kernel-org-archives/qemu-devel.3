Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F5BF94CB0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 22:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFJTI-0003jI-KM; Tue, 21 Apr 2026 18:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFJTG-0003io-EX
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 18:21:30 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFJTE-0007D3-Qz
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 18:21:30 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43d73422431so4072843f8f.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 15:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776810087; x=1777414887; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y4Y6Lcj2ggS5YQ23OA00RNvSohTrGdYqOgwx8e0bNMc=;
 b=kLGDWnkt2y/rUQgGtP4P9f6nwv3kOV3S0iJjmrrVItDiWZ5BVrVIS+Aj3x/u6P2JPf
 FkSHGbsxogV8p+wMz4qQcl9aQiYG7jHwHMgskdn5rknqaAc1+WLfchvoi8/CerWTi99p
 VjGyUtSaY9qtbDkN2XhQoLbpxbzrQpG7N9qTHP95KZqUHyR3XxewKKhGoyPb8LYLgRLC
 P8jo2qW0JjrsHxIWNyOb2TNzkx2ileJ4jr+qFWrqhRsXqTAyaFpK4EknrxwaBAKj65JP
 BSch0gW6DOoEiHE3VKR/0VfokeM7lpaQkdj1BHz7+szTPqwok78WQTqzfB/c3hXuil98
 QjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776810087; x=1777414887;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y4Y6Lcj2ggS5YQ23OA00RNvSohTrGdYqOgwx8e0bNMc=;
 b=n/AMh/rme6zAs3CRDB7DyvoLt+jdTH2nMOlYVuBd6XjpPzEmTMzC6Uu/e/F6A2QemB
 0ppnIxFZZiMMBAphhp8PRFAPrFD3UM/j4tTDJJXwYW1402qQtmURYonBWM0ZWVlp5XFn
 NLjKGEEXebGo0zCsOkGFgFQ3+pKPLY8gOk6XECHNt3K0v81W+NK5oVFOvkx8FV9+hzZo
 RPXIGE1JGJhXb7qbWRHuSNd/Xh0rKu1pweEMihXRlwzw/QBOqoqES+x3odf8hetT+9ME
 lA2v5MrH6WbmXltwiPdFNmH0stX0nn3CQlrNqdwUK5lDtHSZ2v0ryqvnBtaOFSYTrRmC
 rwLw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/K6RlYs19ZnJNVMDBn1QN4Qr6ML4MZ8m5FutdAn+4Kmk6mGbKK/Zem/4sbX1xZPNKbLeN7ek1K48Yw@nongnu.org
X-Gm-Message-State: AOJu0YxM+a3rsiKnXo76x1oRWfP/sQ/2GP9d/itPzkkwj6u6XCDEU6Ma
 q4I9IjqztcN6U8eKoer5z5brVHlmpAvFjQdXRT1H3kjJy9ICas2eM7i4CgH6mtA7ubA=
X-Gm-Gg: AeBDietqn6gEeV8tUuHF6m1fxmIM8I3rOV/oQOOK1GcNHUqhXiy8GS/8Yq2VEJkPzwk
 o5XDsWO7PFO/LM+ySc3J3WdmpF7fim4qdgCeT1NymcNsqY6eHvO2PAuDmMtC9FlP0R81Gzz6Ch9
 9UJTukaDAULMM0aPwvfYL/L+jKu1N8HV8blTWxh1PAuoTN9yfbmbacqAGOzZDruaW999i52Xk4h
 TvcQRMwk23ZARk9DkGlgFlxbAWjbJb58XobFAfNUhXpyQgnOUzO2gVQ+3xFizQnNV5ihnrl0/nj
 lg7fNwkBFvT8x+bUSvRWAJ2bYSgSBgeQshn2wZ6Jl7RqAK/pqNx8byo8RjwMMjAoanFPHd14xp2
 vgN/X47wP8YHfq+ffPrnGBE0O/Cr2AODQt9jn4N8de2+G0MMcvvciuaO7RWGBm/lP58VOlgHSiG
 37+9kUPzSymBh071aFRhezPY2bJVtQUCGoOBh9ANJvO8dv5e60SsqwbX2wwBeX+B0/OM90KMnCb
 /Kc
X-Received: by 2002:a05:6000:24c7:b0:43c:fe0e:5bb9 with SMTP id
 ffacd0b85a97d-43fe3dd4ca7mr31401671f8f.12.1776810086977; 
 Tue, 21 Apr 2026 15:21:26 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4ffa8sm41286302f8f.35.2026.04.21.15.21.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 15:21:26 -0700 (PDT)
Message-ID: <1c4b67db-447f-408e-a6b4-c477894f1a59@linaro.org>
Date: Wed, 22 Apr 2026 00:21:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] intel_iommu: Replace assert(size == 4) with guest
 error in MMIO handlers
Content-Language: en-US
To: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
 yi.l.liu@intel.com, =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?=
 <clement.mathieu--drif@bull.com>, marcel.apfelbaum@gmail.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, farosas@suse.de,
 lvivier@redhat.com
References: <20260420170523.17908-1-junjie.cao@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260420170523.17908-1-junjie.cao@intel.com>
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

On 20/4/26 19:05, Junjie Cao wrote:
> vtd_mem_read() and vtd_mem_write() use assert(size == 4) for
> 32-bit-only VT-d registers. Since MemoryRegionOps .valid/.impl
> accepts sizes 4 through 8, an 8-byte guest access passes framework
> validation and reaches the handler, where the assertion aborts QEMU.
> 
> Narrowing .impl.max_access_size to 4 is not viable because VT-d has
> 64-bit registers (e.g. DMAR_CCMD_REG, DMAR_IQA_REG) that require
> atomic 8-byte access to trigger command execution.

So what about going the other way around, having a pure 64-bit
implementation, so 64-bit accesses are atomic, and 32-bit ones
are handled as 64-bit discarding one half:

-- >8 --
@@ -3916,13 +3916,13 @@ static const VMStateDescription vtd_vmstate = {
  static const MemoryRegionOps vtd_mem_ops = {
      .read = vtd_mem_read,
      .write = vtd_mem_write,
      .endianness = DEVICE_LITTLE_ENDIAN,
      .impl = {
-        .min_access_size = 4,
+        .min_access_size = 8,
          .max_access_size = 8,
      },
      .valid = {
          .min_access_size = 4,
          .max_access_size = 8,
      },
  };
---

> 
> Replace all 22 asserts in vtd_mem_write() and 3 in vtd_mem_read()
> with a size check that logs via qemu_log_mask(LOG_GUEST_ERROR) and
> returns without performing the register access. The asymmetry
> (22 vs 3) is because vtd_mem_read() handles most registers through
> its default branch, so only three explicit cases carried an assert.
> 
> Found by fuzzing with QEMU's generic-fuzz framework; crashes
> reproduced at DMAR_FECTL_REG, DMAR_IECTL_REG, DMAR_IEADDR_REG
> and DMAR_PECTL_REG; all 25 sites share the same root cause.
> 
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>   hw/i386/intel_iommu.c | 114 +++++++++++++++++++++++++++++++++---------
>   1 file changed, 89 insertions(+), 25 deletions(-)


