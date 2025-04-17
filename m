Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619D4C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 11:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5NBp-0003ZD-L3; Thu, 17 Apr 2025 07:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u5NBj-0003YV-Fy
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 07:13:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u5NBg-0007CL-5q
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 07:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744888420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rcbE0+J3Qf7pjeqjEgaZ0PwE5XFnhCxAAx0rGrHG1j4=;
 b=aP4MQFc8TLBFJeJpU6qhd5Bgo4KEHhXIZmixB4RXOMMeZ5x15Jk6ACQBN2xESRqdbBkZG8
 9qZWnKtQ+cUFEn11yW6vmpxv/PA6QH+C5ehHcls1YLfNtJhOjOlS+jCYGNAxAWV+saZdbi
 fb8TOfEoV21NKjjmmz3sC4bf8CyFZGM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-GITBz396N8KiqYhD2y-_3Q-1; Thu, 17 Apr 2025 07:13:38 -0400
X-MC-Unique: GITBz396N8KiqYhD2y-_3Q-1
X-Mimecast-MFC-AGG-ID: GITBz396N8KiqYhD2y-_3Q_1744888418
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43f405810b4so3353435e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 04:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744888417; x=1745493217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rcbE0+J3Qf7pjeqjEgaZ0PwE5XFnhCxAAx0rGrHG1j4=;
 b=LvTfu3+Dy+cUjt5ANC93yUuZ8hhiEMllFlq9/FGiwBlkIKf5ZTLdsA+1IUCPLaYDvz
 Ja9+q3OA5B9Pz8oYwoMC8O+5X7j4cKFPVRwIApjKyPSMYUGJOoPxcVFC6UiVYWwKxbfq
 KpSmHfIdwEDBJNUFJOm533k7sgAswdVFpBSQzjM8dr6ohbMMb2XdHBfNL9qiEEjNRJp/
 1tBcC6bPMomyi5amUbb9OGOZaHfX3fKodQj7kw8CazkPp4oYRIg38g5oBI3CK1q700Dp
 KswM2wVGH/ahn0vRhW4n2dYvTpgomP0RKn2xEa47GIXzts+9kLKYJZwbkWPvdo0FaRgV
 E1dA==
X-Gm-Message-State: AOJu0YzbOoLR+IRyb3dfJcAT3N/1ERP77zbLIrRzUHib+yIFOX0gHjaJ
 8Z3LpBOp8g5oew++qod6Ia1m9Ac1Sgml+F43Cz9xmGseFUK5VkpIS/sHBETe094B+hmoJQDZehE
 Uwc4kudkjivVFGL1ZLB5Mv9iuS/UiY5NPfYUSYvbHEf9ZYpn6+MxErdOJWxzCoPgrRmf2GSAGpr
 r6SJRlqWInqCIrR+x1I8EkJdxZbJY=
X-Gm-Gg: ASbGncvMdcVDp2A7eVQVupesaYkn13W48oI3hMcE3nwNzi2+Dsv+78feRRChaHfIRLe
 r+y8UOzOjrIPfHYEplreLx/RiWG+EArswf2KNTYXREf+I+N4WrhJ7VZZRc6I+TqJBEIzZPGQ=
X-Received: by 2002:a05:600c:1d1f:b0:43d:fa58:8378 with SMTP id
 5b1f17b1804b1-4405d6e33c3mr44029165e9.33.1744888417491; 
 Thu, 17 Apr 2025 04:13:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZRZUoEY25uX+thgTPBPJHOxNoDS9oySFpSPv6BRcRyeEO9Ym7aDlefjTmo5Ff/HrS5tZbE+KBK/KWbSe6mgU=
X-Received: by 2002:a05:600c:1d1f:b0:43d:fa58:8378 with SMTP id
 5b1f17b1804b1-4405d6e33c3mr44029025e9.33.1744888417165; Thu, 17 Apr 2025
 04:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250411114534.3370816-1-ppandit@redhat.com>
 <87ecxteym0.fsf@suse.de> <87bjswfeis.fsf@suse.de>
In-Reply-To: <87bjswfeis.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 17 Apr 2025 16:43:20 +0530
X-Gm-Features: ATxdqUFGW7kupCKMFRK2VlO5oMsPZwI9YLayfI1sSsk4a-IGQmIBplfRcmhy7fY
Message-ID: <CAE8KmOzzn7g1=pd2J325gAf4ffmGALKoHdgL17So4KawxkZdbg@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] Allow to enable multifd and postcopy migration
 together
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

On Wed, 16 Apr 2025 at 18:29, Fabiano Rosas <farosas@suse.de> wrote:
> > The issue is that a zero page is being migrated by multifd but there's
> > an optimization in place that skips faulting the page in on the
> > destination. Later during postcopy when the page is found to be missing,
> > postcopy (@migrate_send_rp_req_pages) believes the page is already
> > present due to the receivedmap for that pfn being set and thus the code
> > accessing the guest memory just sits there waiting for the page.
> >
> > It seems your series has a logical conflict with this work that was done
> > a while back:
> >
> > https://lore.kernel.org/all/20240401154110.2028453-1-yuan1.liu@intel.com/
> >
> > The usage of receivedmap for multifd was supposed to be mutually
> > exclusive with postcopy. Take a look at the description of that series
> > and at postcopy_place_page_zero(). We need to figure out what needs to
> > change and how to do that compatibly. It might just be the case of
> > memsetting the zero page always for postcopy, but I havent't thought too
> > much about it.

===
$ grep -i avx /proc/cpuinfo
flags        : avx avx2 avx512f avx512dq avx512ifma avx512cd avx512bw
avx512vl avx512vbmi avx512_vbmi2 avx512_vnni avx512_bitalg
avx512_vpopcntdq avx512_vp2intersect
$
$ ./configure --enable-kvm --enable-avx512bw --enable-avx2
--disable-docs --target-list='x86_64-softmmu'
$ make -sj10 check-qtest
67/67 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test
     OK             193.80s   81 subtests passed
===

* One of my machines does seem to support 'avx*' instructions. QEMU is
configured and built with the 'avx2' and 'avx512bw' support. Still
migration-tests run fine, without any hang issue observed. Not sure
why the hang issue is not reproducing on my side. How do you generally
build QEMU to run these tests?  Does this issue require some specific
h/w setup/support?

* Not sure how/why page faults happen during the Multifd phase when
the guest on the destination is not running. If 'receivedmap' says
that page is present, code accessing guest memory should just access
whatever is available/present in that space, without waiting. I'll try
to see what zero pages do, how page-faults occur during postcopy and
how they are serviced. Let's see..

* Another suggestion is, maybe we should review and pull at least the
refactoring patches so that in the next revisions we don't have to
redo them. We can hold back the "enable multifd and postcopy together"
patch that causes this guest hang issue to surface.

> > There's also other issues with the series:
> >
> > https://gitlab.com/farosas/qemu/-/pipelines/1770488059
> >
> > The CI workers don't support userfaultfd so the tests need to check for
> > that properly. We have MigrationTestEnv::has_uffd for that.
> >
> > Lastly, I have seem some weirdness with TLS channels disconnections
> > leading to asserts in qio_channel_shutdown() in my testing. I'll get a
> > better look at those tomorrow.
>
> Ok, you can ignore this last paragraph. I was seeing the postcopy
> recovery test disconnect messages, those are benign.

* ie. ignore everything after - "There's also other issues with this
series: " ?  OR just the last one " ...with TLS channels..." ??
Postcopy tests are added only if (env->has_uffd) check returns true.

Thank you.
---
  - Prasad


