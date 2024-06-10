Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F11C27C5F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 16:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGhvb-0001sP-1D; Mon, 10 Jun 2024 12:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sGhvQ-0001pJ-Oe
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 12:31:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sGhvO-0007sk-H5
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 12:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718037073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kEPnFYShNOfW6Go38hlXjO2BpMJrNG7XS+knedTSyz4=;
 b=Xd+x/5oBbco1SDUXhxeN37KgifC9urqk9tp+Kta3oIZl+l3OOFo4Pn63oMX3qvXZjLZhQr
 Y7KyotkSCZiOEzlU2ldMn1xktsq0WgjtGOdGjVd1NTd+viCe94TZFmmgfGUSa6ZVUU6iLE
 CVSMKKesLCYrNyqS3/Uovtw7tJDMIgM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-eOyKlrFrNV2MQcfNhO3bmA-1; Mon, 10 Jun 2024 12:31:11 -0400
X-MC-Unique: eOyKlrFrNV2MQcfNhO3bmA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6b07a472e83so3821226d6.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 09:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718037071; x=1718641871;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kEPnFYShNOfW6Go38hlXjO2BpMJrNG7XS+knedTSyz4=;
 b=dYXJ4ZjRTV6MW9h5F6rwPVOApixPufeYMjcu74sSaP7mrBr8NbFkGJS+Gm4eBFNsjH
 FDZ4py4s46tQ1u1VwLmEHyveJIV897w6ykpps7ALbWrTn+apFZ79cbBspN8lrrmAtJde
 Jc+q7jNspl1TixvEOy1YE/4ilHJNeRu94DZ0tIk3brbyhfV2f6yxKhIcmtS0V061kXcQ
 KD+5Epk32VrLSRTu0dvlO4Um/txP+1DiLTQ1z1ojohsj9iVhovnmLRcq5xsY+MmHFnez
 X2mFEQJCZ06yIOPJUbVVOeggRCAfQa3SZoH1mz5xg/UPJK8IfcZN8qTrC1x4m20GP3y6
 veeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6D0heOTTxegYpHpZR9zvo7b31IJb/JGsR6CzBx7oJcqaCkpfoKd3nygtzYVJ4VVOmyWnpxg0w49Sm+2faopU5b7Is/oU=
X-Gm-Message-State: AOJu0YwYQx8OcEE90x3XoA3wVA9zklUFgl29fWIyZB5DzmCL6Ihlbdh/
 UoL5jdiQly/sqwx0aiVT0Z3zPQjP6s9ISPdh0O0AXO0k7uqfCShx+hHFjp1uX4rrKy6i60pf+e4
 ht5l5ez3s7H0T1Anef2vCoH1NzQWNzPX7wL38sWHA8tLZd6KBg8hX
X-Received: by 2002:a05:6214:23cc:b0:6a0:cd65:599a with SMTP id
 6a1803df08f44-6b059b73fcdmr112353226d6.2.1718037070987; 
 Mon, 10 Jun 2024 09:31:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdLxSknR+8WIYDrIdq1gqx5Ivt0FX6ldjE5iVrk2Qw9zbpwv6gfEMzL2vLXatF+5AN68cnHA==
X-Received: by 2002:a05:6214:23cc:b0:6a0:cd65:599a with SMTP id
 6a1803df08f44-6b059b73fcdmr112352916d6.2.1718037070341; 
 Mon, 10 Jun 2024 09:31:10 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b080015e39sm9518236d6.31.2024.06.10.09.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 09:31:08 -0700 (PDT)
Date: Mon, 10 Jun 2024 12:31:05 -0400
From: Peter Xu <peterx@redhat.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Jinpu Wang <jinpu.wang@ionos.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yu.zhang@ionos.com" <yu.zhang@ionos.com>,
 "mgalaxy@akamai.com" <mgalaxy@akamai.com>,
 "elmar.gerdes@ionos.com" <elmar.gerdes@ionos.com>,
 zhengchuan <zhengchuan@huawei.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, Xiexiangyou <xiexiangyou@huawei.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "lixiao (H)" <lixiao91@huawei.com>, Wangjialin <wangjialin23@huawei.com>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Message-ID: <ZmcqSai3rU4KuEnO@x1n>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <CAMGffEkUd2EOS3+PQ9Yfp=8V1pZB_emo7gcmxmvOX=iWVG6Axg@mail.gmail.com>
 <b637ce3cac16409c83a3391b05011eec@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b637ce3cac16409c83a3391b05011eec@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Jun 07, 2024 at 08:28:29AM +0000, Gonglei (Arei) wrote:
> 
> 
> > -----Original Message-----
> > From: Jinpu Wang [mailto:jinpu.wang@ionos.com]
> > Sent: Friday, June 7, 2024 1:54 PM
> > To: Gonglei (Arei) <arei.gonglei@huawei.com>
> > Cc: qemu-devel@nongnu.org; peterx@redhat.com; yu.zhang@ionos.com;
> > mgalaxy@akamai.com; elmar.gerdes@ionos.com; zhengchuan
> > <zhengchuan@huawei.com>; berrange@redhat.com; armbru@redhat.com;
> > lizhijian@fujitsu.com; pbonzini@redhat.com; mst@redhat.com; Xiexiangyou
> > <xiexiangyou@huawei.com>; linux-rdma@vger.kernel.org; lixiao (H)
> > <lixiao91@huawei.com>; Wangjialin <wangjialin23@huawei.com>
> > Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
> > 
> > Hi Gonglei, hi folks on the list,
> > 
> > On Tue, Jun 4, 2024 at 2:14 PM Gonglei <arei.gonglei@huawei.com> wrote:
> > >
> > > From: Jialin Wang <wangjialin23@huawei.com>
> > >
> > > Hi,
> > >
> > > This patch series attempts to refactor RDMA live migration by
> > > introducing a new QIOChannelRDMA class based on the rsocket API.
> > >
> > > The /usr/include/rdma/rsocket.h provides a higher level rsocket API
> > > that is a 1-1 match of the normal kernel 'sockets' API, which hides
> > > the detail of rdma protocol into rsocket and allows us to add support
> > > for some modern features like multifd more easily.
> > >
> > > Here is the previous discussion on refactoring RDMA live migration
> > > using the rsocket API:
> > >
> > > https://lore.kernel.org/qemu-devel/20240328130255.52257-1-philmd@linar
> > > o.org/
> > >
> > > We have encountered some bugs when using rsocket and plan to submit
> > > them to the rdma-core community.
> > >
> > > In addition, the use of rsocket makes our programming more convenient,
> > > but it must be noted that this method introduces multiple memory
> > > copies, which can be imagined that there will be a certain performance
> > > degradation, hoping that friends with RDMA network cards can help verify,
> > thank you!
> > First thx for the effort, we are running migration tests on our IB fabric, different
> > generation of HCA from mellanox, the migration works ok, there are a few
> > failures,  Yu will share the result later separately.
> > 
> 
> Thank you so much. 
> 
> > The one blocker for the change is the old implementation and the new rsocket
> > implementation; they don't talk to each other due to the effect of different wire
> > protocol during connection establishment.
> > eg the old RDMA migration has special control message during the migration
> > flow, which rsocket use a different control message, so there lead to no way to
> > migrate VM using rdma transport pre to the rsocket patchset to a new version
> > with rsocket implementation.
> > 
> > Probably we should keep both implementation for a while, mark the old
> > implementation as deprecated, and promote the new implementation, and
> > high light in doc, they are not compatible.
> > 
> 
> IMO It makes sense. What's your opinion? @Peter.

Sounds good to me.  We can use an internal property field and enable
rsocket rdma migration on new machine types with rdma protocol, deprecating
both old rdma and that internal field after 2 releases.  So that when
receiving rdma migrations it'll use old property (as old qemu will use old
machine types), but when initiating rdma migration on new binary it'll
switch to rsocket.

It might be more important to address either the failures or perf concerns
that others raised, though.

Thanks,

-- 
Peter Xu


