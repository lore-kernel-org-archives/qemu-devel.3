Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F75DC3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 19:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVFRI-0001Fy-9o; Sat, 20 Jul 2024 15:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVFRG-0001FP-V7
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVFRF-0008E0-LR
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721502492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8LMsjjk5OXHWiVhVH3dix0yrb00TOBlTA9slBT3yQ7g=;
 b=bNdXLrnmA90l24CC27Q6SnUlqrX+Zg4L50DhzQA3aJZlESOw5MUzX+4rsTR1t/KbpHPgHC
 33oDdD05El5VPXrYsDBlwGcK1KzhAW4X7mjX1zVTrYFUpi2uRx+xq+9GQTVpBSKrjsPjjh
 m+rGTWqcekD62D7DjwzY7ogfEW5to2U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-GxsD99-cPteTgQYhn8CHcA-1; Sat, 20 Jul 2024 15:08:11 -0400
X-MC-Unique: GxsD99-cPteTgQYhn8CHcA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-426624f4ce3so19548455e9.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 12:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721502490; x=1722107290;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8LMsjjk5OXHWiVhVH3dix0yrb00TOBlTA9slBT3yQ7g=;
 b=VZoNNrbmbWzCg3/uIQrCMJb2DqW+TBq/lvB08PXu6iCR9HEVYi+a9VT2MWsB6E9Hy1
 5i53dz5cwKWiK70fuwZuolHQQdNE1ZNRNiAAByR2WCJjHvwNyUI/RVTWv57Crg1/3+3Z
 kkcZbwLXdJT3rQaNyopaagEsbPki+KOE4VZ2z6LSN/QuL3wuDiln6Kdzdvh2hhoOG3RF
 ddGvCRY7Mgjq0iiN1XH2eIGPCANkFgp2T7857v+q7jAcqF5+/q/nAU1kJDxdKnUw5Ka1
 oiYVPk2tZcyXrBqooVfajPK5ObKWuYsybFsIUsZKvMt/WfyTiPCTvO65p1jVWSrpPOFe
 7jRA==
X-Gm-Message-State: AOJu0YzVqqe6YefDf0ruDhovkliKLOYrh5ZVeMozVQ4yygomXs5HKlMA
 SpKIJcLSE6AlgUFJgdZUnrVojebtzKwYsd/OatySSdcjJPPrHMqwkyJKIi+K5ZlP2t9VvHvmEaJ
 zexkcVpRHLKj/ZM11c8MY703MK8SC0KvMqxIcwcfhnHM65JRUByEU
X-Received: by 2002:a05:600c:458f:b0:426:554a:e0bf with SMTP id
 5b1f17b1804b1-427dc527e21mr13184455e9.16.1721502489962; 
 Sat, 20 Jul 2024 12:08:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyNkvJxF2pN8YGzoUhY+gg3F8OOlddDbMW1KH5uKHvnqPSesa200bEM7ypwSfTNxGcfXBvZw==
X-Received: by 2002:a05:600c:458f:b0:426:554a:e0bf with SMTP id
 5b1f17b1804b1-427dc527e21mr13184355e9.16.1721502489394; 
 Sat, 20 Jul 2024 12:08:09 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69385ddsm65032155e9.48.2024.07.20.12.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 12:08:08 -0700 (PDT)
Date: Sat, 20 Jul 2024 15:08:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH  v4 0/4] VT-d minor fixes
Message-ID: <20240720150754-mutt-send-email-mst@kernel.org>
References: <20240705105937.1630829-1-clement.mathieu--drif@eviden.com>
 <20240720144357-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240720144357-mutt-send-email-mst@kernel.org>
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

On Sat, Jul 20, 2024 at 02:44:18PM -0400, Michael S. Tsirkin wrote:
> On Fri, Jul 05, 2024 at 11:01:55AM +0000, CLEMENT MATHIEU--DRIF wrote:
> > From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> > 
> > Various fixes for VT-d
> > 
> > This series contains fixes that will be necessary
> > when adding in-guest (fully emulated) SVM support.
> 
> Clément are you going to address Yi Liu's comments?


sorry this is old version, pls ignore

> > v4
> >     - Move declarations of VTD_FRCD_PV and VTD_FRCD_PP
> >     - intel_iommu: make types match:
> >     	- edit commit message to explain that we are not fixing a bug
> >     - intel_iommu: fix type of the mask field in VTDIOTLBPageInvInfo
> >     	- edit commit message
> > 
> > v3
> >     FRCD construction macro :
> >     	- Longer sha1 for the 'Fixes' tag
> >     	- Add '.' at the end of the sentence
> >     
> >     Make types match :
> >     	- Split into 2 patches (one for the fix and one for type matching)
> >     
> >     Remove patch for wait descriptor handling (will be in the PRI series)
> > 
> > v2
> >     Make commit author consistent
> > 
> > 
> > 
> > Clément Mathieu--Drif (4):
> >   intel_iommu: fix FRCD construction macro
> >   intel_iommu: move VTD_FRCD_PV and VTD_FRCD_PP declarations
> >   intel_iommu: fix type of the mask field in VTDIOTLBPageInvInfo
> >   intel_iommu: make types match
> > 
> >  hw/i386/intel_iommu.c          | 2 +-
> >  hw/i386/intel_iommu_internal.h | 6 +++---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > -- 
> > 2.45.2


