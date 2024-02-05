Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E3DC4829A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 04:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWqXy-0004TD-6V; Sun, 04 Feb 2024 23:25:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWqXw-0004Sq-BW
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 23:25:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWqXu-0004MZ-KN
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 23:25:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707107125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F/GBt6HbowGCQ8mb6YM1XyjmkYNYpPFiSLwUUxcdfKU=;
 b=bjfyBjIbaGCQm8GbhzrnarFV9dZ+5LPsx0Piu1GrWpTB55FiitHkVFvp5OqeMvdjjZhGsB
 LnDQlg48uBU42GoSppxw7CHMd3GFuJrSbPlBenYs4oIRupx0btlk0Ub+QXn502i/Q+ZH4t
 dI+oHs2OE+tXMUdJ4nVVOKGtew7wkxc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-MCrnQ-v1MkGZMqoLTy__hg-1; Sun, 04 Feb 2024 23:25:23 -0500
X-MC-Unique: MCrnQ-v1MkGZMqoLTy__hg-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1d97eb96869so633425ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 20:25:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707107123; x=1707711923;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F/GBt6HbowGCQ8mb6YM1XyjmkYNYpPFiSLwUUxcdfKU=;
 b=iTLY6TzZ7oiKB2IQR6yhOjWQiw0kt0QnPKwWgxB9E8IIUItLHMw2EAljqZcpd4fX7I
 vq/Kx+O8BMO6sKLh+oVls9oL3KwVOiRqtmbwNpG2oDVrbh4ZDa+FNQV/4Y+Vah4+8luq
 xWo8aMylVD975+xFk9GfGpO2S7asEL42F1MmWay7X5ac7ifU6pS0w6xzETjpgQA9feB5
 tia2akIpzU8BweH4sdZmruYqsrIBIm9PWuFfM4hne1TkOUeYcPWAvCD+dYQgSE2bTOCX
 sqWBrtSEHWrOEBAjZKFUQoyhV6tSVIKvdhYenbJCSbiGSWsqheUslmz7cNnHBVQXQw8/
 SNbA==
X-Gm-Message-State: AOJu0Ywox3DfHTb/PyjbaFY+QA/yd1YU+UQ9Uql+fJrVZatKTxW3LfiJ
 Gqmqbo5JiF6jI4lOyNDWQZsvSG5IfY2kSfykSxF+tNq8zaYExB9ANbHjH4b1L2VG1jRYjHXMbJy
 qs97cP6cUx1Yie5eDUQccgy3EToyEU/yFRnhj1M2r00vF1LBSftZS
X-Received: by 2002:a17:902:b190:b0:1d8:cc33:d7b4 with SMTP id
 s16-20020a170902b19000b001d8cc33d7b4mr16358841plr.5.1707107122886; 
 Sun, 04 Feb 2024 20:25:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2gYxjN5fMkvCeSjIBnoKi90/p1Bw/39S87MX88IqeuObMeqTPO7r+ZoqovBHOJ67Meww/jA==
X-Received: by 2002:a17:902:b190:b0:1d8:cc33:d7b4 with SMTP id
 s16-20020a170902b19000b001d8cc33d7b4mr16358828plr.5.1707107122518; 
 Sun, 04 Feb 2024 20:25:22 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXu6foVxTNjpdy6lfNmRsvsODGRfxuxt/u3/4/XadDFjTaVoR4dmx6E0lcMe11iEd0fGoiLj34XKsC+Ahq+2NZ6ntwfEHL+w97AsgNtikW8sHy2iUc56VF7TzD9HNlKqNxArFF35Pa9+ZwHUAzXGE9j6Th/vvwMJ4nOmhdG5oUdqEJ3jn6qYQh3YwUWxq7D8iVPwiH0ryf65+akcCWWg/A=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 v4-20020a170902b7c400b001d8b8bf8e44sm5269488plz.92.2024.02.04.20.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 20:25:22 -0800 (PST)
Date: Mon, 5 Feb 2024 12:25:13 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Hao Xiang <hao.xiang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>,
 Avihai Horon <avihaih@nvidia.com>, Yuan Liu <yuan1.liu@intel.com>,
 Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 19/23] migration/multifd: Cleanup multifd_save_cleanup()
Message-ID: <ZcBjKci16vW8I8CS@x1n>
References: <20240202102857.110210-1-peterx@redhat.com>
 <20240202102857.110210-20-peterx@redhat.com>
 <87a5oih9j4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a5oih9j4.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Feb 02, 2024 at 05:54:23PM -0300, Fabiano Rosas wrote:
> peterx@redhat.com writes:
> 
> > From: Peter Xu <peterx@redhat.com>
> >
> > Shrink the function by moving relevant works into helpers: move the thread
> > join()s into multifd_send_terminate_threads(), then create two more helpers
> > to cover channel/state cleanups.
> >
> > Add a TODO entry for the thread terminate process because p->running is
> > still buggy.  We need to fix it at some point but not yet covered.
> >
> > Suggested-by: Fabiano Rosas <farosas@suse.de>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> 
> minor comment below
> 
> > ---
> >  migration/multifd.c | 91 +++++++++++++++++++++++++++++----------------
> >  1 file changed, 59 insertions(+), 32 deletions(-)
> >
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index 4ab8e6eff2..4cb0d2cc17 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -593,6 +593,11 @@ static void multifd_send_terminate_threads(void)
> >       * always set it.
> >       */
> >      qatomic_set(&multifd_send_state->exiting, 1);
> > +
> > +    /*
> > +     * Firstly, kick all threads out; no matter whether they are just idle,
> > +     * or blocked in an IO system call.
> > +     */
> >      for (i = 0; i < migrate_multifd_channels(); i++) {
> >          MultiFDSendParams *p = &multifd_send_state->params[i];
> >  
> > @@ -601,6 +606,21 @@ static void multifd_send_terminate_threads(void)
> >              qio_channel_shutdown(p->c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
> >          }
> >      }
> > +
> > +    /*
> > +     * Finally recycle all the threads.
> > +     *
> > +     * TODO: p->running is still buggy, e.g. we can reach here without the
> > +     * corresponding multifd_new_send_channel_async() get invoked yet,
> > +     * then a new thread can even be created after this function returns.
> > +     */
> 
> Series on the list:
> 
> https://lore.kernel.org/r/20240202191128.1901-1-farosas@suse.de

Thanks a lot.  I'll read it later today.

> 
> > +    for (i = 0; i < migrate_multifd_channels(); i++) {
> > +        MultiFDSendParams *p = &multifd_send_state->params[i];
> > +
> > +        if (p->running) {
> > +            qemu_thread_join(&p->thread);
> > +        }
> > +    }
> >  }
> >  
> >  static int multifd_send_channel_destroy(QIOChannel *send)
> > @@ -608,6 +628,41 @@ static int multifd_send_channel_destroy(QIOChannel *send)
> >      return socket_send_channel_destroy(send);
> >  }
> >  
> > +static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
> > +{
> > +    if (p->registered_yank) {
> > +        migration_ioc_unregister_yank(p->c);
> > +    }
> > +    multifd_send_channel_destroy(p->c);
> > +    p->c = NULL;
> > +    qemu_mutex_destroy(&p->mutex);
> > +    qemu_sem_destroy(&p->sem);
> > +    qemu_sem_destroy(&p->sem_sync);
> > +    g_free(p->name);
> > +    p->name = NULL;
> > +    multifd_pages_clear(p->pages);
> > +    p->pages = NULL;
> > +    p->packet_len = 0;
> > +    g_free(p->packet);
> > +    p->packet = NULL;
> > +    g_free(p->iov);
> > +    p->iov = NULL;
> > +    multifd_send_state->ops->send_cleanup(p, errp);
> > +
> > +    return *errp == NULL;
> 
> I think technically this would require the ERRP_GUARD() macro?

I normally only use ERRP_GUARD() if there can be any caller passing in
NULL, or when I am not sure it's always !NULL.

What I wanted to add here is actually assert(errp), but then I noticed
*errp==NULL plays the same role as that, because if errp==NULL, it'll crash
here when dereferencing, so it actually has an implicit assert(errp);
exactly what I wanted, but even one line less (even if not obvious).

-- 
Peter Xu


