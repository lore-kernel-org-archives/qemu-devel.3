Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4A0C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 11:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZqfG-00020T-WD; Tue, 13 Feb 2024 06:09:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZqfF-000207-Qm
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 06:09:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZqfE-0007nb-0F
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 06:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707822563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FVTfp0hjf6tbmLRdvNE0osBJnT72ZZTj1q2/0hjcaDM=;
 b=hl1ukN9taIEQ90iS05gSQEM1hYIob+6oPXUJ6la2hAvXJlogb1h2nvoA1Kg7qDl1qm0jM6
 YZ7dJtFGtYEAm7OdHErbnt8qYH1H5YmA5rXw5f/K5+/b67ZdTrw+UvpCev6UVi4Akp7wfv
 tl/FqVM9ELbDjUWMfBf9bs1CIcGXJH8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-5AB5Np80OzaABgzIGJzpVg-1; Tue, 13 Feb 2024 06:09:21 -0500
X-MC-Unique: 5AB5Np80OzaABgzIGJzpVg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a2fba67ec20so278216866b.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 03:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707822560; x=1708427360;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FVTfp0hjf6tbmLRdvNE0osBJnT72ZZTj1q2/0hjcaDM=;
 b=oMv/27D8mao7qCQ4tp9dT4M4dVwFc9lXI1dFeOV6/E4hYuOhjQ64I6JWcEeohpevhp
 FyzCJABASPjj2uCgoPxDXcrGfLFNRWR+BwxP3riRENoAHw1edTICvKjyARCcsDhyXm4Y
 x/de9eTNmwBvGUPEVR/6Vm9qMEIyBCePgFp+1mjxUOJQ3Z+t4C8w8gbswmfKijyUJWZr
 shYcCNzOYqW+dc1SuYZmJKOyjQqVQn2nMcpwdZiOrHl+1kRNzK9VmTBw+1Q9tzfJiTqM
 UIOmdVDTessNdpbZToAhZSNb5RDAo3Fmr1dTb5p86gDQhKtVq47R6gcrkZutvCObCl0j
 /kGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWV9lfaTvWy7bJjzQhnWsY8JDFqn+2TP6rLpysb3N2UPZnyl1vu9XU7z9s7FiJbeklvcrl12ChGebrDAsFXHbbVA3sjnQE=
X-Gm-Message-State: AOJu0Yy/TLBnzvgCzVQyPsjK20kZzCh7E982tBoQ5G7NvlWMTNV9dASU
 NeTGUMFQ85Jiqxsx8rzyGzOboNjFLSVpSSeE6h53rHJb9rlzUP37v7VPFECcastcOU4KZJr0HB2
 snhALInJ+PdFFkUY5zjUxPsjLKh/fCrQmw0Fl9rM2UvzFeYXJByPQ
X-Received: by 2002:a17:906:b291:b0:a3c:8120:898d with SMTP id
 q17-20020a170906b29100b00a3c8120898dmr4686097ejz.72.1707822560548; 
 Tue, 13 Feb 2024 03:09:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTAeuXsZthZ/I/KevoaS/aDh2Hmktxlu4VFoC83RkDlu3YB2ZRTZUy+IfTvcMd3L12koX2LA==
X-Received: by 2002:a17:906:b291:b0:a3c:8120:898d with SMTP id
 q17-20020a170906b29100b00a3c8120898dmr4686079ejz.72.1707822560232; 
 Tue, 13 Feb 2024 03:09:20 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWRyg8YXvjYPUpEeudgmDAyV036gzdArX1WgdUajuHWNg4XaOZQaZyKZ4/GnfeARTKbHQok3iy2gfhvzR4bA/BOkSbhV9ZzlL7mgnYys27VglnXHPaGqsnCTdErOEH6Ha8QiU13WgpSumUwVNJ+Lb6e2GhEoar1MBk3njsdHXlgUBx2ztpI8m83AU/i0zZJnvk1RaFZU99/QYq9IpXqUO8fzRYgMBaUv7SLbJFC9Tq2ifU8a8LRZ5jdSIw=
Received: from redhat.com ([2.52.146.238]) by smtp.gmail.com with ESMTPSA id
 qo3-20020a170907874300b00a3d03a5f7acsm498854ejc.65.2024.02.13.03.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 03:09:19 -0800 (PST)
Date: Tue, 13 Feb 2024 06:09:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, alex.williamson@redhat.com,
 clg@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH v2] virtio-iommu: Use qemu_real_host_page_mask as default
 page_size_mask
Message-ID: <20240213060731-mutt-send-email-mst@kernel.org>
References: <20240117132039.332273-1-eric.auger@redhat.com>
 <20240213044312-mutt-send-email-mst@kernel.org>
 <6d4b5766-f8e2-4889-827d-01d3509239f7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d4b5766-f8e2-4889-827d-01d3509239f7@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
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

On Tue, Feb 13, 2024 at 11:32:13AM +0100, Eric Auger wrote:
> Do you have an other concern?

I also worry a bit about migrating between hosts with different
page sizes. Not with kvm I am guessing but with tcg it does work I think?
Is this just for vfio and vdpa? Can we limit this to these setups
maybe?

-- 
MST


