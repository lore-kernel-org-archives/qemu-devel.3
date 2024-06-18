Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2132FC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 21:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJgTZ-0001dF-Ng; Tue, 18 Jun 2024 17:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sJgTY-0001cZ-GO
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 17:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sJgTW-0005T4-8g
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 17:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718746485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tE+y97XjeYUfKcRWRfZSEd+rIxwx/BjPMRUmQb3/emk=;
 b=NEZbjAVKNXjex6bbCK8AC+tRW/iu95shhahqadYzMw0cTlfIN8+z6gOZvMyXRpkwoPnsvN
 Je2qvni5xm6auSbt64TdkEaHQ5TpzYpFlQlTeub7G3ZWBfD6f5Nzp5gF9CcMbC71rl8fae
 shongYpkLpIY87taJHF9r1wJM4SpvMs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-isL_nyJVOTqGmKcksl3hig-1; Tue, 18 Jun 2024 17:34:42 -0400
X-MC-Unique: isL_nyJVOTqGmKcksl3hig-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4212a3ddb6bso45198195e9.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 14:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718746481; x=1719351281;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tE+y97XjeYUfKcRWRfZSEd+rIxwx/BjPMRUmQb3/emk=;
 b=OhV/z1ru95RZIDixV2C/foxOrJgqojMCv15miEmw5bIxBhhGUxDoaDvdv7BiaATTz5
 CsQpDbgXGwTM84GTzryyNRsT0AtD7v3x3y3B6P0MzwO4ZCSMhCWFXyVLT3TjTpkM4XEr
 w0hYK1ppbQdNLxIIgWqQIMJH5xr27/XXRFEld1Q2X0UR86t31I+V6C9bdWxx76ufIcJ2
 XqvEeJ8k3OEc1PtFzOCVbbUVK3kDajMtWmMmCNm20RCuRUWiE9ntzJ0Z4qIHWHNLGNDM
 CkiGWBmPWFEy1x/DoMQ7uysniecol5V2T6PH0zHmGGNCa2VicOe8+Vf3ltFGYB/dYn8H
 I0+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVgvf2pE5wbX0UcBzfoL/pHVYC5t/rj49qynas2xjXwuMtMTm7IdQrU3/yIorOI7FOgrC2MlNuAwqAgqB4NvjTTZk/PIg=
X-Gm-Message-State: AOJu0Yw0/ZyzN9Bi9eufoPXtocVHRXOlHfD4DmuAa0kIBpKj0ICuOnQ5
 LEqQ/ZQLQtzzcd16+DFLYMSKJFyK1A7XRTjbPPbUWuwTjqXI+DECaeE9sovT5Oy9HaUBefiYZrr
 rco+yGGMTaW21qx0SB4bEA9QfA8RGp7Ub6NUvayFyQCUNoxdeQq9S
X-Received: by 2002:a05:600c:4f41:b0:421:cbb8:ca7d with SMTP id
 5b1f17b1804b1-4247529b36cmr4740445e9.37.1718746481175; 
 Tue, 18 Jun 2024 14:34:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH71jRUFIKxkcPD/TmID70gKbH8X3XWdUvWHgwHvFXZB7q96BVJrVlj3MaAIpY+KItMPnplLw==
X-Received: by 2002:a05:600c:4f41:b0:421:cbb8:ca7d with SMTP id
 5b1f17b1804b1-4247529b36cmr4740355e9.37.1718746480595; 
 Tue, 18 Jun 2024 14:34:40 -0700 (PDT)
Received: from redhat.com ([2.52.128.219]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3607509c906sm15184489f8f.39.2024.06.18.14.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 14:34:39 -0700 (PDT)
Date: Tue, 18 Jun 2024 17:34:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: peter.maydell@linaro.org, wangxingang5@huawei.com,
 shannon.zhaosl@gmail.com, imammedo@redhat.com, anisinha@redhat.com,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3] hw/arm/virt-acpi-build: Fix id_count in
 build_iort_id_mapping
Message-ID: <20240618173233-mutt-send-email-mst@kernel.org>
References: <20240618211110.922809-1-nicolinc@nvidia.com>
 <20240618171311-mutt-send-email-mst@kernel.org>
 <ZnH53Qaqp5+Xo1jo@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnH53Qaqp5+Xo1jo@Asurada-Nvidia>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Jun 18, 2024 at 02:19:25PM -0700, Nicolin Chen wrote:
> On Tue, Jun 18, 2024 at 05:14:32PM -0400, Michael S. Tsirkin wrote:
> > > @@ -306,8 +314,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> > >          }
> > >
> > >          /* Append the last RC -> ITS ID mapping */
> > > -        if (next_range.input_base < 0xFFFF) {
> > > -            next_range.id_count = 0xFFFF - next_range.input_base;
> > > +        if (next_range.input_base < 0x10000) {
> > > +            next_range.id_count = 0x10000 - next_range.input_base;
> > >              g_array_append_val(its_idmaps, next_range);
> > >          }
> > 
> > A change of logic here - I think the new one is right and old
> > one was wrong, actually. Right?
> 
> Sorry, I don't quite follow that question...
> 
> Doesn't a patch correct an old wrong one to a new right one?
> 
> Thanks
> Nicolin


So if base is 0xFFFF what should happen? I think previously we
skipped an entry and that is wrong. So that's another latent
bug this patch fixes then?
Worth documenting in the commit log too.

-- 
MST


