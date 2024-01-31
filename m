Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D496C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 08:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV6P1-0000q9-56; Wed, 31 Jan 2024 03:57:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rV6Oz-0000q1-2V
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 03:57:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rV6Ov-0000gH-Km
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 03:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706691415;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swtu9+GCamo+LAafHhqIYs0NU/TqcvXjInatdY9WTdg=;
 b=aecHblmSPhUKiCTFRRsKCCT24GiQdFbciWqHWdqQxE2mXKKH7Z8bXcqX6VSoGfOUxzB0mZ
 0uFOl3rvTb8fSsTibyklsO8dlYV6hT+UYJ7vkGR/NAK0+IVmDSyOJSgf7o6hQUfFdgQcys
 JXnJ7m1h+3z9dVqYKisKcGcpszd420M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-55VcQfPEMwGMBum9Id3bng-1; Wed,
 31 Jan 2024 03:56:52 -0500
X-MC-Unique: 55VcQfPEMwGMBum9Id3bng-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FC6C2812FE1;
 Wed, 31 Jan 2024 08:56:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 09EC21121306;
 Wed, 31 Jan 2024 08:56:49 +0000 (UTC)
Date: Wed, 31 Jan 2024 08:56:47 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, kraxel@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] pc: q35: Bump max_cpus to 1856 vcpus
Message-ID: <ZboLOoFtyGc6AwzZ@redhat.com>
References: <20240131024906.3920-1-anisinha@redhat.com>
 <ZbnH9Yehg7bWY+ws@intel.com>
 <CAK3XEhOOGFtGPr6h1YpSv54QeBBjVnASUk6k59842vCvBt0qLQ@mail.gmail.com>
 <Zbnum6Mljz6ZoFvx@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zbnum6Mljz6ZoFvx@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jan 31, 2024 at 02:54:19PM +0800, Zhao Liu wrote:
> On Wed, Jan 31, 2024 at 10:47:29AM +0530, Ani Sinha wrote:
> > Date: Wed, 31 Jan 2024 10:47:29 +0530
> > From: Ani Sinha <anisinha@redhat.com>
> > Subject: Re: [PATCH v2] pc: q35: Bump max_cpus to 1856 vcpus
> > 
> > On Wed, Jan 31, 2024 at 9:27 AM Zhao Liu <zhao1.liu@intel.com> wrote:
> > >
> > > Hi Ani,
> > >
> > > On Wed, Jan 31, 2024 at 08:19:06AM +0530, Ani Sinha wrote:
> > > > Date: Wed, 31 Jan 2024 08:19:06 +0530
> > > > From: Ani Sinha <anisinha@redhat.com>
> > > > Subject: [PATCH v2] pc: q35: Bump max_cpus to 1856 vcpus
> > > > X-Mailer: git-send-email 2.42.0
> > > >
> > > > Since commit f10a570b093e6 ("KVM: x86: Add CONFIG_KVM_MAX_NR_VCPUS to allow up to 4096 vCPUs")
> > > > Linux kernel can support upto a maximum number of 4096 vCPUS when MAXSMP is
> > > > enabled in the kernel. At present, QEMU has been tested to correctly boot a
> > > > linux guest with 1856 vcpus and no more both with edk2 and seabios firmwares.
> > >
> > > About background, could I ask if there will be Host machines with so
> > > much CPUs? What are the benefits of vCPUs that far exceed the number
> > > of Host CPUs?
> > 
> > Yes HPE has SAP HANA host machines with large numbers of physical
> > cores and memory. For example QEMU was tested on a system with 3840
> > cores.
> 
> Thanks! For such large system, does the vCPU need the CPU affinity, or
> just let them run free on the Host's physical cores?

It depends what you are trying to achieve. The tradeoffs for guest
placement on small systems still pretty much apply on large systems
too. There may be factors which alter the balance for the tradeoffs,
but the theme is still determined by what the guest owner requires
and what the host owner wants to achieve.

Strict host:guest CPU affinity will give the guest a deterministic
amount of host CPU time, and lowest latencies. It is wasteful of
host resources though, because if a guest CPU is idle, a different
guests' CPU can't use that host CPU time. So letting guests run
freely across host cores and overcommiting CPUs will maximize
utilization but give non-deterministic timeslices & latency to
guests.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


