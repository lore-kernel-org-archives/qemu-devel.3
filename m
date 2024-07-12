Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159F6C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 10:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSDzS-000338-Hf; Fri, 12 Jul 2024 06:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sSDzM-0002y3-Mn
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 06:58:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sSDzI-0002Wk-M6
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 06:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720781930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IqxD5BOxQJdaPsnRo1aq8ES5B2GgfvKS0QVRiut+TB0=;
 b=BOHWfhpatIvPSukGNrgQXN+HXf6awOW/Hr1Sze4QqhWMXyjJozBqBG28TCAQitRCOrQquI
 j9Tep+5qHtAQkZcfBw4QjbbT4HH/M73kCpxQ4OwIEjKtnO225WOzybRU668Y+GqT8jA8qt
 VSNpFfWSeAAor49tSm4L+jGsP8oU2pg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-RVud6_vLObGAomu79_1yZA-1; Fri, 12 Jul 2024 06:58:46 -0400
X-MC-Unique: RVud6_vLObGAomu79_1yZA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42668796626so12463675e9.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 03:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720781925; x=1721386725;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IqxD5BOxQJdaPsnRo1aq8ES5B2GgfvKS0QVRiut+TB0=;
 b=DfRYLtfZk9wuMbaazOhCbV8SwEtap0wu3FCFbyrn7OS1mTY2jAah8My9mZcVPzF5EL
 YP94uT+TVyFJCJzDUqw41V8tmQlFyejymMmTDij5O8hFgMBdy0ysnrnekSkR/Q/wtVhU
 m3VyyF1c2adKhS4lKTIjCvGP48lwkd6IUaupFXlXly0ZOn3yxQ78Q+7AcWj1o47Ecp9X
 cG4MJN4ys5ApgySZAR6Gq2CUZ7wF37bn+0TVWQDoC2igpKBWdehMMdcQ903of3LMD8e9
 t/k+uAig7QvUJO4NIGTzVwFxuVUI7DbJUIg8pGwwwlDswiw4tm3r5H1vEoAwDdkzsOuT
 TxYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAhdBXo12/l6EmZS0Uik25ZRi1DG88b3qAdDgIc7yPGmKf4uKeO+TWblSDDATJDJP5dBuoOLkfg2lfH6LBbRutghXK66c=
X-Gm-Message-State: AOJu0YyYG6fh50Mxq8CMYNDmJTMq7tEiUVQ3dE0Go/KNeIkqILmxT+TO
 7+rsg0P/b3tqs59fhVcrIWEFg0u5JuHp5a8EJK6EVntPPAUZhpXaqMQTE7stH9dMwWj/bZHstfO
 m4lVHHSPgmTrTX+28MXRcLj7rllB+3JUqNBa3WQugRjryAR2Barpu
X-Received: by 2002:a05:600c:358f:b0:426:8ee5:5d24 with SMTP id
 5b1f17b1804b1-4268ef4a0b6mr61150355e9.20.1720781925253; 
 Fri, 12 Jul 2024 03:58:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL6mkw1QMIoGUT6RIqTq9phKJYZq5S9rZd/cMd7k8SipZw5jd4Migvrw9ahgB+LIev+blMtQ==
X-Received: by 2002:a05:600c:358f:b0:426:8ee5:5d24 with SMTP id
 5b1f17b1804b1-4268ef4a0b6mr61150055e9.20.1720781924646; 
 Fri, 12 Jul 2024 03:58:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:341:761e:f82:fc9a:623b:3fd1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f25abf0sm20058055e9.14.2024.07.12.03.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 03:58:44 -0700 (PDT)
Date: Fri, 12 Jul 2024 06:58:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yichen Wang <yichen.wang@bytedance.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 Shivam Kumar <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Subject: Re: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to offload zero
 page checking in multifd live migration.
Message-ID: <20240712065342-mutt-send-email-mst@kernel.org>
References: <20240711215244.19237-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711215244.19237-1-yichen.wang@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
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

On Thu, Jul 11, 2024 at 02:52:35PM -0700, Yichen Wang wrote:
> v5
> * Rebase on top of 39a032cea23e522268519d89bb738974bc43b6f6.
> * Rename struct definitions with typedef and CamelCase names;
> * Add build and runtime checks about DSA accelerator;
> * Address all comments from v4 reviews about typos, licenses, comments,
> error reporting, etc.
> 
> v4
> * Rebase on top of 85b597413d4370cb168f711192eaef2eb70535ac.
> * A separate "multifd zero page checking" patchset was split from this
> patchset's v3 and got merged into master. v4 re-applied the rest of all
> commits on top of that patchset, re-factored and re-tested.
> https://lore.kernel.org/all/20240311180015.3359271-1-hao.xiang@linux.dev/
> * There are some feedback from v3 I likely overlooked.
>  
> v3
> * Rebase on top of 7425b6277f12e82952cede1f531bfc689bf77fb1.
> * Fix error/warning from checkpatch.pl
> * Fix use-after-free bug when multifd-dsa-accel option is not set.
> * Handle error from dsa_init and correctly propogate the error.
> * Remove unnecessary call to dsa_stop.
> * Detect availability of DSA feature at compile time.
> * Implement a generic batch_task structure and a DSA specific one dsa_batch_task.
> * Remove all exit() calls and propagate errors correctly.
> * Use bytes instead of page count to configure multifd-packet-size option.
> 
> v2
> * Rebase on top of 3e01f1147a16ca566694b97eafc941d62fa1e8d8.
> * Leave Juan's changes in their original form instead of squashing them.
> * Add a new commit to refactor the multifd_send_thread function to prepare for introducing the DSA offload functionality.
> * Use page count to configure multifd-packet-size option.
> * Don't use the FLAKY flag in DSA tests.
> * Test if DSA integration test is setup correctly and skip the test if
> * not.
> * Fixed broken link in the previous patch cover.
> 
> * Background:

The DSA interface here is extremely low level: it would mean we add a
ton of complex fragile code for any new accelerator.
Please add something high level and simple on top of this.
Off the top of my head:

void start_memcmp(void *a, void *b, int cnt, void *opaque,
	void (*callback)(int result, void *a, void *b, int cnt, void *opaque)
	);

Do all the batching hacks internally.




> I posted an RFC about DSA offloading in QEMU:
> https://patchew.org/QEMU/20230529182001.2232069-1-hao.xiang@bytedance.com/
> 
> This patchset implements the DSA offloading on zero page checking in
> multifd live migration code path.
> 
> * Overview:
> 
> Intel Data Streaming Accelerator(DSA) is introduced in Intel's 4th generation
> Xeon server, aka Sapphire Rapids.
> https://cdrdv2-public.intel.com/671116/341204-intel-data-streaming-accelerator-spec.pdf
> https://www.intel.com/content/www/us/en/content-details/759709/intel-data-streaming-accelerator-user-guide.html
> One of the things DSA can do is to offload memory comparison workload from
> CPU to DSA accelerator hardware. This patchset implements a solution to offload
> QEMU's zero page checking from CPU to DSA accelerator hardware. We gain
> two benefits from this change:
> 1. Reduces CPU usage in multifd live migration workflow across all use
> cases.
> 2. Reduces migration total time in some use cases. 
> 
> * Design:
> 
> These are the logical steps to perform DSA offloading:
> 1. Configure DSA accelerators and create user space openable DSA work
> queues via the idxd driver.
> 2. Map DSA's work queue into a user space address space.
> 3. Fill an in-memory task descriptor to describe the memory operation.
> 4. Use dedicated CPU instruction _enqcmd to queue a task descriptor to
> the work queue.
> 5. Pull the task descriptor's completion status field until the task
> completes.
> 6. Check return status.
> 
> The memory operation is now totally done by the accelerator hardware but
> the new workflow introduces overheads. The overhead is the extra cost CPU
> prepares and submits the task descriptors and the extra cost CPU pulls for
> completion. The design is around minimizing these two overheads.
> 
> 1. In order to reduce the overhead on task preparation and submission,
> we use batch descriptors. A batch descriptor will contain N individual
> zero page checking tasks where the default N is 128 (default packet size
> / page size) and we can increase N by setting the packet size via a new
> migration option.
> 2. The multifd sender threads prepares and submits batch tasks to DSA
> hardware and it waits on a synchronization object for task completion.
> Whenever a DSA task is submitted, the task structure is added to a
> thread safe queue. It's safe to have multiple multifd sender threads to
> submit tasks concurrently.
> 3. Multiple DSA hardware devices can be used. During multifd initialization,
> every sender thread will be assigned a DSA device to work with. We
> use a round-robin scheme to evenly distribute the work across all used
> DSA devices.
> 4. Use a dedicated thread dsa_completion to perform busy pulling for all
> DSA task completions. The thread keeps dequeuing DSA tasks from the
> thread safe queue. The thread blocks when there is no outstanding DSA
> task. When pulling for completion of a DSA task, the thread uses CPU
> instruction _mm_pause between the iterations of a busy loop to save some
> CPU power as well as optimizing core resources for the other hypercore.
> 5. DSA accelerator can encounter errors. The most popular error is a
> page fault. We have tested using devices to handle page faults but
> performance is bad. Right now, if DSA hits a page fault, we fallback to
> use CPU to complete the rest of the work. The CPU fallback is done in
> the multifd sender thread.
> 6. Added a new migration option multifd-dsa-accel to set the DSA device
> path. If set, the multifd workflow will leverage the DSA devices for
> offloading.
> 7. Added a new migration option multifd-normal-page-ratio to make
> multifd live migration easier to test. Setting a normal page ratio will
> make live migration recognize a zero page as a normal page and send
> the entire payload over the network. If we want to send a large network
> payload and analyze throughput, this option is useful.
> 8. Added a new migration option multifd-packet-size. This can increase
> the number of pages being zero page checked and sent over the network.
> The extra synchronization between the sender threads and the dsa
> completion thread is an overhead. Using a large packet size can reduce
> that overhead.
> 
> * Performance:
> 
> We use two Intel 4th generation Xeon servers for testing.
> 
> Architecture:        x86_64
> CPU(s):              192
> Thread(s) per core:  2
> Core(s) per socket:  48
> Socket(s):           2
> NUMA node(s):        2
> Vendor ID:           GenuineIntel
> CPU family:          6
> Model:               143
> Model name:          Intel(R) Xeon(R) Platinum 8457C
> Stepping:            8
> CPU MHz:             2538.624
> CPU max MHz:         3800.0000
> CPU min MHz:         800.0000
> 
> We perform multifd live migration with below setup:
> 1. VM has 100GB memory. 
> 2. Use the new migration option multifd-set-normal-page-ratio to control the total
> size of the payload sent over the network.
> 3. Use 8 multifd channels.
> 4. Use tcp for live migration.
> 4. Use CPU to perform zero page checking as the baseline.
> 5. Use one DSA device to offload zero page checking to compare with the baseline.
> 6. Use "perf sched record" and "perf sched timehist" to analyze CPU usage.
> 
> A) Scenario 1: 50% (50GB) normal pages on an 100GB vm.
> 
> 	CPU usage
> 
> 	|---------------|---------------|---------------|---------------|
> 	|		|comm		|runtime(msec)	|totaltime(msec)|
> 	|---------------|---------------|---------------|---------------|
> 	|Baseline	|live_migration	|5657.58	|		|
> 	|		|multifdsend_0	|3931.563	|		|
> 	|		|multifdsend_1	|4405.273	|		|
> 	|		|multifdsend_2	|3941.968	|		|
> 	|		|multifdsend_3	|5032.975	|		|
> 	|		|multifdsend_4	|4533.865	|		|
> 	|		|multifdsend_5	|4530.461	|		|
> 	|		|multifdsend_6	|5171.916	|		|
> 	|		|multifdsend_7	|4722.769	|41922		|
> 	|---------------|---------------|---------------|---------------|
> 	|DSA		|live_migration	|6129.168	|		|
> 	|		|multifdsend_0	|2954.717	|		|
> 	|		|multifdsend_1	|2766.359	|		|
> 	|		|multifdsend_2	|2853.519	|		|
> 	|		|multifdsend_3	|2740.717	|		|
> 	|		|multifdsend_4	|2824.169	|		|
> 	|		|multifdsend_5	|2966.908	|		|
> 	|		|multifdsend_6	|2611.137	|		|
> 	|		|multifdsend_7	|3114.732	|		|
> 	|		|dsa_completion	|3612.564	|32568		|
> 	|---------------|---------------|---------------|---------------|
> 
> Baseline total runtime is calculated by adding up all multifdsend_X
> and live_migration threads runtime. DSA offloading total runtime is
> calculated by adding up all multifdsend_X, live_migration and
> dsa_completion threads runtime. 41922 msec VS 32568 msec runtime and
> that is 23% total CPU usage savings.
> 
> 	Latency
> 	|---------------|---------------|---------------|---------------|---------------|---------------|
> 	|		|total time	|down time	|throughput	|transferred-ram|total-ram	|
> 	|---------------|---------------|---------------|---------------|---------------|---------------|	
> 	|Baseline	|10343 ms	|161 ms		|41007.00 mbps	|51583797 kb	|102400520 kb	|
> 	|---------------|---------------|---------------|---------------|-------------------------------|
> 	|DSA offload	|9535 ms	|135 ms		|46554.40 mbps	|53947545 kb	|102400520 kb	|	
> 	|---------------|---------------|---------------|---------------|---------------|---------------|
> 
> Total time is 8% faster and down time is 16% faster.
> 
> B) Scenario 2: 100% (100GB) zero pages on an 100GB vm.
> 
> 	CPU usage
> 	|---------------|---------------|---------------|---------------|
> 	|		|comm		|runtime(msec)	|totaltime(msec)|
> 	|---------------|---------------|---------------|---------------|
> 	|Baseline	|live_migration	|4860.718	|		|
> 	|	 	|multifdsend_0	|748.875	|		|
> 	|		|multifdsend_1	|898.498	|		|
> 	|		|multifdsend_2	|787.456	|		|
> 	|		|multifdsend_3	|764.537	|		|
> 	|		|multifdsend_4	|785.687	|		|
> 	|		|multifdsend_5	|756.941	|		|
> 	|		|multifdsend_6	|774.084	|		|
> 	|		|multifdsend_7	|782.900	|11154		|
> 	|---------------|---------------|-------------------------------|
> 	|DSA offloading	|live_migration	|3846.976	|		|
> 	|		|multifdsend_0	|191.880	|		|
> 	|		|multifdsend_1	|166.331	|		|
> 	|		|multifdsend_2	|168.528	|		|
> 	|		|multifdsend_3	|197.831	|		|
> 	|		|multifdsend_4	|169.580	|		|
> 	|		|multifdsend_5	|167.984	|		|
> 	|		|multifdsend_6	|198.042	|		|
> 	|		|multifdsend_7	|170.624	|		|
> 	|		|dsa_completion	|3428.669	|8700		|
> 	|---------------|---------------|---------------|---------------|
> 
> Baseline total runtime is 11154 msec and DSA offloading total runtime is
> 8700 msec. That is 22% CPU savings.
> 
> 	Latency
> 	|--------------------------------------------------------------------------------------------|
> 	|		|total time	|down time	|throughput	|transferred-ram|total-ram   |
> 	|---------------|---------------|---------------|---------------|---------------|------------|	
> 	|Baseline	|4867 ms	|20 ms		|1.51 mbps	|565 kb		|102400520 kb|
> 	|---------------|---------------|---------------|---------------|----------------------------|
> 	|DSA offload	|3888 ms	|18 ms		|1.89 mbps	|565 kb		|102400520 kb|	
> 	|---------------|---------------|---------------|---------------|---------------|------------|
> 
> Total time 20% faster and down time 10% faster.
> 
> * Testing:
> 
> 1. Added unit tests for cover the added code path in dsa.c
> 2. Added integration tests to cover multifd live migration using DSA
> offloading.
> 
> Hao Xiang (12):
>   meson: Introduce new instruction set enqcmd to the build system.
>   util/dsa: Implement DSA device start and stop logic.
>   util/dsa: Implement DSA task enqueue and dequeue.
>   util/dsa: Implement DSA task asynchronous completion thread model.
>   util/dsa: Implement zero page checking in DSA task.
>   util/dsa: Implement DSA task asynchronous submission and wait for
>     completion.
>   migration/multifd: Add new migration option for multifd DSA
>     offloading.
>   migration/multifd: Prepare to introduce DSA acceleration on the
>     multifd path.
>   migration/multifd: Enable DSA offloading in multifd sender path.
>   migration/multifd: Add migration option set packet size.
>   util/dsa: Add unit test coverage for Intel DSA task submission and
>     completion.
>   migration/multifd: Add integration tests for multifd with Intel DSA
>     offloading.
> 
> Yichen Wang (1):
>   util/dsa: Add idxd into linux header copy list.
> 
>  include/qemu/dsa.h              |  176 +++++
>  meson.build                     |   14 +
>  meson_options.txt               |    2 +
>  migration/migration-hmp-cmds.c  |   22 +-
>  migration/migration.c           |    2 +-
>  migration/multifd-zero-page.c   |  100 ++-
>  migration/multifd-zlib.c        |    6 +-
>  migration/multifd-zstd.c        |    6 +-
>  migration/multifd.c             |   53 +-
>  migration/multifd.h             |    8 +-
>  migration/options.c             |   85 +++
>  migration/options.h             |    2 +
>  qapi/migration.json             |   49 +-
>  scripts/meson-buildoptions.sh   |    3 +
>  scripts/update-linux-headers.sh |    2 +-
>  tests/qtest/migration-test.c    |   80 ++-
>  tests/unit/meson.build          |    6 +
>  tests/unit/test-dsa.c           |  503 ++++++++++++++
>  util/dsa.c                      | 1082 +++++++++++++++++++++++++++++++
>  util/meson.build                |    3 +
>  20 files changed, 2177 insertions(+), 27 deletions(-)
>  create mode 100644 include/qemu/dsa.h
>  create mode 100644 tests/unit/test-dsa.c
>  create mode 100644 util/dsa.c
> 
> -- 
> Yichen Wang


