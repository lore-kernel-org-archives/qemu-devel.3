Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A9DCFB448
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 15:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxpzQ-00013y-8H; Mon, 07 Oct 2024 11:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxpzP-00013l-5Z
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:49:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxpzJ-0002lM-PC
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728316171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v2wZIjLwwYnrSSzvBQd2vmwV2H/LNFvZVk2rtq6DaZE=;
 b=Z6DQy9VY8k5p1qb9caTM95krE/zjpypngFOIG1DeD0JT4nMH7wFp9fRNdPSW3K5s8+nkZR
 Yg5HsWq4lVuulsPMZHXVMMqZ+sZhRLPvjCpTlXqXrTdXfFBBD4anNYQTY9y3yEcg4plB/J
 Gev7cEuSDMeWWY+6qC54xdLi4GW/6+o=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296--UAV5PTkOqytoxhcFq-PgQ-1; Mon, 07 Oct 2024 11:49:30 -0400
X-MC-Unique: -UAV5PTkOqytoxhcFq-PgQ-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-82cea2c4e35so560915739f.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 08:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728316169; x=1728920969;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v2wZIjLwwYnrSSzvBQd2vmwV2H/LNFvZVk2rtq6DaZE=;
 b=CpDzsoTrz3hzWB58XVnKSYv0bZGyY5MSx6HcyymAfLC3QuNg6ksPfw9e+qo470myRN
 ByJ1DgkU4ZD6f6w3OhcmwRt7rg+s//j1iqeY6BbD4a5s6kT1POvZhQupBnLJbiKUeHu2
 kt6C76skxylp1L/CUl81e+r5AzHOzbav831tD8Hj23n6AOQ9VSKQkehO62Mx6vnc/pBx
 Jnk4NKer9elHPar1G+QUZkXzTTKky0da05LeN1gNnim+ya1PBiXLK9cyyNeBPCu5JFbX
 6MBdUY1zKXl4myW4b2hnKERIjknTKqVY9AHLg7dVBJLyY95O9KvzXBUwIxMy8C9Hrxlj
 mzEw==
X-Gm-Message-State: AOJu0Yx8Khk2tZGAQE6WAoqKt5slY+klfVayOeGHnrDnhc3/uDB5Nn4k
 DmWNvqR5xJnaQCuHCp2ZsX+zPLHRO61VdAJG4nhVzJa2rvBTdzAKQvZ1fTX10RK42/q7OA6hs9w
 Wzqd2kRaccDP8caKc7XxFmRdrYUKRbY1x43uP565GmEZWk6nlrS6j
X-Received: by 2002:a05:6602:2dc6:b0:82a:ab20:f4bf with SMTP id
 ca18e2360f4ac-834f7c73c2dmr1167347439f.1.1728316169305; 
 Mon, 07 Oct 2024 08:49:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBGcYxNL4ru4ak0GtFMHD7X/pGpZ7FhdY8Qmil0ryWmShmhNfnEE12gRh1Py+ACeYhE2tMuA==
X-Received: by 2002:a05:6602:2dc6:b0:82a:ab20:f4bf with SMTP id
 ca18e2360f4ac-834f7c73c2dmr1167342939f.1.1728316168734; 
 Mon, 07 Oct 2024 08:49:28 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83503b30889sm129380539f.52.2024.10.07.08.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 08:49:28 -0700 (PDT)
Date: Mon, 7 Oct 2024 11:49:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2 05/13] physmem: preserve ram blocks for cpr
Message-ID: <ZwQDBc-8niK2A0Vt@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-6-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1727725244-105198-6-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Sep 30, 2024 at 12:40:36PM -0700, Steve Sistare wrote:
> Save the memfd for anonymous ramblocks in CPR state, along with a name
> that uniquely identifies it.  The block's idstr is not yet set, so it
> cannot be used for this purpose.  Find the saved memfd in new QEMU when
> creating a block.  QEMU hard-codes the length of some internally-created
> blocks, so to guard against that length changing, use lseek to get the
> actual length of an incoming memfd.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  system/physmem.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index 174f7e0..ddbeec9 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -72,6 +72,7 @@
>  
>  #include "qapi/qapi-types-migration.h"
>  #include "migration/options.h"
> +#include "migration/cpr.h"
>  #include "migration/vmstate.h"
>  
>  #include "qemu/range.h"
> @@ -1663,6 +1664,19 @@ void qemu_ram_unset_idstr(RAMBlock *block)
>      }
>  }
>  
> +static char *cpr_name(RAMBlock *block)
> +{
> +    MemoryRegion *mr = block->mr;
> +    const char *mr_name = memory_region_name(mr);
> +    g_autofree char *id = mr->dev ? qdev_get_dev_path(mr->dev) : NULL;
> +
> +    if (id) {
> +        return g_strdup_printf("%s/%s", id, mr_name);
> +    } else {
> +        return g_strdup(mr_name);
> +    }
> +}
> +
>  size_t qemu_ram_pagesize(RAMBlock *rb)
>  {
>      return rb->page_size;
> @@ -1858,14 +1872,18 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>                                          TYPE_MEMORY_BACKEND)) {
>              size_t max_length = new_block->max_length;
>              MemoryRegion *mr = new_block->mr;
> -            const char *name = memory_region_name(mr);
> +            g_autofree char *name = cpr_name(new_block);
>  
>              new_block->mr->align = QEMU_VMALLOC_ALIGN;
>              new_block->flags |= RAM_SHARED;
> +            new_block->fd = cpr_find_fd(name, 0);
>  
>              if (new_block->fd == -1) {
>                  new_block->fd = qemu_memfd_create(name, max_length + mr->align,
>                                                    0, 0, 0, errp);
> +                cpr_save_fd(name, 0, new_block->fd);
> +            } else {
> +                new_block->max_length = lseek(new_block->fd, 0, SEEK_END);

So this can overwrite the max_length that the caller specified..

I remember we used to have some tricks on specifying different max_length
for ROMs on dest QEMU (on which, qemu firmwares also upgraded on the dest
host so the size can be bigger than src qemu's old ramblocks), so that the
MR is always large enough to reload even the new firmwares, while migration
only migrates the smaller size (used_length) so it's fine as we keep the
extra sizes empty. I think that can relevant to the qemu_ram_resize() call
of parse_ramblock().

The reload will not happen until some point, perhaps system resets.  I
wonder whether that is an issue in this case.

+Igor +Mst for this.

>              }
>  
>              if (new_block->fd >= 0) {
> @@ -1875,6 +1893,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>                                                   false, 0, errp);
>              }
>              if (!new_block->host) {
> +                cpr_delete_fd(name, 0);
>                  qemu_mutex_unlock_ramlist();
>                  return;
>              }
> @@ -2182,6 +2201,8 @@ static void reclaim_ramblock(RAMBlock *block)
>  
>  void qemu_ram_free(RAMBlock *block)
>  {
> +    g_autofree char *name = NULL;
> +
>      if (!block) {
>          return;
>      }
> @@ -2192,6 +2213,8 @@ void qemu_ram_free(RAMBlock *block)
>      }
>  
>      qemu_mutex_lock_ramlist();
> +    name = cpr_name(block);
> +    cpr_delete_fd(name, 0);
>      QLIST_REMOVE_RCU(block, next);
>      ram_list.mru_block = NULL;
>      /* Write list before version */
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


