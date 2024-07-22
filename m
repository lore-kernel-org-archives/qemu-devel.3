Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7217C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 19:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVybo-00076h-1c; Mon, 22 Jul 2024 15:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sVybl-0006uq-FD
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 15:22:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sVybj-0002KF-NN
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 15:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721676120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=az+ZYad0JlSF4o0p52hP3yF2V5gU3YmkATYXFG4NPXI=;
 b=PLLq03MN1bPbXJES5Fz/n90WTzr8tcSILeDW77TczE9xmvJEOtOZmrgVWJ6cpHusNJtp1s
 9wp5cawacjWBvZm3nr+itY6YdRKpC1KPiEP36ddqdYLHbZS0i4wNB4tc7Ki4ronSs+kXEU
 25prIrtxjCROd2xOiuKpsrEkKP1bs5g=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-LobtzRIeNIafBkitZ6YFHQ-1; Mon, 22 Jul 2024 15:21:56 -0400
X-MC-Unique: LobtzRIeNIafBkitZ6YFHQ-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-25e65d02dd4so995732fac.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 12:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721676116; x=1722280916;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=az+ZYad0JlSF4o0p52hP3yF2V5gU3YmkATYXFG4NPXI=;
 b=r3pdImuT4P7JIokQZsxJ8vJoWgA2QNWCm8uUmG2C8X3b+QezCqDkLy7Tj4BqZXy9md
 CrwACReSQnQ5nZ5RQ6XGsY8aKDt1ILaY9nO4EwL15qScCcnXiTgvwEUaTgAUCzMVAnpa
 Sj2+fcBaMzFrZEB18rCa+w1J2FRRDyLhNravON1omXm98MBs+7QF11B+I3d8hCoUcsAL
 eq5NDHA+Vrw+ZbDq/NkHUNXmXHB3t/U2YNcN19RTlPY0N33I3V3bw3bJX5LegmiuCuAU
 9NwHlofjaJoTVEeeXLMMaapF/+jaG6GvGnSPn5sxklZHk4RSWny8NA/pNpZYvaZBDYgI
 b/ww==
X-Gm-Message-State: AOJu0YzyGPiTa5mKMbMtwXESa9e+efV1Zp34PA5sTGD0RLsK1GOZxaob
 K2PKG3ZMtQiozms6+O5wWbsa+2JwUBKHb2N+ngzNfPeKn6ONaXcSeymByO7aPf8JHTwouL4xzoV
 Hb3P6y5l/kwv6qy9anS9ZNqT5VMQ5T3ixlBJlzY5HR07AlvggMdup
X-Received: by 2002:a05:6870:858b:b0:261:b94:b0b with SMTP id
 586e51a60fabf-2612130dca6mr4943586fac.1.1721676115972; 
 Mon, 22 Jul 2024 12:21:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUsO+tji8/E/o5dle5gkfRbS9IWI9SXxKyRgHCYAv9DGqLVupNfvccKgS/R+BgdZ9QmCoVIg==
X-Received: by 2002:a05:6870:858b:b0:261:b94:b0b with SMTP id
 586e51a60fabf-2612130dca6mr4943580fac.1.1721676115690; 
 Mon, 22 Jul 2024 12:21:55 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a199074501sm388401385a.113.2024.07.22.12.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 12:21:55 -0700 (PDT)
Date: Mon, 22 Jul 2024 15:21:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH v2 2/9] migration/multifd: Pass in MultiFDPages_t to
 file_write_ramblock_iov
Message-ID: <Zp6xUc4PzTi3pkf0@x1n>
References: <20240722175914.24022-1-farosas@suse.de>
 <20240722175914.24022-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240722175914.24022-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 22, 2024 at 02:59:07PM -0300, Fabiano Rosas wrote:
> We want to stop dereferencing 'pages' so it can be replaced by an
> opaque pointer in the next patches.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


