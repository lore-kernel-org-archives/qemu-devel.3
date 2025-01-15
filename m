Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7FAC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 16:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY61G-00021H-Hm; Wed, 15 Jan 2025 11:13:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tY61E-00020T-9u
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 11:13:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tY61A-0006Td-Up
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 11:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736957597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IsqyoeXOvhOwzr0ho5xqotY1DYZhUuno8bCfSFQhT38=;
 b=a4kJVAwznWlbBxkYCO/IlwRvwSyJZ11KQ53bkdaxMOoDoLxhF605JuZYGHxuw3hAOEYOJI
 tgYl46RO85JfWlH4jlpjY8y2K2Dcj/t8s5k56FPLK+olz7goS7In+ITT8P8jkyC3q9Dx+R
 zPM6+As00w+Fdi7pqfYHnpKVYXNlM2U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-yNWazKxZMOmsMWxfMg7RKg-1; Wed, 15 Jan 2025 11:13:15 -0500
X-MC-Unique: yNWazKxZMOmsMWxfMg7RKg-1
X-Mimecast-MFC-AGG-ID: yNWazKxZMOmsMWxfMg7RKg
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43651b1ba8aso46938375e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 08:13:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736957594; x=1737562394;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IsqyoeXOvhOwzr0ho5xqotY1DYZhUuno8bCfSFQhT38=;
 b=Hc4qVbbrXFzM7DNBWbgJ02C2mvySBlRNfPIonDPoRVWiuA4bUsgd5KZl/twqPvFgB9
 Ohe4BAffjdZgHj8MjoM/J6gAjv+QQJ4nHI0tLOkuIhM9a2j6fAngflzoI3L8EzTNf1DD
 SyEyilXJ/+aatck2P+0Dz7ny7dLRa5SPPghZDaexJZd32PIuis2KNOZk8ZR58sUy8i3W
 2YZBjFYNewy0n4DIdrDs/1duiP9AFSvBNup2O2N9431lbHv5ItOiIqgFMhzVj/QCV7JG
 FrWTdV/F3tgQ+ENswLYSb6vPwdoUSZam4as9AolGZwPIZyPorjUUtgHPqY93bfRCupaN
 GzDA==
X-Gm-Message-State: AOJu0YxeyUxAPqhY29eSgtRNfDaaPaPoZ8UhJhRXBnidUMSQnkU4imz0
 pbFlYJZrTjIdATYKOdMi3/Vh+c4v77eRJbHkSvgcedQ62ZweZMUoatNEg+V9fUZaAIDkRjo97YP
 mvcTRJ3dvL1wYgahWZk23P84XA0roBC1OyxR3gJ8i3ffHIGFd6XdW
X-Gm-Gg: ASbGncuQLJi56r4UTNxT7nPtHWIXpXbg2fWu1Ysxi+hbGp2hnLjSfdnA0h41Gj7mVWC
 TZ4TzIKT+mjJ6E4pjLb9lgx9chDWEpzYyPzv3odw7WHSOneTr3mVS2Zt3PuYCs7YQeK8AB/pn3N
 vZP3bCYDlmxJP23AV2TYBG/sXZoYMDJY4+SXBLxv7QikBOPJR5HhCibAKL5qcRXcTeCLJMZcJqV
 zy23N1nT6L9aT7gc3ft7zPuBLli0CiAoZ2If+ENtQ2IwC+xecTp5SwtMGbXkxEfVPlYIU7/cpox
 2A==
X-Received: by 2002:a05:600c:4185:b0:436:ed38:5c85 with SMTP id
 5b1f17b1804b1-436ed385d5fmr249606565e9.14.1736957594431; 
 Wed, 15 Jan 2025 08:13:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7C4e5w/yckf+mmHVIQwr7VHm4LDz24fN1VZa48XaSAcaLqPU+P5EFDir0ikaQ/WKZHNCxrg==
X-Received: by 2002:a05:600c:4185:b0:436:ed38:5c85 with SMTP id
 5b1f17b1804b1-436ed385d5fmr249606265e9.14.1736957594017; 
 Wed, 15 Jan 2025 08:13:14 -0800 (PST)
Received: from rh-jmarcin (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499b28sm29730845e9.8.2025.01.15.08.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 08:13:13 -0800 (PST)
Date: Wed, 15 Jan 2025 17:13:11 +0100
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Julia Suvorova <jusual@redhat.com>, 
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 00/16] migration: Switchover phase refactoring
Message-ID: <ps5vrwsffaatemrbvaov7dtoqx2lrd5mvk3gwkp6d6wqi3yfwt@kiplq7pwzxri>
References: <20250114230746.3268797-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114230746.3268797-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
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

On 2025-01-14 18:07, Peter Xu wrote:
> CI: https://gitlab.com/peterx/qemu/-/pipelines/1625266692
>     (note: warning is present on rust stuff, but shouldn't be relevant)
> 
> This series refactors the migration switchover path quite a bit.  I started
> this work initially to measure the JSON writer overhead, but then I decided
> to cleanup the switchover path in general when I am at it altogether, as I
> wanted to do this for a long time.
> 
> A few major things I tried to do:
> 
>   - About the JSON writer
> 
>     Currently, precopy migration always dumps a chunk of data called VM
>     description (QEMU_VM_VMDESCRIPTION) for debugging purpose.  That is a
>     JSON blob explaining all the vmstates dumped in the migration stream.
>     QEMU has a machine property suppress-vmdesc deciding whether migration
>     will have that JSON chunk included.
> 
>     Postcopy does not have such JSON dump because postcopy is live session
>     and it can't normally be debugged from stream level (e.g. as a streamed
>     file).
> 
>     A tiny problem is we don't yet have a clue on how much cpu cycles we
>     need to construct and dump these JSONs even if they're only for
>     debugging, and even if suppress-vmdesc=on QEMU will still try to
>     construct these JSONs (e.g. also for postcopy).
> 
>     This series has a few patches just to make sure the JSON blob won't be
>     constructed if not needed (either postcopy, or suppress-vmdesc=on).  I
>     tried to measure the downtime diff with/without these changes, the time
>     QEMU takes to construct / dump the JSON blob is still not measurable.
>     So I suppose unconditionally having this is ok.  Said that, let's still
>     have these changes around so we avoid JSON operations if not needed.
> 
>   - DEVICE migration state
> 
>     QEMU has a very special DEVICE migration state, that only happens with
>     precopy, and only when pause-before-switchover capability is enabled.
>     Due to that specialty we can't merge precopy and postcopy code on
>     switchover starts, because the state machine will be different.
> 
>     However after I checked the history and also with libvirt developers,
>     this seems unnecessary.  So I had one patch making DEVICE state to be
>     the "switchover" phase for precopy/postcopy unconditionally.  That will
>     make the state machine much easier for both modes, meanwhile nothing is
>     expected to break with it (but please still shoot if anyone knows /
>     suspect something will, or could, break..).
> 
>   - General cleanups and fixes
> 
>     Most of the rest changes are random cleanups and fixes in the
>     switchover path.
> 
>     E.g., postcopy_start() has some code that isn't easy to read due to
>     some special flags here and there, mostly around the two calls of
>     qemu_savevm_state_complete_precopy().  This series will remove most of
>     those special treatments here and there.
> 
>     We could have done something twice in the past in postcopy switchover
>     (e.g. I believe we sync CPU twice.. but only happens with postcopy),
>     now they should all be sorted out.
> 
>     And quite some other things hopefully can be separately discussed and
>     justified in each patch.  After these cleanups, we will be able to have
>     an unified entrance for precopy/postcopy on switchover.
> 
> Initially I thought this could optimize the downtime slightly, but after
> some tests, it turns out there's no measureable difference, at least in my
> current setup... So let's take this as a cleanup series at least for now,
> and I hope they would still make some sense.  Comments welcomed.
> 
> Thanks,
> 
> Peter Xu (16):
>   migration: Remove postcopy implications in should_send_vmdesc()
>   migration: Do not construct JSON description if suppressed
>   migration: Optimize postcopy on downtime by avoiding JSON writer
>   migration: Avoid two src-downtime-end tracepoints for postcopy
>   migration: Drop inactivate_disk param in qemu_savevm_state_complete*
>   migration: Synchronize all CPU states only for non-iterable dump
>   migration: Adjust postcopy bandwidth during switchover
>   migration: Adjust locking in migration_maybe_pause()
>   migration: Drop cached migration state in migration_maybe_pause()
>   migration: Take BQL slightly longer in postcopy_start()
>   migration: Notify COMPLETE once for postcopy
>   migration: Unwrap qemu_savevm_state_complete_precopy() in postcopy
>   migration: Cleanup qemu_savevm_state_complete_precopy()
>   migration: Always set DEVICE state
>   migration: Merge precopy/postcopy on switchover start
>   migration: Trivial cleanup on JSON writer of vmstate_save()
> 
>  qapi/migration.json         |   7 +-
>  migration/migration.h       |   1 +
>  migration/savevm.h          |   6 +-
>  migration/migration.c       | 209 +++++++++++++++++++++++-------------
>  migration/savevm.c          | 116 ++++++++------------
>  migration/vmstate.c         |   6 +-
>  tests/qtest/libqos/libqos.c |   3 +-
>  migration/trace-events      |   2 +-
>  tests/qemu-iotests/194.out  |   1 +
>  tests/qemu-iotests/203.out  |   1 +
>  tests/qemu-iotests/234.out  |   2 +
>  tests/qemu-iotests/262.out  |   1 +
>  tests/qemu-iotests/280.out  |   1 +
>  13 files changed, 200 insertions(+), 156 deletions(-)
> 
> -- 
> 2.47.0
> 

All patches look good to me, nice refactor!

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>

-- 
Juraj Marcin


