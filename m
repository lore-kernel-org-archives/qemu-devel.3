Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F076C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 13:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTh1n-0005jx-Vq; Mon, 23 Jun 2025 09:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTh1j-0005jc-4e
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:16:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTh1b-0000K8-Sw
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750684549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ts7A3Mt6g28i4RPuMJV6b/tojgzTyxOZZHL95hWKL5o=;
 b=P9vy4dmzGS7SmsIzQOFe7DXq78G9n7G+wqNOwqf/FCr0bnQ5DtFO7lbfAR4YABeJmJRJ0b
 xcj6rgCHgOOQMNHVOyN66xZcyMPv6yJT7JKV2W875l8aj7u7G/lpNwaytCRZvl42uBJ7BA
 9rJHQpjQ9yF1spNOOjiAoIAxYuRm2IQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-S9OsVJ4xP6aV31avOLPt1g-1; Mon, 23 Jun 2025 09:15:48 -0400
X-MC-Unique: S9OsVJ4xP6aV31avOLPt1g-1
X-Mimecast-MFC-AGG-ID: S9OsVJ4xP6aV31avOLPt1g_1750684548
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7d09ed509aaso607360085a.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 06:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750684548; x=1751289348;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ts7A3Mt6g28i4RPuMJV6b/tojgzTyxOZZHL95hWKL5o=;
 b=h/s1D6XajWc9RpPn+uD3lC5xZsn+FOLrc++x/3H+IV45M3cxT2ezvF3hejDOZUQc1/
 Oyz3HxHBNk3+c8wuHP8/JKK1BokOkG/pD/SLrs0c/5m6rZ6milrUGwTLrxKTzDFlxuGx
 fVlg06rbboMxaQoNvJVvP89dezyzfuRKrsXgI+YPmqOGSCDMqWF+8LzBu65FKvKW7BgN
 ThGtDDIRm9QJ4Xq8WSY7nrWth1Uy51U0v8NaaWuCUANgNQNcrXFS1kVw8KqA2kKRrLwk
 n8s/+8Zwo7kawadwAcM+6fI7/7WHQC96vQRIOLo5kSnkniDQAimxXhV28pMBq3a+27TJ
 U1oQ==
X-Gm-Message-State: AOJu0Yx+aaz6zmpH2hjNJC7SYAmqYdW+AewYpNApL/hXOBRWVDLQFcqx
 P5cDRDSielj2g44y1mSZUcAHbDZHmPqxa7rCKC17WTa/HXX8hm1cAPQMcm1dmjBZXJacYhFK2g7
 vL5wU0D+/1X8NxlFO+qDUDCjU7IcWA2ISW5YTwViqnGJmysZ4SNkGUtvjRErEX647
X-Gm-Gg: ASbGncsm1aEDlgHDYXyqrBEobyg5voDDQilUJ442xP2dzw9uSugVfdFhfmsyH5QFrgH
 FYL8YPAKeV9C5W1+WONdDXezQd4igdUBYt1L+MuJ8sp+00s90hneRXo5I1qItUF+2oc9sIDAvxP
 /6yN+2G3uwRMGijLymSfD6uJGCZpHBzUSzRlzC0p516zz+BTMVeJy4OA3Q233RdoWekmqYOYhY2
 mSv6jAqshpYrCiGm91BUbulGYuTELbB7oyWdNnHJuOAmK5AaMqK9BY3xSL30ktXIsR6mXWLbEr4
 xpFmwUxn/TIHPw==
X-Received: by 2002:a05:6214:5081:b0:6fa:fe02:81ff with SMTP id
 6a1803df08f44-6fd0a43b6a8mr191051556d6.3.1750684547523; 
 Mon, 23 Jun 2025 06:15:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcQJgXCC48/xNSgvpGU4DGTnrnL032LX1AxGSFFBI42enGRCY/wS1JQbfbAVvTPZNl5zv+EA==
X-Received: by 2002:a05:6214:5081:b0:6fa:fe02:81ff with SMTP id
 6a1803df08f44-6fd0a43b6a8mr191051006d6.3.1750684546940; 
 Mon, 23 Jun 2025 06:15:46 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd09456a98sm44490936d6.49.2025.06.23.06.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 06:15:46 -0700 (PDT)
Date: Mon, 23 Jun 2025 09:15:43 -0400
From: Peter Xu <peterx@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 Ethan MILON <ethan.milon@eviden.com>
Subject: Re: [PATCH 0/2] Memory and PCI definitions for emulated ATS
Message-ID: <aFlTf-El8TefWoQa@x1.local>
References: <20250620055620.133027-1-clement.mathieu--drif@eviden.com>
 <aFVxwG_O2QkryM6P@x1.local>
 <7ba298b6-13d3-44b4-bc67-5516893a6cb4@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ba298b6-13d3-44b4-bc67-5516893a6cb4@eviden.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Mon, Jun 23, 2025 at 05:43:06AM +0000, CLEMENT MATHIEU--DRIF wrote:
> Hi Peter
> 
> On 20/06/2025 4:35 pm, Peter Xu wrote:
> > Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
> > 
> > 
> > On Fri, Jun 20, 2025 at 05:56:49AM +0000, CLEMENT MATHIEU--DRIF wrote:
> >> This short series adds the 'address type' bit (concept from PCIe) to the
> >> memory attributes and extends the IOMMUAccessFlags enum. This
> >> will be required to implement ATS support for the virtual IOMMUs.
> >>
> >> Address type: Field present in the PCIe R/W requests, it allows devices to
> >> tell the IOMMU if the address provided in the request is physical or not.
> >> In other words, it allows the devices to use a physical address obtained
> >> via ATS and to prevent the IOMMU from trying to remap it on the fly.
> > 
> > Two pure questions on the flags, could be relevant to spec:
> > 
> >>
> >> Additional IOMMU access flags:
> >>      - Execute Requested
> > 
> > Does this mean that we can start to put code into DMA regions so that
> > device can run some day (even if the device may have a core that is totally
> > different arch v.s. the host's 
> AFAIU, the spec is so nonrestrictive about this flag that heterogeneous 
> arch should not be an issue.
> 
> "The definition of what it means for a Function to execute code is 
> outside the scope of this specification"
> 
> > 
> >>      - Privileged Mode Requested
> >>      - Global
> >>      - Untranslated Only (cannot be used with 'Address type = translated')
> > 
> > I can understand this with patch 1, but not yet with patch 2.
> > 
> > Patch 1 makes sense to me, IIUC it means the addresses to be used in a pcie
> > request will be translated addresses which should bypass IOMMU DMAR.
> > 
> > OTOH, patch 2 added it into iotlb access permissions, which I'm not sure
> > what does it mean.  Perhaps those addresses can only be translated by ATS
> > pre-translation requests, so that DMA on top of them (in IOVA address
> > space) will directly fail?
> 
> I put this here because the ATS API returns IOMMUTLBEntry structures, 
> which contain these flags.
> 
> The untranslated-only bit is set in ATS responses to inform the device 
> that the requested address cannot be pre-translated and should be 
> translated on the fly by the DMA remapping engine. The interrupt range 
> commonly falls into this category.

Ah I see.  Yes this makes sense.

> 
> > 
> > Side note, it might still be more reasonable to put these changes into the
> > ATS series as the first user of flags.
> 
> Yes, I can do that.
> However, the ATS series will contain ~10/~12 patches, is it a concern?

Considering the size of this series, IMHO it should be better to stick with
when they're uesd.

Thanks,

-- 
Peter Xu


