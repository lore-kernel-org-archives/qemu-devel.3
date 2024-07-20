Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D3BC3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 19:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVFUm-0005IP-KI; Sat, 20 Jul 2024 15:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVFUl-0005Hc-02
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:11:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVFUi-0000Pp-VV
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721502708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ldJMC8NcumbuP8G4YKa690DYMLQmR7H6WPhBQu85Cuc=;
 b=XIycvuqhy3bXX4ur6OW6+zh2IzifeUBX61g57PVmI6JSxlJYFbT8IMzoxzquwdzWjEejQz
 ET0POHjICdA/P3L5EDF5XCK2TuL06fzrNafEMu0SghfSWOagHrHWEYAyAs6a/9sL1ojRTJ
 R9Os7TCsqVnw+SHev/Hpd0+GE+4EEqY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199--BguolCeMbClA87_MRvuQQ-1; Sat, 20 Jul 2024 15:11:46 -0400
X-MC-Unique: -BguolCeMbClA87_MRvuQQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42490ae735dso28806385e9.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 12:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721502705; x=1722107505;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ldJMC8NcumbuP8G4YKa690DYMLQmR7H6WPhBQu85Cuc=;
 b=onBzBrd0rTFxM3mtPv2RKIHN+YZkMicjC3pPbNt+bJ//BnBttXBGwy/BMOhf0roUpO
 p5LatnD6mR24nuA5tdqKI5FczZMK9J+IzfXEqO2D7t3npwsmf0H9fCWCI3xk/wzKUW4W
 QkNw2WMU6FTNfxjqROKbFJnGbJyKjGPhW1rsILWjIEQvh4JA67jtBGvEhQsQRAXEHG++
 FxawvO7PvMfOLSrGaqRdJeYGc4M0bTXLf0QIUHBvBDX5hT3L5zTAVLlZaTj+ddAZAY8h
 pot8oD5SjPwAKiL/Vs/k372MVF8sbrYcnEuTekIrpJnxP5WETG1XpualtPfRgvCUasNJ
 CIwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW84Qt0uplDwXBI6sR4KhbQiS/0zBxhR0D1EvOCxf2OgrXhxFXP6uokHKNHTzUurJYxo1KHSYXsFGXNALEw91JrCAkQhvQ=
X-Gm-Message-State: AOJu0YxRV4Uds+PWRe6dHKkYBeJQTMVo1H6KYg1fQud837ylMBt7iW84
 2kjgJuejYJRUpfTmU59keIGbWYtvQmhOal9h1dHpwSq1evutgiKS4RYzj+prJ5934XNu1WDbabj
 VCOmhJo1Ye8rbiIJhexyD4SkGGITktbVOvmluvcB2eIj8Q2TmG3C4
X-Received: by 2002:a05:600c:3109:b0:426:6857:3156 with SMTP id
 5b1f17b1804b1-427dc55bc49mr17672805e9.27.1721502705505; 
 Sat, 20 Jul 2024 12:11:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9xdVRSRVD2Wbn9C7ViCmqDwkXLWIusGsN9OyYWIh8QHBSRCW4lE/gXZJfc0rdhhfZR4P2/g==
X-Received: by 2002:a05:600c:3109:b0:426:6857:3156 with SMTP id
 5b1f17b1804b1-427dc55bc49mr17672505e9.27.1721502704866; 
 Sat, 20 Jul 2024 12:11:44 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6929981sm65301955e9.36.2024.07.20.12.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 12:11:44 -0700 (PDT)
Date: Sat, 20 Jul 2024 15:11:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v10 06/12] pcie_sriov: Reuse SR-IOV VF device instances
Message-ID: <20240720151022-mutt-send-email-mst@kernel.org>
References: <20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com>
 <20240627-reuse-v10-6-7ca0b8ed3d9f@daynix.com>
 <75cbc7d9-b48e-4235-85cf-49dacf3c7483@redhat.com>
 <20240710065145-mutt-send-email-mst@kernel.org>
 <97c6ac3e-d099-4cc5-9672-1c1658f0cbc6@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97c6ac3e-d099-4cc5-9672-1c1658f0cbc6@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Jul 13, 2024 at 09:45:07PM +0900, Akihiko Odaki wrote:
> On 2024/07/10 19:52, Michael S. Tsirkin wrote:
> > On Wed, Jul 10, 2024 at 08:37:27AM +0200, Cédric Le Goater wrote:
> > > Hello,
> > > 
> > > This change introduced a regression on s390x. I could have spotted it
> > > earlier. Sorry about that. Here is the scenario,
> > > 
> > > QEMU now creates automatically the PCI device objects representing the
> > > VFs when the PF device is realized in pcie_sriov_pf_init(). This is
> > > good to report errors early but it has an important drawback.
> > > 
> > > On s390x, PCI devices have a dual S390PCIBusDevice object. This device
> > > model has 'uid' and 'fid' properties which can be either set by the VMM
> > > or, if not, auto-generated by the S390PCIBusDevice realize handler. In
> > > the VF case, these ids are auto-generated by QEMU and they can possibly
> > > conflict with the uid number space of libvirt. The conflict is detected
> > > when the machine is created and the start is aborted with a message :
> > > 
> > >    2024-07-08T12:51:42.876883Z qemu-system-s390x: -device {"driver":"zpci","uid":17,"fid":16,"target":"hostdev0","id":"zpci17"}: uid 17 already in use
> > > 
> > > This problem can occur today with a s390x VM using an IGB device.
> > > 
> > > It worked fine when the VFs were created at OS runtime because the initial
> > > topology of the machine was in place. Adding VFs was more or less like
> > > hotplug. AIUI, libvirt should have full control on the machine topology
> > > and so, creating VFs in QEMU at init time in the back of libvirt seems
> > > like a violation of this rule.
> > > 
> > > That said, the s390x case is specific and could perhaps be handled in a
> > > special way.
> > > 
> > > Thanks,
> > > 
> > > C.
> > 
> > 
> > Thanks for reporting this Cédric. Akihiko what's your
> > plan to handle this? Do you have the time to address this issue?
> 
> Creating VFs at initialization time only makes problems apparent early. Even
> without this change, hot-plugging another PCI device after realizing a VF
> results in a similar situation.
> 
> A proper way to handle this is to add new properties to igb and nvme to let
> libvirt specify the VF ids. However I wonder if it is a worthwhile addition
> (i.e., if igb and nvme's SR-IOV emulation will be used with s390x and
> libvirt).
> 
> Regards,
> Akihiko Odaki


Well okay but libvirt will not update overnight.
If we need time to discuss the design, I can revert for the
release and reapply after we have a fix.

-- 
MST


