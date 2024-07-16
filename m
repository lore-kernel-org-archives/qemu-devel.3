Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9981C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjVZ-0003yI-Hh; Tue, 16 Jul 2024 10:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sTjVX-0003qR-EU
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:50:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sTjVV-0004qr-JZ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721141420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xy4W8ewlRd3anAfMBOZ4Y0zmjYRWyeJnCypJKZgyayY=;
 b=LMtGdzgK1kU8g9jqe5l1VjSCTyJMg/ZASgK/5u0/HlnPD3/QdELrYMZV1vOarX73/qamly
 aRsk4rpZ8p+H0vwUhej0bm7NfCm6mLv34d6u45V71/US6QhMrg7vEhem4xGC6Q1JvYhL3w
 8akx88tYBGG9KEAdclBYvSHR1bUcr6U=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-dGNRpEf_Ovy46fIvTJiAdw-1; Tue, 16 Jul 2024 10:50:18 -0400
X-MC-Unique: dGNRpEf_Ovy46fIvTJiAdw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7a05c09d2fbso10790185a.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 07:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721141417; x=1721746217;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xy4W8ewlRd3anAfMBOZ4Y0zmjYRWyeJnCypJKZgyayY=;
 b=uUARGu68PmSQUS1y/QYMxuV//LNPXt4gr8vLaEHj1NCWoFSSxiovT18oMqj4BMKqMm
 oF+GUjf/X8a9dNxBLzzUYjcZn0yj6BXD7hmdPmy9nv3f+EA0rgNn9FJyHU2kxXcdMTDs
 Z/eoYCBwJZAZmXtYRg2XOjrrJ1vh/DdFJTNLOKYDv/inaS7t2l25WkeoUnaHunPgMzD5
 8gV/+QpVpHu8oE5ckhOfjxKlnSNDP54hqzLmCbpW9JlXf3NKFcHkGTuniJYT0rNk4OSj
 jjx4AUBiT7i4DFxpziYQz4xu2pm1FFP31NHaI1drIaX+61fSvPUbet+/TTafJnDQtWtG
 g3wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzsgMROdLG8xw7ajT5GoGhQT9bvl/ZP7ALkT8CjwO14xKvg4uLC7ETRRVmW2yw4DdeOWy57C79d/8NsNoGh76XLboVpho=
X-Gm-Message-State: AOJu0YxRhEesAEQWnCdEVLg8B5LgaOLOtT4NI8qv5dA3aLC2UrRaVWFo
 bqYjvatFIgH3kBfIa1E/F6LBry7zkjuejQbLNF1L6OJIQqwojwvAh5YdiiTbIcZBakm+eO4T8ek
 vBggiPqzq9l2hpASlK6+GGOjwWdkfjXqTmPLKa3dLmT1j0z20nM7D
X-Received: by 2002:a05:620a:4694:b0:79b:eca2:b807 with SMTP id
 af79cd13be357-7a179f17721mr244962585a.3.1721141417446; 
 Tue, 16 Jul 2024 07:50:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc0JlXwbu5mgxtH6IFtZ54OG1Q5O4rSPzZkQ92SWbzGG871dAwUhfLg7mOTkYFz8bdpkVk2A==
X-Received: by 2002:a05:620a:4694:b0:79b:eca2:b807 with SMTP id
 af79cd13be357-7a179f17721mr244959485a.3.1721141417065; 
 Tue, 16 Jul 2024 07:50:17 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a160b9087asm299655785a.16.2024.07.16.07.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 07:50:16 -0700 (PDT)
Date: Tue, 16 Jul 2024 10:50:13 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yuan1" <yuan1.liu@intel.com>
Cc: "Wang, Yichen" <yichen.wang@bytedance.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Hao Xiang <hao.xiang@linux.dev>, "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Subject: Re: [PATCH v6 1/5] docs/migration: add qatzip compression feature
Message-ID: <ZpaIpXyVWdLHGkbB@x1n>
References: <20240715221245.12435-1-yichen.wang@bytedance.com>
 <20240715221245.12435-2-yichen.wang@bytedance.com>
 <PH7PR11MB59410143A089733E8FAC5A36A3A22@PH7PR11MB5941.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR11MB59410143A089733E8FAC5A36A3A22@PH7PR11MB5941.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 16, 2024 at 02:34:07AM +0000, Liu, Yuan1 wrote:
> > -----Original Message-----
> > From: Yichen Wang <yichen.wang@bytedance.com>
> > Sent: Tuesday, July 16, 2024 6:13 AM
> > To: Peter Xu <peterx@redhat.com>; Fabiano Rosas <farosas@suse.de>; Paolo
> > Bonzini <pbonzini@redhat.com>; Daniel P. Berrangé <berrange@redhat.com>;
> > Eduardo Habkost <eduardo@habkost.net>; Marc-André Lureau
> > <marcandre.lureau@redhat.com>; Thomas Huth <thuth@redhat.com>; Philippe
> > Mathieu-Daudé <philmd@linaro.org>; Eric Blake <eblake@redhat.com>; Markus
> > Armbruster <armbru@redhat.com>; Laurent Vivier <lvivier@redhat.com>; qemu-
> > devel@nongnu.org
> > Cc: Hao Xiang <hao.xiang@linux.dev>; Liu, Yuan1 <yuan1.liu@intel.com>;
> > Zou, Nanhai <nanhai.zou@intel.com>; Ho-Ren (Jack) Chuang
> > <horenchuang@bytedance.com>; Wang, Yichen <yichen.wang@bytedance.com>
> > Subject: [PATCH v6 1/5] docs/migration: add qatzip compression feature
> > 
> > From: Yuan Liu <yuan1.liu@intel.com>
> > 
> > add Intel QATzip compression method introduction
> > 
> > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> > Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Reviewed-by: Yichen Wang <yichen.wang@bytedance.com>
> > ---
> >  docs/devel/migration/features.rst           |   1 +
> >  docs/devel/migration/qatzip-compression.rst | 251 ++++++++++++++++++++
> >  2 files changed, 252 insertions(+)
> >  create mode 100644 docs/devel/migration/qatzip-compression.rst
> > 
> > diff --git a/docs/devel/migration/features.rst
> > b/docs/devel/migration/features.rst
> > index 58f8fd9e16..8f431d52f9 100644
> > --- a/docs/devel/migration/features.rst
> > +++ b/docs/devel/migration/features.rst
> > @@ -14,3 +14,4 @@ Migration has plenty of features to support different
> > use cases.
> >     CPR
> >     qpl-compression
> >     uadk-compression
> > +   qatzip-compression
> > diff --git a/docs/devel/migration/qatzip-compression.rst
> > b/docs/devel/migration/qatzip-compression.rst
> > new file mode 100644
> > index 0000000000..72fa3e2826
> > --- /dev/null
> > +++ b/docs/devel/migration/qatzip-compression.rst
> > @@ -0,0 +1,251 @@
> > +==================
> > +QATzip Compression
> > +==================
> > +In scenarios with limited network bandwidth, the ``QATzip`` solution can
> > help
> > +users save a lot of host CPU resources by accelerating compression and
> > +decompression through the Intel QuickAssist Technology(``QAT``) hardware.
> 
> Hi Yichen
> 
> Thanks for adding the part of Performance Testing with QATzip, I wonder if we
> can remove Performance Testing with QATzip part and directly add the following
> content. 
> 
> Here, we use a typical example of limited bandwidth to illustrate the advantages
> of QATzip. If the user is interested in qatzip, he still needs to verify the performance
> by himself.
> 
> +The following test was conducted using 8 multifd channels and 10Gbps network
> +bandwidth. The results show that, compared to zstd, ``QATzip`` significantly
> +saves CPU resources on the sender and reduces migration time. Compared to the
> +uncompressed solution, ``QATzip`` greatly improves the dirty page processing
> +capability, indicated by the Pages per Second metric, and also reduces the
> +total migration time.
> +
> +::
> +
> +   VM Configuration: 16 vCPU and 64G memory
> +   VM Workload: all vCPUs are idle and 54G memory is filled with Silesia data.
> +   QAT Devices: 4
> +   |-----------|--------|---------|----------|----------|------|------|
> +   |8 Channels |Total   |down     |throughput|pages per | send | recv |
> +   |           |time(ms)|time(ms) |(mbps)    |second    | cpu %| cpu% |
> +   |-----------|--------|---------|----------|----------|------|------|
> +   |qatzip     |   16630|       28|     10467|   2940235|   160|   360|
> +   |-----------|--------|---------|----------|----------|------|------|
> +   |zstd       |   20165|       24|      8579|   2391465|   810|   340|
> +   |-----------|--------|---------|----------|----------|------|------|
> +   |none       |   46063|       40|     10848|    330240|    45|    85|
> +   |-----------|--------|---------|----------|----------|------|------|

Yes this looks much simpler and better.  The 10GBps test isn't that useful
at least, especially with nocomp numbers absent.  I didn't say when looking
previously, but it'll be better to clarify the numbers.

Yuan, thanks so much for reviewing all the relevant patches.  It's very
helpful to us.

-- 
Peter Xu


