Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0621C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 15:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjzn-0002eN-2L; Tue, 16 Jul 2024 11:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTjzl-0002dl-EX
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 11:21:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTjzf-00084W-RN
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 11:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721143290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AqTxCVQA1Nc87dI2wAb3bdg/By49iAQspFoo/847FrI=;
 b=Ed6QRCgYpqHsKUg1GB1hOjyQW235Wm+CLnlSkrbJWpIxhc9aRz3Mfg17oefC7Uhd2f2fq1
 bS+XqkdySJVwITRvFdq8X6kmdCV2hM19mBJnNUjFULDXgbdSAvfKhfftL6X2D7sma46t/c
 pvZP1zJOPEMmkFHgTHJQ6XWI0H6W0FY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-NiYZKnm1NkCbTduLBvS18g-1; Tue, 16 Jul 2024 11:21:28 -0400
X-MC-Unique: NiYZKnm1NkCbTduLBvS18g-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36789dfcc8bso3428329f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 08:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721143287; x=1721748087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AqTxCVQA1Nc87dI2wAb3bdg/By49iAQspFoo/847FrI=;
 b=TcLackEg1Y+lwAma0r3/YDaTZbYNi/fjIiKq/z1MCIzU+DH0J96rf0BiTdeBwY8uf8
 bzKuwSGjF/aFfpPL3uQ9zBbeixuUvEQxDeTsF09nUbysESNDFCcsWA3diN3e+gx/q+/O
 5REM53yxMvvj1NBDPyCuHhIhsIsf7qc7x9/uJfxALQHv1zn/WiNvm7rl6TenpBJc3a4Y
 eOLDGliUiPv2Bym0jG4tsTRl35ovLuF8NWDTjUNlN0uPO43WSIWFAgmXnuAHSWaSZdoy
 Hdv/gV7MtGCOpkloZJ7kXmQ08vQnuP5mmN8PowxRLMeCjdYLV78mPaxeN8NVvKwtYY7F
 grLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjIuE7EC1NURdagz9giOVEZsJZVyDy5WfbDNfIKaXDBslurpWjV2aOOlb4GL4qAslJIiOtipAhfGBA8tliUpzEK1s98OY=
X-Gm-Message-State: AOJu0Yy/FNFnvGA4YgM/kDFgeRSQJY0O8vVHpnL/ch1TPsC+fppLesq/
 0Zmrp274eauAszz13Z+NHF3mycdVkmUzaa580Py5onaJt/zLOl+swx52EfJ2wLDhXkR4ZaSOyxG
 v2ny/W4USAHhWa5qjyDFoLeGfNjJEiOTw4e8O8NeJ8Nq2dJjnYH9l
X-Received: by 2002:adf:e6c8:0:b0:367:973e:c20a with SMTP id
 ffacd0b85a97d-36826089105mr1598587f8f.18.1721143287315; 
 Tue, 16 Jul 2024 08:21:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6CG1LC6NdrxZ0OWPay8Q/qIMpnzyUHy4tKIi9eBpSzU2rpIhjxfwXjSyAdB6yz+sA4wijWg==
X-Received: by 2002:adf:e6c8:0:b0:367:973e:c20a with SMTP id
 ffacd0b85a97d-36826089105mr1598554f8f.18.1721143286933; 
 Tue, 16 Jul 2024 08:21:26 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680daccc9csm9331403f8f.57.2024.07.16.08.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 08:21:26 -0700 (PDT)
Date: Tue, 16 Jul 2024 17:21:25 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: Salil Mehta <salil.mehta@opnsrc.net>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "andrew.jones@linux.dev"
 <andrew.jones@linux.dev>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "will@kernel.org" <will@kernel.org>, "gshan@redhat.com"
 <gshan@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>, "karl.heubaum@oracle.com"
 <karl.heubaum@oracle.com>, "miguel.luis@oracle.com"
 <miguel.luis@oracle.com>, zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng
 (C)" <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "npiggin@gmail.com" <npiggin@gmail.com>, "harshpb@linux.ibm.com"
 <harshpb@linux.ibm.com>, Linuxarm <linuxarm@huawei.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH V15 0/7] Add architecture agnostic code to support vCPU
 Hotplug
Message-ID: <20240716172125.0b1fd791@imammedo.users.ipa.redhat.com>
In-Reply-To: <b8ec039d53534d48b8389aedd1f959f6@huawei.com>
References: <20240713182516.1457-1-salil.mehta@huawei.com>
 <20240715155436.577d34c5@imammedo.users.ipa.redhat.com>
 <b93b570158794e28bf8c00a949afa8b4@huawei.com>
 <3848723ea2584b9b813c3d76e1e6dd59@huawei.com>
 <20240715171154.2667d187@imammedo.users.ipa.redhat.com>
 <4b829bf1-d31c-49eb-b18f-6d87e08c5c04@opnsrc.net>
 <20240716115210.08ca24ba@imammedo.users.ipa.redhat.com>
 <b8ec039d53534d48b8389aedd1f959f6@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Tue, 16 Jul 2024 11:43:00 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:

> Hi Igor,
> 
> >  From: Igor Mammedov <imammedo@redhat.com>
> >  Sent: Tuesday, July 16, 2024 10:52 AM
> >  To: Salil Mehta <salil.mehta@opnsrc.net>
> >  
> >  On Tue, 16 Jul 2024 03:38:29 +0000
> >  Salil Mehta <salil.mehta@opnsrc.net> wrote:
> >    
> >  > Hi Igor,
> >  >
> >  > On 15/07/2024 15:11, Igor Mammedov wrote:  
> >  > > On Mon, 15 Jul 2024 14:19:12 +0000
> >  > > Salil Mehta <salil.mehta@huawei.com> wrote:
> >  > >  
> >  > >>>   From: qemu-arm-bounces+salil.mehta=huawei.com@nongnu.org  <qemu-
> >  > >>>   arm-bounces+salil.mehta=huawei.com@nongnu.org> On Behalf Of  Salil
> >  > >>>   Mehta via
> >  > >>>   Sent: Monday, July 15, 2024 3:14 PM
> >  > >>>   To: Igor Mammedov <imammedo@redhat.com>
> >  > >>>
> >  > >>>   Hi Igor,
> >  > >>>  
> >  > >>>   >  From: Igor Mammedov <imammedo@redhat.com>
> >  > >>>   >  Sent: Monday, July 15, 2024 2:55 PM
> >  > >>>   >  To: Salil Mehta <salil.mehta@huawei.com>
> >  > >>>   >
> >  > >>>   >  On Sat, 13 Jul 2024 19:25:09 +0100
> >  > >>>   >  Salil Mehta <salil.mehta@huawei.com> wrote:
> >  > >>>   >  
> >  > >>>   >  > [Note: References are present at the last after the revision  
> >  > >>>   > history]  >  > Virtual CPU hotplug support is being added across
> >  > >>>   > various architectures  [1][3].  
> >  > >>>   >  > This series adds various code bits common across all architectures:
> >  > >>>   >  >
> >  > >>>   >  > 1. vCPU creation and Parking code refactor [Patch 1] 2. Update ACPI
> >  > >>>   > > GED framework to support vCPU Hotplug [Patch 2,3] 3. ACPI CPUs AML
> >  > >>>   > > code change [Patch 4,5] 4. Helper functions to support unrealization
> >  > >>>   > > of CPU objects [Patch 6,7]  
> >  > >>>   >
> >  > >>>   >  with patch 1 and 3 fixed should be good to go.
> >  > >>>   >
> >  > >>>   >  Salil,
> >  > >>>   >  Can you remind me what happened to migration part of this?
> >  > >>>   >  Ideally it should be a part of of this series as it should be common
> >  > >>>   > for  everything that uses GED and should be a conditional part of
> >  > >>>   > GED's  VMSTATE.
> >  > >>>   >
> >  > >>>   >  If this series is just a common base and no actual hotplug on top of
> >  > >>>   > it is  merged in this release (provided patch 13 is fixed), I'm fine
> >  > >>>   > with migration  bits being a separate series on top.
> >  > >>>   >
> >  > >>>   >  However if some machine would be introducing cpu hotplug in the same
> >  > >>>   > release, then the migration part should be merged before it or be a
> >  > >>>   > part  that cpu hotplug series.  
> >  > >>>
> >  > >>>   We have tested Live/Pseudo Migration and it seem to work with the
> >  > >>>   changes part of the architecture specific patch-set.  
> >  > >
> >  > > have you tested, migration from new QEMU to an older one (that doesn't have cpuhotplug builtin)?  
> >  >
> >  >
> >  > Just curious, how can we detect at source Qemu what version of the
> >  > Qemu destination is running. We require some sort of compatibility
> >  > check but then this is a problem not specific to CPU Hotplug?  
> >  
> >  it's usually managed by version machine types + compat settings for
> >  machine/device.  
> 
> Ok. it looks to be a static checking at the source. I'm sure there must be
> a way to dynamically do the same by negotiating the features i.e. only
> enabling the common subset at the destination. I quickly skimmed the
> migration code and I cannot find any thing like this being done as of now.
> And this problem looks to be a pandoras box to me. 
no dynamic negotiating as far as I'm aware.

We've managed to survive so far with static compat knobs
(with an occasional disaster along the way)

...
> 
> Thanks
> Salil.
> 


