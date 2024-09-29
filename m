Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAEECF6495
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 18:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suyR8-0007xJ-2R; Sun, 29 Sep 2024 14:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1suyR6-0007w6-1r
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 14:14:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1suyR4-0000lh-Ow
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 14:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727633661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w7MT4iAPcSuYS0WNQDhSnN5OL6KGtI0jtO/g+U2dGa4=;
 b=FNek92bl6VAt2ozp9s4Zl8ydieuF0NWuiaRTPdY+9oP5lbrjIlGyhm5KSY+3XLQohRDZCa
 s7mBx9AfFJbw3HDfzdq6byISSTwIloEQte8brHLPWm/pg+vG8B4LJZVzGLHDUod1slUIdw
 LoNgNxtCmW6ul7VNUDDK5cimchnNhW0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-UcMnG6oBPBuez4fj7RAPsQ-1; Sun, 29 Sep 2024 14:14:19 -0400
X-MC-Unique: UcMnG6oBPBuez4fj7RAPsQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5c883ccaf4cso1316309a12.3
 for <qemu-devel@nongnu.org>; Sun, 29 Sep 2024 11:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727633658; x=1728238458;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7MT4iAPcSuYS0WNQDhSnN5OL6KGtI0jtO/g+U2dGa4=;
 b=PnRf9NMUJtw/nZDWoQrgW5RhPbs4Ps8yn2MbNlSP8qWITQsvcLMimC864nZZkikTJr
 GBg8s6LZIhE+EYKyVVSr3W33E66GiXJYVRu21qKkzWg1dI93GnLRQsWr22c4ZfHMpY8e
 AGrocUFAqKCx7H0raF9YKjHt2Toz+KRNTTG+/3jV0FJUCwCcLitFvH+ee2464/2uzdu+
 Dpmw5vCv+w6ohPRxDXvCXngEuaIPg52vrjkoYbdu6YEYOfEy26VjbsVi12wTjIKeCNP9
 cp1QEL04/I8YKThJBtXO7atXIeWr4vJq4//U6i78cmF3Vtd/lT1Fvqh8vzjAMyt9ZRhq
 6qxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbsHTdhvLr5wQ4hkLM12Kb7pDeBU52EvijIviW21L/PdpJ22ar24jFyERJsv6Y4eQmHGKUaUeuCBcs@nongnu.org
X-Gm-Message-State: AOJu0YzV4qEB2OicLXBgM9+6SG7x4xj0VbJEM6+uGQOAItejB2wltQ8A
 jafuSj3dgV2tsjdCqUgBENppICa5nr1Cdb9tVGXzDjBqp5EAZaiqLwCVH4TaXftedcpF8Jt5yqz
 ivJylcqbLDv92G9PVlDfNhMyXoeb4VDJexubGLckoSHHd9i+YXb9J
X-Received: by 2002:a05:6402:42c2:b0:5c5:da5e:68e with SMTP id
 4fb4d7f45d1cf-5c8824cd05fmr16304826a12.3.1727633658305; 
 Sun, 29 Sep 2024 11:14:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsBCMaav1yffVzptAr2TDEl7+U/4t+yG7PheIxWQ0FtDlMqAlga+SPFy9Hc18UupZRNnhYkg==
X-Received: by 2002:a05:6402:42c2:b0:5c5:da5e:68e with SMTP id
 4fb4d7f45d1cf-5c8824cd05fmr16304783a12.3.1727633657918; 
 Sun, 29 Sep 2024 11:14:17 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:822e:847c:4023:a734:1389])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c2978beesm417265966b.147.2024.09.29.11.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 11:14:17 -0700 (PDT)
Date: Sun, 29 Sep 2024 14:14:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Galaxy <mgalaxy@akamai.com>
Cc: Sean Hefty <shefty@nvidia.com>, Peter Xu <peterx@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
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
Message-ID: <20240929141323-mutt-send-email-mst@kernel.org>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <Zs4z7tKWif6K4EbT@x1n>
 <20240827165643-mutt-send-email-mst@kernel.org>
 <027c4f24-f515-4fdb-8770-6bf2433e0f43@akamai.com>
 <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com>
 <ZvQnbzV9SlXKlarV@x1n>
 <DM6PR12MB431364C7A2D94609B4AAF9A8BD6B2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
> A bounce buffer defeats the entire purpose of using RDMA in these cases.
> When using RDMA for very large transfers like this, the goal here is to map
> the entire memory region at once and avoid all CPU interactions (except for
> message management within libibverbs) so that the NIC is doing all of the
> work.
> 
> I'm sure rsocket has its place with much smaller transfer sizes, but this is
> very different.

To clarify, are you actively using rdma based migration in production? Stepping up
to help maintain it?

-- 
MST


