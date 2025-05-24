Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB675C54F30
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 10:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uImFl-00049p-K8; Sat, 24 May 2025 06:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uImFk-00049c-0T
 for qemu-devel@nongnu.org; Sat, 24 May 2025 06:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uImFh-00033R-KJ
 for qemu-devel@nongnu.org; Sat, 24 May 2025 06:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748083035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=szvTzvKj5x32meHVvCO/VysnfM/CIK9OlP9wQI7PHEc=;
 b=P7Ye+H6ApmHgoaRhGx5D0VWMWkB3l/eA2J5GFvfdpjbLpCXfVYPkOoi6eYzDx3woe+iBtI
 6p/v2Ng4nHwcEMOnwNAC4YYEb4YPKagkOaKs/EdYAftBkjzhBARmrhCkWKrKZpwSbPNQUk
 WH17keCDjZNaUuLDlPu+YjtR8XI+zMY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-LqwsmTqsNXK3y7j7EOedFw-1; Sat, 24 May 2025 06:37:13 -0400
X-MC-Unique: LqwsmTqsNXK3y7j7EOedFw-1
X-Mimecast-MFC-AGG-ID: LqwsmTqsNXK3y7j7EOedFw_1748083032
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cfda30a3cso3143575e9.3
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 03:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748083032; x=1748687832;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=szvTzvKj5x32meHVvCO/VysnfM/CIK9OlP9wQI7PHEc=;
 b=n5ftNR8vzlv9bJT+gX5DIZ33v8THQIMgZ7XaAe0L7rJ9oikxOtu1VgEx8EPp8JA5yR
 6jHEaDC2z7StTgf052iSK1w7yT9B6BNFkLzdAn/0GDuqtFmREAb/KTpxIeuO+1OrsWnc
 dedlNyQZEXcP8NEvqf6YTu1KBAtr5f3Duh2jQuUEiTeVzdWOMoc+80ZgvLju2gSab1VQ
 pO7p3IZYjlE4uZaxhH1vQ+x1r9iVNPuu4DFqHsDJ2mApZhNQlcVKlaa4oFPZWS0ziKpw
 02qlutR1KN/o5iThutXZQpLmroF3fSdxEfUNN7l9ALxXL/Zitro31tcmIIg4rLlqzwFf
 +NgA==
X-Gm-Message-State: AOJu0Yy8huVQmVOnetj0Rlbt5nvuIFrW4lLaYhzSvagBBmSWEr0t0te6
 WUuaWe2mqC11Qs8zyb8G2nVM0kNJH+26+lMyLGOpzbNtPq3A0xdcZMeNw6SLyqJ7Ah6KD9MOTPo
 1tv8z1rIgJS/vzmLLyL80cxowSfSgKy0mw2Kd5pFxJyW82A3byet+iL8M
X-Gm-Gg: ASbGncvRKDusPv+JLZ5WWi9zu/hfLKxr55lN/T8Ge3b13W4va4mgCSqUmSmXjT8XCUS
 wDfSDKWo/pZm3Mi4KhzWKo4jWLaYxADiQmz1jKxjGBI75Tv3u1pkwlYAOhx7rBWZlVTFcZjNHT+
 0GB9vQlTA/gyZZ2wC+owy71a4rubz8h3UWtR5H8X5+fHOex1WQ5er/+y2gf+9sxPCTH7L8fMeUP
 wXXVQrGD5CEaBSQxShXP5sVvXw6xNzMb4qyA62jcm/eIwGA9tMsRyAwvtUV3+QSLrF4PqlEEEMe
 k8+dsA==
X-Received: by 2002:a05:600c:1e1c:b0:444:c28f:e818 with SMTP id
 5b1f17b1804b1-44c9493e382mr21407465e9.26.1748083032377; 
 Sat, 24 May 2025 03:37:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcn8gbAPhLL0GpCdRj8vP7BB0uNp02HW//P8sigBWvGYYPLbTrpGO0IgPXqw0b6yXkoOmtqQ==
X-Received: by 2002:a05:600c:1e1c:b0:444:c28f:e818 with SMTP id
 5b1f17b1804b1-44c9493e382mr21407195e9.26.1748083032007; 
 Sat, 24 May 2025 03:37:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f7ca2dd9sm169743815e9.37.2025.05.24.03.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 03:37:11 -0700 (PDT)
Date: Sat, 24 May 2025 06:37:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, anisinha@redhat.com, imammedo@redhat.com,
 jonathan.cameron@huawei.com, linuxarm@huawei.com,
 peter.maydell@linaro.org, prime.zeng@hisilicon.com,
 shameerali.kolothum.thodi@huawei.com, wangyanan55@huawei.com,
 yangyicong@hisilicon.com
Subject: Re: [PATCH v4 3/4] hw/acpi/aml-build: Build a root node in the PPTT
 table
Message-ID: <20250524063700-mutt-send-email-mst@kernel.org>
References: <20250424122439.550-1-alireza.sanaee@huawei.com>
 <20250424122439.550-4-alireza.sanaee@huawei.com>
 <20250511140938-mutt-send-email-mst@kernel.org>
 <20250519095551.0000525d.alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519095551.0000525d.alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.298,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, May 19, 2025 at 09:55:51AM +0100, Alireza Sanaee wrote:
> On Sun, 11 May 2025 14:10:46 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Apr 24, 2025 at 01:24:38PM +0100, Alireza Sanaee wrote:
> > > From: Yicong Yang <yangyicong@hisilicon.com>
> > > 
> > > Currently we build the PPTT starting from the socket node and each
> > > socket will be a separate tree. For a multi-socket system it'll
> > > be hard for the OS to know the whole system is homogeneous or not
> > > (actually we're in the current implementation) since no parent node
> > > to telling the identical implementation informentation. Add a
> > > root node for indicating this.
> > > 
> > > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> > > ---
> > >  hw/acpi/aml-build.c | 15 ++++++++++++++-
> > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > > index 560cee12a24b..3010325ca423 100644
> > > --- a/hw/acpi/aml-build.c
> > > +++ b/hw/acpi/aml-build.c
> > > @@ -2153,12 +2153,25 @@ void build_pptt(GArray *table_data,
> > > BIOSLinker *linker, MachineState *ms, int64_t socket_id = -1,
> > > cluster_id = -1, core_id = -1; uint32_t socket_offset = 0,
> > > cluster_offset = 0, core_offset = 0; uint32_t pptt_start =
> > > table_data->len;
> > > +    uint32_t root_offset;
> > >      int n;
> > >      AcpiTable table = { .sig = "PPTT", .rev = 2,
> > >                          .oem_id = oem_id, .oem_table_id =
> > > oem_table_id }; 
> > >      acpi_table_begin(&table, table_data);
> > >  
> > > +    /*
> > > +     * Build a root node for all the processor nodes. Otherwise
> > > when
> > > +     * building a multi-socket system each socket tree are
> > > separated  
> > 
> > is separated
> Hi Michael,
> 
> Happy to send another version for this issue, or maybe you can
> fix this when pulling, if that's the only problem? Up to you :)
> 
> Alireza

resend pls.

> > 
> > > +     * and will be hard for the OS like Linux to know whether the
> > > +     * system is homogeneous.
> > > +     */
> > > +    root_offset = table_data->len - pptt_start;
> > > +    build_processor_hierarchy_node(table_data,
> > > +        (1 << 0) | /* Physical package */
> > > +        (1 << 4), /* Identical Implementation */
> > > +        0, 0, NULL, 0);
> > > +
> > >      /*
> > >       * This works with the assumption that cpus[n].props.*_id has
> > > been
> > >       * sorted from top to down levels in
> > > mc->possible_cpu_arch_ids(). @@ -2175,7 +2188,7 @@ void
> > > build_pptt(GArray *table_data, BIOSLinker *linker, MachineState
> > > *ms, build_processor_hierarchy_node(table_data, (1 << 0) | /*
> > > Physical package */ (1 << 4), /* Identical Implementation */
> > > -                0, socket_id, NULL, 0);
> > > +                root_offset, socket_id, NULL, 0);
> > >          }
> > >  
> > >          if (mc->smp_props.clusters_supported &&
> > > mc->smp_props.has_clusters) { -- 
> > > 2.34.1  
> > 
> > 


