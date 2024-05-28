Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E79C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzAI-0004NG-Dr; Tue, 28 May 2024 11:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBzAH-0004LY-1y
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:55:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBzAF-0006ka-3e
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716911702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/vmnjKyVcvNIJLIwn8K5hU6Zi02D+6bDG/nSuCBGdWE=;
 b=GHsT31ec5u8wRdEwu13XR674BxcU5B8Nkrnaee1y2Iyez3TCuAOlt3y+ggGvo8owkUzZug
 BcTsDw4llzyetZX109nOObbDMDek9YoJjP8Hi2XdtqG6o7q6++wSAyhKv9oye9mfJuHm3q
 wcooo8qOgngj7NmiQ7DovQuZbEs2KHs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-RYqhZfNRPN6NJfnPGBd4Zw-1; Tue, 28 May 2024 11:54:56 -0400
X-MC-Unique: RYqhZfNRPN6NJfnPGBd4Zw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6ab9836827eso1976146d6.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716911696; x=1717516496;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/vmnjKyVcvNIJLIwn8K5hU6Zi02D+6bDG/nSuCBGdWE=;
 b=bpCG0SjGg1pDI+QLBCwVH7OnLkOp8MDomLbRIXX0u3YmL2LED91sT7K8F8HTP+46Dx
 QO7ZhYCdNNcG3M8Ku1aKQea7FsxDUApg3m3ITmmXLQNYE/pDqqD94nZ94nxpAAOFAoy7
 R7zQe7r2yB71IVxfxFy5RP9M89mcYpCyy04hCsInI9Wr37yAtY8QGKh2V2+4nYc+j6cg
 aBJZ5VBJm1zAkhm13MJPFWCY3RjXAGvhs+he/sQftkHoH8lUlJfpT+h86tQ4HkQAtKkQ
 p8YaomtRKzFiyGzKdd7XilkAsk5VQFm/cpQZOBtVLEOGVL+Bsaf6ErtIhZKPRMtemlsg
 VmNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtv3v4466fb37xHlOKoW9+3OS6POmHn2/ZZKoTIdhhxjiXBRcXWKyE7D1QnCTQnBIHnH4QnXjOjhqhy5KWwkdpZal4oDg=
X-Gm-Message-State: AOJu0YyCRa6+H6VdLRLLzISI8siLbbR85RLV9iELOjTKl9yKgvSFlLWT
 i2/dXxlP4V4sVcSoX7XX6pqZO+dkp5o9kFAzo9rAGd+QiCkbOiffAlXf26M1nf7TgOEEStg92sp
 r5oJ+OCfwoQzhMrwWNwicMwzdzVfOc0iAh8YBpIEyWeYbC0PA+4Fw
X-Received: by 2002:a05:6214:da7:b0:6ab:8463:4350 with SMTP id
 6a1803df08f44-6abd0ab07afmr132696436d6.4.1716911695390; 
 Tue, 28 May 2024 08:54:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkNBlPYMNMzqjoctI4IhCM5xgQb6hExV7/R0sVWF63jLp/PfeHXtR9zAUrHu09ftuyqy5czw==
X-Received: by 2002:a05:6214:da7:b0:6ab:8463:4350 with SMTP id
 6a1803df08f44-6abd0ab07afmr132695966d6.4.1716911694642; 
 Tue, 28 May 2024 08:54:54 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ad81a8c07bsm20627146d6.18.2024.05.28.08.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 08:54:54 -0700 (PDT)
Date: Tue, 28 May 2024 11:54:51 -0400
From: Peter Xu <peterx@redhat.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Yu Zhang <yu.zhang@ionos.com>, Michael Galaxy <mgalaxy@akamai.com>,
 Jinpu Wang <jinpu.wang@ionos.com>, Elmar Gerdes <elmar.gerdes@ionos.com>,
 zhengchuan <zhengchuan@huawei.com>,
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
Message-ID: <ZlX-Swq4Hi-0iHeh@x1n>
References: <Zjj0xa-3KrFHTK0S@x1n>
 <addaa8d094904315a466533763689ead@huawei.com>
 <ZjpWmG2aUJLkYxJm@x1n>
 <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com>
 <ZjzaIAMgUHV8zdNz@x1n>
 <CAHEcVy48Mcup3d3FgYh_oPtV-M9CZBVr4G_9jyg2K+8Esi0WGA@mail.gmail.com>
 <04769507-ac37-495d-a797-e05084d73e64@akamai.com>
 <CAHEcVy4d7uJENZ1hRx2FBzbw22qN4Qm0TwtxvM5DLw3s81Zp_g@mail.gmail.com>
 <Zk0c51D1Oo6NdIxR@x1n>
 <2308a8b894244123b638038e40a33990@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2308a8b894244123b638038e40a33990@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, May 28, 2024 at 09:06:04AM +0000, Gonglei (Arei) wrote:
> Hi Peter,
> 
> > -----Original Message-----
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Wednesday, May 22, 2024 6:15 AM
> > To: Yu Zhang <yu.zhang@ionos.com>
> > Cc: Michael Galaxy <mgalaxy@akamai.com>; Jinpu Wang
> > <jinpu.wang@ionos.com>; Elmar Gerdes <elmar.gerdes@ionos.com>;
> > zhengchuan <zhengchuan@huawei.com>; Gonglei (Arei)
> > <arei.gonglei@huawei.com>; Daniel P. Berrangé <berrange@redhat.com>;
> > Markus Armbruster <armbru@redhat.com>; Zhijian Li (Fujitsu)
> > <lizhijian@fujitsu.com>; qemu-devel@nongnu.org; Yuval Shaia
> > <yuval.shaia.ml@gmail.com>; Kevin Wolf <kwolf@redhat.com>; Prasanna
> > Kumar Kalever <prasanna.kalever@redhat.com>; Cornelia Huck
> > <cohuck@redhat.com>; Michael Roth <michael.roth@amd.com>; Prasanna
> > Kumar Kalever <prasanna4324@gmail.com>; Paolo Bonzini
> > <pbonzini@redhat.com>; qemu-block@nongnu.org; devel@lists.libvirt.org;
> > Hanna Reitz <hreitz@redhat.com>; Michael S. Tsirkin <mst@redhat.com>;
> > Thomas Huth <thuth@redhat.com>; Eric Blake <eblake@redhat.com>; Song
> > Gao <gaosong@loongson.cn>; Marc-André Lureau
> > <marcandre.lureau@redhat.com>; Alex Bennée <alex.bennee@linaro.org>;
> > Wainer dos Santos Moschetta <wainersm@redhat.com>; Beraldo Leal
> > <bleal@redhat.com>; Pannengyuan <pannengyuan@huawei.com>;
> > Xiexiangyou <xiexiangyou@huawei.com>; Fabiano Rosas <farosas@suse.de>
> > Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
> > 
> > On Fri, May 17, 2024 at 03:01:59PM +0200, Yu Zhang wrote:
> > > Hello Michael and Peter,
> > 
> > Hi,
> > 
> > >
> > > Exactly, not so compelling, as I did it first only on servers widely
> > > used for production in our data center. The network adapters are
> > >
> > > Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme BCM5720
> > > 2-port Gigabit Ethernet PCIe
> > 
> > Hmm... I definitely thinks Jinpu's Mellanox ConnectX-6 looks more reasonable.
> > 
> > https://lore.kernel.org/qemu-devel/CAMGffEn-DKpMZ4tA71MJYdyemg0Zda15
> > wVAqk81vXtKzx-LfJQ@mail.gmail.com/
> > 
> > Appreciate a lot for everyone helping on the testings.
> > 
> > > InfiniBand controller: Mellanox Technologies MT27800 Family
> > > [ConnectX-5]
> > >
> > > which doesn't meet our purpose. I can choose RDMA or TCP for VM
> > > migration. RDMA traffic is through InfiniBand and TCP through Ethernet
> > > on these two hosts. One is standby while the other is active.
> > >
> > > Now I'll try on a server with more recent Ethernet and InfiniBand
> > > network adapters. One of them has:
> > > BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller (rev 01)
> > >
> > > The comparison between RDMA and TCP on the same NIC could make more
> > sense.
> > 
> > It looks to me NICs are powerful now, but again as I mentioned I don't think it's
> > a reason we need to deprecate rdma, especially if QEMU's rdma migration has
> > the chance to be refactored using rsocket.
> > 
> > Is there anyone who started looking into that direction?  Would it make sense
> > we start some PoC now?
> > 
> 
> My team has finished the PoC refactoring which works well. 
> 
> Progress:
> 1.  Implement io/channel-rdma.c,
> 2.  Add unit test tests/unit/test-io-channel-rdma.c and verifying it is successful,
> 3.  Remove the original code from migration/rdma.c,
> 4.  Rewrite the rdma_start_outgoing_migration and rdma_start_incoming_migration logic,
> 5.  Remove all rdma_xxx functions from migration/ram.c. (to prevent RDMA live migration from polluting the core logic of live migration),
> 6.  The soft-RoCE implemented by software is used to test the RDMA live migration. It's successful.
> 
> We will be submit the patchset later.

That's great news, thank you!

-- 
Peter Xu


