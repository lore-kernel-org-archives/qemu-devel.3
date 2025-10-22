Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F20CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBeXG-00016G-8j; Wed, 22 Oct 2025 15:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeWv-0000tv-Pa
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:29:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeWt-0001ls-LR
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761161390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XzNoWAkEF4d+oBSToQXHskCOH19a/YjosvNb3uaKjto=;
 b=HFLxs9xlmc1JdpQgrWw9/pxJ2IkfC9LBl1TQ2L9DKRDmD34HL45CDj7diHsd4SrlpxUkb+
 biY8tpxLkj8Z//hKN01tSEd2VrPK1x2xZs3TaEskuJEkEEeRB1hzt8ijuAjq4lr+EYYG1G
 rM+U9MpSS5p0dXeK9dAhdcJmb5IdEQ4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-ToYgUHtXM6Weo5dqEUF_Mg-1; Wed, 22 Oct 2025 15:29:42 -0400
X-MC-Unique: ToYgUHtXM6Weo5dqEUF_Mg-1
X-Mimecast-MFC-AGG-ID: ToYgUHtXM6Weo5dqEUF_Mg_1761161382
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-88ec911196aso2612662585a.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761161382; x=1761766182;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XzNoWAkEF4d+oBSToQXHskCOH19a/YjosvNb3uaKjto=;
 b=ZjF2WmvB/Cdkau0FEmj8l2DtghrqpbAnxbohIPAtMcLlzWHK0l0SxuuanjuXqbCVsy
 SsQWPm10EXkDxDIvx9yz2VajfvMVu8XcseNXKOmKExE1huVOl9f/8gjLVeocQlpHwvZM
 znEdNZd+a+uEVxcH+05JcCOTdlZAgbTib0B+tRYg3IAL1G0s2ZYecEqwSDWvxqIl/UVp
 QJQE63oyBQ3HUiiS7FrKXUNXh7pGTvzaneFcCZCYzcnrpXLMT2vaaJ/KFEhWq0xX/SXW
 rQhzK7q/1OsdZlBDex0IdzHPBDSpvXXY+C4BPDK4lQPhi7kGiA9+xgy+tgYdgIjAcOAC
 vGUQ==
X-Gm-Message-State: AOJu0Yy5vZz4uPJBs7Q72T6dqxxBIIg8qFj+ZiBIAcTbdS4CGU1ro+vy
 t7eiKoaJva0MY+mWdqGVyW//xXrPBR/8iudfHrST0yR1RRKmvPOTwVMNYCQll7ZmrxcoxnrAzBO
 vKsZAmO5+gKJabRf6lk6o5ux8dsHZOVWaTit5dOf2CjJL93diBkgkM72au9SH0xZTrXdMi6fG6d
 LcG3qwtfEPdrC9BTMg2zPDfGAHyqHlBLlJyK6vtQ==
X-Gm-Gg: ASbGnctB1N2CqfHoUNq9K7Yl1uk04LON2lBslXKE5lO7lCmNP+4qY9wqhnNS4a/ORDN
 Ww6BAMYbasDrNAKp3+EVrPeSX1KmJFKWiowgHyqhF+LiSUSk7dtxC4jtFSbU7+KnT8QBdgzU+/D
 Z3SGAMhzgpL2tkPOeZzOH7FULBSas+6h2KisjqOFItOfxUruj8LXrpzbzKh4UxCd9V7QbiMASU/
 3m8UtDRTB9fEJ1fkaST0A1PiE3JGrDoiLNXn8hcbZ6gK1x167F4ifk2pOmni8l98Rz124Lzqucp
 jqisS9jmV7kdcEFXu7srAFMWSnG7OE+vXhX2KH5Ul7Evk7D2PUXZq59XFEma14ED7mo=
X-Received: by 2002:a05:620a:2589:b0:84e:3e97:fb0c with SMTP id
 af79cd13be357-8906e4ba3dbmr2865558485a.17.1761161381724; 
 Wed, 22 Oct 2025 12:29:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECaHoYYTyr5L447JqHLAh/DGPWWJoSq68qE+LGu6AkA/UxB5Gmt5nK2EJGaZuXmFVfHGzJNQ==
X-Received: by 2002:a05:620a:2589:b0:84e:3e97:fb0c with SMTP id
 af79cd13be357-8906e4ba3dbmr2865552485a.17.1761161381123; 
 Wed, 22 Oct 2025 12:29:41 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89c0dbccb8fsm2438785a.11.2025.10.22.12.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 12:29:40 -0700 (PDT)
Date: Wed, 22 Oct 2025 15:29:36 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 00/13] migration: Threadify loadvm process
Message-ID: <aPkwoPBNIMLlHLBr@x1.local>
References: <20251022192612.2737648-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251022192612.2737648-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 22, 2025 at 03:25:59PM -0400, Peter Xu wrote:
> This is v1, however not 10.2 material.  The earliest I see fit would still
> be 11.0+ even if everything goes extremely smooth.
> 
> Removal of RFC is only about that I'm more confident this should be able to
> land without breaking something too easily, as I smoked it slightly more
> cross-archs this time.  AFAIU the best (and possibly only..) way to prove
> it solid is to merge it.. likely in the early phase of a dev cycle.
> 
> The plan is we'll try to get to more device setups too soon, before it
> could land.

I forgot to attach a changelog, sorry, here it is:

rfc->v1:
- Collected tags
- Try to split the major patch 5 to smaller one [Dave]
  - One with WITH_BQL_*() macros, rewritten to allow internal "return" or
    nesting [Vladimir]
  - One patch "migration: Pass in bql_held information from
    qemu_loadvm_state()", the patch itself contain no functional change.
    However it should contain all changes relevant to BQL, hence maybe it
    would help review.
  - One patch contains the rest that need to be in one patch.
- Refine commit message for patch "migration/rdma: Change io_create_watch()
  to return immediately" [Fabiano]
- Pre-requisite patch to rework migration_channel_read_peek(), removing the
  sleep functions [Fabiano]
  - Added patch "io: Add qio_channel_wait_cond() helper"
  - Added patch "migration: Properly wait on G_IO_IN when peeking messages"
- Squashed patch "migration/rdma: Remove rdma_cm_poll_handler" into patch
  "migration: Thread-ify precopy vmstate load process", otherwise the patch
  when split can be racy.
- Changed the vfio patch to be at the end, instead of adding dead code
  directly remove the bql lock/unlock, making sure that API is invoked
  without BQL instead.
- Added one patch "migration: Allow blocking mode for incoming live
  migration", so that after the threadify work switching incoming main
  channel to be in blocking mode.  Reason in commit message.

It may not be complete, so there can be small touch ups here and there that
are not mentioned.

-- 
Peter Xu


