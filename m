Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE482CD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 20:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNGas-0003JL-2h; Wed, 13 May 2026 16:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNGan-0003It-7r
 for qemu-devel@nongnu.org; Wed, 13 May 2026 16:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNGaj-0007pd-2T
 for qemu-devel@nongnu.org; Wed, 13 May 2026 16:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778705632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xBsbTsQL+RdPv4rNwOcq5N/qO54s6H3PYvM8W6XdmOg=;
 b=LXXdYyKeu7JMQbiLcBUDLscfzv9jpJSsMwcUPhayaEuHLWTqqDLiiHT4vlknxXwPqcWlKj
 b47TuuZ3glkjdG3kxIWgnsnf+bVHisPDTZVG7Dejak+ZndNg/ZSclvvhd9eOj5AyvXHm/c
 Y5aQqMX+Y4Tco+uPajeiOwMOAltDi4Q=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-i0zklQP2NHikdP0DVgZwtg-1; Wed, 13 May 2026 16:53:50 -0400
X-MC-Unique: i0zklQP2NHikdP0DVgZwtg-1
X-Mimecast-MFC-AGG-ID: i0zklQP2NHikdP0DVgZwtg_1778705630
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50faf575af4so166098361cf.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 13:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778705630; x=1779310430; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xBsbTsQL+RdPv4rNwOcq5N/qO54s6H3PYvM8W6XdmOg=;
 b=fhz4WPULJ4Pgt+iTxAslHkw0IwzBW8QKRPjauzzgoISBGQxip7vFfu+GBB5Qy11lDl
 QPiZlnjTWopi7XzwhhY6MmbpcDKENa4VZey6UO7zQJItkG7fBvtBKEZdgZfNkdKLFZC5
 GQvPXToWkyrxel56Qw5LFYsr9Wevq/CM0QhokwADErc2bKVxZM1KQZ7MLfrBziIXUBPv
 dHQ25U/jtzgKUnF/H0WIXiDaIxUjVVfq5XF/OGc1j2B1E0oSZD3azCEEmqFo0ZaFqBLs
 naWBCsVC49eGP9hjmVyaMNSb23Fl5N6buCG4qGoKjbfoAEVEZqmzUu5s05QOHQqW8wdH
 U7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778705630; x=1779310430;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xBsbTsQL+RdPv4rNwOcq5N/qO54s6H3PYvM8W6XdmOg=;
 b=lJV90Pb79OZpPn3XbNuvaEKg5oLenQ6oG72f15Zzr4xs2GKNKxWrxKqBousnPqiI1c
 lbh1ht0yf3A9EZZr7Xx1PaRtoBJObREXi7BoEF4LUjFZCz4zP/2EE5ZanZ/vSU2NPVqv
 F2fFFY0s8cVNX5hH2xXcg96Ta2ozArm4JpkVA5qcOYwDrxdUPGIkeKKYpWF4IdJiOthW
 DqPJlsrus+/7cvgYYpgQaxgtsZzzEZRrcBWL/Gc732p68AHjCJ0blkK0A/F+xv9wLj9t
 iblREGB5FhKFwbqPZ5caUcfxEbiYWKnxhG0wVzHgXr8dXQoG7ndacsRwTHygsP5EL/ps
 ss6A==
X-Gm-Message-State: AOJu0YyQDKnp0S/9PwdQcboA3lBGpbqMLIplMb1KqzEKnhfeSgjY5cwh
 hzgHusqyLm+MmZ6Y6IXxBiPVmxFwmHZNMZolwKuebMy+YtM6fzr3+b6Bo+MsEHZ15P1pw7MP4w0
 w+7fcAj+ldkVXOyISbHVW4LhPqXtCCgd1IM23BLNz9utV1emougRKp6nh
X-Gm-Gg: Acq92OHNuSeNWFGksSimUUJCZnPucMHAQVuBfKl0E8Pz5J2+M6pxaC6vZi9gECIC9DY
 4eghLjygFqIUrB1eYmEjcYcMm9VtVqc70rdNUVU3ifXGM3LD6e+w3UzPaDMwRDaJW/0yEmd1jt0
 GNOJSVk2jWe9+mE9LLFBK8IQv8g21L9WI/9prm0+M3UJamWIfFn7Atg20ASFQ5ZLiSHoDktOywd
 oGFN3v4dO163SxSKpEErrDlEfGgq9g1vpyhfTcoXNxaTSOxkfP85DkZ+uwIF8aqVCgV2u4jW39l
 EA6zu7KVU4EaCWVQNcCfIVSFidL2Otn+kDuN/OsHMP4aj1CpH02hD7Lk0f+ZQ+6pQAsx8nEFKgH
 jb3m9NglvuDvL0yobDw7d2W5fVzVwSkBo9xlUYHL6ZCcS/eQ=
X-Received: by 2002:a05:622a:145:b0:50f:ba62:c328 with SMTP id
 d75a77b69052e-5162f4c4df5mr68808271cf.22.1778705630132; 
 Wed, 13 May 2026 13:53:50 -0700 (PDT)
X-Received: by 2002:a05:622a:145:b0:50f:ba62:c328 with SMTP id
 d75a77b69052e-5162f4c4df5mr68807971cf.22.1778705629643; 
 Wed, 13 May 2026 13:53:49 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5148e7bef56sm158300701cf.15.2026.05.13.13.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 13:53:49 -0700 (PDT)
Date: Wed, 13 May 2026 16:53:48 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 00/13] Make RamDiscardManager work with multiple
 sources & virtio-mem
Message-ID: <agTk3NSZaI9IwlUs@x1.local>
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 04, 2026 at 04:30:06PM +0400, Marc-André Lureau wrote:
> Hi,
> 
> This is an attempt to fix the incompatibility of virtio-mem with confidential
> VMs. The solution implements what was discussed earlier with D. Hildenbrand:
> https://patchwork.ozlabs.org/project/qemu-devel/patch/20250407074939.18657-5-chenyi.qiang@intel.com/#3502238
> 
> The first patches are misc cleanups. Then some code refactoring to have split a
> manager/source. And finally, the manager learns to deal with multiple sources.
> 
> I haven't done thorough testing. I only launched a SEV guest with a virtio-mem
> device. It would be nice to have more tests for those scenarios with
> VFIO/virtio-mem/confvm.. In any case, review & testing needed!
> 
> (help fix https://issues.redhat.com/browse/RHEL-131968)

Copy David for virtio-mem: David, please see if you're OK with virtio-mem
side of things; if you have time look at everything it'll be even better.

Copy Chenyi: would you please check with your environment on whether you
still hit issue with this series?

The whole series can be found here:

https://lore.kernel.org/all/20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com/

Side note: this version still contain quite some "over 80 chars" checkpatch
complains... please consider fixing them when repost.

Thanks,

> 
> v4:
>  - added "system/physmem: make ram_block_discard_range() handle guest_memfd"
>  - added "monitor: add 'info ramblock-attributes' command"
>  - added "RFC: hw/virtio: start virtio-mem guest_memfd regions as shared"
>  - skip calling source in notify_populate (it may not have updated its
>    internal state)
>  - rebased, collected trailer tags
> 
> v3: issues found by Cédric
>  - fix assertion error on shutdown, due to rcu-defer cleanup
>  - fix API doc warnings
> 
> v2:
>  - drop replay_{populated,discarded} from source, suggested by Peter Xu
>  - add extra manager cleanup
>  - add r-b tags for preliminary patches
> 
> ---
> Marc-André Lureau (13):
>       system/memory: split RamDiscardManager into source and manager
>       system/memory: move RamDiscardManager to separate compilation unit
>       system/memory: constify section arguments
>       system/ram-discard-manager: implement replay via is_populated iteration
>       virtio-mem: remove replay_populated/replay_discarded implementation
>       system/ram-discard-manager: drop replay from source interface
>       system/memory: implement RamDiscardManager multi-source aggregation
>       system/physmem: destroy ram block attributes before RCU-deferred reclaim
>       system/memory: add RamDiscardManager reference counting and cleanup
>       tests: add unit tests for RamDiscardManager multi-source aggregation
>       system/physmem: make ram_block_discard_range() handle guest_memfd
>       monitor: add 'info ramblock-attributes' command
>       RFC: hw/virtio: start virtio-mem guest_memfd regions as shared
> 
>  MAINTAINERS                                 |    4 +
>  qapi/machine.json                           |   55 ++
>  include/hw/vfio/vfio-container.h            |    2 +-
>  include/hw/vfio/vfio-cpr.h                  |    2 +-
>  include/hw/virtio/virtio-mem.h              |    3 -
>  include/monitor/hmp.h                       |    1 +
>  include/system/memory.h                     |  283 +-----
>  include/system/ram-discard-manager.h        |  358 ++++++++
>  include/system/ramblock.h                   |    6 +-
>  accel/kvm/kvm-all.c                         |    5 +-
>  hw/core/machine-hmp-cmds.c                  |   32 +
>  hw/vfio/cpr-legacy.c                        |    4 +-
>  hw/vfio/listener.c                          |   10 +-
>  hw/virtio/virtio-mem.c                      |  286 ++-----
>  migration/ram.c                             |    6 +-
>  system/memory.c                             |   83 +-
>  system/memory_mapping.c                     |    4 +-
>  system/physmem.c                            |   27 +-
>  system/ram-block-attributes.c               |  329 +++----
>  system/ram-discard-manager.c                |  612 +++++++++++++
>  target/i386/kvm/tdx.c                       |    2 +-
>  tests/unit/test-ram-discard-manager-stubs.c |   48 ++
>  tests/unit/test-ram-discard-manager.c       | 1235 +++++++++++++++++++++++++++
>  hmp-commands-info.hx                        |   13 +
>  rust/bindings/system-sys/lib.rs             |    2 +-
>  system/meson.build                          |    1 +
>  system/trace-events                         |    2 +-
>  tests/unit/meson.build                      |    8 +-
>  28 files changed, 2597 insertions(+), 826 deletions(-)
> ---
> base-commit: ac0cc20ad2fe0b8df2e5d9458e90a095ac711ab1
> change-id: 20260414-rdm5-b6df2366d603
> 
> Best regards,
> --  
> Marc-André Lureau <marcandre.lureau@redhat.com>
> 

-- 
Peter Xu


