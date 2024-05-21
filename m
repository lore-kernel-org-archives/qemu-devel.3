Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EABFC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 22:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9XlP-0004Gt-Dg; Tue, 21 May 2024 18:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s9XlN-0004EW-Ie
 for qemu-devel@nongnu.org; Tue, 21 May 2024 18:15:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s9XlK-0003rA-TJ
 for qemu-devel@nongnu.org; Tue, 21 May 2024 18:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716329712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZKzPeEH8N6yOl96mporHE2CZmrCGJ5mO1m3x7O0intw=;
 b=BfgcTGzTxOq2qBbThfjnBSndizwbTxJRpPLTzkUwizC/63RF6lWK5KASBHmy6/naxIeBrx
 iORm6tIVdoFB7FlEjlG+nffGpnt+oWWs9ImqUMmL3Bx+FcDrCh3drXxrO9L5QDcWXacRKj
 Bzf6MNe8P+3zm5wG+BcLCq3XWbTs6Gk=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-dNZI46wkPFu_Uxyn3SDo7A-1; Tue, 21 May 2024 18:15:11 -0400
X-MC-Unique: dNZI46wkPFu_Uxyn3SDo7A-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5b27bd802a7so4142775eaf.0
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 15:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716329710; x=1716934510;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZKzPeEH8N6yOl96mporHE2CZmrCGJ5mO1m3x7O0intw=;
 b=QK7l1bkgQpQeEv+IuToZkOe/2sbrWotJjI/aMvi7rW+vrR96KY/jNaKe/PXgsAJAjS
 6ybO6YsLaY6NdxGOvbNfdPzNdn14Z1hURE2wkQ+mbtgqjGX7DLL2NnsB3dHGheaO85vo
 EU0VFDBeygcr6wEn5AFxTFL8t7nykQrsSUdyf542E594dKQ5nV73RVjPSdn/G0ZvzCHc
 j9c0YvmfX6fweMjA7GvdUHk/3cvx2fclfOhx8oWbmU1eGpOLWzfmrNX/ckKtNvl3IB97
 p/oH5lDoSPH5Z899dqMrTfRHPYZ6cezLwn47/CtgAefpXUHhwed5vPQAYkMbtE65vVOo
 3wSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxYQX4CjcYi520L7XfPSD5RO5Ia637AeBpvGZqxrM3Ro10QjKA+T2minRLZJV4dlNcHMXl3/3P6iaGIWrmJf6qLuaGYXU=
X-Gm-Message-State: AOJu0YxXKpeb9W0lCzSifaAvGNwgqVDk80ovs/82LdOMZiRqjbvjKOhH
 y668KMKKRHdrAhaGpDz3AcZw2nFLZVlaIoD6cILNnS+EkZP0jpY3ppbXTExlKxB5r8GKzeGihkn
 2OtpQhn95rKGgU57Iqv6g3hCcc/eAwBwIwUd/oL+biFSYBbx7EC4S
X-Received: by 2002:a05:6808:1983:b0:3c7:528b:12ce with SMTP id
 5614622812f47-3cdb722b806mr411591b6e.3.1716329708942; 
 Tue, 21 May 2024 15:15:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqUUZurJofGGjYSuvEM5MrebsPfnHO/FFwYBHhQ+G1Ielocxrt0H/KxJu3yPInJSCVZRZi8g==
X-Received: by 2002:a05:6808:1983:b0:3c7:528b:12ce with SMTP id
 5614622812f47-3cdb722b806mr411562b6e.3.1716329708530; 
 Tue, 21 May 2024 15:15:08 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792e564e4dbsm921760785a.82.2024.05.21.15.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 15:15:07 -0700 (PDT)
Date: Tue, 21 May 2024 18:15:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Yu Zhang <yu.zhang@ionos.com>
Cc: Michael Galaxy <mgalaxy@akamai.com>, Jinpu Wang <jinpu.wang@ionos.com>,
 Elmar Gerdes <elmar.gerdes@ionos.com>, Zheng Chuan <zhengchuan@huawei.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pannengyuan <pannengyuan@huawei.com>,
 Xiexiangyou <xiexiangyou@huawei.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Message-ID: <Zk0c51D1Oo6NdIxR@x1n>
References: <ZjJgQcPQ29HJsTpY@x1n>
 <7e902e4e576a4e199e36d28f99bd55e5@huawei.com>
 <Zjj0xa-3KrFHTK0S@x1n>
 <addaa8d094904315a466533763689ead@huawei.com>
 <ZjpWmG2aUJLkYxJm@x1n>
 <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com>
 <ZjzaIAMgUHV8zdNz@x1n>
 <CAHEcVy48Mcup3d3FgYh_oPtV-M9CZBVr4G_9jyg2K+8Esi0WGA@mail.gmail.com>
 <04769507-ac37-495d-a797-e05084d73e64@akamai.com>
 <CAHEcVy4d7uJENZ1hRx2FBzbw22qN4Qm0TwtxvM5DLw3s81Zp_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHEcVy4d7uJENZ1hRx2FBzbw22qN4Qm0TwtxvM5DLw3s81Zp_g@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 17, 2024 at 03:01:59PM +0200, Yu Zhang wrote:
> Hello Michael and Peter,

Hi,

> 
> Exactly, not so compelling, as I did it first only on servers widely
> used for production in our data center. The network adapters are
> 
> Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme BCM5720
> 2-port Gigabit Ethernet PCIe

Hmm... I definitely thinks Jinpu's Mellanox ConnectX-6 looks more
reasonable.

https://lore.kernel.org/qemu-devel/CAMGffEn-DKpMZ4tA71MJYdyemg0Zda15wVAqk81vXtKzx-LfJQ@mail.gmail.com/

Appreciate a lot for everyone helping on the testings.

> InfiniBand controller: Mellanox Technologies MT27800 Family [ConnectX-5]
> 
> which doesn't meet our purpose. I can choose RDMA or TCP for VM
> migration. RDMA traffic is through InfiniBand and TCP through Ethernet
> on these two hosts. One is standby while the other is active.
> 
> Now I'll try on a server with more recent Ethernet and InfiniBand
> network adapters. One of them has:
> BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller (rev 01)
> 
> The comparison between RDMA and TCP on the same NIC could make more sense.

It looks to me NICs are powerful now, but again as I mentioned I don't
think it's a reason we need to deprecate rdma, especially if QEMU's rdma
migration has the chance to be refactored using rsocket.

Is there anyone who started looking into that direction?  Would it make
sense we start some PoC now?

Thanks,

-- 
Peter Xu


