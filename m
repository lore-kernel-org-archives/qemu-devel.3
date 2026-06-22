Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A08CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 20:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wblBG-0005oB-I8; Mon, 22 Jun 2026 16:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wblB7-0005nP-MH
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 16:23:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wblB2-0006py-5R
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 16:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782159805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CPEP6gHhqNKJhrtW+PUpBGCpELK13U8EoAVNjsbwg7M=;
 b=JJVrD8Q5h+WXaNKrDwaIJowiiOHyZogvlsk6pqYF4morRfnWYXWdoE/jtt8euGAinCIzRj
 qrluyu1JlPxR0c3IPcXK3tMFqdcPtJp0dL3XZ8giOO8kwSfVyN4J/2KGsP3dgNZEWDF65i
 abgcEkpfPLp3ePoQcce16Um0UFvVkiU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-Xrd7O2W6Oo6nJT-5qBQp3w-1; Mon, 22 Jun 2026 16:23:22 -0400
X-MC-Unique: Xrd7O2W6Oo6nJT-5qBQp3w-1
X-Mimecast-MFC-AGG-ID: Xrd7O2W6Oo6nJT-5qBQp3w_1782159802
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ddad618405so109157316d6.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 13:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782159802; x=1782764602; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CPEP6gHhqNKJhrtW+PUpBGCpELK13U8EoAVNjsbwg7M=;
 b=clzG1fSG+NiCqy/pCh1oVYQSHKD0Wtimuf5Yq4sqN4/aecnfW74i4kQansU74fndLV
 kIidMo6iZMaNNiwbWSqCUGELxIST5WpwEazSLWt2+6UKuEi1n+pF6LNxkJmInL+EUZ00
 +WyR4M9UvoWTojTkkbvNrnj5s07qM2AQBq9vte691b5Omcp79Np2rVxJrlj0KcrPRtBY
 ZWETGDziRgtYtpkl1EuHwd2itI97kEzxErbGIy+UqhJ/mnJJErN3SLAkbfWiLAAOk2rh
 NV+BiKuLvyPfQP35U6YMe7scZidzrgZQtN13DAPG5758DO/enHc0zuDnUgw6bsimbZvL
 XfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782159802; x=1782764602;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CPEP6gHhqNKJhrtW+PUpBGCpELK13U8EoAVNjsbwg7M=;
 b=Uq2DcCgCurLRp/Bov7e5ByJxJMxsY3hqPiTXPSGJNs0venYYUk1Kk2jJ0gmmvqVm6z
 X9XLOOQoQwHZLRs/hsmcd0ydD5u4jticj5xZUKrAYetuyCCLlRr8n7lAn75jxYsVm4P4
 yPmtifl8vi6piKqvK28LRX6B5Knitz6spnovy2gkkAxqQvB+WrUyWuMw5RBDAzY12Sps
 eQmebiHzacNsoqVZadXPDdpL5oWNp5bRrS+BUlTWJoohFub0slg3fVmrlrTTiz3fSaXj
 ursWMtaRzl3zyNkgSqYEJQvvyMVaXeF7pQtWhelqii9TpkrrFT0p8X4sDwbsdG2Bb6XM
 8uGw==
X-Gm-Message-State: AOJu0Yz9UZN9SSoeyDJzc33popqeF6DA0sxQ78iFMGdEPJmhDOG/mbdN
 tc31ObHWZH3y0c92fugmyTaIn5OwqN4XjVHRKOxK+b730uTjzO9/yx54zm0QwqeKI18dSIgyMA7
 Vg3eDDqpTyoHr72R3DH9TfpZlMXUVX4eNZph1HigbzjbeCQqN6+S+UHSv
X-Gm-Gg: AfdE7clQSktZ0PPk8IvzOqobaWi8Stu4ok+xt4ZuagUZY6RyZOD5sdkOM9DP2n+LqNY
 2Vl8MhNmoJJyp54wFrZIR++fkeRuV2TGK7vwTHOb19I/hXCvmyw6w6Xe05DxKQipd4ueiKUwFSq
 jF9GvZN5HaTdbuO5J92S8XiJcpQsao2qM2/YPq5WL5SVSreWoO3Z9UtglnKvC7HNz6XOAjLsJmN
 7/UubB3nI1f/ZMEeIXkGODs8Yoy5civesGKPqgP8IDVvwEdBHhN+stfshIB0btjlioj5W2CgMld
 WcjkMW4OPhO8CmPWyPkFyWA0b0KHBDcjhpSMqpU2kIMlaxCl6Oe9RDdGbTRzhv2/F5yB22D0AiE
 w+o1S
X-Received: by 2002:a05:6214:e6f:b0:8ce:f1b:74ea with SMTP id
 6a1803df08f44-8dea3ae3fe8mr249639486d6.24.1782159802132; 
 Mon, 22 Jun 2026 13:23:22 -0700 (PDT)
X-Received: by 2002:a05:6214:e6f:b0:8ce:f1b:74ea with SMTP id
 6a1803df08f44-8dea3ae3fe8mr249638636d6.24.1782159801550; 
 Mon, 22 Jun 2026 13:23:21 -0700 (PDT)
Received: from x1.local ([174.91.117.157]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cde303sm105884836d6.25.2026.06.22.13.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 13:23:21 -0700 (PDT)
Date: Mon, 22 Jun 2026 16:23:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 qemu-block@nongnu.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org
Subject: Re: [PATCH 0/3] migration/ram: Abort on unsupported migratable RAM
 changes
Message-ID: <ajmZrT1d0QXCWTNq@x1.local>
References: <20260611-ram-v1-0-a2dacf699718@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260611-ram-v1-0-a2dacf699718@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jun 11, 2026 at 03:35:47PM +0900, Akihiko Odaki wrote:
> Supersedes: <20260604-migration-v1-1-cef4a5b1bbdd@rsg.ci.i.u-tokyo.ac.jp>
> ("[PATCH] system/physmem: Assert migration invariants")
> 
> ram_mig_ram_block_resized() already aborts migration when migratable RAM
> is resized. Extend the same handling to other unsupported changes to the
> migratable RAMBlock set, such as removing a migratable RAMBlock or
> changing a RAMBlock's migratable state.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> Akihiko Odaki (3):
>       system/physmem: Pass RAMBlock to RAMBlockNotifier callbacks
>       system/physmem: Notify RAMBlock migratable and idstr changes
>       migration/ram: Abort on unsupported migratable RAM changes

Thanks for looking at this, Akihiko.

I understand this is a protection to the system to trap error use cases.
The question I have is do we have any possible way to trigger these.

I worry we add a bunch of code and notifiers, and then there's zero way to
trigger, essentially add dead code.

Logically we could already add assert() on things we don't expect to
happen.  This case might be slightly risky, but still I think we can also
consider things like error_report_once() instead of introducing slightly
complex notifiers just to cover what we think shouldn't happen.

Or do you have way to trigger any of these notifiers?

PS: today I went back and I wanted to try how the existing resize()
notifier would trigger, I can't even reproduce it with David's example
here:

https://lore.kernel.org/qemu-devel/20210429112708.12291-1-david@redhat.com/#t

I can trap a qemu_ram_resize(), but that's invoked with newsize==rb->size,
so it didn't really notify a thing.  I don't really know how to trigger
ram_block_notify_resize().  If you know, please share.

Thanks,

-- 
Peter Xu


