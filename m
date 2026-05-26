Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8E2CD5BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 22:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS0Za-0004Ap-Aa; Tue, 26 May 2026 18:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wS0ZY-0004AK-Rb
 for qemu-devel@nongnu.org; Tue, 26 May 2026 18:48:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wS0ZW-0007CK-6G
 for qemu-devel@nongnu.org; Tue, 26 May 2026 18:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779835704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gBmZ8GaKhZik2UYG+VH5gSYV5iKZ+tSgFbEI0NhZJek=;
 b=Rq5eqT4e+LMths1l3aG7cijK4olI7bvtmviIsYyLXLA3Mv+mGJ0J03p43S+sG31SY3cFd4
 96ZhqArkBePjhKRo9c1+Xc55K5YZ1jldTWOhG71Ee2KkpQEx1EsWYnjTa7GQ7kmVm11W2F
 7qig4gGYJ2D5gmhOm6h6+n/qhvZ6EGk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-5rHQTjA4Nx-ljBLDhXAo3g-1; Tue, 26 May 2026 18:48:22 -0400
X-MC-Unique: 5rHQTjA4Nx-ljBLDhXAo3g-1
X-Mimecast-MFC-AGG-ID: 5rHQTjA4Nx-ljBLDhXAo3g_1779835702
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-516eaf9fb76so63154731cf.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 15:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779835702; x=1780440502; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gBmZ8GaKhZik2UYG+VH5gSYV5iKZ+tSgFbEI0NhZJek=;
 b=NvFd52xdbyhPfDd1vTZANERD6OsGmKHHEWzyltQkcn/+AuxROBKd5ljblYPqchDwJy
 PbK26EW7utgsufUtW2I3sjeFpLfCtc6ExVoo5dFRbPa14f9NxscMJahITZpwcgJj6ReD
 E3eFeZYacNJRZ7ijCTKVMzUBhanuuupCbntLZ1XyZjrdjQhmkw7M+y2Xtx858ZHqRsvI
 0vbUQspGI6jcZzWhF89TgpCdGei2VBbq4grpgQXs7K3KreBgVvEgabNNiFSUsbbORWJi
 I6I+RJbBJZg/DLFlfLz+zVoN3Qycu8krof+4EkB1EO0gh3+kNu5E31KxbCzBucSnn4py
 ramg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779835702; x=1780440502;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gBmZ8GaKhZik2UYG+VH5gSYV5iKZ+tSgFbEI0NhZJek=;
 b=o8MhPI8Bl/MY95QKc4OMGABgKkzCg/HnYm19Bd/bq8dEfx1cwTJiSfqsDu5seJrnTE
 OqV9DHylvbIZHJypUiXyOiHRwHFWTEmfF1105yCFVbF/ZTsrQwqqdszg6NhDsvGMGVSf
 CdaPg7CiZESCC2PuyJnCgT5KChbq2gCpP8uWczUHD4MqxzHxbvfy3ckBE7rkIa1OVtKb
 0GMecB7LH2V5SZqgmxALG80jzLArWb+z3h4BcJyBGa2LCfm19A0jWqCVQiBxPzkGS4QC
 W40/Fp9thhPKd2e8Obs3ALVAhmHaetbrccjvZJM682kTJgNOkDAyY3V0NDfUtPNA14oO
 ASCw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+d7vzx+u53PQ4m2L8SL1gcq92c64aytAgJ/9A/Rn4Z5VAmIRsOxdTMXIDf2OniTLsSQwBvJ3Au04O6@nongnu.org
X-Gm-Message-State: AOJu0YwJHRq2HGNG7JwNnW6LD6iGrTFl09xJbyBFiNnQefl6KQ2CYq4l
 mU9Y1t8p1GR3KbqAD5cRhzLGrDyXBav6BA2tZv9sgKiSBtPgoaE9hbT9hvYYQX3JOGoUNZzpBw5
 LYPYS3QdEbJg3VnwiDHPpfuwcgDnN4ZSMRRRxR7EAOcHTco2nTM8816fZ
X-Gm-Gg: Acq92OG5wOg+qUUk/RSagMQ0bNh5SDf8k8qRu2k9sCN2DqiwA9dTSSMPu+v2+r7Y2X9
 KLMk2JQ5Bpf1trKttppe4mBpf9yo97gvxn0luwESZxu6Meztq2T/xbxedr2q9PEzjxyTh6Q/w+y
 S69Zzbb5hitwvBkTvACPTFJzpPRT5+cQxtn/787SGlV4RWACGXe8z7/lNuCQaqtILYKY4qhHHmD
 8IT4yTqD+ff19g43Fqs5EnP5WlJG177yM4fpz8+D0Hf47QN3hK0W7ki/dvW2jAuC0jPM+yqMWux
 RwZjq/6vr0ED3JmAgNv7tm/z+JR5LFHLuHy0Xulpr/p7xojQQiBxxMNBajFKuuOXahPKGwqgNLo
 zx+wGFjDNAXDIWVyydNP+QLGwkjdUOMU4wILLaMOgEBKpapI=
X-Received: by 2002:a05:622a:5143:b0:50e:defb:9dca with SMTP id
 d75a77b69052e-516d467c294mr290499861cf.45.1779835701844; 
 Tue, 26 May 2026 15:48:21 -0700 (PDT)
X-Received: by 2002:a05:622a:5143:b0:50e:defb:9dca with SMTP id
 d75a77b69052e-516d467c294mr290499491cf.45.1779835701301; 
 Tue, 26 May 2026 15:48:21 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5170b691d15sm18103401cf.11.2026.05.26.15.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 15:48:20 -0700 (PDT)
Date: Tue, 26 May 2026 18:48:19 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH] thread-pool: Allow at least 1 thread in
 thread_pool_adjust_max_threads_to_work()
Message-ID: <ahYjM4IO1bpgHk-0@x1.local>
References: <b76c763f576b0fb8a35960a8e3c3da59701d2a74.1779390317.git.maciej.szmigiero@oracle.com>
 <ahYDnlAUJ8x1bipq@x1.local>
 <f729ff7f-971c-4e00-88fe-61ded891b9be@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f729ff7f-971c-4e00-88fe-61ded891b9be@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, May 26, 2026 at 11:06:58PM +0200, Maciej S. Szmigiero wrote:
> On 26.05.2026 22:33, Peter Xu wrote:
> > On Thu, May 21, 2026 at 09:06:07PM +0200, Maciej S. Szmigiero wrote:
> > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > 
> > > thread_pool_adjust_max_threads_to_work() is supposed to give each task its
> > > own thread by setting the pool max thread count limit accordingly.
> > > 
> > > However, if there aren't any tasks currently in the pool the pool max
> > > thread count will be set to 0, which will trigger an assertion failure
> > > in thread_pool_set_max_threads() - because setting this value would
> > > completely block the pool by not allowing it to process any submitted
> > > tasks.
> > > 
> > > This also can happen if a task is submitted via
> > > thread_pool_submit_immediate() to an empty pool but the task completes so
> > > quickly that by the time this function calls
> > > thread_pool_adjust_max_threads_to_work() the pool again has no unfinished
> > > tasks in it.
> > 
> > Sorry for a late comment. Just curious: how easy is this to reproduce?
> 
> It's difficult to reproduce in most setups.
> 
> My main VFIO live migration setup never hit it for more than a year, other
> similar setup hit it recently 3 times.
> 
> On the other hand, putting sleep(5) in the middle of
> thread_pool_submit_immediate() makes it reproduce nearly always for me.

Thanks, I'll attach this info to the patch when queuing.

> 
> > > 
> > > Fix this by making sure that the pool is allowed to create at least 1
> > > thread.
> > 
> > But then it means we have no work and then we will create one thread does
> > nothing..
> 
> thread_pool_adjust_max_threads_to_work() is currently called only from
> thread_pool_submit_immediate().
> 
> If the API user truly wants no threads in the pool for time being
> (even though this will completely block the pool) they can use
> thread_pool_submit() to submit their task(s).
> This won't call thread_pool_adjust_max_threads_to_work() by itself.
> 
> Also, since the thread pool is created with zero initial threads by
> default the patch does *not* mean that the each newly created pool
> will have one idle thread now.

This is another small problem.  I think the ideal case is we create threads
before hand, not on-demand here.  It should be faster. I don't know how
much, maybe it's not measurable, but IIUC that's one good thing about
exclusive thread pool that we didn't really leverage.

I think the system on both sides should know exactly how many threads we
need, hence they can create them before downtime starts.  During the
process, we shouldn't need to adjust num of threads, also avoid the bug
like this.  But I'll leave that to you to decide if it's worthwhile.

> 
> > 
> > I suspect the real culprit is we released the cur_work_lock during the
> > whole process of thread_pool_submit_immediate().  If we take it during the
> > whole window this will be a no-issue too.
> 
> True, however this will need splitting both thread_pool_submit() and
> thread_pool_adjust_max_threads_to_work() into two versions each: one
> which takes pool->cur_work_lock, another which does not and then
> take pool->cur_work_lock on their behalf in thread_pool_submit_immediate().
> 
> Not to mention this would also mean putting the whole g_thread_pool_push()
> -> g_thread_pool_start_thread() machinery under pool->cur_work_lock in this
> case instead of just pool->cur_work increment.
> 
> I think doing this such way would add unnecessary complexity considering
> that its alternative of this patch is a single-line trivial change.
> 
> > The other question is, if it is awkward to manually adjust num of threads,
> > shall we set num to be -1 (unlimited) while pool created?
> 
> We can't - Glib thread pool API does not allow unlimited exclusive pools.

If we don't care about pre-init of thread pools, I'm actually not sure if
we need exclusive pool at all.. maybe it'll still help, to e.g. inherit
scheduler setup of migration thread.

But it's ok anyway, I'll queue this patch for now.

Thanks,

-- 
Peter Xu


