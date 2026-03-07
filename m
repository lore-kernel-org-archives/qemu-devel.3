Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6CAFC9ECF
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 05:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vykYU-00056I-On; Sat, 07 Mar 2026 00:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vykYL-00055G-DR; Sat, 07 Mar 2026 00:50:17 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vykYI-0004mA-9k; Sat, 07 Mar 2026 00:50:17 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6275mnlo066273
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 7 Mar 2026 14:49:50 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=orITRtaC4a0R0PsWvNR48y3aT8WPRnKWjVVi0dmYyWY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1772862590; v=1;
 b=Re2i7o0CB1GQy3H93cEygFvD7gXSHrTHU3aLo2fySZ0CbZZj92iXb8lwqUAjczLD
 6NUDN2HJ/jvGIMaiJO3/roS2HZSQvqDgmNietlYT762jSlYNj6EnfE84uOp/PZ9q
 AZFuoC+03wkNhyWmls7TuFYKTBapRCdTIDYo9BMy5lOMWKMLi2AmvCW+W9fNpxBB
 t61dYKszpDYZmqP/73/hO2hpblAOLrBaGC30ThNYLDfinVRIOSmHTjylZUEan22p
 1XjVF1WuclnQ3AeQJUPAskzNv4s4GvBGYeJfb8dpuZt3tlYCMa3XybTKbih/38aw
 5xwpk50ESedD66n1cIUqMQ==
Message-ID: <17fccf01-7784-44a2-9745-33a48e8c60e3@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 7 Mar 2026 14:48:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] system: memory: convert some helpers to const
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>, Peter Xu <peterx@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20260307044608.25486-1-mohamed@unpredictable.fr>
 <20260307044608.25486-2-mohamed@unpredictable.fr>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260307044608.25486-2-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/03/07 13:46, Mohamed Mediouni wrote:
> Seemed to be a better alternative than making flatview_for_each_range pass non-const
> pointers.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   include/system/memory.h | 14 +++++++-------
>   system/memory.c         |  6 +++---
>   2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index 0562af3136..1a140ef203 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -1339,7 +1339,7 @@ void memory_region_init(MemoryRegion *mr,
>    *
>    * @mr: the #MemoryRegion
>    */
> -void memory_region_ref(MemoryRegion *mr);
> +void memory_region_ref(const MemoryRegion *mr);

I don't firmly oppose this, but I feel a bit uneasy about this change.

You are right that this should be const in principle: this function does 
not modify mr in any way.

However, we can also consider the current implement as "abusing" the 
const qualifier to express that we are not going to ref/unref. It is an 
abuse, but I think it is practically makes sense.

Regards,
Akihiko Odaki

>   
>   /**
>    * memory_region_unref: Remove 1 to a memory region's reference count
> @@ -1765,7 +1765,7 @@ uint64_t memory_region_size(MemoryRegion *mr);
>    *
>    * @mr: the memory region being queried
>    */
> -static inline bool memory_region_is_ram(MemoryRegion *mr)
> +static inline bool memory_region_is_ram(const MemoryRegion *mr)
>   {
>       return mr->ram;
>   }
> @@ -1777,7 +1777,7 @@ static inline bool memory_region_is_ram(MemoryRegion *mr)
>    *
>    * @mr: the memory region being queried
>    */
> -bool memory_region_is_ram_device(MemoryRegion *mr);
> +bool memory_region_is_ram_device(const MemoryRegion *mr);
>   
>   /**
>    * memory_region_is_romd: check whether a memory region is in ROMD mode
> @@ -1787,7 +1787,7 @@ bool memory_region_is_ram_device(MemoryRegion *mr);
>    *
>    * @mr: the memory region being queried
>    */
> -static inline bool memory_region_is_romd(MemoryRegion *mr)
> +static inline bool memory_region_is_romd(const MemoryRegion *mr)
>   {
>       return mr->rom_device && mr->romd_mode;
>   }
> @@ -2071,7 +2071,7 @@ MemoryRegion *memory_region_from_host(void *ptr, ram_addr_t *offset);
>    *
>    * @mr: the memory region being queried.
>    */
> -void *memory_region_get_ram_ptr(MemoryRegion *mr);
> +void *memory_region_get_ram_ptr(const MemoryRegion *mr);
>   
>   /* memory_region_ram_resize: Resize a RAM region.
>    *
> @@ -2967,7 +2967,7 @@ void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
>   int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr);
>   bool prepare_mmio_access(MemoryRegion *mr);
>   
> -static inline bool memory_region_supports_direct_access(MemoryRegion *mr)
> +static inline bool memory_region_supports_direct_access(const MemoryRegion *mr)
>   {
>       /* ROM DEVICE regions only allow direct access if in ROMD mode. */
>       if (memory_region_is_romd(mr)) {
> @@ -2984,7 +2984,7 @@ static inline bool memory_region_supports_direct_access(MemoryRegion *mr)
>       return !memory_region_is_ram_device(mr);
>   }
>   
> -static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write,
> +static inline bool memory_access_is_direct(const MemoryRegion *mr, bool is_write,
>                                              MemTxAttrs attrs)
>   {
>       if (!memory_region_supports_direct_access(mr)) {
> diff --git a/system/memory.c b/system/memory.c
> index c51d0798a8..eb515fbee4 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1825,7 +1825,7 @@ Object *memory_region_owner(MemoryRegion *mr)
>       return obj->parent;
>   }
>   
> -void memory_region_ref(MemoryRegion *mr)
> +void memory_region_ref(const MemoryRegion *mr)
>   {
>       /* MMIO callbacks most likely will access data that belongs
>        * to the owner, hence the need to ref/unref the owner whenever
> @@ -1866,7 +1866,7 @@ const char *memory_region_name(const MemoryRegion *mr)
>       return mr->name;
>   }
>   
> -bool memory_region_is_ram_device(MemoryRegion *mr)
> +bool memory_region_is_ram_device(const MemoryRegion *mr)
>   {
>       return mr->ram_device;
>   }
> @@ -2415,7 +2415,7 @@ int memory_region_get_fd(MemoryRegion *mr)
>       return mr->ram_block->fd;
>   }
>   
> -void *memory_region_get_ram_ptr(MemoryRegion *mr)
> +void *memory_region_get_ram_ptr(const MemoryRegion *mr)
>   {
>       uint64_t offset = 0;
>   


