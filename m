Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67251C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 22:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS2bh-00019N-CF; Thu, 11 Jul 2024 18:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sS2bf-00018s-PO
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:49:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sS2bd-000631-Nf
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720738179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y738lNqBcRkfsnLk3tFCnr8supLZRBSaBLCvUGVRgaw=;
 b=bk1QqbVPDbcxxNxBpQwnRZ/EfwRWSgFnzGLJuvzn5x7Te6/aUxoZIv1lxi38g8bENquBwu
 TBVtuJTHfS4yMFznIX3SqDn9j7NT9/9cOtX+yT8pjzh0L/XhLp7MdhmSwlBrRkeC01MW0b
 yZwnh23LW9N+fgj9x1wqoHEg76rC35k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-ql5mrTrBOe-HEFx1jxrPDA-1; Thu, 11 Jul 2024 18:49:37 -0400
X-MC-Unique: ql5mrTrBOe-HEFx1jxrPDA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-426724679f0so12389835e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 15:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720738176; x=1721342976;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y738lNqBcRkfsnLk3tFCnr8supLZRBSaBLCvUGVRgaw=;
 b=xESDz1D0Z9f7wVOmRB1W3vw7uKYn97tWAXNFKi0IzwsA2aBwlvCRUG0EYtbMrRmivV
 uKtEBr9jNvmaHgYt5y4Sok2PzxJJOXsQWf/pfv4RcqBLzOZ87O07OF4YjoGq+mnEl+T8
 YXKBl9ZySYZ7bX7KRsWNjGHg0oTrAWMdppFEWxSvkYM+Pd5vpbWf3ciuEt+oqN1xcvfK
 JSuUYbQSdv11mko+t+JMGgkrNCRT4iRuKkcho/SHM7eTwL0F9Lq3x51Rhh3UgGZ0S/gR
 fUXzbg8GhuSF/pj/1GfiZFkgxXi7P4DgpuwOC1PrUosSK6QBrxEPa9W7nemFI8zVvXyY
 Shdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw8VlMCDZzGorXFYl0EnrHpjSKSSmbOELRQ8/jPY88Ftyl6VoD+PgO/QwkiVE1j6OgsBtnvWH7DNLJMgquER+WZa1Edno=
X-Gm-Message-State: AOJu0Yz+tpd4juf1k+5mDAv3ezF7nqPRBuwgpmsg1uAKb6KPppwiP4Z9
 jH9/RPGsSGARqsOUgX5ORWcsI/FePBVicpeWwW51I80QNZzeCY3wIQNYk6whD22WM4uYFeX9tro
 9KY4uI/xA5NmCsSo7+Yta3ebSEmMLflW7x6TviFzKQ5JFd3u5OdDY
X-Received: by 2002:a05:600c:4f49:b0:424:aa83:ef27 with SMTP id
 5b1f17b1804b1-4279d9f289emr8630845e9.1.1720738176114; 
 Thu, 11 Jul 2024 15:49:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESwKR3fcxTB8hhovkxnpTwz7Rfyh3EJ5CWJBSYmhLGxng/DlHyc4RJdV1a+a/3oZmVxXGkYQ==
X-Received: by 2002:a05:600c:4f49:b0:424:aa83:ef27 with SMTP id
 5b1f17b1804b1-4279d9f289emr8630605e9.1.1720738175593; 
 Thu, 11 Jul 2024 15:49:35 -0700 (PDT)
Received: from redhat.com ([2a02:14f:173:2166:83a4:d566:a055:a5a3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2679b1sm2894615e9.15.2024.07.11.15.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 15:49:35 -0700 (PDT)
Date: Thu, 11 Jul 2024 18:49:27 -0400
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
Message-ID: <20240711184131-mutt-send-email-mst@kernel.org>
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
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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


Here the DSA was mostly idle.

Sounds good but a question: what if several qemu instances are
migrated in parallel?

Some accelerators tend to basically stall if several tasks
are trying to use them at the same time.

Where is the boundary here?




-- 
MST


