Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEC7C3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 13:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTLw8-0007Yh-4u; Mon, 15 Jul 2024 09:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sTLw4-0007XK-H4
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 09:40:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sTLw1-0000n7-EZ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 09:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721050807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dr5WkaecGMyPHaD21C9iVTZpNS6SNWbjKMPSLUS4eDs=;
 b=JwVFKpNIHKkYTkV+Tkn0PPyM1owPJ99iQELpI115n99NiA4n68P+3iziwtKpR7Wf6QLVnO
 sv1bekdqUce2S8/kCbM62zhZKd3S/SV3pvT5hKyeXL7AtJyWyB6xjD1vrJAmzs6qnrqO8f
 /xEdFHoIOo+LC4OTsFiJXknLIfaROSg=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-K6wst9qYO6Kz_YJZCs7FUA-1; Mon, 15 Jul 2024 09:40:00 -0400
X-MC-Unique: K6wst9qYO6Kz_YJZCs7FUA-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3d92425ce86so261957b6e.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 06:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050799; x=1721655599;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dr5WkaecGMyPHaD21C9iVTZpNS6SNWbjKMPSLUS4eDs=;
 b=lpUV1krzJEOG0QE+eUBWgT30MC/tzuTggwLK4JWD6ZDdeMn+M0tUBh2+1F2fy5p4y3
 nrXiUIEewaiLl4L68y2O/yuaGRMGSc46ctgUpeu5AaZKJ4/PoFzwwmMG/PhnKGxQjCnW
 720N0LMFnl0BienCtrb+r/8h47sgHPNZTSnU2AIsmCLWCR7OhsLwWBrtLrKfsyh+hW2M
 xSqdSEjuztnIMysm8oixf8h74vqYnqTEpozmvESn7bdYbaJKgWN/QkU+y5+vnKqkk10x
 tePhmq1nw+yTgbiTsHjYHn3u9YXbFvYPL4f4OLhKc5lFkmYuRibACRoCgO6Hn6y8Fhcc
 s8eA==
X-Gm-Message-State: AOJu0Yz0Kmopzpb2Sk+RldghA7RJCBdDk8kDrQjgRiFgJKRJbeS9QYum
 T+9/CqnRy6nJABTdwPDQGl1yyT1X111dGwDUwDQcP1evkhsfQ2MNqdwXjbj/zea7GPwIfWaNMLX
 wh/o0ELffMrquLpbmcGcAd72Tj3f7PWIxkz1R5NBv0YBvE6LTwLEq
X-Received: by 2002:a05:6808:1881:b0:3d6:2de0:84ef with SMTP id
 5614622812f47-3d93bc1a005mr18328445b6e.0.1721050799566; 
 Mon, 15 Jul 2024 06:39:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvX5M75q7vDyKWTCMZP59xeKgPARWpOoKwOOdwvGSJc1UzDmAD7bvC1WeDvBuhL6FM14Jmtg==
X-Received: by 2002:a05:6808:1881:b0:3d6:2de0:84ef with SMTP id
 5614622812f47-3d93bc1a005mr18328427b6e.0.1721050799214; 
 Mon, 15 Jul 2024 06:39:59 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a160c6418dsm199855885a.92.2024.07.15.06.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 06:39:58 -0700 (PDT)
Date: Mon, 15 Jul 2024 09:39:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, mcoqueli@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 0/2] Postcopy migration and vhost-user errors
Message-ID: <ZpUmrTrEnx0RcO2y@x1n>
References: <20240711131424.181615-1-ppandit@redhat.com> <Zo_8fpKH8oBA8WV1@x1n>
 <CAE8KmOzsGaPtTFsjcRkyd8n_fPzXeFd+c38Eb=aLG0_MdO+yKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOzsGaPtTFsjcRkyd8n_fPzXeFd+c38Eb=aLG0_MdO+yKw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 15, 2024 at 03:44:06PM +0530, Prasad Pandit wrote:
> > I remember after you added the rwlock, there's still a hang issue.
> > Did you investigated that?  Or do you mean this series will fix all the problems?
> 
> * No, this series does not fix the guest hang issue. Root cause of
> that is still a mystery. If migration is ending abruptly before all of
> the guest state is migrated, the guest hang scenario seems possible.
> Adding vhost-user-rw-lock does not address the issue of end of
> migration.

IMHO it's better we debug and fix all the issues before merging this one,
otherwise we may overlook something.  You could pass over the patch to
whoever going to debug this, so it will be included in the whole set to be
posted when the bug is completely fixed.

> * From the protocol page above, it is not clear if the front-end
> should allow/have multiple threads talking to the same vhost-user
> device.

The protocol should have no restriction on the thread model of a front-end.
It only describes the wire protocol.

IIUC the protocol was designed to be serialized by nature (where there's no
request ID, so we can't match reply to any of the previous response), then
the front-end can manage the threads well to serialize all the requests,
like using this rwlock.

Thanks,

-- 
Peter Xu


