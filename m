Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5839EC3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 15:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRZ5y-0007lP-Gz; Wed, 10 Jul 2024 11:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRZ5x-0007kv-6z
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:19:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRZ5v-0007ka-ET
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720624737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yYSm3+3l8zDGPUMdfoOmU6RHW39+rc4LRLrUStTBlGU=;
 b=S30YmUosOoNbpuX2bpckqbDhS3RbBRlz0OLLNDvkrTbpSVu1nTTesa2wBkXzIKJnRZiIdp
 FzOghmOqy5Mt9FVtySt9btCuafql6rEV3H/W74gbsLFZbnmUEm+CdVdciazEK72m5CxBiE
 yCBIRfqxNRJhrV/0YHMdItWR+TB5NcU=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-5VxJtiPXNG6xrfkToDqBSA-1; Wed, 10 Jul 2024 11:18:56 -0400
X-MC-Unique: 5VxJtiPXNG6xrfkToDqBSA-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3d62ad9f453so338696b6e.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 08:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720624735; x=1721229535;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yYSm3+3l8zDGPUMdfoOmU6RHW39+rc4LRLrUStTBlGU=;
 b=vnHBbXco9okpNSiJacEMnqpGVbTG/u9Y+7Cfi6tINoJDZs5d7I6/vB/8LiSpSl9J+l
 9CCFP5jeKwLuJtrK9jre/3PXxM6a2SgTTnbtKaOfEsVYPHG/b+X/lqIbeSo1tgq/hzeE
 EWbzuo89jWsDfgMRXz6ZX4SCi9pMng/lYjwsk2YB2j+OWp/YsJ+PeQhrP2bT6oiHDpnK
 pm6vEj3FFfmJwRRZYMdaeKTd8D0dpRLA85JZ8JDVIfR4BNvS0y3fzDC3e6jt8uHlB92O
 fa+wRqrCakHE+Ny1+/lete2RsshwQPCjnxjsZXFIzdWpRHabAobSh72ZYgt+mQMCoBtp
 orvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyp8fucs5hpdzQrt4m6tW8PzkBGL8cT6RoKBByBFgITtI8EB9BUiXtt1uY5ogwXHp/we4obd0+HDMHUdL13QpWYVsPSEw=
X-Gm-Message-State: AOJu0YwdQTHwVpDp2Aq451VzQ99T6jwep0cE1mWbYk91qW4Vit6dXtUf
 vgnqTpw6drXSVOIgBVm4woVph7VcVgg0phA6nhjzT+OssDX1fFc/7B3YzazXF4oTws5Onv8Gn5V
 yLsjZW3FSB1sifsI5UYK7y+562ioQjXkoK0qidUo2SlXzFwmBvkEw
X-Received: by 2002:a05:6808:148b:b0:3d9:2e1d:2543 with SMTP id
 5614622812f47-3d93c0fe45amr6007766b6e.5.1720624735291; 
 Wed, 10 Jul 2024 08:18:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOdJ2tomhbuI7BvjEC2ahwyrW70MgL3r5oM2oT5bZxcIN3AoXIxSherBSBQqKrh2Oc5/jvIA==
X-Received: by 2002:a05:6808:148b:b0:3d9:2e1d:2543 with SMTP id
 5614622812f47-3d93c0fe45amr6007738b6e.5.1720624734901; 
 Wed, 10 Jul 2024 08:18:54 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79f190b0af1sm203401185a.122.2024.07.10.08.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 08:18:54 -0700 (PDT)
Date: Wed, 10 Jul 2024 11:18:51 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yuan1" <yuan1.liu@intel.com>
Cc: "Wang, Yichen" <yichen.wang@bytedance.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Hao Xiang <hao.xiang@linux.dev>, "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Subject: Re: [PATCH v4 0/4] Implement using Intel QAT to offload ZLIB
Message-ID: <Zo6mWzuxFET1q81j@x1n>
References: <20240705182901.48948-1-yichen.wang@bytedance.com>
 <PH7PR11MB5941B008DD622227FB46E95EA3DB2@PH7PR11MB5941.namprd11.prod.outlook.com>
 <Zo2EsEqAY5KnkO1V@x1n>
 <PH7PR11MB594133AD3E08A6E35D07DD97A3A42@PH7PR11MB5941.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR11MB594133AD3E08A6E35D07DD97A3A42@PH7PR11MB5941.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Wed, Jul 10, 2024 at 01:55:23PM +0000, Liu, Yuan1 wrote:

[...]

> migrate_set_parameter max-bandwidth 1250M
> |-----------|--------|---------|----------|----------|------|------|
> |8 Channels |Total   |down     |throughput|pages per | send | recv |
> |           |time(ms)|time(ms) |(mbps)    |second    | cpu %| cpu% |
> |-----------|--------|---------|----------|----------|------|------|
> |qatzip     |   16630|       28|     10467|   2940235|   160|   360|
> |-----------|--------|---------|----------|----------|------|------|
> |zstd       |   20165|       24|      8579|   2391465|   810|   340|
> |-----------|--------|---------|----------|----------|------|------|
> |none       |   46063|       40|     10848|    330240|    45|    85|
> |-----------|--------|---------|----------|----------|------|------|
> 
> QATzip's dirty page processing throughput is much higher than that no compression. 
> In this test, the vCPUs are in idle state, so the migration can be successful even 
> without compression.

Thanks!  Maybe good material to be put into the docs/ too, if Yichen's
going to pick up your doc patch when repost.

[...]

> I don’t have much experience with postcopy, here are some of my thoughts
> 1. For write-intensive VMs, this solution can improve the migration success, 
>    because in a limited bandwidth network scenario, the dirty page processing
>    throughput will be significantly reduced for no compression, the previous
>    data includes this(pages_per_second), it means that in the no compression
>    precopy, the dirty pages generated by the workload are greater than the
>    migration processing, resulting in migration failure.

Yes.

> 
> 2. If the VM is read-intensive or has low vCPU utilization (for example, my 
>    current test scenario is that the vCPUs are all idle). I think no compression +
>    precopy + postcopy also cannot improve the migration performance, and may also
>    cause timeout failure due to long migration time, same with no compression precopy.

I don't think postcopy will trigger timeout failures - postcopy should use
constant time to complete a migration, that is guest memsize / bw.

The challenge is normally on the delay of page requests higher than
precopy, but in this case it might not be a big deal. And I wonder if on
100G*2 cards it can also perform pretty well, as the delay might be minimal
even if bandwidth is throttled.

> 
> 3. In my opinion, the postcopy is a good solution in this scenario(low network bandwidth,
>    VM is not critical), because even if compression is turned on, the migration may still 
>    fail(page_per_second may still less than the new dirty pages), and it is hard to predict
>    whether VM memory is compression-friendly.

Yes.

Thanks,

-- 
Peter Xu


