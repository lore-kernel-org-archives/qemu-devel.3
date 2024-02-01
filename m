Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0FCC47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 06:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVQ8e-00084k-K2; Thu, 01 Feb 2024 01:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVQ8d-00084P-7x
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 01:01:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVQ8Z-0002PA-Ic
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 01:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706767281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y7igkYjN8JA6rNREmhVY153GCQ3nZz6UQTL0IUKEtak=;
 b=R8oan1ThlbOEVVVpv69kGoDDhz9PJh/0kOyo2noT2ypZSkVZhbNKTbzNLUGv8qNA5Qnu1G
 Ze8NvqOk9GffeSOljPNL5YA1iXfo5bYY72J9KWJSDPdLUvJDiGKoW0LhmOhFNk0Xxj+zyW
 ZQ4Pz/ZXs+Ug78UaOTvYXm5KP0uhxYk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-qNLwpntqPQ6MiOazkj3AIQ-1; Thu, 01 Feb 2024 01:01:20 -0500
X-MC-Unique: qNLwpntqPQ6MiOazkj3AIQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-28e7e94a63aso102354a91.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 22:01:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706767279; x=1707372079;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y7igkYjN8JA6rNREmhVY153GCQ3nZz6UQTL0IUKEtak=;
 b=UZ07iWznlFzv+erp6ePWVXdN1+GAEg/06yR9KmJ+MmRRo9IKkQgGDXhRt2cmEPnERQ
 MAinZdw/muVSg0RoQ0bkXuy11htOwnH9tsEUJIP/M7xDqPahx5L597H0znKbO7y38aZu
 h6ggF6M1hlSTjgcshK8FxLQZQIPSKjUcMQMrF26oMjNeNg/HLigS7VgDcKiYCUKC8obC
 uqG0QYACqZmQ9lPHGx5wrHPs2BXZnBe73cmV2nrhDa/87zGujZ2yFJSIemBNITqgOABz
 rEIZ3Niqzf/eS0LFPMncBUjSBYSOY3w0p2rBugvN+o6Naj1k1CGKCu3HPN2T+tEakuTz
 e2fg==
X-Gm-Message-State: AOJu0YzpSiGKwvsuZIk9VPltiaJ+qT6Y956XOgb+ArsaQoVZciey7auo
 josa1NZA+cgkD+E9FfiWYKPH2dMmEwUNGUXO7S7n9J1YZOGmM8gphbhNyRmFr2AdYQpiHkHXueb
 3kG3hD0NelXV1mCIpUtf0POxH78Pt/K2aXWJgyLZ479He3ChmoJfqVWUP6+q0FhaxPCFmZQejlU
 7w27L9MgCK3TxkyMwDtjXXPhABvJUJPi+GN/gQ
X-Received: by 2002:a17:903:2348:b0:1d9:143:a254 with SMTP id
 c8-20020a170903234800b001d90143a254mr1742331plh.2.1706767279138; 
 Wed, 31 Jan 2024 22:01:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRV6j6eW2HVOHKNu6OIX3NjA3BWnvxUTxRZwdPsKKvjWO3cUHEmMNDSWPVkPlTBZYXSbsSHg==
X-Received: by 2002:a17:903:2348:b0:1d9:143:a254 with SMTP id
 c8-20020a170903234800b001d90143a254mr1742300plh.2.1706767278609; 
 Wed, 31 Jan 2024 22:01:18 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCV3rRRqIHPdh94gIqzwjk9TTwDVA8f62jKR9U/LKa2CkDODi7NsFiCBdotTI3qqPqvS9JVHSCYGcKPXkTMzuA3D2oTs73OQ5b9yVMfmxSgllksixYOw41XWLrbIseNIMjz29Q0Oyl/8wFDv7lRS/Qq8YJ5Ai7gTMB4a8NkM5TjBPOQsKkfmlDWgIni1/kHyK/gEhk1lDw==
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 u17-20020a170902a61100b001d6f8b31ddcsm10056914plq.3.2024.01.31.22.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 22:01:18 -0800 (PST)
Date: Thu, 1 Feb 2024 14:01:12 +0800
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bryan Zhang <bryan.zhang@bytedance.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Yuan Liu <yuan1.liu@intel.com>, Avihai Horon <avihaih@nvidia.com>,
 Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH 14/14] migration/multifd: Forbid spurious wakeups
Message-ID: <ZbszqD8flNOWKRcK@x1n>
References: <20240131103111.306523-1-peterx@redhat.com>
 <20240131103111.306523-15-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240131103111.306523-15-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jan 31, 2024 at 06:31:11PM +0800, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Now multifd's logic is designed to have no spurious wakeup.  I still
> remember a talk to Juan and he seems to agree we should drop it now, and if
> my memory was right it was there because multifd used to hit that when
> still debugging.
> 
> Let's drop it and see what can explode; as long as it's not reaching
> soft-freeze.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/multifd.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 0f22646f95..bd0e3ea1a5 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -766,9 +766,6 @@ static void *multifd_send_thread(void *opaque)
>              p->pending_sync = false;
>              qemu_mutex_unlock(&p->mutex);
>              qemu_sem_post(&p->sem_sync);
> -        } else {
> -            qemu_mutex_unlock(&p->mutex);
> -            /* sometimes there are spurious wakeups */
>          }
>      }
>  
> -- 
> 2.43.0
> 

While removing this is still the goal, I just noticed that _if_ something
spurious wakeup happens then this will not crash qemu, but instead it'll
cause mutex locked forever and deadlock.

A deadlock is less wanted than a crash in this case, so when I repost, I'll
make sure it crashes and does it hard, like squashing this in:

====
diff --git a/migration/multifd.c b/migration/multifd.c
index bd0e3ea1a5..89011f75d9 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -751,7 +751,9 @@ static void *multifd_send_thread(void *opaque)
             p->next_packet_size = 0;
             p->pending_job = false;
             qemu_mutex_unlock(&p->mutex);
-        } else if (p->pending_sync) {
+        } else {
+            /* If not a normal job, must be a sync request */
+            assert(p->pending_sync);
             p->flags = MULTIFD_FLAG_SYNC;
             multifd_send_fill_packet(p);
             ret = qio_channel_write_all(p->c, (void *)p->packet,
====

Fabiano, I'll keep your ACK, but let me know otherwise..

-- 
Peter Xu


