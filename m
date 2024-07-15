Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4265C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTHRA-00063E-LD; Mon, 15 Jul 2024 04:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sTHR7-0005sa-T5
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:51:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sTHR6-00059V-C8
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721033514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=etJ+aew3jzFKWW7IbJ/vk7g/UkA89WF0fx1dlUfz5JQ=;
 b=GtxOrZAVGLqAXXQ60u6KdBr/w1s8ftHG6hrvVlchPyrLBwOZKig8F6ARBKz6foI1JOC8aM
 QB7SbIodwdOa7DJFg9cYw3jCa6+Jplk8JjKKrcV2f2eojqKUC/nKjc/iH29jiRfHqqGnbN
 rAhhFisrWYePJLUlaE6SNBpGJom4+6g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-cOPUomXbNvCSADKxo129mQ-1; Mon, 15 Jul 2024 04:51:52 -0400
X-MC-Unique: cOPUomXbNvCSADKxo129mQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-426703ac88dso26882445e9.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 01:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721033511; x=1721638311;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=etJ+aew3jzFKWW7IbJ/vk7g/UkA89WF0fx1dlUfz5JQ=;
 b=BSrGhVkts+GIkVsSB/yZSRKW5e6IzrINSkWS452CPpbm0Qo3m/RvqF0fbYPDb5Hfjt
 fPVxKl6AZjebGMqB8x2h7hQIubNm9tkiqqq0jnv1UGygSQmKywzmd8SEhm1ES9cSddLd
 8XS2iT8yiHBzP7Bp9ZRZY3O+rxo6g/sjuVIWg+bjjE4coPkqoWeCMXhWgSPX/MSglQ2W
 3fIfZeEx4p7uc0gAKH4YDRTR8zBC249VYEFQN8MycHZQ413S6Q+CrSuqN8rYvq9y293D
 NIeaZ+BIiWM/52uO9vPD99LjFiicW40Pay/By1Z+I+pr1DVKOLVXK1fFX8dixpAD6zFE
 bnCg==
X-Gm-Message-State: AOJu0Yzgw5Yj+PAjTtDKoZ1tlDAJHGymWH8ONNqSUBXc9dcbhYZ5d8Qd
 GWRaFZTZshiIQvk3VfWkukSodO0oIV4fE1wgW3itx6voknZi4dbTVzRE98DxArHedsSrdbfvJF1
 1EKa8WiKI+BWEDPsWw6u9aUsInLgYePoe1Vsvm2gU2/EM04a8AMWx
X-Received: by 2002:a05:600c:6d8f:b0:426:6f0e:a60 with SMTP id
 5b1f17b1804b1-426707e2ffdmr124732585e9.17.1721033511426; 
 Mon, 15 Jul 2024 01:51:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBPFUeKMPzKFIZyIR9kxkphVkwOyzia+Rw5DpRQwWc7m07JkYYPqHx68Zpqzdosqjow4CdNw==
X-Received: by 2002:a05:600c:6d8f:b0:426:6f0e:a60 with SMTP id
 5b1f17b1804b1-426707e2ffdmr124732395e9.17.1721033510899; 
 Mon, 15 Jul 2024 01:51:50 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:240:5146:27c:20a3:47d4:904])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a14d32e8sm104070185e9.17.2024.07.15.01.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 01:51:50 -0700 (PDT)
Date: Mon, 15 Jul 2024 04:51:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH v7 0/4] VT-d minor fixes
Message-ID: <20240715045137-mutt-send-email-mst@kernel.org>
References: <20240709142557.317271-1-clement.mathieu--drif@eviden.com>
 <83110d22-6046-425e-8e4d-aa408f998d0b@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83110d22-6046-425e-8e4d-aa408f998d0b@eviden.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jul 15, 2024 at 08:48:52AM +0000, CLEMENT MATHIEU--DRIF wrote:
> Hi Michael, Yi and Jason
> 
> Thanks for your feedback on the previous versions.
> If you agree with the series, do you think we can move forward?


Yes, tagged, thanks!

> Thanks!
>  >cmd
> 
> On 09/07/2024 16:26, CLEMENT MATHIEU--DRIF wrote:
> > From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> >
> > Various fixes for VT-d
> >
> > This series contains fixes that will be necessary
> > when adding in-guest (fully emulated) SVM support.
> >
> > v7
> >      intel_iommu: fix type of the mask field in VTDIOTLBPageInvInfo:
> >      	- Edit commit message
> >
> > v6
> >      intel_iommu: fix type of the mask field in VTDIOTLBPageInvInfo:
> >      	- Add 'Fixes' tag
> >
> > v5
> >      intel_iommu: fix FRCD construction macro:
> >      	- Remove empty line after 'Fixes'
> >      
> >      intel_iommu: fix type of the mask field in VTDIOTLBPageInvInfo:
> >      	- Edit commit message after comment from Yi
> >      
> >      intel_iommu: make types match:
> >      	- Edit commit message (s/"make types match"/"make type match"/)
> >
> > v4
> >      - Move declarations of VTD_FRCD_PV and VTD_FRCD_PP
> >      - intel_iommu: make types match:
> >      	- edit commit message to explain that we are not fixing a bug
> >      - intel_iommu: fix type of the mask field in VTDIOTLBPageInvInfo
> >      	- edit commit message
> >
> > v3
> >      FRCD construction macro :
> >      	- Longer sha1 for the 'Fixes' tag
> >      	- Add '.' at the end of the sentence
> >      
> >      Make types match :
> >      	- Split into 2 patches (one for the fix and one for type matching)
> >      
> >      Remove patch for wait descriptor handling (will be in the PRI series)
> >
> > v2
> >      Make commit author consistent
> >
> >
> >
> > Clément Mathieu--Drif (4):
> >    intel_iommu: fix FRCD construction macro
> >    intel_iommu: move VTD_FRCD_PV and VTD_FRCD_PP declarations
> >    intel_iommu: fix type of the mask field in VTDIOTLBPageInvInfo
> >    intel_iommu: make type match
> >
> >   hw/i386/intel_iommu.c          | 2 +-
> >   hw/i386/intel_iommu_internal.h | 6 +++---
> >   2 files changed, 4 insertions(+), 4 deletions(-)
> >


