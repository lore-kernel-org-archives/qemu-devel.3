Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B27C7883E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 13:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srdjL-0001eG-Vx; Fri, 20 Sep 2024 09:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1srZat-0001Vs-K0
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 05:06:29 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1srZar-00043G-8Y
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 05:06:26 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8d43657255so259130766b.0
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2024 02:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1726823182; x=1727427982; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5ea6kApel9704WtmafZwie6CE4udCD/ZWEKovHegrZg=;
 b=dg+fdGnrtiNvhgF6sEfXi/4NkGAK/FKpCn2uFpA5fFrlH0SvorNenUD3rhETmyz5ZF
 ZlhtPCVJg6niWj6eZk3g+pzmAB1MvRlWpJnUFyN5fvUqXJIKDQPFiGVZK+H5TwvnQGKy
 ChWNJ0a95ViuT3pq6C1Tg1RERLZodmHoGXc97vK9gkWQoDVYbugMl/3vn7YZ/rg4piXC
 nSvLjENKlSBj4n6B6m7+0jKj0dOLedJMJHuPN43dSXq0rMBThFByrQQ3VzQmd4KTA6WL
 rSCP3xdz3rXOXQKhfQQ8xu/GgN6+xqZABxOZdsmUhivDPXH0uY1VBPILGaBPsjppMe/w
 UEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726823182; x=1727427982;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ea6kApel9704WtmafZwie6CE4udCD/ZWEKovHegrZg=;
 b=QOSw0gxm/mn8njsNDbRh5cu+FLuqiHFE5taYwspjSBcbcm1Sui7IyenEo1bs4WsbNd
 Oin6EVfPxPsVL1/azunaf5bYvOFM4p/traDbhdESC6KrX37j0jwf5a+yWzxFcV8tnXtV
 F/TK8nWRAS0bVKx6zitz3eHi0CdxiCdvQeP76Jt6UhIYxTZNPRaep7QdkFBB2OlyXx9d
 FA1lcUqYpcLh/NAaoEKXgJ1yEvCDFs4GvgnuyDw5ckIL6XIdMv7zgIle7a5YXZWp0AvN
 HG+TBnRFv8FjdT5OTRzBQvzzkUJ5HS6Iur3DLTrFp//y69q3V6OKRkY+kQ8TrBEI9KZO
 gaRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzlQCYOTLHbhwgqE0mjTwvEppeon5IVFLm/2XhTGSnT3n0b0yj6ybX4fhJpxDWK3R+xQJkJaIVS7/C@nongnu.org
X-Gm-Message-State: AOJu0Yzo6HytYTwqp/kAaBf2qFypUd2uKf3E5Im4cOeYX77Rx23fo5ng
 ev+s9bd0s2LFHY4wDc7/bUaKawXIVx/Lq6It+2MSvZGXJjaLn9YsH/m3MRK5e1w=
X-Google-Smtp-Source: AGHT+IHS5Ou0XIJ4uflfTtxR3ETCTI4FJBbvqfkbaPfxDAC5XJ69GFR67U4wnEW673qhczAiNcFAYw==
X-Received: by 2002:a17:906:cad6:b0:a8d:25d3:65e4 with SMTP id
 a640c23a62f3a-a90d4ffcb11mr164635366b.36.1726823182340; 
 Fri, 20 Sep 2024 02:06:22 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com ([83.68.141.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610f4971sm821742366b.90.2024.09.20.02.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 02:06:21 -0700 (PDT)
Date: Fri, 20 Sep 2024 11:06:09 +0200
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, John Groves <John@groves.net>,
 virtualization@lists.linux.dev, Oscar Salvador <osalvador@suse.de>,
 qemu-devel@nongnu.org, Dave Jiang <dave.jiang@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linuxarm@huawei.com,
 wangkefeng.wang@huawei.com, John Groves <jgroves@micron.com>,
 Fan Ni <fan.ni@samsung.com>, Navneet Singh <navneet.singh@intel.com>,
 =?utf-8?B?4oCcTWljaGFlbCBTLiBUc2lya2lu4oCd?= <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [RFC] Virtualizing tagged disaggregated memory capacity (app
 specific, multi host shared)
Message-ID: <Zu07AU3aUrHBMXaw@PC2K9PVX.TheFacebook.com>
References: <20240815172223.00001ca7@Huawei.com>
 <fc05d089-ce04-42d2-a0d7-ea32fd73fe90@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc05d089-ce04-42d2-a0d7-ea32fd73fe90@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=gourry@gourry.net; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 20 Sep 2024 09:31:23 -0400
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

> > 2. Coarse grained memory increases for 'normal' memory.
> >     Can use memory hot-plug. Recovery of capacity likely to only be possible on
> >     VM shutdown.
> 
> Is there are reason "movable" (ZONE_MOVABLE) is not an option, at least in
> some setups? If not, why?
>


This seems like a bit of a muddied conversation.

"'normal' memory" has no defined meaning - so lets clear this up a bit

There is:
* System-RAM (memory managed by kernel allocators)
* Special Purpose Memory (generally presented as DAX)

System-RAM is managed as zones - the relevant ones are
* ZONE_NORMAL allows both movable and non-movable allocations
* ZONE_MOVABLE only allows non-movable allocations
  (Caveat: this generally only applies to allocation, you can
   violate this with stuff like pinning)

Hotplug can be thought of as two discrete mechanisms
* Exposing capacity to the kernel (CXL DCD Transactions)
* Exposing capacity to allocators (mm/memory-hotplug.c)

1) if the intent is to primarily utilize dynamic capacity for VMs, then
   the host does not need (read: should not need) to map the memory as
   System-RAM in the host. The VMM should be made to consume it directly
   via DAX or otherwise.

   That capacity is almost by definition "Capital G Guaranteed" to be
   reclaimable regardless of what the guest does. A VMM can force a guest
   to let go of resources - that's its job.

2) if the intent is to provide dynamic capacity to a host as System-RAM, then
   recoverability is dictated by system usage of that capacity. If onlined
   into ZONE_MOVABLE, then if the system has avoided doing things like pinning
   those pages it should *generally* be recoverable (but not guaranteed).


For the virtualization discussion:

Hotplug and recoverability is a non-issue.  The capacity should never be
exposed to system allocators and the VMM should be made to consume special
purpose memory directly. That's on the VMM/orchestration software to get right.


For the host System-RAM discussion:

Auto-onlined hotplug capacity presently defaults to ZONE_NORMAL, but we
discussed (yesterday, at Plumbers) changing this default to ZONE_MOVABLE.

The only concern is when insufficient ZONE_NORMAL exists to support
ZONE_MOVABLE capacity - but this is unlikely to be the general scenario AND
can be mitigated w/ existing mechanisms.

Manually onlined capacity defaults to ZONE_MOVABLE.

It would be nice to make this behavior consistent, since the general opinion
appears to be that this capacity should default to ZONE_MOVABLE.

~Gregory

