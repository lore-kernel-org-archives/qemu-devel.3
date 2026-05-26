Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2A3CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRnzS-0006Hl-6G; Tue, 26 May 2026 05:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRnzO-0006GE-BJ
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:22:20 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRnzK-00041j-3H
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:22:16 -0400
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-490388fd0dbso47517045e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779787330; x=1780392130; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JU8BY8gliUPtsTlcSn/ovGoRxdvV3CH4wXYaAUQjtS4=;
 b=xIREl78wiCgqb4/PYZy5Y65D3xODTM47RyrF9JMedIUNP9/KZpSIFlmG2U8th0cWS0
 EyyHxsl0+neJtNmmNAAKdywFyUodVUmZYYLVanq46LT0O9/M0PNIs1Ak7np0ZHTqgHLG
 XuaQ/hOspqG4oLguFGcv27qyLro39LRB27ETmHiOw3TAZvWcS6v9wtWWM6k+6O4y6CWo
 XZSP8dkbQyyLf13+GU/x3n0SzwIiZmtrW4vA4pMf0IYyL2WdS9f5ncTXcjoJ31cVr1Tr
 yWDhfTwgQC8+gVWiTBPw9hFrzGeEundUPXvrbiix4Z3L6lA1mKPs02EbU3OCmsYFGdN7
 oLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779787330; x=1780392130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JU8BY8gliUPtsTlcSn/ovGoRxdvV3CH4wXYaAUQjtS4=;
 b=FE93DR8CR9o0LLd5tDR+d24tBGOYtGXWPsTPj8c7J5hf4slA/3qP/QgOJSnNmRNWnC
 ux43lxNq+FdHe/K5ZXqQrmbRabGP/ErgcG3Y/ib32bITFR+u9ZoDyCNgomGmP4DLQl5x
 WQu4rPatZzAvax/1pPfZVWm+vNFaKZNBpmLxKNXuV2T+cfWeXXGHg66J7xOUshNDyvF5
 kFJZ7uXLp5F9DPISoEnsuVjof3kOXFUtLxSwWHnFm8uY2ikBPFsSG15huf2zivES6kCm
 uyZorbvnVaqce0GlLdw6tInA4imxS9gzunOYEtENbg1w9baetxUlxnAZ+LYZSySUCO4K
 qxgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fQ4ZrAd7g/klVYSHWxceJoSf2k4vBp8ksS/TC3v2FeGgfbCFgEQDXeRoGh/LLgBUXjTEfpsm9Xw/+@nongnu.org
X-Gm-Message-State: AOJu0YzW3toGWBJ2UkUL/lRNiJg1PPWVf6HqXqONSODnP3AYC/8g5F52
 0pbeLuc7v88abPoWt/H1I54MOy795GuIL7RrUNoxuPpojJ8I4xioCXjJG1aZDUoKzIU=
X-Gm-Gg: Acq92OEqguUA3wjKFDd0Z4t8nGoP76uTjJxJbgMN8ia4cQLhrZfmRQsOrS4d8QEOHP6
 0Cn3TyA2Poi6kMnVVbTuzu27qqLgGgAkEIS8xlJnHW736MhQXxGz/36qhbJpld7A4lYb62w6RbC
 1EU+7Vqlvu7DmvJLTqOjVBdgn4amM/mUWP9DVCFN+FmRJ7Vric7TIv1m1qAZ4D+9NmPNtL9ZbE0
 jxj0aI6c2UND7umgzyBGbUIywsgf5BLwio1hVmcy6BFWSIoGCrqWvwpIGTxiJkJ/fp2Bu1eI2aX
 Jj4oCIUS7zWaxcXRp54xhco396W05L25djSnJ+wAhOaHeQ5aHElYa71yW0M+G56ddTB68dHN1uG
 sPHsRjDNPj2i/3vjb3x4JqeccUDn5Nj9xIgkgcZjhrQ4kQ+ZhDQ1LZO7LFHqsdpHEgGNwnH/d13
 xBZ01fA0O9m+Q1+zr0VwXmlx4luSWcRjIkyfXC34vWiKxLbEmBjSlBhxUjGadcwTH5dw==
X-Received: by 2002:a05:600c:1d9a:b0:490:5cb3:e93f with SMTP id
 5b1f17b1804b1-4905cb3ec51mr157972915e9.2.1779787330110; 
 Tue, 26 May 2026 02:22:10 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527526dsm343610735e9.4.2026.05.26.02.22.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 02:22:09 -0700 (PDT)
Message-ID: <b0754ae4-41bd-4f9d-b24b-9981ebea5a3e@linaro.org>
Date: Tue, 26 May 2026 11:22:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/physmem: Synchronize ram_list accesses
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260523-tsan-v1-1-07d5eb9dcaa2@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260523-tsan-v1-1-07d5eb9dcaa2@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

On 23/5/26 14:38, Akihiko Odaki wrote:
> Alex Bennée reported a ThreadSanitizer warning about a plain concurrent
> access to ram_list [1]. Ensure the concurrent accesses to ram_list are
> properly synchronized with atomic accesses, mutexes, or RCU.
> 
> First, the plain assignments of ram_list.mru_block are replaced with
> qatomic_set(). A comment in qemu_get_ram_block() explains why the
> ordering requirement is relaxed, but it still needs to be atomically
> accessed. include/qemu/atomic.h says:
> 
>> The C11 memory model says that variables that are accessed from
>> different threads should at least be done with __ATOMIC_RELAXED
>> primitives or the result is undefined. Generally this has little to
>> no effect on the generated code but not using the atomic primitives
>> will get flagged by sanitizers as a violation.
> 
> Second, ram_list.version accesses are replaced with atomic operations
> or protected with a mutex. Unlike ram_list.mru_block, ram_list.version
> has tighter ordering requirements for one of its goals: ensuring that
> the reader-held rs->last_seen_block value is invalidated whenever a RAM
> block is reclaimed between two RCU reader critical sections. Below are
> steps a reader and an updater follow:
> 
> Reader:
> 
> R-1. Enter the first RCU read-side critical section:
> R-1-1. rs->last_version = qatomic_load_acquire(&ram_list.version)
> R-1-2. rs->last_seen_block = an element of ram_list.blocks
> R-2. Enter the second RCU read-side critical section:
> R-2-1. if (qatomic_read(&ram_list.version) != rs->last_version)
> R-2-2.     rs->last_seen_block = NULL
> 
> Updater:
> 
> W-1. Enter a ram_list.mutex critical section
> W-1-1. Update ram_list.blocks
> W-1-2. qatomic_store_release(&ram_list.version, ram_list.version + 1)
> W-2. Enter another ram_list.mutex critical section
> W-2-1. QLIST_REMOVE_RCU(block, next)
> W-2-2. qatomic_store_release(&ram_list.version, ram_list.version + 1)
> W-2-3. call_rcu(block, reclaim_ramblock, rcu)
> 
> W-1-2 represents the write observed by R-1-1.
> 
> ram_list.version is read non-atomically on the update side because the
> update side is serialized with ram_list.mutex. The other ram_list
> accesses in these steps are reasoned about in two cases.
> 
> When the grace period of W-2-3 contains R-2:
>      qatomic_load_acquire() at R-1-1 and qatomic_store_release() at W-1-2
>      enforce the following ordering:
>          W-1-1 -> W-1-2 -> R-1-1 -> R-1-2
>      The value of ram_list.blocks stored by W-1-1 or a newer value that
>      was loaded by R-1-2 is still valid because of the grace period.
> 
> When the grace period of W-2-3 ends before R-2:
>      call_rcu() at W-2-3 and the read-side critical section at R-2 ensure
>      the following ordering:
>          W-2-2 -> W-2-3 -> the grace period -> R-2 -> R-2-1
>      The value of ram_list.version stored by W-2-2 or a newer value that
>      was loaded by R-2-1 differs from rs->last_version and the reader
>      invalidates rs->last_seen_block.
> 
> Together, these steps ensure that rs->last_seen_block is invalidated
> whenever necessary. With added atomic operations, pre-existing memory
> barriers are no longer necessary and are removed.
> 
> Any other ram_list accesses are already properly synchronized.
> 
> [1] https://lore.kernel.org/qemu-devel/878q9fbmap.fsf@draig.linaro.org/
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   migration/ram.c  | 10 +++++-----
>   system/physmem.c | 16 +++++++---------
>   2 files changed, 12 insertions(+), 14 deletions(-)


> @@ -2260,11 +2260,10 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>       } else { /* list is empty */
>           QLIST_INSERT_HEAD_RCU(&ram_list.blocks, new_block, next);
>       }
> -    ram_list.mru_block = NULL;
> +    qatomic_set(&ram_list.mru_block, NULL);
>   
>       /* Write list before version */
> -    smp_wmb();
> -    ram_list.version++;
> +    qatomic_store_release(&ram_list.version, ram_list.version + 1);

Should this be:

        qatomic_store_release(&ram_list.version,
                              qatomic_read(&ram_list.version) + 1);

>       qemu_mutex_unlock_ramlist();
>   
>       physical_memory_set_dirty_range(new_block->offset,
> @@ -2608,10 +2607,9 @@ void qemu_ram_free(RAMBlock *block)
>       name = cpr_name(block->mr);
>       cpr_delete_fd(name, 0);
>       QLIST_REMOVE_RCU(block, next);
> -    ram_list.mru_block = NULL;
> +    qatomic_set(&ram_list.mru_block, NULL);
>       /* Write list before version */
> -    smp_wmb();
> -    ram_list.version++;
> +    qatomic_store_release(&ram_list.version, ram_list.version + 1);

ditto?

>       call_rcu(block, reclaim_ramblock, rcu);
>       qemu_mutex_unlock_ramlist();
>   }
> 
> ---
> base-commit: e89049b3ba5f1f0468bc0d294173345597514a1b
> change-id: 20260520-tsan-c6f1aa909a90
> 
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 


