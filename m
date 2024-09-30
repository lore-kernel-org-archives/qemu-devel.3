Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028ADCE8379
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 18:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svKwd-00074t-Gb; Mon, 30 Sep 2024 14:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svKwb-00074M-F9
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 14:16:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svKwZ-0000vG-Hf
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 14:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727720179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g70UrLqfz9ieslzzgOkmz08fHuxDPadkSXeHrQ+so08=;
 b=bRBvp+V54Zo1YV1A5caXh98dphMZWZS4z/5UXwOiX9xjzr+qDKMbTf5IKwxHUiMeGqwdod
 AQi9+XagXsRcAi3SNsp7RfGFz8Wd5tUsJ6TivgmhWn5llz2CukAzXkcZAAUBGNSlWMXkcs
 YJx9RLHdJ0P0Yik+niL8V1GJ2pD1Cb4=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-2Z0mu0YANBivSvIcO-h-wQ-1; Mon, 30 Sep 2024 14:16:18 -0400
X-MC-Unique: 2Z0mu0YANBivSvIcO-h-wQ-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5e1cd853298so3561397eaf.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 11:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727720178; x=1728324978;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g70UrLqfz9ieslzzgOkmz08fHuxDPadkSXeHrQ+so08=;
 b=W+PBnRbcIr/qba3wZcAIvd6hDtwhuOtUGXukSUqSWWGZzU2mUjpTyUwobW38MfwYWL
 9xe9kqoTNdjTmr6Lln0GOdt9NZSEif3Zd8c6K4Q9lZJyGhWgTVmru1pNytN73Bp9XdNH
 LWVc9ZkDMFRNEar8d9DZdxEi00bWQWUvLU+ccousw2qA23q9BtzqZ0U68O2TsoOpzQYm
 mAGwrbGs37qRbL84Ky2eFt77VmFEFPv6b8v5zzdaR2S/8sYFYmZaDaDcs2MgxgxtQMoW
 1IE/W9574cSjjxK9aKEoe3YZTTEQ8w2vBPdoeZ/vUI0ul1FowAje2RcxMZFxKZTdZKVm
 6YAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU22oPLbT/eMF1LX5GgM6Ddzlma8Pvbjy+eLaLc4QZWA64j9eAMJVm9G1zHuVrcqz/Fmo6Jszt1V2Td@nongnu.org
X-Gm-Message-State: AOJu0YyIZhXJDyrEVbzEZ4O0EG6Zq0/aup6NDWtN1n//EWJ8MMeFjFe/
 /xImszhkvmvASZ6m8zXOL7hYmPBhBL6zEjGxXufzTQNcElMz933TqNxh7VasP01pZb2WKST815Y
 vgeKbgoDH94cn7QEonSPAEUMFEAcpmXfj+m+2pcnasBTHwCoQq4KM
X-Received: by 2002:a05:6358:60c7:b0:1b8:2cf8:cf5 with SMTP id
 e5c5f4694b2df-1becbc261f9mr781334555d.3.1727720177729; 
 Mon, 30 Sep 2024 11:16:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBfqZzsABhgfZIZhmer2c2B5PqhU2BpdrwLqd2GTt5QuL/pH5CbvBqdiobgzrukVOd5H6UBw==
X-Received: by 2002:a05:6358:60c7:b0:1b8:2cf8:cf5 with SMTP id
 e5c5f4694b2df-1becbc261f9mr781330455d.3.1727720177390; 
 Mon, 30 Sep 2024 11:16:17 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b67f23csm41656496d6.108.2024.09.30.11.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 11:16:16 -0700 (PDT)
Date: Mon, 30 Sep 2024 14:16:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Galaxy <mgalaxy@akamai.com>
Cc: Sean Hefty <shefty@nvidia.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yu.zhang@ionos.com" <yu.zhang@ionos.com>,
 "elmar.gerdes@ionos.com" <elmar.gerdes@ionos.com>,
 zhengchuan <zhengchuan@huawei.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Xiexiangyou <xiexiangyou@huawei.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "lixiao (H)" <lixiao91@huawei.com>,
 "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
 Wangjialin <wangjialin23@huawei.com>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Message-ID: <Zvrq7nSbiLfPQoIY@x1n>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <Zs4z7tKWif6K4EbT@x1n>
 <20240827165643-mutt-send-email-mst@kernel.org>
 <027c4f24-f515-4fdb-8770-6bf2433e0f43@akamai.com>
 <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com>
 <ZvQnbzV9SlXKlarV@x1n>
 <DM6PR12MB431364C7A2D94609B4AAF9A8BD6B2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Sep 28, 2024 at 12:52:08PM -0500, Michael Galaxy wrote:
> On 9/27/24 16:45, Sean Hefty wrote:
> > !-------------------------------------------------------------------|
> >    This Message Is From an External Sender
> >    This message came from outside your organization.
> > |-------------------------------------------------------------------!
> > 
> > > > > I have met with the team from IONOS about their testing on actual IB
> > > > > hardware here at KVM Forum today and the requirements are starting
> > > > > to make more sense to me. I didn't say much in our previous thread
> > > > > because I misunderstood the requirements, so let me try to explain
> > > > > and see if we're all on the same page. There appears to be a
> > > > > fundamental limitation here with rsocket, for which I don't see how it is
> > > possible to overcome.
> > > > > The basic problem is that rsocket is trying to present a stream
> > > > > abstraction, a concept that is fundamentally incompatible with RDMA.
> > > > > The whole point of using RDMA in the first place is to avoid using
> > > > > the CPU, and to do that, all of the memory (potentially hundreds of
> > > > > gigabytes) need to be registered with the hardware *in advance* (this is
> > > how the original implementation works).
> > > > > The need to fake a socket/bytestream abstraction eventually breaks
> > > > > down => There is a limit (a few GB) in rsocket (which the IONOS team
> > > > > previous reported in testing.... see that email), it appears that
> > > > > means that rsocket is only going to be able to map a certain limited
> > > > > amount of memory with the hardware until its internal "buffer" runs
> > > > > out before it can then unmap and remap the next batch of memory with
> > > > > the hardware to continue along with the fake bytestream. This is
> > > > > very much sticking a square peg in a round hole. If you were to
> > > > > "relax" the rsocket implementation to register the entire VM memory
> > > > > space (as my original implementation does), then there wouldn't be any
> > > need for rsocket in the first place.
> > > 
> > > Yes, some test like this can be helpful.
> > > 
> > > And thanks for the summary.  That's definitely helpful.
> > > 
> > > One question from my side (as someone knows nothing on RDMA/rsocket): is
> > > that "a few GBs" limitation a software guard?  Would it be possible that rsocket
> > > provide some option to allow user opt-in on setting that value, so that it might
> > > work for VM use case?  Would that consume similar resources v.s. the current
> > > QEMU impl but allows it to use rsockets with no perf regressions?
> > Rsockets is emulated the streaming socket API.  The amount of memory dedicated to a single rsocket is controlled through a wmem_default configuration setting.  It is also configurable via rsetsockopt() SO_SNDBUF.  Both of those are similar to TCP settings.  The SW field used to store this value is 32-bits.
> > 
> > This internal buffer acts as a bounce buffer to convert the synchronous socket API calls into the asynchronous RDMA transfers.  Rsockets uses the CPU for data copies, but the transport is offloaded to the NIC, including kernel bypass.
> Understood.
> > Does your kernel allocate > 4 GBs of buffer space to an individual socket?
> Yes, it absolutely does. We're dealing with virtual machines here, right? It
> is possible (and likely) to have a virtual machine that is hundreds of GBs
> of RAM in size.
> 
> A bounce buffer defeats the entire purpose of using RDMA in these cases.
> When using RDMA for very large transfers like this, the goal here is to map
> the entire memory region at once and avoid all CPU interactions (except for
> message management within libibverbs) so that the NIC is doing all of the
> work.
> 
> I'm sure rsocket has its place with much smaller transfer sizes, but this is
> very different.

Is it possible to make rsocket be friendly with large buffers (>4GB) like
the VM use case?

I also wonder whether there're other applications that may benefit from
this outside of QEMU.

Thanks,

-- 
Peter Xu


