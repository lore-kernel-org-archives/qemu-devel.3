Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A76BD26293
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 19:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viHFn-0008Q1-AM; Tue, 20 Jan 2026 14:19:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viHFl-0008NG-PV
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 14:19:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viHFj-0003Af-4I
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 14:19:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768936737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LXNlOy4zTglMXdMCBz+ZGmkJ7Un7pRQU487689nm2cU=;
 b=bkgflAoRg/3XKPY6tudZbssGvwg9qSHm80uOKxeW8s2Y39F0QXvuHTjt0eGRcBlb5VBo3x
 1Sjfai5Jmzlk/9CbkOePk5eft20JRm0vkivoLUhEGAbRUJTTlWekUOjjvHmqUmaHUW255+
 AZhvJNGDq+RZjwBQdhEXkT4WFkIomJw=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-auaJ49DLO7q1MS2zg-oefw-1; Tue, 20 Jan 2026 14:18:56 -0500
X-MC-Unique: auaJ49DLO7q1MS2zg-oefw-1
X-Mimecast-MFC-AGG-ID: auaJ49DLO7q1MS2zg-oefw_1768936734
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2b70bd4a2ccso1306508eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 11:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768936734; x=1769541534; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LXNlOy4zTglMXdMCBz+ZGmkJ7Un7pRQU487689nm2cU=;
 b=f4SdEFjxlxwKb4FceojBLaR0/3RcmyF9emLbVppYr0yCiSr64LTE8jyE9vzar1k/gU
 0ji5ju/LrroccZ9clqgv6+lRH6WTq2TMZkK+QCe7p/UfksDRCX7xJJHoINFfkf/SEV9u
 HyZb83EvDiGc6noVJB7v3nKz9vy3b3cKWI4+Q48ry9wKq1JbkhVl1rZXUiQQopP81pmQ
 XqNl+vZoPSrG4GoJH4atZ3fIDBIYYHTaM2T9itAAMyQlhhPlmy1t8z/Za2dg4NKCfpuq
 MCU48TKAoF6dDf4dAZviG9erKlHHJOkksaR8xzInV+/fOSqEwIdeZ8kPIB0tyqpH75Mw
 E+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768936734; x=1769541534;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LXNlOy4zTglMXdMCBz+ZGmkJ7Un7pRQU487689nm2cU=;
 b=ihR0oq2ZWL4A7Qm+IKjzuV1tmtLa/unYU7Wp+QB9qdmht+1h0FMaYv5NMc4N5Y/ucN
 tl95qY+XRZV9gupfrfd103xv9aBhCmAyldPGdJ765GyqpBx+GVus+1geGJlVPPyMgN4n
 LfEvfbXjj/TiYOot+fLsTdnNMMmZRElDiFByqu3Olq8jh5tJa4ps2rJ2HKdnZKkAe8UK
 iefy1QnAHqgBB5kJwFrqPpCrdjFAD5oXxdcvj5nyAM/vJLGdF9jtcvd3mjoZuoenPqce
 2wUkocectpH7wkUA+OFs8s4fuYcov9FvsHsIVYlVWI8VC5NYiQa3x4mM6xmJQ/mlxaBF
 nbiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDhTDOuifGhIC4qkRLHZIue7DNK/saCBQ9kpndli7K176I4ef9dCclN5ZamS7jHovzDU0RWYsDssyx@nongnu.org
X-Gm-Message-State: AOJu0Yzd+WAwwbLtkR1ikv2/KPWdt/d1bejtfRQtYQpUO63lihqdSC9x
 AV1LiLqh65Wpnmb/WGYTpjCuEWVM3BleQWcax7G3vyRD2YkZS9tiSZ/IjZp1W3I54183c4GBP91
 7TrMss3pYjouNfvRyPXGxUhV1YskBMkKMs0TkKaQ5lrKkMjCKxlN9OiYn
X-Gm-Gg: AZuq6aL59+nmmNy8Urb1Lo+SDK/ObpljrCgLA5UMviInVhzSzl6dZlPPj4VXfjZ8gix
 2mBnb71iN/W9OSMbhDrHuh8qCXhYAGfpj9KaFaSsyuIXNiQ5VuvomTRUW3mwpmyf9tkZ+S+eXzQ
 ZATnoXJ5S2RMYtTIPwP01oZD9C60/GkMjEvyAJzHfUoRiFsEnIzRVxX1n8mNgziPZmfueKTO9IC
 HHHlc+98bkoBblI1+CIDDLQVIWueEFs8EBjREdEedxc7Kv6avFs1l0IRJU+S4sWlMQffGx9+QoH
 JV5e7SO2p4toKcgHbccMMDtSkCBRy980iZW1d3+ysGiVjUtTnFCRffiGeVNAyqrcStJuwAbUt7N
 gCEI=
X-Received: by 2002:a05:7300:5714:b0:2ae:5ddf:e203 with SMTP id
 5a478bee46e88-2b6b3f2ffc7mr9174483eec.11.1768936734167; 
 Tue, 20 Jan 2026 11:18:54 -0800 (PST)
X-Received: by 2002:a05:7300:5714:b0:2ae:5ddf:e203 with SMTP id
 5a478bee46e88-2b6b3f2ffc7mr9174461eec.11.1768936733560; 
 Tue, 20 Jan 2026 11:18:53 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b6b365516asm17969425eec.26.2026.01.20.11.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 11:18:53 -0800 (PST)
Date: Tue, 20 Jan 2026 14:18:45 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@trasno.org>
Subject: Re: [PATCH v2 4/8] multifd: Add COLO support
Message-ID: <aW_VFSUnrAs6U0LR@x1.local>
References: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
 <20260117-colo_unit_test_multifd-v2-4-ab521777fa51@web.de>
 <aW-31rQky14G8_lq@x1.local> <aW_D2-EEE_aSC_rJ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aW_D2-EEE_aSC_rJ@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Jan 20, 2026 at 06:05:15PM +0000, Daniel P. Berrangé wrote:
> On Tue, Jan 20, 2026 at 12:13:58PM -0500, Peter Xu wrote:
> > On Sat, Jan 17, 2026 at 03:09:11PM +0100, Lukas Straub wrote:
> > > Like in the normal ram_load() path, put the received pages into the
> > > colo cache and mark the pages in the bitmap so that they will be
> > > flushed to the guest later.
> > > 
> > > Multifd with COLO is useful to reduce the VM pause time during checkpointing
> > > for latency sensitive workloads. In such workloads the worst-case latency
> > > is especially important.
> > > 
> > > Also, multifd migration is the preferred way to do migration nowadays and this
> > > allows to use multifd compression with COLO.
> > > 
> > > Benchmark:
> > > Cluster nodes
> > >  - Intel Xenon E5-2630 v3
> > >  - 48Gb RAM
> > >  - 10G Ethernet
> > > Guest
> > >  - Windows Server 2016
> > >  - 6Gb RAM
> > >  - 4 cores
> > > Workload
> > >  - Upload a file to the guest with SMB to simulate moderate
> > >    memory dirtying
> > >  - Measure the memory transfer time portion of each checkpoint
> > >  - 600ms COLO checkpoint interval
> > > 
> > > Results
> > > Plain
> > >  idle mean: 4.50ms 99per: 10.33ms
> > >  load mean: 24.30ms 99per: 78.05ms
> > > Multifd-4
> > >  idle mean: 6.48ms 99per: 10.41ms
> > >  load mean: 14.12ms 99per: 31.27ms
> > 
> > Thanks for the numbers.  They're persuasive at least from 1st look.
> > 
> > Said that, one major question is, multifd should only help with throughput
> > when cpu is a bottleneck sending, in your case it's 10Gbps NIC.  Normally
> > any decent cpu should be able to push closer to 10Gbps even without
> > multifd.
> 
> That assumes the CPUs used by migration are otherwise idle though. If the
> host is busy running guest workloads, only small timeslices may be available
> for use by migration threads. Using multifd would better utilize what's
> available if multiple host CPUs have partial availability.

Hmm, I'm not sure this is the case for when the test was run above.  I
rarely see a host's CPUs been completely occupied.  Say, on 16 cores system
it means ~1600% CPU utilization.

I think it's because normally when a host will be hosting VMs, we should
normally have some of CPU resources reserved for host housekeeping.
Otherwise I'm not sure how to guarantee general availability of the
host.. and IIUC it may also affect the guest.

Here, IMHO as long as there's >100% CPU resource on this host (e.g. out of
1600% on a 16 cores system), enabling multifd or not shouldn't matter much
when the NIC is 10Gbps.

Old but decent processor should be able to push 10~15Gbps, new processor
should be able to push to ~25Gbps or more, with 100% CPU resource.

It's because the scheduler will schedule whatever thread (either the
migration thread alone, or multifd threads) onto whatever core that will
still be free (or some cores that have free cycles).

When all CPUs are occupied, IMHO multifd shouldn't help much
either.. maybe >1 threads make it easier to get scheduled (hence more time
slices from scheduler), but I believe that's not the major use case for
multifd.. it should really be when there're plenty of CPU resources.

Thanks,

-- 
Peter Xu


