Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92B0C25B74
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 18:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s58gP-0003NL-Ef; Thu, 09 May 2024 14:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s58gN-0003NA-DW
 for qemu-devel@nongnu.org; Thu, 09 May 2024 14:39:55 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s58gK-0001sa-Vr
 for qemu-devel@nongnu.org; Thu, 09 May 2024 14:39:54 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EC120605F7;
 Thu,  9 May 2024 18:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715279991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OE63MybdltupL0JvUy/u759UKkQmKL4z1Ri1QnMk30k=;
 b=xlQryjUk/0fCDQB22BDdCiot5sh0sNvcxWg+5OyQ+REXpCXOpRTmcxDTf+OxogLQ+/s9SB
 7lZ9sPq2kH+WSEBSNaZrD6KT7XMeExn4wuLe93nHpvrSIYBFV891dyTn7mSYSYb8CuRwWj
 DnIVhOI4z4mLI/fDp0Nu1K9yOrIpAhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715279991;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OE63MybdltupL0JvUy/u759UKkQmKL4z1Ri1QnMk30k=;
 b=K6Wy7ZtVDYLTbL0IpzD1oGXPt5jVw0VCIA4O+uPSp4kC5GE9RXW7xnL4v3SxwfXkX7BZ56
 lXEKxipTWxJPsbAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xAJu2iyX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/VR+v3bL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715279990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OE63MybdltupL0JvUy/u759UKkQmKL4z1Ri1QnMk30k=;
 b=xAJu2iyXUw+wfOR+QaR8S4ZIgjPAnDynsoTD1p4gT/IOpIR4yGIt3xZx/i7sPa9P2wzgqq
 sLzuDPhHRkuCWRgeSUjFnEWb9GqTdS+JwyLYsJntWiB5bMj8y5mHg/w0E5pbA0r2cTSnli
 bR0S2X5G5UN006XLBvSmYqz5AdHgm30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715279990;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OE63MybdltupL0JvUy/u759UKkQmKL4z1Ri1QnMk30k=;
 b=/VR+v3bL0kwgfvXa62EQaxDuyM4l3tac+K/eBSyCQmU9maFD81b3lkt1nWmH9LeMlRMZGx
 6blwlm5DloI4c3CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F15713941;
 Thu,  9 May 2024 18:39:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id drPADXYYPWbsSAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 09 May 2024 18:39:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe Mathieu-Daude
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 25/26] migration: fix mismatched GPAs during cpr-exec
In-Reply-To: <1714406135-451286-26-git-send-email-steven.sistare@oracle.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-26-git-send-email-steven.sistare@oracle.com>
Date: Thu, 09 May 2024 15:39:47 -0300
Message-ID: <87le4ikex8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EC120605F7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWELVE(0.00)[12]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,habkost.net,gmail.com,linaro.org,oracle.com];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 TAGGED_RCPT(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MID_RHS_MATCH_FROM(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:email, oracle.com:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Steve Sistare <steven.sistare@oracle.com> writes:

> For cpr-exec mode, ramblock_is_ignored is always true, and the address of
> each migrated memory region must match the address of the statically
> initialized region on the target.  However, for a PCI rom block, the region
> address is set when the guest writes to a BAR on the source, which does not
> occur on the target, causing a "Mismatched GPAs" error during cpr-exec
> migration.
>
> To fix, unconditionally set the target's address to the source's address
> if the region does not have an address yet.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Just a detail below.

Reviewed-by: Fabiano Rosas <farosas@suse.de>

> ---
>  include/exec/memory.h | 12 ++++++++++++
>  migration/ram.c       | 15 +++++++++------
>  system/memory.c       | 10 ++++++++--
>  3 files changed, 29 insertions(+), 8 deletions(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index d337737..4f654b0 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -801,6 +801,7 @@ struct MemoryRegion {
>      bool unmergeable;
>      uint8_t dirty_log_mask;
>      bool is_iommu;
> +    bool has_addr;

This field is not used during memory access, maybe move it down below to
preserve the hole for future usage.

>      RAMBlock *ram_block;
>      Object *owner;
>      /* owner as TYPE_DEVICE. Used for re-entrancy checks in MR access hotpath */
> @@ -2402,6 +2403,17 @@ void memory_region_set_enabled(MemoryRegion *mr, bool enabled);
>  void memory_region_set_address(MemoryRegion *mr, hwaddr addr);
>  
>  /*
> + * memory_region_set_address_only: set the address of a region.
> + *
> + * Same as memory_region_set_address, but without causing transaction side
> + * effects.
> + *
> + * @mr: the region to be updated
> + * @addr: new address, relative to container region
> + */
> +void memory_region_set_address_only(MemoryRegion *mr, hwaddr addr);
> +
> +/*
>   * memory_region_set_size: dynamically update the size of a region.
>   *
>   * Dynamically updates the size of a region.
> diff --git a/migration/ram.c b/migration/ram.c
> index add285b..7b8d7f6 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4196,12 +4196,15 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
>      }
>      if (migrate_ignore_shared()) {
>          hwaddr addr = qemu_get_be64(f);
> -        if (migrate_ram_is_ignored(block) &&
> -            block->mr->addr != addr) {
> -            error_report("Mismatched GPAs for block %s "
> -                         "%" PRId64 "!= %" PRId64, block->idstr,
> -                         (uint64_t)addr, (uint64_t)block->mr->addr);
> -            return -EINVAL;
> +        if (migrate_ram_is_ignored(block)) {
> +            if (!block->mr->has_addr) {
> +                memory_region_set_address_only(block->mr, addr);
> +            } else if (block->mr->addr != addr) {
> +                error_report("Mismatched GPAs for block %s "
> +                             "%" PRId64 "!= %" PRId64, block->idstr,
> +                             (uint64_t)addr, (uint64_t)block->mr->addr);
> +                return -EINVAL;
> +            }
>          }
>      }
>      ret = rdma_block_notification_handle(f, block->idstr);
> diff --git a/system/memory.c b/system/memory.c
> index ca04a0e..3c72504 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2665,7 +2665,7 @@ static void memory_region_add_subregion_common(MemoryRegion *mr,
>      for (alias = subregion->alias; alias; alias = alias->alias) {
>          alias->mapped_via_alias++;
>      }
> -    subregion->addr = offset;
> +    memory_region_set_address_only(subregion, offset);
>      memory_region_update_container_subregions(subregion);
>  }
>  
> @@ -2745,10 +2745,16 @@ static void memory_region_readd_subregion(MemoryRegion *mr)
>      }
>  }
>  
> +void memory_region_set_address_only(MemoryRegion *mr, hwaddr addr)
> +{
> +    mr->addr = addr;
> +    mr->has_addr = true;
> +}
> +
>  void memory_region_set_address(MemoryRegion *mr, hwaddr addr)
>  {
>      if (addr != mr->addr) {
> -        mr->addr = addr;
> +        memory_region_set_address_only(mr, addr);
>          memory_region_readd_subregion(mr);
>      }
>  }

