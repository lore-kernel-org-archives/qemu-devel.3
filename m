Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF97C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 19:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAELt-00039P-DU; Thu, 23 May 2024 15:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sAELr-00038W-O4
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:43:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sAELq-0002xG-AM
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716493424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ncNMcT+e1P1+hJLONPU0NxPQD/JteHLQFan6GKiAvg=;
 b=AhGNIpVEvWrl3BkD9rjjXr+36mJMpXwo7ATqQbvxBQOn8z+aHJAFrIZ/AaU5q8Dj2XWIqA
 e0TGqrxToyWG3/8m0dbH2CpTolfnVdeYpDvJZOjHl5XNrFk8M2xPpt9PrHtYc3PYzvLctp
 nPlnQgnzo2sW9aA9I4RxLWxpNtWy+3k=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-QmC8Dq9hMzConAZuVw9KPA-1; Thu, 23 May 2024 15:43:43 -0400
X-MC-Unique: QmC8Dq9hMzConAZuVw9KPA-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-804cadd0835so13229241.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 12:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716493421; x=1717098221;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ncNMcT+e1P1+hJLONPU0NxPQD/JteHLQFan6GKiAvg=;
 b=aHHj8CyhiYnNukkR+djDKBShZRs363JkjCm5IbWUdBsoMc5gAgCUzGb1zQGRLIQjIv
 zU1LlfvJx1vo4be9EX47et5XYd2Hn/2Dxgzek76dc62h3788NQfT1tpRJWtGcMG71Fhc
 N/pfH2PpWa9x6RCuT6Ndu7bJFHoXCawTDdT7G2kkyC+0jZIaCSed+pYyoRUVY4Ss4RGI
 qsTCtZNGPi61W/oQNMZBjByYBIjBtC9VKy5pSx1VYPVOwfGDaV5/jct3PpR0wzPLQWek
 Q6zNdZbtwgswW7MsIJcz3pm7c1LJvFmcz917hz9pSjBHgHUF9EatUho4BnmC3+bsaJ/j
 VE3g==
X-Gm-Message-State: AOJu0Yx4z84Y43LDIAC+WmPyjjkaDvUQ7bTL5yVGZBKlrZ9ZdqpSu8xw
 EW7cv9bW22OpP6MtwotvFH97vKICvQglaBTzUR94Pbg3auQd2VqW/xQ4XgOx8vY8ClpwfI9r1H+
 qF8UezZm8KwFbR5Q+0yk/cu13kJZHwQFF8o6JftNqmHwCFnhUqNQO
X-Received: by 2002:a05:6102:508c:b0:47e:d83:3baa with SMTP id
 ada2fe7eead31-48a385060e9mr497406137.1.1716493421304; 
 Thu, 23 May 2024 12:43:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYV9r14ddpJGyTWcdfRx9gkkRPI0U1UrbWF8cUKJ4pAqffscKWIQsF1rwRAMAG1zmTxCgKBw==
X-Received: by 2002:a05:6102:508c:b0:47e:d83:3baa with SMTP id
 ada2fe7eead31-48a385060e9mr497379137.1.1716493420737; 
 Thu, 23 May 2024 12:43:40 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43faaf0f266sm9783071cf.92.2024.05.23.12.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 12:43:40 -0700 (PDT)
Date: Thu, 23 May 2024 15:43:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, fam@euphon.net,
 kwolf@redhat.com, hreitz@redhat.com, marcandre.lureau@redhat.com,
 farosas@suse.de, pbonzini@redhat.com, richard.henderson@linaro.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH 5/6] migration: Rephrase message on failure to save /
 load Xen device state
Message-ID: <Zk-cZFil8GYo0JY8@x1n>
References: <20240513141703.549874-1-armbru@redhat.com>
 <20240513141703.549874-6-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240513141703.549874-6-armbru@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, May 13, 2024 at 04:17:02PM +0200, Markus Armbruster wrote:
> Functions that use an Error **errp parameter to return errors should
> not also report them to the user, because reporting is the caller's
> job.  When the caller does, the error is reported twice.  When it
> doesn't (because it recovered from the error), there is no error to
> report, i.e. the report is bogus.
> 
> qmp_xen_save_devices_state() and qmp_xen_load_devices_state() violate
> this principle: they call qemu_save_device_state() and
> qemu_loadvm_state(), which call error_report_err().
> 
> I wish I could clean this up now, but migration's error reporting is
> too complicated (confused?) for me to mess with it.

:-(

> 
> Instead, I'm merely improving the error reported by
> qmp_xen_load_devices_state() and qmp_xen_load_devices_state() to the
> QMP core from
> 
>     An IO error has occurred
> 
> to
>     saving Xen device state failed
> 
> and
> 
>     loading Xen device state failed
> 
> respectively.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


