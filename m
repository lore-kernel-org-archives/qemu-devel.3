Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0A7C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 10:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taXeY-0001P3-LC; Wed, 22 Jan 2025 05:08:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taXdw-0000SH-Tu
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 05:07:29 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taXdu-0004v9-Rk
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 05:07:28 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385e06af753so3309861f8f.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 02:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737540445; x=1738145245; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ExaM5IojEhR5ebxmbt+JrEhI38FIHz3XEQYGQ8hBC5Y=;
 b=SuZFB8WVd843hq+dQmAQ7eGgUuPMsowzvnv2jZQd+Pcp1aAES6Lrq1As7JTU6vTL7B
 jsYEZcm3ng2ZD6nwfjJvRMt5QIOfBOT4vAy8wRDeFwcIHYUODDHV22KUFpVfehEgWaGp
 YMglhR4AoonIQbdXlFtDCPF2wsFejRnIODz2JgVMHJ9yoAddkIsud7kh9i0clm3w+dWA
 apgaSNY75ru6V0VNihGNv737kJBcTKkI7lE3Hrst7Q4v+BQ7UdIcnTtLVaPUkor34+KT
 IDnljInIvq68yQ6dC/5TWpWssiQO5FYt3k2dfaiV4sxFBUgWHD1LRtSvOKcI85yx1lkT
 ioMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737540445; x=1738145245;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ExaM5IojEhR5ebxmbt+JrEhI38FIHz3XEQYGQ8hBC5Y=;
 b=AVtq214HWVyl7qH5YyjgwbAO6nJie2f5enRD2FurXJJe4f06WMUNzEDl2sWnv4iZfg
 yhgaFn7Cvd9fbV8Axo4Fq/WnOvEXF4ftLmsUnOxvQojfbxt7j9MeW2Ukmr9S6O50qnyt
 PKTAZ5GH4bWShOsGDwNYw+7ErzcFzkP0G3LHaL9lqMsJHcwDgTGidx4CMpN4YiJUtE+v
 9O6aMUy1aGHl8trhpVo+tgCl31brwD3TC9fRIedq/KcFFhLOt6tKzFniJWsEUsRUmbP/
 KhO3QgunP5e8wGC5oUpVMDYbwNKSMLVXAcgqvepmT1PrhYKaqh06YijBh5bsgW0c5jfb
 sRRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU16YF62cHMLHZe3p6cC5dOs6fcYOhj8a6QH56+vSmwfEJiehQtz38UL92vAnQFTasE5JXQ48VGfiHe@nongnu.org
X-Gm-Message-State: AOJu0Yy+rynfAuunm9PuY/iQTTa/QaXinkRdx/D+nRmEHKw94j56V7Yr
 LGPhzWAFAH07JErF/wXwLWA+Eivb0DX1SVM6GshDf7gQiVxu60grJ355LCttHeQ=
X-Gm-Gg: ASbGncv06kRdaJ4v5UJncffadKJFOkr1f5yu15DrrTPNVPHISnIlkT/hh6/35IMc1Tu
 bRgbZpMNNsZcJZpzLlOam6yPE5NPtT56rEV0IS3IHLL0yozPmc/mTPN+Og5gRGh9YkVN3EJvLdO
 0Rx7D0YSN1W3XH3/zLjHxChk6YwCzTeEAqpnCtZ5GomWLdBj0ar4w7AMI+rMGA3rBbu579WxT/I
 dgI6sBA3wDBSret2wjfhtvKBaDA9VP5vBhrPqFIK8MjAV4JE+8gVMY19p/BqId4wkbgXTvT8znD
 5VVdijBBh6tGwPiRA+85Cx+3vAj0ssvgTvJ3Pw==
X-Google-Smtp-Source: AGHT+IEAY3Xv531vygIXN2LLeYLhz7VuzEbG0NO5ianBha6mo0loe6VLYvrFFAk6B7HP+OQXRQQlzw==
X-Received: by 2002:adf:f788:0:b0:38a:41c9:8544 with SMTP id
 ffacd0b85a97d-38bf57a2838mr13365382f8f.37.1737540444968; 
 Wed, 22 Jan 2025 02:07:24 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322ad74sm16029958f8f.56.2025.01.22.02.07.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 02:07:24 -0800 (PST)
Message-ID: <5267cc69-18ec-48b1-be60-90c972922806@linaro.org>
Date: Wed, 22 Jan 2025 11:07:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] physmem: disallow direct access to RAM DEVICE in
 address_space_write_rom()
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Zabka <git@zabka.it>
References: <20250120111503.244994-1-david@redhat.com>
 <20250120111503.244994-2-david@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250120111503.244994-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Hi David,

On 20/1/25 12:14, David Hildenbrand wrote:
> As documented in commit 4a2e242bbb306 ("memory: Don't use memcpy for
> ram_device regions"), we disallow direct access to RAM DEVICE regions.
> 
> Let's factor out the "supports direct access" check from
> memory_access_is_direct() so we can reuse it, and make it a bit easier to
> read.
> 
> This change implies that address_space_write_rom() and
> cpu_memory_rw_debug() won't be able to write to RAM DEVICE regions. It
> will also affect cpu_flush_icache_range(), but it's only used by
> hw/core/loader.c after writing to ROM, so it is expected to not apply
> here with RAM DEVICE.
> 
> This fixes direct access to these regions where we don't want direct
> access. We'll extend cpu_memory_rw_debug() next to also be able to write to
> these (and IO) regions.
> 
> This is a preparation for further changes.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   include/exec/memory.h | 30 ++++++++++++++++++++++++------
>   system/physmem.c      |  3 +--
>   2 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 3ee1901b52..bd0ddb9cdf 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -2985,15 +2985,33 @@ MemTxResult address_space_write_cached_slow(MemoryRegionCache *cache,
>   int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr);
>   bool prepare_mmio_access(MemoryRegion *mr);
>   
> +static inline bool memory_region_supports_direct_access(MemoryRegion *mr)
> +{
> +    /* ROM DEVICE regions only allow direct access if in ROMD mode. */
> +    if (memory_region_is_romd(mr)) {
> +        return true;
> +    }
> +    if (!memory_region_is_ram(mr)) {
> +        return false;
> +    }
> +    /*
> +     * RAM DEVICE regions can be accessed directly using memcpy, but it might
> +     * be MMIO and access using mempy can be wrong (e.g., using instructions not
> +     * intended for MMIO access). So we treat this as IO.
> +     */
> +    return !memory_region_is_ram_device(mr);
> +
> +}
> +
>   static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
>   {
> -    if (is_write) {
> -        return memory_region_is_ram(mr) && !mr->readonly &&
> -               !mr->rom_device && !memory_region_is_ram_device(mr);
> -    } else {
> -        return (memory_region_is_ram(mr) && !memory_region_is_ram_device(mr)) ||

This patch is doing multiple things at once, and I'm having hard time
reviewing it.

> -               memory_region_is_romd(mr);
> +    if (!memory_region_supports_direct_access(mr)) {
> +        return false;
> +    }
> +    if (!is_write) {
> +        return true;
>       }
> +    return !mr->readonly && !mr->rom_device;
>   }

Trying to split.

1/ Extract starting with ram[_device]:
-- >8 --
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 3ee1901b52c..5834a208618 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2987,2 +2987,15 @@ bool prepare_mmio_access(MemoryRegion *mr);

+static inline bool memory_region_supports_direct_access(MemoryRegion *mr)
+{
+    if (!memory_region_is_ram(mr)) {
+        return false;
+    }
+    /*
+     * RAM DEVICE regions can be accessed directly using memcpy, but it 
might
+     * be MMIO and access using mempy can be wrong (e.g., using 
instructions not
+     * intended for MMIO access). So we treat this as IO.
+     */
+    return !memory_region_is_ram_device(mr);
+}
+
  static inline bool memory_access_is_direct(MemoryRegion *mr, bool 
is_write)
@@ -2990,6 +3003,6 @@ static inline bool 
memory_access_is_direct(MemoryRegion *mr, bool is_write)
      if (is_write) {
-        return memory_region_is_ram(mr) && !mr->readonly &&
-               !mr->rom_device && !memory_region_is_ram_device(mr);
+        return !mr->readonly && !mr->rom_device &&
+               !memory_region_supports_direct_access(mr);
      } else {
-        return (memory_region_is_ram(mr) && 
!memory_region_is_ram_device(mr)) ||
+        return memory_region_supports_direct_access(mr) ||
                 memory_region_is_romd(mr);
---

2/ Call memory_region_supports_direct_access() once [dubious]
-- >8 --
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 5834a208618..4c5c84059b7 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3002,8 +3002,10 @@ static inline bool 
memory_access_is_direct(MemoryRegion *mr, bool is_write)
  {
+    if (!memory_region_supports_direct_access(mr)) {
+        return false;
+    }
+
      if (is_write) {
-        return !mr->readonly && !mr->rom_device &&
-               !memory_region_supports_direct_access(mr);
+        return !mr->readonly && !mr->rom_device;
      } else {
-        return memory_region_supports_direct_access(mr) ||
-               memory_region_is_romd(mr);
+        return memory_region_is_romd(mr);
      }
---

3/ Invert if ladders:
-- >8 --
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 4c5c84059b7..e89cd2f10f0 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3006,7 +3006,7 @@ static inline bool 
memory_access_is_direct(MemoryRegion *mr, bool is_write)

-    if (is_write) {
-        return !mr->readonly && !mr->rom_device;
-    } else {
+    if (!is_write) {
          return memory_region_is_romd(mr);
      }
+
+    return !mr->readonly && !mr->rom_device;
  }
---

4/ Check memory_region_is_romd() [dubious]
-- >8 --
diff --git a/include/exec/memory.h b/include/exec/memory.h
index e89cd2f10f0..2cdbf4b43d7 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2989,2 +2989,6 @@ static inline bool 
memory_region_supports_direct_access(MemoryRegion *mr)
  {
+    /* ROM DEVICE regions only allow direct access if in ROMD mode. */
+    if (memory_region_is_romd(mr)) {
+        return true;
+    }
      if (!memory_region_is_ram(mr)) {
@@ -3007,3 +3011,3 @@ static inline bool 
memory_access_is_direct(MemoryRegion *mr, bool is_write)
      if (!is_write) {
-        return memory_region_is_romd(mr);
+        return true;
      }
---

Hmm maybe this isn't a change that can be easily split in logical steps?

