Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C32A606A329
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WJ1/4wH2;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HBMjwV53
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUHR-0008QI-R4; Thu, 29 Oct 2026 13:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xMUGo-00081v-Do
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:50:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xMUGm-0004Wt-8X
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793296231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CnyI6KRqAzl/z3mqplranxJQclpiFMHOitnEtM9upIo=;
 b=WJ1/4wH2aSvxadDDIksX8OUzY7DyGa6HUqAci3fP6AiAJ+8RtDe6ZBtM8j7zKkxg5t69Ia
 L8oEXAYQeibkGD2Bxy22I0kRvByZ5OGtriZG4os8732olTkWFdG8LzNXOv+mSFRp1LBIT+
 d68Rybjyn33YH0qBq/dcQbeEe9mC3oY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-SmCMeegENOyTVu4aPbQaow-1; Thu, 29 Oct 2026 13:50:17 -0400
X-MC-Unique: SmCMeegENOyTVu4aPbQaow-1
X-Mimecast-MFC-AGG-ID: SmCMeegENOyTVu4aPbQaow_1793296216
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48e0c896d05so1988760f8f.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793296216; x=1793901016; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CnyI6KRqAzl/z3mqplranxJQclpiFMHOitnEtM9upIo=;
 b=HBMjwV53o503ZGw8BgMUcBYG63Efv/WKO5+d81NyJiMysQK++qIVXBXERh/gsn4noJ
 bHEQaNudoFLwbScfaRN04VW+0+j9W2pA/MRNpEAJV+/hC7E/tDE57JqKQrEShQqeyU/r
 jwCSDhc6nLAc+5m+nNOnQ2BKm+HGeGSEq1YcKMavJ2wQrgW0WskgYcMK3HK/BfMtnKGk
 lapwEyOau7USONSfKRlfn7LztVCBpkVJoTS0BbQNUeNyosE0uekrQL+7YmRD5sJUM4kM
 kHcG/ONiMJgBqOy3vz015ESJVAxje0T4clCcZrUWe6ON4J3VsQVKx04NKWbfYiPZlkln
 fPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793296216; x=1793901016;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CnyI6KRqAzl/z3mqplranxJQclpiFMHOitnEtM9upIo=;
 b=WS6NCTqEqgWdjjUP0oD6rZIIYFnypW8MDaTYieFTt/KBr0W1wKNmEGnmzHPDXfaKJ4
 dsXAqa7pl0bc0cIMdAwZZaviaxn8VNkc/yPG1qExwCqj00WwSWGeszR5ZSrmfjLheeCl
 afywiv0avPE49WsY3M7uRppb/vlN5fHWGfBAQFECnqgx9rgszhYBSt5t1W4sFvTo4XAB
 Ni6rf0kRTrgzbsDGipOC/U9jHU4nzW8ziZGh0UDRD9nFUdkW8usplp0CHqyrqh3ejSL3
 rYGjZ2ah+WKDeKIqR2gAf99URGSXaZJJwzIrV8/msNpJtaw4JRJ82/1GvTEMQTp2iqO0
 2BYw==
X-Gm-Message-State: AFq9FYJG7OHbR0cSNBI/Wnhf0xLhYsbXsMMjgeIgExO4bFjAd4NSwZuX
 79PylHmroU9gg+XewAhrwGxHb+hMpWwhsTdLB6h40jbTVXf+BYnJ3H8lSf+azM30iwUrV7v0FoS
 9NgpBUipUpZJs/4mKJBV4DTlitey+tFT97kbmiRimgCbaNqeHPAjnHN0C
X-Gm-Gg: AYBFou3Z6fkTgw38C+VK38VqvK166p9qe2txpvfJfDq3IrkdvFEdUfIW0pOS5H+2j21
 BYhCHGyHazmIptNpspfaF4FhN9bxTUxTWhlWA7us87rSnfBXgrMztLnyUzEJqfnDKNT6VC4ICi5
 FsNQMrFtryQD998oxQItHURH5x08xJ7fpL6mVyVQhFr52gHoE0e73kT5iuDOWaIVhA9tS2mZoiy
 z+1WBc6869jBYEnNhEw3b0+Ixrw8qLNXYZrJYzXZwiVrRqgdzw5b3lp1UkOJzQDNfXmARPfA969
 CCCMUy9Qid55wdYpyhkafTKbFCDoBZWncePd8oXYMaACpThuD3xNHbLWYMeUaPZ3qWEOjnfT3YI
 bKFHu9cjBcD1F5zBQlSTfdisMAvmudilz8eNNFn5q8Evt
X-Received: by 2002:a05:6000:2893:b0:48c:58d5:30fb with SMTP id
 ffacd0b85a97d-48e6e2db3cbmr378330f8f.5.1793296216305; 
 Thu, 29 Oct 2026 10:50:16 -0700 (PDT)
X-Received: by 2002:a05:6000:2893:b0:48c:58d5:30fb with SMTP id
 ffacd0b85a97d-48e6e2db3cbmr378267f8f.5.1793296215620; 
 Thu, 29 Oct 2026 10:50:15 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73c1:fd00:6c8e:5a61:f533:519d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6df87fdbsm557858f8f.13.2026.10.29.10.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:50:14 -0700 (PDT)
Date: Thu, 29 Oct 2026 13:50:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Weqaar Janjua <weqaar.janjua@packetfive.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, peter.maydell@linaro.org,
 pierrick.bouvier@oss.qualcomm.com, jasowangio@gmail.com,
 pbonzini@redhat.com, farosas@suse.de, lvivier@redhat.com,
 marcel.apfelbaum@gmail.com, peterx@redhat.com,
 lizhijian@fujitsu.com, odaki@rsg.ci.i.u-tokyo.ac.jp
Subject: Re: [PATCH v3 0/6] hw: Add Cnuas virtual devices
Message-ID: <20261029134859-mutt-send-email-mst@kernel.org>
References: <20260929202358.725310-1-weqaar.janjua@packetfive.com>
 <20261016153247.1815153-1-weqaar.janjua@packetfive.com>
 <20261027080746.2468700-1-weqaar.janjua@packetfive.com>
 <20261027063724-mutt-send-email-mst@kernel.org>
 <20261029115735.2716219-1-weqaar.janjua@packetfive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029115735.2716219-1-weqaar.janjua@packetfive.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 11:57:06AM +0000, Weqaar Janjua wrote:
> On Tue, Oct 27, 2026 at 06:46:49AM -0400, Michael S. Tsirkin wrote:
> > Sorry I can merge if someone reviews but I just can't take on reviewing
> > a new device right now, I'm buried under AI security reports as it is.
> 
> Thanks Michael, understood, and thank you for offering to merge once
> it is reviewed.
> 
> > I appreciate that you listed yourself as the sole maintainer but you are
> > a first time contributor.
> 
> Fair point. I am happy to be listed as a reviewer instead, or alongside
> an existing maintainer if someone in the net or migration area is
> willing. I will keep supporting the code either way.
> 
> > Maybe Jason can review. Try poking other net device maintainers.
> > Maybe rdma migration guys? if this is useful to test
> > qemu rdma migration then suddenly you have users within the community.
> 
> Thanks for the suggestion, I tried it. Setup: two Linux guests on one
> host, each with a CnuasNIC (1b36:0017 from this series) attached to a
> shared user-space switch, using the in-kernel RDMA stack over RoCEv2.
> 
> - rping over RDMA CM, 1000 iterations per size, data verified with -V
>   (rping -s/-c -a <ip> -C 1000 -S <size> -V), both sides exit 0:
> 
>     size      wall time   per iteration   RDMA READ+WRITE data
>     64 B        1.218 s         1218 us             0.8 Mb/s
>     4096 B      1.172 s         1172 us            55.9 Mb/s
>     32768 B     1.857 s         1857 us           282.4 Mb/s
> 
>   Wall time is measured on the client and includes connect and
>   disconnect.
> - perftest over RDMA CM (ib_send_bw -R, ib_read_lat -R,
>   ib_write_lat -R) passes.
> - QEMU RDMA migration of a nested TCG guest with 512 MiB of RAM filled
>   with random data, source paused, migrate rdma:<ip>:<port>. With QEMU
>   master (29b1dc631d) it completed in 6.4 s at about 675 Mbps with
>   269 ms downtime, and a pmemsave of guest RAM is identical on source
>   and destination.
> 
> So CnuasNIC gives another way to exercise migration/rdma.c on a single
> host without RDMA hardware. The guest driver changes needed for RDMA CM
> will be part of our Linux driver submission (blocked on PCI ID patches 1
> and 4), and I can share the full setup if anyone wants to reproduce it.
> 
> Jason, Peter, Zhijian, Akihiko: would one of you be able to review
> patches 2 and 3 (the CnuasNIC device model and its qtest)?
> 
> > Indeed, next release.
> 
> Agreed for the device models.
> 
> One request on the PCI IDs: patches 1 and 4 only reserve 1b36:0017 and
> 1b36:0018, and both have Gerd's Reviewed-by. Our Linux driver and
> rdma-core provider submissions depend on these IDs, so the device models
> waiting for the next release also holds up that work. Would it be
> acceptable to merge patches 1 and 4 ahead of the device models, for
> 11.2 if there is still time before the soft freeze? If it is easier, I
> can send them as a separate two-patch series rebased on master.
> 
> Thanks,
> 
> Weqaar

Hmm wait a second.  I don't understand. Isn't it a physical device you
are emulating?  Why is it using the Red Hat IDs?


-- 
MST


