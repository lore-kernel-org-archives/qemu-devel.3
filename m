Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F261CC3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 18:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVF4L-0002MN-SU; Sat, 20 Jul 2024 14:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVF4K-0002LT-2M
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 14:44:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVF4D-0004G8-UI
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 14:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721501065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y5Xvip3LujjNye39GXBeY1SGVIjG4zkLLbAYbxzRLmU=;
 b=dWXHTbifLZ9VHBCxCinRllFXaLOFqSXT2u/rGXjSEaTet8TllAQWyegPhZ81KqDhZ62bCD
 ETSc88mDFYSqVxcRh+4ZE7T4T66bv60xt2QgJ3yrzdowQMWNXilbWKxVSI4XFRNbGy67Ek
 6pAyc6Rmdft6+bAgzp4Ep+8P4+kdI08=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-z_euVNuBMnqXElJDp8hjvg-1; Sat, 20 Jul 2024 14:44:20 -0400
X-MC-Unique: z_euVNuBMnqXElJDp8hjvg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-36831873b39so1356453f8f.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 11:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721501059; x=1722105859;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y5Xvip3LujjNye39GXBeY1SGVIjG4zkLLbAYbxzRLmU=;
 b=D6JSmn2FPyBomOxfuxQKOrzzPx3m+zTv6A+XPhOAeU80YaoQf+/4gTR6SLegvlBWFS
 XJE7GqQ+ub+Pjzmp3BE1Viq4btOGH6Fd6pCgH3fi48GSU2vHHZRWiXohZnTopAAMBxH/
 F3dASK/HV/Xmya3fyiCi1eeQwea9udUsyEunFv6XBuvGR+pUjE50MCZqUDc+HCjDQhtR
 OFc6psLA1nInk8UEA8MNo5ZjElQuN4FfxTJSSeEYRxJ7lW32zNyQrFOdtg8Wk9zzZ6bT
 xgmfnGeEerRNdEL7F9jkFd/9CyOpUFjQLq4SrmPOBw0BIHTWjVreOVCpxXkC7xPZBjNL
 pYSQ==
X-Gm-Message-State: AOJu0Yyub2iW+mlfVMxso/nuOpj9XCUOAW7j/ZU39B7JZjoHky+tt8Ml
 LOfiOKQmoBpZXRZt5mfkKtlbcUP7Dj/MO4FBxJj6XefKmpg60HLcFVB5DJ/Oy0MFvDKWHSD4tYJ
 UUJrfCguQE0XcMGenKCEcVCly12KJT2NJfc8wAg5C2qiFjKgI1rST
X-Received: by 2002:a05:6000:71d:b0:368:255e:ab13 with SMTP id
 ffacd0b85a97d-36831722ed8mr8360958f8f.50.1721501059518; 
 Sat, 20 Jul 2024 11:44:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/jBlBlMk+SaotPJ6xZ5Bm3v8NXwqFiKbU3yiN0Z6z5lHn0ReZ/p7hvz5+KwL7eDLS5b2+Wg==
X-Received: by 2002:a05:6000:71d:b0:368:255e:ab13 with SMTP id
 ffacd0b85a97d-36831722ed8mr8360940f8f.50.1721501058528; 
 Sat, 20 Jul 2024 11:44:18 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684225sm4439179f8f.9.2024.07.20.11.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 11:44:17 -0700 (PDT)
Date: Sat, 20 Jul 2024 14:44:15 -0400
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
Message-ID: <20240720144357-mutt-send-email-mst@kernel.org>
References: <20240705105937.1630829-1-clement.mathieu--drif@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240705105937.1630829-1-clement.mathieu--drif@eviden.com>
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

On Fri, Jul 05, 2024 at 11:01:55AM +0000, CLEMENT MATHIEU--DRIF wrote:
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> Various fixes for VT-d
> 
> This series contains fixes that will be necessary
> when adding in-guest (fully emulated) SVM support.

Clément are you going to address Yi Liu's comments?

> v4
>     - Move declarations of VTD_FRCD_PV and VTD_FRCD_PP
>     - intel_iommu: make types match:
>     	- edit commit message to explain that we are not fixing a bug
>     - intel_iommu: fix type of the mask field in VTDIOTLBPageInvInfo
>     	- edit commit message
> 
> v3
>     FRCD construction macro :
>     	- Longer sha1 for the 'Fixes' tag
>     	- Add '.' at the end of the sentence
>     
>     Make types match :
>     	- Split into 2 patches (one for the fix and one for type matching)
>     
>     Remove patch for wait descriptor handling (will be in the PRI series)
> 
> v2
>     Make commit author consistent
> 
> 
> 
> Clément Mathieu--Drif (4):
>   intel_iommu: fix FRCD construction macro
>   intel_iommu: move VTD_FRCD_PV and VTD_FRCD_PP declarations
>   intel_iommu: fix type of the mask field in VTDIOTLBPageInvInfo
>   intel_iommu: make types match
> 
>  hw/i386/intel_iommu.c          | 2 +-
>  hw/i386/intel_iommu_internal.h | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> -- 
> 2.45.2


