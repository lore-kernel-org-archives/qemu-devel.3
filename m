Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA80EC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 06:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcJq8-0008U5-9F; Tue, 20 Feb 2024 01:42:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcJq3-0008To-Rt
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 01:42:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcJpz-0003cB-U6
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 01:42:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708411356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5hDqhHpONTvD7A+nB9XgprKd1CjE0cpS6mugOaN5w5g=;
 b=TdL68g1FrnUqyKb64FkUtXfe501t+g88gxGmuxBde+cRrn8bP/Japp64vNBbYo/+Xh9ig7
 5bFvssiRbyMSBnFGtTK8CI0Qka8gSnglo4aOSf270R5ZNdyVwgqwiG1TwzdAnLoda/2bq2
 y2WvUOtwowS8sUb08zQtryCg8v9LWAc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-tmsIpV9VM0mGu4zrfiCOTQ-1; Tue, 20 Feb 2024 01:42:35 -0500
X-MC-Unique: tmsIpV9VM0mGu4zrfiCOTQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5cf53f904f9so1354551a12.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 22:42:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708411354; x=1709016154;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5hDqhHpONTvD7A+nB9XgprKd1CjE0cpS6mugOaN5w5g=;
 b=TAz+gBjpHeedU9p64SToSNRGk04q66jYqc9LmuqEC+OwJFXBxxFLDp3siBXhTBNVS6
 1vcDSGjqwH3Z6tWVqOUuoe3WYVvh0CYX2EHGLb6KJ0dtqh6EVei32yXi3fZlj6Kj48t+
 N661PBho3O2I0Cf2FpM8Qcq4U17YdAUJDWBNJsyZVt9Z6kbnbbGdG6nBAR1izEf0I7G0
 xT0oXR1+JunAzN1ZvYVEyhUKOK0DnWBMfYw0mQ90KXLSfkxgN3zP23aLMm9pFWPUqQGx
 u5ziCO9xqUFTipyqihkU74oST0Md8zRpDnQPnncODpK2e+EP1rnN4mEVuJOpZ61cPE2C
 mN5g==
X-Gm-Message-State: AOJu0Yz6HdUBMso7cptfbiGeAwIWYn4W4TfQmzrqmZQm0wYZVuFofBqi
 /C+DAfg/hOBqV8LbE4i4xnMyZBA676HZvFIdC8hQtWMBqaDg3syAkNkUbNecHozw73Ox+9l9g3Q
 Qt28jlR5bzGWd66XHuOiMHXoNsYqXlWM9bAd5VoljiCzgwPgYswV5
X-Received: by 2002:a05:6a21:7886:b0:19e:c428:929f with SMTP id
 bf6-20020a056a21788600b0019ec428929fmr17056395pzc.1.1708411354153; 
 Mon, 19 Feb 2024 22:42:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzvhM5GhV/OdUrqMHJa5s8UHps40IjlvWr4mrq7qLeuDf9xrYMQs/VtjxJ4OT3MOUJkLHY+g==
X-Received: by 2002:a05:6a21:7886:b0:19e:c428:929f with SMTP id
 bf6-20020a056a21788600b0019ec428929fmr17056384pzc.1.1708411353784; 
 Mon, 19 Feb 2024 22:42:33 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001d8a93fa5b1sm5459355plb.131.2024.02.19.22.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 22:42:33 -0800 (PST)
Date: Tue, 20 Feb 2024 14:42:22 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V3 05/13] migration: remove postcopy_after_devices
Message-ID: <ZdRJzmiKw-JWgwQD@x1n>
References: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
 <1707418446-134863-6-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1707418446-134863-6-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Feb 08, 2024 at 10:53:58AM -0800, Steve Sistare wrote:
> postcopy_after_devices and migration_in_postcopy_after_devices are no
> longer used, so delete them.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


