Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A0EC28B25
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqgXV-0001T4-2d; Fri, 07 Mar 2025 17:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tqgXT-0001Sr-SJ
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:51:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tqgXS-00013L-8R
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741387889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oz26d+FuIgu1q88EhP9jh7x2MX/fvMs28gHN80rq4O4=;
 b=G/wH5eq5IbhvmIaASY/pO51L/nyfnk/xGGce9sBrJP5HsQ6Z5J5mhuC1eTt/KjJyXJ+wBr
 oyYcH0J9DtNDqdEmcTCJ1pLld4hi3mIotZ3BIx+OuE9XX1pQA3Qt3uum7MDithOjGoj+4k
 yACMFF7qaL9NLEWmAcYRa5sfcA+eIOc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-Oma41uuJPZitITbWJFv6aQ-1; Fri, 07 Mar 2025 17:51:18 -0500
X-MC-Unique: Oma41uuJPZitITbWJFv6aQ-1
X-Mimecast-MFC-AGG-ID: Oma41uuJPZitITbWJFv6aQ_1741387878
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6e8c93fda2aso42091116d6.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 14:51:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741387878; x=1741992678;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oz26d+FuIgu1q88EhP9jh7x2MX/fvMs28gHN80rq4O4=;
 b=JMVS2CumTV9a28d1aU5KXOqdMbhUoheo4HG+pODlnw7tRLOnqeCcHUXMbxXMe94h+t
 GrEyqYlCQZmAB5CHLOUgNl+Mig+CMDJG86p0SdxVJORDBjSti/WpWUmRMIQUh3/FBOKJ
 9FL+nD6QqrfSSzPjzqjNNfN9Oascb0hcC8HclLPN0LltZILTb6PdtIrvIcOW6rzOyhg+
 0jKuxI83JTQ41zVe8ece1VMdQ6Xv8IJbJnD3asVFMWnoVT/eGVRRdKZxKlwV/mOOOX4k
 hegOuudGclaeh/a2TGc//wPV7w9V3CBFIdvG+1P97Vom6atU3emz36paOqVS1t4clrKz
 z03A==
X-Gm-Message-State: AOJu0Yw5Xs7tInX96JAL57qm+keNRRA89FjrxEF1FkXH+cP4/jCeBACq
 jN5UFYovPyIcVxRF81SxoWf+vAOv9lUcGOftOjWVJ+C/DwIlLMAdQnPAYtJRoqlNYqF7phZKGu3
 UX+aCnY/e0xo+0QfDPQbMRXw52s5Ff+IlDhspdd227/qXRb1USupQ
X-Gm-Gg: ASbGncu5jpsulpcERil5TvbaFaW40FkzWHZDtjabFzeldIr5EbqneHKpiv7FNAU9E6V
 TYIiJ8TwHJH+/DlkyGGCXmpstQriV15X218Vp8O1m46T9Ct++kz6scJdITCEfdt5A11O2Bgf+7d
 el6JqGuw2LRymq6eX0PSFaNANSFfruvtwzqNhjcmTItZBG/zWLSdsmuvL/11oUGzm+pEhc7VEvL
 NB4dEJBz2xRevjPIHc/YDNy/H7tgF7sUXZnEN7w+xa2X84tx+iaK4ZuTRQflBmsILHhjKK4WHB1
 CXPZ4JY=
X-Received: by 2002:ad4:5f4f:0:b0:6d8:af66:6344 with SMTP id
 6a1803df08f44-6e9005d4a32mr66172456d6.2.1741387878201; 
 Fri, 07 Mar 2025 14:51:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+sJwGIF7MyGtPcEWKZL9z4Vkh2nXvsXDeUuPMvruDDwgvytF3D35vh7KhGbasoX3+GoeGww==
X-Received: by 2002:ad4:5f4f:0:b0:6d8:af66:6344 with SMTP id
 6a1803df08f44-6e9005d4a32mr66172226d6.2.1741387877937; 
 Fri, 07 Mar 2025 14:51:17 -0800 (PST)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f707c4b5sm24419366d6.1.2025.03.07.14.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 14:51:16 -0800 (PST)
Date: Fri, 7 Mar 2025 17:51:14 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v7 5/5] migration: add MULTIFD_RECV_SYNC migration command
Message-ID: <Z8t4YoPEnwJO0sFP@x1.local>
References: <20250228121749.553184-1-ppandit@redhat.com>
 <20250228121749.553184-6-ppandit@redhat.com>
 <Z8G9Wj3DWSgdLkNQ@x1.local>
 <CAE8KmOxenqyqOxEFozgP1gBZPtneEqcbop9F_f+VW3ukPfw37A@mail.gmail.com>
 <Z8XBowkG72G-l3L4@x1.local>
 <CAE8KmOyssf_2RYBw2LLpxP2Z5bmtyU==Qs+4HWp=mOVb9o82-g@mail.gmail.com>
 <Z8cPnxqOvp1hFpx8@x1.local>
 <CAE8KmOw1CCQUt0wyELVhy5j-CfwVuA2XNsecW=y6rwJv7dempw@mail.gmail.com>
 <Z8hJeneeuKqD1i8Q@x1.local>
 <CAE8KmOyKiEt9t0vUwVyqD7tx01vkm+NHA1p1tmQnJ9mKY0Za7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOyKiEt9t0vUwVyqD7tx01vkm+NHA1p1tmQnJ9mKY0Za7w@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Mar 07, 2025 at 05:15:03PM +0530, Prasad Pandit wrote:
> diff --git a/migration/migration.c b/migration/migration.c
> index 65fc4f5eed..da2c49c303 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3401,9 +3401,10 @@ static MigIterateState
> migration_iteration_run(MigrationState *s)
>      if (!in_postcopy && must_precopy <= s->threshold_size
>          && can_switchover && qatomic_read(&s->start_postcopy)) {
>          if (migrate_multifd()) {
> -            multifd_send_flush();
> -            multifd_send_sync_main(MULTIFD_SYNC_LOCAL);
> -            qemu_savevm_send_multifd_recv_sync(s->to_dst_file);
> +/*          multifd_send_flush();
> + *          multifd_send_sync_main(MULTIFD_SYNC_ALL);
> + *          qemu_savevm_send_multifd_recv_sync(s->to_dst_file);
> + */
> +            qemu_savevm_state_complete_multifd(s->to_dst_file);
>              multifd_send_shutdown();

Forgot to mention one thing:

If you do flush and sync, IMHO we can keep the threads there and remove
this shutdown, as long as we are sure it'll be properly shutdown when
cleanup.

With the assertion in dest threads, I think it should be OK.

-- 
Peter Xu


