Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4299DC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 18:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMXaT-0002RT-99; Wed, 26 Jun 2024 14:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sMXaR-0002QP-Nx
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 14:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sMXaP-00006U-PF
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 14:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719427300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9SiERUD2m2cCkLjQpirZNSzMxFYJh7SFwh3okXBBKys=;
 b=DJ9n9rx2uOkEgvGA4iD4vdat3VrJy3Qs5CD1L1G772Z+SRVXmoTAKxnuSwijrcGCOjuGQI
 7dQ5XGL5YhusiMiVyEYkZhTchuluNfuhr/IbAoFOEREI34bMvJH63u4ryXwJOyiF/mwjZB
 a/3yM+cPpXPm+0ukKCrP0X7wlYLT418=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-R2MMydemP12BLXZR6KO5ow-1; Wed, 26 Jun 2024 14:41:38 -0400
X-MC-Unique: R2MMydemP12BLXZR6KO5ow-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-63128981dfcso2615677b3.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 11:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719427298; x=1720032098;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9SiERUD2m2cCkLjQpirZNSzMxFYJh7SFwh3okXBBKys=;
 b=qDu82j83wQzJ5Sv5/HEeTdn5w7NVFb6soRrjoJPdXdohGA+6yTRMuKkDGiWcsV+6iM
 owhgc6YnSrtmMJxZvr8mHs7vaZZSV1vqVjhm8tEfmHYPeRfXQgK6baNgz4hW544rAJTR
 B70/uEUkrOXW1LGBhqerSSWiT8OZD/Yfc4dvt7f5vl1Zv6xO4PAONwM/byGyWo6eEXPu
 qwWpbOxPDTZI1hr1GkDVHJn1Bi2g/aHT77BV5QYu/GB7oSx9YIxt13doVOhfD6sQ5aQ+
 UfGDHj6cnDGZUWMlpt17waly8Sd6QUGsUJNW7PT/TulBbdfiXkNSi2t/Iow/+rUIbcSh
 R7cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaKmc4aNpvBxDjt9YvZclk68av108J5kAOQskFqYV9K0bF5eGWZLX+PLtY0pPbddjP1+oVnIQ77x2y2t1ED70GNa+94B0=
X-Gm-Message-State: AOJu0YzhkFbfkxTlZ6w4qGA6dksM1sMcnHyGgoXQoGzfJcnwqQil3cte
 aqlMi4z+DTL9zsEyBxPlWUJwf+2/rTaaNsvuQBJ5rAj+dDxT9FVIC9n0h8P2/L5+d2V0fzjnLDX
 vr8jH1JOh4MbOHEI72XgWQOit6PGomCZQrEFYo9/DyR3a+zkgq6Tj
X-Received: by 2002:a05:690c:c90:b0:627:e34e:14de with SMTP id
 00721157ae682-6419996ebb9mr100338807b3.5.1719427297809; 
 Wed, 26 Jun 2024 11:41:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7LXDrqSwSDPr2CWagT206Yz4lRW0eqLOBixozfikfMP0cTfINNDF6CCgtDZn55Qih+h3sIg==
X-Received: by 2002:a05:690c:c90:b0:627:e34e:14de with SMTP id
 00721157ae682-6419996ebb9mr100338527b3.5.1719427297318; 
 Wed, 26 Jun 2024 11:41:37 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b51ef30eddsm57159256d6.86.2024.06.26.11.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 11:41:36 -0700 (PDT)
Date: Wed, 26 Jun 2024 14:41:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-devel@nongnu.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com
Subject: Re: [PATCH RFC 2/2] migration: abort on destination if switchover
 limit exceeded
Message-ID: <Znxg3jyYAfJQIHUB@x1n>
References: <20240621143221.198784-1-elena.ufimtseva@oracle.com>
 <20240621143221.198784-3-elena.ufimtseva@oracle.com>
 <ZnnL42_iDip3hfUh@x1n>
 <9eeea2a9-b3ef-4791-94de-fb06ad2bd9b4@oracle.com>
 <ZnrZ9W6WpvmDBpgv@x1n>
 <5953224c-9763-4806-ba72-c3cd87a71210@oracle.com>
 <ZnsUnKZHtsMKQc_2@x1n>
 <3af67d66-075d-4162-916b-b407332042e2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3af67d66-075d-4162-916b-b407332042e2@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 26, 2024 at 12:04:43PM +0100, Joao Martins wrote:
> Are you thinking in something specifically?

Not really. I don't think I have any idea on how to make it better,
unfortunately, but we did some measurement too quite some time ago and I
can share some below.

> 
> Many "variables" affect this from the point we decide switchover, and at the
> worst (likely) case it means having qemu subsystems declare empirical values on
> how long it takes to suspend/resume/transfer-state to migration expected
> downtime prediction equation. Part of the reason that having headroom within
> downtime-limit was a simple 'catch-all' (from our PoV) in terms of
> maintainability while giving user something to fallback for characterizing its
> SLA.

Yes, I think this might be a way to go, by starting with something that can
catch all.

> Personally, I think there's a tiny bit disconnect between what the user
> desires when setting downtime-limit vs what it really does. downtime-limit right
> now looks to be best viewed as 'precopy-ram-downtime-limit' :)

That's fair to say indeed.. QEMU can try to do better on this, it's just
not yet straightforward to know how.

> Unless the accuracy work you're thinking is just having a better
> migration algorithm at obtaining the best possible downtime for
> outstanding-data/RAM *even if* downtime-limit is set at a high limit,
> like giving 1) a grace period in the beginning of migration post first
> dirty sync

Can you elaborate on this one a bit?

> or 2) a measured value with continually incrementing target downtime
> limit until max downtime-limit set by user hits ... before defaulting to
> the current behaviour of migrating as soon as expected downtime is within
> the downtime-limit. As discussed in the last response, this could create
> the 'downtime headroom' for getting the enforcement/SLA better
> honored. Is this maybe your line of thinking?

Not what I was referring, but I think such logic existed for years, it was
just not implemented in QEMU.  I know at least OpenStack implemented
exactly that, where instead of keeping an internal smaller downtime_limit
and keep increasing that, OpenStack will keep adjusting downtime_limit
parameter from time to time, starting with a relatively low value.

That is also what I would suggest to most people who cares about downtime,
because QEMU does treat it pretty simple: if QEMU thinks it can switchover
within the downtime specified, QEMU will just do it, even if it's not the
best it can do.

Do you think such idea should be instead implemented in QEMU, too?  Note
that this will also be not about "making downtime accurate", but "reducing
downtime", it may depend on how we define downtime_limit in the context,
perhaps, where in OpenStack's case it simply won't directly feed that
parameter with the real max downtime the user allows.

Since that wasn't my original purpose, what I meant is simply see ways to
make downtime_limit accurate, and by analyzing the current downtimes (as
you mentioned, using the downtime tracepoints; and I'd say kudos to you on
suggesting that in a formal patch).

Here's something we collected by our QE team, for example, on a pretty
loaded system of 384 cores + 12TB:

Checkpoints analysis:

            downtime-start ->               vm-stopped:             267635.2 (us)
                vm-stopped ->           iterable-saved:            3558506.2 (us)
            iterable-saved ->       non-iterable-saved:             270352.2 (us)
        non-iterable-saved ->             downtime-end:             144264.2 (us)
                                        total downtime:            4240758.0 (us)

Iterable device analysis:

  Device SAVE of                                      ram:  0 took    3470420 (us)

Non-iterable device analysis:

  Device SAVE of                                      cpu:121 took     118090 (us)
  Device SAVE of                                     apic:167 took       6899 (us)
  Device SAVE of                                      cpu:296 took       3795 (us)
  Device SAVE of             0000:00:02.2:00.0/virtio-blk:  0 took        638 (us)
  Device SAVE of                                      cpu:213 took        630 (us)
  Device SAVE of             0000:00:02.0:00.0/virtio-net:  0 took        534 (us)
  Device SAVE of                                      cpu:374 took        517 (us)
  Device SAVE of                                      cpu: 31 took        503 (us)
  Device SAVE of                                      cpu:346 took        497 (us)
  Device SAVE of             0000:00:02.0:00.1/virtio-net:  0 took        492 (us)
  (1341 vmsd omitted)

In this case we also see the SLA violations since we specified something
much lower than 4.2sec as downtime_limit.

This might not be a good example, as I think when capturing the traces we
used to still have the issue on inaccurate bw estimations, and that was why
I introduced switchover-bandwidth parameter, I wished after that the result
can be closer to downtime_limit but we never tried to test again.  I am not
sure either on whether that's the best way to address this.

But let's just ignore the iterable save() huge delays (which can be
explained, and hopefully will still be covered by downtime_limit
calculations when it can try to get closer to right), and we can also see
at least a few things we didn't account:

  - stop vm: 268ms
  - non-iterables: 270ms
  - dest load until complete: 144ms

For the last one, we did see another outlier where it can only be seen from
dest:

Non-iterable device analysis:

  Device LOAD of                              kvm-tpr-opt:  0 took     123976 (us)  <----- this one
  Device LOAD of              0000:00:02.0/pcie-root-port:  0 took       6362 (us)
  Device LOAD of             0000:00:02.0:00.0/virtio-net:  0 took       4583 (us)
  Device LOAD of             0000:00:02.0:00.1/virtio-net:  0 took       4440 (us)
  Device LOAD of                         0000:00:01.0/vga:  0 took       3740 (us)
  Device LOAD of                         0000:00:00.0/mch:  0 took       3557 (us)
  Device LOAD of             0000:00:02.2:00.0/virtio-blk:  0 took       3530 (us)
  Device LOAD of                   0000:00:02.1:00.0/xhci:  0 took       2712 (us)
  Device LOAD of              0000:00:02.1/pcie-root-port:  0 took       2046 (us)
  Device LOAD of              0000:00:02.2/pcie-root-port:  0 took       1890 (us)

So we found either cpu save() taking 100+ms, or kvm-tpr-opt load() taking
100+ms.  None of them sounds normal, and I didn't look into them.

Now with a global ratio perhaps start to reflect "how much ratio of
downtime_limit should we account into data transfer", then we'll also need
to answer how the user should set that ratio value, and maybe there's a
sane way to calculate that by the VM setup?  I'm not sure, but those
questions may need to be answered together in the next post, so that such
parameter can be consumable.

The answer doesn't need to be accurate, but I hope that can be based on
some similar analysis like above (where I didn't do it well; as I don't
think I looked into any of the issues, and maybe they're fix-able).  But
just to show what I meant.  It'll be also great when doing the analysis we
found issues fix-able, then it'll be great we fix the issues intead.
That's the part when I mentioned "I still prefer fixing downtime_limit
itself".

Thanks,

-- 
Peter Xu


