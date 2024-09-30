Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACEACDD1D6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 19:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svMN6-00067u-Am; Mon, 30 Sep 2024 15:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svMN2-0005tw-Sa
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:47:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svMN0-0002XN-ET
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727725664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=prGBeKA86QLhKRADp0eTX+tNoVAx4dt5Wv+6p9pM42E=;
 b=NH8kGqgCtsWbuosUU8KmkFsdUPbQ4Bsbqtfl18wbJC/SMp1oyI5TFrx+KozIBOkKf++ef+
 g1pxoG0xU3VPG+FYWCaCosCNnmxhYdMDwEaotTf4A1PtuZ3srKfECTKJKrCk/ih697oI7g
 030i7EAoMMQyvVITNPoqtz64+JpvtDs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-0muyMiVIND2ZQ07kw1VHUQ-1; Mon, 30 Sep 2024 15:47:41 -0400
X-MC-Unique: 0muyMiVIND2ZQ07kw1VHUQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7ac8d3dbe5bso550499785a.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 12:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727725660; x=1728330460;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=prGBeKA86QLhKRADp0eTX+tNoVAx4dt5Wv+6p9pM42E=;
 b=YP4RvIee0S4Aa6EOsBN8xHDr932Axzlmi/s1IVe6UAK6u0bc0G+PDulhwzdKJtZx7S
 Ck2gRYKVDvcuWk96Qj+tR9l1mrAYSqgsMMD4XDS91ZG0X78jCLMhlBy9BoTOcTV2OyjS
 oDkeoDX6DIU6Y5y3prYEwvnuteT6NvkVinBZPMZhYm7lgwXiROQlaq+PtOP18LUR0I7I
 DhMMVynLpqoAguL4RULy+oQVtpWPKGgOWMgVXWNdO9Dtp6A108R1ty07fpHBtGfiR54M
 e0gOQmUYBL2ofr8n5qDnlIjy3eX+h2br7jpql5zlUewVZh5TcEjGbyjbJvdmhNu0mX4z
 FpCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvsgSM8mv9KIVhpmniNyFqk03M/ArZ22fFtZ4dy5yHFj/0G7IJ5gy7xkbWzFAqMM561GxkVQQYVjeC@nongnu.org
X-Gm-Message-State: AOJu0YzKVnF/rl8HNXerr2efmXS9tlU4gZgmxDJnJoG/TXdh+BjEe6Bd
 W3Q1438yu2JBie3LKYMs9VgxJJcOwy4kQmLjhHAdJH6g6+Vh9jSb2THydlHZ9WyLIaIDzbMXjKA
 PXOdbbLORrUZWh2KhKSPsx3+C+rlG2dl75KBuFQlEYkrYch7N6YwpCG+It7hB
X-Received: by 2002:a05:620a:450c:b0:7a9:b04a:b324 with SMTP id
 af79cd13be357-7ae378ddb4cmr1930912585a.64.1727725659757; 
 Mon, 30 Sep 2024 12:47:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX81kf1iR/0lZtJ1lFzJzUc0+892Dm3hNPAy43+5BBqc4BJnAj900bLjAI/dH3V8YZuNyxIg==
X-Received: by 2002:a05:620a:450c:b0:7a9:b04a:b324 with SMTP id
 af79cd13be357-7ae378ddb4cmr1930908785a.64.1727725659234; 
 Mon, 30 Sep 2024 12:47:39 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae377d8a68sm441384785a.37.2024.09.30.12.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 12:47:38 -0700 (PDT)
Date: Mon, 30 Sep 2024 15:47:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Sean Hefty <shefty@nvidia.com>
Cc: Michael Galaxy <mgalaxy@akamai.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
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
Message-ID: <ZvsAV0MugV85HuZf@x1n>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <Zs4z7tKWif6K4EbT@x1n>
 <20240827165643-mutt-send-email-mst@kernel.org>
 <027c4f24-f515-4fdb-8770-6bf2433e0f43@akamai.com>
 <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com>
 <ZvQnbzV9SlXKlarV@x1n>
 <DM6PR12MB431364C7A2D94609B4AAF9A8BD6B2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com>
 <Zvrq7nSbiLfPQoIY@x1n>
 <DM6PR12MB4313D6BA256740DE1ACA29E9BD762@DM6PR12MB4313.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM6PR12MB4313D6BA256740DE1ACA29E9BD762@DM6PR12MB4313.namprd12.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Mon, Sep 30, 2024 at 07:20:56PM +0000, Sean Hefty wrote:
> > > I'm sure rsocket has its place with much smaller transfer sizes, but
> > > this is very different.
> > 
> > Is it possible to make rsocket be friendly with large buffers (>4GB) like the VM
> > use case?
> 
> If you can perform large VM migrations using streaming sockets, rsockets is likely usable, but it will involve data copies.  The problem is the socket API semantics.
> 
> There are rsocket API extensions (riowrite, riomap) to support RDMA write operations.  This avoids the data copy at the target, but not the sender.   (riowrite follows the socket send semantics on buffer ownership.)
> 
> It may be possible to enhance rsockets with MSG_ZEROCOPY or io_uring extensions to enable zero-copy for large transfers, but that's not something I've looked at.  True zero copy may require combining MSG_ZEROCOPY with riowrite, but then that moves further away from using traditional socket calls.

Thanks, Sean.

One thing to mention is that QEMU has QIO_CHANNEL_WRITE_FLAG_ZERO_COPY,
which already supports MSG_ZEROCOPY but only on sender side, and only if
when multifd is enabled, because it requires page pinning and alignments,
while it's more challenging to pin a random buffer than a guest page.

Nobody moved on yet with zerocopy recv for TCP; there might be similar
challenges that normal socket APIs may not work easily on top of current
iochannel design, but I don't know well to say..

Not sure whether it means there can be a shared goal with QEMU ultimately
supporting better zerocopy via either TCP or RDMA.  If that's true, maybe
there's chance we can move towards rsocket with all the above facilities,
meanwhile RDMA can, ideally, run similiarly like TCP with the same (to be
enhanced..) iochannel API, so that it can do zerocopy on both sides with
either transport.

-- 
Peter Xu


