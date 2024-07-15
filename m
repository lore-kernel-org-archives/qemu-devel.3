Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B8FC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 12:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTKka-00005e-5M; Mon, 15 Jul 2024 08:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sTKkY-0008US-5J
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 08:24:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sTKkP-000829-8J
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 08:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721046242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4Eduw8aduiskin9r6RkwQ3S/uQgxHJt1b5haNWyHck=;
 b=B45q5nwZdqYFFaaBixOtPsz/KEuLhN56LdQmDQt1t3/BiP1kUxut8KDWh7mv/JrO1f4Gv8
 HjnQFgz7/Vya5H17G7IRRwUQQ4SScYJwBkI/OAvHNJEZf5QZsx4gJSBJBV+M6oMqerTsYK
 Qq5/hUS+2s1J20RsdkUcCq0Jk/RnKEI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-_3MQTSGJMSuG-OFd7p-CCg-1; Mon, 15 Jul 2024 08:24:01 -0400
X-MC-Unique: _3MQTSGJMSuG-OFd7p-CCg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ee90339092so48816521fa.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 05:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721046240; x=1721651040;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w4Eduw8aduiskin9r6RkwQ3S/uQgxHJt1b5haNWyHck=;
 b=hfjtXKWc6B5XFY7uTT73b7WGL7YqPlwk8GYijvnjY9JHQ1iadLCJfQznGKtZo2qOTm
 GzrP55d52jMdEQYfrBQHM70DEgH3JjCAT5CjUCYL+HIjKp+Aqk9SL/yVEBrDox7EcSer
 SMgZFP2nqnh9c44KsXhp8mL/FVWcOrGeM7O8aAlc2V/q1r2Zr2pEsq/tc37KQ6U46Ywi
 QfRV1yk0Drs5LtZEikt2YJatQgtPFr0/Qgp9e6YkEvn4yY07NVQgUDuAPkyN9ONMCX4q
 pfPMq8YUywzPYkGOZkpySAfBUkImrgaWJ4vhq5o+af6iQrRoRO5XT89KU2z9WXoozzQA
 IAsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG/v5V/1SB2zPwHfFvfyRs5OuEzVOVHV5Z5rgIz4PB6WlWEysktYClUrdlToSNj/3gJPPZMAVBd4PDUuVWryxYeTGE+yQ=
X-Gm-Message-State: AOJu0YwRi8Tg1AMk5j7uzyXWUW2aX2YvOe5pSwNEMg7LFd9D30EekMJX
 RBLyHOmGslkKfdXgAvMBZS1uXKNkBkVEJaVMw/Zq3G6gquqRPTU4cQ3xYj3GhLOQTq4E+7zoPoA
 URg7RSS7Gk2L6ou+6w48Xq4g0FhoJLflXVOznqnqfUrT4TJHi0LGL
X-Received: by 2002:a05:6512:3b20:b0:52c:c9ce:be8d with SMTP id
 2adb3069b0e04-52eb99d6de0mr13127492e87.57.1721046240090; 
 Mon, 15 Jul 2024 05:24:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9hX7y4YY/obRohZnKqrQtama+0410+/71MmNWai0P8ar/AiIH6XqBUIJsLUVa9ByO+feVbQ==
X-Received: by 2002:a05:6512:3b20:b0:52c:c9ce:be8d with SMTP id
 2adb3069b0e04-52eb99d6de0mr13127473e87.57.1721046239417; 
 Mon, 15 Jul 2024 05:23:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:243:da88:7ff9:68fc:2f43:bcdf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5edb4a3sm86299655e9.31.2024.07.15.05.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 05:23:58 -0700 (PDT)
Date: Mon, 15 Jul 2024 08:23:53 -0400
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
Message-ID: <20240715081857-mutt-send-email-mst@kernel.org>
References: <20240711215244.19237-1-yichen.wang@bytedance.com>
 <20240711184131-mutt-send-email-mst@kernel.org>
 <PH7PR11MB594105D464F3A4C2C25F94FEA3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR11MB594105D464F3A4C2C25F94FEA3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Jul 15, 2024 at 08:29:03AM +0000, Liu, Yuan1 wrote:
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Friday, July 12, 2024 6:49 AM
> > To: Wang, Yichen <yichen.wang@bytedance.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>; Marc-André Lureau
> > <marcandre.lureau@redhat.com>; Daniel P. Berrangé <berrange@redhat.com>;
> > Thomas Huth <thuth@redhat.com>; Philippe Mathieu-Daudé
> > <philmd@linaro.org>; Peter Xu <peterx@redhat.com>; Fabiano Rosas
> > <farosas@suse.de>; Eric Blake <eblake@redhat.com>; Markus Armbruster
> > <armbru@redhat.com>; Cornelia Huck <cohuck@redhat.com>; qemu-
> > devel@nongnu.org; Hao Xiang <hao.xiang@linux.dev>; Liu, Yuan1
> > <yuan1.liu@intel.com>; Kumar, Shivam <shivam.kumar1@nutanix.com>; Ho-Ren
> > (Jack) Chuang <horenchuang@bytedance.com>
> > Subject: Re: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to offload
> > zero page checking in multifd live migration.
> > 
> > On Thu, Jul 11, 2024 at 02:52:35PM -0700, Yichen Wang wrote:
> > > * Performance:
> > >
> > > We use two Intel 4th generation Xeon servers for testing.
> > >
> > > Architecture:        x86_64
> > > CPU(s):              192
> > > Thread(s) per core:  2
> > > Core(s) per socket:  48
> > > Socket(s):           2
> > > NUMA node(s):        2
> > > Vendor ID:           GenuineIntel
> > > CPU family:          6
> > > Model:               143
> > > Model name:          Intel(R) Xeon(R) Platinum 8457C
> > > Stepping:            8
> > > CPU MHz:             2538.624
> > > CPU max MHz:         3800.0000
> > > CPU min MHz:         800.0000
> > >
> > > We perform multifd live migration with below setup:
> > > 1. VM has 100GB memory.
> > > 2. Use the new migration option multifd-set-normal-page-ratio to control
> > the total
> > > size of the payload sent over the network.
> > > 3. Use 8 multifd channels.
> > > 4. Use tcp for live migration.
> > > 4. Use CPU to perform zero page checking as the baseline.
> > > 5. Use one DSA device to offload zero page checking to compare with the
> > baseline.
> > > 6. Use "perf sched record" and "perf sched timehist" to analyze CPU
> > usage.
> > >
> > > A) Scenario 1: 50% (50GB) normal pages on an 100GB vm.
> > >
> > > 	CPU usage
> > >
> > > 	|---------------|---------------|---------------|---------------|
> > > 	|		|comm		|runtime(msec)	|totaltime(msec)|
> > > 	|---------------|---------------|---------------|---------------|
> > > 	|Baseline	|live_migration	|5657.58	|		|
> > > 	|		|multifdsend_0	|3931.563	|		|
> > > 	|		|multifdsend_1	|4405.273	|		|
> > > 	|		|multifdsend_2	|3941.968	|		|
> > > 	|		|multifdsend_3	|5032.975	|		|
> > > 	|		|multifdsend_4	|4533.865	|		|
> > > 	|		|multifdsend_5	|4530.461	|		|
> > > 	|		|multifdsend_6	|5171.916	|		|
> > > 	|		|multifdsend_7	|4722.769	|41922		|
> > > 	|---------------|---------------|---------------|---------------|
> > > 	|DSA		|live_migration	|6129.168	|		|
> > > 	|		|multifdsend_0	|2954.717	|		|
> > > 	|		|multifdsend_1	|2766.359	|		|
> > > 	|		|multifdsend_2	|2853.519	|		|
> > > 	|		|multifdsend_3	|2740.717	|		|
> > > 	|		|multifdsend_4	|2824.169	|		|
> > > 	|		|multifdsend_5	|2966.908	|		|
> > > 	|		|multifdsend_6	|2611.137	|		|
> > > 	|		|multifdsend_7	|3114.732	|		|
> > > 	|		|dsa_completion	|3612.564	|32568		|
> > > 	|---------------|---------------|---------------|---------------|
> > >
> > > Baseline total runtime is calculated by adding up all multifdsend_X
> > > and live_migration threads runtime. DSA offloading total runtime is
> > > calculated by adding up all multifdsend_X, live_migration and
> > > dsa_completion threads runtime. 41922 msec VS 32568 msec runtime and
> > > that is 23% total CPU usage savings.
> > 
> > 
> > Here the DSA was mostly idle.
> > 
> > Sounds good but a question: what if several qemu instances are
> > migrated in parallel?
> > 
> > Some accelerators tend to basically stall if several tasks
> > are trying to use them at the same time.
> > 
> > Where is the boundary here?
> 
> A DSA device can be assigned to multiple Qemu instances. 
> The DSA resource used by each process is called a work queue, each DSA
> device can support up to 8 work queues and work queues are classified into 
> dedicated queues and shared queues. 
> 
> A dedicated queue can only serve one process. Theoretically, there is no limit 
> on the number of processes in a shared queue, it is based on enqcmd + SVM technology.
> 
> https://www.kernel.org/doc/html/v5.17/x86/sva.html

This server has 200 CPUs which can thinkably migrate around 100 single
cpu qemu instances with no issue. What happens if you do this with DSA?

> > --
> > MST


