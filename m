Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98751C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 05:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWrN4-0002DT-TG; Thu, 25 Jul 2024 01:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWrN2-00023d-6v
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 01:50:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWrN0-0004cu-Eu
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 01:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721886629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dw6uQuUxLbJLguecojDbP9dDqrgxsjavWZI9IVHv/Iw=;
 b=Da/dog/JgBpA4Z3xF+LpT7UoZJnUfTvEiNZmNWFT2d7rL0DwiZxtbFjXZ+UwLJ0pM9rfDu
 V58bBHf4gn0vUpPgR8MMcG9OOREsuYNG6jvsMbfZQfjiioGDIp+wInU/t6mXbmyniL6t2k
 0+ygUVGZyLcsrdJpGLZ5oz04QmvCy70=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-VgD8ZWZ7PdiXAr7UBbP4bQ-1; Thu, 25 Jul 2024 01:50:25 -0400
X-MC-Unique: VgD8ZWZ7PdiXAr7UBbP4bQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-427fc86aaa2so3790775e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 22:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721886625; x=1722491425;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dw6uQuUxLbJLguecojDbP9dDqrgxsjavWZI9IVHv/Iw=;
 b=neD2N7mc1VEwz9zzprAFh3WQeMBZsd9sh4bKKoVcdysbvat54Z3n8nX2vqrPgXuN6l
 zLWyiLL+TLUtQvsdBf31NQtxCtqQVSCzkRHLEsv+qZCXZK9kQ2FkRl2k6zYsS6J22pL6
 nkLvt3xCXGleGSdnU4sYysChh2JhnODxVP2KQuy8oWf+dfejFI0OzdI1sgViOJwiR6Lr
 /Xw57FwJhjwAKpnsAqMAtUnBHoEO+sd1YMc6FxQbEecZHWx2jntD/8x0i0AV3bDzJIHy
 vqLsYIm+EwydNrH6p+w66e5KyRLlSecSs4s9Hmowdaakmjp9u4wxBKx7V2+5C1aNWe8x
 ozXw==
X-Gm-Message-State: AOJu0YxvLmr4c2wXO2G8kDRYEj/3DYxCBNgmuPa0o0V9T24tbvnghZgR
 a6UGWc9ikN2GcaVIjAmY+H0/jpYD9klJU/ko+rFfUZYNEJrs5L6dDruhcQ9mNkMFMOGNtm1Ipau
 b5c4lzmGOGNX/l5q4YkcBerT7Tz2gVKTaRyAwWiKtGTZMs22nPcOB
X-Received: by 2002:a05:600c:350f:b0:423:791:f446 with SMTP id
 5b1f17b1804b1-4280546de1cmr7583775e9.7.1721886624771; 
 Wed, 24 Jul 2024 22:50:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsogcgHGZNLvjQlO9cOD7WCrHLOFGPRIpIXfV/slhV6V1mQAXsrwH0jSqmsGOmg2bUA0PeQA==
X-Received: by 2002:a05:600c:350f:b0:423:791:f446 with SMTP id
 5b1f17b1804b1-4280546de1cmr7583585e9.7.1721886624068; 
 Wed, 24 Jul 2024 22:50:24 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ed:8427:35e3:731c:3106:ee46])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f93e65a7sm58688855e9.33.2024.07.24.22.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 22:50:23 -0700 (PDT)
Date: Thu, 25 Jul 2024 01:50:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Hilber <peter.hilber@opensynergy.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
Subject: Re: [PATCH] hw/acpi: Add vmclock device
Message-ID: <20240725014905-mutt-send-email-mst@kernel.org>
References: <b2c50884f0a6992edec5d7d59626702508369cca.camel@infradead.org>
 <20240724132727-mutt-send-email-mst@kernel.org>
 <a3a9e8381a71ae745b25476d4793d89e1e9e4360.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3a9e8381a71ae745b25476d4793d89e1e9e4360.camel@infradead.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 24, 2024 at 07:45:31PM +0100, David Woodhouse wrote:
> On Wed, 2024-07-24 at 13:29 -0400, Michael S. Tsirkin wrote:
> > 
> > Isn't the existing vmgenid sufficient for this disruption marker
> > and if not, why?
> 
> No, VMGENID handles snapshotting and cloning of virtual machines, but
> it explicitly *doesn't* change on live migration.

Ah, good point. I note the marker will always trigger on
a snapshot though, so there's some overlap.

-- 
MST


