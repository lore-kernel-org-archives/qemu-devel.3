Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD37E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNazy-0003dk-1l; Tue, 17 Dec 2024 12:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNazv-0003bC-Jj
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:04:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNazu-00011l-6T
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:04:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734455076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YnjZtAgbupA44rfkx4qZzshAWyP8xsG5EP/DM6mN3Mc=;
 b=GCxSAQjnjMBSa+G2dWcrD/L9clRCehyKvKZwvZxWMagxLi+1Ai/swZEbF1lzCz1pHqfPKE
 i9Nm2w4yhcwMOT9rri7bFDovLU1FIwj2ZvBZC51N6t0TbIza+pV+iDPW1HCH1qLfa0LYKt
 so4+y5yKpK2v+pE+pYGm/xiFbBZs2Qg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-gyzTJKaFMfaD6Q324KY-uw-1; Tue, 17 Dec 2024 12:04:35 -0500
X-MC-Unique: gyzTJKaFMfaD6Q324KY-uw-1
X-Mimecast-MFC-AGG-ID: gyzTJKaFMfaD6Q324KY-uw
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6dadae92652so7410006d6.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 09:04:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734455075; x=1735059875;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YnjZtAgbupA44rfkx4qZzshAWyP8xsG5EP/DM6mN3Mc=;
 b=MKk6BDfRHZHp/3ao73BTJOavitHWMhWg1PkPwP7/GcjEc7GpxHZIoV7qsW/+unbfC4
 YpMRDsq4ovGyuinmeaHGBaZn3O+Hxkd5J8poF7OFjV3l/08o8agHqGnb7iv0yIGwN1Lr
 dZQQpXh9rLrNzqEAe9dEjkHiSnrQdzxN82qJ8SZJKyIdYROPU6NsVu64P7UiGLazWRbJ
 3dbwubHcjhwtuQWOeVhZUEvs3COE30tmdRVJa0Sod3R2Rg+ulNP5zbXYSUrf/S01ArVk
 TDcIPn4dsQ+cZAWIqC83QtrH02TOC5cRDjgEdnR/lQrVcTwOBpQWTJ1yxcI06U1E5lp+
 DB7A==
X-Gm-Message-State: AOJu0YwmWHg97uHgIhKrE50YfIyZdQCH8ujyShO/eCB9817Dulua0ZrP
 C4UgqzV0/UG3jBBCuSJ5/KmTi0l0hs2toDw/MUaxvFNJFcFS9g6OdNk24QWMi8AowYyJ2/0neqU
 k761Rjou7od5k0ig+aAgGaBVm/B4MdZUR4NJVxxqBReYmu47rIQeB
X-Gm-Gg: ASbGnctAty9GT+6I04n8GqFsz0ZEIXYbyha++Ya+bP5u4ICAFhDkj7yId5yS8nLa6hA
 3mg2sqGwplc/79eDUv35+X/bvP9vGCT9EH/uf2tdxXm1u9Z04hrMjL9luCPjb0zqhXnA280xz+/
 zFbuSoiea0vDdRKydCHZsa0EuRJq3uloHgvCN87Z/G+3+79loUJrnzDYnKnjqalL7z4jC6GJC5c
 8uE1YDM8NkYC+n7QWy65uJqi9oWMF+D4PpmyXDYwlMrDnV1TI+1WEhh9+w+eGkjxYzcZT2CtMah
 WRWEegeOGi7HWR9m+g==
X-Received: by 2002:a05:6214:1d0e:b0:6d8:846b:cd8d with SMTP id
 6a1803df08f44-6dc8ef18b11mr240135046d6.30.1734455074248; 
 Tue, 17 Dec 2024 09:04:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBNUsgfpNLO2eLwAK5O4XvSJjK3BH6uQJlAJalwfLJPyvcoBbLg8tBsxBTl/IIAtauwoIupg==
X-Received: by 2002:a05:6214:1d0e:b0:6d8:846b:cd8d with SMTP id
 6a1803df08f44-6dc8ef18b11mr240132486d6.30.1734455072353; 
 Tue, 17 Dec 2024 09:04:32 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd26e4f8sm40997606d6.67.2024.12.17.09.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:04:31 -0800 (PST)
Date: Tue, 17 Dec 2024 12:04:30 -0500
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hyman Huang <yong.huang@smartx.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH 9/9] migration: Unexport migration_is_active()
Message-ID: <Z2GvHkKfHqyCkUie@x1n>
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <20241216094638.26406-10-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241216094638.26406-10-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On Mon, Dec 16, 2024 at 11:46:38AM +0200, Avihai Horon wrote:
> After being removed from VFIO and dirty limit, migration_is_active() no
> longer has any users outside the migration subsystem, and in fact, it's
> only used in migration.c.
> 
> Unexport it and also relocate it so it can be made static.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


