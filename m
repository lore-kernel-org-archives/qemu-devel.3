Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6279C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 19:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlttN-0006S4-Rc; Mon, 20 Jul 2026 15:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlttI-0006RF-0f
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 15:43:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlttE-0002ek-QO
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 15:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784576579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jzWtUFKTnU7Fv8QhCtSzvYIiU/lWRZbu736lrVVWQsY=;
 b=BcS8kOJj6zAWKY+6P+1ExL6PjFZhWbeaOX38rLGYUrg23TrQBx8Y/TDfnbIznBgsAxCybl
 dV5un8iiMcIPu8UzPcsj0xZytWSbsqijoC9n5tsFEYtv5Fu7yNZTx4lF8ypzY3V4+v00w4
 y1x3DbbTPkdxV1+pBAFHbM2GtxekmOU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-CdhuBPXSPv-vrqKb1Rjw-A-1; Mon, 20 Jul 2026 15:42:56 -0400
X-MC-Unique: CdhuBPXSPv-vrqKb1Rjw-A-1
X-Mimecast-MFC-AGG-ID: CdhuBPXSPv-vrqKb1Rjw-A_1784576576
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51bff5c7035so101084441cf.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 12:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784576576; x=1785181376; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jzWtUFKTnU7Fv8QhCtSzvYIiU/lWRZbu736lrVVWQsY=;
 b=F9/3/ZAMJAKLZ1EWgwOX+Urar6lAhVeLVVlEyNRMJJDmYJ4knBiJxXijDcDPKmCoRi
 mzi/le1u3KAnJadMYiTib/FGR4tTs8GggCzOXnZOYJxULXXGSKXQIen0p66/M9VSzGCh
 Ty2lxClS+Lgg1J0TsFUjInZ/8hH9OiTeJ9G1VkJhREmtSgk3gFjA6o06Vq/PXjrf7uFm
 ds7518LMlyLzxec/XKfLFJXyLbvtKnWSuS4yVHrL+bG+GQGsP59M38L8nU+25Kaird1G
 nEQGvbuQzIrSZMomWUvnqS8FQjxgefTyEpJ0DcGtvOy9rFOXMZMSFovIiXy9FTwndQnU
 c15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784576576; x=1785181376;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jzWtUFKTnU7Fv8QhCtSzvYIiU/lWRZbu736lrVVWQsY=;
 b=Z76iLlNI5vxmQ3pItCEBgKl13Wvr9V3WhxFziOBAPZcLLrBXTrDnx8ZfV/gsTXmx23
 6+KXSA9/qtYOvD1ERu24Mn0rN8vv8gHOX3KfbdwXmNASkijw3g/HEuCkCum2vUT3crqh
 QA7zdARLfTQqSsk6pG85q8K7kzeloli2qVVebHLKhaCg5t4ijxJ6UWCYnBeNK68NTAfX
 ymQDXiM1ZnFlSE1lGvEqfeoLECLzpJOsxNNsy4RkhC59GBW6MAfrbFbJsXKuWM2cLP8G
 pw0yno6lbJjVTt8e9v3jir2Z5O+yy9e/3b9TftqEA0bzL4Eu2odbmxmJJJjCYBdq7Qq/
 hBNw==
X-Gm-Message-State: AOJu0YzA5jrK/5Qpxra64klAV0pduRckr8fIqDd1ySxj2Dxv4LQ9BTAj
 ftqMVe/znELSNm4yWRcjPc4Wwc9hVHsrJOOPe9feiySSDI+SCcJGdkqGqA9jgBC/Ex+aAh83pHH
 XvktLwZJhHGLdGLluF7PdYo2Gk+GeXTMlqHcRMyYuRCEffyEc27eIrrxT
X-Gm-Gg: AfdE7clOQ37su4aaHurrteVglUU6QYSjtzoKppNJi/okoeUWIsEvscmxC50o5Y6xmGr
 0HtycgP+YVcRv16ZYhoiu5fuD8H6inPECOzRL50TqiVr9cduhsIKB71OIopLPnwGI7Jj8VyeNxx
 iPuvVkbh8hj0nfTYLbNY99rOdG0FPCmY8NXqJ8KXEjWJFLKh33nE5agilRwmfsgS8FxmUyJGcxp
 JMA84T0AvQyvjgCsQmuvU0VvsDEK2nWmszqMNRb1m6RboTe2le3VmuOIRxLwuozlcVR3B/zN6Zu
 eWartJp9eghn+RiSvpp3Q636F/V1e/28kLe4HAXL6pMS90IUWY/6Yml9vu18Ia8RbxUJ
X-Received: by 2002:a05:622a:4ccb:b0:51a:1651:b796 with SMTP id
 d75a77b69052e-5213ad60931mr145142151cf.29.1784576575744; 
 Mon, 20 Jul 2026 12:42:55 -0700 (PDT)
X-Received: by 2002:a05:622a:4ccb:b0:51a:1651:b796 with SMTP id
 d75a77b69052e-5213ad60931mr145141951cf.29.1784576575081; 
 Mon, 20 Jul 2026 12:42:55 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-526627e6a2csm2654741cf.7.2026.07.20.12.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 12:42:54 -0700 (PDT)
Date: Mon, 20 Jul 2026 15:42:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v3 11/11] docs/migration: Add documentation for fast
 snapshot load feature
Message-ID: <al56MgEneEnIpL6E@x1.local>
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
 <20260714141547.1268000-12-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714141547.1268000-12-aadeshveer07@gmail.com>
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jul 14, 2026 at 07:45:47PM +0530, Aadeshveer Singh wrote:
> Add documenatation for fast snapshot load covering an overview, the
> architecture, usage and limitations.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> ---
>  docs/devel/migration/fast-snapshot-load.rst | 81 +++++++++++++++++++++
>  docs/devel/migration/features.rst           |  1 +
>  2 files changed, 82 insertions(+)
>  create mode 100644 docs/devel/migration/fast-snapshot-load.rst
> 
> diff --git a/docs/devel/migration/fast-snapshot-load.rst b/docs/devel/migration/fast-snapshot-load.rst
> new file mode 100644
> index 0000000000..0c0dc676fb
> --- /dev/null
> +++ b/docs/devel/migration/fast-snapshot-load.rst
> @@ -0,0 +1,81 @@
> +==================
> +Fast Snapshot Load
> +==================
> +
> +Overview
> +========
> +Fast snapshot load is an extension of the postcopy migration feature
> +to disk loads.
> +
> +Unlike a usual snapshot load, which requires all VM data (RAM as well
> +as device states) to be loaded into host RAM from the snapshot file
> +for the guest to run, fast snapshot load uses postcopy infrastructure
> +to load in only the required device states and load RAM pages on
> +demand. The idea is to start the guest and serve its page faults on

Suggest to replace "load RAM pages on demand" to something more general,
like, "allows the RAM pages to be loaded after VM starts".  E.g. the eager
load thread work isn't on-demand.

> +the go, reducing the perceived resume time for large snapshots.
> +
> +Architecture
> +============
> +This feature combines postcopy migration and mapped-ram capabilities
> +to load RAM pages on demand. It is done by catching guest faults using
> +Linux ``userfaultfd`` and loading the page by calculating the offset
> +of its location in the snapshot file using mapped-ram capabilities.
> +
> +Fault Thread
> +------------
> +The fault thread uses Linux ``userfaultfd`` to catch page faults caused
> +by guest and directly load the page from the snapshot file. It is
> +very similar to network postcopy fault thread, with primary difference
> +being it loads pages directly by reading from the snapshot file.
> +
> +Eager Thread
> +------------
> +Eager thread iterates over all pages in RAM and loads each page not
> +yet loaded by fault thread. It is required as unlike network postcopy
> +where majority of RAM has already been loaded via precopy, here entire
> +RAM is waiting to be loaded. If there is no eager loading thread each
> +page will only be loaded when it is required by guest. In case there
> +are some background pages that are never/rarely accessed by guest,
> +the system will be locked in migration state indefinitely.
> +
> +Synchronization
> +---------------
> +In order to make sure both of these threads do not load the same page
> +twice potentially overwriting and corrupting user RAM, a bitmap is
> +used (``RAMBlock->pending_bmap``) which tracks the pages claimed to
> +be loaded by threads. This prevents race condition when one thread
> +is loading the page and other one tries to do the same.
> +
> +Usage
> +=====
> +
> +Simply enable ``mapped-ram`` and ``postcopy-ram`` capabilities on
> +the destination:
> +
> +.. code-block:: text
> +
> +    migrate_set_capability mapped-ram on
> +    migrate_set_capability postcopy-ram on
> +
> +Use a ``file:`` URI for migration:
> +
> +.. code-block:: text
> +
> +    migrate_incoming file:/path/to/snapshot/file
> +
> +Limitations
> +===========
> +
> + - Multifd
> +    Fast snapshot load is currently incompatible with ``multifd``
> +    capability. While ``mapped-ram`` allows for parallel disk I/O,
> +    coupling it with ``postcopy`` capability requires additional
> +    infrastructure.
> +
> + - Host OS support
> +    Because this feautre essentially depends on ``userfaultfd``
> +    to trap page faults, it is supported only on Linux hosts.
> +
> + - vhost-user
> +    Fast snapshot load does not currently support ``vhost-user``
> +    backends.

For this one you haven't added a check in the other patch to detect it
happening, you can add one check to see if postcopy_notifier_list is empty:
anything registered implies vhost-user enabled.

Thanks,

> diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
> index 9aef79e7fa..23c2a93173 100644
> --- a/docs/devel/migration/features.rst
> +++ b/docs/devel/migration/features.rst
> @@ -11,6 +11,7 @@ Migration has plenty of features to support different use cases.
>     vfio
>     virtio
>     mapped-ram
> +   fast-snapshot-load
>     CPR
>     qpl-compression
>     uadk-compression
> -- 
> 2.55.0
> 

-- 
Peter Xu


