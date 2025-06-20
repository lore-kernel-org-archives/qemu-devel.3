Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19147C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 14:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uScqe-0007g9-Ic; Fri, 20 Jun 2025 10:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uScqc-0007fc-BN
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 10:36:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uScqY-0001Yw-L0
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 10:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750430159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=To/O38RzlPoNiiooz2+/FG6PZv5p8mGay4JDiGEEHRw=;
 b=bT7onLLCHfsppAGbRvDME99x10l/r7mKTu7zKfFtw4px8NESgpEUeyWGW7jpGur6p2d2iJ
 lvYuQAHS8sKlVrekGTjxZl+/DCcZiXhafkmHBJFjwllDu81aWUqcUpTrY2S2DmFEcVDBIx
 J8QLnCq/3S+lQ3Dn8sK8D4TDiFJhrpk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-6Y6LmSzhNM26dyOVO_m8qQ-1; Fri, 20 Jun 2025 10:35:51 -0400
X-MC-Unique: 6Y6LmSzhNM26dyOVO_m8qQ-1
X-Mimecast-MFC-AGG-ID: 6Y6LmSzhNM26dyOVO_m8qQ_1750430151
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-235c897d378so16985885ad.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 07:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750430151; x=1751034951;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=To/O38RzlPoNiiooz2+/FG6PZv5p8mGay4JDiGEEHRw=;
 b=v+y1NLPV10UrIli2D6dfTn7niheLh+POLdtgzyPy0SP50jQGKgzXIHwIQBi6hlWdBh
 19cnwXzrLztiKhADWVLtK905hFP2MwnbXn4GUBNxxoLBtHSrya5nNW0XOXphNkg7maua
 hfJ2SzYCnOV5OlYZv5d7P5DegSettuYmXcbbG317hF82imqo6oOyGU6ZI+j+xEkzAtIp
 USzY66zOzxPdUyG4TdelvJyGmcHA7MPk5/rl5AxTEG78q6KxvfsQL759cHm9tUvlTafw
 G1Cjzvb5Gjuk3A/eesLBZQKEp0DjKe5REaCNwGn4kbLIMfoBS6u1cz9v6HYntbspNvB9
 E2BA==
X-Gm-Message-State: AOJu0YwF056Ladh7bvhYfUmqGBfSxISzPMZst7PjV1l6hvqinX3vpJPe
 I4P3O4COjJwq+Qn2OpqUaHyGR+mHDQtXHdRYhHBIoeiqRmCfViAfG3slrB2DQrAeKh+tVsXgR3A
 gjPNvwzFxVk9/x/W3zQRqUCbY1LAV0+dFDjHK0zAGjIplnLDjFR+YScSV
X-Gm-Gg: ASbGncs0Ysepv5K/Pk5e6aNXhFvbxGzbAgEHelAAveqeDEX1qm0QrMS58b65CrhAgA1
 diXCJUC6JNehMCh7Nspc+QgmYEwqmQvsLeqbmNeydIHg0eLuBhAh7JMWH7quqYAvIpWHc5g36Ux
 nTOyF+8/C7ZH1KyfpR25g7u7TAn/QryTR71kvGJGxYH+rINFc7jmFVv1pxVG/61s/Ngm3LVwe2y
 /WaLUWp0sma2rTH5UcxmgifpwUT1lYcEGuOPOa+QOCczh5f6KIQ1tn0osO7R0tmA9x8c0cfZvw8
 edfFWqvEfgOlvQ==
X-Received: by 2002:a17:903:f85:b0:235:f298:cbbe with SMTP id
 d9443c01a7336-237d9726d7cmr53308325ad.12.1750430150704; 
 Fri, 20 Jun 2025 07:35:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwb9/BDFm9RX+ZPYDDUpPVPn02dstyypT7EltS55wCw4pl8WdF3hsdw+4fDoDdmWW35zzikA==
X-Received: by 2002:a17:903:f85:b0:235:f298:cbbe with SMTP id
 d9443c01a7336-237d9726d7cmr53307915ad.12.1750430150255; 
 Fri, 20 Jun 2025 07:35:50 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d869fbfcsm20136475ad.194.2025.06.20.07.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 07:35:49 -0700 (PDT)
Date: Fri, 20 Jun 2025 10:35:44 -0400
From: Peter Xu <peterx@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 Ethan MILON <ethan.milon@eviden.com>
Subject: Re: [PATCH 0/2] Memory and PCI definitions for emulated ATS
Message-ID: <aFVxwG_O2QkryM6P@x1.local>
References: <20250620055620.133027-1-clement.mathieu--drif@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250620055620.133027-1-clement.mathieu--drif@eviden.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

On Fri, Jun 20, 2025 at 05:56:49AM +0000, CLEMENT MATHIEU--DRIF wrote:
> This short series adds the 'address type' bit (concept from PCIe) to the
> memory attributes and extends the IOMMUAccessFlags enum. This
> will be required to implement ATS support for the virtual IOMMUs.
> 
> Address type: Field present in the PCIe R/W requests, it allows devices to
> tell the IOMMU if the address provided in the request is physical or not.
> In other words, it allows the devices to use a physical address obtained
> via ATS and to prevent the IOMMU from trying to remap it on the fly.

Two pure questions on the flags, could be relevant to spec:

> 
> Additional IOMMU access flags:
>     - Execute Requested

Does this mean that we can start to put code into DMA regions so that
device can run some day (even if the device may have a core that is totally
different arch v.s. the host's CPUs)?

>     - Privileged Mode Requested
>     - Global
>     - Untranslated Only (cannot be used with 'Address type = translated')

I can understand this with patch 1, but not yet with patch 2.

Patch 1 makes sense to me, IIUC it means the addresses to be used in a pcie
request will be translated addresses which should bypass IOMMU DMAR.

OTOH, patch 2 added it into iotlb access permissions, which I'm not sure
what does it mean.  Perhaps those addresses can only be translated by ATS
pre-translation requests, so that DMA on top of them (in IOVA address
space) will directly fail?

Side note, it might still be more reasonable to put these changes into the
ATS series as the first user of flags.

Thanks,

> 
> Clement Mathieu--Drif (2):
>   pci: Add a memory attribute for pre-translated DMA operations
>   memory: Add permissions in IOMMUAccessFlags
> 
>  include/exec/memattrs.h |  3 +++
>  include/hw/pci/pci.h    |  9 +++++++++
>  include/system/memory.h | 23 +++++++++++++++++++++--
>  3 files changed, 33 insertions(+), 2 deletions(-)
> 
> -- 
> 2.49.0
> 

-- 
Peter Xu


