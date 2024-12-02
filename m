Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14FED4979D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 05:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHywF-0007vy-E6; Mon, 02 Dec 2024 00:25:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tHyin-0006vy-8N
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 00:11:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tHyii-0001dd-3g
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 00:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733116297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IT3X0daiYpo4M3JIJyQ/ZZUzOXx+xDBce508NzZqCJo=;
 b=HiNlhoAnME8/EZr9rMAY45zmBdfYaURQmTUN3FxSwXaMavQOzq1Vn00Pa9D79RooDBHoNn
 78bR/9JcPtj0kwLdPgRo0F+ppIWBU2C5U8tddMnSxb+juMqTMFMb+ZNwnmFzwZ6xTemIj/
 Zx12t/MqHfXRCWZiVb0OFAEzz+yak8Q=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-6JXmmUdjN4q44QfeEPuWvg-1; Mon, 02 Dec 2024 00:11:32 -0500
X-MC-Unique: 6JXmmUdjN4q44QfeEPuWvg-1
X-Mimecast-MFC-AGG-ID: 6JXmmUdjN4q44QfeEPuWvg
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-841a803534fso36745839f.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 21:11:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733116292; x=1733721092;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IT3X0daiYpo4M3JIJyQ/ZZUzOXx+xDBce508NzZqCJo=;
 b=QDHchOrbnEt/uiKvvpnbuEievqBKY49M2y8XGkPaZ/1yHjHxx2IzrQwBttst5B94eA
 ZIbcingZ63vIj+n/O8Togvu3j3OagpsVpLHsBK39suQDPf6dIQCOJYZ1qQ8ZJ+s1i7b4
 tPWjcO28t1My8XgYMV9GuO6oncZ1wtSaieK56hK0QLgravSdR7W+YQ3ZHpe7re24vhpK
 ToQlUHKVvwkY6KnM0giuug3l61PmQdzYOiZDmJB0W2UF+C9dvGkm7qMYUbkEQ0niUn3w
 t+58igH6N6mOOsfZwD63AGYzywvB4Cu0olN0+A5nbOrlOgFq3DSaYiDNaCOl1ProD8k8
 Vfig==
X-Gm-Message-State: AOJu0YyYoycpvaKdEuzlXWSDD0DrTsXWVnvg+scdU2KRbtFZpcftBC0M
 g9ssabyw1FnOPZr8r8xFD05839nHQZVPNWHkzCxt/yGd2WvBzMS77AJYIGrlCPY2pYXFHCApd2P
 +dy+Zmt+P11QjM6bSznr00/5N/3p/aZ3Q8byPVYnhgEEXlXPJvnFT
X-Gm-Gg: ASbGncsLQI8Sg5OcBvkZjZ9SM7NFoEX8Oad8LPysbB7f3+ogb+OqSmT2sCfUgXCPqDi
 ijbgPVH1RtyVQEQdUKSUbosyJA//0nXg+ZGGVG6elzDRFSVBLe60iptbKb6P1Jw6H+ogWW0i1Zk
 ouSa3lQaUAi6nTw8uNC1gFwsgnxoJE0qqYkJQt86yZJyvRQeU63WDIxvLL2x0DWdSOmTR3ueSHi
 wTRUCYyecbWv6bJTgdIV7gij1n7t5XbU1LVZrd1iOE7+I5pb6nGOw==
X-Received: by 2002:a05:6e02:18c5:b0:3a7:81cd:5c4a with SMTP id
 e9e14a558f8ab-3a7c5601d1emr59687905ab.7.1733116291939; 
 Sun, 01 Dec 2024 21:11:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IET8p2BCX378MHvKhdi1tdAgqrnhMI016K0dzPed1NcisafnnNpNj2bQ5rzAXA/z83OBsle/w==
X-Received: by 2002:a05:6e02:18c5:b0:3a7:81cd:5c4a with SMTP id
 e9e14a558f8ab-3a7c5601d1emr59687865ab.7.1733116291631; 
 Sun, 01 Dec 2024 21:11:31 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7ccbf0b76sm19892035ab.32.2024.12.01.21.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 21:11:31 -0800 (PST)
Date: Sun, 1 Dec 2024 22:11:29 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, Corvin =?UTF-8?B?S8O2aG5l?=
 <c.koehne@beckhoff.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>
Subject: Re: [PATCH 1/8] vfio/igd: fix GTT stolen memory size calculation
 for gen 7
Message-ID: <20241201221129.03ea9577.alex.williamson@redhat.com>
In-Reply-To: <20241201160938.44355-2-tomitamoeko@gmail.com>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
 <20241201160938.44355-2-tomitamoeko@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon,  2 Dec 2024 00:09:31 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> Both intel documentation [1][2] and i915 driver shows GGMS represents
> GTT stolen memory size in multiple of 1MB, not 2MB starting from gen 8.
> 
> [1] https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/3rd-gen-core-desktop-vol-2-datasheet.pdf
> [2] https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4th-gen-core-family-desktop-vol-2-datasheet.pdf
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/vfio/igd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 4047f4f071..e40e601026 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -268,7 +268,7 @@ static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
>  
>      gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
>      ggms = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
> -    if (gen > 6) {
> +    if (gen > 7) {
>          ggms = 1 << ggms;
>      }
>  
> @@ -678,7 +678,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>  
>      /* Determine the size of stolen memory needed for GTT */
>      ggms_mb = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
> -    if (gen > 6) {
> +    if (gen > 7) {
>          ggms_mb = 1 << ggms_mb;
>      }
>  

I'd argue this should be rolled into patch 4.  It's not really fixing
anything because igd_gen() can't return anything between 6 and 8.  This
only allows for several device versions that we currently consider to
be gen 6 to align with i915 kernel driver generation by calling them
generation 7.  We'd previously lumped them into generation 6 because
there's no functional difference we care about here between 6 & 7.

In the next patch you replace this '1 << ggms_mb' with '*= 2', which
would be equivalent to 'ggms_mb << 1' and matches your description that
the increment is doubled.  Is there a separate bug fix that needs to be
pulled out here?

Also, please send a cover letter for any series longer than a single
patch and please configure your tools to thread the series.  Thanks,

Alex


