Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0395EC87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 12:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulRKd-0003O9-82; Mon, 11 Aug 2025 08:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ulRKa-0003NM-UI
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:08:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ulRKV-0003x7-Rj
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754914121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5bGHoJIT1iPxMNUCgiJ/hTncNT2mPplt6rnMhNmH5GA=;
 b=aLlVpLYULmjiFpSRhxl2MPWTUXiVY7GHp7TlHhzzGyYvcCvSJCYByg4yO0zDP91uKqNQxC
 uIQwIacNszOyazk762qOmKY5nQ0CxbFGnQWwrFJmy858uFd5OfiwbS1THtNPPuwqGdxKx4
 9c3ykcJuKcQsnIXuiWwUCaDb940vJ3A=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-fz9c3V43MJqL-yB1hdBA9A-1; Mon, 11 Aug 2025 08:08:40 -0400
X-MC-Unique: fz9c3V43MJqL-yB1hdBA9A-1
X-Mimecast-MFC-AGG-ID: fz9c3V43MJqL-yB1hdBA9A_1754914119
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7e826e0d7abso901009885a.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 05:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754914119; x=1755518919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5bGHoJIT1iPxMNUCgiJ/hTncNT2mPplt6rnMhNmH5GA=;
 b=hz3/Xm47nXiFkMtrMB9YPfaZyZ9HSfOX+45WZSIu7mBY6DTxSnk/efndJczqLbeJzx
 Aevb/CKUeaUDt8m9kjsBIQ/1oKfwfGB67f816flhcvCnZAyBI8ngPtT4qh+BG1dXX2RE
 yM8cSc/leXlemxICznCR/UjjNQ7tIUVqzMrJgYok0wupSsdNdTclMg6NN7sKg706oias
 YtrpSZa+q+dhJiYTq7hQqbCPGId7yWU81E7hvCgB2KwxwQfx7FzIv6c3MU//goU/wwVS
 arlJYEGNmVXbhvhoUTVDhzTSqas+01X5nqLKGCXTrhYkX6ovpWuh49/VVcV9sG9px0kk
 mBlA==
X-Gm-Message-State: AOJu0YxWKFexBiA+NWsMuvyUI03XAiq4fMJeBdPVzoJJxPOHK7bMvAjT
 DebKCd2hBwDcRQ2x7W43g6t8KBtJX8BVy9OHKaHaAmdKEX3m3aLXjXkU6qty9w0NjKug157/6OS
 eGUEu2CqrlBd2nRKm7HwB+Y9+GuJfTthbcbgyx18SoI8Ys8md9vDQrfHH
X-Gm-Gg: ASbGncujJE6poMUc2E3kIFHMxoFkKo/52Jy5DUHfHiNAaKoSG4F1y7QG0HVqH9Hz9Vv
 RVNCdZv5l70O/1TPtiAftmaTAuKoaWNwiawyZUwihPoOWy7yEK+IHlZxg9qt9prGpPlYB8FqtZK
 QEe+cIcMEZiKvBlwcjrqi/evLaCPIUzIBxqm6gytUzwtGvYfAs8W3YG3nOCS7fnPNH+i1xtGmBg
 BMsQGO95KR4Rlw8pcRNLsc7I1gvoEDik2jPUOfieTHlWaOJAzmRSoU7BYlh7wSF8JSxPwB5LDPm
 vfpj0ag8M3EyQU9KQ0i1hQBHit/klw==
X-Received: by 2002:a05:620a:4406:b0:7e8:7e6:af69 with SMTP id
 af79cd13be357-7e82c6ac4f7mr1918860085a.28.1754914119444; 
 Mon, 11 Aug 2025 05:08:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGSNVh7Xv5wRznCmGY1V5Wp8DgONegPqAFSnpyWS60x/ZMEdDSCMCFfz5NA8zjNidtkv68dQ==
X-Received: by 2002:a05:620a:4406:b0:7e8:7e6:af69 with SMTP id
 af79cd13be357-7e82c6ac4f7mr1918855885a.28.1754914119014; 
 Mon, 11 Aug 2025 05:08:39 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e822b6c47esm665770085a.39.2025.08.11.05.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 05:08:38 -0700 (PDT)
Date: Mon, 11 Aug 2025 14:08:36 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, philmd@linaro.org, mtosatti@redhat.com
Subject: Re: [PATCH v3 01/10] memory: reintroduce BQL-free fine-grained
 PIO/MMIO
Message-ID: <20250811140836.5f9b9e27@fedora>
In-Reply-To: <f9da47d9-1278-4453-ba16-8ca813074478@redhat.com>
References: <20250808120137.2208800-1-imammedo@redhat.com>
 <20250808120137.2208800-2-imammedo@redhat.com>
 <2de4fa21-a9ec-454a-9c10-39dd77e16f38@redhat.com>
 <20250808163635.461b52c7@fedora>
 <f9da47d9-1278-4453-ba16-8ca813074478@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Fri, 8 Aug 2025 17:24:54 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 08.08.25 16:36, Igor Mammedov wrote:
> > On Fri, 8 Aug 2025 14:12:54 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> On 08.08.25 14:01, Igor Mammedov wrote:  
> >>> This patch brings back Jan's idea [1] of BQL-free IO access
> >>>
> >>> This will let us make access to ACPI PM/HPET timers cheaper,
> >>> and prevent BQL contention in case of workload that heavily
> >>> uses the timers with a lot of vCPUs.
> >>>
> >>> 1) 196ea13104f (memory: Add global-locking property to memory regions)
> >>>      ... de7ea885c539 (kvm: Switch to unlocked MMIO)
> >>>
> >>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >>> ---
> >>> v3:
> >>>     add comment for 'mr->disable_reentrancy_guard = true'
> >>>       Peter Xu <peterx@redhat.com>
> >>> ---
> >>>    include/system/memory.h | 10 ++++++++++
> >>>    system/memory.c         | 15 +++++++++++++++
> >>>    system/physmem.c        |  2 +-
> >>>    3 files changed, 26 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/include/system/memory.h b/include/system/memory.h
> >>> index e2cd6ed126..d04366c994 100644
> >>> --- a/include/system/memory.h
> >>> +++ b/include/system/memory.h
> >>> @@ -833,6 +833,7 @@ struct MemoryRegion {
> >>>        bool nonvolatile;
> >>>        bool rom_device;
> >>>        bool flush_coalesced_mmio;
> >>> +    bool lockless_io;
> >>>        bool unmergeable;
> >>>        uint8_t dirty_log_mask;
> >>>        bool is_iommu;
> >>> @@ -2341,6 +2342,15 @@ void memory_region_set_flush_coalesced(MemoryRegion *mr);
> >>>     */
> >>>    void memory_region_clear_flush_coalesced(MemoryRegion *mr);
> >>>    
> >>> +/**
> >>> + * memory_region_enable_lockless_io: Enable lockless (BQL free) acceess.
> >>> + *
> >>> + * Enable BQL-free access for devices with fine-grained locking.
> >>> + *
> >>> + * @mr: the memory region to be updated.
> >>> + */
> >>> +void memory_region_enable_lockless_io(MemoryRegion *mr);  
> >>
> >> Is this safe to use on any IO region, or could actually something break
> >> when mis-used? In case it's the latter, I assume we would want to
> >> carefully document under which scenarios this is safe to use.  
> > 
> > "for devices with fine-grained locking" is defining scope of where it's
> > applicable, in another words devices enabling this need to take care
> > of any locking if necessary.  
> 
> Okay, I would have stressed that a bit more, something like
> 
> "Enable BQL-free access for devices that are well prepared to handle 
> locking during I/O themselves: either by doing fine grained locking or 
> by providing lock-free I/O schemes."

Thank,
I'll fix it up on respin

> 
> Nothing else jumped at me.
> 


