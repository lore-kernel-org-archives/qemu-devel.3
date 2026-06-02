Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4704CD5BD1
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 13:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUPJW-000864-VF; Tue, 02 Jun 2026 09:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1wUPJQ-00083L-NZ
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 09:37:47 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1wUPJO-0008EB-Bk
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 09:37:43 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4797543C76;
 Tue,  2 Jun 2026 13:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6881F00893;
 Tue,  2 Jun 2026 13:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780407460;
 bh=L2yYvGox/EKJMaBAWf+A3p/3pD/YEYEC5qxLfCCvIUE=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=ePQEfnHF3lAqEpyV3svyZJ1RHPpytVOx27Q1FVnUuxIo5OQYllQIdP0vMHF1eQV5M
 NKMyqHXWGYx4dfGUMM3qNiZxbJwyvWC0nA8+foXMMRme/ntOnqnpcRQ0RcjTKjTsW4
 o9R870RLF6HmpOAqU0eHBbrMAAPi81RoFxzcEwIUdnEzpfWguB++p3NIqYyHU2ecoz
 b94XotP1s6qqKOj2Ke7O7lxzqN6pcI0no17pNEjmHqyCXOoO3r5J4yCRLNi/LJHSs0
 jCgaTwpYJX4IkjaqD3rlqEyphjckhbK1KMpIn697SweO9ZmQZIvbrS5Bsm9To/wWkn
 2aFNKmmMC2SoA==
Message-ID: <288eac74-0eb8-4aa6-8238-0fc00e1e50e7@kernel.org>
Date: Tue, 2 Jun 2026 15:37:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/13] system/ram-discard-manager: implement replay via
 is_populated iteration
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
 <20260504-rdm5-v4-4-bdf61e57c1e1@redhat.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260504-rdm5-v4-4-bdf61e57c1e1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=david@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/4/26 14:30, Marc-André Lureau wrote:
> Replace the source-level replay wrappers with a new
> replay_by_populated_state() helper that iterates the section at
> min-granularity, calls is_populated() for each chunk, and aggregates
> consecutive chunks of the same state before invoking the callback.
> 
> This moves the iteration logic from individual sources into the manager,
> preparing for multi-source aggregation where the manager must combine
> state from multiple sources anyway.
> 
> The replay_populated/replay_discarded vtable entries in
> RamDiscardSourceClass are no longer called but remain in the interface
> for now; they will be removed in follow-up commits along with the
> now-dead source implementations.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  system/ram-discard-manager.c | 85 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 61 insertions(+), 24 deletions(-)
> 
> diff --git a/system/ram-discard-manager.c b/system/ram-discard-manager.c
> index 1c9ff7fda58..a907ddf3708 100644
> --- a/system/ram-discard-manager.c
> +++ b/system/ram-discard-manager.c
> @@ -27,26 +27,65 @@ static bool ram_discard_source_is_populated(const RamDiscardSource *rds,
>      return rdsc->is_populated(rds, section);
>  }
>  
> -static int ram_discard_source_replay_populated(const RamDiscardSource *rds,
> -                                               const MemoryRegionSection *section,
> -                                               ReplayRamDiscardState replay_fn,
> -                                               void *opaque)
> +/*
> + * Iterate the section at source granularity, aggregating consecutive chunks
> + * with matching populated state, and call replay_fn for each run.
> + */
> +static int replay_by_populated_state(const RamDiscardManager *rdm,
> +                                     const MemoryRegionSection *section,
> +                                     bool replay_populated,
> +                                     ReplayRamDiscardState replay_fn,
> +                                     void *opaque)
>  {
> -    RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_GET_CLASS(rds);
> +    uint64_t granularity, offset, size, end, pos, run_start = 0;
> +    bool in_run = false;
> +    int ret = 0;
>  
> -    g_assert(rdsc->replay_populated);
> -    return rdsc->replay_populated(rds, section, replay_fn, opaque);
> -}
> +    granularity = ram_discard_source_get_min_granularity(rdm->rds, rdm->mr);
> +    offset = section->offset_within_region;
> +    size = int128_get64(section->size);
> +    end = offset + size;
> +
> +    /* Align iteration to granularity boundaries */
> +    pos = QEMU_ALIGN_DOWN(offset, granularity);
> +
> +    for (; pos < end; pos += granularity) {
> +        MemoryRegionSection chunk = {
> +            .mr = section->mr,
> +            .offset_within_region = pos,
> +            .size = int128_make64(granularity),
> +        };
> +        bool populated = ram_discard_source_is_populated(rdm->rds, &chunk);
> +
> +        if (populated == replay_populated) {
> +            if (!in_run) {
> +                run_start = pos;
> +                in_run = true;
> +            }
> +        } else if (in_run) {
> +            MemoryRegionSection tmp = *section;
> +
> +            if (memory_region_section_intersect_range(&tmp, run_start,
> +                                                      pos - run_start)) {
> +                ret = replay_fn(&tmp, opaque);
> +                if (ret) {
> +                    return ret;
> +                }
> +            }
> +            in_run = false;
> +        }
> +    }
>  
> -static int ram_discard_source_replay_discarded(const RamDiscardSource *rds,
> -                                               const MemoryRegionSection *section,
> -                                               ReplayRamDiscardState replay_fn,
> -                                               void *opaque)
> -{
> -    RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_GET_CLASS(rds);
> +    if (in_run) {
> +        MemoryRegionSection tmp = *section;
>  
> -    g_assert(rdsc->replay_discarded);
> -    return rdsc->replay_discarded(rds, section, replay_fn, opaque);
> +        if (memory_region_section_intersect_range(&tmp, run_start,
> +                                                  pos - run_start)) {
> +            ret = replay_fn(&tmp, opaque);
> +        }
> +    }
> +
> +    return ret;
>  }
>  
>  RamDiscardManager *ram_discard_manager_new(MemoryRegion *mr,
> @@ -78,8 +117,7 @@ int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
>                                           ReplayRamDiscardState replay_fn,
>                                           void *opaque)
>  {
> -    return ram_discard_source_replay_populated(rdm->rds, section,
> -                                               replay_fn, opaque);
> +    return replay_by_populated_state(rdm, section, true, replay_fn, opaque);
>  }
>  
>  int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
> @@ -87,8 +125,7 @@ int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
>                                           ReplayRamDiscardState replay_fn,
>                                           void *opaque)
>  {
> -    return ram_discard_source_replay_discarded(rdm->rds, section,
> -                                               replay_fn, opaque);
> +    return replay_by_populated_state(rdm, section, false, replay_fn, opaque);
>  }
>  
>  static void ram_discard_manager_initfn(Object *obj)
> @@ -182,8 +219,8 @@ void ram_discard_manager_register_listener(RamDiscardManager *rdm,
>      rdl->section = memory_region_section_new_copy(section);
>      QLIST_INSERT_HEAD(&rdm->rdl_list, rdl, next);
>  
> -    ret = ram_discard_source_replay_populated(rdm->rds, rdl->section,
> -                                              rdm_populate_cb, rdl);
> +    ret = ram_discard_manager_replay_populated(rdm, rdl->section,
> +                                               rdm_populate_cb, rdl);
>      if (ret) {
>          error_report("%s: Replaying populated ranges failed: %s", __func__,
>                       strerror(-ret));
> @@ -208,8 +245,8 @@ int ram_discard_manager_replay_populated_to_listeners(RamDiscardManager *rdm)
>      int ret = 0;
>  
>      QLIST_FOREACH(rdl, &rdm->rdl_list, next) {
> -        ret = ram_discard_source_replay_populated(rdm->rds, rdl->section,
> -                                                  rdm_populate_cb, rdl);
> +        ret = ram_discard_manager_replay_populated(rdm, rdl->section,
> +                                                   rdm_populate_cb, rdl);

I'm probably missing something. You are changing the parameters passed to
ram_discard_manager_replay_populated(), but
ram_discard_manager_replay_populated() is not actually modified in this patch to
take other parameters?

-- 
Cheers,

David

