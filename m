Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE69EC5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27v-0003U8-76; Tue, 10 Jun 2025 12:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uP1sx-0007kd-Hs
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 12:31:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uP1sv-0004nA-Lw
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 12:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749573094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uEnFzQX+3AN5Mg1ENclmMV60pj/YFE2y+k8hgAKqrQk=;
 b=AsQ0PZ/TRGN/2YFbbVw1ORGU9q9duHDSnq3Sz0rqT3LPllrUhp7dn/vZOirg84Lsf9gpfB
 Y5du0rIVLh6zC3Stpk69D59f9237HLsImBY6/KgIXVwcGrX8jg2eokLBBXJ5/BYYBNvJiT
 eUtSlZeu3ia1UsoobWmMcsKms+mo+8M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-wc5BWJ87MmSeTRFBKch6ug-1; Tue, 10 Jun 2025 12:31:32 -0400
X-MC-Unique: wc5BWJ87MmSeTRFBKch6ug-1
X-Mimecast-MFC-AGG-ID: wc5BWJ87MmSeTRFBKch6ug_1749573091
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4eb9c80deso2107996f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 09:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749573091; x=1750177891;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uEnFzQX+3AN5Mg1ENclmMV60pj/YFE2y+k8hgAKqrQk=;
 b=XNMg+xUOFxsc4u7aBwgBPfuPkoLFvAs0rT7JUpJjTALYIidplRoxQhvk5b6OrpVafM
 GTHP6uNtFzaf17po8RkCe9ur3bRzh4hg0NuosuMAvHlHMNtnPAKv5XkPPcF83gOn3qBZ
 GGYM0n+26whKotHZP1TvJdfZ5BWSua/A5p6BfKFOn4jxmwxmo9TgLDJlC7rCGp1GAL0+
 oWpa0jrV3MUHSjm13427WYZfenQhsD6wvfQskb+d2IGbOmq2ZORezZ9580ZtRj4xtCOI
 iudVPnWW91nFQBnuk4CZE+bBBlDFckhZ9bkmSZ33hRoLeyeMbBSPWTilomX4rgPXcbu+
 SwlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnFdEgsYGki+QX1JIz+OX3/wDsMn9lz7sX/qMooEP06UR8btejk7XYFkBG/bPW5eZzZ870DM2wXWEm@nongnu.org
X-Gm-Message-State: AOJu0YyAcxKXXPOFW+6fbUCggeKV7/KAZa0/LUkCT125hvysZe0Q8Lfz
 gtYfN1/Xoiu9LyonYxRDV+cpm2QUmMODC2cq6a/O8DbNh7XK8jbB5OXS5nsA8HkNBcqz2IOTUOa
 fQygms7ugRAsSzyN6oktjdjTe/6Tpv185L/pjoNHrNBqBi54JjdoeT0K6
X-Gm-Gg: ASbGncuKZ/z/X4euO9Yf/VXaQBwtvNBbQ/6b/ZhvFaXkkGMDdV/GF7F7bhdkXC4R+SK
 kAmxY+a4LrU5iiKFdNsIHCosMEi+cshmDMr3IqEGTD0eNqqYMGBoFEJeqZilF5R4UPPYZtF2hCd
 1NRAe6fTNmSIDIs+7b0L+ZW0KQ/RVA43Fkse1nPlHCjIXArUaOTgv0eQROCHNMMO1/Vy3J0IE2s
 ZvxAVrBKT5opzWAN3uD/WogHodyTf7B0N+uIdxsVHksVdm9H9HxsJ+QGV77t3L6tfSRycz+9kAq
 6WhFNG5urNePX+4n
X-Received: by 2002:a5d:64e7:0:b0:3a4:f902:3872 with SMTP id
 ffacd0b85a97d-3a531cab757mr13367582f8f.19.1749573090918; 
 Tue, 10 Jun 2025 09:31:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHysSiRANfZlU1GfoqyZGcgBgVmmaHqdBXp6WJ8+A//vTK6Vw70BMxOPhGTAsgPFrl6dSGr5w==
X-Received: by 2002:a5d:64e7:0:b0:3a4:f902:3872 with SMTP id
 ffacd0b85a97d-3a531cab757mr13367548f8f.19.1749573090533; 
 Tue, 10 Jun 2025 09:31:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5323c08fasm12495371f8f.44.2025.06.10.09.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 09:31:29 -0700 (PDT)
Date: Tue, 10 Jun 2025 12:31:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V4 16/43] pci: skip reset during cpr
Message-ID: <20250610122246-mutt-send-email-mst@kernel.org>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-17-git-send-email-steven.sistare@oracle.com>
 <d62bd9c6-1660-4d16-8d7d-5445ba6c5031@redhat.com>
 <20250601150607-mutt-send-email-mst@kernel.org>
 <899ee161-2c5d-4aa2-aa64-5135b26bc3ff@oracle.com>
 <0a50d630-57c7-4f05-93c7-73be8f575873@redhat.com>
 <c01c7c19-2422-45c7-9582-09ca37170974@redhat.com>
 <468008fc-a86f-4b90-86c3-1109d68f6fc2@oracle.com>
 <76b58b82-a867-4577-8644-88e419a8d85f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76b58b82-a867-4577-8644-88e419a8d85f@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 04, 2025 at 03:48:40PM +0200, Cédric Le Goater wrote:
> > I don't see any advantage to making this a class attribute.  I looked for examples
> > of using such attributes for vfio to configure pci, and found very little.  It
> > sounds like overkill since vfio already sets and gets PCIDevice members directly
> > in many places.
> > 
> > I defined skip_reset_on_cpr based on this existing example:
> > 
> > vfio_instance_init()
> >      pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS
> 
> pci_dev->cap_present can be modified at realize time. skip_reset_on_cpr
> is a constant, for which a class attribute are more appropriate.
> This is minor.
> 
> Michael,
> 
>   Are you ok with the 'skip_reset_on_cpr' bool ?

Generally yes, but maybe cap_present bit is even cleaner?
vfio already pokes at it, and we have history of encoding
quirks there, see QEMU_PCIE_LNKSTA_DLLLA_BITNR for example.


> > > I wonder if the resettable interface, and more specifically the
> > > RESET_TYPE_SNAPSHOT_LOAD type, might be useful. Have you explored
> > > this alternative ?
> > 
> > RESET_TYPE_SNAPSHOT_LOAD (or a new type such as RESET_TYPE_CPR) would skip
> > reset for all devices, but we only skip for vfio_pci.  All other devices
> > (including virtio) save and restore state using standard migration vmstate,
> > and must call reset.
> OK.
> 
> C.


