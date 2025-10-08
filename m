Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A11CCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 20:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6aza-0005jj-PS; Wed, 08 Oct 2025 16:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v6azX-0005jM-Qp
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 16:42:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v6azO-0003nU-Dj
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 16:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759956135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HOnqdWE3bmL7yTna9fDdRtYGTaDxR2OcsFG4/qQNrQM=;
 b=PwgH95z6tvIsNmiHKvbaNAQA1HrJvmf/3ZAQiUB+ggAiFfMZOUh38dUNm7IKSMVvMjOOsr
 3/ZZevNa1RL/amHN2sYge589Y/5oCXtjlLQS6pHsVXEwQ2i24xqWvEkXzhTP62FANg/K8q
 AWRBenJ2+MhreF/Knx/5CJDZIE7fkxE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-shhg2qlEOyi0X-240_pBaw-1; Wed, 08 Oct 2025 16:42:14 -0400
X-MC-Unique: shhg2qlEOyi0X-240_pBaw-1
X-Mimecast-MFC-AGG-ID: shhg2qlEOyi0X-240_pBaw_1759956134
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4df7cdf22cbso54330041cf.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 13:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759956134; x=1760560934;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HOnqdWE3bmL7yTna9fDdRtYGTaDxR2OcsFG4/qQNrQM=;
 b=uPJbTsb2sfi/VsWfaHuLrfHvwChVn5OF4CMqa+FfIRaie+gY4QFmgV1yOtetE3cCLn
 aQSZIJQ9j8FY6D7EjCOJxO0e03iDCzOySumbo2feN3Gk0ULsNY6MeWLIr7p2Ncou8T8x
 6gDzK5y6swY0rDcgfeLR9fuNysvveiPqAmDJxdEM2PZC4phjH2EZ4+Zuy+tNtiREPz1v
 8dNObYkVzeM073MyUiDZl7Gp+0vqxWDiGNa0Jf7alQGYbvV5NrKgNVwCh7MSEqm1jgKm
 RwQL48lKro14u+EXgdcq7HmnC+XxXDg4y0PMC7jWRURO1OK79C4Ac0Q4DsYIA+be3q4a
 31kQ==
X-Gm-Message-State: AOJu0YwMW4G7nkhvGcL/SZLJ/5l4j7wmTAcF/+GkYOGc6wuqJno6p0Gr
 UXvcLvqSN8p6IBT5ITDn+Fq5PPnqIbvuS48SDWpfKVxca3wBB3/z1ft/3SNeaZlNleMkIDsVzYb
 Lt/btt/TP/BPI726Y4//AGYqWkNeuQosN9ES+/WYvuqoha+UR8dWQD6oZ
X-Gm-Gg: ASbGnctAIcxIDMshxLMQ7hGJbsnuki8qkmFswG04rfY1mO6l8wE0dGHJh9ysNnuSsgG
 fr+UhT7fxmWwFJXL+qQLAxOdnFn1HCn18NZNRGH504duVAPjC1HY0iFct7vK2DmF59UHWd8Vwe7
 Ylz8XiLM8QTY7n3va03YetlFUjGPrVTHmcx+22C8OI2ArCYjQdDaNrxTJiMcoO4neY8YfhMAS0v
 T0Qaizp9SqEPbVkPU3omvYjgnkfNqB29urlBVFoBBiAPeIhFiFw/CfBFyQLujn44HgTk/k60AWU
 UDADwG3D2CskrFGAgDQmU6UuBw1DZHATBD9Z6A==
X-Received: by 2002:a05:622a:1e8a:b0:4c3:9b8c:ab30 with SMTP id
 d75a77b69052e-4e6eafb29e4mr76154311cf.6.1759956133950; 
 Wed, 08 Oct 2025 13:42:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQTNjDCdBWtj1IKgve64yDunzeCveuxRq+PQZHdQSntR7c/KmUs1uo042IwTzvrWBmKRmSlw==
X-Received: by 2002:a05:622a:1e8a:b0:4c3:9b8c:ab30 with SMTP id
 d75a77b69052e-4e6eafb29e4mr76153901cf.6.1759956133487; 
 Wed, 08 Oct 2025 13:42:13 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e6e7c88cb2sm32839941cf.26.2025.10.08.13.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 13:42:12 -0700 (PDT)
Date: Wed, 8 Oct 2025 16:42:11 -0400
From: Peter Xu <peterx@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Prasad Pandit <ppandit@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC 4/9] migration/rdma: Change io_create_watch() to
 return immediately
Message-ID: <aObMoyblRullLbSK@x1.local>
References: <20250827205949.364606-1-peterx@redhat.com>
 <20250827205949.364606-5-peterx@redhat.com>
 <a29ebbe7-008d-4d96-a2c4-825378055a28@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a29ebbe7-008d-4d96-a2c4-825378055a28@fujitsu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 26, 2025 at 02:39:43AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 28/08/2025 04:59, Peter Xu wrote:
> > The old RDMA's io_create_watch() isn't really doing much work anyway.  For
> > G_IO_OUT, it already does return immediately.  For G_IO_IN, it will try to
> > detect some RDMA context length however normally nobody will be able to set
> > it at all.
> > 
> 
> 
> First, RDMA migration works well with this patch applied.
> 
> Tested-by: Li Zhijian <lizhijian@fujitsu.com>

Thanks a lot, Zhijian.

> 
> 
> I have a small question. While testing, I didn't observe any callers to
> qio_channel_rdma_create_watch() during a complete RDMA migration using
> the default capabilities and parameters.
> I was wondering in which case this function is expected to be called?
> (I see io_create_watch() is mandatory for QIOChannelClass)

Yes, that's also my observation.  See my reply to Fabiano on the same patch
for some information.

A summary of what I said there but more focused to what you're asking: IIUC
currently we almost always rely on qemu_rdma_wait_comp_channel() to poll
the two rdma fds, and yield if necessary when in a coroutine.

IOW, I don't know when qio_channel_rdma_create_watch(), or in most cases,
qio_channel_wait(), will be used at all.  I had a feeling that if it's used
it might stuck forever (as the gsource will be monitoring control_len, see
below [1], while IIUC only the thread itself can update it, or am I
wrong?).  But I'm not fluent with the RDMA codebase.  Maybe you'll have a
better picture after seeing what I said here and there.

This patch is almost something I want to guarantee it won't happen, hence
for whatever could return QIO_CHANNEL_ERR_BLOCK for rdma channels I want to
make sure it immediately retries instead of hanging forever in the temp
main loop of qio_channel_wait().

> 
> 
> Thanks
> Zhijian
> 
> 
> > Simplify the code so that RDMA iochannels simply always rely on synchronous
> > reads and writes.  It is highly likely what 6ddd2d76ca6f86f was talking
> > about, that the async model isn't really working well.
> > 
> > This helps because this is almost the only dependency that the migration
> > core would need a coroutine for rdma channels.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   migration/rdma.c | 69 +++---------------------------------------------
> >   1 file changed, 3 insertions(+), 66 deletions(-)
> > 
> > diff --git a/migration/rdma.c b/migration/rdma.c
> > index ed4e20b988..bcd7aae2f2 100644
> > --- a/migration/rdma.c
> > +++ b/migration/rdma.c
> > @@ -2789,56 +2789,14 @@ static gboolean
> >   qio_channel_rdma_source_prepare(GSource *source,
> >                                   gint *timeout)
> >   {
> > -    QIOChannelRDMASource *rsource = (QIOChannelRDMASource *)source;
> > -    RDMAContext *rdma;
> > -    GIOCondition cond = 0;
> >       *timeout = -1;
> > -
> > -    RCU_READ_LOCK_GUARD();
> > -    if (rsource->condition == G_IO_IN) {
> > -        rdma = qatomic_rcu_read(&rsource->rioc->rdmain);
> > -    } else {
> > -        rdma = qatomic_rcu_read(&rsource->rioc->rdmaout);
> > -    }
> > -
> > -    if (!rdma) {
> > -        error_report("RDMAContext is NULL when prepare Gsource");
> > -        return FALSE;
> > -    }
> > -
> > -    if (rdma->wr_data[0].control_len) {
> > -        cond |= G_IO_IN;
> > -    }
> > -    cond |= G_IO_OUT;
> > -
> > -    return cond & rsource->condition;
> > +    return TRUE;
> >   }
> >   
> >   static gboolean
> >   qio_channel_rdma_source_check(GSource *source)
> >   {
> > -    QIOChannelRDMASource *rsource = (QIOChannelRDMASource *)source;
> > -    RDMAContext *rdma;
> > -    GIOCondition cond = 0;
> > -
> > -    RCU_READ_LOCK_GUARD();
> > -    if (rsource->condition == G_IO_IN) {
> > -        rdma = qatomic_rcu_read(&rsource->rioc->rdmain);
> > -    } else {
> > -        rdma = qatomic_rcu_read(&rsource->rioc->rdmaout);
> > -    }
> > -
> > -    if (!rdma) {
> > -        error_report("RDMAContext is NULL when check Gsource");
> > -        return FALSE;
> > -    }
> > -
> > -    if (rdma->wr_data[0].control_len) {

[1]

> > -        cond |= G_IO_IN;
> > -    }
> > -    cond |= G_IO_OUT;
> > -
> > -    return cond & rsource->condition;
> > +    return TRUE;
> >   }
> >   
> >   static gboolean
> > @@ -2848,29 +2806,8 @@ qio_channel_rdma_source_dispatch(GSource *source,
> >   {
> >       QIOChannelFunc func = (QIOChannelFunc)callback;
> >       QIOChannelRDMASource *rsource = (QIOChannelRDMASource *)source;
> > -    RDMAContext *rdma;
> > -    GIOCondition cond = 0;
> > -
> > -    RCU_READ_LOCK_GUARD();
> > -    if (rsource->condition == G_IO_IN) {
> > -        rdma = qatomic_rcu_read(&rsource->rioc->rdmain);
> > -    } else {
> > -        rdma = qatomic_rcu_read(&rsource->rioc->rdmaout);
> > -    }
> > -
> > -    if (!rdma) {
> > -        error_report("RDMAContext is NULL when dispatch Gsource");
> > -        return FALSE;
> > -    }
> > -
> > -    if (rdma->wr_data[0].control_len) {
> > -        cond |= G_IO_IN;
> > -    }
> > -    cond |= G_IO_OUT;
> >   
> > -    return (*func)(QIO_CHANNEL(rsource->rioc),
> > -                   (cond & rsource->condition),
> > -                   user_data);
> > +    return (*func)(QIO_CHANNEL(rsource->rioc), rsource->condition, user_data);
> >   }
> >   
> >   static void

-- 
Peter Xu


