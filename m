Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F6AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 15:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTNMz-0005kR-1s; Mon, 15 Jul 2024 11:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTNMx-0005iZ-6X
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 11:12:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTNMv-0007pI-9V
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 11:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721056319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/2/rY9UmcpoRGE5z/3fRcE6/eWoQROqBiGf/TvwXkzw=;
 b=ORum4AxNeWwNk/bWcvYWBmGAaSsi732oRQj32JZQY/y8w8vEQh7dk0wLuKuuDEuuir3w6C
 U1V3zg3sIN/72PHAAaOtG9WrdVQ6D9Fwr6JC3Vucmw6zJ2rBqNgQLAGmjvg3PGpDNK0cES
 OC93NJo/sjH/ABNah206EWgK8pnAOFU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-zwHdJO5ZNbOLRD8BMtoVNw-1; Mon, 15 Jul 2024 11:11:58 -0400
X-MC-Unique: zwHdJO5ZNbOLRD8BMtoVNw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4265464ddc9so25837005e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 08:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721056317; x=1721661117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/2/rY9UmcpoRGE5z/3fRcE6/eWoQROqBiGf/TvwXkzw=;
 b=KMQlED8EM2J+kBMIuREYUl0nN/N835Tsy7YaT6B8we79iBPcfHOgHUKji3zcs5e+4m
 xqIEV2XvoeoqauSNDh+tikPcNSSbDcj6GnjIK8LGY/RmoAbSvkD+CI3bKbxET+BJ4Vjb
 7WwNWkrk1ASBE0iZrUnTaQB3+Prdcsh5kkiJXuJbyRTuk0/eIFtZsmiW19LdIJMWdfJV
 oXlRFVpZlnrx0w6QGUwx3pmOwQ3TpoNEmL6RhYdSVx08JDciVD9hE64NLc2gnqJsEVqE
 U/vNutsC1DBQsBWF/1GRteBI4wGaZ/U9vTjtsnFNl/8s6+POdal9Y56Vy6UAdhpoykdd
 pXZA==
X-Gm-Message-State: AOJu0YxyXdjOg3CIL8mDtNDT5WL5ZP13oOJbhyAMaZbKnlGC7H82Le68
 QYJil/VLEgm6TvKT4IWUKaBH1wGEad4HBabKBCKnTylc1s8uH/gBc0mfSR8VIA6uQOjuNfujXfz
 0zyc/GlltPxLFEn+yRkNRVz9x+LtGX7+5D3Ig3DultixV2oZ419w5
X-Received: by 2002:a05:600c:1592:b0:426:6f26:d7f4 with SMTP id
 5b1f17b1804b1-4279da43452mr94155895e9.18.1721056317073; 
 Mon, 15 Jul 2024 08:11:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYmleSfmLaGcCxRXWI91bK8MQqwTAF2qAZra1bqimSxijETVY/kLeVoyAVaS1D3Xgl3AwmIw==
X-Received: by 2002:a05:600c:1592:b0:426:6f26:d7f4 with SMTP id
 5b1f17b1804b1-4279da43452mr94155565e9.18.1721056316674; 
 Mon, 15 Jul 2024 08:11:56 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f25942csm124617775e9.15.2024.07.15.08.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 08:11:56 -0700 (PDT)
Date: Mon, 15 Jul 2024 17:11:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "maz@kernel.org"
 <maz@kernel.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
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
 <miguel.luis@oracle.com>, "salil.mehta@opnsrc.net"
 <salil.mehta@opnsrc.net>, zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng
 (C)" <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "npiggin@gmail.com" <npiggin@gmail.com>, "harshpb@linux.ibm.com"
 <harshpb@linux.ibm.com>, Linuxarm <linuxarm@huawei.com>, peterx@redhat.com
Subject: Re: [PATCH V15 0/7] Add architecture agnostic code to support vCPU
 Hotplug
Message-ID: <20240715171154.2667d187@imammedo.users.ipa.redhat.com>
In-Reply-To: <3848723ea2584b9b813c3d76e1e6dd59@huawei.com>
References: <20240713182516.1457-1-salil.mehta@huawei.com>
 <20240715155436.577d34c5@imammedo.users.ipa.redhat.com>
 <b93b570158794e28bf8c00a949afa8b4@huawei.com>
 <3848723ea2584b9b813c3d76e1e6dd59@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, 15 Jul 2024 14:19:12 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:

> >  From: qemu-arm-bounces+salil.mehta=huawei.com@nongnu.org <qemu-
> >  arm-bounces+salil.mehta=huawei.com@nongnu.org> On Behalf Of Salil
> >  Mehta via
> >  Sent: Monday, July 15, 2024 3:14 PM
> >  To: Igor Mammedov <imammedo@redhat.com>
> >  
> >  Hi Igor,
> >    
> >  >  From: Igor Mammedov <imammedo@redhat.com>
> >  >  Sent: Monday, July 15, 2024 2:55 PM
> >  >  To: Salil Mehta <salil.mehta@huawei.com>
> >  >
> >  >  On Sat, 13 Jul 2024 19:25:09 +0100
> >  >  Salil Mehta <salil.mehta@huawei.com> wrote:
> >  >  
> >  >  > [Note: References are present at the last after the revision  
> >  > history]  >  > Virtual CPU hotplug support is being added across
> >  > various architectures  [1][3].  
> >  >  > This series adds various code bits common across all architectures:
> >  >  >
> >  >  > 1. vCPU creation and Parking code refactor [Patch 1] 2. Update ACPI
> >  > > GED framework to support vCPU Hotplug [Patch 2,3] 3. ACPI CPUs AML
> >  > > code change [Patch 4,5] 4. Helper functions to support unrealization
> >  > > of CPU objects [Patch 6,7]  
> >  >
> >  >  with patch 1 and 3 fixed should be good to go.
> >  >
> >  >  Salil,
> >  >  Can you remind me what happened to migration part of this?
> >  >  Ideally it should be a part of of this series as it should be common
> >  > for  everything that uses GED and should be a conditional part of
> >  > GED's  VMSTATE.
> >  >
> >  >  If this series is just a common base and no actual hotplug on top of
> >  > it is  merged in this release (provided patch 13 is fixed), I'm fine
> >  > with migration  bits being a separate series on top.
> >  >
> >  >  However if some machine would be introducing cpu hotplug in the same
> >  > release, then the migration part should be merged before it or be a
> >  > part  that cpu hotplug series.  
> >  
> >  We have tested Live/Pseudo Migration and it seem to work with the
> >  changes part of the architecture specific patch-set.

have you tested, migration from new QEMU to an older one (that doesn't have cpuhotplug builtin)?

> >  
> >  Ampere: https://lore.kernel.org/all/e17e28ac-28c7-496f-b212-
> >  2c9b552dbf63@amperemail.onmicrosoft.com/
> >  Oracle: https://lore.kernel.org/all/46D74D30-EE54-4AD2-8F0E-
> >  BA5627FAA63E@oracle.com/
> >  
> >  
> >  For ARM, please check below patch part of RFC V3 for changes related to
> >  migration:
> >  https://lore.kernel.org/qemu-devel/20240613233639.202896-15-
> >  salil.mehta@huawei.com/  
> 
> 
> Do you wish to move below change into this path-set and make it common
> to all instead?

it would be the best to include this with here.

> 
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 63226b0040..e92ce07955 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -333,6 +333,16 @@ static const VMStateDescription vmstate_memhp_state = {
>      }
>  };
>  
> +static const VMStateDescription vmstate_cpuhp_state = {
> +    .name = "acpi-ged/cpuhp",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields      = (VMStateField[]) {
> +        VMSTATE_CPU_HOTPLUG(cpuhp_state, AcpiGedState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_ged_state = {
>      .name = "acpi-ged-state",
>      .version_id = 1,
> @@ -381,6 +391,7 @@ static const VMStateDescription vmstate_acpi_ged = {
>      },
>      .subsections = (const VMStateDescription * const []) {
>          &vmstate_memhp_state,
> +        &vmstate_cpuhp_state,

I'm not migration guru but I believe this should be conditional
to avoid breaking cross-version migration.
See 679dd1a957d '.needed = vmstate_test_use_cpuhp. part

CCing Peter

>          &vmstate_ghes_state,
>          NULL
>      }
> 
> Maybe I can add a separate patch for this in the end? Please confirm.
> 
> Thanks
> Salil.


