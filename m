Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE83C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 09:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXHY9-0001ef-AM; Tue, 06 Feb 2024 04:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXHY3-0001e7-0g
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:15:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXHY0-0002yC-2W
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707210918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/+m+QZ/ovkj/gdSJnszMJklsIJVqdZt9eUgAymlhdZ4=;
 b=fYOCivLiHnlMDNi0br962pbXEFg/NBWkU0enpzG7S74VMqbt/+NF1aBpedH1AinwCGnaIN
 mNM6aXYd/EtFEEuKAlhE74ILDH61+AJsHutZbCDWRkdIZ5eUlPGAq1pp6GBmjWR0hbJxig
 eG7ay/McVOu9pmRXAxa2Q1/gnDVmDQM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-XcivGdXQMKiz_cIg79FALA-1; Tue, 06 Feb 2024 04:15:16 -0500
X-MC-Unique: XcivGdXQMKiz_cIg79FALA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2961d20fe78so1395045a91.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 01:15:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707210915; x=1707815715;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/+m+QZ/ovkj/gdSJnszMJklsIJVqdZt9eUgAymlhdZ4=;
 b=MC2/flKF0Acnk9Py5KuyYOq8pr4ateteghuVwcGxDu7+9Vyp5bPeJOTd46hPmSmSQS
 EOxTa0aQShAwMx/INjxkK0LQV3Zt1/b6OfhdBQxX4EGobtAenezHvEO0AHjdfvg2UOuY
 W8nqIwXv10sm2Q9noh4gkY7Iv1YO0O49G6lJ62JJKTrDFpHaoSOgLZ+DRsFr1Ut6cu5N
 JKq83+mxMEJHHCOmLlf4vBnt2H1DEjIA2NpfL9SZfWwZ4cpGJIKEEoKLHpFG0ak8YDSo
 huAy7tx4l1RdS3O/BlWcLg7xllHgpbmHNMy8/Srvayn5Ym/CZRRtMEhxtHsV11BA26uk
 Nmrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0qNoTDMRysVAya5aBgWofRY0MKa6MkBe3d3ohT5JXOlg68fTf1GrL36NsdiHt+4OWNpospX5EglosFG5ArqIlXqaFFqE=
X-Gm-Message-State: AOJu0YylqVxZ6PfTIN2AI/DQwf86bajPICCQx1R8vGMCl9ZXXMAyvxKB
 6FLWcmb+WznZbWV5d2rUxKq9hdkL6Q4VgBy7pZvD5P8trNMMikqFKBK0JJMWhadx6nbmmm8zMfC
 nhiXTK7q6Qh1iUNcKZZ3cgdnqnG6C/yJBikabzcFbQsaXe6llXaHw
X-Received: by 2002:a17:90a:df06:b0:296:cc9e:89f5 with SMTP id
 gp6-20020a17090adf0600b00296cc9e89f5mr596123pjb.4.1707210915637; 
 Tue, 06 Feb 2024 01:15:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENp5RsHGWqA8Tw9tWTBLsXlAXy+J8qKWQogcQ2mvtw7jX/5K8qEuK3R9M7J8ETFc3OI5DcCA==
X-Received: by 2002:a17:90a:df06:b0:296:cc9e:89f5 with SMTP id
 gp6-20020a17090adf0600b00296cc9e89f5mr596099pjb.4.1707210914937; 
 Tue, 06 Feb 2024 01:15:14 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCV0TWj30QGm0DOrUQPl6yCD/FOmGo1fghKU2srGltHNTh1gJ8aHg4JSiTO4YPQW1WP3VDs2EnpEbPWlNOil3PBAGZgDajQKM4viKDPPdEl7dZ6vWKTbGgbtXFydUFkh9ZqOLJdCFkm95zrrSlGRlmFBtQ==
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 rs16-20020a17090b2b9000b0028ce81d9f32sm1024910pjb.16.2024.02.06.01.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 01:15:14 -0800 (PST)
Date: Tue, 6 Feb 2024 17:15:07 +0800
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Avihai Horon <avihaih@nvidia.com>, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v2 1/6] migration/multifd: Join the TLS thread
Message-ID: <ZcH4m3hLkYQxwt1S@x1n>
References: <20240205194929.28963-1-farosas@suse.de>
 <20240205194929.28963-2-farosas@suse.de>
 <ZcHzmb6gVJtS_flp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcHzmb6gVJtS_flp@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Feb 06, 2024 at 08:53:45AM +0000, Daniel P. Berrangé wrote:
> AFAICS, it is not ovewriting 'p->thread' because at the time when the
> TLS thread is created, the main 'send thread' has not yet been
> created. The TLS thread and send thread execution times are mutually
> exclusive.

IIUC it'll be overwritten after the tls handshake, where in the tls thread
uses multifd_channel_connect() to create the ultimate multifd thread with
the same p->thread variable:

    qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
                       QEMU_THREAD_JOINABLE);

There it'll overwrite the old value setup by p->thread, hence the tls
thread resource should be leaked until QEMU quits when created with
JOINABLE in both contexts.

Thanks,

-- 
Peter Xu


