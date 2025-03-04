Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EFCC282D2
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 14:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpTMn-0005aw-4G; Tue, 04 Mar 2025 09:35:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tpTMj-0005ZN-Cj
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 09:35:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tpTMg-0001Ax-5x
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 09:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741098918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1MNGAJ7UzKxHTmZF4u8ge6AlyfFgB3ZGC0mIW7ZoIrU=;
 b=QpaKogHORUgxkAvUIRCR9EQIi3rQrsUgNN7EhOEK/n9AZCpUwe3Ce2SR+FVliPLJedEL5x
 6/d/xHBuVsKryeWZ5WFG+DTBkK581vraL36GxOISSuIsl4GA/ZOQJJl+1Atp/QzZk0xzfN
 ekCO19tm3//QyjUuMYpel+i8b3UeWZE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-7_T8VAdqPPekQDZ2oc7A-g-1; Tue, 04 Mar 2025 09:35:16 -0500
X-MC-Unique: 7_T8VAdqPPekQDZ2oc7A-g-1
X-Mimecast-MFC-AGG-ID: 7_T8VAdqPPekQDZ2oc7A-g_1741098916
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6e8ab341f0eso106399236d6.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 06:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741098916; x=1741703716;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1MNGAJ7UzKxHTmZF4u8ge6AlyfFgB3ZGC0mIW7ZoIrU=;
 b=shGfVTnUJpjkkcfAU5mgKtOzeGoADBR2+d7GWVNKSmaLXernYyd048vKMMITAA6SNh
 Jm/avnj64QO3OFds5WSyUlJi22lIRsgLl3YhRpKFi0w+s5W2wxC7fVTUhc0hDuN4L4bG
 cbXYpp3wjZrr7MurwxnrJOfzKPKTs2BKSc53DsqDPWqWnJNf69FOY+A22lWbXVxIR0Dp
 UD7K+xbBWtmwbc/Dhsrscb4yeLQUNqwsjG+IiYj6+YbU1NnpO5nnkUGeDMmZWaTEkXUC
 HKCLNWnomQSMXCrOcbWurmqEzC7B0/j7foIDDBBP96gVC3/r9AfMMBEz/z6+L2hQx2fw
 PhCw==
X-Gm-Message-State: AOJu0YxsF/2DhLjD/QUby3YS9V1o82/Ht8hMe8rfFXzXQC1VKvjHMj7l
 QSKJ9zN01aaNkDEw7Lk96xZ+zvYS7nU2Tryqjex8B1EUU7Ekz72R6xga16ITboZMfTbqbgQkWaE
 tw3kC6x7oWPFoMh+XrZu0gF779Uqn127nXDgvHcaFplz3IitoziD1
X-Gm-Gg: ASbGncuxXAL6P99O42y5qg1XBtBYgE34ytVd5stYW/psQT8QcIiw7Ui2QslUKRIwps8
 axBCR1BLk9P9eK3zOJjNxJ6FuiUCxncJ2/UThYLMJi5K5NJei2wnX04V1xbLr5wAZv3iHkzqo3i
 wi7a/lPk/fbVGj8MjvgnMoX3xZ+N1HwC7WdKFnoC7qhhniilBW2l/RhebLZ47gNMjz6AdNMglW0
 cdSsl6Cpee62Ib6wVQrlLZNR5SpO2qb8vmIxT68WBjsNoCSDWjNHCUJp/oxJuercPjxSBnHkKuu
 bCd7WfM=
X-Received: by 2002:ad4:5c66:0:b0:6e8:9535:b00 with SMTP id
 6a1803df08f44-6e8a0cbfaedmr259666746d6.12.1741098915809; 
 Tue, 04 Mar 2025 06:35:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOjhjecLnBAcVeXPYdkqIxqB0KJ7usZrm5/LqWYkW0P5s5FC6MYuXjo7C7fk+ETJXkTqA+JQ==
X-Received: by 2002:ad4:5c66:0:b0:6e8:9535:b00 with SMTP id
 6a1803df08f44-6e8a0cbfaedmr259666396d6.12.1741098915483; 
 Tue, 04 Mar 2025 06:35:15 -0800 (PST)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8976da260sm66989906d6.106.2025.03.04.06.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 06:35:14 -0800 (PST)
Date: Tue, 4 Mar 2025 09:35:11 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v7 5/5] migration: add MULTIFD_RECV_SYNC migration command
Message-ID: <Z8cPnxqOvp1hFpx8@x1.local>
References: <20250228121749.553184-1-ppandit@redhat.com>
 <20250228121749.553184-6-ppandit@redhat.com>
 <Z8G9Wj3DWSgdLkNQ@x1.local>
 <CAE8KmOxenqyqOxEFozgP1gBZPtneEqcbop9F_f+VW3ukPfw37A@mail.gmail.com>
 <Z8XBowkG72G-l3L4@x1.local>
 <CAE8KmOyssf_2RYBw2LLpxP2Z5bmtyU==Qs+4HWp=mOVb9o82-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOyssf_2RYBw2LLpxP2Z5bmtyU==Qs+4HWp=mOVb9o82-g@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Mar 04, 2025 at 01:40:02PM +0530, Prasad Pandit wrote:
> Hello Peter,
> 
> On Mon, 3 Mar 2025 at 20:20, Peter Xu <peterx@redhat.com> wrote:
> > We need the header.
> 
> * We need a section type, which is sent by qemu_savevm_command_send()
> as 'QEMU_VM_COMMAND'.

I think we need the header, the ram is a module.

> 
> >  Maybe the easiest as of now is one more hook like
> > qemu_savevm_state_complete_precopy_prepare(), and only use it in RAM as of
> > now.
> 
> * What will this helper do?

Do similarly like qemu_savevm_state_complete_precopy_iterable() but do
whatever a vmstate hander wants, so it'll be with a header.

> 
> > > * But earlier we discussed 'flush and sync' is enough for that, no?
> >
> > Yes it's ok I think, but this patch didn't do that.
> >
> > +            multifd_send_flush();
> > +            multifd_send_sync_main(MULTIFD_SYNC_LOCAL);
> > +            qemu_savevm_send_multifd_recv_sync(s->to_dst_file);
> >
> > I don't think it sent RAM_SAVE_FLAG_MULTIFD_FLUSH.  IIUC you need the
> > complete multifd_ram_flush_and_sync(), and the new message not needed.
> 
> * If we look at multifd_ram_flush_and_sync(), it does:
>      1. multifd_send()                       <= this patch does it via
> multifd_send_flush()
>      2. multifd_send_sync_main()    <= this patch also calls it above

MULTIFD_SYNC_LOCAL will not invoke MULTIFD_FLAG_SYNC, which we need.

>      3. send RAM_SAVE_FLAG_MULTIFD_FLUSH  <= this patch sends
> MIG_CMD_MULTIFD_RECV_SYNC

IMO we shouldn't make a global cmd for multifd.

> 
> * What is missing?
> 
> > Instead of I prepare the patch and whole commit message, please take your
> > time and think about it, justify it, and if you also think it works put
> > explanation into commit message and then we can go with it.
> 
> * The commit message does explain about flush and sync and how the
> migration command helps. What else do we need to add?

Please consider adding details like "we need message AAA on BBB channel to
serialize with CCC" and details.  Not asking that as required to merge, but
my understanding is that that's what is missing and that's why none of yet
versions can make sure of it in code.  Maybe that'll help you to understand
how that was serialized.

> 
> > > * And multifd_recv_sync_main() function on the destination blocks the
> > > 'main' thread until all multfd_recv_threads (mig/dst/recv_x) have
> > > exited, only then it proceeds to accept the incoming new postcopy
> > > connection.
> >
> > I don't think it makes sure threads have exited,
> 
> * 'multifd_recv_sync_main()' blocks the main thread on
> 'multifd_recv_state->sem_sync' semaphore. It is increased when
> multifd_recv threads exit due to the shutdown message. ie. the 'main'
> thread unblocks when all 'mig/dst/recv_x' threads have exited.

So is it your intention to not send MULTIFD_FLAG_SYNC above?

In all cases, I still think that's not the right way to do.

Thanks,

-- 
Peter Xu


