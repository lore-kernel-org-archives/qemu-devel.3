Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EC8FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 19:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKLb1-0007tE-2p; Tue, 05 May 2026 15:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKLaz-0007sn-LT
 for qemu-devel@nongnu.org; Tue, 05 May 2026 15:38:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKLaw-0002fc-So
 for qemu-devel@nongnu.org; Tue, 05 May 2026 15:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778009892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Ug1IGAtqWfSRxIi2kUED0xqx7x/JlYhdoNCN8Nz0Vs=;
 b=SEI9xE4o5Vcan5kJ02CaheCGZJyHOzBhWzTZQOPEWj9LOUBJa9Xi5snqNTGQpiWDvYxb8Y
 0af0rfqayj/TSdq8jBa+oMPfOLqd1JoXGpaj+d9KZj2jlh1IlbZnb7TUjbbJ5CRrG0MNMq
 SLpsWKUUa4ZfjQyYFSwT+nnJs8KAQI8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-B3eFh9kjMGmDbqAZCNirLg-1; Tue, 05 May 2026 15:38:11 -0400
X-MC-Unique: B3eFh9kjMGmDbqAZCNirLg-1
X-Mimecast-MFC-AGG-ID: B3eFh9kjMGmDbqAZCNirLg_1778009891
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8b5ceedb5c1so94954606d6.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 12:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778009891; x=1778614691; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8Ug1IGAtqWfSRxIi2kUED0xqx7x/JlYhdoNCN8Nz0Vs=;
 b=qLYpqyIvPmJnLrYBT+tuAUUYkV0YwPrmk0DaqbfwInJT+3W7kKbV4d8jLH4/JOJQDj
 lbBr6c0M7kAGwOCUR82YtuJgAsEirTWC+C8jCCW/aZr2V54TiA6TKEV2R2q9xNKmIH9p
 M3DMpgyubjK+Bv6iFFDQASY2XjKRwlTZmG0QWdfySEt/FZwLHzXlOcK8coZdGQlW2Ok4
 W9GfZIxD2tfBn3U1EGSrgFd0YbbsIaH/yGuxr1yhwpkNG66nm+owzKRDYMmwPdWoCO1Q
 Aie4WNprZCkcX409Iv8zBlFX5Qemj4061K/RzPZOkChJmozVv7YhzimbJtOCoee1fFNk
 dXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778009891; x=1778614691;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Ug1IGAtqWfSRxIi2kUED0xqx7x/JlYhdoNCN8Nz0Vs=;
 b=NRtqbxPqaVmSd4oo04hJ71DmJE85sUwZGNQgzDyidq03rNSSgvkFfhRAPIWgsZRN9M
 WA2s3V9xVllKB6nhDZDEg7wBZhKyaeB21aD6z5LsjCFsVgK0pB6+/fbRk2mWozahSO3T
 Y+1FZJIzEYVs+hmCFO5hooZLbhaPPkg5b/p7n9pAw6+jOo19mL6uIT7k2ALeqBNIFY/z
 vJkWFQ7FDO3nhr/Jti351wpeFzY9BuDYhjxRyEiVXCNpm9UJn8ogwGeZPIi84Og5BqUZ
 FVoLrhfSViGHrZbS48tAes/aLF+7hRyHeyDp/buO24SjF06+jC7KhfygqGqgQ42+s2dW
 yFEQ==
X-Gm-Message-State: AOJu0YzfVthu+aPbJSR5DocMmlMgY1yLUyLSF3pAjSet3z+DWugXWx9Z
 Hnua+0Q2f5EDSgZsTZF1bvh/I1dmdsyH80Q4+fELbp5yT1Q8UROan6NUQ2N9r8uHLqMpXBRvqGc
 Tp0DwipM4S12QxVKYiIqmfoopzEPPUXNOe16vDK+NvUOtTcyP/C7V9LJp
X-Gm-Gg: AeBDiev7yJxF5yxbaRmA9THBBboHEOvkNYH7aAshyD8BNhJH7d73yY/AUG1IuzvloQC
 qzOLGxzOMC4qRFSE5Q1Q1QJaI8cWXjc8/Zdl6tEFa99ml/SK7JSf0G4A8J+Z5m6pfdfURWdihNC
 8qgPvGjwlk8ZzngaymdiOFvxguJVZdvoLEqUEhmcnpW3DEzd7QLxfU1vLQDEY/8l6xpwS/SmFsI
 uJv0z677GfNxxWMdp+4yYkuMN3s3t0szUd5VbsUGU3TbmzmM4Byeo7qPUgnwLgnVe7CDRMbxFFD
 1EB5DpR2KNx5jtTvYbKF88ycdrKPM6C6ssIycLuWEQ6ONkEenZH5aryVysTkzCViXmcQ7OHuNnC
 bHH8WDkGthApi3/4jhLMcI63lQd1Qs1fKyEWuBW0TsMldHB2u78BEoDYpnQ==
X-Received: by 2002:a0c:e01a:0:b0:89c:6a86:e632 with SMTP id
 6a1803df08f44-8bc43c042c3mr1759716d6.18.1778009890651; 
 Tue, 05 May 2026 12:38:10 -0700 (PDT)
X-Received: by 2002:a0c:e01a:0:b0:89c:6a86:e632 with SMTP id
 6a1803df08f44-8bc43c042c3mr1759176d6.18.1778009890132; 
 Tue, 05 May 2026 12:38:10 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53c0e7d3esm176489086d6.28.2026.05.05.12.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 12:38:09 -0700 (PDT)
Date: Tue, 5 May 2026 15:38:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v1] tests/qtest/migration: Fix A-B file build
Message-ID: <afpHIBDaGw2r8d49@x1.local>
References: <20260429231025.30818-1-farosas@suse.de>
 <afoeaRAxWSMO_gK5@x1.local> <87se85y8mq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87se85y8mq.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 05, 2026 at 04:11:09PM -0300, Fabiano Rosas wrote:
> I have a bunch of patches adding code into bootfile.c and consequently
> bootfile.h for the stress.c and hugepages work I told you about. We can
> discuss the header structure when I send them, if you don't mind.

Sure thing.

-- 
Peter Xu


