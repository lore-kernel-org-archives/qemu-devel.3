Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F4BC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUlQ5-0001t0-PM; Tue, 30 Jan 2024 05:32:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUlQ2-0001si-9G
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:32:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUlPp-0007Jx-Fk
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:32:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706610748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XyHw2GeuVWN6me2y740SMo08DmaQk1n82ySRDXiHVjY=;
 b=LwaqN07Dr1p56FCIoQ2Kki49jkzTzMaDIo0vmFJ/FPhY94C/mgg8uV+BQwtUvHdxeqwoW6
 wRrAWNzCh0jl2V5cBsGnMpXraTXQ4SJtmRcu6KBSMJdn8RP9lUfdICrAzxSOfaxOSn7am0
 CsshUQhe2irGkQe0ttpt2LA4arOVB5Y=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-TJ2s2415NvuBjrVQRpwJeQ-1; Tue, 30 Jan 2024 05:32:25 -0500
X-MC-Unique: TJ2s2415NvuBjrVQRpwJeQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29488245eb5so670566a91.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 02:32:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706610744; x=1707215544;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XyHw2GeuVWN6me2y740SMo08DmaQk1n82ySRDXiHVjY=;
 b=lh8whmXHMUY9WKwWrUU84gY5sf4y8bEOS5mkW5K5LbUQN3jDDjICCVrqv3qWfo78x6
 9sNOfBuF0pSr9t/T7KuUWb145vG54VEXarkpf1uvVwiU5NHjQqRCLE+zVmPsji9hH94d
 iMckSgnnwlxLGAQK7siq12cn+CgNJuUCJ4nfQKA2KDr/QEbMcn2RQS/l5x2XwRChZ0o0
 7exiStXPzYSop0YBmMvyR7GlHSbWL+qjOvf1G5GtZBJNktjodus1SHOIXAnihd2s049w
 zNG4vqybAUob7PDitqON8sFF3HFMbzab4JF6T0CgDnRyf8xm5OKja64TwH4JJGos4n2L
 kNng==
X-Gm-Message-State: AOJu0YxSF//Kbnt5gUbGpfqXufiF/kDhMvBCEDJABQseJqHCxvt7iTSb
 DvKoGE5nBxWs/DKtEnUeaLJStLqSMtG2gSsCrIg/p54E78Y4A9x9P03w8cU8FnLp9KsZSismWFy
 QBP49hxkCiuSmcnehfLf7/EI3AOrB1EVsJhTart1oTbkopf+SHUOc
X-Received: by 2002:a17:90a:d157:b0:290:239b:8f8e with SMTP id
 t23-20020a17090ad15700b00290239b8f8emr9202744pjw.4.1706610744493; 
 Tue, 30 Jan 2024 02:32:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4vYQ6cMPXmD4SguqMwn6eSFBQmv5xy3py2fbUiJ5E67Mtq56ns3Jn0kRLxRzrrPUrDsSK/A==
X-Received: by 2002:a17:90a:d157:b0:290:239b:8f8e with SMTP id
 t23-20020a17090ad15700b00290239b8f8emr9202732pjw.4.1706610744107; 
 Tue, 30 Jan 2024 02:32:24 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 ns1-20020a17090b250100b0028e821155efsm10227144pjb.46.2024.01.30.02.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 02:32:23 -0800 (PST)
Date: Tue, 30 Jan 2024 18:32:16 +0800
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yuan1" <yuan1.liu@intel.com>
Cc: "farosas@suse.de" <farosas@suse.de>,
 "leobras@redhat.com" <leobras@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: Re: [PATCH v3 0/4] Live Migration Acceleration with IAA Compression
Message-ID: <ZbjQMDE5jw0-Fm2v@x1n>
References: <20240103112851.908082-1-yuan1.liu@intel.com>
 <ZbeBJEDlqX51dlBN@x1n>
 <PH7PR11MB5941CDEF3401D271C41F419DA37D2@PH7PR11MB5941.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR11MB5941CDEF3401D271C41F419DA37D2@PH7PR11MB5941.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jan 30, 2024 at 03:56:05AM +0000, Liu, Yuan1 wrote:
> > -----Original Message-----
> > From: Peter Xu <peterx@redhat.com>
> > Sent: Monday, January 29, 2024 6:43 PM
> > To: Liu, Yuan1 <yuan1.liu@intel.com>
> > Cc: farosas@suse.de; leobras@redhat.com; qemu-devel@nongnu.org; Zou,
> > Nanhai <nanhai.zou@intel.com>
> > Subject: Re: [PATCH v3 0/4] Live Migration Acceleration with IAA
> > Compression
> > 
> > On Wed, Jan 03, 2024 at 07:28:47PM +0800, Yuan Liu wrote:
> > > Hi,
> > 
> > Hi, Yuan,
> > 
> > I have a few comments and questions.  Many of them can be pure questions
> > as I don't know enough on these new technologies.
> > 
> > >
> > > I am writing to submit a code change aimed at enhancing live migration
> > > acceleration by leveraging the compression capability of the Intel
> > > In-Memory Analytics Accelerator (IAA).
> > >
> > > The implementation of the IAA (de)compression code is based on Intel
> > > Query Processing Library (QPL), an open-source software project
> > > designed for IAA high-level software programming.
> > > https://github.com/intel/qpl
> > >
> > > In the last version, there was some discussion about whether to
> > > introduce a new compression algorithm for IAA. Because the compression
> > > algorithm of IAA hardware is based on deflate, and QPL already
> > > supports Zlib, so in this version, I implemented IAA as an accelerator
> > > for the Zlib compression method. However, due to some reasons, QPL is
> > > currently not compatible with the existing Zlib method that Zlib
> > > compressed data can be decompressed by QPl and vice versa.
> > >
> > > I have some concerns about the existing Zlib compression
> > >   1. Will you consider supporting one channel to support multi-stream
> > >      compression? Of course, this may lead to a reduction in compression
> > >      ratio, but it will allow the hardware to process each stream
> > >      concurrently. We can have each stream process multiple pages,
> > >      reducing the loss of compression ratio. For example, 128 pages are
> > >      divided into 16 streams for independent compression. I will provide
> > >      the a early performance data in the next version(v4).
> > 
> > I think Juan used to ask similar question: how much this can help if
> > multifd can already achieve some form of concurrency over the pages?
> 
> 
> > Couldn't the user specify more multifd channels if they want to grant more
> > cpu resource for comp/decomp purpose?
> > 
> > IOW, how many concurrent channels QPL can provide?  What is the suggested
> > concurrency channels there?
> 
> From the QPL software, there is no limit on the number of concurrent compression and decompression tasks.
> From the IAA hardware, one IAA physical device can process two compressions concurrently or eight decompression tasks concurrently. There are up to 8 IAA devices on an Intel SPR Server and it will vary according to the customer’s product selection and deployment.
> 
> Regarding the requirement for the number of concurrent channels, I think this may not be a bottleneck problem.
> Please allow me to introduce a little more here
> 
> 1. If the compression design is based on Zlib/Deflate/Gzip streaming mode, then we indeed need more channels to maintain concurrent processing. Because each time a multifd packet is compressed (including 128 independent pages), it needs to be compressed page by page. These 128 pages are not concurrent. The concurrency is reflected in the logic of multiple channels for the multifd packet.

Right.  However since you said there're only a max of 8 IAA devices, would
it also mean n_multifd_threads=8 can be a good enough scenario to achieve
proper concurrency, no matter the size of data chunk for one compression
request?

Maybe you meant each device can still process concurrent compression
requests, so the real capability of concurrency can be much larger than 8?

> 
> 2. Through testing, we prefer concurrent processing on 4K pages, not multifd packet, which means that 128 pages belonging to a packet can be compressed/decompressed concurrently. Even one channel can also utilize all the resources of IAA. But this is not compatible with existing zlib.
> The code is similar to the following
>   for(int i = 0; i < num_pages; i++) {
>     job[i]->input_data = pages[i]
>     submit_job(job[i] //Non-block submit for compression/decompression tasks
>   }
>   for(int i = 0; i < num_pages; i++) {
>     wait_job(job[i])  //busy polling. In the future, we will make this part and data sending into pipeline mode.
>   } 

Right, if more concurrency is wanted, you can use this async model; I think
Juan used to suggest such and I agree it will also work.  It can be done on
top of the basic functionality merged.

> 
> 3. Currently, the patches we provide to the community are based on streaming compression. This is to be compatible with the current zlib method. However, we found that there are still many problems with this, so we plan to provide a new change in the next version that the independent QPL/IAA acceleration function as said above.
> Compatibility issues include the following
>     1. QPL currently does not support the z_sync_flush operation
>     2. IAA comp/decomp window is fixed 4K. By default, the zlib window size is 32K. And window size should be the same for Both comp/decomp sides. 
>     3. At the same time, I researched the QAT compression scheme. QATzip currently does not support zlib, nor does it support z_sync_flush. The window size is 32K
> 
> In general, I think it is a good suggestion to make the accelerator compatible with standard compression algorithms, but also let the accelerator run independently, thus avoiding some compatibility and performance problems of the accelerator. For example, we can add the "accel" option to the compression method, and then the user must specify the same accelerator by compression accelerator parameter on the source and remote ends (just like specifying the same compression algorithm)
> 
> > >
> > >   2. Will you consider using QPL/IAA as an independent compression
> > >      algorithm instead of an accelerator? In this way, we can better
> > >      utilize hardware performance and some features, such as IAA's
> > >      canned mode, which can be dynamically generated by some statistics
> > >      of data. A huffman table to improve the compression ratio.
> > 
> > Maybe one more knob will work?  If it's not compatible with the deflate
> > algo maybe it should never be the default.  IOW, the accelerators may be
> > extended into this (based on what you already proposed):
> > 
> >   - auto ("qpl" first, "none" second; never "qpl-optimized")
> >   - none (old zlib)
> >   - qpl (qpl compatible)
> >   - qpl-optimized (qpl uncompatible)
> > 
> > Then "auto"/"none"/"qpl" will always be compatible, only the last doesn't,
> > user can select it explicit, but only on both sides of QEMU.
> Yes, this is what I want, I need a way that QPL is not compatible with zlib. From my current point of view, if zlib chooses raw defalte mode, then QAT will be compatible with the current community's zlib solution.
> So my suggestion is as follows
> 
> Compression method parameter
>  - none
>  - zlib
>  - zstd
>  - accel (Both Qemu sides need to select the same accelerator from "Compression accelerator parameter" explicitly).

Can we avoid naming it as "accel"?  It's too generic, IMHO.

If it's a special algorithm that only applies to QPL, can we just call it
"qpl" here?  Then...

> 
> Compression accelerator parameter
>  - auto
>  - none
>  - qpl (qpl will not support zlib/zstd, it will inform an error when zlib/zstd is selected)
>  - qat (it can provide acceleration of zlib/zstd)

Here IMHO we don't need qpl then, because the "qpl" compression method can
enforce an hardware accelerator.  In summary, not sure whether this works;

Compression methods: none, zlib, zstd, qpl (describes all the algorithms
that might be used; again, qpl enforces HW support).

Compression accelerators: auto, none, qat (only applies when zlib/zstd
chosen above)

> 
> > > Test condition:
> > >   1. Host CPUs are based on Sapphire Rapids, and frequency locked to
> > 3.4G
> > >   2. VM type, 16 vCPU and 64G memory
> > >   3. The Idle workload means no workload is running in the VM
> > >   4. The Redis workload means YCSB workloadb + Redis Server are running
> > >      in the VM, about 20G or more memory will be used.
> > >   5. Source side migartion configuration commands
> > >      a. migrate_set_capability multifd on
> > >      b. migrate_set_parameter multifd-channels 2/4/8
> > >      c. migrate_set_parameter downtime-limit 300
> > >      d. migrate_set_parameter multifd-compression zlib
> > >      e. migrate_set_parameter multifd-compression-accel none/qpl
> > >      f. migrate_set_parameter max-bandwidth 100G
> > >   6. Desitination side migration configuration commands
> > >      a. migrate_set_capability multifd on
> > >      b. migrate_set_parameter multifd-channels 2/4/8
> > >      c. migrate_set_parameter multifd-compression zlib
> > >      d. migrate_set_parameter multifd-compression-accel none/qpl
> > >      e. migrate_set_parameter max-bandwidth 100G
> > 
> > How is zlib-level setup?  Default (1)?
> Yes, use level 1 the default level.
> 
> > Btw, it seems both zlib/zstd levels are not even working right now to be
> > configured.. probably overlooked in migrate_params_apply().
> Ok, I will check this.

Thanks.  If you plan to post patch, please attach:

Reported-by: Xiaohui Li <xiaohli@redhat.com>

As that's reported by our QE team.

Maybe you can already add an unit test (migration-test.c, under tests/)
which should expose this issue already, by setting z*-level to non-1 then
query it back, asserting that the value did change.

> 
> > > Early migration result, each result is the average of three tests
> > > +--------+-------------+--------+--------+---------+----+-----+
> > >  |        | The number  |total   |downtime|network  |pages per |
> > >  |        | of channels |time(ms)|(ms)    |bandwidth|second    |
> > >  |        | and mode    |        |        |(mbps)   |          |
> > >  |        +-------------+-----------------+---------+----------+
> > >  |        | 2 chl, Zlib | 20647  | 22     | 195     | 137767   |
> > >  |        +-------------+--------+--------+---------+----------+
> > >  | Idle   | 2 chl, IAA  | 17022  | 36     | 286     | 460289   |
> > >  |workload+-------------+--------+--------+---------+----------+
> > >  |        | 4 chl, Zlib | 18835  | 29     | 241     | 299028   |
> > >  |        +-------------+--------+--------+---------+----------+
> > >  |        | 4 chl, IAA  | 16280  | 32     | 298     | 652456   |
> > >  |        +-------------+--------+--------+---------+----------+
> > >  |        | 8 chl, Zlib | 17379  | 32     | 275     | 470591   |
> > >  |        +-------------+--------+--------+---------+----------+
> > >  |        | 8 chl, IAA  | 15551  | 46     | 313     | 1315784  |
> > 
> > The number is slightly confusing to me.  If IAA can send 3x times more
> > pages per-second, shouldn't the total migration time 1/3 of the other if
> > the guest is idle?  But the total times seem to be pretty close no matter
> > N of channels. Maybe I missed something?
> 
> This data is the information read from "info migrate" after the live migration status changes to "complete".
> I think it is the max throughout when expected downtime and network available bandwidth are met.
> In vCPUs are idle, live migration does not run at maximum throughput for too long.
> 
> > >  +--------+-------------+--------+--------+---------+----------+
> > >
> > >  +--------+-------------+--------+--------+---------+----+-----+
> > >  |        | The number  |total   |downtime|network  |pages per |
> > >  |        | of channels |time(ms)|(ms)    |bandwidth|second    |
> > >  |        | and mode    |        |        |(mbps)   |          |
> > >  |        +-------------+-----------------+---------+----------+
> > >  |        | 2 chl, Zlib | 100% failure, timeout is 120s        |
> > >  |        +-------------+--------+--------+---------+----------+
> > >  | Redis  | 2 chl, IAA  | 62737  | 115    | 4547    | 387911   |
> > >  |workload+-------------+--------+--------+---------+----------+
> > >  |        | 4 chl, Zlib | 30% failure, timeout is 120s         |
> > >  |        +-------------+--------+--------+---------+----------+
> > >  |        | 4 chl, IAA  | 54645  | 177    | 5382    | 656865   |
> > >  |        +-------------+--------+--------+---------+----------+
> > >  |        | 8 chl, Zlib | 93488  | 74     | 1264    | 129486   |
> > >  |        +-------------+--------+--------+---------+----------+
> > >  |        | 8 chl, IAA  | 24367  | 303    | 6901    | 964380   |
> > >  +--------+-------------+--------+--------+---------+----------+
> > 
> > The redis results look much more preferred on using IAA comparing to the
> > idle tests.  Does it mean that IAA works less good with zero pages in
> > general (assuming that'll be the majority in idle test)?
> Both Idle and Redis data are not the best performance for IAA since it is based on multifd packet streaming compression.
> In the idle case, most pages are indeed zero page, zero page compression is not as good as only detecting zero pages, so the compression advantage is not reflected.
> 
> > From the manual, I see that IAA also supports encryption/decryption.
> > Would it be able to accelerate TLS?
> From Sapphire Rapids(SPR)/Emerald Rapids (EMR) Xeon servers, IAA can't support encryption/decryption. This feature may be available in future generations
> For TLS acceleration, QAT supports this function on SPR/EMR and has successful cases in some scenarios.
> https://www.intel.cn/content/www/cn/zh/developer/articles/guide/nginx-https-with-qat-tuning-guide.html
> 
> > How should one consider IAA over QAT?  What is the major difference?  I
> > see that IAA requires IOMMU scalable mode, why?  Is it because the IAA HW
> > is something attached to the pcie bus (assume QAT the same)?
> 
> Regarding the difference between using IAA or QAT for compression
> 1. IAA is more suitable for 4K compression, and QAT is suitable for large block data compression. This is determined by the deflate windows size, and QAT can support more compression levels. IAA hardware supports 1 compression level.
> 2. From the perspective of throughput, one IAA device supports compression throughput is 4GBps and decompression is 30GBps. One QAT support compression or decompression throughput is 20GBps.
> 3. Depending on the product type selected by the customer and the deployment, the resources used for live migration will also be different.
> 
> Regarding the IOMMU scalable mode
> 1. The current IAA software stack requires Shared Virtual Memory (SVM) technology, and SVM depends on IOMMU scalable mode.
> 2. Both IAA and QAT support PCIe PASID capability, then IAA can support shared work queue.
> https://docs.kernel.org/next/x86/sva.html

Thanks for all these information.  I'm personally still curious why Intel
would like to provide two new technology to service similar purposes merely
at the same time window.

Could you put many of these information into a doc file?  It can be
docs/devel/migration/QPL.rst.

Also, we may want an unit test to cover the new stuff when the whole design
settles. It may cover all mode supported, but for sure we can skip hw
accelerated use case.

-- 
Peter Xu


