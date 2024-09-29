Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19BECF6495
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 22:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sv2NQ-00047z-0e; Sun, 29 Sep 2024 18:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sv2NO-00047Q-Ci
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 18:26:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sv2NM-0005R0-Tx
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 18:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727648806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PemBl1hyIBKlSfrjKFuPjoBlVFbCeAta7QU5X0y5gt4=;
 b=Db1DCd81N1lDP3Q7EHg3sHZ7ztWDZwJfq4Xks9BQLPZ1SZkuBbwQJXGx9VlyhIeTVds0eS
 Dse6EJd+8KHFOydniHyEvT1FYJdiJS7m9hGksvDLtRFRFSWjNH0DHFq84QfKROT1fzwazq
 uy866W2X1ZmHueI9jx997Ka3Xetx290=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-Y1yjCGECOpmTR8MG1gFPWA-1; Sun, 29 Sep 2024 18:26:45 -0400
X-MC-Unique: Y1yjCGECOpmTR8MG1gFPWA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5c884ed9844so1978594a12.1
 for <qemu-devel@nongnu.org>; Sun, 29 Sep 2024 15:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727648804; x=1728253604;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PemBl1hyIBKlSfrjKFuPjoBlVFbCeAta7QU5X0y5gt4=;
 b=DS22QIq73RZP3ggrYqtQY+Gwd3AAG0WnWTtsKyq0akOsWBH+gKhOCbvoxf/Y3CVJrM
 w1pMDLLdg88B8LPnBV/4iAb1ndxfCtPeYwvvVmpbOkN+UD1SOuvUTgBScZrs2MBF3tnb
 bZLRb7pP7PR0p5r3i2Lu6874AVz+mpMnUKa1oST/K/fTjaA8Y/4RT2wZHw2C4IKQ9nQA
 X60RWUEBVsk+58LJdxP4HwvgCDxUt7ARXf9eHEwUyHL3sGBPwizkb3tCq5TqPxoPGCYs
 sRb0+rBTeixYq/tP+tEFY6ECXsjxAgGqjbTHzyoHH0IkKWvkOS0EaTNPR4w3w5hGXc9n
 ceyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlzM19Y5acdq4UeJ7SBeH5cwV6sfnUcNaS63sM6gqyciDDPsNgUTdmSmEQoMQA2+1pTkTCfjNAUZFa@nongnu.org
X-Gm-Message-State: AOJu0YwABRGZiMrqY5ilATXlROFmJXo4Y0t9p2biGCgQv2kYkaFYJj1b
 OWNQX0beY3PtXhg9R4DS4V4nx0yT45ySDqaS302lXWwQTdb2G3AY7CDAIzOzzQHxMlAr7p4A29G
 XPc2SvwtXtjDUPNVzwnUlABkGgmp1YNsrEwucpe/T25CRj/yatfvD
X-Received: by 2002:a17:907:3e1c:b0:a88:b93b:cdcb with SMTP id
 a640c23a62f3a-a93c4a68305mr937015566b.47.1727648804137; 
 Sun, 29 Sep 2024 15:26:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPK76RJL7fWhJqBZ4WIV0xqWHm/oTyDpoUm61pptCrw05Cci/N1M+eFd2v4vtuGKr3jSxwsw==
X-Received: by 2002:a17:907:3e1c:b0:a88:b93b:cdcb with SMTP id
 a640c23a62f3a-a93c4a68305mr937013966b.47.1727648803738; 
 Sun, 29 Sep 2024 15:26:43 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:822e:847c:4023:a734:1389])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c27c7130sm431617466b.67.2024.09.29.15.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 15:26:42 -0700 (PDT)
Date: Sun, 29 Sep 2024 18:26:37 -0400
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
Message-ID: <20240929182538-mutt-send-email-mst@kernel.org>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <Zs4z7tKWif6K4EbT@x1n>
 <20240827165643-mutt-send-email-mst@kernel.org>
 <027c4f24-f515-4fdb-8770-6bf2433e0f43@akamai.com>
 <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com>
 <ZvQnbzV9SlXKlarV@x1n>
 <DM6PR12MB431364C7A2D94609B4AAF9A8BD6B2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com>
 <20240929141323-mutt-send-email-mst@kernel.org>
 <46f8e54e-64a4-4d90-9b02-4fd699b54e41@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46f8e54e-64a4-4d90-9b02-4fd699b54e41@akamai.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Sun, Sep 29, 2024 at 03:26:58PM -0500, Michael Galaxy wrote:
> 
> On 9/29/24 13:14, Michael S. Tsirkin wrote:
> > !-------------------------------------------------------------------|
> >    This Message Is From an External Sender
> >    This message came from outside your organization.
> > |-------------------------------------------------------------------!
> > 
> > On Sat, Sep 28, 2024 at 12:52:08PM -0500, Michael Galaxy wrote:
> > > A bounce buffer defeats the entire purpose of using RDMA in these cases.
> > > When using RDMA for very large transfers like this, the goal here is to map
> > > the entire memory region at once and avoid all CPU interactions (except for
> > > message management within libibverbs) so that the NIC is doing all of the
> > > work.
> > > 
> > > I'm sure rsocket has its place with much smaller transfer sizes, but this is
> > > very different.
> > To clarify, are you actively using rdma based migration in production? Stepping up
> > to help maintain it?
> > 
> Yes, both Huawei and IONOS have both been contributing here in this email
> thread.
> 
> They are both using it in production.
> 
> - Michael

Well, any plans to work on it? for example, postcopy does not really
do zero copy last time I checked, there's also a long TODO list.

-- 
MST


