Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D27EC87FDB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 14:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulTvO-0002y0-Ny; Mon, 11 Aug 2025 10:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulTvL-0002x7-30
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 10:54:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulTvF-0003BS-W0
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 10:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754924086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GRnnvEsQmBcC7gW6m0H2EAcng3UjuI+S3sbxiIYnOc0=;
 b=iH40vI51gHJhiOErSaQuPrDEkaz1DtFTMAsAlf/OFm22twbckNFJu/Scw78N6l8GVORRma
 d+OGfs7ykBDXP8GY6601JsRGpL3C9FkoCnqoqcr4WQ3UwkX2olUovn6o6m/ViafW7rteI7
 RRBThIzZHOknsazcjI9ykSAG4OG3nXQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-RhgvbP3nPlGVARMVNnfKTw-1; Mon, 11 Aug 2025 10:54:44 -0400
X-MC-Unique: RhgvbP3nPlGVARMVNnfKTw-1
X-Mimecast-MFC-AGG-ID: RhgvbP3nPlGVARMVNnfKTw_1754924084
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7e82a101470so827746185a.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 07:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754924084; x=1755528884;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRnnvEsQmBcC7gW6m0H2EAcng3UjuI+S3sbxiIYnOc0=;
 b=lBeEH11UF6WE//hhmn2tYWn1lkMrWsFbm3d7bmvT/vHjmSGn5VAzfF/XkjVYFX1WAx
 dnddfpg8EN/PlGuwr8zxsjISTExF2Gdw13yo+9YiCvW+U4Tic5Z/niVNEFtWI1o9v5CG
 i2MODc38yplOI/imu89RYusWy/VVaAzf6j0fSyQ3CuPGyCT2TU4/X5aHubD5XkFQOUO+
 kXJm3CR1dicNrgDWl/e5P+1R8yT4+y0j3KMFYrYErR1MlDIg1N7d5FIAm7znnk84BwY5
 YUPvLK3dUjHcfNzIhwr8Ty23VjVnfjxEycTMI7a2RkpUIcQ9ubJY9/PGuoWow+5BLx6j
 Oszg==
X-Gm-Message-State: AOJu0Yyy8aYU3PtiIqn1FZEj7riI0/s1vPKNXONi+INZUFJkfS7x2UnB
 fty5GBkUY0WY34rugi849YLnL1/4hHaRCAsQe+eNf9qGTzKMIMwkoWfHVpCZd00EZ+PRduAGgyF
 6OnPeAV+hKt7uCzQWSFUuIObBgGgqUKdCINbTd5fc/TTclCi2bA6N+6tU
X-Gm-Gg: ASbGncv9/AILWHw7YG1Zd3MoQkfoflblKD3vMgmI37nWpgNca7+F228jL8Tk7+jwmWo
 iFMYvdBjipmhkh1uY1S44PpwxdTo9OiaOAsen+3Lzk2yzyTnl5lybvjCbMr4Q7M2DkrhdDPs8f7
 amo128IiK8eBpS2GvRd8LFxHPdXGQqwXBf+hF8AH4e4gOUsTMnryUW+9mwFnCzc5M1+wBfGJIig
 I8Os6E6MNTwEeKnfoTzw5ryIBc7LkI1gnfDp7v7wFx7m9GxCZeFLqCnQno8RAa9MprbJJoC+AZI
 vfnkEpSfFN+NTTdYnh7jAN7eNok3S6Tt
X-Received: by 2002:a05:620a:1d02:b0:7e6:82d0:4c81 with SMTP id
 af79cd13be357-7e85856f573mr29927185a.0.1754924083828; 
 Mon, 11 Aug 2025 07:54:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc1Qh66F7LmVrIeL/YNO46z+OTTN+qjpHMj9n/jxJ6jKBmgtpffe54ZWj9GWaSK+UjgabeTQ==
X-Received: by 2002:a05:620a:1d02:b0:7e6:82d0:4c81 with SMTP id
 af79cd13be357-7e85856f573mr29922285a.0.1754924083170; 
 Mon, 11 Aug 2025 07:54:43 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e84941a977sm249600785a.0.2025.08.11.07.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 07:54:42 -0700 (PDT)
Date: Mon, 11 Aug 2025 10:54:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [RFC PATCH 0/4] migration: Introduce postcopy-setup capability
 and state
Message-ID: <aJoEJhJw-_rGVBbA@x1.local>
References: <20250807114922.1013286-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250807114922.1013286-1-jmarcin@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

[Sorry to respond late on the real meat of this series..]

On Thu, Aug 07, 2025 at 01:49:08PM +0200, Juraj Marcin wrote:
> When postcopy migration starts, the source side sends all
> non-postcopiable device data in one package command and immediately
> transitions to a "postcopy-active" state. However, if the destination
> side fails to load the device data or crashes during it, the source side
> stays paused indefinitely with no way of recovery.
> 
> This series introduces a new "postcopy-setup" state during which the
> destination side is guaranteed to not been started yet and, the source
> side can recover and resume and the destination side gracefully exit.
> 
> Key element of this feature is isolating the postcopy-run command from
> non-postcopiable data and sending it only after the destination side
> acknowledges, that it has loaded all devices and is ready to be started.
> This is necessary, as once the postcopy-run command is sent, the source
> side cannot be sure if the destination is running or not and if it can
> safely resume in case of a failure.
> 
> Reusing existing ping/pong messages was also considered, PING 3 is right
> before the postcopy-run command, but there are two reasons why the PING
> 3 message might not be delivered to the source side:
> 
> 1. destination machine failed, it is not running, and the source side
>    can resume,
> 2. there is a network failure, so PING 3 delivery fails, but until until
>    TCP or other transport times out, the destination could process the
>    postcopy-run command and start, in which case the source side cannot
>    resume.
> 
> Furthermore, this series contains two more patches required for the
> implementation of this feature, that make the listen thread joinable for
> graceful cleanup and detach it explicitly otherwise, and one patch
> fixing state transitions inside postcopy_start().
> 
> Such (or similar) feature could be potentially useful also for normal
> (only precopy) migration with return-path, to prevent issues when
> network failure happens just as the destination side shuts the
> return-path. When I tested such scenario (by filtering out the SHUT
> command), the destination started and reported successful migration,
> while the source side reported failed migration and tried to resume, but
> exited as it failed to gain disk image file lock.
> 
> Another suggestion from Peter, that I would like to discuss, is that
> instead of introducing a new state, we could move the boundary between
> "device" and "postcopy-active" states to when the postcopy-run command
> is actually sent (in this series boundary of "postcopy-setup" and
> "postcopy-active"), however, I am not sure if such change would not have
> any unwanted implications.

Yeah, after reading patch 4, I still want to check with you on whether this
is possible, on a simpler version of such soluion.

As we discussed offlist, looks like there's no perfect solution for
synchronizing between src <-> dst on this matter.  No matter what is the
last message to be sent, either precopy has RP_SHUT, or relying on 3rd/4th
PONG, or RUN_ACK, it might get lost in a network failure.

IIUC it means we need to face the situation of split brain. The link can
simply be broken at any time.  The ultimate result is still better when two
VMs will be halted when split brain, but then IMHO we'll need to justify
whether that complexity would be worthwhile for changing "both sides
active" -> "both sides halted" when it happened.

If we go back to the original request of why we decided to work on this: it
was more or less a feature parity request on postcopy against precopy, so
that when device states loading failed during switchover, postcopy can also
properly get cancelled rather than hanging.  Precopy can do that, we wished
postcopy can do at least the same.

Could we still explore the simpler idea and understand better on the gap
between the two?  E.g. relying on the 3rd/4th PONG returned from the dest
QEMU to be the ACK message.

Something like:

  - Start postcopy...

  - Send the postcopy wholesale package (which includes e.g. whole device
    states dump, PING-3, RUN), as before.

  - Instead of going directly POSTCOPY_ACTIVE, we stay in DEVICE, but we
    start to allow iterations to resolve page faults while keep moving
    pages.

  - If...

    - we received the 3rd PONG, we _assume_ the device states are loaded
      successfully and the RUN must be processed, src QEMU moves to
      POSTCOPY_ACTIVE.

    - we noticed network failure before 3rd PONG, we _assume_ destination
      failed to load or crashed, src QEMU fails the migration (DEVICE ->
      FAILED) and try to restart VM on src.

This might be a much smaller change, and it might not need any change from
dest qemu or stream protocol.

It means, if it works (even if imperfect) it'll start to work for old VMs
too as long as they got migrated to the new QEMU, and we get this postcopy
parity feature asap instead of requesting user to cold-restart the VM with
a newer machine type.

Would this be a better possible trade-off?

Thanks,

-- 
Peter Xu


