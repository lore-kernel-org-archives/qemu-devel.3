Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A66C10F1A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 16:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2D8R-0004jq-0L; Wed, 01 May 2024 12:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2D8O-0004jU-Ri
 for qemu-devel@nongnu.org; Wed, 01 May 2024 12:48:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2D8N-0002wl-BY
 for qemu-devel@nongnu.org; Wed, 01 May 2024 12:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714582122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W0rqb1II+fEQyts8xj8PiGw705f1XoyimiMNElU/2to=;
 b=dWFocAyQ1uBJUXpMQXUM+Lr7o8SeePIgi/KB9n0gsaALVP0+jy8KMyEWrQ0SK9nYOiIpf0
 RbOAtGkrVBm6ftwEe5yHaM47sxzyWuVNDdKOnVP/ITId8LHD95gvvokp6wKsz1IICBtsHo
 M72l5Z1e0NwEzNzzsgJ9gR+yeC5f9Pg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-1MJN5om4PbywXoZDCyXdTg-1; Wed, 01 May 2024 12:48:39 -0400
X-MC-Unique: 1MJN5om4PbywXoZDCyXdTg-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-43a3632d56aso28221491cf.1
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 09:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714582118; x=1715186918;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W0rqb1II+fEQyts8xj8PiGw705f1XoyimiMNElU/2to=;
 b=KH3CaFn1LlJ/ok2xk9uK/kr7bpBgaCUIAKc3w+Tdj4Hpxm3hGon6ESYuWVVH3gk1+8
 OnKuTYloT2fMToGgsyHmISRQSG1tlcuLrL9c4H0R7GCTV8YdG1B/CqnvS9mbYJ+7izLY
 XJcCsD8+N0mL5E+tya9YNSdNVoZInuV18cyqhmd+cDET5t1vlzJ2G0tok1i+nmCUGG8h
 g2dYMkH5AHj6P9r5VtGCJgtiqvHYExGQhWEhVlcxkZgVH02pDkxASv1E7KaIsapYe4nZ
 pIVYyvMmCKmDvX4bl+GVAtxP/13xr3zPUrh/Aa8UbwhYbnWa7TVnAe/sfxDj7vXXXc8B
 asKg==
X-Gm-Message-State: AOJu0YwzcegrWEFTinQy9BHaihIncIfmKcko7KM5iMnq1IHYb4BpXA5X
 TagXT/ZVLUxS5htbMshorFnWOJRrZ3Dz58zZ/lz6CIvZqJlO7kBddzbJJRaVbA9s7yxFryqxrTj
 xtdqCwbLoe1Ihu418GVRwzEiKBnRkDy2ri/i8y1ZkO8RCZLGplgsB
X-Received: by 2002:a05:622a:454:b0:43b:e8:3858 with SMTP id
 o20-20020a05622a045400b0043b00e83858mr3335561qtx.5.1714582118215; 
 Wed, 01 May 2024 09:48:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlczwLQ1ydCbZMNGW1G2sQPdaOKLA7HRYhsgku2nl0OuzRoK0kJ+YcZfu1hxBiGpLYl+M3KQ==
X-Received: by 2002:a05:622a:454:b0:43b:e8:3858 with SMTP id
 o20-20020a05622a045400b0043b00e83858mr3335525qtx.5.1714582117703; 
 Wed, 01 May 2024 09:48:37 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 h2-20020ac85142000000b00439a1bdb6e5sm9468549qtn.17.2024.05.01.09.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 09:48:37 -0700 (PDT)
Date: Wed, 1 May 2024 12:48:35 -0400
From: Peter Xu <peterx@redhat.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 13/17] softmmu: Pass RAM MemoryRegion and is_write
 xen_map_cache()
Message-ID: <ZjJyYzr-Qq9Y71BM@x1n>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-14-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240430164939.925307-14-edgar.iglesias@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
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

On Tue, Apr 30, 2024 at 06:49:35PM +0200, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Propagate MR and is_write to xen_map_cache().
> This is in preparation for adding support for grant mappings.
> 
> No functional change.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


