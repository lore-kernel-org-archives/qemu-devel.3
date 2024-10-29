Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1282D3A699
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 20:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5sjn-0003hh-Om; Tue, 29 Oct 2024 16:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5sjl-0003hG-VC
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 16:22:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5sjj-0001d2-QO
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 16:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730233361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I+Onz6IjTTzjIjp+XvTzR9Tz5Twl+EL1x6odngjGIds=;
 b=ISkx2S6nAvLwTqx8jTs3BQ0meTPjDzOPt51zTcl4W/wINm31qlW8RofSD/Ga0F3PLJSQVv
 ovvfyZJYWUxY+WvqbkR+31p0FTkA2uuXw0mp6qtxA/2yP1aO2h9rKBsB8NabD9IhRXfhU3
 W5BffzDAtdGMZDgT9IvUFVnPmo7v/m4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-8jaM0QJKPumcSqBSSNSx8w-1; Tue, 29 Oct 2024 16:22:39 -0400
X-MC-Unique: 8jaM0QJKPumcSqBSSNSx8w-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-460a9b67fadso89013361cf.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 13:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730233358; x=1730838158;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I+Onz6IjTTzjIjp+XvTzR9Tz5Twl+EL1x6odngjGIds=;
 b=szDJP+OUEXQ8KgOYPv3/TQqLQd8JHlAU6eZXBtbnaP9lXTxTT79MY/9driSLXl79Te
 vSmuB8za4sbZkg3EMhJEQgP+qQrD7TUwHe0IO4rtORalzIfySWCppnu7ayOQPyBhG8gu
 ENcinVZW0HwpMA+ghKT7ONcx359z82HYiU5T1oSU5RUZ8w9i35PigSDjWNsx44MqR0fR
 eERoz6mM5UNnYwhIyQVyMl8bqkuYDciOsQPIIoFoQ7k5hpS0klowRxIobpSkS21iTagE
 x74SEhGH80aiIIPPTLCddabc8rTqgbGKgW4NtCRcD84tzocPfBvD7DZ07rfslsGFI7Lz
 PlWA==
X-Gm-Message-State: AOJu0YxIiQapbyZDLTrhGRgo398eq4MKIeysfq8yEGoOHCOCPnZjaUd5
 eA2BBFCS70mW0Jf0GeG/Ek3N02TADHRwIJGBTL53ULA7lc0l8DKpAa7+inGc3zJlatAfCMKiPsR
 BzqvfLzaXEXl3FRC8qsb69QK+MK+jz9C/UFZdhu7lPXged2Jiim0KTMAwXjE4uolz7u1JoZucGO
 N4mJJqEqllTJXid+Uut9A1zNAIEWn0XzhHRw==
X-Received: by 2002:a05:622a:1490:b0:45e:f2df:2ed3 with SMTP id
 d75a77b69052e-4613c047c88mr158365361cf.32.1730233358089; 
 Tue, 29 Oct 2024 13:22:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGExOKCXHJ/0WxNbDnPzXxQ7gu5QiuCtTvuZ49SGoS8W8US+cLGG/64FEbTB55nWMklGpXkUQ==
X-Received: by 2002:a05:622a:1490:b0:45e:f2df:2ed3 with SMTP id
 d75a77b69052e-4613c047c88mr158365121cf.32.1730233357667; 
 Tue, 29 Oct 2024 13:22:37 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4613211a228sm47697811cf.19.2024.10.29.13.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 13:22:37 -0700 (PDT)
Date: Tue, 29 Oct 2024 16:22:35 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 0/8] Migration: Make misc.h helpers available for
 whole VM lifecycle
Message-ID: <ZyFECyaVpNwfnPiI@x1n>
References: <20241024213056.1395400-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241024213056.1395400-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 24, 2024 at 05:30:48PM -0400, Peter Xu wrote:
> Based-on: <20241024165627.1372621-1-peterx@redhat.com>
> CI:       https://gitlab.com/peterx/qemu/-/pipelines/1511349805
> 
> This is a follow up of below patch from Avihai as a replacement:
> 
> https://lore.kernel.org/qemu-devel/20241020130108.27148-3-avihaih@nvidia.com/
> 
> This is v3 of the series, and it happened again: changelog doesn't make
> sense to compare to v2 because it's rewritten.  Meanwhile, now this series
> is based on the other TYPE_SINGLETON series I posted just now:
> 
> https://lore.kernel.org/r/20241024165627.1372621-1-peterx@redhat.com
> 
> It turns out I found more things to cleanup, as the versions spin up.
> 
> Patch 1:     I found that object_ref() in migration thread is actually also
>              racy..  this should fix it.
> 
> Patch 2-7:   It turns out I decided to clean things up first, then it'll
>              make my last patch easier on adding the mutex protection for
>              the current_migration reference
> 
> Patch 8:     The fix for NULL-dereference / race for the exported
>              functions.  VFIO can hit it only because VFIO's specialty
>              in using migration helpers in vmstate handlers, I guess.  I
>              found most functions always safe because even if they're used
>              outside migration/ they're most likely still invoked with
>              migration thread context.  So I found only two functions that
>              really need protections, exactly what VFIO is using.

I queued patch 1-5.

Ideally 6+7 can be a single patch, then we don't need to move DEVICE into
migration_is_active() at all.  Also that might break VFIO as Avihai pointed
out on VGA sync.  Avihai, I'd still appreciate if you could consider look
at vfio to behave like what kvm/vhost/.. is doing, by accepting log_sync()
before log_start().

Patch 8 still rely on singleton series, which will become rfc to be
reposted, so probably no rush on that.

> 
> Comments welcomed, thanks.
> 
> Peter Xu (8):
>   migration: Take migration object refcount earlier for threads
>   migration: Unexport dirty_bitmap_mig_init()
>   migration: Unexport ram_mig_init()
>   migration: Drop migration_is_setup_or_active()
>   migration: Drop migration_is_idle()
>   migration: Drop migration_is_device()
>   migration: Unexport migration_is_active()
>   migration: Protect updates to current_migration with a mutex
> 
>  include/migration/misc.h |  11 +---
>  migration/migration.h    |   8 +++
>  migration/ram.h          |   1 +
>  hw/vfio/common.c         |   6 +-
>  hw/virtio/virtio-mem.c   |   2 +-
>  migration/migration.c    | 118 +++++++++++++++++++--------------------
>  migration/ram.c          |   7 +--
>  net/vhost-vdpa.c         |   3 +-
>  system/dirtylimit.c      |   3 +-
>  system/qdev-monitor.c    |   4 +-
>  10 files changed, 81 insertions(+), 82 deletions(-)
> 
> -- 
> 2.45.0
> 

-- 
Peter Xu


