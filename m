Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D8CC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLk70-0005CM-AQ; Mon, 24 Jun 2024 09:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sLk6y-0005Bq-NS
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:52:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sLk6x-0005b7-DY
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719237117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N/EVfZvBR+l9w9B5iYww32KGkGwB6S0lG5l7VQvMcTY=;
 b=WH/2WYC2Im+L28uKMmD04USZOMzgiGvi86y7EsYSnXyF8fVFM/1A5ng6o7FItbIuIFMjjI
 AgxE8TvyYZUYDiF/J4Ewdh47sRF1pySUoSjzroW9g14Dbh2ggslUPfcMTc++T9aRnfjtkM
 2AkBooDB8FbmhvDkwjQu85s+P4f8QJY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-NEHpcfMzNSGQDSmPyJSBGw-1; Mon, 24 Jun 2024 09:51:55 -0400
X-MC-Unique: NEHpcfMzNSGQDSmPyJSBGw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4246e5fd996so24442895e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719237114; x=1719841914;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N/EVfZvBR+l9w9B5iYww32KGkGwB6S0lG5l7VQvMcTY=;
 b=JSQQeWexwglMDZ59WUdK+Mqjzq82irHb/AH8rVItnmnjJwbLaq5E4gM9KyALAwey8n
 /2igr6No2ksjUIasXTi7wCJn0rh3E5Lsb6wKxlIT9hpGFOUPfCdMHJtX5I6gQTQb8ZNC
 i3Wy7b3yam0O3gbl6lyDg9T+4HArsEAjZTdPxn89w1ydoDudctSWhvFDOiGBqxOH6/GF
 A6poVErN2LpuiqXMJX71SF8dovpN5wVT9/qgpahoQJDlQxQaaruuRNm3pRFo7O+bDcjG
 oco9fHhV1LJt79gmDI2cgxEOYcVoOCaKyFkirj+FRj3jnCKbfVr9ovI9z2YCpHpumJlE
 Q/Nw==
X-Gm-Message-State: AOJu0YzX5e9tmsVNpuaPVQq6LKnlUfP8iC9GVjK/BRieMm97sumFzXZp
 PTmk6RUGZZYp/xq1H4saiKD5LWPxZXqgwBSFr6WuXdhw3+sqkM1wAcJvTBdE7H5nSicgw4GJnym
 t5JPezLo0GDQ8YO+7ooysHxd5L/4duRMjAG/W9M+o4+mTCGf7F7k7
X-Received: by 2002:a05:600c:4f94:b0:424:90fa:6758 with SMTP id
 5b1f17b1804b1-42490fa6992mr23704915e9.5.1719237114618; 
 Mon, 24 Jun 2024 06:51:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCjs8EecFrWDytXiluHrmJftQKxesX6ZDq1Rjd/VlnW/8dEFAf7waiyQpMLW1ncA96gs50/Q==
X-Received: by 2002:a05:600c:4f94:b0:424:90fa:6758 with SMTP id
 5b1f17b1804b1-42490fa6992mr23704685e9.5.1719237113953; 
 Mon, 24 Jun 2024 06:51:53 -0700 (PDT)
Received: from redhat.com ([2.52.146.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42481921f16sm134442695e9.41.2024.06.24.06.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 06:51:53 -0700 (PDT)
Date: Mon, 24 Jun 2024 09:51:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Gao,Shiyuan" <gaoshiyuan@baidu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Subject: Re: [PATCH 1/1] hw/i386/acpi-build: add OSHP method support for SHPC
 driver load
Message-ID: <20240624094556-mutt-send-email-mst@kernel.org>
References: <20240624131426.77231-1-gaoshiyuan@baidu.com>
 <20240624091745-mutt-send-email-mst@kernel.org>
 <a15cb952e03845b684f5211d75dfb4ff@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a15cb952e03845b684f5211d75dfb4ff@baidu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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

On Mon, Jun 24, 2024 at 01:34:08PM +0000, Gao,Shiyuan wrote:
> > > SHPC driver will be loaded fail in i440fx platform, the dmesg shows
> > > that OS cannot get control of SHPC hotplug and hotplug device to
> > > the PCI bridge will fail when we use SHPC Native type:
> > >
> > >   [3.336059] shpchp 0000:00:03.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PCI0.S28_)
> > >   [3.337408] shpchp 0000:00:03.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PCI0)
> > >   [3.338710] shpchp 0000:00:03.0: Cannot get control of SHPC hotplug
> > >
> > > Add OSHP method support for SHPC driver load, the hotplug device to the PCI bridge will
> > > success when we use SHPC Native type.
> > >
> > >   [1.703975] shpchp 0000:00:03.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PCI0.S18_)
> > >   [1.704934] shpchp 0000:00:03.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PCI0)
> > >   [1.705855] shpchp 0000:00:03.0: Gained control of SHPC hotplug (\_SB_.PCI0)
> > >   [1.707054] shpchp 0000:00:03.0: HPC vendor_id 1b36 device_id 1 ss_vid 0 ss_did 0
> > >
> > > According to the acpi_pcihp, the OSHP method don't need parameter and return value now.
> > >
> > >   shpc_probe
> > >     --> acpi_get_hp_hw_control_from_firmware
> > >       --> acpi_run_oshp
> > >         --> status = acpi_evaluate_object(handle, METHOD_NAME_OSHP, NULL, NULL);
> > >
> > > Signed-off-by: Shiyuan Gao <gaoshiyuan@baidu.com>
> > > ---
> > >  hw/i386/acpi-build.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > index f4e366f64f..79622e6939 100644
> > > --- a/hw/i386/acpi-build.c
> > > +++ b/hw/i386/acpi-build.c
> > > @@ -1412,6 +1412,18 @@ static void build_acpi0017(Aml *table)
> > >      aml_append(table, scope);
> > >  }
> > >
> > > +static Aml *build_oshp_method(void)
> > > +{
> > > +    Aml *method;
> > > +
> > > +    /*
> > > +     * Request control of SHPC hotplug via OSHP method,
> > > +     * no need parameter and return value in acpi_pcihp.
> > > +     */
> >
> > Quote spec and earliest version documenting this, please.
> 
> I cann't find document describe this, only find in the kernel code
> and describe it in the commit message.

Hrrm you really should read the spec not just go by the fact things
happen to work.  Look up PCI Firmware Specification

-- 
MST


