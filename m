Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5899DCAC59A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 20:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqeOD-0003L1-Hl; Tue, 17 Sep 2024 16:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqeOB-0003KX-3P
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 16:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqeO7-0001vt-W5
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 16:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726603285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iwAdY/OyfXZeKCx8H/8jhgNCcdjayijuXtU7yCzM1ow=;
 b=FsIrLWsFHCbE6zganSZ8Zojr4afZPNbzB6WlHWZaXnFeJgHoH2NfA9pCuDFOyRSnGX9X55
 1WvMzVGpqdES/KjhoKPv7QOmFH4AA7PRcPeUuxUY/Je99hVmV0c6wDAInrhSZpD/WJGUr6
 DBedWvGIoG8lXsYHb/hneI5ZNhCQksI=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-ytO4knFsPEyFGiEXs5DioQ-1; Tue, 17 Sep 2024 16:01:23 -0400
X-MC-Unique: ytO4knFsPEyFGiEXs5DioQ-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5e1d7e1a846so4433764eaf.3
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 13:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726603283; x=1727208083;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iwAdY/OyfXZeKCx8H/8jhgNCcdjayijuXtU7yCzM1ow=;
 b=MwXXqTax3YliFArzSYnX1ETPT2lDBsKVRjLJu5lEFRPYCFWhV/+ujXBhj23iGGHXnU
 MlFPFVWvgMBBbo1t6cKWn8XLBsqODqAkfifPxjXdgmyLPU6qM4HAALBGx3c311Msn76c
 xvhZ7p4zU0wA5FAbUu4XWXPIIeKHOmPAnjyqqN6zKXu24P3hGMabi3hLk2x/zo2N7xi6
 3jG5g7/qBj80ONvAQ48rbZmkIzqfT5QAJsHytm+KY1Vv/45T/PytuXrgp6REqEYgoul7
 BJpB9OI8Jb0o18os4V0FdyelfrrxFqLXI9/R38uwSpFD3Y3+CBy+H68UPnEL2CYO7KKU
 QLvw==
X-Gm-Message-State: AOJu0YyGx0KBlF9quOFVNQUQb4ku7MCPYxMveJIfwLnAp2f5UKROKFv3
 ssY3t/wzEkRHPlCBWxJGilFjbroZHahkHLHxpr48mVyOshb3Dod3wtCJ3jeJUlLHZtOxfu7JDD0
 1bJPYGcZsExmzDld74ZuO/cgbdqVTcv/ffmRVlujp6MMkuam4mMxa
X-Received: by 2002:a05:6808:19a0:b0:3da:bc80:b233 with SMTP id
 5614622812f47-3e071aa7cfbmr12870806b6e.17.1726603283109; 
 Tue, 17 Sep 2024 13:01:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2pTgCv7aCfHWk2VmTD3dBBgH3GQHxtol+osGX87foRUZ7BZXuMXGYAhOKqTuozkXCjXfrCA==
X-Received: by 2002:a05:6808:19a0:b0:3da:bc80:b233 with SMTP id
 5614622812f47-3e071aa7cfbmr12870786b6e.17.1726603282713; 
 Tue, 17 Sep 2024 13:01:22 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-459aad2363bsm42132871cf.86.2024.09.17.13.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 13:01:22 -0700 (PDT)
Date: Tue, 17 Sep 2024 16:01:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/2] migration/multifd: Fix rb->receivedmap cleanup race
Message-ID: <ZungELnuhdCXeYeZ@x1n>
References: <20240917185802.15619-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240917185802.15619-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Sep 17, 2024 at 03:58:00PM -0300, Fabiano Rosas wrote:
> v2: Keep skipping the cpu_synchronize_all_post_init() call if the
> postcopy listen thread is live. Don't copy stable on the first patch.
> 
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1457418838
> ====
> v1:
> https://lore.kernel.org/r/20240913220542.18305-1-farosas@suse.de
> 
> This fixes the crash we've been seing recently in migration-test. The
> first patch is a cleanup to have only one place calling
> qemu_loadvm_state_cleanup() and the second patch reorders the cleanup
> calls to make multifd_recv_cleanup() run first and stop the recv
> threads.
> 
> Fabiano Rosas (2):
>   migration/savevm: Remove extra load cleanup calls
>   migration/multifd: Fix rb->receivedmap cleanup race

queued.

Let's see whether this can quiesce all multifd cancel test failures..  If
not, we can still follow that up.

-- 
Peter Xu


