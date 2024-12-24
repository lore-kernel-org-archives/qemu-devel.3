Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B89E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 15:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ6a1-0004Sg-Ns; Tue, 24 Dec 2024 10:12:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQ6Zz-0004SB-W3
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:12:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQ6Zy-0003XB-9Q
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:12:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735053131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xLaAcyEr3qbwtXKO3MdRSsB62y3usyWN8ZLJtwYJmYQ=;
 b=VQC0oFmbeJ2SvbLSi08KiW7CX6ahF3YOq/psaM9MB5m3jCYLi3p5dVwQj4JZccp8S/5dTq
 CLxSypEa3g8TxP/QfSEQeE7SiSqJ0Eg8sabPzxZydZBk6OyYivnVnzU4XDv90JK48txe2w
 QFkYSPyoA2czGzp9Y+FF7ctQriTtTD4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-ZPh81ayGPiiuhvLVlqZXeA-1; Tue, 24 Dec 2024 10:12:10 -0500
X-MC-Unique: ZPh81ayGPiiuhvLVlqZXeA-1
X-Mimecast-MFC-AGG-ID: ZPh81ayGPiiuhvLVlqZXeA
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d8edc021f9so87619076d6.3
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 07:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735053129; x=1735657929;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xLaAcyEr3qbwtXKO3MdRSsB62y3usyWN8ZLJtwYJmYQ=;
 b=cAfgkZAVy5zas4IamAgNTkOZmu9So4QjBdznF6DMhcFXPN7z/FRQrMuyeA18MHIehT
 WyHgCZC2TqbjrdEssiHWiEh3BlMlRFDAk1gfeOIwTrYBLpt6Q2qOxgv3RrE4BbWxsjky
 8VUzbOsgWasd/FTTPwI5wErS5535IsL4hqHFZXmr4hfZrA6fvc/iyCIOsJ10FIZbjcEO
 caQk6EBAQkIvpV7gcy+EqZGhRT7BsgylAImzO6qyRbKqKOA3xkmaU7aoKw121L+uNCVX
 5k2PMKIb56G+QMVNYfiMSRJpkXJ8DLhBjDILgT3j5A4yVlgH/uQ2HJzRnozFAC3/UDx9
 NyVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJzWfVrXGTDGiG0Md3yAcOAn0SL5kld08uH086xvDnln0I0Nnjwf/iRcYpVrxaXsbd4Uh/UNCcc37G@nongnu.org
X-Gm-Message-State: AOJu0YzoGSWVp+j6aQfmUWQ0SlXsGLkZ5E/BpyOAGEckTuL+xDpngyRe
 hnChXfOORCEb/bbbH7Jx0DstI8w5M/Cf2EF3DeJVt0I3aUeVjfYMXiT441CLcy+0/X6wy5Imj5p
 piNi2C4RgGN09tMWyigiYHYJG1k0soTm+NA8Q4KQZRG+Fo+I8ms44
X-Gm-Gg: ASbGnctXEJyRpDr4nBfr2VLevY+aIFBN0vMlWAgmJ/sZ04TjDjMJL8xM1VOl9HpwgfE
 NQdzjoFCh1qSEt1e5fDmxiCBhnhQkmYm3efNG9whVI+J2XSpv76U/E5/L1x1PSdrcSl01HIy/0X
 q4GruNG4mmcdZj/1wcOV067JyevOYF41NblkKa269C2iZIs61RZ662K7gxP8LIbupKgivEC4vBT
 IBi74R+UhZGamFM2kM3BxytQ2VMUU6uiEX6zCPIEizV4+/MvhFc/Qa8SvPOMhRU6WYj65mPuJ9x
 CHSmqILkYYmnNnYvWg==
X-Received: by 2002:ad4:5bcf:0:b0:6d8:f0ba:ea92 with SMTP id
 6a1803df08f44-6dd23356e42mr262273276d6.21.1735053129754; 
 Tue, 24 Dec 2024 07:12:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGGuWky6yM7eRenGfAAnfsTL4ChbxGSQXgw2/5G/EqCir0g0wSxGXP4XlSjkkXgXZn+2CaTQ==
X-Received: by 2002:ad4:5bcf:0:b0:6d8:f0ba:ea92 with SMTP id
 6a1803df08f44-6dd23356e42mr262272976d6.21.1735053129480; 
 Tue, 24 Dec 2024 07:12:09 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d422asm53388856d6.105.2024.12.24.07.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 07:12:08 -0800 (PST)
Date: Tue, 24 Dec 2024 10:12:07 -0500
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hyman Huang <yong.huang@smartx.com>,
 Joao Martins <joao.m.martins@oracle.com>, Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH v2 0/7] migration: Drop/unexport migration_is_device()
 and migration_is_active()
Message-ID: <Z2rPRxla5iBczNm4@x1n>
References: <20241218134022.21264-1-avihaih@nvidia.com>
 <7e89a423-14ef-4b6e-b1ae-9b2e6e947a38@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e89a423-14ef-4b6e-b1ae-9b2e6e947a38@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Dec 24, 2024 at 09:20:08AM +0100, Cédric Le Goater wrote:
> Fabiano, Peter,
> 
> On 12/18/24 14:40, Avihai Horon wrote:
> > Hello,
> > 
> > This follows up on Peter's series [1] to simplify migration status API
> > to a single migration_is_running() function.
> > 
> > Peter's series tried to drop migration_is_device() and
> > migration_is_active(), however VFIO used them to check if dirty page
> > tracking has been started in order to avoid errors in log sync, so they
> > couldn't simply be dropped without some preliminary cleanups.
> > 
> > This series handles these preliminary cleanups and eventually drops
> > migration_is_device() and unexports migration_is_active().
> > 
> > The series has been migration tested with the following:
> > - VFIO device dirty tracking.
> > - Legacy VFIO iommu dirty tracking.
> > - vIOMMU + Legacy VFIO iommu dirty tracking (migration with vIOMMU is
> >    currently blocked, so I used a patched QEMU to allow it).
> > 
> > I also tested calc-dirty-rate as now VFIO dirty pages should be included
> > in its report, and indeed they are.
> > 
> > I didn't test it with iommu DPT as I don't have access to such HW.
> > It would be great if someone with the proper HW could test it.
> > 
> > Patch structure:
> > 1-4: Refactor and clean up VFIO dirty page tracking helpers.
> > 5: Refactor dirty limit code.
> > 6-7: Drop/unexport migration_is_device() and migration_is_running().
> 
> I can take these migration changes through the VFIO queue.
> Is that ok for you ?

Fabiano is collecting things for this cycle, but just in case he's in the
middle of a party - yes please, thanks!

-- 
Peter Xu


