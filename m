Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BACC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 13:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9lJu-00061Y-4E; Tue, 29 Apr 2025 09:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1u9lJo-000608-KV
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:48:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1u9lJl-0002Ia-TB
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745934491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mQCnz7nH2NBHwXyEMcPzFnTV157wqVq2fmiuHV8ef1c=;
 b=dMkw3oBT8+6a0pUV5+Vr3uyZrK8eTdkFRVdDIFaSadXmpUagfnzdyQmFg7wNIuVuOIiOnt
 yz3QzmysCQAivXhqYrvrgsqT57jZrj0FyHQMtCOQAVmxYSvZ1qzg7auMGVqAnVxuU8z9Hq
 tREJofIv2qzlK/+5f/8Q1fbQrB1mPSg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-adcprLFrMfqx0bqejxtQrg-1; Tue, 29 Apr 2025 09:48:03 -0400
X-MC-Unique: adcprLFrMfqx0bqejxtQrg-1
X-Mimecast-MFC-AGG-ID: adcprLFrMfqx0bqejxtQrg_1745934483
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6e8feea216aso120227096d6.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 06:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745934483; x=1746539283;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQCnz7nH2NBHwXyEMcPzFnTV157wqVq2fmiuHV8ef1c=;
 b=jJT7YGEWAcLK/qQw/O7rYL6NQ5l5U37uoy07aDW5HU5Nnk6kasOlcC+5eCQbJCbwDS
 stajUqb97uVbm1tjg9zjSC5aGZYeiJ81Rf2wfcjKTKiYXHIDml7WWWHZRY/aScN7usqE
 AgP/VUISx0492GuqM1LSVUGxAqrUqh4hXMOhhmcqLKaHvE8HNr1uMtvmr7wzv6WXEING
 ySBwH14xS8wbePPd2MBY5gjZPhZOhAQGOGRAWea3KwGsTZM9N5RUdii2srsG1F3SjwyM
 sxZx8uHKOqtic8b/liiR2IcUX9QPVBg04GDUXd+HH1PqWpZ67GQP6NuL7p8J+giKY49w
 hS0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyQaHkrCZN2mRInn76jK5pjJyrjSI272XfB3Ytor6RRTjwePWVAA4n1CZ6XzXMy3AH+ZIswe555Eys@nongnu.org
X-Gm-Message-State: AOJu0Yy3pMgnfUBwtyMVXODm9oPAUl6HhuzZhLqKrjxW1a8FI+dmk3UM
 lgsdeD8N4KaaN8MmwoakCc1ZJkwRHiQMe6tFIo1fh21SlJoz/MzWXO5MMQ2IFBxiplleh1+U55t
 JYL9CGT/8vmBhAnUXU0mHi0w6Jxj30u46Sv+NIyl5UgkAtLYhDhNu
X-Gm-Gg: ASbGnctxAJDwLAaVXhqbnuvoMBYxt+5q7/Ovp0ZcAAN2CKUAtPU1ScPeaEJB/M9zDUa
 IXeEm09YN/TA1NbAFdGC9jwhVWSteJQgZXlLExSEnnlW5o1Qec7nM8GmsLT6CBztIUACFU6+iOf
 exkwRizMTDj4EfbEMR1rW2mLm4S+gTSFhvNu0VzDt6MbD5+gooIqf8rJWlZBHqoFo7xBkse4r7Q
 /tM41uo2+ueeHxDBlSZScRfaBuZiWibaO3bHW/J1a2FIQMGy14SQuK2UbbrRsCvWOFQEzufs7UM
 JF4=
X-Received: by 2002:a05:622a:6090:b0:476:ae71:eabf with SMTP id
 d75a77b69052e-4885a1123bdmr52684201cf.21.1745934482820; 
 Tue, 29 Apr 2025 06:48:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2Xad4n6QAP6B+Ijwpjm+ltGAVvEGB/wBXlJZxEG2LkiBDM+1Kpx/mM1JNmg5aKcb+V1opDQ==
X-Received: by 2002:a05:622a:6090:b0:476:ae71:eabf with SMTP id
 d75a77b69052e-4885a1123bdmr52683881cf.21.1745934482485; 
 Tue, 29 Apr 2025 06:48:02 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47e9eaf264dsm80411381cf.10.2025.04.29.06.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:48:01 -0700 (PDT)
Date: Tue, 29 Apr 2025 09:47:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 berrange@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v9 0/7] Allow to enable multifd and postcopy migration
 together
Message-ID: <aBDYj3k83_W6ihlF@x1.local>
References: <20250411114534.3370816-1-ppandit@redhat.com>
 <87ecxteym0.fsf@suse.de> <87bjswfeis.fsf@suse.de>
 <CAE8KmOzzn7g1=pd2J325gAf4ffmGALKoHdgL17So4KawxkZdbg@mail.gmail.com>
 <87y0vyepta.fsf@suse.de> <aAlu0hcUCdzmIN4p@x1.local>
 <CAE8KmOz7P+Pz8zwJq+mTEJbZjhCk7iAo9+c5DrZzhbTmz=VtUQ@mail.gmail.com>
 <aBDObgL7hDQMy63F@x1.local>
 <CAE8KmOx9yuZWWHnaA6gkC2VpeimY1=Pw+AU9iDvQ+vVpUp_vKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOx9yuZWWHnaA6gkC2VpeimY1=Pw+AU9iDvQ+vVpUp_vKg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Apr 29, 2025 at 06:58:29PM +0530, Prasad Pandit wrote:
> On Tue, 29 Apr 2025 at 18:34, Peter Xu <peterx@redhat.com> wrote:
> > I think that's what Fabiano mentioned, but ultimately we need to verify it
> > on a reproducer to know.
> ...
> > Looks ok, but please add some comments explain why postcopy needs to do it,
> > and especially do it during precopy phase.
> >
> > I'd use migrate_postcopy_ram() instead.
> 
> * Okay. It should be '||' instead of '&&' in the first conditional I
> think, we want to write zeropage when postcopy is enabled.
> ===
> diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
> index dbc1184921..4d6677feab 100644
> --- a/migration/multifd-zero-page.c
> +++ b/migration/multifd-zero-page.c
> @@ -85,9 +85,11 @@ void multifd_recv_zero_page_process(MultiFDRecvParams *p)
>  {
>      for (int i = 0; i < p->zero_num; i++) {
>          void *page = p->host + p->zero[i];
> -        if (ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
> +        if (migrate_postcopy_ram() ||
> +            ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
>              memset(page, 0, multifd_ram_page_size());
> -        } else {
> +        }
> +        if (!ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
>              ramblock_recv_bitmap_set_offset(p->block, p->zero[i]);
>          }
>      }
> ===
> * I'll send this one if it looks okay.

Please don't rush to send. Again, let's verify the issue first before
resending anything.

If you could reproduce it it would be perfect, then we can already verify
it.  Otherwise we may need help from Fabiano.  Let's not send anything if
you're not yet sure whether it works..  It can confuse people thinking
problem solved, but maybe not yet.

-- 
Peter Xu


