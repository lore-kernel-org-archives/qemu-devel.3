Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10527F8D755
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 18:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDRnb-0006SM-RP; Thu, 16 Apr 2026 14:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wDRnV-0006S1-MD
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 14:50:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wDRnP-0002mH-T8
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 14:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776365434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jX11VQcvPfS9Q5lr1veyNW7Wdf2XGmDXi6xA56e1oRk=;
 b=TFGZaffPDjxIJQ8AMoyUQma21Dj9T8QPlXRasPGBI1KF0aRe+DM9C+yfG8w+h4a+91TaYd
 OjB0Ni/PW/u0TDKVq1DGJO6kzt7VNwDyQANLklz7/YRUp1F07hMSdNBbZiFDrQer/DgStG
 b2wI/KgtLQsMEDNXceI/25WVlbatcOU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-QMV3s0rnOPySz-9p0ShQ2w-1; Thu, 16 Apr 2026 14:50:32 -0400
X-MC-Unique: QMV3s0rnOPySz-9p0ShQ2w-1
X-Mimecast-MFC-AGG-ID: QMV3s0rnOPySz-9p0ShQ2w_1776365432
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ac566014e0so233751976d6.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776365432; x=1776970232; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jX11VQcvPfS9Q5lr1veyNW7Wdf2XGmDXi6xA56e1oRk=;
 b=dUeHY8Qt2QzLi9aOyWmD/puxjBxtkNXItmeI0GGJr0mxEkJJbTErt2Ia9dTphCmoXo
 IYvbW9a4T/n9Gnds9P6JEiXafEHL5TPzILqEOph49vJNT6h6WcWGLU/pgqu2tG+y57rs
 1xq2UAjyMAUAYQDb/YoNFox7cT538bbdIXw6u7pnriw8pGD0/z+5mVlxgDeDNNKEee1e
 QcNhkz8G144ecvdkx0J2lGmPX4xh/75uB3orqiZ4BaOYw+jliURoImmvc0lJ8cGMZVNd
 zlVLyLTkEGP5qGwvs/9veKvar9Lg4bsX6E2Lx9dYtt6OUEfZUeGIUn+sZBpMKF+XypaO
 XOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365432; x=1776970232;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jX11VQcvPfS9Q5lr1veyNW7Wdf2XGmDXi6xA56e1oRk=;
 b=DvKzb7+kQtWrkRe9T3DXPqdW89/DOcfofnUpMP6z7pHKVHGTF/hGFAumATPjhoINQz
 nwY9gmp5fUv9tSm9rDZoVkQCl7ZtZMukJcDqIDvwmkPrIXouThP9aBBrvfCsmK4LW4yO
 ZF7efZxb/JVmK7/InsEBjPILnRVg0Rqjy4jTSgW8K3wm+qo20QwOlpQTveSbivuKu+pC
 hvEdKvIQylUDtOP1NyiNAX55pWbxNJYjNMHvRFN0Uh/+VnLnNQ2qSWcLMpXCx7hdW2/7
 Hy6/uWmX2/VD0JgKAsi3EsPGOzyXfvfqkJ3SRtmg1fqGj3J81CnfcxY9gqGgSK3yFcvp
 yGIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QYAbPeuSDyuBn6EwD5HtBARZmMy0Tx6+7K85QuFiI/VjmO+QvtNf8Sr8X25EXxudoOI6WyxLT4w4n@nongnu.org
X-Gm-Message-State: AOJu0YxAN3RlNrU6tlUGcLjxo/4Fy7/qZxzuNszbKeeDIhfImK22ZXWV
 dhQAdojeLbMgPq8CkljeoB9FWXAbu1Kk/2Rq9+t8e6f1HB6f08qtd7ugkYi0xvauLmYb/rcCR/y
 WA4s9aXXR/wmcrc1oybzskurbOrLBMGy1hd9dortyqoQULBDTlFq0qOo1
X-Gm-Gg: AeBDieuqU5V4UhrBBOQkEENYk4LLF7P1g0n6UUS998FmT5csUyaWVlVl/sP1lkwBjX6
 h3Dw4JqZ7NmnVQpcbzP6V6NHBVaMtMQ9Y1mjrJJQg128Y3hdWjS6guoZt4OyVcbXWvwcet4YHWG
 9frEps/4/KKPREIj8Rn5dZEqv5OEcneFgmeTnZYvetAurqp0qCPhikU4KP3mgIrRlsDj+QUTJ3Z
 vAHJFi8BkLGoiQoGvrAN2Anh5m/oUrwm0tnMY0O55XIZ4YdVQuldvhpyDhVBgt6DzWh54soahJf
 edZmyFD4Gnfy6uvKv9XmnsGKLkWfXzoi/1MZVnPpGucudcXtG6N3UQRe+a96CrT6O+70elPPthx
 f10S2USieYBmTdZrSysAeLm1sKeVRTijbrr11YPxIfD58vxI6TMsQBObQtA==
X-Received: by 2002:a05:6214:8082:b0:89f:9bc2:20d1 with SMTP id
 6a1803df08f44-8b025dade57mr8042946d6.7.1776365432176; 
 Thu, 16 Apr 2026 11:50:32 -0700 (PDT)
X-Received: by 2002:a05:6214:8082:b0:89f:9bc2:20d1 with SMTP id
 6a1803df08f44-8b025dade57mr8042426d6.7.1776365431718; 
 Thu, 16 Apr 2026 11:50:31 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6cb9ecbasm41875576d6.30.2026.04.16.11.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:50:31 -0700 (PDT)
Date: Thu, 16 Apr 2026 14:50:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: Claudio Fontana <cfontana@suse.de>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org, Jim Fehlig <jfehlig@suse.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH 0/2] migration: include timing and RAM stats on
 destination when query-migrate
Message-ID: <aeEvdT0gzpOfDksG@x1.local>
References: <20260405152612.93027-1-viking4@gmail.com> <878qb05gq7.fsf@suse.de>
 <ada038hgmY9hNqPK@x1.local>
 <5f29c2dd-95eb-44c6-b22e-1909f7453cdf@suse.de>
 <ad1a9GaGQFHS4UHx@x1.local>
 <spjcuqt626vglmkxxal6ntrttaiwlapcbltrix5eslmyr7yirx@cegi5c5lvay2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <spjcuqt626vglmkxxal6ntrttaiwlapcbltrix5eslmyr7yirx@cegi5c5lvay2>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Apr 16, 2026 at 11:53:55PM +0700, Trieu Huynh wrote:
> Hello Peter,

Hi, Trieu,

> One specific use case where the source is completely unavailable is loading 
> from a migration snapshot (non-live).
> In this scenario, there is no active source QEMU to query_for_stats. The 
> dst (IMHO) is the only entity that can report how long the loading took 
> and how much data was actually processed from the snapshot file.
> This use case is a little bit niche but still a valid one though, isn't it?

Yes it's in general valid, but it also depends.  There's a reason that QEMU
supported load snapshot over the years and nobody was asking for it.  I
believe it's because people simply don't need it.

Load snapshot, unlike generic form of live migration, doesn't have much
uncertainty on its own.  It should either succeed after a while, or fail
with an error.  People should not expect to need to query anything.

It will likely, and should, hold true even if with async load snapshot in
the future.

It is only valid in that it might be useful for developers who works on
snapshot, especially tuning the performance.  But then it also means we
shouldn't expose it to an user API (QMP is in this case).  For dev only
reportings, we should rely on trace points unless we have good reason to
make it visible to users.

In general, we don't need to add unnecessary API maint burden to ourselves
when not needed.

Thanks,

-- 
Peter Xu


