Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE9ECD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmfV-0005Fm-8z; Wed, 20 May 2026 15:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPmfN-0005EC-Eh
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:33:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPmfL-0004tP-Ht
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779305594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N0PvjMYu4v53lEyBT+z1PsEfhXNlX0SSHAMJqJG/lo0=;
 b=fw/eLxt9NWLa3vAr61KFWgjb17HtAhIOV2AIe8q1HlHoMMNj9SiNtuLYZ0YebAjTrRRHto
 EroEjABmfYbWTMWeBcrkOpzlvlcd0iTF2ZxM2Gn0VHBrgXC7GMe+hq/G+IZN7MM8UPaqm8
 7j6k0RHl/3H1TheXHtzaV+IIXaPnUx0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-dy56DQm5PZCjgzXQ2-zvng-1; Wed, 20 May 2026 15:33:10 -0400
X-MC-Unique: dy56DQm5PZCjgzXQ2-zvng-1
X-Mimecast-MFC-AGG-ID: dy56DQm5PZCjgzXQ2-zvng_1779305590
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d890580e1so115926341cf.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779305590; x=1779910390; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N0PvjMYu4v53lEyBT+z1PsEfhXNlX0SSHAMJqJG/lo0=;
 b=O543ZnMfiuxRYpgqgnKKWKFREtMn8+GfRhdqWK6ei8LPcTr+WNc688mLDLPsEVjcKc
 59VJCFXjP+gqA4UUUaCl9ppEoAh1DzyOyFi7l8ahnXldDO3qN+fRWZ6FJ+MS/1k7gM2Z
 drZUL5lOmqLOe7r6Gi4mFSjkzvMtR6aKYbI5GDUZ0nqOIRiMtdvGf+tCA8LRVpwgU7dJ
 VftSbYDXhUfwqIg9wXsengTHFEAqpI2R4SxWlC655JZyuqsU0hwn9B0t+/vtLn2+z5xL
 ddQgKPQ1CSVQbGOZ/KKwAGfbQIsUF2PY2TThs2lqlPt+uQNxF2nzNzhMNsSf56hgSHFC
 h0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305590; x=1779910390;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N0PvjMYu4v53lEyBT+z1PsEfhXNlX0SSHAMJqJG/lo0=;
 b=kwS6/tFHCDZp1NTjHmzWDKFCzErAMawv35EXe5jsxwXmAJ01fIG5x1SQ0mydHpqTub
 fsuhuSGTRranYbQqy46ntZX5R3X97j3j0dsqaqbvQMsxS5XDi/mwwS03RVv5liumaAwd
 G/Zdr+ThGOVfNo/001LvBBPzxuRSCzW3eTgqaY+UPSHFjJO4IAqWBLI66FKP72h5Oa2E
 5RoAZJ8AXGQBtsEiiIBZOEvWtHgoeNogTbL4n1JTf1HmWRSkZ6WnZTtqZAUuU3+7O9GZ
 xukhzsLFJfhpZV6VK8oXaRFmm4I8kradqi+UKuBScYzJPyyxUyRHPVQvA6kYuUkeqdiZ
 fg0Q==
X-Gm-Message-State: AOJu0YyV8DH16nSM/VBt4fwgjgzGtuZVZCTtMFQKVWuQd3x6sSg0OHNv
 CNIHCHouhXJpqk9EXMgQ264ACQF27XPg6GZE5frtn5ne7h9WKaJlSF5AxV/P++Di3bK89Z6xfNC
 ha4zCJoThniY398m2g7mdImCm7Cug3jHKxzXlTzP0wmaQcr3WQ6Z4qndX
X-Gm-Gg: Acq92OGLuD6P/hb6crQI7NqzefNHsC80jj8zwNyo3NhXWxBWOCOye3vJY0lARJC9hFv
 ahanneU6xoQ980h9CzLMU7z4B9migvgVdIZi6+sZ5FHAUA9BrMC8WHMDhlorMjThi1xHvruLoin
 9QwhwP6G809JoXhFXPU0SstzRBo5F3OW8hdJBRbQjyOrSgCGpD1aQFAE1DSwrhHyzc/xCgEWqK1
 Yfel3PuPZ4UlyJwyoT0F6aNAne54AyhuQMAlWBnb59S1WUHbTrrctT+BlbA+owz2Glqa4eWrq0L
 m1uOMt1ex72tqdNVG3jLhFRoY+SnpSVH5lEpiR1Gd2eUImDXsZxOAJdU0cwf1I+s4/cbh/omFEw
 ZFrkTVvx0cFSRNtLstSb/3ZHFPyFcxjhKmhAFz8+XP3DDuZ0=
X-Received: by 2002:a05:622a:5814:b0:50d:9b4a:e6f with SMTP id
 d75a77b69052e-5165a012120mr339935461cf.1.1779305589464; 
 Wed, 20 May 2026 12:33:09 -0700 (PDT)
X-Received: by 2002:a05:622a:5814:b0:50d:9b4a:e6f with SMTP id
 d75a77b69052e-5165a012120mr339934591cf.1.1779305588740; 
 Wed, 20 May 2026 12:33:08 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5164585cf66sm203711111cf.30.2026.05.20.12.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 12:33:08 -0700 (PDT)
Date: Wed, 20 May 2026 15:33:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH 0/8] migration: cleanups, fixes and micro-optimizations
Message-ID: <ag4McsK60Za6k72c@x1.local>
References: <20260518110112.21395-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260518110112.21395-1-guobin@linux.alibaba.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 18, 2026 at 07:01:04PM +0800, Bin Guo wrote:
> This series collects several small improvements to the migration
> subsystem:
> 
> - Bug fix: off-by-one in multifd recv channel ID validation that
>   could allow an out-of-bounds write (patch 5).
> - Micro-optimizations: cache migrate_multifd_channels() in hot
>   paths (patches 7-8), use stack-allocated bitmap instead of
>   heap (patch 4), avoid per-element heap churn in vmstate ptr
>   marker field (patch 3).
> - Cleanups: collapse migration_fd_valid into a single boolean
>   expression (patch 1), replace strcpy("") with explicit NUL
>   termination (patch 2), merge thread-join and cleanup loops in
>   multifd_recv_cleanup (patch 6).
> 
> No functional change intended except for the off-by-one fix in
> patch 5.
> 
> Bin Guo (8):
>   migration/fd: collapse migration_fd_valid into single boolean
>     expression
>   migration/global_state: replace strcpy("") with explicit NUL
>     termination
>   migration/vmstate: avoid per-element heap churn in vmsd ptr marker
>     field
>   migration/savevm: use stack-allocated bitmap in
>     configuration_validate_capabilities
>   migration/multifd: fix off-by-one in recv channel ID validation
>   migration/multifd: merge thread-join and cleanup loops in
>     multifd_recv_cleanup
>   migration/multifd: cache migrate_multifd_channels() in send/recv hot
>     paths
>   migration/multifd: cache channel count in multifd_send_sync_main

For patch 1, I tend to agree with Fabiano; I don't clearly see why the
oneliner is always better.  Oneliners can be harder to read to some (for
most of the cases, myself included..).

For patch 6, I confess I can't see an issue with the current patch, but
since there's a discussion, let it happen.

I queued the rest, thanks.

-- 
Peter Xu


