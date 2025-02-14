Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2774C02198
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 01:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj75I-0004fV-Hf; Fri, 14 Feb 2025 20:35:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tj38G-00078i-Ce
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 16:21:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tj38D-00085m-UZ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 16:21:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739568109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WTA93GBQYjzWQv0sdzCiO4meUgBl6OZnMg+W7LgSu/8=;
 b=eU2z0L+GFMCPeK9RPMQvABW3a9EC3x94Jfd8sxxX3WfgqKdXuq+sQtPZiNLHiACb3eyzAB
 x1fBRhEWAORCXinnzoMI5G8hX559C3PY3kiolyGd8c+zK6C9kmzhfCuiUGfKPd6Z6nzzFY
 yLeP366xp+ufs8n70xeAza5f2OsKvCI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-euMGxkXcPuG5SKvM5SHWGg-1; Fri, 14 Feb 2025 16:21:47 -0500
X-MC-Unique: euMGxkXcPuG5SKvM5SHWGg-1
X-Mimecast-MFC-AGG-ID: euMGxkXcPuG5SKvM5SHWGg_1739568106
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4394b2c19ccso20479545e9.1
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 13:21:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739568106; x=1740172906;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WTA93GBQYjzWQv0sdzCiO4meUgBl6OZnMg+W7LgSu/8=;
 b=W9Q8091psFcH+lI0xz4UoV9n39nfjU5zo92y5GeALFPcSLz+ieVtFXvIdy4tbFAuV+
 YBzcqCwtwg/CP2AB25flH+/Muig+7vsSTiAM80+EytrJX0SvwkM8ZcD89vXHDhVy+7l1
 tAJXIH6M8/xTad/WrXxxcPdNHE2dqjRYquxCTs8yPTxgN8X30Z8s4vmhN8uxYMUzQc45
 UtYZYVNKfE+hgzicBRw4DZGrdlY3YbpTgGAymqa63bcXEec3+tuJGpqpGp0ALiLdQi/3
 EF2nzNfsVeAyEXCqZOcSOFwRzvYn0MhWMwvvJLuK5fKUZa58ZVxu0mQUd/5TBHiechRb
 qDgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP7YmGCjcdYF8SXxiHxhjuxC4NhSOiLvhQuSyqhse6jk4OyAKbMnVj4Z1ejQuykDqfDo5hvveT6Cgu@nongnu.org
X-Gm-Message-State: AOJu0Yy8+S0U+6ldFls1aBZXHGOhM3oyLBChF189K7GU6bGWnbX5rLFJ
 7oZFHreM283sZZuHK+V7gAqlT+m8lEJAnHLovYWI0eENYWMk7KBAHhfLp29lCyxnL9dQmmV+qsY
 iNcJq4mMeitWl1QT75kgwhv/iwK6/HQ4tiwxOGsNQAvDFagZWG0WE
X-Gm-Gg: ASbGncsHC55VhrwRp/3PF+Z08jfKCvzU2qND1PeoJBg2qsShmp3i9AaPY7RKjiizGNl
 t2jYCMmoPnMk2u+zBqN6Be6GU4u8mSagaPdpOyh1d/yAtIjSWA4UNS4xt3IKVnuY3kL51UtkawD
 HJlJXAaRJSbfvdmVncFblju+s6Ok8OED2qA0jBrLhJqWDTKafW1OArKd7CwzjO6ZEYaoXg4u+hl
 oF5JE7aF1PnJl9tVo64KycBlfNRaPsbA13mhz9hAwXobcyeeFgtHzoqYtwdk529obqFNRBCQN75
 kb8YKXwaHJAJPNnt52+vVLJ5iOD1doNp+S75exErt0c52pd8ST9tDKfCDOkBBgKC8DDfkKTM64z
 1VfXoRZwpb4Qs90CeQ+X11laE8EZvRv3G
X-Received: by 2002:a05:600c:4fce:b0:439:3d5c:8c19 with SMTP id
 5b1f17b1804b1-4396e717094mr9590615e9.24.1739568106453; 
 Fri, 14 Feb 2025 13:21:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrFlxs5Fv0UIa6Gyrf16YvheVIe82Lidc8cDz9HjUkcMF4z1GXBLnwWI3GzYN0WYsaLyzXHw==
X-Received: by 2002:a05:600c:4fce:b0:439:3d5c:8c19 with SMTP id
 5b1f17b1804b1-4396e717094mr9590445e9.24.1739568106089; 
 Fri, 14 Feb 2025 13:21:46 -0800 (PST)
Received: from ?IPV6:2003:d8:2f22:1000:d72d:fd5f:4118:c70b?
 (p200300d82f221000d72dfd5f4118c70b.dip0.t-ipconnect.de.
 [2003:d8:2f22:1000:d72d:fd5f:4118:c70b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439617da784sm55519205e9.5.2025.02.14.13.21.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2025 13:21:44 -0800 (PST)
Message-ID: <7e781592-ea91-4a3a-9855-8e5479e0b61e@redhat.com>
Date: Fri, 14 Feb 2025 22:21:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] migration: ram block cpr blockers
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <1739563953-227207-1-git-send-email-steven.sistare@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1739563953-227207-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 14.02.25 21:12, Steve Sistare wrote:
> Unlike cpr-reboot mode, cpr-transfer mode cannot save volatile ram blocks
> in the migration stream file and recreate them later, because the physical
> memory for the blocks is pinned and registered for vfio.  Add a blocker
> for volatile ram blocks.
> 
> Also add a blocker for RAM_GUEST_MEMFD.  Preserving guest_memfd may be
> sufficient for CPR, but it has not been tested yet.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> ---
>   include/exec/memory.h   |  3 +++
>   include/exec/ramblock.h |  1 +
>   migration/savevm.c      |  2 ++
>   system/physmem.c        | 68 +++++++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 74 insertions(+)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 9f73b59..ea5d33a 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -3184,6 +3184,9 @@ bool ram_block_discard_is_disabled(void);
>    */
>   bool ram_block_discard_is_required(void);
>   
> +void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp);
> +void ram_block_del_cpr_blocker(RAMBlock *rb);
> +
>   #endif
>   
>   #endif
> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
> index 0babd10..64484cd 100644
> --- a/include/exec/ramblock.h
> +++ b/include/exec/ramblock.h
> @@ -39,6 +39,7 @@ struct RAMBlock {
>       /* RCU-enabled, writes protected by the ramlist lock */
>       QLIST_ENTRY(RAMBlock) next;
>       QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
> +    Error *cpr_blocker;
>       int fd;
>       uint64_t fd_offset;
>       int guest_memfd;
> diff --git a/migration/savevm.c b/migration/savevm.c
> index bc375db..85a3559 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -3315,12 +3315,14 @@ void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
>       qemu_ram_set_idstr(mr->ram_block,
>                          memory_region_name(mr), dev);
>       qemu_ram_set_migratable(mr->ram_block);
> +    ram_block_add_cpr_blocker(mr->ram_block, &error_fatal);
>   }
>   
>   void vmstate_unregister_ram(MemoryRegion *mr, DeviceState *dev)
>   {
>       qemu_ram_unset_idstr(mr->ram_block);
>       qemu_ram_unset_migratable(mr->ram_block);
> +    ram_block_del_cpr_blocker(mr->ram_block);
>   }
>   
>   void vmstate_register_ram_global(MemoryRegion *mr)
> diff --git a/system/physmem.c b/system/physmem.c
> index 67c9db9..c416068 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -70,7 +70,10 @@
>   
>   #include "qemu/pmem.h"
>   
> +#include "qapi/qapi-types-migration.h"
> +#include "migration/blocker.h"
>   #include "migration/cpr.h"
> +#include "migration/options.h"
>   #include "migration/vmstate.h"
>   
>   #include "qemu/range.h"
> @@ -1899,6 +1902,14 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>               qemu_mutex_unlock_ramlist();
>               goto out_free;
>           }
> +
> +        error_setg(&new_block->cpr_blocker,
> +                   "Memory region %s uses guest_memfd, "
> +                   "which is not supported with CPR.",
> +                   memory_region_name(new_block->mr));
> +        migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
> +                                  MIG_MODE_CPR_TRANSFER,
> +                                  -1);
>       }
>   
>       ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;
> @@ -4059,3 +4070,60 @@ bool ram_block_discard_is_required(void)
>       return qatomic_read(&ram_block_discard_required_cnt) ||
>              qatomic_read(&ram_block_coordinated_discard_required_cnt);
>   }
> +
> +/*
> + * Return true if ram contents would be lost during CPR.  Do not exclude rom,
> + * because the rom file could change in new QEMU.
> + */
> +static bool ram_is_volatile(RAMBlock *rb)

Can we call this

ram_is_cpr_compatible() / ram_is_cpr_incompatible() or sth. instead?

Talking about RAM and "volatile" is misleading, and the function is 
specific to CPR already (e.g., comment :) ).


-- 
Cheers,

David / dhildenb


