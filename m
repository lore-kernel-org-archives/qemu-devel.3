Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2100C5320E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 12:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg1q9-0000KJ-0e; Mon, 19 Aug 2024 08:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <grovesaustin@gmail.com>)
 id 1sfrsu-0006GM-G2
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 22:12:40 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <grovesaustin@gmail.com>)
 id 1sfrss-0005hb-9a
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 22:12:40 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5d5e97b8a22so2303136eaf.2
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 19:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724033557; x=1724638357; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=kuLzrxHtd3ErSvy/xkwzVOEiflzs3mXlwCUfMyo1XlY=;
 b=Ev6a3/rjtA9z+UmyWuHMew9UqGjuTRhDhjn2M3iji56XeSZfuCvBUT0qAHFokhEsIJ
 tUnkREHeEWoHlphyp0zOT46E/q/8fLYAGQz5lq3fAVAlAiNceG+vwER1YNZbW2g3Ur1n
 mIdadJ0Jx7Sws54c9JlTc+3lJis7kPUCTUwFiYJ9sdAvLOXO3OsVnd74McDz9lcJlPlY
 9w6c635k7xBQS50xS1ti2hsdClz5zDzCiO8ZdCg/yTSbbESho0wWUE/8uCmNCC2V/HDZ
 sriqpRGcxAF5MXzt/0tWdTYmYv3yc6w1/r4sVM+UndfMSsndcxjjkvIveYH4Zz5vASj5
 ++eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724033557; x=1724638357;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kuLzrxHtd3ErSvy/xkwzVOEiflzs3mXlwCUfMyo1XlY=;
 b=VQ7KZSeOEqird7il47ICIAmWEXwrTgurfJtHh6lnP0kLeNaxhTmx/jcMTiEOOfxbbi
 ALMrUHpkeU6Z2EGt/HN+BHfiqT4fB+rzXkpf2e/MwWMrRN21kPQgE8W5JeXPIGe+z3Ob
 Asf59xFEZ4CDfl+Yo2C/0fYhIVWwWmIoxE9OPAzItWsEJNu289mMQxl2sMJmIxZGOLCm
 gu9wbRqTwTv7UrL7dHXAeFyr/dXTjn9r5xoiPstLYS0WAzJ0e+vhCXr2qIWZLujkL+7m
 uRbkyRsu7JanxGTsWy1H7o988Q3O/NBXWeDKk68qK6hNJqtu8HXYSfBVd63TK2BwK1g2
 RdkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfEfeWX1iw3vIVJlK7SiXgbJh/BJOD2i2EiIj0ImF2fUUgi1UNMrdBvAG9rFs6cIN1VJAWIU3AYi3PufvDt99hpTlwZF0=
X-Gm-Message-State: AOJu0YyoaBBqOFpGxCKXrWjO3cL2g7ikSoUG/Z4FpjkVY5ce3U/FQBHB
 SbDMVPlwQU2tSRFdmcsaUl2z8ikFkrxOlj8gEueqYR1DUY2vr56q
X-Google-Smtp-Source: AGHT+IGPFkOOeEpckRDFCUVwQIGGQr/JsPZgxRaMEz2IAoGo+sQFEwWCNUAzmF3eAuk+/dJ8qwreqw==
X-Received: by 2002:a05:6820:1624:b0:5da:a2fd:5af9 with SMTP id
 006d021491bc7-5daa2fd7235mr7883905eaf.8.1724033556730; 
 Sun, 18 Aug 2024 19:12:36 -0700 (PDT)
Received: from Borg-110.local (syn-070-114-203-196.res.spectrum.com.
 [70.114.203.196]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5da8cf83db6sm1928759eaf.33.2024.08.18.19.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Aug 2024 19:12:36 -0700 (PDT)
Date: Sun, 18 Aug 2024 21:12:34 -0500
From: John Groves <John@groves.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, 
 linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, 
 Ira Weiny <ira.weiny@intel.com>, virtualization@lists.linux.dev, 
 Oscar Salvador <osalvador@suse.de>, qemu-devel@nongnu.org,
 Dave Jiang <dave.jiang@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, linuxarm@huawei.com,
 wangkefeng.wang@huawei.com, 
 John Groves <jgroves@micron.com>, Fan   Ni <fan.ni@samsung.com>, 
 Navneet   Singh <navneet.singh@intel.com>,
 =?utf-8?B?4oCcTWljaGFlbCBTLiBUc2lya2lu4oCd?= <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC] Virtualizing tagged disaggregated memory capacity (app
 specific, multi host shared)
Message-ID: <sjz2xzwkgkq6bun5lssqbsimbggczarotpjdhcsq3itoq5h7jc@x5ormqciwofo>
References: <20240815172223.00001ca7@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815172223.00001ca7@Huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=grovesaustin@gmail.com; helo=mail-oo1-xc29.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 19 Aug 2024 08:50:24 -0400
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

On 24/08/15 05:22PM, Jonathan Cameron wrote:
> Introduction
> ============
> 
> If we think application specific memory (including inter-host shared memory) is
> a thing, it will also be a thing people want to use with virtual machines,
> potentially nested. So how do we present it at the Host to VM boundary?
> 
> This RFC is perhaps premature given we haven't yet merged upstream support for
> the bare metal case. However I'd like to get the discussion going given we've
> touched briefly on this in a number of CXL sync calls and it is clear no one is

Excellent write-up, thanks Jonathan.

Hannes' idea of an in-person discussion at LPC is a great idea - count me in.

As the proprietor of famfs [1] I have many thoughts.

First, I like the concept of application-specific memory (ASM), but I wonder
if there might be a better term for it. ASM suggests that there is one
application, but I'd suggest that a more concise statement of the concept
is that the Linux kernel never accesses or mutates the memory - even though
multiple apps might share it (e.g. via famfs). It's a subtle point, but
an important one for RAS etc. ASM might better be called non-kernel-managed
memory - though that name does not have as good a ring to it. Will mull this
over further...

Now a few level-setting comments on CXL and Dynamic Capacity Devices (DCDs),
some of which will be obvious to many of you:

* A DCD is just a memory device with an allocator and host-level
  access-control built in.
* Usable memory from a DCD is not available until the fabric manger (likely
  on behalf of an orchestrator) performs an Initiate Dynamic Capacity Add
  command to the DCD.
* A DCD allocation has a tag (uuid) which is the invariant way of identifying
  the memory from that allocation.
* The tag becomes known to the host from the DCD extents provided via
  a CXL event following succesful allocation.
* The memory associated with a tagged allocation will surface as a dax device
  on each host that has access to it. But of course dax device naming &
  numbering won't be consistent across separate hosts - so we need to use
  the uuid's to find specific memory.

A few less foundational observations:

* It does not make sense to "online" shared or sharable memory as system-ram,
  because system-ram gets zeroed, which blows up use cases for sharable memory.
  So the default for sharable memory must be devdax mode.
* Tags are mandatory for sharable allocations, and allowed but optional for
  non-sharable allocations. The implication is that non-sharable allocations
  may get onlined automatically as system-ram, so we don't need a namespace
  for those. (I argued for mandatory tags on all allocations - hey you don't
  have to use them - but encountered objections and dropped it.)
* CXL access control only goes to host root ports; CXL has no concept of
  giving access to a VM. So some component on a host (perhaps logically
  an orchestrator component) needs to plumb memory to VMs as appropriate.

So tags are a namespace to find specific memory "allocations" (which in the
CXL consortium, we usually refer to as "tagged capacity").

In an orchestrated environment, the orchestrator would allocate resources
(including tagged memory capacity), make that capacity visible on the right
host(s), and then provide the tag when starting the app if needed.

if (e.g.) the memory cotains a famfs file system, famfs needs the uuid of the
root memory allocation to find the right memory device. Once mounted, it's a
file sytem so apps can be directed to the mount path. Apps that consume the
dax devices directly also need the uuid because /dev/dax0.0 is not invariant
across a cluster...

I have been assuming that when the CXL stack discovers a new DCD allocation,
it will configure the devdax device and provide some way to find it by tag.
/sys/cxl/<tag>/dev or whatever. That works as far as it goes, but I'm coming
around to thinking that the uuid-to-dax map should not be overtly CXL-specific.

General thoughts regarding VMs and qemu

Physical connections to CXL memory are handled by physical servers. I don't
think there is a scenario in which a VM should interact directly with the
pcie function(s) of CXL devices. They will be configured as dax devices
(findable by their tags!) by the host OS, and should be provided to VMs
(when appropriate) as DAX devices. And software in a VM needs to be able to
find the right DAX device the same way it would running on bare metal - by
the tag.

Qemu can already get memory from files (-object memory-backend-file,...), and
I believe this works whether it's an actual file or a devdax device. So far,
so good.

Qemu can back a virtual pmem device by one of these, but currently (AFAIK)
not a virtual devdax device. I think virtual devdax is needed as a first-class
abstraction. If we can add the tag as a property of the memory-backend-file,
we're almost there - we just need away to lookup a daxdev by tag.

Summary thoughts:

* A mechanism for resolving tags to "tagged capacity" devdax devices is
  essential (and I don't think there are specific proposals about this
  mechanism so far).
* Said mechanism should not be explicitly CXL-specific.
* Finding a tagged capacity devdax device in a VM should work the same as it
  does running on bare metal.
* The file-backed (and devdax-backed) devdax abstraction is needed in qemu.
* Beyond that, I'm not yet sure what the lookup mechanism should be. Extra
  points for being easy to implement in both physical and virtual systems.

Thanks for teeing this up!
John


[1] https://github.com/cxl-micron-reskit/famfs/blob/master/README.md


