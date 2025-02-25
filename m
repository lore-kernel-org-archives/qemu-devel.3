Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2F3C19F32
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 10:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmrkk-0002lG-5q; Tue, 25 Feb 2025 05:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tmrki-0002kc-Pm
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 05:01:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tmrkg-0007h9-RM
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 05:01:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740477681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/oob05Zz0uyD/XBE51wa6Mc8C+ILDhC8TNNOox+clSQ=;
 b=i66jAuZ9Bfw70LLklFG1seVbHZxWmjde87f19Pe49Fog+mcEKwMAHonmtfRVik5Wz8qDKc
 Ybd92SXobyJBFy/qKFMl4W5/exDr3omcXKLw/SECGGkDnSP0+v1HDdAHj+Fd7y310KRWi9
 hJx+/P38xO5PpNXdhZOrHWNxATqySKo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-24GKdPLZPNGCjdyEF8cxZA-1; Tue, 25 Feb 2025 05:01:18 -0500
X-MC-Unique: 24GKdPLZPNGCjdyEF8cxZA-1
X-Mimecast-MFC-AGG-ID: 24GKdPLZPNGCjdyEF8cxZA_1740477678
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43947979ce8so23293615e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 02:01:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740477677; x=1741082477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/oob05Zz0uyD/XBE51wa6Mc8C+ILDhC8TNNOox+clSQ=;
 b=OQKAVXBp8+88pUf6mmTUZUHonoW36wsFgKZBbncFe5KmvLTWh4F/NRdD+C+/6LXmFJ
 X9gHSOCdMQMnoLWcZX2VnQ86Wpxx2o/hVjaD2L3lugR3+a4d0Z94V8hwR7niHEAPATXa
 KN3vZFA97pJQQ2CXQ+WZSQu0st41HYlkJrwebM8Xvz7TejvaT4XG+S/IWYSiOpMVrtkZ
 xpIqHo1bgxTbR+wmjm+fcsM9O49Od7KZi2JQvozVVPc9lRqjdUyGytaRlPEHgmfEfgew
 rZYSKsLDJZRlYELSILju6nrX0E9lW1wUmaDgPgh4lbCAnMmf8cbSyn+6M8NRNmXVhvem
 vSsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV64OXrpp663aOX0WAVY/LU106RCtRYwp2bpJXZOPeGZrgByHZh8ont4uMxaXXcfNl21N8KHxZYc+p5@nongnu.org
X-Gm-Message-State: AOJu0Yziy8qlYQKnEw227mHE5N8lmJ01VKcT9FRMXwvHuPam6V9Wp2G7
 h7KTkOEICf7Hci9TeUGG4noYpJ5Tw2z0G0NyIdNUDL0syQbqlBpIDCNlIoYFuNk9FQR93z/Mn/9
 ZJobNqEosgC2/V/Jurq4HYViBMtbv8/TGYibp9dC1hTnaMl7cpfbf
X-Gm-Gg: ASbGncuOMuyOTof7rNt7TWcUC5cGwEBxvn/lfUodSXWOosq5kTBXadzN/nMaXJtmEvS
 R7IQSLd7I/rDjlOnq1OLbouIjI5v0qCWUtVcGCb9ImQMRewDEBiARFORNJxZ9PpqKX0/MgVzF7q
 +GGDLDP5ux5gEZD7o+17vam9EmtzCqFneb3RfqvpLhZZom+iyEkd2uQavxXtLtBuUMkqEJpwPtj
 bhYC7nnalttGIzbo2EmOMW71sePyFuYe73FlTaEXe8F+YeSIjaB4Udril1lFeaTY2ruwVVpbGjJ
 m7/tBwXVdkLtPCKjG0cyfr993+MNSfQbT8uItTO4N7vmwdbrCH784T8CPRkjYU8=
X-Received: by 2002:a05:600c:3582:b0:434:f131:1e64 with SMTP id
 5b1f17b1804b1-439ae1e960dmr126912595e9.9.1740477677420; 
 Tue, 25 Feb 2025 02:01:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFtCPwMwCWEkCujQAtGB/IAc3Rx6Ggr5o3VQ96qC0I11ol3KnmivdGHCMQQLoZ6t1X2yVwRA==
X-Received: by 2002:a05:600c:3582:b0:434:f131:1e64 with SMTP id
 5b1f17b1804b1-439ae1e960dmr126912025e9.9.1740477676935; 
 Tue, 25 Feb 2025 02:01:16 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab1546f77sm19802945e9.20.2025.02.25.02.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 02:01:16 -0800 (PST)
Date: Tue, 25 Feb 2025 11:01:15 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, Philippe =?UTF-8?B?TWF0?=
 =?UTF-8?B?aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Eric Blake
 <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, "Markus Armbruster" <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, "Paolo Bonzini" <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu
 <zhao1.liu@intel.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Gavin Shan <gshan@redhat.com>, Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH v3 00/14] Change ghes to use HEST-based offsets and add
 support for error inject
Message-ID: <20250225110115.6090e416@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250221102127.000059e6@huawei.com>
References: <cover.1738345063.git.mchehab+huawei@kernel.org>
 <20250203110934.000038d8@huawei.com>
 <20250203162236.7d5872ff@imammedo.users.ipa.redhat.com>
 <20250221073823.061a1039@foz.lan>
 <20250221102127.000059e6@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 21 Feb 2025 10:21:27 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Fri, 21 Feb 2025 07:38:23 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Em Mon, 3 Feb 2025 16:22:36 +0100
> > Igor Mammedov <imammedo@redhat.com> escreveu:
> >   
> > > On Mon, 3 Feb 2025 11:09:34 +0000
> > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > >     
> > > > On Fri, 31 Jan 2025 18:42:41 +0100
> > > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > > >       
> > > > > Now that the ghes preparation patches were merged, let's add support
> > > > > for error injection.
> > > > > 
> > > > > On this series, the first 6 patches chang to the math used to calculate offsets at HEST
> > > > > table and hardware_error firmware file, together with its migration code. Migration tested
> > > > > with both latest QEMU released kernel and upstream, on both directions.
> > > > > 
> > > > > The next patches add a new QAPI to allow injecting GHESv2 errors, and a script using such QAPI
> > > > >    to inject ARM Processor Error records.
> > > > > 
> > > > > If I'm counting well, this is the 19th submission of my error inject patches.        
> > > > 
> > > > Looks good to me. All remaining trivial things are in the category
> > > > of things to consider only if you are doing another spin.  The code
> > > > ends up how I'd like it at the end of the series anyway, just
> > > > a question of the precise path to that state!      
> > > 
> > > if you look at series as a whole it's more or less fine (I guess you
> > > and me got used to it)
> > > 
> > > however if you take it patch by patch (as if you've never seen it)
> > > ordering is messed up (the same would apply to everyone after a while
> > > when it's forgotten)
> > > 
> > > So I'd strongly suggest to restructure the series (especially 2-6/14).
> > > re sum up my comments wrt ordering:
> > > 
> > > 0  add testcase for HEST table with current HEST as expected blob
> > >    (currently missing), so that we can be sure that we haven't messed
> > >    existing tables during refactoring.    
> 
> To potentially save time I think Igor is asking that before you do anything
> at all you plug the existing test hole which is that we don't test HEST
> at all.   Even after this series I think we don't test HEST.  You add
> a stub hest and exclusion but then in patch 12 the HEST stub is deleted whereas
> it should be replaced with the example data for the test.

that's what I was saying.
HEST table should be in DSDT, but it's optional and one has to use
'ras=on' option to enable that, which we aren't doing ATM.
So whatever changes are happening we aren't seeing them in tests
nor will we see any regression for the same reason.

While white listing tables before change should happen and then updating them
is the right thing to do, it's not sufficient since none of tests
run with 'ras' enabled, hence code is not actually executed. 

> 
> That indeed doesn't address testing the error data storage which would be
> a different problem.

I'd skip hardware_errors/CPER testing from QEMU unit tests.
That's basically requires functioning 'APEI driver' to test that.

Maybe we can use Ani's framework to parse HEST and all the way
towards CPER record(s) traversal, but that's certainly out of
scope of this series.
It could be done on top, but I won't insist even on that
since Mauro's out of tree error injection testing will
cover that using actual guest (which I assume he would
like to run periodically).

> > 
> > Not sure if I got this one. The HEST table is part of etc/acpi/tables,
> > which is already tested, as you pointed at the previous reviews. Doing
> > changes there is already detected. That's basically why we added patches
> > 10 and 12:
> > 
> > 	[PATCH v3 10/14] tests/acpi: virt: allow acpi table changes for a new table: HEST
> > 	[PATCH v3 12/14] tests/acpi: virt: add a HEST table to aarch64 virt and update DSDT
> > 
> > What tests don't have is a check for etc/hardware_errors firmware inside 
> > tests/data/acpi/aarch64/virt/, but, IMO, we shouldn't add it there.
> > 
> > See, hardware_errors table contains only some skeleton space to
> > store:
> > 
> > 	- 1 or more error block address offsets;
> > 	- 1 or more read ack register;
> > 	- 1 or more HEST source entries containing CPER blocks.
> > 
> > There's nothing there to be actually checked: it is just some
> > empty spaces with a variable number of fields.
> > 
> > With the new code, the actual number of CPER blocks and their
> > corresponding offsets and read ack registers can be different on 
> > different architectures. So, for instance, when we add x86 support,
> > we'll likely start with just one error source entry, while arm will
> > have two after this changeset.
> > 
> > Also, one possibility to address the issues reported by Gavin Shan at
> > https://lore.kernel.org/qemu-devel/20250214041635.608012-1-gshan@redhat.com/
> > would be to have one entry per each CPU. So, the size of such firmware
> > could be dependent on the number of CPUs.
> > 
> > So, adding any validation to it would just cause pain and probably
> > won't detect any problems.  
> 
> If we did do this the test would use a fixed number of CPUs so
> would just verify we didn't break a small number of variants. Useful
> but to me a follow up to this series not something that needs to
> be part of it - particularly as Gavin's work may well change that!
> 
> > 
> > What could be done instead is to have a different type of tests that
> > would use the error injection script to check if regressions are 
> > introduced after QEMU 10.0. Such new kind of test would require
> > this series to be merged first. It would also require the usage of
> > an OSPM image with some testing tools on it. This is easier said 
> > than done, as besides the complexity of having an OSPM test image,
> > such kind of tests would require extra logic, specially if it would
> > check regressions for SEA and other notification sources.
> >   
> Agreed that a more end to end test is even better, but those are
> quite a bit more complex so definitely a follow up.
> 
> J
> > Thanks,
> > Mauro
> >   
> 


