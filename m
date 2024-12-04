Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF2BE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 18:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIuHy-0003un-Hg; Wed, 04 Dec 2024 13:39:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIuHx-0003ud-3O
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 13:39:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIuHv-0007Zv-Ex
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 13:39:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733337589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bYiT+BJmNsd3DbcuWRlTH4ILSZuN7w4IKIzluWvPt84=;
 b=TPOJwPnkgo8StZf69WXnKI0+ON1QfFPa2unQYqq42BBsqVcEtOS7BXG/siyGiMqHsC6lXx
 M0HKC2/b0C9I4JghBrnro7Iq0z/i8nzUB8GqBCyNpmM469fUPCZiNOrHTiL83RYH/UTehu
 jYVZPF1cVp28fdbSvsfRjxpUnEoh38w=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-6QvpUxPoMmWF1qhMlZcYEQ-1; Wed, 04 Dec 2024 13:39:48 -0500
X-MC-Unique: 6QvpUxPoMmWF1qhMlZcYEQ-1
X-Mimecast-MFC-AGG-ID: 6QvpUxPoMmWF1qhMlZcYEQ
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3ea305e40ceso187036b6e.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 10:39:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733337587; x=1733942387;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bYiT+BJmNsd3DbcuWRlTH4ILSZuN7w4IKIzluWvPt84=;
 b=BtB8r4zn455Vja5KqUVzxPYp/XPBI3UW0gGqkz/Oq87M5R2OKJ5nFExOMF22BMleEe
 KWtOqefY0H+gdXoPbBpEdxbLRsgH3dFm00taVKYvTC3G38o+F/3UDiiq2uB/MxxfojmI
 x7nzBkgkQEtTGhxGmV4VlSn+x7in69WYgtcZiAl7lv8FbhLolgQzykLZDteo3GhJionL
 mB0flJuMFZWIO5bUzUdX8MNzPzw9QJcdSKDlBqzBWYv9dznd0xp/3ObTlPKFFjlFELsS
 guP2qKspPNYbn4gPY0rV/xwTaR/wWODuH6llfb3K6gHOsd4f1D6mrxDM366je+IsbxDf
 y6xA==
X-Gm-Message-State: AOJu0Yx9s8bGi/q3a6snOMH7hqA3Tx7U69EFGGndm747Tkd/IWxfZz9p
 jdLAbIiGedFONewGnzO2fVI6wXJ1gxAPQXM3XwAqO5l+fUOjGyaaaUcRSY21uE1dvc8IfGld94O
 qk/leEJOOBn3s1Kt3g5E3EhzFvdFApGKsLqDZHWE3e7Ksj9HvPHq1
X-Gm-Gg: ASbGncsLl1/PszzPEg4aKeHujPUI4XIewQEtXLOHAZaDi1PfARyoQ6NQsZ6tVpExftx
 3wminF67Mm/vdxsgm1tkx7aQGApkPcwlIHurtZESrHT3Kns/ZxyqG2UItFSM1K2cje5Yhn0MWIN
 1xAVe0Aayb3JreQ3HN2GWAcj7FZeGerTGD+ezmHFiuuIcFdkSRGXlonEAPT9Syia0lxIty1W5ci
 9kKsADJ1fTKuAcZAhKQIjbMmVtrvgbh2lyLF9wXkx5e8JfgouG51zpVzUU69uN1XDiTYVmt7d4R
 ukPwYa/Gl8k=
X-Received: by 2002:a54:4793:0:b0:3ea:f809:44d0 with SMTP id
 5614622812f47-3eaf809469bmr3029938b6e.35.1733337587324; 
 Wed, 04 Dec 2024 10:39:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEd9bwpMT4NicnAecom+O63Aw4/Z9W3XH4/yL9AoOGuDg5zElSEchrukkdMNeByW2hrc9FsSw==
X-Received: by 2002:a54:4793:0:b0:3ea:f809:44d0 with SMTP id
 5614622812f47-3eaf809469bmr3029926b6e.35.1733337587019; 
 Wed, 04 Dec 2024 10:39:47 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d891919b43sm56015466d6.113.2024.12.04.10.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 10:39:46 -0800 (PST)
Date: Wed, 4 Dec 2024 13:39:44 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 2/6] migration: Kick postcopy threads on cancel
Message-ID: <Z1Ch8HpiKMoqILDM@x1n>
References: <20241202220137.32584-1-farosas@suse.de>
 <20241202220137.32584-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241202220137.32584-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Mon, Dec 02, 2024 at 07:01:33PM -0300, Fabiano Rosas wrote:
> Make sure postcopy threads are released when migrate_cancel is
> issued. Kick the postcopy_pause semaphore and have the fault thread
> read 'fault_thread_quit' when joining.
> 
> While here fix the comment mentioning userfault_event_fd.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

I remember when working on postcopy, I thought about failing migrate-cancel
for postcopy in general, rejecting such request.  And when working on the
recover feature, there's no concern on having it being cancelled, because
the user really shouldn't do that..

The problem is migrate-cancel means crashing the VM on both sides when QEMU
already goes into postcopy stage.

If the user wants to crash the VM anyway, an easier way to do is killing on
both sides.

If the user wished to cancel, we should tell them "postcopy cannot be
cancelled, until complete".  That's probably the major reason why people
think postcopy is dangerous to use..

Or do we have any use case this could be a valid scenario?

-- 
Peter Xu


