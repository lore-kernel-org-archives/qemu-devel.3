Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D231AC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 07:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4aws-0001ns-Tj; Tue, 15 Apr 2025 03:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u4awl-0001nT-03
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 03:43:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u4awj-0006sV-B9
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 03:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744702983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OlrcEsIeCM7F+cO5CYR19hmweoaji5NZ0uxry2wjKPM=;
 b=CtGS7uVobmUR+uMycEAK8zF7DEhnhXcGOfQQnV1XXBXotSxeOb2o4WmruhhI3RozUJ/vej
 5hqeeMv2Ol+ToGGUrzk80+8Eye58xzZHgfsrPs2a4NtALTdX1h4W86zRmnD8tDnL5/xaxG
 02wAU+08fsWW2XNqT2/DmSfl1XGuCSU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-KOnE00o8MHCfPicWeuXCWA-1; Tue, 15 Apr 2025 03:43:01 -0400
X-MC-Unique: KOnE00o8MHCfPicWeuXCWA-1
X-Mimecast-MFC-AGG-ID: KOnE00o8MHCfPicWeuXCWA_1744702980
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43ea256f039so39885375e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 00:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744702980; x=1745307780;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OlrcEsIeCM7F+cO5CYR19hmweoaji5NZ0uxry2wjKPM=;
 b=wB1+R4z/E/T2Z6X0g+i2E9lacSRYq1TX207cts1n5063PCTiGYs3L9GLetgkyUYiOn
 PuwKkbAYmp42Rod4q91433Fqu8D+/BOB0YYn6e9yNbLc1Zsw69Jycs+p4bz6QQOOYI1Z
 C/ZGgpyMNrEjqGIDS5E3TA19L9OLpFE77PA5Ck9/ZNlf7vokD7xuNvchRHtWaNQYlcHd
 K2FWIlCzMfnkSupWmxKsPtiJpfcRkTkgXxSe0gzKN4TMmD+N7E75aZpVwG2c3c5M2FsX
 90SAZpJ/MXJNrxmCGHtsaNmO/wJda9niEZOmroUY68heN9sZjWZuSbbQCEXnKsM9R/LQ
 i/Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8tsRoYlzVfi5GuKJy7uEEaD2UH8n6lBs86zA+m0t/1B3WWLE166WRLmHQidQUJbCfdgTcXAd88ONf@nongnu.org
X-Gm-Message-State: AOJu0YzAJGXjX2I6AqZWI/VOjk1/Jq+cSBCQPCg6d/IbcUh1sA10CTjO
 t/0eHgM9UId9ZyR7LRjYfAtPBLXlhfFggQpbI1d4p0tlRIhgrEvmhoLLc/9YLED+stZE+a8+8vH
 uTNLeLCBP3sjIdkpiOtpb27dW0O6VTVeBm+9kBBeU1d5dwGnqRpZC
X-Gm-Gg: ASbGncskRGjHzUWdMkIu2zOEP7daSuI3hM2Vets+dvtYgCMnNfVwapF3xWn9OpPhD66
 f8mDiL2KYVABWK9e5ailFwct1RfOkLbVCTuWzVRZwvbHot+DpBGdMRrvdaSxRS+Ar1Do5SZ9Lju
 DXGUFB4jgg7b2m7vz6DjLYCcvPGO8cao0PtVv/n7X40ISAVH8l7HDTCSXCuyY1XgS42xisrIrb3
 2j/37TYFpR5rAXoet+t1hDaOxKIrHGolqqShPfcNOhZFUGH+yHNDG3OTdJrGlsEm7r7PRiln70T
 PXE0Yg==
X-Received: by 2002:a05:600c:1e02:b0:43d:22d9:4b8e with SMTP id
 5b1f17b1804b1-43f86e1f246mr25391525e9.10.1744702979825; 
 Tue, 15 Apr 2025 00:42:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtbWzUCVyQFwKQPh4evCxMUoUALYbwXZjRdAGzzNl7mXbgYRZytsAn0MXgmbgFTjkQ1dPOcw==
X-Received: by 2002:a05:600c:1e02:b0:43d:22d9:4b8e with SMTP id
 5b1f17b1804b1-43f86e1f246mr25391205e9.10.1744702979408; 
 Tue, 15 Apr 2025 00:42:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f2066d26bsm205037975e9.22.2025.04.15.00.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 00:42:58 -0700 (PDT)
Date: Tue, 15 Apr 2025 03:42:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH] intel_iommu: Take the bql before registering a new
 address space
Message-ID: <20250415034112-mutt-send-email-mst@kernel.org>
References: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
 <23c9f066-f30c-4e35-8629-504eeb9cd7a8@linaro.org>
 <f3b38c07-f099-4422-87fa-32c78c7630a4@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3b38c07-f099-4422-87fa-32c78c7630a4@eviden.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Tue, Apr 15, 2025 at 07:28:34AM +0000, CLEMENT MATHIEU--DRIF wrote:
> 
> 
> On 15/04/2025 8:53 am, Philippe Mathieu-Daudé wrote:
> > Caution: External email. Do not open attachments or click links, unless 
> > this email comes from a known sender and you know the content is safe.
> > 
> > 
> > On 15/4/25 08:18, CLEMENT MATHIEU--DRIF wrote:
> >> Address space creation might end up being called without holding the
> >> bql as it is exposed through the IOMMU ops.
> >>
> >> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
> >> ---
> >>   hw/i386/intel_iommu.c | 10 ++++++++++
> >>   1 file changed, 10 insertions(+)
> >>
> >> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >> index dffd7ee885..fea2220013 100644
> >> --- a/hw/i386/intel_iommu.c
> >> +++ b/hw/i386/intel_iommu.c
> >> @@ -4216,6 +4216,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState 
> >> *s, PCIBus *bus,
> >>       vtd_dev_as = g_hash_table_lookup(s->vtd_address_spaces, &key);
> >>       if (!vtd_dev_as) {
> >>           struct vtd_as_key *new_key = g_malloc(sizeof(*new_key));
> >> +        bool take_bql = !bql_locked();
> >>
> >>           new_key->bus = bus;
> >>           new_key->devfn = devfn;
> >> @@ -4238,6 +4239,11 @@ VTDAddressSpace 
> >> *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
> >>           vtd_dev_as->context_cache_entry.context_cache_gen = 0;
> >>           vtd_dev_as->iova_tree = iova_tree_new();
> >>
> >> +        /* Some functions in this branch require the bql, make sure 
> >> we own it */
> >> +        if (take_bql) {
> >> +            bql_lock();
> >> +        }
> >> +
> >>           memory_region_init(&vtd_dev_as->root, OBJECT(s), name, 
> >> UINT64_MAX);
> >>           address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, "vtd- 
> >> root");
> >>
> >> @@ -4305,6 +4311,10 @@ VTDAddressSpace 
> >> *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
> >>
> >>           vtd_switch_address_space(vtd_dev_as);
> > 
> > Would it help clarifying to propagate this argument down?
> > vtd_switch_address_space(VTDAddressSpace *as, bool need_lock);
> 
> Hi phil, vtd_switch_address_space already does the same kind of check
> 
> > 
> >>
> >> +        if (take_bql) {
> >> +            bql_unlock();
> >> +        }
> >> +
> >>           g_hash_table_insert(s->vtd_address_spaces, new_key, 
> >> vtd_dev_as);
> >>       }
> >>       return vtd_dev_as;
> > 


As an apropos, I think any caller of bql_lock really should call
bql_lock_impl so we know who took BQL. Or just use BQL_LOCK_GUARD.
But, that's an unrelated cleanup.


