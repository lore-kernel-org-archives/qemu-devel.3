Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCA8C2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 15:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLlaz-0005lF-E7; Mon, 24 Jun 2024 11:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sLlax-0005kh-IU
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 11:27:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sLlaw-0008Uq-93
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 11:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719242815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TS/mmG020xJXsu7O4jsmpUCXWfR98gCyjrhSNU7IDkU=;
 b=dcdZUAvkvR7a6g+vWA1rZPhqB0DdGmiZ/ehAX6qm38xcKoOzQEcj9uhdfiZQyBpoHL64GQ
 2NJCkDr6KLxIRvEyoawKNYpKW9eGzYFAZ9CPob6FHcR7R80hxgYcCdlhcIxAxKzl2nXMG0
 WlB7tRguAGmtzEdTomUMFOuSvOnxK4w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-TjQpjUG3M76sMEQryKv1Kg-1; Mon, 24 Jun 2024 11:26:50 -0400
X-MC-Unique: TjQpjUG3M76sMEQryKv1Kg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-366fa770e34so218611f8f.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 08:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719242809; x=1719847609;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TS/mmG020xJXsu7O4jsmpUCXWfR98gCyjrhSNU7IDkU=;
 b=FYRx5QkWpFKJlOJRmtfrLLGhPdEjKN3H+yPtGChKtTlbpkgMMZEG2SE0OhjdGbFkXc
 eiFEmqdQkSafqjbHsCpoR/6G4qXFmCAd2fAhaXBS2k8jcMRA+KXLdmentvXPUmhEuryH
 w0XL1+IJftYp8qYtec4VpwwU6xDWFUtnRaqF2HlV42HWoR7OiqM22oNVapXzlnR7/5sN
 roG5npNqTJdeF+m4qOtsoGpdu9zUmIe9Te1uxMvzsx9nhGEfrFlgIdXexdOY2I7xeytx
 GDl+154AG0ksZI17+DMnMEQLZX9mYKV8Croq0GGOnp7va6KJF3OAYJbMbYtANLxnHGH/
 hqkQ==
X-Gm-Message-State: AOJu0YwvPF+WsUciow64y0ito8JVgqDXD+Oy51svuUpZXFD6itTeND/R
 xTIJ/JED8lMnyGu4Z/adwYLtLlncC4R0O4cqzbT0UCDqyuRJ32q10HopUjNMI1vXuqafoMJBGdf
 BzkwD4hI9jl6XFzup3h4a10dKRj5xpHKxegdTIN00x8VYKC35E/KC
X-Received: by 2002:adf:f342:0:b0:362:52b6:bc39 with SMTP id
 ffacd0b85a97d-366e948fc8bmr3020654f8f.16.1719242809358; 
 Mon, 24 Jun 2024 08:26:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/kZAoM9fzmgwbT0s7EukNWbM9AQdYOBfgN5aHEF06g+CX9Azk+chdXoclXTwOxJqohN3DOw==
X-Received: by 2002:adf:f342:0:b0:362:52b6:bc39 with SMTP id
 ffacd0b85a97d-366e948fc8bmr3020632f8f.16.1719242808624; 
 Mon, 24 Jun 2024 08:26:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:f72:b8c7:9fc2:4c8b:feb3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366389b8ab0sm10371979f8f.27.2024.06.24.08.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 08:26:48 -0700 (PDT)
Date: Mon, 24 Jun 2024 11:26:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Gao,Shiyuan" <gaoshiyuan@baidu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Subject: Re: [PATCH 1/1] hw/i386/acpi-build: add OSHP method support for SHPC
 driver load
Message-ID: <20240624112611-mutt-send-email-mst@kernel.org>
References: <20240624131426.77231-1-gaoshiyuan@baidu.com>
 <20240624091745-mutt-send-email-mst@kernel.org>
 <a15cb952e03845b684f5211d75dfb4ff@baidu.com>
 <20240624094556-mutt-send-email-mst@kernel.org>
 <a048130a668d44aa955599fc5c5e84cf@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a048130a668d44aa955599fc5c5e84cf@baidu.com>
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

On Mon, Jun 24, 2024 at 02:40:48PM +0000, Gao,Shiyuan wrote:
> > > > > +static Aml *build_oshp_method(void)
> > > > > +{
> > > > > +    Aml *method;
> > > > > +
> > > > > +    /*
> > > > > +     * Request control of SHPC hotplug via OSHP method,
> > > > > +     * no need parameter and return value in acpi_pcihp.
> > > > > +     */
> > > >
> > > > Quote spec and earliest version documenting this, please.
> > >
> > > I cann't find document describe this, only find in the kernel code
> > > and describe it in the commit message.
> >
> > Hrrm you really should read the spec not just go by the fact things
> > happen to work.  Look up PCI Firmware Specification
> 
> 
> Thanks and I will quote it.

yes and also pls explain why does an empty method make sense
from spec POV.


