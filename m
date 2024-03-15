Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0C3C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 15:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl98r-0000iY-6F; Fri, 15 Mar 2024 11:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rl98o-0000iI-NC
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:06:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rl98m-0007Dv-8d
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710515194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HJJC9+w28vo93svvTIpK1Wz/d1hFrbdoBDpDC8zoys8=;
 b=XeS+LWbzE5ouNEVxNLVBwlb+78+mV0OBxfG1SgJVU/ID+cNHYJ76i84LJmCThPYOWCGVOe
 /pKHrpjONSjQF7L73tYmSnU6eUEwkwHxY1z8Ofav7FTRJvWblok+hYfOyuDQ3OH3QPD8oW
 TnCOvbQuFb1eISJNTu1tLP/7tdmpGX4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-I8yaw4y-N3-PKIEQGVR8Dw-1; Fri, 15 Mar 2024 11:06:31 -0400
X-MC-Unique: I8yaw4y-N3-PKIEQGVR8Dw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6912513fc7bso11645976d6.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 08:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710515191; x=1711119991;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HJJC9+w28vo93svvTIpK1Wz/d1hFrbdoBDpDC8zoys8=;
 b=RW+JOjzKU3kkN7TRtCPMOWORDkWP2wsFoP66j86/7vKiNjmR2juALrs+CIFR0uPgNz
 rvvRkJETIW7aiaVylvu9SV9AsvdbuojH2PcC9cM6jwRt3UDVZtJ5So1Mt6dD/1NXQqX9
 mQp5b7nLnT7X2lRGskR1gxPUkA6VsAVM1RqRGNh5/+53EVsUQc7wUI+9ZeDOotKdJaKg
 6HZzKAHqNY7xnglnJog8AUPvp+DLaNjP2TWFqtX5EJ/mpgE4dcwRyyIJFqSls3vsKQcw
 bKZTt5WJZ0AqvMKxRE95MWFu73rCoZggL/0Jq1mC4df8GwJc7CmJYHOjGnuqDsGdb3c8
 SkCg==
X-Gm-Message-State: AOJu0YyEWv+Qp6MmkynYvaHgVlfve10MJE6e0DLDODRgsilroJ4zhkx8
 vyCC8/VkxRQ6a/eejhsLXwN8Xpsxv05AnXduh1hXfDtTheZRIbKEnnjaZF84jTi9BJGGYv1Iydm
 PXFWOv0cBb4zqXmYU0SzeZMlOLnJz5RyLrkVeWCGVWjRm8Vhd/kzm
X-Received: by 2002:a05:6214:459e:b0:68f:1c80:d78e with SMTP id
 op30-20020a056214459e00b0068f1c80d78emr5467231qvb.0.1710515190922; 
 Fri, 15 Mar 2024 08:06:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk4eAIspw800nMvLXvGlyMxwNQE3jzY91Go/m7/aXK7hwL5RnAj0wMewYVZ32HYzYGpghIyA==
X-Received: by 2002:a05:6214:459e:b0:68f:1c80:d78e with SMTP id
 op30-20020a056214459e00b0068f1c80d78emr5467206qvb.0.1710515190573; 
 Fri, 15 Mar 2024 08:06:30 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 t12-20020ad45bcc000000b00690d2942caasm2098421qvt.20.2024.03.15.08.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 08:06:30 -0700 (PDT)
Date: Fri, 15 Mar 2024 11:06:27 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 22/25] memory: Add Error** argument to
 memory_get_xlat_addr()
Message-ID: <ZfRj8wIfmJIcpQyM@x1n>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-23-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240306133441.2351700-23-clg@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Mar 06, 2024 at 02:34:37PM +0100, Cédric Le Goater wrote:
> Let the callers do the reporting. This will be useful in
> vfio_iommu_map_dirty_notify().
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


