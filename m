Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639B2C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 08:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOtxK-00027q-1p; Tue, 10 Jun 2025 04:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uOtxH-00026J-RO
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 04:03:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uOtxF-0006nb-9k
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 04:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749542611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C6v5eO4KRPLDLssBKHllP2DNjh2KCFp7qAC/RbRL70k=;
 b=HBPimPYEkxiqopijC+jIw9+i2KSBrOzwU/+qugd+XbYcUnpPifch4OhI9T+3PS7Qv0CWoz
 3TKaytb3oAUUMfZSEukIa/YjfC63oCU3CNNqghMtUK2Pb/qzhxVUEYSBlqkyc7n1lVuEHf
 bIeu5sQ3uOHE35o/S1Ygur6T+aN2xw8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-Ue46WyiQO-W6R1cymSI5ag-1; Tue,
 10 Jun 2025 04:03:27 -0400
X-MC-Unique: Ue46WyiQO-W6R1cymSI5ag-1
X-Mimecast-MFC-AGG-ID: Ue46WyiQO-W6R1cymSI5ag_1749542606
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DBCB1956056; Tue, 10 Jun 2025 08:03:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.69])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AB4C1956087; Tue, 10 Jun 2025 08:03:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9A83A1801083; Tue, 10 Jun 2025 08:47:06 +0200 (CEST)
Date: Tue, 10 Jun 2025 08:47:06 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Eric Auger <eauger@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/2] ramfb: Add property to control if load the romfile
Message-ID: <dli36wx3pe5we6xg5w7c3vyxifnfctovurucrci75kec3qk2y2@2dweacwekfcl>
References: <20250609073408.2083831-1-shahuang@redhat.com>
 <20250609073408.2083831-2-shahuang@redhat.com>
 <aEakP3rDTyBqDXA5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEakP3rDTyBqDXA5@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

  Hi,

> $ qemu-system-aarch64  -machine virt -cpu max -device ati-vga
> qemu-system-aarch64: -device ati-vga: failed to find romfile "vgabios-ati.bin"
> $ qemu-system-aarch64  -machine virt -cpu max -device cirrus-vga
> qemu-system-aarch64: -device cirrus-vga: failed to find romfile "vgabios-cirrus.bin"
> $ qemu-system-aarch64  -machine virt -cpu max -device VGA
> qemu-system-aarch64: -device VGA: failed to find romfile "vgabios-stdvga.bin"
> 
> Perhaps some of these devices are non-functional for other
> reasons ?

Anything with pci memory bars is problematic on arm (which is one of the
reasons why ramfb exists in the first place).

> None the less if the device is built for non-x86 targets, and
> the ROM files contain x86-only code that is to be executed by
> SeaBIOS only, then conceptually this fix should apply to all
> devices use a VGA BIOS ROM, not just ramfb.

Note that non-x86 drivers for some of these devices exist, we have at
least roms/QemuMacDrivers which includes a driver for (IIRC) stdvga.

The ipxe roms are x86-only too btw.  We could make them multi-arch at
least for EFI platforms, but given that edk2 ships a virtio-net driver
and the recently added EFI archs (aarch64, riscv64, loongarch64) are all
younger than virtio-net there is little reason to do so.

> If we're introducing a property to control this usage, then
> we should fix all devices at once, so we don't need to add
> separate properties for other devices in future.

All pci devices already have a romfile property.  So for most devices
this is a matter of setting this property via machine compat properties.

ramfb is a bit different here because it is not a PCI device, so we
can't control things with the existing property and need a new one.

take care,
  Gerd


