Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797B4C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZtX-0008NJ-TI; Tue, 04 Jun 2024 15:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sEZtV-0008Ml-IS
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:32:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sEZtS-0000vA-MO
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717529545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nn8VVvMg5S3LrLJ8kYp1BIeEBqdiypMdX4uLq+yvay8=;
 b=dumDalFbO3/mTTicyfpkBmO0VQEN36GWY3PYLGcVOIc1jxTHGEpxG8S/OtbLjC0b0FWI7U
 gZ0CY52aJvBEVYibQg8EkgatKZkImlox/pqpHcqx9BwwwvSPIV/4yxi8lxQgCfiJF98R3U
 A2s6eZQUKA1wF1vEUx4i5MXJT0/WsPc=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-PNnHJ_ZXMs-x0i6Lm-DLmQ-1; Tue, 04 Jun 2024 15:32:24 -0400
X-MC-Unique: PNnHJ_ZXMs-x0i6Lm-DLmQ-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5b970b125fcso1318063eaf.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717529543; x=1718134343;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nn8VVvMg5S3LrLJ8kYp1BIeEBqdiypMdX4uLq+yvay8=;
 b=YagQVhdTRXvEOvPY3O2BIPhUSmKE+aW3nAgcHKZrCcdpawavTIOZWMlS+UMuIKzECt
 /ZAHHUB2lEfFZDa9SZ4zbceqecCjhlIv4cTtb3Bo6g1tgsmnxUUUKrUG+1KLAN0OXczs
 0HS9GMNZZBxj5Ded6kAtze4tRhPq+ULjSWdVZ12rqVTd0qM4k3re1QnScRtb4jCmNbvG
 jDN9YPSLlpdKMWU/cfPVa251+5zdm+5B4wu6cXW/Hvvs3qkvenMPwO8alVWHWqWBtW5I
 C+o9KIKqNVsRuMQ0HfbaFPUfTxlMle0Ft0gUnjlqLU5LCNkx/tsCpdTx+s+w7VjMs6be
 OFNA==
X-Gm-Message-State: AOJu0Yw5Uzm2r2h/UuuaOvasOODFREgbSrMUNuDa3ULVCix21nNTpXuQ
 KmYbfXL9G8zdTKlmPqxzsR0DqfMGPWvJlgAcPEGumhNZ7Equ7Uspi/vlTaIXYnT/9zH6g98s7GE
 bwEbsNmNsKQfbIxZI0RsCs1gclzK8sYqZpLC+wBr37nPXNf0IkUXw
X-Received: by 2002:a05:6870:55ca:b0:24f:ee85:2c9e with SMTP id
 586e51a60fabf-251222b7943mr498800fac.5.1717529543058; 
 Tue, 04 Jun 2024 12:32:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1gB4iI0JHGmExhph7ALHiOFQaV0SHQGCAABO67v817/arMccef/BuXa4ll/7UITsy6Fjpzw==
X-Received: by 2002:a05:6870:55ca:b0:24f:ee85:2c9e with SMTP id
 586e51a60fabf-251222b7943mr498722fac.5.1717529542415; 
 Tue, 04 Jun 2024 12:32:22 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-795183f9dbesm74190685a.132.2024.06.04.12.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:32:21 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:32:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Gonglei <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org, yu.zhang@ionos.com, mgalaxy@akamai.com,
 elmar.gerdes@ionos.com, zhengchuan@huawei.com, berrange@redhat.com,
 armbru@redhat.com, lizhijian@fujitsu.com, pbonzini@redhat.com,
 mst@redhat.com, xiexiangyou@huawei.com, linux-rdma@vger.kernel.org,
 lixiao91@huawei.com, jinpu.wang@ionos.com,
 Jialin Wang <wangjialin23@huawei.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Message-ID: <Zl9rw3Q9Z9A0iMYV@x1n>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi, Lei, Jialin,

Thanks a lot for working on this!

I think we'll need to wait a bit on feedbacks from Jinpu and his team on
RDMA side, also Daniel for iochannels.  Also, please remember to copy
Fabiano Rosas in any relevant future posts.  We'd also like to know whether
he has any comments too.  I have him copied in this reply.

On Tue, Jun 04, 2024 at 08:14:06PM +0800, Gonglei wrote:
> From: Jialin Wang <wangjialin23@huawei.com>
> 
> Hi,
> 
> This patch series attempts to refactor RDMA live migration by
> introducing a new QIOChannelRDMA class based on the rsocket API.
> 
> The /usr/include/rdma/rsocket.h provides a higher level rsocket API
> that is a 1-1 match of the normal kernel 'sockets' API, which hides the
> detail of rdma protocol into rsocket and allows us to add support for
> some modern features like multifd more easily.
> 
> Here is the previous discussion on refactoring RDMA live migration using
> the rsocket API:
> 
> https://lore.kernel.org/qemu-devel/20240328130255.52257-1-philmd@linaro.org/
> 
> We have encountered some bugs when using rsocket and plan to submit them to
> the rdma-core community.
> 
> In addition, the use of rsocket makes our programming more convenient,
> but it must be noted that this method introduces multiple memory copies,
> which can be imagined that there will be a certain performance degradation,
> hoping that friends with RDMA network cards can help verify, thank you!

It'll be good to elaborate if you tested it in-house. What people should
expect on the numbers exactly?  Is that okay from Huawei's POV?

Besides that, the code looks pretty good at a first glance to me.  Before
others chim in, here're some high level comments..

Firstly, can we avoid using coroutine when listen()?  Might be relevant
when I see that rdma_accept_incoming_migration() runs in a loop to do
raccept(), but would that also hang the qemu main loop even with the
coroutine, before all channels are ready?  I'm not a coroutine person, but
I think the hope is that we can make dest QEMU run in a thread in the
future just like the src QEMU, so the less coroutine the better in this
path.

I think I also left a comment elsewhere on whether it would be possible to
allow iochannels implement their own poll() functions to avoid the
per-channel poll thread that is proposed in this series.

https://lore.kernel.org/r/ZldY21xVExtiMddB@x1n

Personally I think even with the thread proposal it's better than the old
rdma code, but I just still want to double check with you guys.  E.g.,
maybe that just won't work at all?  Again, that'll also be based on the
fact that we move migration incoming into a thread first to keep the dest
QEMU main loop intact, I think, but I hope we will reach that irrelevant of
rdma, IOW it'll be nice to happen even earlier if possible.

Another nitpick is that qio_channel_rdma_listen_async() doesn't look used
and may prone to removal.

Thanks,

-- 
Peter Xu


