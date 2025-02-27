Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F482C19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 21:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnlsR-0004kY-9G; Thu, 27 Feb 2025 16:57:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tnlsP-0004k8-99
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 16:57:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tnlsN-0006Yf-Hn
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 16:57:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740693420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hxtY58cL3fCjjL4r2dYDM9cLMZpR1P9WmNPFFn/BJwU=;
 b=L3bJXx5EiO/vEmVFCVf6X2w5dbINKf0xyo/UGFMSFUwsKRvhR3e7bTojN4nFZGgpg/tRbl
 F17sz11IDBQVFVWxYs6PiuR2Qw6xiDUqaHry0lr7+enYn1zAhx61sTIJN0AP4vMiCU7PMB
 LQmQVXFky5zZcHOFUGF3jDsTcFtLij4=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-LzrNHTXUN5G_R17eUhtAQQ-1; Thu, 27 Feb 2025 16:55:44 -0500
X-MC-Unique: LzrNHTXUN5G_R17eUhtAQQ-1
X-Mimecast-MFC-AGG-ID: LzrNHTXUN5G_R17eUhtAQQ_1740693344
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-855fc58b9b9so21091239f.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 13:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740693344; x=1741298144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hxtY58cL3fCjjL4r2dYDM9cLMZpR1P9WmNPFFn/BJwU=;
 b=f65dF4fc3byGADjPzwlrnGml7Ykb/7HxMncGABoHtfUxj5pZ3wTUTr81aKZLqYId6u
 dMo4xQCwaBmgCZMIbtapIC/bOEeZaB7YiUjROF6KZ7KMYXNkD4SKCVnFZMEX+vXcMaQ1
 lW2c1orZXdvHufvW6JusqY7sh41ZhW6s74RnZQjEjTNnZOGTkH8X5oIcL4qMB0SdpvOg
 AAE9tQe9QiatB+ELvAD75i4J1KW7ROr/kFrKcTnVnt5Jbm2oMZUCkMbhMkxUOAdABczD
 JUsZsEK9tSXOJeAEctHuM/lRJX/e4o9HuNtD4YWxUsB+9R1ZslP/dTRuw9gwx0WJUH1o
 y6Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCR2lFcQx4jNia8CaO3Y91OrusOYBM0Iwci2wPaNVCLvLzCvfbi5FpWCbJOXBZQ0RwgDJxMng6LDMl@nongnu.org
X-Gm-Message-State: AOJu0YxgrLYMqTzgN8IrDLTC9fplrg/R/z9ijY2o5jVyqA/YH8R+wtjq
 GrRTJr9x31VFSfLNKyUtbgGA8oODnov+he5FnEAubBopU8RCVNF4HoBBhezmUygTXoaWW36Qdvg
 M5aOiw41tlNS/4bNrgQOuyzU41wim0osseWdmtvy6PpYqOgX1PQq/
X-Gm-Gg: ASbGncusbvroFdJyZ/d35oyDN9tjPEzXWgLFnPON/3C4pw/90WCIdnCvmaKvEO1IX2R
 arAo+WB3gH9z2AE+onh4XZFE+AfHo7iH23084H5LSNVr3gj/RGLC6PF6Li96qYxHFzsJr07Y7y3
 al6SiyCTUo2E6i81aJ5bGuzpzTDkLzk2gKIj6Vm0pIRmfyqOPSJ7iuOwP83L5TU2f1ZFHVHpH4h
 e0JP8zHBJYjkBaB1X3S1m0AV8XhKOE4klTEAyw8tJJCe9Qo4YdXlr3mUNLgGPqPX6dgxjInFxRw
 bcLL8eLA6cfLPKN3R+o=
X-Received: by 2002:a05:6e02:184a:b0:3d3:d13b:4de3 with SMTP id
 e9e14a558f8ab-3d3e6f483fbmr2554475ab.5.1740693343751; 
 Thu, 27 Feb 2025 13:55:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUGd3lk+K6DxzgfdxY4cE+A7rK1JbmhfNcj3+oNL4qOKwAphRRj6R5KgF0lbyk8I7fWTdjcg==
X-Received: by 2002:a05:6e02:184a:b0:3d3:d13b:4de3 with SMTP id
 e9e14a558f8ab-3d3e6f483fbmr2554385ab.5.1740693343409; 
 Thu, 27 Feb 2025 13:55:43 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f061c71940sm542309173.66.2025.02.27.13.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 13:55:41 -0800 (PST)
Date: Thu, 27 Feb 2025 14:55:38 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 00/10] vfio/igd: Remove legacy mode
Message-ID: <20250227145538.4735420c.alex.williamson@redhat.com>
In-Reply-To: <20250224182927.31519-1-tomitamoeko@gmail.com>
References: <20250224182927.31519-1-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, 25 Feb 2025 02:29:17 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> This patchset removes some legacy checks and converts the legacy mode
> implicitly enabled by BDF 00:02.0 into x-igd-* options, including:
> * Removing PCI ROM BAR and VGA IO/MMIO range check before applying quirk
> * Using unified x-igd-opregion option for OpRegion access.
> * Introducing new x-igd-lpc option for the LPC bridge / Host bridge ID
>   quirk. Currently this is only supported on i440fx.
> * Extending quirk support when IGD is not assigned to BDF 00:02.0
> 
> The first 2 patches of this patchset was taken from a previous one,
> details can be found at:
> https://lore.kernel.org/all/20250124191245.12464-1-tomitamoeko@gmail.com/
> 
> This patchest was mainly tested on Alder Lake UHD770, with Debian 12
> (kernel 6.1), Windows 11 (driver 32.0.101.6458) and Intel GOP driver
> 17.0.1081.
> 
> If the design is good to go, I will update the documentation also.
> 
> A open question is whether the old legacy mode behavior should be kept
> or not. Checking if all the condition of legacy mode were met and
> toggling correspoding options is more complicated then I expected :(
> Any ideas would be appreciated.

I dusted off a working IGD assignment configuration on an i7-7700 Kaby
Lake system with HD630 graphics.  This series breaks it a couple times.

First, while the host system itself may support UEFI (some systems may
not), I had dumped the VGA ROM in CSM mode and run the VM with SeaBIOS.
Therefore it needs VGA support.  This is the recommended configuration
for legacy mode in our current documentation.  Patch 4/ requires that I
add x-vga to continue using this VM.

Then of course since this VM is specifically using legacy mode, patch
10/ requires that I also add both x-igd-opregion and x-igd-lpc.

Therefore I go from a VM that works with IGD assignment in legacy mode,
with no unsupported options:

<domain type="kvm">
    ...
    <type arch="x86_64" machine="pc-i440fx-10.0">hvm</type>
    ...
    <hostdev mode="subsystem" type="pci" managed="yes">
      <source>
        <address domain="0x0000" bus="0x00" slot="0x02" function="0x0"/>
      </source>
      <rom file="/var/lib/libvirt/images/igd-i7-7700.rom"/>
      <address type="pci" domain="0x0000" bus="0x00" slot="0x02" function="0x0"/>
    </hostdev>

To one that requires multiple unsupported, experimental options:

<domain xmlns:qemu="http://libvirt.org/schemas/domain/qemu/1.0" type="kvm">
    ...
    <type arch="x86_64" machine="pc-i440fx-10.0">hvm</type>
    ...
    <hostdev mode="subsystem" type="pci" managed="yes">
      <source>
        <address domain="0x0000" bus="0x00" slot="0x02" function="0x0"/>
      </source>
      <alias name="ua-igd"/>
      <rom file="/var/lib/libvirt/images/igd-i7-7700.rom"/>
      <address type="pci" domain="0x0000" bus="0x00" slot="0x02" function="0x0"/>
    </hostdev>
  ...
  <qemu:override>
    <qemu:device alias="ua-igd">
      <qemu:frontend>
        <qemu:property name="x-vga" type="bool" value="true"/>
        <qemu:property name="x-igd-opregion" type="bool" value="true"/>
        <qemu:property name="x-igd-lpc" type="bool" value="true"/>
      </qemu:frontend>
    </qemu:device>
  </qemu:override>

I don't know how we justify this within our defacto support contract
with users.  Legacy mode needs to continue to exist and be
automatically enabled unless we want to figure out a deprecation
process for it and queue this sort of change for sometime in the
future.  Thanks,

Alex


