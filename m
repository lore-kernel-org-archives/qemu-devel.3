Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9746C3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 13:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQopu-0008Sj-Sh; Mon, 08 Jul 2024 09:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQopr-0008Rk-QV
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 09:55:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQopn-0001jS-C9
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 09:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720446914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gN92sDqkGK7Io4oEThtAQq6k4cj75NNnXWY/QdVzw68=;
 b=KC0kW8VjDS1xpNT8iLe93I98cWi0D91Ai6QAU+iqBmsEsa1up5dUMbGC5LG7yoD4raRPdz
 I4ZsJv+o1gJixRG0NWY103UH7Vljr3RpRDrKPg5ZgFboIulXb6HO1gHjyMrN2qSp8weqfD
 MxalWLMNgzkRNfw0XW4aqNWLSKXfOUU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-gfokfuYGNw24as0CqL_SYQ-1; Mon, 08 Jul 2024 09:55:11 -0400
X-MC-Unique: gfokfuYGNw24as0CqL_SYQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4266b03fe2bso6677345e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 06:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720446910; x=1721051710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gN92sDqkGK7Io4oEThtAQq6k4cj75NNnXWY/QdVzw68=;
 b=HNEFvYsrrytRFb7FUbd0MfiC9owXG4GiUN8iUuxytXPbna1hEPDvTLkRPneQPxyhA/
 N8U6CKFJ0EVUqXM+wYeDaegofikA9hj1qSCYrCBPamMoNiDrKYdENr11UEzTYZ8KbL+6
 VEsUfg4qTHgTI8bUzwfV37aF0NCN2/Uy/2N0tsWiPHFPSZvbpr4JvLv9YuNKliFOTCMM
 egTiTHxlYYVDQt66yEAnduSvJS2NDIYbOMWFY0ODksutOYWuT/2o8cGBhep2BmmwOn/V
 e4SMBBPnuQ5VD0HaLUbyMQQVTj0LGsTI+DtiW4Wl/msj5rGnSHPqiki93HywXX97ku5O
 8xOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZShgFmF2SuuTA9y4+PujYDvvLaV1gvHBhMoZhxqI1u71xzChoUB9Fj3JQ2jnsO8VPdhB5CE9KHoUNaSgQp/PmJJePue4=
X-Gm-Message-State: AOJu0YxxH3im3pinG4972FSiofrH8mJizjPUm3nthOEyiBdDdVM6bb51
 4cqy/Q8SgOZtJ8QiLmnUh9I0Fb03R3FtgsWIWoy2MgbC2LaxsPyO+5YjqP8Eu9Al2lG1q4BEw9s
 dTnwxX+Q7M4qEEhmGEYZiIJS7PbyJSpboQ4SAQ95PIHFkxCzNtceO
X-Received: by 2002:a05:600c:4988:b0:426:647b:1bfc with SMTP id
 5b1f17b1804b1-426647b1c61mr28272985e9.30.1720446910628; 
 Mon, 08 Jul 2024 06:55:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMh14bKUeFF26sB4ZbUu6Cx6wm2Jh/5fZwB0o+kWtN8WmS2GrJHrJDe0YkDn987L6vs40FoA==
X-Received: by 2002:a05:600c:4988:b0:426:647b:1bfc with SMTP id
 5b1f17b1804b1-426647b1c61mr28272815e9.30.1720446910237; 
 Mon, 08 Jul 2024 06:55:10 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd6b4sm27786669f8f.17.2024.07.08.06.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 06:55:09 -0700 (PDT)
Date: Mon, 8 Jul 2024 15:55:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@opnsrc.net>
Cc: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
 eric.auger@redhat.com, oliver.upton@linux.dev, pbonzini@redhat.com,
 mst@redhat.com, will@kernel.org, gshan@redhat.com, rafael@kernel.org,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, npiggin@gmail.com, harshpb@linux.ibm.com,
 linuxarm@huawei.com, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH V13 8/8] docs/specs/acpi_hw_reduced_hotplug: Add the CPU
 Hotplug Event Bit
Message-ID: <20240708155507.52418191@imammedo.users.ipa.redhat.com>
In-Reply-To: <db8c2a7c-cc40-4fed-98fc-171f70e239ea@opnsrc.net>
References: <20240607115649.214622-1-salil.mehta@huawei.com>
 <20240607115649.214622-9-salil.mehta@huawei.com>
 <20240706164519.06c53d77@imammedo.users.ipa.redhat.com>
 <db8c2a7c-cc40-4fed-98fc-171f70e239ea@opnsrc.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Mon, 8 Jul 2024 05:32:28 +0000
Salil Mehta <salil.mehta@opnsrc.net> wrote:

> On 06/07/2024 14:45, Igor Mammedov wrote:
> > On Fri, 7 Jun 2024 12:56:49 +0100
> > Salil Mehta <salil.mehta@huawei.com> wrote:
> >  
> >> GED interface is used by many hotplug events like memory hotplug, NVDIMM hotplug
> >> and non-hotplug events like system power down event. Each of these can be
> >> selected using a bit in the 32 bit GED IO interface. A bit has been reserved for
> >> the CPU hotplug event.
> >>
> >> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> >> Reviewed-by: Gavin Shan <gshan@redhat.com>
> >> Tested-by: Zhao Liu <zhao1.liu@intel.com>  
> > suggest to squash this into the patch that introduces this bit [3/8]  
> 
> I thought, we are introducing a change common to all architectures?

hw reduced hotplug implies GED, so including doc change
into the patch that introduces bit in the code is better
option.

it also easier on the folks that come later and find doc
and code in the same commit (which is easier to follow
than looking for different commits in git log).

> > Best, Salil.
> 
> >> ---
> >>   docs/specs/acpi_hw_reduced_hotplug.rst | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/docs/specs/acpi_hw_reduced_hotplug.rst b/docs/specs/acpi_hw_reduced_hotplug.rst
> >> index 0bd3f9399f..3acd6fcd8b 100644
> >> --- a/docs/specs/acpi_hw_reduced_hotplug.rst
> >> +++ b/docs/specs/acpi_hw_reduced_hotplug.rst
> >> @@ -64,7 +64,8 @@ GED IO interface (4 byte access)
> >>          0: Memory hotplug event
> >>          1: System power down event
> >>          2: NVDIMM hotplug event
> >> -    3-31: Reserved
> >> +       3: CPU hotplug event
> >> +    4-31: Reserved
> >>   
> >>   **write_access:**
> >>     
> > :
> >  
> 


