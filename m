Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CC7C25B74
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2024 13:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDlIB-0000Jd-Cv; Sun, 02 Jun 2024 09:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDlIA-0000JF-G3
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 09:30:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDlI9-0005YK-3l
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 09:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717335032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tsd4/w/Wo65gB47IGDW5cjL/CynRH+o6n6pO9H3Yhas=;
 b=SO3BnA+rAIUpkyM0rS+h5b1TIEhAUX31/db0mIMszph4v+aU415ndixwQqsL0FtbaKd/hm
 kvF4NCLZFH5UQaDHQATneNrzr73x2Ytelx4Z8/kek5OBMbC06o7rBAKtiVBwfoNTK96kUM
 vaWMl44HOUd70mZbp/1OGO2vK2biagE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-OYH-ks92PlCDssckMJw2Rg-1; Sun, 02 Jun 2024 09:30:30 -0400
X-MC-Unique: OYH-ks92PlCDssckMJw2Rg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42117a61bccso25877905e9.0
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 06:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717335029; x=1717939829;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tsd4/w/Wo65gB47IGDW5cjL/CynRH+o6n6pO9H3Yhas=;
 b=qsWs2DiIIXHo4vOjStovEWGo8DGhnisQ9C2DLR0H29/V6hoFlDv/yz0bPeaZiER8Mb
 3Wqs6hWG3sMABOancmnM3JiRYHqNzeXl13N7DYLdinABnzJ/urGfTfc5BiFAXKBT/nGn
 8AEf1DhA9i8ClFBzjzvU2Ov7yBleLRcr+QhWRK29olV8aWHlaVSv+jotKwhg59Dpz3Pa
 66KwUfZDIppJJqG/g+1D0ysia30a922UhiB6N4qxLKOBCSzCB3OoNTVZvaoJ6Jy/bm36
 6Ww54I1zs08qsoDwfZjhcx+yokCjiO3+7D7UaYtjNAGXoj1Yn09w4QPZqiSsQBC6SjOl
 crWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGRYH0FLkr090dB3PZXPxNqxAQ1TXTSnTPUr180lQNECOf4oTUqdsZW5NmlDsiW63rhA7hYwGPePtpbYjLiodc0qjTBOA=
X-Gm-Message-State: AOJu0Ywy/8IaLm1q5YzGuJmRu++Dyy2EdwJ2IFI8P3R2Y5eHTBk5zb78
 EuPegobw8Csog7qQPIryq+Zh29J7U9ygmEy9sOIIVPofsxUaodfStBlNM7Mh4nxKCI6ksnxLPx0
 qVSd5Ihi09vMgNPRYprOnPxr7an3N5drj0RRP4UiNEPSyY/XKUTF7
X-Received: by 2002:a05:600c:3106:b0:41a:ff7d:2473 with SMTP id
 5b1f17b1804b1-4212e0469d9mr60266885e9.4.1717335029420; 
 Sun, 02 Jun 2024 06:30:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk/hTSeeoYnBt1Vv4lS6p3hAJLelFlAdd+86zhxTaWcMx4An9qCjkpjOz0xjVYZ1xoF7MIhg==
X-Received: by 2002:a05:600c:3106:b0:41a:ff7d:2473 with SMTP id
 5b1f17b1804b1-4212e0469d9mr60266695e9.4.1717335028901; 
 Sun, 02 Jun 2024 06:30:28 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:950b:d4e:f17a:17d8:5699])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212f0f9660sm73230025e9.39.2024.06.02.06.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jun 2024 06:30:28 -0700 (PDT)
Date: Sun, 2 Jun 2024 09:30:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH-for-9.0?] docs: i386: pc: Update maximum CPU numbers for
 PC Q35
Message-ID: <20240602092857-mutt-send-email-mst@kernel.org>
References: <20240412085358.731560-1-zhao1.liu@linux.intel.com>
 <305d659b-d4d6-4681-bdad-cd869e552333@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <305d659b-d4d6-4681-bdad-cd869e552333@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Apr 12, 2024 at 11:57:35AM +0200, Philippe Mathieu-Daudé wrote:
> Hi Zhao,
> 
> On 12/4/24 10:53, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > Commit e4e98c7eebfa ("pc: q35: Bump max_cpus to 4096 vcpus") increases
> > the supported CPUs for PC Q35 machine.
> > 
> > Update maximum CPU numbers for PC Q35 in the document.
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >   docs/system/target-i386-desc.rst.inc | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/docs/system/target-i386-desc.rst.inc b/docs/system/target-i386-desc.rst.inc
> > index 5ebbcda9db4c..319e540573d3 100644
> > --- a/docs/system/target-i386-desc.rst.inc
> > +++ b/docs/system/target-i386-desc.rst.inc
> > @@ -36,7 +36,7 @@ The QEMU PC System emulator simulates the following peripherals:
> >   -  PCI UHCI, OHCI, EHCI or XHCI USB controller and a virtual USB-1.1
> >      hub.
> > -SMP is supported with up to 255 CPUs.
> > +SMP is supported with up to 255 CPUs (and 4096 CPUs for PC Q35 machine).
> 
> This comment is not accurate since a while, IIUC:
> 
> Up to q35-2.7: 255
> q35-2.8: 288
> q35-8.0+: 1024
> q35-9.0: 4096


What are you saying here, Philippe? I don't think compat
machine types matter enough to bother with more detail.

> >   QEMU uses the PC BIOS from the Seabios project and the Plex86/Bochs LGPL
> >   VGA BIOS.


