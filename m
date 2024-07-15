Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DB9C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 16:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTOGO-00024J-Qg; Mon, 15 Jul 2024 12:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sTOGJ-00022Y-G2
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 12:09:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sTOGH-0001xk-6F
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 12:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721059751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gHpSRRAOuGTTZ716emnOp3La/sPjFm62YvQLAfjXK1I=;
 b=XcNUxl+r+DsbJRSFNMLxZnHCo1iIKTSw44AIvOuYCTeggsPDJBQXyNggvBczeOT2jWs5Ql
 OSX04FtUUNHpWd5bhGnwgCn7g43TAXoQNWzu77GHo2Nq3OZat9qNx4ZoJ4+5qQr7E86QTy
 7hThcOXVDZnlyUe16S/F3QZnW3lvjM4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-IbBKDJ7IO_6x-oAh1bJigw-1; Mon, 15 Jul 2024 12:09:09 -0400
X-MC-Unique: IbBKDJ7IO_6x-oAh1bJigw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-426620721c2so33197985e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 09:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721059748; x=1721664548;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gHpSRRAOuGTTZ716emnOp3La/sPjFm62YvQLAfjXK1I=;
 b=cJfOPaM9fLysk/2ze/TW7vK3LeLOekEQLvloM9mnNiWmRlx3tVNMPHh1E7+Cf/Drm0
 C759nCOC3oeK1BbYJOqWmjhoWXxpBkMunf+TZlx9RjYljs+HcRA5qAJLZ/eYgm06mURL
 WDCr2HcD5v9HgyAF5aSzOKgedFrw5c3tSJ1jgRXJjTiBFJv/PzRd8/rxkDNOu+RWTEqy
 joRmztCt2/SMxRmHOHu/gHS2nXfpB7OGzaqzIrTGrL5N7lFxDq3zDPAmD4CDhJDjhnv1
 0SYiMm2qRn2q8jSbPn10V/Zy2oQH4ldDu4ljX2W7RNJNy7CeI1nOWkWzKOlmM7qYOzGq
 klQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy4KrHfmQz0+hyijLRpy++0fRgkUxzvprRr4NOE8fRONB+tCc4tH9hZTec2UIOpgSgG3c9mGBAj+AeI328c2GeyeeNb90=
X-Gm-Message-State: AOJu0YyIvLQkb9BjcyKrSPqomizWAcJc6ntfj6LZm15a9oOpMTHMHE1G
 Ec0vkE+sh5KHNqTOp4dzMi6mbSi9RgwmqtCwtPndCFMgmsOxI9+u6nb12Jha048304rsGYAAZt2
 LRQJmIFve03ODaB8nPCXDQVCvzaQtnxSN0gtONiMsP6ggOenkRSm9
X-Received: by 2002:a05:600c:198f:b0:426:607c:1863 with SMTP id
 5b1f17b1804b1-427b88a40bcmr684215e9.21.1721059747926; 
 Mon, 15 Jul 2024 09:09:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMkufzkQ6q1ZGWiI/Dt2wv4NGLoCDV6T1X4MRgge1I+LjOLBqPVnQbdgmbj8dZHDkXaFjGQw==
X-Received: by 2002:a05:600c:198f:b0:426:607c:1863 with SMTP id
 5b1f17b1804b1-427b88a40bcmr683935e9.21.1721059747317; 
 Mon, 15 Jul 2024 09:09:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:243:da88:7ff9:68fc:2f43:bcdf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f25ac47sm128211705e9.18.2024.07.15.09.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 09:09:06 -0700 (PDT)
Date: Mon, 15 Jul 2024 12:08:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Liu, Yuan1" <yuan1.liu@intel.com>
Cc: "Wang, Yichen" <yichen.wang@bytedance.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Hao Xiang <hao.xiang@linux.dev>,
 "Kumar, Shivam" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Subject: Re: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to offload zero
 page checking in multifd live migration.
Message-ID: <20240715120657-mutt-send-email-mst@kernel.org>
References: <20240711215244.19237-1-yichen.wang@bytedance.com>
 <20240711184131-mutt-send-email-mst@kernel.org>
 <PH7PR11MB594105D464F3A4C2C25F94FEA3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
 <20240715081857-mutt-send-email-mst@kernel.org>
 <PH7PR11MB5941A453AC1A4B3A387475A7A3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
 <20240715104015-mutt-send-email-mst@kernel.org>
 <PH7PR11MB59410B8B35F932AF55C8A243A3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR11MB59410B8B35F932AF55C8A243A3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 15, 2024 at 03:23:13PM +0000, Liu, Yuan1 wrote:
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, July 15, 2024 10:43 PM
> > To: Liu, Yuan1 <yuan1.liu@intel.com>
> > Cc: Wang, Yichen <yichen.wang@bytedance.com>; Paolo Bonzini
> > <pbonzini@redhat.com>; Marc-André Lureau <marcandre.lureau@redhat.com>;
> > Daniel P. Berrangé <berrange@redhat.com>; Thomas Huth <thuth@redhat.com>;
> > Philippe Mathieu-Daudé <philmd@linaro.org>; Peter Xu <peterx@redhat.com>;
> > Fabiano Rosas <farosas@suse.de>; Eric Blake <eblake@redhat.com>; Markus
> > Armbruster <armbru@redhat.com>; Cornelia Huck <cohuck@redhat.com>; qemu-
> > devel@nongnu.org; Hao Xiang <hao.xiang@linux.dev>; Kumar, Shivam
> > <shivam.kumar1@nutanix.com>; Ho-Ren (Jack) Chuang
> > <horenchuang@bytedance.com>
> > Subject: Re: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to offload
> > zero page checking in multifd live migration.
> > 
> > On Mon, Jul 15, 2024 at 01:09:59PM +0000, Liu, Yuan1 wrote:
> > > > -----Original Message-----
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Monday, July 15, 2024 8:24 PM
> > > > To: Liu, Yuan1 <yuan1.liu@intel.com>
> > > > Cc: Wang, Yichen <yichen.wang@bytedance.com>; Paolo Bonzini
> > > > <pbonzini@redhat.com>; Marc-André Lureau
> > <marcandre.lureau@redhat.com>;
> > > > Daniel P. Berrangé <berrange@redhat.com>; Thomas Huth
> > <thuth@redhat.com>;
> > > > Philippe Mathieu-Daudé <philmd@linaro.org>; Peter Xu
> > <peterx@redhat.com>;
> > > > Fabiano Rosas <farosas@suse.de>; Eric Blake <eblake@redhat.com>;
> > Markus
> > > > Armbruster <armbru@redhat.com>; Cornelia Huck <cohuck@redhat.com>;
> > qemu-
> > > > devel@nongnu.org; Hao Xiang <hao.xiang@linux.dev>; Kumar, Shivam
> > > > <shivam.kumar1@nutanix.com>; Ho-Ren (Jack) Chuang
> > > > <horenchuang@bytedance.com>
> > > > Subject: Re: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to
> > offload
> > > > zero page checking in multifd live migration.
> > > >
> > > > On Mon, Jul 15, 2024 at 08:29:03AM +0000, Liu, Yuan1 wrote:
> > > > > > -----Original Message-----
> > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Sent: Friday, July 12, 2024 6:49 AM
> > > > > > To: Wang, Yichen <yichen.wang@bytedance.com>
> > > > > > Cc: Paolo Bonzini <pbonzini@redhat.com>; Marc-André Lureau
> > > > > > <marcandre.lureau@redhat.com>; Daniel P. Berrangé
> > > > <berrange@redhat.com>;
> > > > > > Thomas Huth <thuth@redhat.com>; Philippe Mathieu-Daudé
> > > > > > <philmd@linaro.org>; Peter Xu <peterx@redhat.com>; Fabiano Rosas
> > > > > > <farosas@suse.de>; Eric Blake <eblake@redhat.com>; Markus
> > Armbruster
> > > > > > <armbru@redhat.com>; Cornelia Huck <cohuck@redhat.com>; qemu-
> > > > > > devel@nongnu.org; Hao Xiang <hao.xiang@linux.dev>; Liu, Yuan1
> > > > > > <yuan1.liu@intel.com>; Kumar, Shivam <shivam.kumar1@nutanix.com>;
> > Ho-
> > > > Ren
> > > > > > (Jack) Chuang <horenchuang@bytedance.com>
> > > > > > Subject: Re: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to
> > > > offload
> > > > > > zero page checking in multifd live migration.
> > > > > >
> > > > > > On Thu, Jul 11, 2024 at 02:52:35PM -0700, Yichen Wang wrote:
> > > > > > > * Performance:
> > > > > > >
> > > > > > > We use two Intel 4th generation Xeon servers for testing.
> > > > > > >
> > > > > > > Architecture:        x86_64
> > > > > > > CPU(s):              192
> > > > > > > Thread(s) per core:  2
> > > > > > > Core(s) per socket:  48
> > > > > > > Socket(s):           2
> > > > > > > NUMA node(s):        2
> > > > > > > Vendor ID:           GenuineIntel
> > > > > > > CPU family:          6
> > > > > > > Model:               143
> > > > > > > Model name:          Intel(R) Xeon(R) Platinum 8457C
> > > > > > > Stepping:            8
> > > > > > > CPU MHz:             2538.624
> > > > > > > CPU max MHz:         3800.0000
> > > > > > > CPU min MHz:         800.0000
> > > > > > >
> > > > > > > We perform multifd live migration with below setup:
> > > > > > > 1. VM has 100GB memory.
> > > > > > > 2. Use the new migration option multifd-set-normal-page-ratio to
> > > > control
> > > > > > the total
> > > > > > > size of the payload sent over the network.
> > > > > > > 3. Use 8 multifd channels.
> > > > > > > 4. Use tcp for live migration.
> > > > > > > 4. Use CPU to perform zero page checking as the baseline.
> > > > > > > 5. Use one DSA device to offload zero page checking to compare
> > with
> > > > the
> > > > > > baseline.
> > > > > > > 6. Use "perf sched record" and "perf sched timehist" to analyze
> > CPU
> > > > > > usage.
> > > > > > >
> > > > > > > A) Scenario 1: 50% (50GB) normal pages on an 100GB vm.
> > > > > > >
> > > > > > > 	CPU usage
> > > > > > >
> > > > > > > 	|---------------|---------------|---------------|-------------
> > > > --|
> > > > > > > 	|		|comm		|runtime(msec)	|totaltime(msec)|
> > > > > > > 	|---------------|---------------|---------------|-------------
> > > > --|
> > > > > > > 	|Baseline	|live_migration	|5657.58	|		|
> > > > > > > 	|		|multifdsend_0	|3931.563	|		|
> > > > > > > 	|		|multifdsend_1	|4405.273	|		|
> > > > > > > 	|		|multifdsend_2	|3941.968	|		|
> > > > > > > 	|		|multifdsend_3	|5032.975	|		|
> > > > > > > 	|		|multifdsend_4	|4533.865	|		|
> > > > > > > 	|		|multifdsend_5	|4530.461	|		|
> > > > > > > 	|		|multifdsend_6	|5171.916	|		|
> > > > > > > 	|		|multifdsend_7	|4722.769	|41922		|
> > > > > > > 	|---------------|---------------|---------------|-------------
> > > > --|
> > > > > > > 	|DSA		|live_migration	|6129.168	|		|
> > > > > > > 	|		|multifdsend_0	|2954.717	|		|
> > > > > > > 	|		|multifdsend_1	|2766.359	|		|
> > > > > > > 	|		|multifdsend_2	|2853.519	|		|
> > > > > > > 	|		|multifdsend_3	|2740.717	|		|
> > > > > > > 	|		|multifdsend_4	|2824.169	|		|
> > > > > > > 	|		|multifdsend_5	|2966.908	|		|
> > > > > > > 	|		|multifdsend_6	|2611.137	|		|
> > > > > > > 	|		|multifdsend_7	|3114.732	|		|
> > > > > > > 	|		|dsa_completion	|3612.564	|32568		|
> > > > > > > 	|---------------|---------------|---------------|-------------
> > > > --|
> > > > > > >
> > > > > > > Baseline total runtime is calculated by adding up all
> > multifdsend_X
> > > > > > > and live_migration threads runtime. DSA offloading total runtime
> > is
> > > > > > > calculated by adding up all multifdsend_X, live_migration and
> > > > > > > dsa_completion threads runtime. 41922 msec VS 32568 msec runtime
> > and
> > > > > > > that is 23% total CPU usage savings.
> > > > > >
> > > > > >
> > > > > > Here the DSA was mostly idle.
> > > > > >
> > > > > > Sounds good but a question: what if several qemu instances are
> > > > > > migrated in parallel?
> > > > > >
> > > > > > Some accelerators tend to basically stall if several tasks
> > > > > > are trying to use them at the same time.
> > > > > >
> > > > > > Where is the boundary here?
> > > > >
> > > > > A DSA device can be assigned to multiple Qemu instances.
> > > > > The DSA resource used by each process is called a work queue, each
> > DSA
> > > > > device can support up to 8 work queues and work queues are
> > classified
> > > > into
> > > > > dedicated queues and shared queues.
> > > > >
> > > > > A dedicated queue can only serve one process. Theoretically, there
> > is no
> > > > limit
> > > > > on the number of processes in a shared queue, it is based on enqcmd
> > +
> > > > SVM technology.
> > > > >
> > > > > https://www.kernel.org/doc/html/v5.17/x86/sva.html
> > > >
> > > > This server has 200 CPUs which can thinkably migrate around 100 single
> > > > cpu qemu instances with no issue. What happens if you do this with
> > DSA?
> > >
> > > First, the DSA work queue needs to be configured in shared mode, and one
> > > queue is enough.
> > >
> > > The maximum depth of the work queue of the DSA hardware is 128, which
> > means
> > > that the number of zero-page detection tasks submitted cannot exceed
> > 128,
> > > otherwise, enqcmd will return an error until the work queue is available
> > again
> > >
> > > 100 Qemu instances need to be migrated concurrently, I don't have any
> > data on
> > > this yet, I think the 100 zero-page detection tasks can be successfully
> > submitted
> > > to the DSA hardware work queue, but the throughput of DSA's zero-page
> > detection also
> > > needs to be considered. Once the DSA maximum throughput is reached, the
> > work queue
> > > may be filled up quickly, this will cause some Qemu instances to be
> > temporarily unable
> > > to submit new tasks to DSA.
> > 
> > The unfortunate reality here would be that there's likely no QoS, this
> > is purely fifo, right?
> 
> Yes, this scenario may be fifo, assuming that the number of pages each task
> is the same, because DSA hardware consists of multiple work engines, they can
> process tasks concurrently, usually in a round-robin way to get tasks from the
> work queue.	
> 
> DSA supports priority and flow control based on work queue granularity.
> https://github.com/intel/idxd-config/blob/stable/Documentation/accfg/accel-config-config-wq.txt

Right but it seems clear there aren't enough work queues for a typical setup.

> > > This is likely to happen in the first round of migration
> > > memory iteration.
> > 
> > Try testing this and see then?
> 
> Yes, I can test based on this patch set. Please review the test scenario
> My server has 192 CPUs, and 8 DSA devices, 100Gbps NIC.
> All 8 DSA devices serve 100 Qemu instances for simultaneous live migration.
> Each VM has 1 vCPU, and 1G memory, with no workload in the VM.
> 
> You want to know if some Qemu instances are stalled because of DSA, right?

And generally just run same benchmark you did compared to cpu:
worst case and average numbers would be interesting.

> > --
> > MST


