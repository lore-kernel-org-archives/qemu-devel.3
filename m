Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71466C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 11:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl5aP-00030c-Oe; Fri, 15 Mar 2024 07:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rl5aK-0002yz-FC
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:18:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rl5aI-0007xH-Bz
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710501525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+V9mv7WSb4kbQRcA0HvjKZOFTCbdC0jKfK5WEEq0WU=;
 b=GJ+L4i0JgmrGABGQwMLo6t1AzNJXgzQRMy42lDOC2v79LRcfBR86j4KBdGxSuBK6ajyi07
 k8SMM3Agz4xmk+4yg4C1rhqKanGLwthC2yAOFI8nS8be08XO64eU5oMsXy93EzkX00oN1k
 +ZKeTXrrAjOQbDranvXG9MyTw4/EOcY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-c10zZG9COROLsDwEtbRbXQ-1; Fri, 15 Mar 2024 07:18:44 -0400
X-MC-Unique: c10zZG9COROLsDwEtbRbXQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-430b4572a97so1162821cf.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 04:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710501524; x=1711106324;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O+V9mv7WSb4kbQRcA0HvjKZOFTCbdC0jKfK5WEEq0WU=;
 b=PC/HWdKqd1pJyRGbyPhWoIbc+gQGPpdJ9CpdSzCPQWaCDvqspfcRlVk89XWae99u5G
 wXDaBTQohM8qPnPQjrCQjhRD3CgUTBUGY7+s3yZ1EAbP6rtsspBXXuYAiEBejJwDF1bw
 yadCuIIOeWdVf4NYUGF0cRKFiBt1g2fT3ooezYjLzYz/oVTMZaW/LAq1xUVbAZcDDqbZ
 C5D4Y4ky2NrvYs2ub1Ws0MZBgW+VERebmaBjnblsUtycNSyuHFAHjFd513x5Q27z55sy
 5P+q+0zLwJnjuk/A2n2r8EBQuoRE4XyXDyEVD3js2Cy1Q5AWe4Jy6ETn7E9swsb0v99h
 UBmA==
X-Gm-Message-State: AOJu0YwJaglwPSFQx5F4gW96OSitAOjJmL+MTHilJPtgsa1O2ZjZ2KnE
 BfhkSkblcFUf+W+gOAVnkfuHJ02+T7Oqfo7RcMJ/lhC55vuvrJmSydmOtNcvZMzObG6fptJQRLm
 CFnJk1aaRKNUDqOqqvhQPNMzmxYXZPZmoP+J0b7W7SbFgo78MQkiy
X-Received: by 2002:a05:6214:5345:b0:690:3c85:c5b with SMTP id
 kv5-20020a056214534500b006903c850c5bmr1824820qvb.3.1710501523718; 
 Fri, 15 Mar 2024 04:18:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw40xwPNrz3UXMfvsSlCsfFCkK5wCihhoDGZbhcHWZdHATS5gMIaAyyAEVTc8E0LXIVQBuXA==
X-Received: by 2002:a05:6214:5345:b0:690:3c85:c5b with SMTP id
 kv5-20020a056214534500b006903c850c5bmr1824804qvb.3.1710501523361; 
 Fri, 15 Mar 2024 04:18:43 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 pp26-20020a056214139a00b00691732938a8sm988670qvb.73.2024.03.15.04.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 04:18:42 -0700 (PDT)
Date: Fri, 15 Mar 2024 07:18:40 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 13/25] memory: Add Error** argument to
 .log_global_start() handler
Message-ID: <ZfQukLXQsgFEap4f@x1n>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-14-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240306133441.2351700-14-clg@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Mar 06, 2024 at 02:34:28PM +0100, Cédric Le Goater wrote:
> diff --git a/system/memory.c b/system/memory.c
> index a229a79988fce2aa3cb77e3a130db4c694e8cd49..3600e716149407c10a1f6bf8f0a81c2611cf15ba 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2914,9 +2914,27 @@ static unsigned int postponed_stop_flags;
>  static VMChangeStateEntry *vmstate_change;
>  static void memory_global_dirty_log_stop_postponed_run(void);
>  
> +/*
> + * Stop dirty logging on all listeners where it was previously enabled.
> + */
> +static void memory_global_dirty_log_rollback(MemoryListener *listener,
> +                                             unsigned int flags)
> +{
> +    global_dirty_tracking &= ~flags;

Having a hook rollback function to touch the global_dirty_tracking flag is
IMHO tricky.

Can we instead provide a helper to call all log_global_start() hooks, but
allow a gracefully fail (so rollback will be called if it fails)?

  bool memory_global_dirty_log_start_hooks(...)

Or any better names..  Leaving global_dirty_tracking rollback to
memory_global_dirty_log_start() when it returns false.

Would this be cleaner?

> +    trace_global_dirty_changed(global_dirty_tracking);
> +
> +    while (listener) {
> +        if (listener->log_global_stop) {
> +            listener->log_global_stop(listener);
> +        }
> +        listener = QTAILQ_PREV(listener, link);
> +    }
> +}
> +
>  void memory_global_dirty_log_start(unsigned int flags)
>  {
>      unsigned int old_flags;
> +    Error *local_err = NULL;
>  
>      assert(flags && !(flags & (~GLOBAL_DIRTY_MASK)));
>  
> @@ -2936,7 +2954,25 @@ void memory_global_dirty_log_start(unsigned int flags)
>      trace_global_dirty_changed(global_dirty_tracking);
>  
>      if (!old_flags) {
> -        MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward);
> +        MemoryListener *listener;
> +        bool ret = true;
> +
> +        QTAILQ_FOREACH(listener, &memory_listeners, link) {
> +            if (listener->log_global_start) {
> +                ret = listener->log_global_start(listener, &local_err);
> +                if (!ret) {
> +                    break;
> +                }
> +            }
> +        }
> +
> +        if (!ret) {
> +            memory_global_dirty_log_rollback(QTAILQ_PREV(listener, link),
> +                                             flags);
> +            error_report_err(local_err);
> +            return;
> +        }
> +
>          memory_region_transaction_begin();
>          memory_region_update_pending = true;
>          memory_region_transaction_commit();
> @@ -3009,13 +3045,16 @@ static void listener_add_address_space(MemoryListener *listener,
>  {
>      FlatView *view;
>      FlatRange *fr;
> +    Error *local_err = NULL;
>  
>      if (listener->begin) {
>          listener->begin(listener);
>      }
>      if (global_dirty_tracking) {
>          if (listener->log_global_start) {
> -            listener->log_global_start(listener);
> +            if (!listener->log_global_start(listener, &local_err)) {
> +                error_report_err(local_err);
> +            }

IMHO we should assert here instead of error report.  We have this to guard
hot-plug during migration so I think the assert is justified:

qdev_device_add_from_qdict():

    if (!migration_is_idle()) {
        error_setg(errp, "device_add not allowed while migrating");
        return NULL;
    }

If it really happens it's a bug, as listener_add_address_space() will still
keep the rest things around even if the hook failed.  It'll start to be a
total mess..

Thanks,

>          }
>      }
>  
> -- 
> 2.44.0
> 

-- 
Peter Xu


