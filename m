Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC565C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 15:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQqZP-0004O6-NI; Mon, 08 Jul 2024 11:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sQqZF-0004Mz-5b
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 11:46:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sQqZC-0003MD-Rc
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 11:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720453573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P6k4EpXsKOPlZOPblKQNV8GLILAZMQIqsSEIv3ueRdI=;
 b=IH4zpicp9hBeGohA2S7qO6rEg3r0WIcvzR7AOeQ7zG0BYB7QhK8mOOw3AzCjM8eLBQPWU7
 S+TdIibtQeahURU+t0wuKAY/IhBZ76aPBVh02BfZxhLkfeA7xXK4k8JG1PGrET5LvjAqZr
 f4aiiz2FXvqVtodMkZHZoa6s6NjKra8=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-FPjBfmaqPLGM_1SMvGNFFw-1; Mon, 08 Jul 2024 11:46:10 -0400
X-MC-Unique: FPjBfmaqPLGM_1SMvGNFFw-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-dfd377669d6so1117424276.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 08:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720453570; x=1721058370;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P6k4EpXsKOPlZOPblKQNV8GLILAZMQIqsSEIv3ueRdI=;
 b=M/rWr8AlMK4KJXndNJX656dVBrv2lc1SnklgF/bkMb0cvgx2fu++U4t7AxxWKMLf5B
 7xry7VpGHVk3I8h55GJJ782a3Zjs6qzfsnwjfKq64hKU1Vf2kmuVxjHHplbCZRZR+DQ1
 Hl59T3qW+ix0RqdRtPQvTda4HwHosjIWZvHSUuLzZmp508OgOlpR1u2deu10Ljj3gDhM
 YExWhkXnNKaTZOn59Nk720Meo5yw6GQJ9cr4qfsiH4OJH5FHCxiGz6McsJzl041yA3fp
 6lA+Cu84NixU2GHRs24oz+oeayBzPCQjIDOvVrhrB+I9Zl/Y9nY3DWF+i9QXN3AxhaMp
 B3WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtuU7WGJFIFkXqAiue6iBAot6FuU3wzc2o6RJiFrm2NKVx+7zW3H7kQ7qNroeh4YnFkdy0KlhZiRgkcHj3v1mZ37HX+zI=
X-Gm-Message-State: AOJu0YyR8HIzyqL3SSRZJi0yFnaOOeEPsFQUo9IESONIR9AfaI4ctpjm
 Mwf2t/YgKupdPVbN8jZtS3QLwyPKiYjZqe5XInNL0OzhaCYIfE5IlpVQNgfMEbxIfoPLosiHfQ5
 H2b+HU48AZXTAYW/1ZBn4NaXSjZswbsU6+1qXhL3ZAPQuj/M2n0N8
X-Received: by 2002:a25:84cb:0:b0:e03:af0f:f487 with SMTP id
 3f1490d57ef6-e041af41bcamr173319276.0.1720453569870; 
 Mon, 08 Jul 2024 08:46:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnZScfX1BF3HF1AaUGapdS9e1LCyPhs1tBVJ3sNZL6OIGyvdqLfRFR9B5xfUMS3VBucPAwGQ==
X-Received: by 2002:a25:84cb:0:b0:e03:af0f:f487 with SMTP id
 3f1490d57ef6-e041af41bcamr173293276.0.1720453569575; 
 Mon, 08 Jul 2024 08:46:09 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b61ba9f323sm494146d6.132.2024.07.08.08.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 08:46:09 -0700 (PDT)
Date: Mon, 8 Jul 2024 11:46:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Yichen Wang <yichen.wang@bytedance.com>
Cc: "Liu, Yuan1" <yuan1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Hao Xiang <hao.xiang@linux.dev>, "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Subject: Re: [External] [PATCH v3 0/4] Implement using Intel QAT to offload
 ZLIB
Message-ID: <ZowJvvvEJzgPiFAu@x1n>
References: <20240627223445.95096-1-yichen.wang@bytedance.com>
 <ZoRSA4naaje878PK@x1n>
 <PH7PR11MB5941E373F92A78EB5A7E4FCAA3DE2@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZobBeWWyf5aHGROj@x1n>
 <PH7PR11MB5941064312077F74CE235E45A3DF2@PH7PR11MB5941.namprd11.prod.outlook.com>
 <8E9B92DE-5576-48C9-8878-3F750DA116E4@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8E9B92DE-5576-48C9-8878-3F750DA116E4@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Fri, Jul 05, 2024 at 11:28:25AM -0700, Yichen Wang wrote:
> Just want to add some information here. So in ByteDance, the current
> generation server is quipped with 2*100Gb NIC. We reserve 10Gbps for
> control plane purposes which includes live migration here. So it is not
> about we are using “good network”, it is about not normal to use full
> bandwidth for control plane purposes. Hence we do have a requirements for
> QAT/IAA in these cases.

Yes, this makes sense.

But then you may then also want to figure out the high cpu consumption of
those cards, to not interrupt more important workloads?

I saw there's a new version posted, I didn't see an explanation of the cpu
consumption issue mentioned.  Meanwhile I also see that the docs/ update is
missing.

Would you consider adding both by replying to the new version?

-- 
Peter Xu


