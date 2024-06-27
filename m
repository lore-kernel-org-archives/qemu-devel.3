Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94726C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpWO-0008Am-0I; Thu, 27 Jun 2024 09:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sMpWM-0008AY-0Q
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:50:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sMpWK-0003KK-DY
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719496238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b/K53bCUebQ2JRHKsv54FB0P9fu+ROyN2LvLiXJJfBA=;
 b=C9G3CgB6XuLwRpbiiDxM6I4bi1fZgRyF+UN8a87o/Mshx2uJGXkEUTVTyquvU9fivkRYxz
 HENVPWRkkvRrcc4cc6wapJtjM6nBLAdHPZQJgPAJLJB5vwRQ2T/CxDj0zcHjDg9+WnMbX5
 EZobRztwXVHwZG7ZNzDvfKxJuard8tc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-__NOpNkzNLOeKwyg4IflzA-1; Thu, 27 Jun 2024 09:50:37 -0400
X-MC-Unique: __NOpNkzNLOeKwyg4IflzA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-421bb51d73cso42809665e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719496236; x=1720101036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b/K53bCUebQ2JRHKsv54FB0P9fu+ROyN2LvLiXJJfBA=;
 b=YBnfxyKSNH/E8J1uZxPu5NBtXVcTj5hJHXusPfDRCkRikg9ZkbtBmoO/8NoMOE0bEN
 eCWoSguSdZbSynvXUFy8XSQsgiR021SDfqPbafIWMgU822jypi4V1kC0bU1UpiZfziuj
 jlgSLPM3gvixVFdRniPNV9IWg6BRsNNOtbI6Dzi7J8HbHBlqgwyxuc3jEuypXS1c0I/m
 2VFmk5pi0KongudNfcLiJ6gC5cUxFi/yfRt7zgS+PbleY90ZWsIcWtcvVEDmmUAJGdWA
 nO8dJn11yzbwQhW/aReywhFieDZ2cOnCH79/9skwRT+s6RPOCuSRsQkN7a+GOkUJ9aZU
 Lxaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIMw0ma7fCTzsWROGJ0lmnH71Hf17YTIGWiMZZX7yBUq5m70kgRQuMfquM4m79bLooV+MIvSnFykccDE8ZpsVmdEMu6Z4=
X-Gm-Message-State: AOJu0Ywwy9nokHkD4Uw50yjNdeq9XOB1VwDEdy9Tk50K6wov6AGdKiiP
 xqyMdcs12QHftcuoFB/z2iI+HH1k7fUITCJxFZK+mUoZXLLdjz5rm1ZhHABZvmNJ9sbvRUUIDws
 tXCp02uL2YjNgs/euhu3N9afxoxb9VYmWqkgE7BzbAaAhf+w7H+eW
X-Received: by 2002:a05:600c:470d:b0:422:7eca:db41 with SMTP id
 5b1f17b1804b1-4248cc18101mr107719235e9.2.1719496235865; 
 Thu, 27 Jun 2024 06:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMcKamJRiI3rpkVJDHck0MM+yXJbTQoD3q0JAT8y7cmLvTvn8ku0c+ocm1SzOuFhCeW7TDWQ==
X-Received: by 2002:a05:600c:470d:b0:422:7eca:db41 with SMTP id
 5b1f17b1804b1-4248cc18101mr107719145e9.2.1719496235542; 
 Thu, 27 Jun 2024 06:50:35 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c82519b0sm68404015e9.14.2024.06.27.06.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 06:50:35 -0700 (PDT)
Date: Thu, 27 Jun 2024 15:50:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 09/11] bios-tables-test: Allow for new
 acpihmat-generic-x test data.
Message-ID: <20240627155034.69a8b9e4@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240627145155.2c3d3709@imammedo.users.ipa.redhat.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
 <20240620160324.109058-10-Jonathan.Cameron@huawei.com>
 <20240627145155.2c3d3709@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
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

On Thu, 27 Jun 2024 14:51:55 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 20 Jun 2024 17:03:17 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > The test to be added exercises many corners of the SRAT and HMAT table  
>                                       ^^^^ did you mean 'corner cases"?
> > generation.

another issue is that this and later patches will conflict with
risc-v acpi tests, that along the way change directory structure
of expected tables.

Perhaps, it's better to rebase this series on top of that. 


> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > v3: No change
> > ---
> >  tests/qtest/bios-tables-test-allowed-diff.h | 5 +++++
> >  tests/data/acpi/q35/APIC.acpihmat-generic-x | 0
> >  tests/data/acpi/q35/CEDT.acpihmat-generic-x | 0
> >  tests/data/acpi/q35/DSDT.acpihmat-generic-x | 0
> >  tests/data/acpi/q35/HMAT.acpihmat-generic-x | 0
> >  tests/data/acpi/q35/SRAT.acpihmat-generic-x | 0
> >  6 files changed, 5 insertions(+)
> > 
> > diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> > index dfb8523c8b..a5aa801c99 100644
> > --- a/tests/qtest/bios-tables-test-allowed-diff.h
> > +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> > @@ -1 +1,6 @@
> >  /* List of comma-separated changed AML files to ignore */
> > +"tests/data/acpi/q35/APIC.acpihmat-generic-x",
> > +"tests/data/acpi/q35/CEDT.acpihmat-generic-x",
> > +"tests/data/acpi/q35/DSDT.acpihmat-generic-x",
> > +"tests/data/acpi/q35/HMAT.acpihmat-generic-x",
> > +"tests/data/acpi/q35/SRAT.acpihmat-generic-x",
> > diff --git a/tests/data/acpi/q35/APIC.acpihmat-generic-x b/tests/data/acpi/q35/APIC.acpihmat-generic-x
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/data/acpi/q35/CEDT.acpihmat-generic-x b/tests/data/acpi/q35/CEDT.acpihmat-generic-x
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/data/acpi/q35/DSDT.acpihmat-generic-x b/tests/data/acpi/q35/DSDT.acpihmat-generic-x
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/data/acpi/q35/HMAT.acpihmat-generic-x b/tests/data/acpi/q35/HMAT.acpihmat-generic-x
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/data/acpi/q35/SRAT.acpihmat-generic-x b/tests/data/acpi/q35/SRAT.acpihmat-generic-x
> > new file mode 100644
> > index 0000000000..e69de29bb2  
> 


