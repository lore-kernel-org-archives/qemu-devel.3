Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7CD606A32C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GnQXezkC;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Di+qbpQm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWDXb-000706-Js; Wed, 25 Nov 2026 09:00:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWDXP-0006uY-AV
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:59:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWDXN-00057W-0j
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795615188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BKuKgHpO4vvmGwG2Bx0cjx/hUlzQL7fWxeFOZCQLnTo=;
 b=GnQXezkCCOTUobXOYdCPRg/FDkEPmxRZq/YjfhkDzNtShDMniNkxHGeXV8sDRCiqjBGWMf
 Ew7GKgSJVJI+ntWHNbdRjqfVb40sP90YVKuRlAxeeXUfgjzJOu44mvtOQRkDgXQMn4QMkZ
 LuRZfCwduLD8WVZH3La41me7isJZN3c=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-Jzfm6sw3NS2SXynwQcLggA-1; Wed, 25 Nov 2026 13:59:46 +0000
X-MC-Unique: Jzfm6sw3NS2SXynwQcLggA-1
X-Mimecast-MFC-AGG-ID: Jzfm6sw3NS2SXynwQcLggA_1795615186
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-55c16eb248eso95677311cf.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 05:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795615186; x=1796219986; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BKuKgHpO4vvmGwG2Bx0cjx/hUlzQL7fWxeFOZCQLnTo=;
 b=Di+qbpQmLxboYAAVxc4ImXy6hbqDBHyQuK+XjUA0MrhoEhYc6lJ7RusGmRsQygRlpo
 eQ/OisIXTbzDqPdg6LbRfl/uef7eRbup5igPMRZY9YJRxA9XC6W74tcvNFEgzm03cDHb
 B+JPIkDPRjADBwU5SH8nRzWVeAKgv0PHi16jIbNmpqvS2zNMXQs8kFDjwWa/UViK0rf2
 0qNTP5C5JtwRQ5tHXWS843W0TT+xBaC1W1RRkL4SFtqJgj3vSmEK2Ko2n/7B5V1bnzCu
 P9Dl2+82j13YLCp2uZMznkV6X2wem+MkNn/WelOWqpEzn+g2d3EZ3fesEl6a7zJS/Lka
 EX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795615186; x=1796219986;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BKuKgHpO4vvmGwG2Bx0cjx/hUlzQL7fWxeFOZCQLnTo=;
 b=nify4W9ncTnE4izffz805fNNBzENAneHfDBpCAbn0ZnLtqRRhYQ9F6Ksgsw+Z+g8bO
 aoHRQBeHIDMOaIfX8D1+FcctTB9sR1XrdbB7zMOXoBezOqlbEoT2Hc/p4EQ3ESP+AX1J
 lKIqL/7j0uDH7NzyTBs4b6lKm2sNC5L5ogpXvP8CYJTCXS069hdSTg1LbTa9UIDNHtGX
 AMSj7V+yLrwXO6+Ig1gAkJvkrkcJ0rjflrts9p0gVCwZ5zf9Dw7GnFjteqRnZB11zsPx
 BvUcUVKy9nif/Ivi8DYVZw/hFEYPKxe4H6YCOuyArXMiS0OrRxqy+ptmZRHKs4tJZZ8E
 p7zw==
X-Gm-Message-State: APuU4Z+ZXZE1NN8P0BZ+TPxtTngzWVArVkDwNqbY3/dBxODjxOY88Nvw
 tpxMx5KcyiaTcXjJHJ4F+CU3bQ3qKIGgpFeXZU1BvOIJqA1KmTdumxxrKths9BcqDXyVjXAkWjN
 yOVR1zijSGG0OzQLYHifBRTsTPvbLXUn/E8bNS1nFdkEXwDf3ihkR7O8G
X-Gm-Gg: AZFdTZdRVGCLD2lIwh0H8DYrHhd8rqvNG/THrWpegStLT1lhjhX0P6PrV2hTgfSRUdv
 DPDacx2WxO/8cF1qIDYQGYi+lBSh5f2LY+LbOnYDVWIC9sHbGXSZ0ReB1L/q3ss5vF88vGRhUli
 wAIIZiQuA2uoAsDAXoOV63Nl15QAXAIUl3N45YMhLDoZzwq8cpGeYfdRuMU/lpq131tJ182NGLr
 Vw7UnlgQUj62pjDUfvSMD2gZrYxfNiKxWSZLEcrdMbhBJJ5+KSf9acLzWHyT8bDtuyR8ORegbnw
 EOR7MbafmZOcXZu+zciAgw5vdGtTjkTY2y321sRarrBQOocS1irnYDy6vBZwRFk0z1WVWZTqP42
 taaOUX1EOMoV+dC/oilkgXDvJGRBYyqJWxIyti4bhVWpi
X-Received: by 2002:ac8:5a46:0:b0:533:2ef6:d98a with SMTP id
 d75a77b69052e-55d76a518c8mr353608401cf.29.1795615185538; 
 Wed, 25 Nov 2026 05:59:45 -0800 (PST)
X-Received: by 2002:ac8:5a46:0:b0:533:2ef6:d98a with SMTP id
 d75a77b69052e-55d76a518c8mr353607941cf.29.1795615185027; 
 Wed, 25 Nov 2026 05:59:45 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d7889ea4csm156926451cf.26.2026.11.25.05.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 05:59:44 -0800 (PST)
Date: Wed, 25 Nov 2026 08:59:43 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable@nongnu.org, Elliot Berman <eberman@anduril.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH-for-11.2?] system/memory: Invalidate TBs on ROM device
 mode switch
Message-ID: <awbpz7SZ5grn9gyi@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261124182722.78535-1-philmd@oss.qualcomm.com>
 <awXxps0Z4PjS85DT@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <eecb8487-0fca-4028-823d-f70215628f20@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eecb8487-0fca-4028-823d-f70215628f20@oss.qualcomm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 11:29:15PM +0100, Philippe Mathieu-Daudé wrote:
> On 24/11/26 21:20, Peter Xu wrote:
> > On Tue, Nov 24, 2026 at 07:27:22PM +0100, Philippe Mathieu-Daudé wrote:
> > > A ROM device changes its contents with direct stores while in MMIO
> > > mode. TCG does not see these stores, so translated blocks built from
> > > the old contents survive the switch back to ROMD mode and the guest
> > > executes stale code.
> > > 
> > > Make memory_region_rom_device_set_romd() drop the TBs of the whole
> > > region on both transitions: before leaving ROMD mode (if currently
> > > in it), and after entering ROMD mode, for TBs another vCPU built
> > > before its TLB was flushed.
> > 
> > Pure question: should we flush once, but only when ROMD->MMIO?  Said that,
> > IIUC we need to flush after switching to MMIO to avoid the race you
> > mentioned, that is something like:
> > 
> >    if (mr_is_romd(mr) && romd_mode) {
> >        set_romd(false);
> >        flush();
> >    }
> > 
> > It's based on my limited understanding / assumption that during MMIO state
> > TCG won't be able to cache invalid TB on these regions.
> > 
> > So when switching ROMD->MMIO, invalidated TBs can exist, hence flush only
> > once, after updating romd=false.  When switching back from MMIO->ROMD, no
> > chance caching anything wrong.
> 
> This doesn't run. Its flush comes after romd is cleared, and
> memory_region_flush_rom_device() asserts that the region is still in
> romd mode. The reproducer aborts with:
> 
> Assertion failed: (memory_region_is_romd(mr)), function
> memory_region_flush_rom_device

IIUC that assertion was not required and can be removed, based on its
comment?

So my pure question was really about why we need two TB flushes rather than
one: the pflash changed causing stale TB which I can understand.  What I
suggested was "making sure nobody caches this pflash, then drop all
existing TB" approach, which requries removal of the assertion.  I assumed
that works, but maybe not really - I tried to read slightly more into TCG
just now and noticed maybe there's yet another layer of caching on TLB so
the stale mapping can still be visible.  Said that, IMO it would be great
if we can explain why two flushes are needed rather than one.  That means,
if we think the 2nd flush guards everything somehow (including the stale
TLB async work hasn't flushed), then it seems to me we can then drop the
1st flush (ROMD->MMIO switch).

Thanks,

-- 
Peter Xu


