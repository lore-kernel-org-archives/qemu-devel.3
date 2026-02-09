Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C497E81BD3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 17:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpUit-000065-HH; Mon, 09 Feb 2026 12:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpUir-00005d-9f
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 12:06:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpUip-0003Mc-31
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 12:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770656809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OxOHR4p2BVGtCNrQdx8JejZUsXyh8RXfrIbb5ULfQmM=;
 b=hZGaPSy7zYQRTu63zXHYstW6RVSiBXKQnEsLIeEZuK7o2T69wIlz17yiYgDiBATsSLrxfB
 jBMkr6kXjTbdsoZb4oEs7qXgB1FqRXEEmEniw/FykuDgWTLCF1uJBomNFdxM/DR3hBnSNj
 jGpnST4LEH598hQ4iknhN0JNPuOYPq8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-ONxTZwusMNG496Hd7CQiBQ-1; Mon, 09 Feb 2026 12:06:48 -0500
X-MC-Unique: ONxTZwusMNG496Hd7CQiBQ-1
X-Mimecast-MFC-AGG-ID: ONxTZwusMNG496Hd7CQiBQ_1770656807
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50340e2b4dfso208664251cf.3
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 09:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770656807; x=1771261607; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OxOHR4p2BVGtCNrQdx8JejZUsXyh8RXfrIbb5ULfQmM=;
 b=Qt2ocXSee3UPnUEbH8ncTJS0fh7tyPLcXcfCIHrHWyzJ/rMo+pbCyp1c9/F9PNQmRV
 Fdgrv110ysugrkKpwrAsSeW/xUgL9sUGYXNxqtEJsxmmzxWAvRfBnFNNznZSFcyqEjsy
 gn4CfcI8kwjVkdtuvXpgoyHVm/BYgrC+srnffYRkSMyuYzgkprrOFC37AobdyTrikdjC
 jjXcuw6+gQyTMovvtHj29uV5JriyIujS07DGk3vcraQs0bXe6+H/16kS38Sk+hQpHDCd
 5G74b5yI8Lx8Zz5/18a/z8EiHNfQcZMoCFiYxI34uykkIt3l0srgQpevYYKxHUQ2l2Qg
 Ua6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770656807; x=1771261607;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OxOHR4p2BVGtCNrQdx8JejZUsXyh8RXfrIbb5ULfQmM=;
 b=xMma4kEMFUj6TMujhFu4dNirU9IN+TFsf+Xzz76Kd0J2ya9TsY0OAz5Rfi9dcJOg7b
 Pgx1EMMYC/E2nVxkJzXpbFYYXxJlj7efF/rj16C2HYQJzl8xkjIQIuiPCapY5bUD/PQz
 /bq7kHc2ae9fMFt3/qe18909N9h5+Vis9oYF0T09IBLfGNPZPitQzE7iYPl9ajCK1Bt2
 lRO1W4UafJ6GxOafZQu0ufUy+0ryfPvZrxsC3ckv797CEkdXNlaFgg2F9uqoSQ8anAIP
 2bd43cl//5iLz/4kFLFndQSOMA8sKgwHmkUCBXivELzUvCwgQJpM2RuHCcH6ZIKd9xEm
 0JGA==
X-Gm-Message-State: AOJu0YzxShyP6ZXjYmF1+zLvo6dS9NhCZ1TuSEIuinkUWpZEeeu4XNHD
 KnhPRnMkLIAEppA7NzzOvho8rov6jq3S3JKdOMdxDT2hvEryYs3cqEyYCp4UZtx7nYXdaDYLhUJ
 oNU2WGk9HpPE9WcWTuYhay8YqahmHW2fDQAdLOaQJaedpvF4eXDEjq5M5
X-Gm-Gg: AZuq6aIDZI5kEkm5yR5ENHoOPqP4xnwnnCT3hE1SHUvqFqY6XAYwLWRw4Cc4AFpcoJ2
 LSf2gvmw8CLVpwy0rtTSrIUQmDzf8UUAv90YZIeqJfWrTk6BYWGZmhen1EiL25tv+LiRVbkrtIX
 P67E0vU05dupKHaWdzfWV5bgBbK4idsrEqodzaG8KkXzMJ/PxtZxWwak6sgcejE9Sw/yUH6Mqvo
 Ej0ldgwfiYGSStb/0zIzHxOamBB0QykCq+t257kKJ8G5AqNJU3E9B/heauJmCuCdr6fDa1KVkhr
 HIe9XRMxALLaUNqGPXc1UlhVa4b+rMeb/CQKjuFMuGHg14JGAc5St86juIuIAXlUf2OrWRGwZBW
 cGCU=
X-Received: by 2002:ac8:7d42:0:b0:501:458a:9a45 with SMTP id
 d75a77b69052e-5063988b5ddmr169872201cf.30.1770656807372; 
 Mon, 09 Feb 2026 09:06:47 -0800 (PST)
X-Received: by 2002:ac8:7d42:0:b0:501:458a:9a45 with SMTP id
 d75a77b69052e-5063988b5ddmr169871701cf.30.1770656806824; 
 Mon, 09 Feb 2026 09:06:46 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8caf81c118csm879534885a.24.2026.02.09.09.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 09:06:46 -0800 (PST)
Date: Mon, 9 Feb 2026 12:06:45 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v6 13/18] colo: Do not hold the BQL while receiving ram
 state.
Message-ID: <aYoUJZHVxohmEPhI@x1.local>
References: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
 <20260206-colo_unit_test_multifd-v6-13-27779dda139d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260206-colo_unit_test_multifd-v6-13-27779dda139d@web.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Feb 06, 2026 at 09:03:11PM +0100, Lukas Straub wrote:
> We only receive ram into the colo cache here and don't touch anything
> else, so the BQL is not needed here.
> 
> Move cpu_synchronize_all_states() downwards, before we apply the received
> checkpoint. It turns out that qemu_system_reset() already calls it
> for us.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


