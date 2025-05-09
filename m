Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4934C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 15:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDPjC-0003qp-AK; Fri, 09 May 2025 11:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uDPj9-0003nT-MN
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:33:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uDPj8-0000dj-0F
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746804808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pWco+uhZgff2pXNpmatayBUN06GISv1tHwORY72IhSw=;
 b=NZXAyOMIcj+5V9SEHn5MAi5+wDNIhpmSLI7Biv8HmBG1KEgQcSkAEZskt6KeA016bVwL+7
 hM/XvHn5DXLhneT3ufYocFd0iu8KC4UkwAT3XKGi1FkiZDShvR0WlKKHRcvnqsn5qDeEyK
 5cEXQ67FR4k4kFV3TPPPAq6cJwfwO68=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-CT-wGcJANcq69Gs0lU_VKQ-1; Fri, 09 May 2025 11:33:28 -0400
X-MC-Unique: CT-wGcJANcq69Gs0lU_VKQ-1
X-Mimecast-MFC-AGG-ID: CT-wGcJANcq69Gs0lU_VKQ_1746804807
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-47689968650so26431751cf.2
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 08:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746804807; x=1747409607;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pWco+uhZgff2pXNpmatayBUN06GISv1tHwORY72IhSw=;
 b=JJMzlJue7gCk/xkcUdGupLs79RGIJEWbI5N0JNYk8mbXbIrBPHuHxmz1zfQRj8FKtW
 t3UsXoPX8qRC3ZjhXVuoyQyVOtmMcV1po3vPDvvbQBgVKBDoFf2AANTGJWGjlgU3OEOm
 C+9125xoGup7Rr67kQ3DrR/UGFuwlGjTfMyZJ1uE3iW9LEH9sS56/Psa1R+zN5/p8po5
 G+6mGmjPnGh3PzC5qLNHiKx+qNUY4XXxvHua0gekaW/346OT3b/2nNOe7N+vLQfMg4zM
 uab0U03gb2wwUutDSjXBduka9rP4ub5XPjdcD+PFGqW41GzdzpC4Q5t0TgQbsLiRbw73
 79Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAmm2LJY+CtBow8Mmm0CC3/AmvGeAMkYzgZn6dSmF9HCYPmKy8OmeoomOQW9BCAHYdmPcNaTqSRv3s@nongnu.org
X-Gm-Message-State: AOJu0Yyw8lJoEobkSaRq/FiBVJSY7jIhqq/VPQV4mlXbhCgWAkgnBxIo
 iy70yF4yINYz6ReaebMS+xakj1xweSMErXYS9p8wxMTh40rXO01jyg63saUTR92JTMRFIcy2NRn
 fsFrW5WHiC3EKd672PXwrnzpy9fo0XnrMEck74SzPVR01rBdaCIm2
X-Gm-Gg: ASbGncutAuGBEP6O5K3UsYE8Pzi64Qf6I+4jyoAlQYh2lJKFZGpYqpcc1oZdI12WUgI
 T5+3bgsInvwAUZ8pncIKWHMPUzj6WgnQ2zcf/aBBdd2zjGRzF/Dko3cuH5uxzq87H03bH9SJNgn
 JrD9fRkPY53xahJcCBg6gXSAPQgVnyb7asPBKDg4jEQfdLa25CNUc4A3WB6o3wPEGXHnGC1ZERE
 Hz5KzizbGXNMeZB0ulWbQSx+E9z8d3UCvCDUSYYBFEM4Bu4Z49OAj/1DcxgyhylX4r5W0wfzNnX
 zr8=
X-Received: by 2002:a05:622a:10a:b0:476:639e:ede0 with SMTP id
 d75a77b69052e-494527603afmr51111781cf.26.1746804807250; 
 Fri, 09 May 2025 08:33:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHNnxYuT17ZipbCYjGpRuisd3G36qw86Llbzu1YoFDYPQEkTeL0fLz9dHz4mV9QCu3w0C7HA==
X-Received: by 2002:a05:622a:10a:b0:476:639e:ede0 with SMTP id
 d75a77b69052e-494527603afmr51111241cf.26.1746804806781; 
 Fri, 09 May 2025 08:33:26 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-494524bbd04sm14178271cf.46.2025.05.09.08.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 08:33:26 -0700 (PDT)
Date: Fri, 9 May 2025 11:33:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 1/2] qtest/migration/rdma: Enforce RLIMIT_MEMLOCK >=
 128MB requirement
Message-ID: <aB4gQ7AxNNv7C2PD@x1.local>
References: <20250509014211.1272640-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250509014211.1272640-1-lizhijian@fujitsu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
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

On Fri, May 09, 2025 at 09:42:10AM +0800, Li Zhijian wrote:
> Ensure successful migration over RDMA by verifying that RLIMIT_MEMLOCK is
> set to at least 128MB. This allocation is necessary due to the requirement
> to pin significant portions of guest memory, typically exceeding 100MB
> in this test, while the remainder is transmitted as compressed zero pages.
> 
> Otherwise, it will fail with:
> stderr:
> qemu-system-x86_64: cannot get rkey
> qemu-system-x86_64: error while loading state section id 2(ram)
> qemu-system-x86_64: load of migration failed: Operation not permitted
> qemu-system-x86_64: rdma migration: recv polling control error!
> qemu-system-x86_64: RDMA is in an error state waiting migration to abort!
> qemu-system-x86_64: failed to save SaveStateEntry with id(name): 2(ram): -1
> qemu-system-x86_64: Channel error: Operation not permitted
> 
> Reported-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Thanks, this works for me.

I'll queue this one first separately.

-- 
Peter Xu


